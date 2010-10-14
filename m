From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] tests: test terminal output to both stdout and stderr
Date: Wed, 13 Oct 2010 23:04:44 -0400
Message-ID: <20101014030443.GB5626@sigill.intra.peff.net>
References: <20101014030220.GB20685@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Chase Brammer <cbrammer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 05:04:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6E7G-00068f-5j
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 05:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754227Ab0JNDEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 23:04:21 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:44610 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754108Ab0JNDEU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 23:04:20 -0400
Received: (qmail 4666 invoked by uid 111); 14 Oct 2010 03:04:20 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 14 Oct 2010 03:04:20 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Oct 2010 23:04:44 -0400
Content-Disposition: inline
In-Reply-To: <20101014030220.GB20685@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159017>

Some outputs (like the pager) care whether stdout is a
terminal. Others (like progress meters) care about stderr.

This patch sets up both. Technically speaking, we could go
further and set up just one (because either the other goes
to a terminal, or because our tests are only interested in
one). This patch does both to keep the interface to
lib-terminal simple.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-terminal.sh    |    8 ++++----
 t/test-terminal.perl |   31 ++++++++++++++++++++++++-------
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/t/lib-terminal.sh b/t/lib-terminal.sh
index 6fc33db..3258b8f 100644
--- a/t/lib-terminal.sh
+++ b/t/lib-terminal.sh
@@ -1,19 +1,19 @@
 #!/bin/sh
 
 test_expect_success 'set up terminal for tests' '
-	if test -t 1
+	if test -t 1 && test -t 2
 	then
-		>stdout_is_tty
+		>have_tty
 	elif
 		test_have_prereq PERL &&
 		"$PERL_PATH" "$TEST_DIRECTORY"/test-terminal.perl \
-			sh -c "test -t 1"
+			sh -c "test -t 1 && test -t 2"
 	then
 		>test_terminal_works
 	fi
 '
 
-if test -e stdout_is_tty
+if test -e have_tty
 then
 	test_terminal() { "$@"; }
 	test_set_prereq TTY
diff --git a/t/test-terminal.perl b/t/test-terminal.perl
index 73ff809..c2e9dac 100755
--- a/t/test-terminal.perl
+++ b/t/test-terminal.perl
@@ -4,14 +4,15 @@ use warnings;
 use IO::Pty;
 use File::Copy;
 
-# Run @$argv in the background with stdout redirected to $out.
+# Run @$argv in the background with stdio redirected to $out and $err.
 sub start_child {
-	my ($argv, $out) = @_;
+	my ($argv, $out, $err) = @_;
 	my $pid = fork;
 	if (not defined $pid) {
 		die "fork failed: $!"
 	} elsif ($pid == 0) {
 		open STDOUT, ">&", $out;
+		open STDERR, ">&", $err;
 		close $out;
 		exec(@$argv) or die "cannot exec '$argv->[0]': $!"
 	}
@@ -47,12 +48,28 @@ sub xsendfile {
 	copy($in, $out, 4096) or $!{EIO} or die "cannot copy from child: $!";
 }
 
+sub copy_stdio {
+	my ($out, $err) = @_;
+	my $pid = fork;
+	defined $pid or die "fork failed: $!";
+	if (!$pid) {
+		close($out);
+		xsendfile(\*STDERR, $err);
+		exit 0;
+	}
+	close($err);
+	xsendfile(\*STDOUT, $out);
+	finish_child($pid) == 0
+		or exit 1;
+}
+
 if ($#ARGV < 1) {
 	die "usage: test-terminal program args";
 }
-my $master = new IO::Pty;
-my $slave = $master->slave;
-my $pid = start_child(\@ARGV, $slave);
-close $slave;
-xsendfile(\*STDOUT, $master);
+my $master_out = new IO::Pty;
+my $master_err = new IO::Pty;
+my $pid = start_child(\@ARGV, $master_out->slave, $master_err->slave);
+close $master_out->slave;
+close $master_err->slave;
+copy_stdio($master_out, $master_err);
 exit(finish_child($pid));
-- 
1.7.3.1.204.g337d6.dirty
