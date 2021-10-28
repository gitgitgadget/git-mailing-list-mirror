Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF1EC433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 00:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 332E960F9B
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 00:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbhJ1AX3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 20:23:29 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33372 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229437AbhJ1AX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 20:23:28 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id B6F2D1F953
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 00:21:02 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Subject: [PATCH] allow disabling fsync everywhere
Date:   Thu, 28 Oct 2021 00:21:02 +0000
Message-Id: <20211028002102.19384-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"core.fsync" and the "GIT_FSYNC" environment variable now exist
for disabling fsync() even on packfiles and other critical data.

Running "make test -j8 NO_SVN_TESTS=1" on a noisy 8-core system
on an HDD, adding "GIT_FSYNC=0" to the invocation brings my test
runtime from ~4 minutes down to ~3 minutes.

SVN interopability tests are minimally affected since SVN will
still use fsync in various places.

This will also be useful for 3rd-party tools which create
throwaway git repositories of temporary data.

Signed-off-by: Eric Wong <e@80x24.org>
---
 Documentation/config/core.txt |  7 +++++++
 Documentation/git.txt         |  5 +++++
 cache.h                       |  1 +
 config.c                      |  5 +++++
 environment.c                 |  1 +
 git-cvsserver.perl            | 22 ++++++++++++++++++++++
 perl/Git/SVN.pm               | 20 ++++++++++++++++++--
 t/test-lib.sh                 |  1 +
 write-or-die.c                |  5 ++++-
 9 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index c04f62a54a..2ad5364246 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -555,6 +555,13 @@ data writes properly, but can be useful for filesystems that do not use
 journalling (traditional UNIX filesystems) or that only journal metadata
 and not file contents (OS X's HFS+, or Linux ext3 with "data=writeback").
 
+core.fsync::
+	A boolean to control 'fsync()' on all files.
++
+Setting this to false can speed up writes of unimportant data.
+Disabling fsync will lead to data loss on power failure.  If set
+to false, this also overrides core.fsyncObjectFiles.  Defaults to true.
+
 core.preloadIndex::
 	Enable parallel index preload for operations like 'git diff'
 +
diff --git a/Documentation/git.txt b/Documentation/git.txt
index d63c65e67d..cda4504e41 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -703,6 +703,11 @@ for further details.
 	not set, Git will choose buffered or record-oriented flushing
 	based on whether stdout appears to be redirected to a file or not.
 
+`GIT_FSYNC`::
+	Setting this environment variable to "0" disables fsync() entirely.
+	This is intended for running test suites and other repositories of
+	unimportant data.  See also core.fsync in linkgit:git-config[1].
+
 `GIT_TRACE`::
 	Enables general trace messages, e.g. alias expansion, built-in
 	command execution and external command execution.
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
diff --git a/config.c b/config.c
index 2dcbe901b6..1ea7cb801b 100644
--- a/config.c
+++ b/config.c
@@ -1492,6 +1492,11 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.fsync")) {
+		use_fsync = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.preloadindex")) {
 		core_preload_index = git_config_bool(var, value);
 		return 0;
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
index 64319bed43..7679819e4d 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -3607,6 +3607,25 @@ package GITCVS::updater;
 use strict;
 use warnings;
 use DBI;
+our $_use_fsync;
+
+# n.b. consider using Git.pm
+sub use_fsync {
+    if (!defined($_use_fsync)) {
+        my $x = $ENV{GIT_FSYNC};
+        if (defined $x) {
+            local $ENV{GIT_CONFIG};
+            delete $ENV{GIT_CONFIG};
+            my $v = ::safe_pipe_capture('git', '-c', "core.fsync=$x",
+                                        qw(config --type=bool core.fsync));
+            $_use_fsync = defined($v) ? ($v eq "true\n") : 1;
+        } else {
+            my $v = `git config --type=bool core.fsync`;
+            $_use_fsync = $v eq "false\n" ? 0 : 1;
+        }
+    }
+    $_use_fsync;
+}
 
 =head1 METHODS
 
@@ -3676,6 +3695,9 @@ sub new
                                 $self->{dbuser},
                                 $self->{dbpass});
     die "Error connecting to database\n" unless defined $self->{dbh};
+    if ($self->{dbdriver} eq 'SQLite' && !use_fsync()) {
+        $self->{dbh}->do('PRAGMA synchronous = OFF');
+    }
 
     $self->{tables} = {};
     foreach my $table ( keys %{$self->{dbh}->table_info(undef,undef,undef,'TABLE')->fetchall_hashref('TABLE_NAME')} )
diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 35ff5a6896..7b333ea62e 100644
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
@@ -2269,6 +2269,22 @@ sub mkfile {
 	}
 }
 
+# TODO: move this to Git.pm?
+sub use_fsync {
+	if (!defined($_use_fsync)) {
+		my $x = $ENV{GIT_FSYNC};
+		if (defined $x) {
+			my $v = command_oneline('git', '-c', "core.fsync=$x",
+				qw(config --type=bool core.fsync));
+			$_use_fsync = defined($v) ? ($v eq "true\n") : 1;
+		} else {
+			$_use_fsync = Git::config_bool('core.fsync');
+			$_use_fsync = 1 if !defined($_use_fsync);
+		}
+	}
+	$_use_fsync;
+}
+
 sub rev_map_set {
 	my ($self, $rev, $commit, $update_ref, $uuid) = @_;
 	defined $commit or die "missing arg3\n";
@@ -2290,7 +2306,7 @@ sub rev_map_set {
 	my $sync;
 	# both of these options make our .rev_db file very, very important
 	# and we can't afford to lose it because rebuild() won't work
-	if ($self->use_svm_props || $self->no_metadata) {
+	if (($self->use_svm_props || $self->no_metadata) && use_fsync()) {
 		require File::Copy;
 		$sync = 1;
 		File::Copy::copy($db, $db_lock) or die "rev_map_set(@_): ",
diff --git a/t/test-lib.sh b/t/test-lib.sh
index a291a5d4a2..61bb24444c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -442,6 +442,7 @@ unset VISUAL EMAIL LANGUAGE $("$PERL_PATH" -e '
 		PERF_
 		CURL_VERBOSE
 		TRACE_CURL
+		FSYNC
 	));
 	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
 	print join("\n", @vars);
diff --git a/write-or-die.c b/write-or-die.c
index 0b1ec8190b..d2962dc423 100644
--- a/write-or-die.c
+++ b/write-or-die.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "config.h"
 #include "run-command.h"
 
 /*
@@ -57,7 +58,9 @@ void fprintf_or_die(FILE *f, const char *fmt, ...)
 
 void fsync_or_die(int fd, const char *msg)
 {
-	while (fsync(fd) < 0) {
+	if (use_fsync < 0)
+		use_fsync = git_env_bool("GIT_FSYNC", 1);
+	while (use_fsync && fsync(fd) < 0) {
 		if (errno != EINTR)
 			die_errno("fsync error on '%s'", msg);
 	}
