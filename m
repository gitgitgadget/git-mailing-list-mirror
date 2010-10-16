From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 2/8] tests: test terminal output to both stdout and stderr
Date: Sun, 17 Oct 2010 02:36:57 +0800
Message-ID: <1287254223-4496-3-git-send-email-rctay89@gmail.com>
References: <1287254223-4496-1-git-send-email-rctay89@gmail.com>
 <1287254223-4496-2-git-send-email-rctay89@gmail.com>
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Chase Brammer <cbrammer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 16 20:38:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7Bds-0002rt-Uf
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 20:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550Ab0JPShd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Oct 2010 14:37:33 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38045 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410Ab0JPShb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Oct 2010 14:37:31 -0400
Received: by mail-pz0-f46.google.com with SMTP id 33so271976pzk.19
        for <git@vger.kernel.org>; Sat, 16 Oct 2010 11:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=M7SeV5GoCQBYskkSdqG1i2BUon9GIywh8KoMRaJKmVM=;
        b=YkcQfcgBeT0jTE5316+gawRZSBjg04h7Q3ZYtEk6apJqLz/DVlqhoG7O9Zt1cg7TpQ
         rtVRlwsCd9frELgjpXE7XsEYN058ofeouF9grXTiG4Ly6S8XhUr6U8Bze/Zsr+TcE3W9
         9iDH8M5Q36JkkF0Z7i61SJem6217ICyV5HriI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fM2W5txQ4Tv7xaynuAYc0xM1/rSVQaFyb8MlSa3T9PMN+9IoCYltjmI6aMcdKyn82M
         CQ4qd1JfO8cq9BuI9GEY0FbjTkci/9d6cqWm1IqiU46hBLDrcuRhYAofu1ZFyYl3e0AL
         jilfdA3jPf4E+krJpftrXvSh6E94cyyqEaIwY=
Received: by 10.142.216.2 with SMTP id o2mr1843095wfg.142.1287254251235;
        Sat, 16 Oct 2010 11:37:31 -0700 (PDT)
Received: from localhost.localdomain (cm147.zeta152.maxonline.com.sg [116.87.152.147])
        by mx.google.com with ESMTPS id x18sm8029156wfa.23.2010.10.16.11.37.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 Oct 2010 11:37:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
In-Reply-To: <1287254223-4496-2-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159173>

From: Jeff King <peff@peff.net>

Some outputs (like the pager) care whether stdout is a
terminal. Others (like progress meters) care about stderr.

This patch sets up both. Technically speaking, we could go
further and set up just one (because either the other goes
to a terminal, or because our tests are only interested in
one). This patch does both to keep the interface to
lib-terminal simple.

Signed-off-by: Jeff King <peff@peff.net>
---

  No change.

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
1.7.2.2.513.ge1ef3
