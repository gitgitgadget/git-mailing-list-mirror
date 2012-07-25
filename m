From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 1/4] Extract some utilities from git-svn to allow extracting Git::SVN.
Date: Tue, 24 Jul 2012 23:01:03 -0700
Message-ID: <1343196066-81319-2-git-send-email-schwern@pobox.com>
References: <1343196066-81319-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, "Michael G. Schwern" <schwern@pobox.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 25 08:01:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StufA-0007mm-DK
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 08:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756407Ab2GYGBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 02:01:31 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51502 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756388Ab2GYGB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 02:01:29 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so869214pbb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 23:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=/4NaoalIb/qZtofjEFtD7nnV1XfYOJtkBttnXwMpPHE=;
        b=dKQLW9OJ7d8z+CtkG2m/ZOzmt72aQgqjcfVemBT6YZ0dJ6AWFHr+T1zH60AGRQmOK1
         38Xw8ij29McUiu0h8+F5YKmUetVyERoD3Xat5sJNB+04xRIfnjZDOz5kB/47JltztoIv
         L5GRCDwYAvGctPhXcyR/7xFR5uPc8+wuUg3StM1h8wP/ggeKeKarLL8RIpIu2oex8JBk
         O5Y5g8HrAG1L3kKAPwx/MAn34Uu/ccV8MusxtgIulKWMTGZgl6+EyMYSH2pOrWmHj6k5
         z8vzS1F4Vf7m21TamjdMGpg4rfUOG7YKNRWi04laI4nDeHiaZnNfZsW6cmqIePDaP4EO
         QOTw==
Received: by 10.68.203.40 with SMTP id kn8mr50537094pbc.162.1343196089526;
        Tue, 24 Jul 2012 23:01:29 -0700 (PDT)
Received: from windhund.local.net (c-71-236-173-173.hsd1.or.comcast.net. [71.236.173.173])
        by mx.google.com with ESMTPS id oy8sm13681630pbc.52.2012.07.24.23.01.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 23:01:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1
In-Reply-To: <1343196066-81319-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202125>

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
