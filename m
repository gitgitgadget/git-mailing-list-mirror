From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 2/3] fast-import: add a check for tree delta base sha1
Date: Fri, 12 Aug 2011 16:32:49 +0600
Message-ID: <1313145170-24471-3-git-send-email-divanorama@gmail.com>
References: <1313145170-24471-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 12:32:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qrp2n-0007xL-LP
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 12:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382Ab1HLKch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 06:32:37 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42662 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842Ab1HLKce (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 06:32:34 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so1552656bke.19
        for <git@vger.kernel.org>; Fri, 12 Aug 2011 03:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=VMaxgxAYeV2Pstdlx9EX+4ZfsCapMFcHBK3u3jtMTBg=;
        b=Z7HUbVwYAGkZyJv0Q1KqAvEeqJHQZ+2A7hPDHBBL6z0GIzESgQ/qxVDVy0zghf7u3C
         6c4rSBgsGgr0Mlu46Fr3VhY8UBuFn5s3F+12wVhN+Ezg8QrYFwciMbj161QGtZvcYnmI
         qAdjyPNCD75PpkE+WapwpDclZS4b29zpnnn+M=
Received: by 10.205.82.79 with SMTP id ab15mr299941bkc.142.1313145153714;
        Fri, 12 Aug 2011 03:32:33 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id i14sm763298bkd.6.2011.08.12.03.32.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 12 Aug 2011 03:32:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1313145170-24471-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179225>

fast-import is able to write imported tree objects in delta format.
It holds a tree structure in memory where each tree entry may have
a delta base sha1 assigned. When delta base data is needed it is
reconstructed from this in-memory structure. Though sometimes the
delta base data doesn't match the delta base sha1 so wrong or even
corrupt pack is produced.

To create a small easily reproducible test, add an excessive check
for delta base sha1. It's not likely that computing sha1 for each
tree delta base costs us much.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c          |   20 +++++++++++++++-----
 t/t9300-fast-import.sh |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index d0f8580..8196d1b 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1455,12 +1455,22 @@ static void store_tree(struct tree_entry *root)
 			store_tree(t->entries[i]);
 	}
 
-	le = find_object(root->versions[0].sha1);
-	if (S_ISDIR(root->versions[0].mode) && le && le->pack_id == pack_id) {
+	if (!is_null_sha1(root->versions[0].sha1)
+					&& S_ISDIR(root->versions[0].mode)) {
+		unsigned char old_tree_sha1[20];
 		mktree(t, 0, &old_tree);
-		lo.data = old_tree;
-		lo.offset = le->idx.offset;
-		lo.depth = t->delta_depth;
+		prepare_object_hash(OBJ_TREE, &old_tree,
+						NULL, NULL, old_tree_sha1);
+
+		if (hashcmp(old_tree_sha1, root->versions[0].sha1))
+			die("internal tree delta base sha1 mismatch");
+
+		le = find_object(root->versions[0].sha1);
+		if (le && le->pack_id == pack_id) {
+			lo.data = old_tree;
+			lo.offset = le->idx.offset;
+			lo.depth = t->delta_depth;
+		}
 	}
 
 	mktree(t, 1, &new_tree);
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index f256475..c70e489 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -734,6 +734,44 @@ test_expect_success \
 	 git diff-tree --abbrev --raw L^ L >output &&
 	 test_cmp expect output'
 
+cat >input <<INPUT_END
+blob
+mark :1
+data <<EOF
+the data
+EOF
+
+commit refs/heads/L2
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+init L2
+COMMIT
+
+M 644 :1 a/b/c
+M 644 :1 a/b/d
+M 644 :1 a/e/f
+INPUT_END
+
+cat >input2 <<INPUT_END
+commit refs/heads/L2
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+update L2
+COMMIT
+from refs/heads/L2^0
+M 040000 @A g
+M 040000 @E g/b
+M 040000 @E g/b/h
+INPUT_END
+
+test_expect_failure \
+    'L: verify internal tree delta base' \
+	'git fast-import <input &&
+	A=$(git ls-tree L2 a | tr " " "\t" | cut -f 3) &&
+	E=$(git ls-tree L2 a/e | tr " " "\t" | cut -f 3) &&
+	cat input2 | sed -e "s/@A/$A/" -e "s/@E/$E/" >input &&
+	git fast-import <input'
+
 ###
 ### series M
 ###
-- 
1.7.3.4
