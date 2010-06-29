From: newren@gmail.com
Subject: [PATCH 1/5] Add additional testcases for D/F conflicts
Date: Mon, 28 Jun 2010 19:12:12 -0600
Message-ID: <1277773936-12412-2-git-send-email-newren@gmail.com>
References: <1277773936-12412-1-git-send-email-newren@gmail.com>
Cc: Johannes.Schindelin@gmx.de, vmiklos@frugalware.org,
	gitster@pobox.com, spearce@spearce.org,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 29 03:10:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTPLn-0006lJ-F8
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 03:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550Ab0F2BKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 21:10:54 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:46078 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab0F2BKv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 21:10:51 -0400
Received: by mail-px0-f174.google.com with SMTP id 8so2060482pxi.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 18:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=jk0xyTvwivZEwJ/1qq5najq6PSrEJj+ORUk1w4bH1gY=;
        b=nSp2kkF6ozLxV7c2yn6Af2NwpUuXBoedNpCZzumveK/qkCl1Q7T5sev2/80GQgk+mR
         xnUiaqpKjJer9n5MIyz3lenc0Q7qRPjlUQMtX8txBm1BuOKBcqsNzhh0Z6YbhLAO9F34
         OmS/aR9/6quNPnBegOrKR90Lc4AIQmaVyiabs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZYL9skCeWlH6bbB8tDz/hfyJJqXmXapqNCzhrUIvJJVSVWUp66IQhYokNSjDGsN33g
         vcdGvBn4vs1h8eJluQP63tfcqYCttjoMocU7i+CKgW5Uk4dXu3lxKVPZNDegFDz1UxSd
         PzosJUOz0w7t+IYNpnyLdsMlmDBhMqRy3KDkY=
Received: by 10.142.207.13 with SMTP id e13mr6955857wfg.21.1277773850639;
        Mon, 28 Jun 2010 18:10:50 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-59-120.hsd1.nm.comcast.net [76.113.59.120])
        by mx.google.com with ESMTPS id x34sm8105171wfi.4.2010.06.28.18.10.48
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 28 Jun 2010 18:10:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc0.207.ga9fc
In-Reply-To: <1277773936-12412-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149874>

From: Elijah Newren <newren@gmail.com>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6035-merge-dir-to-symlink.sh |   37 +++++++++++++++++++++++++++++++++++--
 t/t9350-fast-export.sh          |   24 ++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/t/t6035-merge-dir-to-symlink.sh b/t/t6035-merge-dir-to-symlink.sh
index cd3190c..4f04f41 100755
--- a/t/t6035-merge-dir-to-symlink.sh
+++ b/t/t6035-merge-dir-to-symlink.sh
@@ -56,7 +56,7 @@ test_expect_success 'do not lose a/b-2/c/d in merge (resolve)' '
 	test -f a/b-2/c/d
 '
 
-test_expect_failure 'do not lose a/b-2/c/d in merge (recursive)' '
+test_expect_failure 'Handle D/F conflict, do not lose a/b-2/c/d in merge (recursive)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
 	git merge -s recursive master &&
@@ -64,6 +64,31 @@ test_expect_failure 'do not lose a/b-2/c/d in merge (recursive)' '
 	test -f a/b-2/c/d
 '
 
+test_expect_failure 'Handle F/D conflict, do not lose a/b-2/c/d in merge (recursive)' '
+	git reset --hard &&
+	git checkout master &&
+	git merge -s recursive baseline^0 &&
+	test -h a/b &&
+	test -f a/b-2/c/d
+'
+
+test_expect_success 'do not lose untracked in merge (recursive)' '
+	git reset --hard &&
+	git checkout baseline^0 &&
+	touch a/b/c/e &&
+	test_must_fail git merge -s recursive master &&
+	test -f a/b/c/e &&
+	test -f a/b-2/c/d
+'
+
+test_expect_success 'do not lose modifications in merge (recursive)' '
+	git add --all &&
+	git reset --hard &&
+	git checkout baseline^0 &&
+	echo more content >> a/b/c/d &&
+	test_must_fail git merge -s recursive master
+'
+
 test_expect_success 'setup a merge where dir a/b-2 changed to symlink' '
 	git reset --hard &&
 	git checkout start^0 &&
@@ -82,7 +107,7 @@ test_expect_success 'merge should not have conflicts (resolve)' '
 	test -f a/b/c/d
 '
 
-test_expect_failure 'merge should not have conflicts (recursive)' '
+test_expect_failure 'merge should not have D/F conflicts (recursive)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
 	git merge -s recursive test2 &&
@@ -90,4 +115,12 @@ test_expect_failure 'merge should not have conflicts (recursive)' '
 	test -f a/b/c/d
 '
 
+test_expect_failure 'merge should not have F/D conflicts (recursive)' '
+	git reset --hard &&
+	git checkout -b foo test2 &&
+	git merge -s recursive baseline^0 &&
+	test -h a/b-2 &&
+	test -f a/b/c/d
+'
+
 test_done
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index d43f37c..69179c6 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -376,4 +376,28 @@ test_expect_success 'tree_tag-obj'    'git fast-export tree_tag-obj'
 test_expect_success 'tag-obj_tag'     'git fast-export tag-obj_tag'
 test_expect_success 'tag-obj_tag-obj' 'git fast-export tag-obj_tag-obj'
 
+test_expect_failure 'directory becomes symlink'        '
+	git init dirtosymlink &&
+	git init result &&
+	(
+		cd dirtosymlink &&
+		mkdir foo &&
+		mkdir bar &&
+		echo hello > foo/world &&
+		echo hello > bar/world &&
+		git add foo/world bar/world &&
+		git commit -q -mone &&
+		git rm -r foo &&
+		ln -s bar foo &&
+		git add foo &&
+		git commit -q -mtwo
+	) &&
+	(
+		cd dirtosymlink &&
+		git fast-export master -- foo |
+		(cd ../result && git fast-import --quiet)
+	) &&
+	(cd result && git show master:foo)
+'
+
 test_done
-- 
1.7.2.rc0.212.g0c601
