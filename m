Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0BFA20984
	for <e@80x24.org>; Mon, 12 Sep 2016 11:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757955AbcILLfG (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 07:35:06 -0400
Received: from forward11o.cmail.yandex.net ([37.9.109.178]:50843 "EHLO
        forward11o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757918AbcILLfG (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Sep 2016 07:35:06 -0400
X-Greylist: delayed 647 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Sep 2016 07:35:05 EDT
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::26])
        by forward11o.cmail.yandex.net (Yandex) with ESMTP id 945F820AD0
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 14:24:16 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (localhost.localdomain [127.0.0.1])
        by smtp2o.mail.yandex.net (Yandex) with ESMTP id 6DDAA5080F6E;
        Mon, 12 Sep 2016 14:24:14 +0300 (MSK)
Received: by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id cBrC1GAfOB-ODZ8Cc6x;
        Mon, 12 Sep 2016 14:24:13 +0300
        (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=filippov.me; s=mail; t=1473679453;
        bh=WmYhWvQgS+xurIFIFq+o1ec9ylF0Qy4FKreYJqhEb8U=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=An5K/YhLjqedQnvEYADsphGm9rljB+blnqVXnLo2EQQC/Le3JzAlw5wRDua+mazdD
         SLA+iPbd4aDI7rk+LtMcdCuHeFEDqVreWdFgBGvIMjN+hK3W6rYV7sgIZZyUvObRvQ
         vntaPyQpOYtZtIcgV3i1NnyWmZdcCee9sdY4QlKo=
Authentication-Results: smtp2o.mail.yandex.net; dkim=pass header.i=@filippov.me
X-Yandex-Suid-Status: 1 0,1 1130000020865541
From:   Mikhail Filippov <mikhail@filippov.me>
To:     git@vger.kernel.org
Cc:     Mikhail Filippov <mikhail@filippov.me>
Subject: [PATCH] Do not record unstaged deleted file upon recursive merge if file was moved outside of working tree with enabled sparse-checkout.
Date:   Mon, 12 Sep 2016 14:24:11 +0300
Message-Id: <1473679451-4591-1-git-send-email-mikhail@filippov.me>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's a very unexpected behaviour when a user sees a deleted file after a merge with enabled sparse-checkout. Moreover, when the user resolves merge conflicts and commits the changes with the command "git commit -am xxx", a repository can be broken because all the moved files will be deleted. Finally, it's really hard to find a user who deleted these files because "git log file" doesn't show any merge commits by default. I'm not sure that my fix is correct but I checked all tests and I didn't find a better way to prevent files deleting.
---
 merge-recursive.c                    |  9 +++++---
 t/t6042-merge-rename-corner-cases.sh | 41 ++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 3 deletions(-)

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
index 411550d..5d84418 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -575,4 +575,45 @@ test_expect_success 'rename/rename/add-dest merge still knows about conflicting
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
+	test_i18ngrep "nothing to commit" output
+'
+
 test_done
-- 
2.7.4 (Apple Git-66)

