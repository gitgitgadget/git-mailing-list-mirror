From: Caleb Thompson <cjaysson@gmail.com>
Subject: [PATCH v3 4/5] commit test: test_set_editor in each test
Date: Mon, 26 May 2014 13:56:25 -0500
Message-ID: <1401130586-93105-5-git-send-email-caleb@calebthompson.io>
References: <20140525062427.GA94219@sirius.att.net>
 <1401130586-93105-1-git-send-email-caleb@calebthompson.io>
Cc: Jeff King <peff@peff.net>, Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 26 20:57:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wp04x-0001UC-7R
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 20:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbaEZS4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 14:56:48 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:64059 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbaEZS4p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 14:56:45 -0400
Received: by mail-ig0-f176.google.com with SMTP id hl10so255761igb.15
        for <git@vger.kernel.org>; Mon, 26 May 2014 11:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q0elCu5RE4bCYfYvMzg7VO0fA1VGu3stbIKyf3Tmnf8=;
        b=SMPil+FGfNUmIiwAjhtjcXHB8wmFeFKSgQPSfvp21trA1IZJz6E3VJq9r7hYdSBiaa
         gwVAgwvw3l7Hh9I8ADsHGXPcALSWW2PXMmG8OVWzeT0Ey2GHApDM2vhR1JHjYzS6znzw
         61cFciT2DJvcuZWcgI5JjmxA/H3+VrdjpF8JLTkchBTTMHWbHLo84BwbJlIT/nkDrb3j
         KPKBLh7JXkpAdgBtgCz5DpQM8fGSOr+N0Xx+ZVGQaSpzLr9Sl6tcQ9XinL72j78iU42t
         Zz1IUNHa2DSTI3S+AtEGW/KbZY3m4Qn/v0rVRpikL9rf/PcuusUIk+O/YqvF6GtVXGDE
         lebA==
X-Received: by 10.42.35.15 with SMTP id o15mr4219027icd.90.1401130604351;
        Mon, 26 May 2014 11:56:44 -0700 (PDT)
Received: from sirius.att.net (107-216-44-113.lightspeed.austtx.sbcglobal.net. [107.216.44.113])
        by mx.google.com with ESMTPSA id ql7sm1708857igc.19.2014.05.26.11.56.43
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 11:56:43 -0700 (PDT)
X-Google-Original-From: Caleb Thompson <caleb@calebthompson.io>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1401130586-93105-1-git-send-email-caleb@calebthompson.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250111>

t/t7507-commit-verbose.sh was using a global test_set_editor call to
build its environment.

Rather than building global state with test_set_editor at the beginning
of the file, move test_set_editor calls into each test.

Besides being inline with current practices, it also allows the tests
which required GIT_EDITOR=cat to avoid using a subshell and simplify
their logic.

Signed-off-by: Caleb Thompson <caleb@calebthompson.io>
---
 t/t7507-commit-verbose.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index e62d921..310b68b 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -6,7 +6,6 @@ test_description='verbose commit template'
 write_script check-for-diff <<-EOF
 	exec grep '^diff --git' "\$1"
 EOF
-test_set_editor "$(pwd)/check-for-diff"
 
 cat >message <<'EOF'
 subject
@@ -21,10 +20,12 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'initial commit shows verbose diff' '
+	test_set_editor "$(pwd)/check-for-diff" &&
 	git commit --amend -v
 '
 
 test_expect_success 'second commit' '
+	test_set_editor "$(pwd)/check-for-diff" &&
 	echo content modified >file &&
 	git add file &&
 	git commit -F message
@@ -36,11 +37,13 @@ check_message() {
 }
 
 test_expect_success 'verbose diff is stripped out' '
+	test_set_editor "$(pwd)/check-for-diff" &&
 	git commit --amend -v &&
 	check_message message
 '
 
 test_expect_success 'verbose diff is stripped out (mnemonicprefix)' '
+	test_set_editor "$(pwd)/check-for-diff" &&
 	test_config diff.mnemonicprefix true &&
 	git commit --amend -v &&
 	check_message message
@@ -59,16 +62,19 @@ index 0000000..f95c11d
 EOF
 
 test_expect_success 'diff in message is retained without -v' '
+	test_set_editor "$(pwd)/check-for-diff" &&
 	git commit --amend -F diff &&
 	check_message diff
 '
 
 test_expect_success 'diff in message is retained with -v' '
+	test_set_editor "$(pwd)/check-for-diff" &&
 	git commit --amend -F diff -v &&
 	check_message diff
 '
 
 test_expect_success 'submodule log is stripped out too with -v' '
+	test_set_editor "$(pwd)/check-for-diff" &&
 	test_config diff.submodule log &&
 	git submodule add ./. sub &&
 	git commit -m "sub added" &&
@@ -77,20 +83,14 @@ test_expect_success 'submodule log is stripped out too with -v' '
 		echo "more" >>file &&
 		git commit -a -m "submodule commit"
 	) &&
-	(
-		GIT_EDITOR=cat &&
-		export GIT_EDITOR &&
-		test_must_fail git commit -a -v 2>err
-	) &&
+	test_set_editor cat &&
+	test_must_fail git commit -a -v 2>err
 	test_i18ngrep "Aborting commit due to empty commit message." err
 '
 
 test_expect_success 'verbose diff is stripped out with set core.commentChar' '
-	(
-		GIT_EDITOR=cat &&
-		export GIT_EDITOR &&
-		test_must_fail git -c core.commentchar=";" commit -a -v 2>err
-	) &&
+	test_set_editor cat &&
+	test_must_fail git -c core.commentchar=";" commit -a -v 2>err
 	test_i18ngrep "Aborting commit due to empty commit message." err
 '
 
-- 
1.9.3
