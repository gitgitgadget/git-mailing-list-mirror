From: Doug Kelly <dougk.ff7@gmail.com>
Subject: [PATCH v4 1/2] t4255: test am submodule with diff.submodule
Date: Wed,  7 Jan 2015 14:13:42 -0600
Message-ID: <1420661623-30692-1-git-send-email-dougk.ff7@gmail.com>
References: <1419635506-5045-1-git-send-email-dougk.ff7@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Doug Kelly <dougk.ff7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 07 21:14:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8wzR-000628-51
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 21:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752455AbbAGUN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 15:13:56 -0500
Received: from mail-ob0-f169.google.com ([209.85.214.169]:64457 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbbAGUNz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 15:13:55 -0500
Received: by mail-ob0-f169.google.com with SMTP id vb8so4958315obc.0
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 12:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IU7jg90Q6iFyYDAEb0u7oZPZyVWxRtFku6eI9aKCM1Y=;
        b=V9GutuWYGcsXvJb7FQFe6B610K9d7FpiQzpCMYeD9xBcDruN4pFVw/boVUe8wi2eYB
         6HK3fV9LqD4GT49PtAdYmbbojhm5rrXjuCXntIjA0HErWheHskLm/5lBWRcr+bQoXa5w
         OSu8C5kbrVjVVFDEvYA+c5apC+Pe+CO09Q8cdKKKk1GN8uKlw9qrDg8OqZVvuaBL8QI5
         3r5wtLJnx41r6CirCk2GZUKrvQFdIXPudCmepXN/YCHWjFhmoI/480B0IeY/Y1rtT1j5
         HRsEyjnEUU3qOKWYNlLl9mlv3619BdECXN/BLQdatuAxAboWxwJBNIclA3UP/Htoz5XR
         JAow==
X-Received: by 10.60.76.10 with SMTP id g10mr3335821oew.0.1420661635336;
        Wed, 07 Jan 2015 12:13:55 -0800 (PST)
Received: from kenshin.dougk-ff7.net (64-151-63-23.static.everestkc.net. [64.151.63.23])
        by mx.google.com with ESMTPSA id vx15sm1470358oeb.6.2015.01.07.12.13.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jan 2015 12:13:54 -0800 (PST)
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1419635506-5045-1-git-send-email-dougk.ff7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262150>

git am will break when using diff.submodule=log; add some test cases
to illustrate this breakage as simply as possible.  There are
currently two ways this can fail:

* With errors ("unrecognized input"), if only change
* Silently (no submodule change), if other files change

Test for both conditions and ensure without diff.submodule this works.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Doug Kelly <dougk.ff7@gmail.com>
---
Updated to remove test_ticks and clean the commit message.

 t/t4255-am-submodule.sh | 70 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/t/t4255-am-submodule.sh b/t/t4255-am-submodule.sh
index 8bde7db..a38c305 100755
--- a/t/t4255-am-submodule.sh
+++ b/t/t4255-am-submodule.sh
@@ -18,4 +18,74 @@ am_3way () {
 KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
 test_submodule_switch "am_3way"
 
+test_expect_success 'setup diff.submodule' '
+	test_commit one &&
+	INITIAL=$(git rev-parse HEAD) &&
+
+	git init submodule &&
+	(
+		cd submodule &&
+		test_commit two &&
+		git rev-parse HEAD >../initial-submodule
+	) &&
+	git submodule add ./submodule &&
+	git commit -m first &&
+
+	(
+		cd submodule &&
+		test_commit three &&
+		git rev-parse HEAD >../first-submodule
+	) &&
+	git add submodule &&
+	git commit -m second &&
+	SECOND=$(git rev-parse HEAD) &&
+
+	(
+		cd submodule &&
+		git mv two.t four.t &&
+		git commit -m "second submodule" &&
+		git rev-parse HEAD >../second-submodule
+	) &&
+	test_commit four &&
+	git add submodule &&
+	git commit --amend --no-edit &&
+	THIRD=$(git rev-parse HEAD) &&
+	git submodule update --init
+'
+
+run_test() {
+	START_COMMIT=$1 &&
+	EXPECT=$2 &&
+	test_might_fail git am --abort &&
+	git reset --hard $START_COMMIT &&
+	rm -f *.patch &&
+	git format-patch -1 &&
+	git reset --hard $START_COMMIT^ &&
+	git submodule update &&
+	git am *.patch &&
+	git submodule update &&
+	git -C submodule rev-parse HEAD >actual &&
+	test_cmp $EXPECT actual
+}
+
+test_expect_success 'diff.submodule unset' '
+	test_unconfig diff.submodule &&
+	run_test $SECOND first-submodule
+'
+
+test_expect_success 'diff.submodule unset with extra file' '
+	test_unconfig diff.submodule &&
+	run_test $THIRD second-submodule
+'
+
+test_expect_failure 'diff.submodule=log' '
+	test_config diff.submodule log &&
+	run_test $SECOND first-submodule
+'
+
+test_expect_failure 'diff.submodule=log with extra file' '
+	test_config diff.submodule log &&
+	run_test $THIRD second-submodule
+'
+
 test_done
-- 
2.0.5
