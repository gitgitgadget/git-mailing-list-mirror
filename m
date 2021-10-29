Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C32C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 00:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA64260F38
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 00:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhJ2ASU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 20:18:20 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:52268 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230227AbhJ2ASU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 20:18:20 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 96F241F953;
        Fri, 29 Oct 2021 00:15:52 +0000 (UTC)
Date:   Fri, 29 Oct 2021 00:15:52 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] tests: disable fsync everywhere
Message-ID: <20211029001552.GA29647@dcvr>
References: <20211028002102.19384-1-e@80x24.org>
 <YXq1g4Zwfq8gJEoC@coredump.intra.peff.net>
 <20211028182824.GA1307@dcvr>
 <xmqqilxhq774.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqilxhq774.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> >> > This will also be useful for 3rd-party tools which create
> >> > throwaway git repositories of temporary data.
> >> 
> >> Do you mostly just care about the tests, or is the third-party tool
> >> support important to you? I ask because most of us switched to running
> >> the tests with --root=/some/tmpfs long ago to achieve the same speedup.
> >
> > Third-party tools and OSes which don't have a tmpfs mounted by
> > default (I don't think most *BSDs have tmpfs enabled by
> > default).

> > I'm also strongly considering making GIT_FSYNC=0 the default for
> > our own test suite since it's less setup for newbies.
> 
> If the primary focus is for testing, perhaps GIT_TEST_FSYNC would be
> better?  I do not think we want to even advertise an option for not
> syncing at all for end users working with any real repositories.
> Not even when they promise that the end user accepts all the
> responsibility and will keep both halves when things got broken.

I think having an undocumented GIT_TEST_FSYNC is a good
compromise and saves us the support burden.

Fwiw, I do currently have a 3rd-party tool which creates
throwaway repos, but the throwaways are currently small enough
that objects stay loose.  They might get bigger and pack in
in the future.

Relying on an LD_PRELOAD-based solution such as eatmydata
doesn't work for staticly-linked systems, and can conflict
with other LD_PRELOAD-based tools one might use(*)

v2 changes:
* s/GIT_FSYNC/GIT_TEST_FSYNC/
* disable fsync by default for tests, reduces setup for newcomers
* fix style nit noted by Eric Sunshine

--------------8<------------
Subject: [PATCH] tests: disable fsync everywhere

The "GIT_TEST_FSYNC" environment variable now exists for
disabling fsync() even on packfiles and other "critical" data.

Running "make test -j8 NO_SVN_TESTS=1" on a noisy 8-core system
on an HDD, test runtime drops from ~4 minutes down to ~3 minutes.
Using "GIT_TEST_FSYNC=1" re-enables fsync() for comparison
purposes.

SVN interopability tests are minimally affected since SVN will
still use fsync in various places.

This will also be useful for 3rd-party tools which create
throwaway git repositories of temporary data, but remains
undocumented for end users.

Signed-off-by: Eric Wong <e@80x24.org>
---
 cache.h            |  1 +
 environment.c      |  1 +
 git-cvsserver.perl | 19 +++++++++++++++++++
 perl/Git/SVN.pm    | 17 +++++++++++++++--
 t/test-lib.sh      |  7 +++++++
 write-or-die.c     |  5 +++++
 6 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index eba12487b9..de6c45cf44 100644
--- a/cache.h
+++ b/cache.h
@@ -986,6 +986,7 @@ extern int read_replace_refs;
 extern char *git_replace_ref_base;
 
 extern int fsync_object_files;
+extern int use_fsync;
 extern int core_preload_index;
 extern int precomposed_unicode;
 extern int protect_hfs;
diff --git a/environment.c b/environment.c
index 9da7f3c1a1..0d06a31024 100644
--- a/environment.c
+++ b/environment.c
@@ -42,6 +42,7 @@ const char *git_hooks_path;
 int zlib_compression_level = Z_BEST_SPEED;
 int pack_compression_level = Z_DEFAULT_COMPRESSION;
 int fsync_object_files;
+int use_fsync = -1;
 size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit = 96 * 1024 * 1024;
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 64319bed43..4c8118010a 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -3607,6 +3607,22 @@ package GITCVS::updater;
 use strict;
 use warnings;
 use DBI;
+our $_use_fsync;
+
+# n.b. consider using Git.pm
+sub use_fsync {
+    if (!defined($_use_fsync)) {
+        my $x = $ENV{GIT_TEST_FSYNC};
+        if (defined $x) {
+            local $ENV{GIT_CONFIG};
+            delete $ENV{GIT_CONFIG};
+            my $v = ::safe_pipe_capture('git', '-c', "test.fsync=$x",
+                                        qw(config --type=bool test.fsync));
+            $_use_fsync = defined($v) ? ($v eq "true\n") : 1;
+        }
+    }
+    $_use_fsync;
+}
 
 =head1 METHODS
 
@@ -3676,6 +3692,9 @@ sub new
                                 $self->{dbuser},
                                 $self->{dbpass});
     die "Error connecting to database\n" unless defined $self->{dbh};
+    if ($self->{dbdriver} eq 'SQLite' && !use_fsync()) {
+        $self->{dbh}->do('PRAGMA synchronous = OFF');
+    }
 
     $self->{tables} = {};
     foreach my $table ( keys %{$self->{dbh}->table_info(undef,undef,undef,'TABLE')->fetchall_hashref('TABLE_NAME')} )
diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 35ff5a6896..df5a87a151 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -6,7 +6,7 @@ package Git::SVN;
 use vars qw/$_no_metadata
             $_repack $_repack_flags $_use_svm_props $_head
             $_use_svnsync_props $no_reuse_existing
-	    $_use_log_author $_add_author_from $_localtime/;
+	    $_use_log_author $_add_author_from $_localtime $_use_fsync/;
 use Carp qw/croak/;
 use File::Path qw/mkpath/;
 use IPC::Open3;
@@ -2269,6 +2269,19 @@ sub mkfile {
 	}
 }
 
+# TODO: move this to Git.pm?
+sub use_fsync {
+	if (!defined($_use_fsync)) {
+		my $x = $ENV{GIT_TEST_FSYNC};
+		if (defined $x) {
+			my $v = command_oneline('git', '-c', "test.fsync=$x",
+					qw(config --type=bool test.fsync));
+			$_use_fsync = defined($v) ? ($v eq "true\n") : 1;
+		}
+	}
+	$_use_fsync;
+}
+
 sub rev_map_set {
 	my ($self, $rev, $commit, $update_ref, $uuid) = @_;
 	defined $commit or die "missing arg3\n";
@@ -2290,7 +2303,7 @@ sub rev_map_set {
 	my $sync;
 	# both of these options make our .rev_db file very, very important
 	# and we can't afford to lose it because rebuild() won't work
-	if ($self->use_svm_props || $self->no_metadata) {
+	if (($self->use_svm_props || $self->no_metadata) && use_fsync()) {
 		require File::Copy;
 		$sync = 1;
 		File::Copy::copy($db, $db_lock) or die "rev_map_set(@_): ",
diff --git a/t/test-lib.sh b/t/test-lib.sh
index a291a5d4a2..21f5fab999 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -489,6 +489,13 @@ then
 	export GIT_PERL_FATAL_WARNINGS
 fi
 
+case $GIT_TEST_FSYNC in
+'')
+	GIT_TEST_FSYNC=0
+	export GIT_TEST_FSYNC
+	;;
+esac
+
 # Add libc MALLOC and MALLOC_PERTURB test
 # only if we are not executing the test with valgrind
 if test -n "$valgrind" ||
diff --git a/write-or-die.c b/write-or-die.c
index 0b1ec8190b..a3d5784cec 100644
--- a/write-or-die.c
+++ b/write-or-die.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "run-command.h"
 
 /*
@@ -57,6 +58,10 @@ void fprintf_or_die(FILE *f, const char *fmt, ...)
 
 void fsync_or_die(int fd, const char *msg)
 {
+	if (use_fsync < 0)
+		use_fsync = git_env_bool("GIT_TEST_FSYNC", 1);
+	if (!use_fsync)
+		return;
 	while (fsync(fd) < 0) {
 		if (errno != EINTR)
 			die_errno("fsync error on '%s'", msg);
-- 

(*) I happen to be working on an LD_PRELOAD-based malloc tracer
    for Perl which may help us cut memory use in git-svn;
    but interposing malloc/free gets tricky...
