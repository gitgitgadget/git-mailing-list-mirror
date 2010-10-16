From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 4/8] test_terminal: catch use without TTY prerequisite
Date: Sun, 17 Oct 2010 02:36:59 +0800
Message-ID: <1287254223-4496-5-git-send-email-rctay89@gmail.com>
References: <1287254223-4496-1-git-send-email-rctay89@gmail.com>
 <1287254223-4496-2-git-send-email-rctay89@gmail.com>
 <1287254223-4496-3-git-send-email-rctay89@gmail.com>
 <1287254223-4496-4-git-send-email-rctay89@gmail.com>
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Chase Brammer <cbrammer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 16 20:38:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7Bdu-0002rt-4G
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 20:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753628Ab0JPShj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Oct 2010 14:37:39 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51141 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593Ab0JPShi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Oct 2010 14:37:38 -0400
Received: by mail-pw0-f46.google.com with SMTP id 4so321570pwj.19
        for <git@vger.kernel.org>; Sat, 16 Oct 2010 11:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=6hjggYeGDlcVtkcNql5UoVDh+KbSFMJ02DqJBzME2g0=;
        b=vx6rg2sxaScLyz4iN+HiWRbTBu5a5mFxFS9Ebaak5fNOy2f/Lbs1VWbh93V0RO4X+M
         2dce0rPkfe65lqP5g+J4saA6z8qC5wAEz4hBE0yQynSOYW0PTbdMQaxInegC34XueScA
         20Ql5SBeSS/UeqwXcfEPtqqROYRXP6045klW4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FdbBSfpJzokumkrmofL3qgvEY4iVXquSkT5P/k9xyWuuFMymL/c/y1O504usm14ThA
         xnfo+nz91RgLgCtOQTyDSd8LE9AoLjbRrkFMzi3Db+JvhMdj+vt4zE3vVqtL0sk+/rdR
         2GzdjychdCZm5RKTbfMsMb9h6jUlupWjqK7pU=
Received: by 10.142.70.8 with SMTP id s8mr1843358wfa.155.1287254258186;
        Sat, 16 Oct 2010 11:37:38 -0700 (PDT)
Received: from localhost.localdomain (cm147.zeta152.maxonline.com.sg [116.87.152.147])
        by mx.google.com with ESMTPS id x18sm8029156wfa.23.2010.10.16.11.37.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 Oct 2010 11:37:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
In-Reply-To: <1287254223-4496-4-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159171>

From: Jonathan Nieder <jrnieder@gmail.com>

It is easy to forget to declare the TTY prerequisite when
writing tests on a system where it would always be satisfied
(because IO::Pty is installed; see v1.7.3-rc0~33^2, 2010-08-16
for example).  Automatically detect this problem so there is
no need to remember.

	test_terminal: need to declare TTY prerequisite
	test_must_fail: command not found: test_terminal echo hi

test_terminal returns status 127 in this case to simulate
not being available.

Also replace the SIMPLEPAGERTTY prerequisite on one test with
"SIMPLEPAGER,TTY", since (1) the latter is supported now and
(2) the prerequisite detection relies on the TTY prereq being
explicitly declared.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---

  Rebased on top of Jeff's series, so that lib-terminal's test_terminal is
  changed instead.

 t/lib-terminal.sh |   13 +++++++++++--
 t/t7006-pager.sh  |    7 +------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/t/lib-terminal.sh b/t/lib-terminal.sh
index 3258b8f..5e7ee9a 100644
--- a/t/lib-terminal.sh
+++ b/t/lib-terminal.sh
@@ -15,14 +15,23 @@ test_expect_success 'set up terminal for tests' '
 
 if test -e have_tty
 then
-	test_terminal() { "$@"; }
+	test_terminal_() { "$@"; }
 	test_set_prereq TTY
 elif test -e test_terminal_works
 then
-	test_terminal() {
+	test_terminal_() {
 		"$PERL_PATH" "$TEST_DIRECTORY"/test-terminal.perl "$@"
 	}
 	test_set_prereq TTY
 else
 	say "# no usable terminal, so skipping some tests"
 fi
+
+test_terminal () {
+	if ! test_declared_prereq TTY
+	then
+		echo >&2 'test_terminal: need to declare TTY prerequisite'
+		return 127
+	fi
+	test_terminal_ "$@"
+}
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 17e54d3..5641b59 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -184,11 +184,6 @@ test_expect_success 'color when writing to a file intended for a pager' '
 	colorful colorful.log
 '
 
-if test_have_prereq SIMPLEPAGER && test_have_prereq TTY
-then
-	test_set_prereq SIMPLEPAGERTTY
-fi
-
 # Use this helper to make it easy for the caller of your
 # terminal-using function to specify whether it should fail.
 # If you write
@@ -224,7 +219,7 @@ parse_args() {
 test_default_pager() {
 	parse_args "$@"
 
-	$test_expectation SIMPLEPAGERTTY "$cmd - default pager is used by default" "
+	$test_expectation SIMPLEPAGER,TTY "$cmd - default pager is used by default" "
 		unset PAGER GIT_PAGER;
 		test_might_fail git config --unset core.pager &&
 		rm -f default_pager_used ||
-- 
1.7.2.2.513.ge1ef3
