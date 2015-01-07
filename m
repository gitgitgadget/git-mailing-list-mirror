From: Doug Kelly <dougk.ff7@gmail.com>
Subject: [PATCH v3 1/2] t4255: test am submodule with diff.submodule
Date: Wed,  7 Jan 2015 13:31:44 -0600
Message-ID: <1420659105-26546-1-git-send-email-dougk.ff7@gmail.com>
References: <1419635506-5045-1-git-send-email-dougk.ff7@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Doug Kelly <dougk.ff7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 07 20:32:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8wKi-0000ig-Bq
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 20:31:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754188AbbAGTbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 14:31:51 -0500
Received: from mail-oi0-f49.google.com ([209.85.218.49]:55337 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753730AbbAGTbu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 14:31:50 -0500
Received: by mail-oi0-f49.google.com with SMTP id a141so4287189oig.8
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 11:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lyy5b/apNw7LjS7Opd8EZazR8mdgr2+9I38aCNAjrDQ=;
        b=iTAOpjMx9REIWjCbAsdM6MF1LW/WUOu8Br4uUIMYCznD+L7T029uzCquCx3QZo8iYh
         X5a31v3byTR1ZJP89RMvzl80TNjLfxCQ3itqXKcfv+NtRtRs4kI10n+XtFFDgPTvmWwQ
         jP4ZUmD8CbF4B5ZrPv7j57SuL1I+DAtR8FRoIwxt23IcU7AWcKU9xkaRF0Q6iyAtB+ys
         yupbOgGaS+BdjlRc+ige9hf1SHkO7kIXymBdxHr7BeXbf+4o5kJSbuZwWkiIqTQsMaom
         0vMil/AqHBjHKpLPAHZcSqKvvBuieCWL0oCFob2L44lNUBxNSeBgEcwAw8kMtNGiFTyZ
         0qxw==
X-Received: by 10.60.132.74 with SMTP id os10mr3107689oeb.63.1420659109860;
        Wed, 07 Jan 2015 11:31:49 -0800 (PST)
Received: from kenshin.dougk-ff7.net (64-151-63-23.static.everestkc.net. [64.151.63.23])
        by mx.google.com with ESMTPSA id uv10sm1424290obc.27.2015.01.07.11.31.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jan 2015 11:31:48 -0800 (PST)
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1419635506-5045-1-git-send-email-dougk.ff7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262145>

git am will break when using diff.submodule=log; add some test cases
to illustrate this breakage as simply as possible.  There are
currently two ways this can fail:

* With errors ("unrecognized input"), if only change
* Silently (no submodule change), if other files change

Test for both conditions and ensure without diff.submodule this works.

Signed-off-by: Doug Kelly <dougk.ff7@gmail.com>
Thanks-to: Eric Sunshine <sunshine@sunshineco.com>
Thanks-to: Junio C Hamano <gitster@pobox.com>
---
Updated with Eric Sunshine's comments and changes to reduce complexity,
and also changed to include Junio's suggestions for using test_config,
test_unconfig, and test_might_fail (since we don't know if a previous
am failed or not -- we always want to clean up first).

 t/t4255-am-submodule.sh | 72 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/t/t4255-am-submodule.sh b/t/t4255-am-submodule.sh
index 8bde7db..523accf 100755
--- a/t/t4255-am-submodule.sh
+++ b/t/t4255-am-submodule.sh
@@ -18,4 +18,76 @@ am_3way () {
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
+	test_tick &&
+	git commit -m second &&
+	SECOND=$(git rev-parse HEAD) &&
+
+	(
+		cd submodule &&
+		git mv two.t four.t &&
+		test_tick &&
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
