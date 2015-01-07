From: Doug Kelly <dougk.ff7@gmail.com>
Subject: [PATCH v5 1/2] t4255: test am submodule with diff.submodule
Date: Wed,  7 Jan 2015 14:32:11 -0600
Message-ID: <1420662732-11972-1-git-send-email-dougk.ff7@gmail.com>
References: <1419635506-5045-1-git-send-email-dougk.ff7@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Doug Kelly <dougk.ff7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 07 21:33:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8xHN-0003HF-Qm
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 21:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754450AbbAGUc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 15:32:29 -0500
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33233 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbbAGUc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 15:32:28 -0500
Received: by mail-oi0-f49.google.com with SMTP id a141so4524695oig.8
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 12:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fpQOW2MQ8WVPQAwJGoPBNYkAUVlEniGNSGIWyA0h8+Q=;
        b=NYoYfV9PWQqbcjA6ZqSOVPzfLD820OYsWOCVqPsxG6vpxd6tAn0sWAFhvI8QbeCiRx
         J718TMUIFDjawXPSo3VNMIsMI+BtsNC1G+Lzg+LmNePjw9Ar9hZi5DnwLrvRnefUU4Qb
         Zr6cT/Kns42v9hIderoCYq6SQPqkodr+rKm09ccOlPO3zX1wJSZiNh3UWl3BNf/JYIxX
         u45XAqn/9dGECE6tyDF5Z2kNbCYwdcOTT9ViOzPm3q7jEePMd2JPNFmRXk42JkrPqR0X
         oTkw5MwgwA++YRA1v3TmImERKExcJ5t66wXqbAi0L5Z4y6BxizOOGaCRo3GI5jdwZQbs
         N3hQ==
X-Received: by 10.182.181.36 with SMTP id dt4mr3277401obc.3.1420662747727;
        Wed, 07 Jan 2015 12:32:27 -0800 (PST)
Received: from kenshin.dougk-ff7.net (64-151-63-23.static.everestkc.net. [64.151.63.23])
        by mx.google.com with ESMTPSA id ox19sm1470496oeb.17.2015.01.07.12.32.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jan 2015 12:32:26 -0800 (PST)
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1419635506-5045-1-git-send-email-dougk.ff7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262158>

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
Added a comment for why test_might_fail is used to abort merges
in progress.

 t/t4255-am-submodule.sh | 72 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/t/t4255-am-submodule.sh b/t/t4255-am-submodule.sh
index 8bde7db..450d261 100755
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
+	# Abort any merges in progress: the previous
+	# test may have failed, and we should clean up.
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
