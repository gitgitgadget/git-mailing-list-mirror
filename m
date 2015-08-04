From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 1/3] test_terminal: redirect child process' stdin to a pty
Date: Tue,  4 Aug 2015 22:08:49 +0800
Message-ID: <1438697331-29948-2-git-send-email-pyokagan@gmail.com>
References: <20150728164311.GA1948@yoshi.chippynet.com>
 <1438697331-29948-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Paul Tan <pyokagan@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 16:09:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMcu0-0001O0-Ed
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 16:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934293AbbHDOJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 10:09:05 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33586 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934241AbbHDOJC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 10:09:02 -0400
Received: by padck2 with SMTP id ck2so9694970pad.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 07:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jhcI1/Ep+Pjg3fmC9CGwLlMg/7StBmTHedhRtIdLLc8=;
        b=Xsyr16OUNcVtVBmR9XtIkpPMrJuDFMc0r/2K3nbGPMm9IkHyrM3kNGHxV80ysQuiyP
         h4abQFhR7QhQlA+QKbEWYWupLCTu6i6V8Wpg7i+xQhYwSDzblgzr6Yy6PLCT5S1dT2m2
         L/QHQVRFEiNuckpSOcYvYpkqkYDkIrNWJJ+KIj3kl5N4q18wqIlFZVSgfLtj+BDlJRxN
         pwijlyoVsys6pT/YdXnBXNzuN20y4hnEJgUXLBZKyonLasH40TzFygXZ0kSQ2lQIsvOs
         4fvhISp6vz5/fvhhuYEFghnRE3bG2t9BKWNTvtksbo9/ljQ/Km+zie0uKpLPyMSSQjQp
         AA/w==
X-Received: by 10.66.222.161 with SMTP id qn1mr8434420pac.66.1438697342500;
        Tue, 04 Aug 2015 07:09:02 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id qc9sm561141pab.18.2015.08.04.07.08.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 07:09:01 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438697331-29948-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275323>

When resuming, git-am detects if we are trying to feed it patches or not
by checking if stdin is a TTY.

However, the test library redirects stdin to /dev/null. This makes it
difficult, for instance, to test the behavior of "git am -3" when
resuming, as git-am will think we are trying to feed it patches and
error out.

Support this use case by extending test-terminal.perl to create a
pseudo-tty for the child process' standard input as well.

Note that due to the way the code is structured, the child's stdin
pseudo-tty will be closed when we finish reading from our stdin. This
means that in the common case, where our stdin is attached to /dev/null,
the child's stdin pseudo-tty will be closed immediately. Some operations
like isatty(), which git-am uses, require the file descriptor to be
open, and hence if the success of the command depends on such functions,
test_terminal's stdin should be redirected to a source with large amount
of data to ensure that the child's stdin is not closed, e.g.

	test_terminal git am --3way </dev/zero

Cc: Jonathan Nieder <jrnieder@gmail.com>
Cc: Jeff King <peff@peff.net>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/test-terminal.perl | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/t/test-terminal.perl b/t/test-terminal.perl
index 1fb373f..f6fc9ae 100755
--- a/t/test-terminal.perl
+++ b/t/test-terminal.perl
@@ -5,15 +5,17 @@ use warnings;
 use IO::Pty;
 use File::Copy;
 
-# Run @$argv in the background with stdio redirected to $out and $err.
+# Run @$argv in the background with stdio redirected to $in, $out and $err.
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
+		close $in;
 		close $out;
 		exec(@$argv) or die "cannot exec '$argv->[0]': $!"
 	}
@@ -50,14 +52,23 @@ sub xsendfile {
 }
 
 sub copy_stdio {
-	my ($out, $err) = @_;
+	my ($in, $out, $err) = @_;
 	my $pid = fork;
+	if (!$pid) {
+		close($out);
+		close($err);
+		xsendfile($in, \*STDIN);
+		exit 0;
+	}
+	$pid = fork;
 	defined $pid or die "fork failed: $!";
 	if (!$pid) {
+		close($in);
 		close($out);
 		xsendfile(\*STDERR, $err);
 		exit 0;
 	}
+	close($in);
 	close($err);
 	xsendfile(\*STDOUT, $out);
 	finish_child($pid) == 0
@@ -67,14 +78,18 @@ sub copy_stdio {
 if ($#ARGV < 1) {
 	die "usage: test-terminal program args";
 }
+my $master_in = new IO::Pty;
 my $master_out = new IO::Pty;
 my $master_err = new IO::Pty;
+$master_in->set_raw();
 $master_out->set_raw();
 $master_err->set_raw();
+$master_in->slave->set_raw();
 $master_out->slave->set_raw();
 $master_err->slave->set_raw();
-my $pid = start_child(\@ARGV, $master_out->slave, $master_err->slave);
+my $pid = start_child(\@ARGV, $master_in->slave, $master_out->slave, $master_err->slave);
+close $master_in->slave;
 close $master_out->slave;
 close $master_err->slave;
-copy_stdio($master_out, $master_err);
+copy_stdio($master_in, $master_out, $master_err);
 exit(finish_child($pid));
-- 
2.5.0.280.gd88bd6e
