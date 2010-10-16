From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 1/8] tests: factor out terminal handling from t7006
Date: Sun, 17 Oct 2010 02:36:56 +0800
Message-ID: <1287254223-4496-2-git-send-email-rctay89@gmail.com>
References: <1287254223-4496-1-git-send-email-rctay89@gmail.com>
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Chase Brammer <cbrammer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 16 20:37:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7BdM-0002cP-Iv
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 20:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500Ab0JPSh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Oct 2010 14:37:29 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38045 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410Ab0JPSh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Oct 2010 14:37:28 -0400
Received: by pzk33 with SMTP id 33so271976pzk.19
        for <git@vger.kernel.org>; Sat, 16 Oct 2010 11:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=2tDt60YBHeWFLogxu8O21wXtkz7f6y86GR8HmwkoUvE=;
        b=kbfw6s8qq5Z0U6YmL2P+wxDz4msqDckVs5E2NRCZUZD4mDx/MuBPx3Z+ez4RN1ADmY
         1ci8W5EJVGx+SStuVlFE5C0Pbe63xNVyjN0YtMTFX7eWLPiBLiO36w+2WwhGlquQPShy
         82OO1cP6LMgfW5EEa08SkGd0tlz13eCN5C59E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=W34H8Sh9wVU7xOwxGKF9a8/HXFiHBlG1Lq/IT2DQe8eNyC4HC4+3miDMkjsuxuMQcI
         bUekuX9S1MjBbrW4T8xLJRTxl4peukJySX9p7iassy59QvCsZMFxa9e2TTMKJ82HMziE
         kf/+7srv2NzRhqTeSyIhjG1TK2/NfjIXHluiY=
Received: by 10.142.14.9 with SMTP id 9mr1848527wfn.136.1287254247701;
        Sat, 16 Oct 2010 11:37:27 -0700 (PDT)
Received: from localhost.localdomain (cm147.zeta152.maxonline.com.sg [116.87.152.147])
        by mx.google.com with ESMTPS id x18sm8029156wfa.23.2010.10.16.11.37.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 Oct 2010 11:37:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
In-Reply-To: <1287254223-4496-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159170>

From: Jeff King <peff@peff.net>

Other tests besides the pager ones may want to check how we handle
output to a terminal. This patch makes the code reusable.

Signed-off-by: Jeff King <peff@peff.net>
---

  No change.

 t/lib-terminal.sh          |   28 +++++++++++++++++++++
 t/t7006-pager.sh           |   31 +----------------------
 t/t7006/test-terminal.perl |   58 --------------------------------------------
 t/test-terminal.perl       |   58 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 87 insertions(+), 88 deletions(-)
 create mode 100644 t/lib-terminal.sh
 delete mode 100755 t/t7006/test-terminal.perl
 create mode 100755 t/test-terminal.perl

diff --git a/t/lib-terminal.sh b/t/lib-terminal.sh
new file mode 100644
index 0000000..6fc33db
--- /dev/null
+++ b/t/lib-terminal.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+
+test_expect_success 'set up terminal for tests' '
+	if test -t 1
+	then
+		>stdout_is_tty
+	elif
+		test_have_prereq PERL &&
+		"$PERL_PATH" "$TEST_DIRECTORY"/test-terminal.perl \
+			sh -c "test -t 1"
+	then
+		>test_terminal_works
+	fi
+'
+
+if test -e stdout_is_tty
+then
+	test_terminal() { "$@"; }
+	test_set_prereq TTY
+elif test -e test_terminal_works
+then
+	test_terminal() {
+		"$PERL_PATH" "$TEST_DIRECTORY"/test-terminal.perl "$@"
+	}
+	test_set_prereq TTY
+else
+	say "# no usable terminal, so skipping some tests"
+fi
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index fb744e3..17e54d3 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -4,42 +4,13 @@ test_description='Test automatic use of a pager.'
 
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-pager.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
 
 cleanup_fail() {
 	echo >&2 cleanup failed
 	(exit 1)
 }
 
-test_expect_success 'set up terminal for tests' '
-	rm -f stdout_is_tty ||
-	cleanup_fail &&
-
-	if test -t 1
-	then
-		>stdout_is_tty
-	elif
-		test_have_prereq PERL &&
-		"$PERL_PATH" "$TEST_DIRECTORY"/t7006/test-terminal.perl \
-			sh -c "test -t 1"
-	then
-		>test_terminal_works
-	fi
-'
-
-if test -e stdout_is_tty
-then
-	test_terminal() { "$@"; }
-	test_set_prereq TTY
-elif test -e test_terminal_works
-then
-	test_terminal() {
-		"$PERL_PATH" "$TEST_DIRECTORY"/t7006/test-terminal.perl "$@"
-	}
-	test_set_prereq TTY
-else
-	say "# no usable terminal, so skipping some tests"
-fi
-
 test_expect_success 'setup' '
 	unset GIT_PAGER GIT_PAGER_IN_USE;
 	test_might_fail git config --unset core.pager &&
diff --git a/t/t7006/test-terminal.perl b/t/t7006/test-terminal.perl
deleted file mode 100755
index 73ff809..0000000
--- a/t/t7006/test-terminal.perl
+++ /dev/null
@@ -1,58 +0,0 @@
-#!/usr/bin/perl
-use strict;
-use warnings;
-use IO::Pty;
-use File::Copy;
-
-# Run @$argv in the background with stdout redirected to $out.
-sub start_child {
-	my ($argv, $out) = @_;
-	my $pid = fork;
-	if (not defined $pid) {
-		die "fork failed: $!"
-	} elsif ($pid == 0) {
-		open STDOUT, ">&", $out;
-		close $out;
-		exec(@$argv) or die "cannot exec '$argv->[0]': $!"
-	}
-	return $pid;
-}
-
-# Wait for $pid to finish.
-sub finish_child {
-	# Simplified from wait_or_whine() in run-command.c.
-	my ($pid) = @_;
-
-	my $waiting = waitpid($pid, 0);
-	if ($waiting < 0) {
-		die "waitpid failed: $!";
-	} elsif ($? & 127) {
-		my $code = $? & 127;
-		warn "died of signal $code";
-		return $code - 128;
-	} else {
-		return $? >> 8;
-	}
-}
-
-sub xsendfile {
-	my ($out, $in) = @_;
-
-	# Note: the real sendfile() cannot read from a terminal.
-
-	# It is unspecified by POSIX whether reads
-	# from a disconnected terminal will return
-	# EIO (as in AIX 4.x, IRIX, and Linux) or
-	# end-of-file.  Either is fine.
-	copy($in, $out, 4096) or $!{EIO} or die "cannot copy from child: $!";
-}
-
-if ($#ARGV < 1) {
-	die "usage: test-terminal program args";
-}
-my $master = new IO::Pty;
-my $slave = $master->slave;
-my $pid = start_child(\@ARGV, $slave);
-close $slave;
-xsendfile(\*STDOUT, $master);
-exit(finish_child($pid));
diff --git a/t/test-terminal.perl b/t/test-terminal.perl
new file mode 100755
index 0000000..73ff809
--- /dev/null
+++ b/t/test-terminal.perl
@@ -0,0 +1,58 @@
+#!/usr/bin/perl
+use strict;
+use warnings;
+use IO::Pty;
+use File::Copy;
+
+# Run @$argv in the background with stdout redirected to $out.
+sub start_child {
+	my ($argv, $out) = @_;
+	my $pid = fork;
+	if (not defined $pid) {
+		die "fork failed: $!"
+	} elsif ($pid == 0) {
+		open STDOUT, ">&", $out;
+		close $out;
+		exec(@$argv) or die "cannot exec '$argv->[0]': $!"
+	}
+	return $pid;
+}
+
+# Wait for $pid to finish.
+sub finish_child {
+	# Simplified from wait_or_whine() in run-command.c.
+	my ($pid) = @_;
+
+	my $waiting = waitpid($pid, 0);
+	if ($waiting < 0) {
+		die "waitpid failed: $!";
+	} elsif ($? & 127) {
+		my $code = $? & 127;
+		warn "died of signal $code";
+		return $code - 128;
+	} else {
+		return $? >> 8;
+	}
+}
+
+sub xsendfile {
+	my ($out, $in) = @_;
+
+	# Note: the real sendfile() cannot read from a terminal.
+
+	# It is unspecified by POSIX whether reads
+	# from a disconnected terminal will return
+	# EIO (as in AIX 4.x, IRIX, and Linux) or
+	# end-of-file.  Either is fine.
+	copy($in, $out, 4096) or $!{EIO} or die "cannot copy from child: $!";
+}
+
+if ($#ARGV < 1) {
+	die "usage: test-terminal program args";
+}
+my $master = new IO::Pty;
+my $slave = $master->slave;
+my $pid = start_child(\@ARGV, $slave);
+close $slave;
+xsendfile(\*STDOUT, $master);
+exit(finish_child($pid));
-- 
1.7.2.2.513.ge1ef3
