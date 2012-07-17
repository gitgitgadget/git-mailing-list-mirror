From: Michael G Schwern <schwern@pobox.com>
Subject: Extract Git classes from git-svn (2/10) (was Re: Fix git-svn tests
 for SVN 1.7.5.)
Date: Tue, 17 Jul 2012 16:12:36 -0700
Message-ID: <5005F164.3060300@pobox.com>
References: <5004B772.3090806@pobox.com> <20120717174446.GA14244@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 01:12:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrGwe-0001gC-O6
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 01:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754879Ab2GQXMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 19:12:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46181 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751708Ab2GQXMh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 19:12:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25330843E;
	Tue, 17 Jul 2012 19:12:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=c3DF6vvSH1d+
	WW0WyNtlNsWEXkk=; b=lURlZQTctUmREbRsEd/8WZU6SMgwMNqICGnsIY0Aaob1
	BA48a4V6ZJ92Gi0R0voIKgLd0oFT0boy5nCg1OMxrDOtwrUeLAd85dP44GXrWItv
	hVMsx8bztHgcwK4SPiUo/+ykMdecEi//gfZEE8LdlIhT2ursJGo/NyePQknQM18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=e0eNbQ
	A35YxLOZA4ydyCkwHnFsQOz/dk+yWD09XtfNquwCTEb8WsiDBn7q1YiKGLYVRYmL
	t6wWV0sg7VfBVMINCnDhRA3ZnL2uoM7uvgLTHk92ZqwvACnJD5SYdCUVj1OgVu7r
	vVFXwDtxOF/I8s70ZjsLbO2be0dWiXOfT/TsM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F897843D;
	Tue, 17 Jul 2012 19:12:37 -0400 (EDT)
Received: from windhund.local (unknown [67.23.204.5]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 144D1843C; Tue, 17 Jul
 2012 19:12:36 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:13.0)
 Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <20120717174446.GA14244@burratino>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: E5A9DE88-D064-11E1-921B-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201627>

>From 683a230e439f1d5ac2727ce4c2a74e93804fc72b Mon Sep 17 00:00:00 2001
From: "Michael G. Schwern" <schwern@pobox.com>
Date: Wed, 11 Jul 2012 22:16:01 -0700
Subject: [PATCH 03/11] Fix Git::SVN so it can at least compile alone.

It's still very intertwined with git-svn, but that's a lot of work.  This
gets things working and tests passing again (as well as they were).

This required some parallel refactorings...

* fatal() moved out of git-svn into a new Git::SVN::Utils

* The $can_compress lexical moved into Git::SVN::Utils::can_compress()

* The $_prefix variable which stores the --prefix option is wrapped
  in a function (rather than made global) so access to it can be
  controlled.  Git::SVN does not rely on this function being
  available so it can work without git-svn loaded.  In general,
  the options should be put back together into a hash and accessed
  via an options() function.

* A new tree of unit tests for the Git::SVN modules has been created.
  It doesn't work with the existing Makefile, that can be worried
  about later.

* Move initialization of Git::SVN globals into Git::SVN

* Have Git::SVN load the Git command* functions on its own
---
 git-svn.perl                   | 33 ++++++++++++++++++---------------
 perl/Git/SVN.pm                | 29 ++++++++++++++++++++---------
 perl/Git/SVN/Utils.pm          | 19 +++++++++++++++++++
 perl/Makefile                  |  2 ++
 t/Git-SVN/00compile.t          |  9 +++++++++
 t/Git-SVN/Utils/can_compress.t | 11 +++++++++++
 t/Git-SVN/Utils/fatal.t        | 34 ++++++++++++++++++++++++++++++++++
 7 files changed, 113 insertions(+), 24 deletions(-)
 create mode 100644 perl/Git/SVN/Utils.pm
 create mode 100644 t/Git-SVN/00compile.t
 create mode 100644 t/Git-SVN/Utils/can_compress.t
 create mode 100644 t/Git-SVN/Utils/fatal.t

diff --git a/git-svn.perl b/git-svn.perl
index 59db0a4..8a02d1c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -10,6 +10,9 @@ use vars qw/	$AUTHOR $VERSION
 $AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
 $VERSION = '@@GIT_VERSION@@';

+use Git::SVN;
+use Git::SVN::Utils qw(fatal can_compress);
+
 # From which subdir have we been invoked?
 my $cmd_dir_prefix = eval {
 	command_oneline([qw/rev-parse --show-prefix/], STDERR => 0)
@@ -17,10 +20,8 @@ my $cmd_dir_prefix = eval {

 my $git_dir_user_set = 1 if defined $ENV{GIT_DIR};
 $ENV{GIT_DIR} ||= '.git';
-$Git::SVN::default_repo_id = 'svn';
-$Git::SVN::default_ref_id = $ENV{GIT_SVN_ID} || 'git-svn';
+
 $Git::SVN::Ra::_log_window_size = 100;
-$Git::SVN::_minimize_url = 'unset';

 if (! exists $ENV{SVN_SSH} && exists $ENV{GIT_SSH}) {
 	$ENV{SVN_SSH} = $ENV{GIT_SSH};
@@ -35,8 +36,6 @@ $Git::SVN::Log::TZ = $ENV{TZ};
 $ENV{TZ} = 'UTC';
 $| = 1; # unbuffer STDOUT

-sub fatal (@) { print STDERR "@_\n"; exit 1 }
-
 # All SVN commands do it.  Otherwise we may die on SIGPIPE when the remote
 # repository decides to close the connection which we expect to be kept alive.
 $SIG{PIPE} = 'IGNORE';
@@ -66,7 +65,7 @@ sub _req_svn {
 		fatal "Need SVN::Core 1.1.0 or better (got $SVN::Core::VERSION)";
 	}
 }
-my $can_compress = eval { require Compress::Zlib; 1};
+
 use Carp qw/croak/;
 use Digest::MD5;
 use IO::File qw//;
@@ -89,7 +88,7 @@ BEGIN {
 	foreach (qw/command command_oneline command_noisy command_output_pipe
 	            command_input_pipe command_close_pipe
 	            command_bidi_pipe command_close_bidi_pipe/) {
-		for my $package ( qw(Git::SVN::Migration Git::SVN::Log Git::SVN),
+		for my $package ( qw(Git::SVN::Migration Git::SVN::Log),
 			__PACKAGE__) {
 			*{"${package}::$_"} = \&{"Git::$_"};
 		}
@@ -109,7 +108,10 @@ my ($_stdin, $_help, $_edit,
 	$_merge, $_strategy, $_preserve_merges, $_dry_run, $_local,
 	$_prefix, $_no_checkout, $_url, $_verbose,
 	$_git_format, $_commit_url, $_tag, $_merge_info, $_interactive);
-$Git::SVN::_follow_parent = 1;
+
+# This is a refactoring artifact so Git::SVN can get at this variable.
+sub opt_prefix { return $_prefix || '' }
+
 $Git::SVN::Fetcher::_placeholder_filename = ".gitignore";
 $_q ||= 0;
 my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
@@ -1578,7 +1580,7 @@ sub cmd_reset {
 }

 sub cmd_gc {
-	if (!$can_compress) {
+	if (!can_compress()) {
 		warn "Compress::Zlib could not be found; unhandled.log " .
 		     "files will not be compressed.\n";
 	}
@@ -2020,7 +2022,7 @@ sub md5sum {
 }

 sub gc_directory {
-	if ($can_compress && -f $_ && basename($_) eq "unhandled.log") {
+	if (can_compress() && -f $_ && basename($_) eq "unhandled.log") {
 		my $out_filename = $_ . ".gz";
 		open my $in_fh, "<", $_ or die "Unable to open $_: $!\n";
 		binmode $in_fh;
@@ -2042,6 +2044,7 @@ sub gc_directory {
 package Git::SVN::Log;
 use strict;
 use warnings;
+use Git::SVN::Utils qw(fatal);
 use POSIX qw/strftime/;
 use constant commit_log_separator => ('-' x 72) . "\n";
 use vars qw/$TZ $limit $color $pager $non_recursive $verbose $oneline
@@ -2140,15 +2143,15 @@ sub config_pager {
 sub run_pager {
 	return unless defined $pager;
 	pipe my ($rfd, $wfd) or return;
-	defined(my $pid = fork) or ::fatal "Can't fork: $!";
+	defined(my $pid = fork) or fatal "Can't fork: $!";
 	if (!$pid) {
 		open STDOUT, '>&', $wfd or
-		                     ::fatal "Can't redirect to stdout: $!";
+		                     fatal "Can't redirect to stdout: $!";
 		return;
 	}
-	open STDIN, '<&', $rfd or ::fatal "Can't redirect stdin: $!";
+	open STDIN, '<&', $rfd or fatal "Can't redirect stdin: $!";
 	$ENV{LESS} ||= 'FRSX';
-	exec $pager or ::fatal "Can't run pager: $! ($pager)";
+	exec $pager or fatal "Can't run pager: $! ($pager)";
 }

 sub format_svn_date {
@@ -2297,7 +2300,7 @@ sub cmd_show_log {
 		} elsif ($::_revision =~ /^\d+$/) {
 			$r_min = $r_max = $::_revision;
 		} else {
-			::fatal "-r$::_revision is not supported, use ",
+			fatal "-r$::_revision is not supported, use ",
 				"standard 'git log' arguments instead";
 		}
 	}
diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 533f1da..02983d6 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1,11 +1,13 @@
 package Git::SVN;
+
 use strict;
 use warnings;
+
 use Fcntl qw/:DEFAULT :seek/;
 use constant rev_map_fmt => 'NH40';
-use vars qw/$default_repo_id $default_ref_id $_no_metadata $_follow_parent
+use vars qw/$_no_metadata
             $_repack $_repack_flags $_use_svm_props $_head
-            $_use_svnsync_props $no_reuse_existing $_minimize_url
+            $_use_svnsync_props $no_reuse_existing
 	    $_use_log_author $_add_author_from $_localtime/;
 use Carp qw/croak/;
 use File::Path qw/mkpath/;
@@ -20,6 +22,14 @@ BEGIN {
 	$can_use_yaml = eval { require Git::SVN::Memoize::YAML; 1};
 }

+use Git qw(command command_oneline command_noisy command_output_pipe
command_close_pipe);
+use Git::SVN::Utils qw(fatal can_compress);
+
+our $_follow_parent  = 1;
+our $_minimize_url   = 'unset';
+our $default_repo_id = 'svn';
+our $default_ref_id  = $ENV{GIT_SVN_ID} || 'git-svn';
+
 my ($_gc_nr, $_gc_period);

 # properties that we do not log:
@@ -840,8 +850,8 @@ sub assert_index_clean {
 		command_noisy('read-tree', $treeish);
 		$x = command_oneline('write-tree');
 		if ($y ne $x) {
-			::fatal "trees ($treeish) $y != $x\n",
-			        "Something is seriously wrong...";
+			fatal "trees ($treeish) $y != $x\n",
+			      "Something is seriously wrong...";
 		}
 	});
 }
@@ -1196,7 +1206,7 @@ sub mkemptydirs {
 	my %empty_dirs = ();
 	my $gz_file = "$self->{dir}/unhandled.log.gz";
 	if (-f $gz_file) {
-		if (!$can_compress) {
+		if (!can_compress()) {
 			warn "Compress::Zlib could not be found; ",
 			     "empty directories in $gz_file will not be read\n";
 		} else {
@@ -1879,7 +1889,7 @@ sub set_tree {
 	my ($self, $tree) = (shift, shift);
 	my $log_entry = ::get_commit_entry($tree);
 	unless ($self->{last_rev}) {
-		::fatal("Must have an existing revision to commit");
+		fatal("Must have an existing revision to commit");
 	}
 	my %ed_opts = ( r => $self->{last_rev},
 	                log => $log_entry->{log},
@@ -2237,12 +2247,13 @@ sub find_rev_after {
 sub _new {
 	my ($class, $repo_id, $ref_id, $path) = @_;
 	unless (defined $repo_id && length $repo_id) {
-		$repo_id = $Git::SVN::default_repo_id;
+		$repo_id = $default_repo_id;
 	}
 	unless (defined $ref_id && length $ref_id) {
-		$_prefix = '' unless defined($_prefix);
+		# Access the prefix option from the git-svn main program if it's loaded.
+		my $prefix = defined &::opt_prefix ? ::opt_prefix() : "";
 		$_[2] = $ref_id =
-		             "refs/remotes/$_prefix$Git::SVN::default_ref_id";
+		             "refs/remotes/$prefix$default_ref_id";
 	}
 	$_[1] = $repo_id;
 	my $dir = "$ENV{GIT_DIR}/svn/$ref_id";
diff --git a/perl/Git/SVN/Utils.pm b/perl/Git/SVN/Utils.pm
new file mode 100644
index 0000000..d8f63e6
--- /dev/null
+++ b/perl/Git/SVN/Utils.pm
@@ -0,0 +1,19 @@
+package Git::SVN::Utils;
+
+use strict;
+use warnings;
+
+use base qw(Exporter);
+
+our @EXPORT_OK = qw(fatal can_compress);
+
+sub fatal (@) { print STDERR "@_\n"; exit 1 }
+
+my $can_compress;
+sub can_compress {
+    return $can_compress if defined $can_compress;
+
+    return $can_compress = eval { require Compress::Zlib; } ? 1 : 0;
+}
+
+1;
diff --git a/perl/Makefile b/perl/Makefile
index 4f25930..d0a0c5c 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -26,11 +26,13 @@ instdir_SQ = $(subst ','\'',$(prefix)/lib)

 modules += Git
 modules += Git/I18N
+modules += Git/SVN
 modules += Git/SVN/Memoize/YAML
 modules += Git/SVN/Fetcher
 modules += Git/SVN/Editor
 modules += Git/SVN/Prompt
 modules += Git/SVN/Ra
+modules += Git/SVN/Utils

 $(makfile): ../GIT-CFLAGS Makefile
 	echo all: bundles/Error/Error.pm $(modules) > $@
diff --git a/t/Git-SVN/00compile.t b/t/Git-SVN/00compile.t
new file mode 100644
index 0000000..c32ee4b
--- /dev/null
+++ b/t/Git-SVN/00compile.t
@@ -0,0 +1,9 @@
+#!/usr/bin/env perl
+
+use strict;
+use warnings;
+
+use Test::More tests => 2;
+
+require_ok 'Git::SVN';
+require_ok 'Git::SVN::Utils';
diff --git a/t/Git-SVN/Utils/can_compress.t b/t/Git-SVN/Utils/can_compress.t
new file mode 100644
index 0000000..d7b49b8
--- /dev/null
+++ b/t/Git-SVN/Utils/can_compress.t
@@ -0,0 +1,11 @@
+#!/usr/bin/perl
+
+use strict;
+use warnings;
+
+use Test::More 'no_plan';
+
+use Git::SVN::Utils qw(can_compress);
+
+# !! is the "convert this to boolean" operator.
+is !!can_compress(), !!eval { require Compress::Zlib };
diff --git a/t/Git-SVN/Utils/fatal.t b/t/Git-SVN/Utils/fatal.t
new file mode 100644
index 0000000..b90746c
--- /dev/null
+++ b/t/Git-SVN/Utils/fatal.t
@@ -0,0 +1,34 @@
+#!/usr/bin/perl
+
+use strict;
+use warnings;
+
+use Test::More 'no_plan';
+
+BEGIN {
+    # Override exit at BEGIN time before Git::SVN::Utils is loaded
+    # so it will see our local exit later.
+    *CORE::GLOBAL::exit = sub(;$) {
+        return @_ ? CORE::exit($_[0]) : CORE::exit();
+    };
+}
+
+use Git::SVN::Utils qw(fatal);
+
+# fatal()
+{
+    # Capture the exit code and prevent exit.
+    my $exit_status;
+    no warnings 'redefine';
+    local *CORE::GLOBAL::exit = sub { $exit_status = $_[0] || 0 };
+
+    # Trap fatal's message to STDERR
+    my $stderr;
+    close STDERR;
+    ok open STDERR, ">", \$stderr;
+
+    fatal "Some", "Stuff", "Happened";
+
+    is $stderr, "Some Stuff Happened\n";
+    is $exit_status, 1;
+}
-- 
1.7.11.1
