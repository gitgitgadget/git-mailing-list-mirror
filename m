From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] contrib/subtree: ignore log.date configuration
Date: Tue, 21 Jul 2015 16:59:12 -0700
Message-ID: <1437523152-28911-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Bryan Jacobs <b@q3q.us>,
	Charles Bailey <cbailey32@bloomberg.net>,
	Danny Lin <danny0838@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 01:59:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHhRS-0005aG-M0
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 01:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934084AbbGUX7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 19:59:16 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34310 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933665AbbGUX7P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 19:59:15 -0400
Received: by pacan13 with SMTP id an13so129382166pac.1
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 16:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Xxdv92WrbTSBP7yQCYDD4uyXsGMJawjSkHPfM3PpUB8=;
        b=QfeVoRpGNIe1wGnHChJChBJqwN8Esg7768Ngq9HswdhcOm+nnVzGU7pMo7+qs01MCx
         /C99jXTRZJ6X3TNcLe+RB4uT/Rnt3vmL5/7Nn6R5VY27d4Erp9DRHHIZ11bXkCoE8y7O
         riuuEY8R150YEBmrksmTQrztDdn9S6PgLfnXnwVKsDHn4mjInS1BvcHHIH74zJWAs/Ac
         9KdyXBV3b75p59EcYgZ7r8wm0sUnAJE54SYVUUCjdGhLCMOOhajrDAUPf8/OOgt+23qi
         Ozvc5LWG2FJbXgx1EJhitYKMjx3E80oUglFYWDl7COD9JBBTVHoRRhIRS4z0ITriJUfG
         bedg==
X-Received: by 10.70.90.193 with SMTP id by1mr25016903pdb.80.1437523154410;
        Tue, 21 Jul 2015 16:59:14 -0700 (PDT)
Received: from raptor.disneyanimation.com (w.disneyanimation.com. [198.187.190.241])
        by smtp.gmail.com with ESMTPSA id to5sm29704769pac.33.2015.07.21.16.59.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Jul 2015 16:59:13 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274434>

git-subtree's log format string uses "%ad" and "%cd", which
respect the user's configured log.date value.

This is problematic for git-subtree because it needs to use real
dates so that copied commits come through unchanged.

Add a test and tweak the format strings to use %aD and %cD
so that the default date format is used instead.

Reported-by: Bryan Jacobs <b@q3q.us>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 contrib/subtree/git-subtree.sh     | 2 +-
 contrib/subtree/t/t7900-subtree.sh | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 07bd77c..9f06571 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -305,7 +305,7 @@ copy_commit()
 	# We're going to set some environment vars here, so
 	# do it in a subshell to get rid of them safely later
 	debug copy_commit "{$1}" "{$2}" "{$3}"
-	git log -1 --pretty=format:'%an%n%ae%n%ad%n%cn%n%ce%n%cd%n%B' "$1" |
+	git log -1 --pretty=format:'%an%n%ae%n%aD%n%cn%n%ce%n%cD%n%B' "$1" |
 	(
 		read GIT_AUTHOR_NAME
 		read GIT_AUTHOR_EMAIL
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index bd3df97..cd2dfe7 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -94,6 +94,11 @@ test_expect_success 'add sub3' '
 # Back to mainline
 cd ..
 
+# Enable log.date=relative to catch errors
+test_expect_success 'enable log.date=relative to catch error' '
+	git config log.date relative
+'
+
 test_expect_success 'add main4' '
 	create main4 &&
 	git commit -m "main4" &&
-- 
2.5.0.rc3
