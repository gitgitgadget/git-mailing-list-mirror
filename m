From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2] contrib/subtree: ignore log.date configuration
Date: Tue, 21 Jul 2015 17:01:02 -0700
Message-ID: <1437523262-29130-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Bryan Jacobs <b@q3q.us>,
	Charles Bailey <cbailey32@bloomberg.net>,
	Danny Lin <danny0838@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 02:01:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHhTI-0006WX-Eq
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 02:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934175AbbGVABJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 20:01:09 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:32850 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934166AbbGVABE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 20:01:04 -0400
Received: by padck2 with SMTP id ck2so127585125pad.0
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 17:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=m3lsKf0ZImyn74fw7ZF6/ce9+WQ2UnZyL+QbtzbNbjY=;
        b=JojlGrx+M/x+g8y6qJirnmQ8ZpazPSWH4Km5EuhAiZ2dkQNc8AOvjXJKVu0IT4RC1f
         oKUVW5GE8vTHfO0itIHHd8IqSHwlKWP/JPhvcM2kjWmM8uVEqHVV9U582g1msbj2Ryvu
         Rw6B8BlYsG/nE+kTwra9fZDxqpHkydPRP0e5Vo6RC/+YGw435gkkPR/PgRS1LwHM10HE
         GzPa67Nk6OeQ3OZ8l/EN5GK4lzlPUB8tlDrm4zUyxjkVfSEMmBqogRigj2vvxhYU7+bg
         Kghfsd1wG2lnA7bCnQNz75/uWrw3TkR5utg4Z6/NqqHqBcGpMoKRZozdsNo6V5KuxFez
         eg/Q==
X-Received: by 10.66.63.71 with SMTP id e7mr77042975pas.57.1437523264317;
        Tue, 21 Jul 2015 17:01:04 -0700 (PDT)
Received: from raptor.disneyanimation.com (w.disneyanimation.com. [198.187.190.241])
        by smtp.gmail.com with ESMTPSA id vr2sm6667409pab.26.2015.07.21.17.01.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Jul 2015 17:01:03 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274435>

git-subtree's log format string uses "%ad" and "%cd", which
respect the user's configured log.date value.

This is problematic for git-subtree because it needs to use real
dates so that copied commits come through unchanged.

Add a test and tweak the format strings to use %aD and %cD
so that the default date format is used instead.

Reported-by: Bryan Jacobs <b@q3q.us>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
Please ignore the previous patch -- it had a stray comment in the
test code that is not present in this version.

 contrib/subtree/git-subtree.sh     | 2 +-
 contrib/subtree/t/t7900-subtree.sh | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

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
index bd3df97..9051982 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -94,6 +94,10 @@ test_expect_success 'add sub3' '
 # Back to mainline
 cd ..
 
+test_expect_success 'enable log.date=relative to catch errors' '
+	git config log.date relative
+'
+
 test_expect_success 'add main4' '
 	create main4 &&
 	git commit -m "main4" &&
-- 
2.5.0.rc3
