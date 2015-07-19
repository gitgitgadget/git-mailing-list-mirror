From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 10/12] t4150: tests for am --[no-]scissors
Date: Sun, 19 Jul 2015 23:49:16 +0800
Message-ID: <1437320958-11192-11-git-send-email-pyokagan@gmail.com>
References: <1437320958-11192-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 17:50:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGqqs-0005oa-8B
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 17:50:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753859AbbGSPt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 11:49:59 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:33636 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753853AbbGSPt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 11:49:57 -0400
Received: by pdbnt7 with SMTP id nt7so18596135pdb.0
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 08:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FW4aVXvv1MfvTwDKeZbJBdqzc0PqdHAr95gLpphvkTo=;
        b=Fhf1acXUxN/WViMnkaFf4qrLKHbeVxEBpG1kKubw0B7jt3yLdQ64JIuV8TiogXCfjT
         R6x/plg8XfOCwUhBaFJehWhPZ39bmeK+aB9nKNr5H4Z8cqhI6hK/+aA9mmNr9Deytt0Q
         zzcuWUE3tlLW7R6jorhEwJvVdD6Yh9Y69sMRSEixD4843DUhm2SLRMJvM8lrmuNVAErZ
         KI6YT8X1YxvR60MABg05lUSi8Iyv/PKgWXaBM7hTvyONBxAe7YXJY66KshJmlt8QFMn2
         dRWR6XJO3v+aJzSzyEnLzg+GN5ym3G4Ab6GsDb6LhANed1bXDDirwCHoehQi93uqabjR
         gxjQ==
X-Received: by 10.66.139.138 with SMTP id qy10mr50304036pab.30.1437320997152;
        Sun, 19 Jul 2015 08:49:57 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id j9sm17216516pdl.65.2015.07.19.08.49.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 08:49:56 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gf2a5fc6
In-Reply-To: <1437320958-11192-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274222>

Since 017678b (am/mailinfo: Disable scissors processing by default,
2009-08-26), git-am supported the --[no-]scissors option, passing it to
git-mailinfo.

Add tests to ensure that git-am will pass the --scissors option to
git-mailinfo, and that --no-scissors will override the configuration
setting of mailinfo.scissors.

Reviewed-by: Stefan Beller <sbeller@google.com>
Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t4150-am.sh | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 7494240..67fbf0e 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -67,6 +67,19 @@ test_expect_success 'setup: messages' '
 
 	EOF
 
+	cat >scissors-msg <<-\EOF &&
+	Test git-am with scissors line
+
+	This line should be included in the commit message.
+	EOF
+
+	cat - scissors-msg >no-scissors-msg <<-\EOF &&
+	This line should not be included in the commit message with --scissors enabled.
+
+	 - - >8 - - remove everything above this line - - >8 - -
+
+	EOF
+
 	signoff="Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
 '
 
@@ -105,6 +118,20 @@ test_expect_success setup '
 		git format-patch --stdout first | sed -e "1d"
 	} > patch1-ws.eml &&
 
+	echo scissors-file >scissors-file &&
+	git add scissors-file &&
+	git commit -F scissors-msg &&
+	git tag scissors &&
+	git format-patch --stdout scissors^ >scissors-patch.eml &&
+	git reset --hard HEAD^ &&
+
+	echo no-scissors-file >no-scissors-file &&
+	git add no-scissors-file &&
+	git commit -F no-scissors-msg &&
+	git tag no-scissors &&
+	git format-patch --stdout no-scissors^ >no-scissors-patch.eml &&
+	git reset --hard HEAD^ &&
+
 	sed -n -e "3,\$p" msg >file &&
 	git add file &&
 	test_tick &&
@@ -305,6 +332,27 @@ test_expect_success 'am with failing post-applypatch hook' '
 	test_cmp head.expected head.actual
 '
 
+test_expect_success 'am --scissors cuts the message at the scissors line' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout second &&
+	git am --scissors scissors-patch.eml &&
+	test_path_is_missing .git/rebase-apply &&
+	git diff --exit-code scissors &&
+	test_cmp_rev scissors HEAD
+'
+
+test_expect_success 'am --no-scissors overrides mailinfo.scissors' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout second &&
+	test_config mailinfo.scissors true &&
+	git am --no-scissors no-scissors-patch.eml &&
+	test_path_is_missing .git/rebase-apply &&
+	git diff --exit-code no-scissors &&
+	test_cmp_rev no-scissors HEAD
+'
+
 test_expect_success 'setup: new author and committer' '
 	GIT_AUTHOR_NAME="Another Thor" &&
 	GIT_AUTHOR_EMAIL="a.thor@example.com" &&
-- 
2.5.0.rc2.110.gf2a5fc6
