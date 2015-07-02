From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 10/12] t4150: tests for am --[no-]scissors
Date: Fri,  3 Jul 2015 02:16:38 +0800
Message-ID: <1435861000-25278-11-git-send-email-pyokagan@gmail.com>
References: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 20:17:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAj3a-0006YT-6z
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 20:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753094AbbGBSRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 14:17:50 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33539 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754033AbbGBSRh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 14:17:37 -0400
Received: by pdjd13 with SMTP id d13so49200506pdj.0
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 11:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7H2P9Jz08YBVlwNsK/kOUfhe6zBS3Slz2Le/t9eds6Y=;
        b=RKmvR5mQXF4tHcb6dUb1840qMS1D749q+9moplD0kDNPZdGhL/aXlp32uVJsnOtsKH
         rXiOktHyg18rqaVkyFNMnAKAAk/Mltg3wnTLDMavaut9b529f6/HZH3y4YOa1ZwHZHbi
         bKFhxEo0h5g/wp1HGblNlVBERP3LFA4n08vrZpbEG8hGj1wSmcfQ6sCgwsRjjizggm5k
         UvEQf0ajCTd+Ek63iN0NpMGnB/UA/8IIAQaMTEMb1Fqnkj0a0TSEaadrrSxDj19+nS6p
         zRebtbAcMSY8qsc2F251zcFjaRBvxMXb3CItDaJgNyDUk9vsQ9BjBrQQ46sBFv9E/kfd
         T9vw==
X-Received: by 10.68.167.66 with SMTP id zm2mr69301985pbb.164.1435861056308;
        Thu, 02 Jul 2015 11:17:36 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id pr4sm6412670pbb.30.2015.07.02.11.17.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jul 2015 11:17:35 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.81.gfe77482
In-Reply-To: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273264>

Since 017678b (am/mailinfo: Disable scissors processing by default,
2009-08-26), git-am supported the --[no-]scissors option, passing it to
git-mailinfo.

Add tests to ensure that git-am will pass the --scissors option to
git-mailinfo, and that --no-scissors will override the configuration
setting of mailinfo.scissors.

Cc: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t4150-am.sh | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 62b678c..94e7c18 100755
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
@@ -317,6 +344,27 @@ test_expect_success 'am with failing post-applypatch hook' '
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
2.5.0.rc1.81.gfe77482
