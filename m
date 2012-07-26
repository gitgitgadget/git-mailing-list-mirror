From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 1/4] Extract some utilities from git-svn to allow extracting Git::SVN.
Date: Thu, 26 Jul 2012 16:22:22 -0700
Message-ID: <1343344945-3717-2-git-send-email-schwern@pobox.com>
References: <1343344945-3717-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com,
	"Michael G. Schwern" <schwern@pobox.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 27 01:23:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuXOZ-0005Dz-Lm
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 01:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200Ab2GZXW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 19:22:57 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:47861 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148Ab2GZXW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 19:22:56 -0400
Received: by ghrr11 with SMTP id r11so2620202ghr.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 16:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=XJ+0wpLulw/TU+Qv+qlKXKZTCHZDXTVlSCkCHb8gBIU=;
        b=rBoAjIdDzQD9UjN0FxIPeiT2xQVrUCsjrg/H6duvXiUuvJ6KPwUPjwk3D/j5vNzT2b
         VfnviMmbtF+U7mRjdVvVQ6FpaizfBQZVkqv+47PmjqxAt5zH/32Qrl3b5sd5/AisbHVV
         qS18ritwPtMJJrvbIplTgXvJQQQY5lsBPnRzxXfAcP661iFVwo2QcEtB14X/5r7ZH5JI
         5KDYTrImuW3vqIBb6md7igJ+mWMe682z3DQ/okcGVBCUJME6hV3hvtZdLnQl4Lrmkc7s
         if8kEP7216bxFWn6EZ+RVYmy+onc3+Kd+uche1x6kI1BHrgpLvDiS4UQe3IITN6wmdCL
         5gtg==
Received: by 10.66.84.138 with SMTP id z10mr1143579pay.2.1343344975236;
        Thu, 26 Jul 2012 16:22:55 -0700 (PDT)
Received: from localhost.localdomain (c-76-105-239-160.hsd1.or.comcast.net. [76.105.239.160])
        by mx.google.com with ESMTPS id oo6sm596728pbc.22.2012.07.26.16.22.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 16:22:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1
In-Reply-To: <1343344945-3717-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202317>

From: "Michael G. Schwern" <schwern@pobox.com>

Put them in a new module called Git::SVN::Utils.  Yeah, not terribly
original and it will be a dumping ground.  But its better than having
them in the main git-svn program.  At least they can be documented
and tested.

* fatal() is used by many classes.
* Change the $can_compress lexical into a function.

This should be enough to extract Git::SVN.

Signed-off-by: Michael G. Schwern <schwern@pobox.com>
---
 git-svn.perl                   | 34 +++++++++++++-----------
 perl/Git/SVN/Utils.pm          | 59 ++++++++++++++++++++++++++++++++++++++++++
 perl/Makefile                  |  1 +
 t/Git-SVN/00compile.t          |  8 ++++++
 t/Git-SVN/Utils/can_compress.t | 11 ++++++++
 t/Git-SVN/Utils/fatal.t        | 34 ++++++++++++++++++++++++
 6 files changed, 132 insertions(+), 15 deletions(-)
 create mode 100644 perl/Git/SVN/Utils.pm
 create mode 100644 t/Git-SVN/00compile.t
 create mode 100644 t/Git-SVN/Utils/can_compress.t
 create mode 100644 t/Git-SVN/Utils/fatal.t

diff --git a/git-svn.perl b/git-svn.perl
index 0b074c4..79fe4a4 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -10,6 +10,8 @@ use vars qw/	$AUTHOR $VERSION
 $AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
 $VERSION = '@@GIT_VERSION@@';
 
+use Git::SVN::Utils qw(fatal can_compress);
+
 # From which subdir have we been invoked?
 my $cmd_dir_prefix = eval {
 	command_oneline([qw/rev-parse --show-prefix/], STDERR => 0)
@@ -35,8 +37,6 @@ $Git::SVN::Log::TZ = $ENV{TZ};
 $ENV{TZ} = 'UTC';
 $| = 1; # unbuffer STDOUT
 
-sub fatal (@) { print STDERR "@_\n"; exit 1 }
-
 # All SVN commands do it.  Otherwise we may die on SIGPIPE when the remote
 # repository decides to close the connection which we expect to be kept alive.
 $SIG{PIPE} = 'IGNORE';
@@ -66,7 +66,7 @@ sub _req_svn {
 		fatal "Need SVN::Core 1.1.0 or better (got $SVN::Core::VERSION)";
 	}
 }
-my $can_compress = eval { require Compress::Zlib; 1};
+
 use Carp qw/croak/;
 use Digest::MD5;
 use IO::File qw//;
@@ -1578,7 +1578,7 @@ sub cmd_reset {
 }
 
 sub cmd_gc {
-	if (!$can_compress) {
+	if (!can_compress()) {
 		warn "Compress::Zlib could not be found; unhandled.log " .
 		     "files will not be compressed.\n";
 	}
@@ -2014,13 +2014,13 @@ sub md5sum {
 	} elsif (!$ref) {
 		$md5->add($arg) or croak $!;
 	} else {
-		::fatal "Can't provide MD5 hash for unknown ref type: '", $ref, "'";
+		fatal "Can't provide MD5 hash for unknown ref type: '", $ref, "'";
 	}
 	return $md5->hexdigest();
 }
 
 sub gc_directory {
-	if ($can_compress && -f $_ && basename($_) eq "unhandled.log") {
+	if (can_compress() && -f $_ && basename($_) eq "unhandled.log") {
 		my $out_filename = $_ . ".gz";
 		open my $in_fh, "<", $_ or die "Unable to open $_: $!\n";
 		binmode $in_fh;
@@ -2055,6 +2055,9 @@ use Time::Local;
 use Memoize;  # core since 5.8.0, Jul 2002
 use Memoize::Storable;
 use POSIX qw(:signal_h);
+
+use Git::SVN::Utils qw(fatal can_compress);
+
 my $can_use_yaml;
 BEGIN {
 	$can_use_yaml = eval { require Git::SVN::Memoize::YAML; 1};
@@ -2880,8 +2883,8 @@ sub assert_index_clean {
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
@@ -3236,7 +3239,7 @@ sub mkemptydirs {
 	my %empty_dirs = ();
 	my $gz_file = "$self->{dir}/unhandled.log.gz";
 	if (-f $gz_file) {
-		if (!$can_compress) {
+		if (!can_compress()) {
 			warn "Compress::Zlib could not be found; ",
 			     "empty directories in $gz_file will not be read\n";
 		} else {
@@ -3919,7 +3922,7 @@ sub set_tree {
 	my ($self, $tree) = (shift, shift);
 	my $log_entry = ::get_commit_entry($tree);
 	unless ($self->{last_rev}) {
-		::fatal("Must have an existing revision to commit");
+		fatal("Must have an existing revision to commit");
 	}
 	my %ed_opts = ( r => $self->{last_rev},
 	                log => $log_entry->{log},
@@ -4348,6 +4351,7 @@ sub remove_username {
 package Git::SVN::Log;
 use strict;
 use warnings;
+use Git::SVN::Utils qw(fatal);
 use POSIX qw/strftime/;
 use constant commit_log_separator => ('-' x 72) . "\n";
 use vars qw/$TZ $limit $color $pager $non_recursive $verbose $oneline
@@ -4446,15 +4450,15 @@ sub config_pager {
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
@@ -4603,7 +4607,7 @@ sub cmd_show_log {
 		} elsif ($::_revision =~ /^\d+$/) {
 			$r_min = $r_max = $::_revision;
 		} else {
-			::fatal "-r$::_revision is not supported, use ",
+			fatal "-r$::_revision is not supported, use ",
 				"standard 'git log' arguments instead";
 		}
 	}
diff --git a/perl/Git/SVN/Utils.pm b/perl/Git/SVN/Utils.pm
new file mode 100644
index 0000000..3d0bfa4
--- /dev/null
+++ b/perl/Git/SVN/Utils.pm
@@ -0,0 +1,59 @@
+package Git::SVN::Utils;
+
+use strict;
+use warnings;
+
+use base qw(Exporter);
+
+our @EXPORT_OK = qw(fatal can_compress);
+
+
+=head1 NAME
+
+Git::SVN::Utils - utility functions used across Git::SVN
+
+=head1 SYNOPSIS
+
+    use Git::SVN::Utils qw(functions to import);
+
+=head1 DESCRIPTION
+
+This module contains functions which are useful across many different
+parts of Git::SVN.  Mostly it's a place to put utility functions
+rather than duplicate the code or have classes grabbing at other
+classes.
+
+=head1 FUNCTIONS
+
+All functions can be imported only on request.
+
+=head3 fatal
+
+    fatal(@message);
+
+Display a message and exit with a fatal error code.
+
+=cut
+
+# Note: not certain why this is in use instead of die.  Probably because
+# the exit code of die is 255?  Doesn't appear to be used consistently.
+sub fatal (@) { print STDERR "@_\n"; exit 1 }
+
+
+=head3 can_compress
+
+    my $can_compress = can_compress;
+
+Returns true if Compress::Zlib is available, false otherwise.
+
+=cut
+
+my $can_compress;
+sub can_compress {
+    return $can_compress if defined $can_compress;
+
+    return $can_compress = eval { require Compress::Zlib; } ? 1 : 0;
+}
+
+
+1;
diff --git a/perl/Makefile b/perl/Makefile
index 6ca7d47..24a9f5a 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -31,6 +31,7 @@ modules += Git/SVN/Fetcher
 modules += Git/SVN/Editor
 modules += Git/SVN/Prompt
 modules += Git/SVN/Ra
+modules += Git/SVN/Utils
 
 $(makfile): ../GIT-CFLAGS Makefile
 	echo all: private-Error.pm Git.pm Git/I18N.pm > $@
diff --git a/t/Git-SVN/00compile.t b/t/Git-SVN/00compile.t
new file mode 100644
index 0000000..a7aa85a
--- /dev/null
+++ b/t/Git-SVN/00compile.t
@@ -0,0 +1,8 @@
+#!/usr/bin/env perl
+
+use strict;
+use warnings;
+
+use Test::More tests => 1;
+
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
index 0000000..49e1438
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
+	# Override exit at BEGIN time before Git::SVN::Utils is loaded
+	# so it will see our local exit later.
+	*CORE::GLOBAL::exit = sub(;$) {
+	return @_ ? CORE::exit($_[0]) : CORE::exit();
+	};
+}
+
+use Git::SVN::Utils qw(fatal);
+
+# fatal()
+{
+	# Capture the exit code and prevent exit.
+	my $exit_status;
+	no warnings 'redefine';
+	local *CORE::GLOBAL::exit = sub { $exit_status = $_[0] || 0 };
+
+	# Trap fatal's message to STDERR
+	my $stderr;
+	close STDERR;
+	ok open STDERR, ">", \$stderr;
+
+	fatal "Some", "Stuff", "Happened";
+
+	is $stderr, "Some Stuff Happened\n";
+	is $exit_status, 1;
+}
-- 
1.7.11.1
