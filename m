From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] cvsserver: Add some useful commandline options
Date: Thu,  7 Jun 2007 16:57:01 +0200
Message-ID: <11812282222271-git-send-email-frank@lichtenheld.de>
References: <1181228221959-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 07 16:57:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwJQM-0003Qg-SE
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 16:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759511AbXFGO5J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 10:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759757AbXFGO5J
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 10:57:09 -0400
Received: from v32413.1blu.de ([88.84.155.73]:33101 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759511AbXFGO5G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 10:57:06 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1HwJQ8-0000WT-Gn; Thu, 07 Jun 2007 16:57:04 +0200
Received: from p54b0e234.dip.t-dialin.net ([84.176.226.52] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HwJQ7-0004RF-6B; Thu, 07 Jun 2007 16:57:03 +0200
Received: from djpig by dirac.djpig.de with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1HwJQ6-0008Gn-Aj; Thu, 07 Jun 2007 16:57:02 +0200
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <1181228221959-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49372>

Make git-cvsserver understand some options inspired by
git-daemon, namely --base-path, --export-all, --strict-paths.

Also allow the caller to specify a whitelist of allowed
directories, again similar to git-daemon.

While already adding option parsing also support the common
--help and --version options.

Rationale:

While the gitcvs.enabled configuration option already
offers means to limit git-cvsserver access to a repository,
there are some use cases where other methods of access
control prove to be more useful.

E.g. if setting up a pserver for a collection of public
repositories one might want limit the exported repositories
to exactly the directory this collection is located whithout
having to worry about other repositories that might lie around
with the configuration variable set (never trust your users ;)

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/git-cvsserver.txt |   42 ++++++++++++++++++++
 git-cvsserver.perl              |   79 ++++++++++++++++++++++++++++++++++++---
 t/t9400-git-cvsserver-server.sh |   28 ++++++++++++++
 3 files changed, 143 insertions(+), 6 deletions(-)

 --interpolated-path can't be supported because the information isn't
 available in CVS protocoll.

 --user-path could be supported, I just hadn't motivation/time enough to
 do that.

 The documentation part of the patch could probably use some improvement
 still.

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index e5005f0..6d1e311 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -7,10 +7,52 @@ git-cvsserver - A CVS server emulator for git
 
 SYNOPSIS
 --------
+
+SSH:
+
 [verse]
 export CVS_SERVER=git-cvsserver
 'cvs' -d :ext:user@server/path/repo.git co <HEAD_name>
 
+pserver (/etc/inetd.conf):
+
+[verse]
+cvspserver stream tcp nowait nobody /usr/bin/git-cvsserver git-cvsserver pserver
+
+Usage:
+
+[verse]
+'git-cvsserver' [options] [pserver|server] [<directory> ...]
+
+OPTIONS
+-------
+
+All these options obviously only make sense if enforced by the server side.
+They have been implemented to resemble the gitlink:git-daemon[1] options as
+closely as possible.
+
+--base-path <path>::
+Prepend 'path' to requested CVSROOT
+
+--strict-paths::
+Don't allow recursing into subdirectories
+
+--export-all::
+Don't check for `gitcvs.enabled` in config
+
+--version, -V::
+Print version information and exit
+
+--help, -h, -H::
+Print usage information and exit
+
+<directory>::
+You can specify a list of allowed directories. If no directories
+are given, all are allowed. This is an additional restriction, gitcvs
+access still needs to be enabled by the `gitcvs.enabled` config option
+unless '--export-all' was given, too.
+
+
 DESCRIPTION
 -----------
 
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index d41b29f..9fbd9db 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -22,6 +22,9 @@ use bytes;
 use Fcntl;
 use File::Temp qw/tempdir tempfile/;
 use File::Basename;
+use Getopt::Long qw(:config require_order no_ignore_case);
+
+my $VERSION = '@@GIT_VERSION@@';
 
 my $log = GITCVS::log->new();
 my $cfg;
@@ -85,15 +88,52 @@ my $methods = {
 my $state = { prependdir => '' };
 $log->info("--------------- STARTING -----------------");
 
+my $usage =
+    "Usage: git-cvsserver [options] [pserver|server] [<directory> ...]\n".
+    "    --base-path <path>  : Prepend to requested CVSROOT\n".
+    "    --strict-paths      : Don't allow recursing into subdirectories\n".
+    "    --export-all        : Don't check for gitcvs.enabled in config\n".
+    "    --version, -V       : Print version information and exit\n".
+    "    --help, -h, -H      : Print usage information and exit\n".
+    "\n".
+    "<directory> ... is a list of allowed directories. If no directories\n".
+    "are given, all are allowed. This is an additional restriction, gitcvs\n".
+    "access still needs to be enabled by the gitcvs.enabled config option.\n";
+
+my @opts = ( 'help|h|H', 'version|V',
+	     'base-path=s', 'strict-paths', 'export-all' );
+GetOptions( $state, @opts )
+    or die $usage;
+
+if ($state->{version}) {
+    print "git-cvsserver version $VERSION\n";
+    exit;
+}
+if ($state->{help}) {
+    print $usage;
+    exit;
+}
+
 my $TEMP_DIR = tempdir( CLEANUP => 1 );
 $log->debug("Temporary directory is '$TEMP_DIR'");
 
+$state->{method} = 'ext';
+if (@ARGV) {
+    if ($ARGV[0] eq 'pserver') {
+	$state->{method} = 'pserver';
+	shift @ARGV;
+    } elsif ($ARGV[0] eq 'server') {
+	shift @ARGV;
+    }
+}
+
+# everything else is a directory
+$state->{allowed_roots} = [ @ARGV ];
+
 # if we are called with a pserver argument,
 # deal with the authentication cat before entering the
 # main loop
-$state->{method} = 'ext';
-if (@ARGV && $ARGV[0] eq 'pserver') {
-    $state->{method} = 'pserver';
+if ($state->{method} eq 'pserver') {
     my $line = <STDIN>; chomp $line;
     unless( $line =~ /^BEGIN (AUTH|VERIFICATION) REQUEST$/) {
        die "E Do not understand $line - expecting BEGIN AUTH REQUEST\n";
@@ -178,13 +218,40 @@ sub req_Root
 	return 0;
     }
 
-    $state->{CVSROOT} = $data;
+    $state->{CVSROOT} = $state->{'base-path'} || '';
+    $state->{CVSROOT} =~ s#/+$##;
+    $state->{CVSROOT} .= $data;
 
     $ENV{GIT_DIR} = $state->{CVSROOT} . "/";
+
+    if (@{$state->{allowed_roots}}) {
+	my $allowed = 0;
+	foreach my $dir (@{$state->{allowed_roots}}) {
+	    next unless $dir =~ m#^/#;
+	    $dir =~ s#/+$##;
+	    if ($state->{'strict-paths'}) {
+		if ($ENV{GIT_DIR} =~ m#^\Q$dir\E/?$#) {
+		    $allowed = 1;
+		    last;
+		}
+	    } elsif ($ENV{GIT_DIR} =~ m#^\Q$dir\E(/?$|/)#) {
+		$allowed = 1;
+		last;
+	    }
+	}
+
+	unless ($allowed) {
+	    print "E $ENV{GIT_DIR} does not seem to be a valid GIT repository\n";
+	    print "E \n";
+	    print "error 1 $ENV{GIT_DIR} is not a valid repository\n";
+	    return 0;
+	}
+    }
+
     unless (-d $ENV{GIT_DIR} && -e $ENV{GIT_DIR}.'HEAD') {
        print "E $ENV{GIT_DIR} does not seem to be a valid GIT repository\n";
-        print "E \n";
-        print "error 1 $ENV{GIT_DIR} is not a valid repository\n";
+       print "E \n";
+       print "error 1 $ENV{GIT_DIR} is not a valid repository\n";
        return 0;
     }
 
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 41dcf64..392f890 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -143,6 +143,34 @@ test_expect_success 'req_Root failure (conflicting roots)' \
   'cat request-conflict | git-cvsserver pserver >log 2>&1 &&
    tail log | grep -q "^error 1 Conflicting roots specified$"'
 
+test_expect_success 'req_Root (strict paths)' \
+  'cat request-anonymous | git-cvsserver --strict-paths pserver $SERVERDIR >log 2>&1 &&
+   tail -n1 log | grep -q "^I LOVE YOU$"'
+
+test_expect_failure 'req_Root failure (strict-paths)' \
+  'cat request-anonymous | git-cvsserver --strict-paths pserver $WORKDIR >log 2>&1'
+
+test_expect_success 'req_Root (w/o strict-paths)' \
+  'cat request-anonymous | git-cvsserver pserver $WORKDIR/ >log 2>&1 &&
+   tail -n1 log | grep -q "^I LOVE YOU$"'
+
+test_expect_failure 'req_Root failure (w/o strict-paths)' \
+  'cat request-anonymous | git-cvsserver pserver $WORKDIR/gitcvs >log 2>&1'
+
+cat >request-base  <<EOF
+BEGIN AUTH REQUEST
+/gitcvs.git
+anonymous
+
+END AUTH REQUEST
+EOF
+
+test_expect_success 'req_Root (base-path)' \
+  'cat request-base | git-cvsserver --strict-paths --base-path $WORKDIR/ pserver $SERVERDIR >log 2>&1 &&
+   tail -n1 log | grep -q "^I LOVE YOU$"'
+
+test_expect_failure 'req_Root failure (base-path)' \
+  'cat request-anonymous | git-cvsserver --strict-paths --base-path $WORKDIR pserver $SERVERDIR >log 2>&1'
 
 #--------------
 # CONFIG TESTS
-- 
1.5.2.1
