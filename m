Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B19C1FCA9
	for <e@80x24.org>; Sun, 11 Sep 2016 20:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754058AbcIKUc2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 16:32:28 -0400
Received: from forward12j.cmail.yandex.net ([5.255.227.176]:43875 "EHLO
        forward12j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751602AbcIKUcZ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Sep 2016 16:32:25 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Sep 2016 16:32:24 EDT
Received: from smtp3j.mail.yandex.net (smtp3j.mail.yandex.net [IPv6:2a02:6b8:0:801:1::12])
        by forward12j.cmail.yandex.net (Yandex) with ESMTP id 8721C20E85
        for <git@vger.kernel.org>; Sun, 11 Sep 2016 23:25:09 +0300 (MSK)
Received: from smtp3j.mail.yandex.net (localhost.localdomain [127.0.0.1])
        by smtp3j.mail.yandex.net (Yandex) with ESMTP id 10D9A380C3A;
        Sun, 11 Sep 2016 23:25:08 +0300 (MSK)
Received: by smtp3j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id OWAhuZ797V-P7oGaMH4;
        Sun, 11 Sep 2016 23:25:08 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=filippov.me; s=mail; t=1473625508;
        bh=pgpTFApnpDKPGJ3Xr0Ufz+wVLqy8nKs2CJSl/9di0HU=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=ai4rM12iqulHfbsdw2ZtwUffreNXk4iwFlty9Ul4+Ur8zANsH1k5nE0ibeQcAvpdJ
         kMWGXxGhQL9wanj5ZLNa/qM92dAQ0QfMKx7whi41S/A2h07CgcujfmIQ673YKqx5Br
         hixUTy84x2dTg39P1WbbHvQC6JpbFDFtATB/jqu0=
Authentication-Results: smtp3j.mail.yandex.net; dkim=pass header.i=@filippov.me
X-Yandex-Suid-Status: 1 0,1 1130000020865541
From:   Mikhail Filippov <mikhail@filippov.me>
To:     git@vger.kernel.org
Cc:     Mikhail Filippov <mikhail@filippov.me>
Subject: [PATCH] Do not record unstaged deleted file upon recursive merge if file was moved outside of working tree with enabled sparse-checkout.
Date:   Sun, 11 Sep 2016 23:25:05 +0300
Message-Id: <1473625505-7641-1-git-send-email-mikhail@filippov.me>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 merge-recursive.c                    |  9 +++++---
 t/t6042-merge-rename-corner-cases.sh | 42 ++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index e349126..25dc701 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1724,9 +1724,12 @@ static int merge_content(struct merge_options *o,
 		 */
 		path_renamed_outside_HEAD = !path2 || !strcmp(path, path2);
 		if (!path_renamed_outside_HEAD) {
-			add_cacheinfo(o, mfi.mode, &mfi.oid, path,
-				      0, (!o->call_depth), 0);
-			return mfi.clean;
+			struct stat st;
+			if (lstat(path, &st) == 0) {
+				add_cacheinfo(o, mfi.mode, &mfi.oid, path,
+					      0, (!o->call_depth), 0);
+				return mfi.clean;
+			}
 		}
 	} else
 		output(o, 2, _("Auto-merging %s"), path);
diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index 411550d..2073e49 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -575,4 +575,46 @@ test_expect_success 'rename/rename/add-dest merge still knows about conflicting
 	test ! -f c
 '
 
+test_expect_success 'move file/sparse-checkout/merge should not delete moved file' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	echo output >.gitignore &&
+	echo .gitignore >>.gitignore &&
+
+	echo b1 >b1 &&
+	git add b1 &&
+	git commit -m b1 &&
+
+	mkdir excluded &&
+	echo problem >excluded/to-be-moved.txt &&
+	git add excluded/to-be-moved.txt &&
+	git commit -m to-be-moved &&
+	git tag split_point &&
+
+	echo b2 >b2 &&
+	git add b2 &&
+	git commit -m b2 &&
+	git tag b2 &&
+
+	git reset --hard split_point &&
+
+	git mv excluded/to-be-moved.txt excluded/moved.txt &&
+	git commit -m move &&
+	git tag b1 &&
+
+	git config core.sparsecheckout true &&
+	echo "/*" >.git/info/sparse-checkout &&
+	echo "!excluded/" >>.git/info/sparse-checkout &&
+	git read-tree -mu HEAD &&
+
+	git merge -m merge b2 &&
+
+	git status >output &&
+	cp output /tmp/a &&
+	test_i18ngrep "nothing to commit" output
+'
+
 test_done
-- 
2.7.4 (Apple Git-66)

