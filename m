From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/3] test-terminal: give the child an empty stdin TTY
Date: Mon, 12 Dec 2011 19:09:13 +0100
Message-ID: <b97d14da67bd6097e5b04f6ae3057c0f1d536a0b.1323713230.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 12 19:09:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaAJb-00029C-A2
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 19:09:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443Ab1LLSJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 13:09:21 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:53412 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752870Ab1LLSJU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 13:09:20 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Dec
 2011 19:09:15 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Dec
 2011 19:09:17 +0100
X-Mailer: git-send-email 1.7.8.431.g2abf2
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186923>

So far, test-terminal.perl did not care at all about the stdin (that
is, leave it as-is).  This mostly works well, but git-shortlog is a
problem:

* It takes decisions based on isatty(0).  (No test checks this, but
  compare 'git shortlog </dev/null' with 'git shortlog' in a
  terminal.)

* It reads all of stdin if !isatty(0) and no arguments were passed.

Because of the latter, t7006.58ff cause unexpected results if you do:

  git rev-list <range> |
  while read sha; do
    git checkout sha
    make test
  done

If t7006 runs during any 'make test' run, the next 'read sha' will
fail (git-shortlog ate all of stdin already) and the while loop stops
immediately.  In particular, this loop will only ever successfully
test *one* revision.

To fix this, change test-terminal.perl to open a third PTY for stdin,
send an EOF (Ctrl-D) immediately and close it later.  Since this may
not be portable, we use POSIX::Termios to set it to Ctrl-D.

Noticed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/test-terminal.perl |   22 +++++++++++++++++++---
 1 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/t/test-terminal.perl b/t/test-terminal.perl
index ee01eb9..87b5a8c 100755
--- a/t/test-terminal.perl
+++ b/t/test-terminal.perl
@@ -4,14 +4,16 @@
 use warnings;
 use IO::Pty;
 use File::Copy;
+use POSIX ();
 
-# Run @$argv in the background with stdio redirected to $out and $err.
+# Run @$argv in the background with stdio redirected from $in and to $out and $err.
 sub start_child {
-	my ($argv, $out, $err) = @_;
+	my ($argv, $in, $out, $err) = @_;
 	my $pid = fork;
 	if (not defined $pid) {
 		die "fork failed: $!"
 	} elsif ($pid == 0) {
+		open STDIN, "<&", $in;
 		open STDOUT, ">&", $out;
 		open STDERR, ">&", $err;
 		close $out;
@@ -64,13 +66,27 @@ sub copy_stdio {
 		or exit 1;
 }
 
+sub set_default_eof_char {
+	my $fd = fileno shift;
+	my $termios = POSIX::Termios->new;
+	$termios->getattr($fd);
+	$termios->setcc(&POSIX::VEOF, 4);
+	$termios->setattr($fd, &POSIX::TCSANOW)
+		or die "Termios::setattr failed: $!";
+}
+
 if ($#ARGV < 1) {
 	die "usage: test-terminal program args";
 }
+my $master_in = new IO::Pty;
 my $master_out = new IO::Pty;
 my $master_err = new IO::Pty;
-my $pid = start_child(\@ARGV, $master_out->slave, $master_err->slave);
+set_default_eof_char($master_in->slave);
+my $pid = start_child(\@ARGV, $master_in->slave, $master_out->slave, $master_err->slave);
+close $master_in->slave;
 close $master_out->slave;
 close $master_err->slave;
+print $master_in "\cD";
 copy_stdio($master_out, $master_err);
+close $master_in;
 exit(finish_child($pid));
-- 
1.7.8.431.g2abf2
