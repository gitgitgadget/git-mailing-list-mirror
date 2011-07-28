From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH/WIP 7/7] fast-import: fix data corruption in load_tree
Date: Thu, 28 Jul 2011 10:46:10 +0600
Message-ID: <1311828370-30477-8-git-send-email-divanorama@gmail.com>
References: <1311828370-30477-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 06:43:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmIRn-0004W6-5n
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 06:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754576Ab1G1Eno (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 00:43:44 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36852 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754496Ab1G1Enh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 00:43:37 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so881708fxh.19
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 21:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9GWwk1AX+h7evi4PdIM+ZKT+u6n+nf9mbdYRTuCPj8Q=;
        b=gThRtT1Ilz5WcPTVsB5hqkBpXjljQl1V42NIBwM1pwdoILilNTGuSxXPU6lSgh1fCC
         EwK6WHgXlXXFUkXf/X8OswduwwCRC75bc5n2HXP9fTuP0m98rjc+rrdmJe1eWdjOzEyI
         nTYpVnlreRhIrSuLGDxsgInbtr7M6l91NOg8E=
Received: by 10.204.140.134 with SMTP id i6mr159397bku.189.1311828217034;
        Wed, 27 Jul 2011 21:43:37 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id r24sm146189bkr.26.2011.07.27.21.43.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Jul 2011 21:43:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1311828370-30477-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178013>

load_tree could be used to load a tree having different base and
current sha1. For example it can happens after a parent tree was
set by sha1 (it's tree becomes NULL, versions[0].sha1 remain and
versions[1].sha1 change). But it doesn't look at versions[0].sha1
and just loads a new version resetting the base one to the new one.
This corrupts parent tree delta.

Try to detect that case. Load both base and new trees and merge them
together so that mktree is able to produce both base and new trees
correctly.

There still may be a delta data corruption. For example tree_content_set
with subtree != NULL can produce subtree entries bases and subtree's new
parent base mismatch. tree_content_set is used in file_modify_cr - copy
and move trees by names. And another place is notes writing thing that
does some trees magic too.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c |   68 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 14a2a63..feccd14 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1389,14 +1389,6 @@ static void load_tree_content(struct tree_content **root, unsigned char *sha1)
 	free(buf);
 }
 
-static void load_tree(struct tree_entry *root)
-{
-	root->tree = t = new_tree_content(8);
-	if (is_null_sha1(sha1))
-		return;
-       load_tree_content(&root->tree, root->versions[1].sha1);
-}
-
 static int tecmp0 (const void *_a, const void *_b)
 {
 	struct tree_entry *a = *((struct tree_entry**)_a);
@@ -1442,6 +1434,66 @@ static void mktree(struct tree_content *t, int v, struct strbuf *b)
 	}
 }
 
+static void load_tree(struct tree_entry *root)
+{
+	struct tree_content *oldt;
+	size_t n, i, j;
+
+	root->tree = new_tree_content(8);
+	if (is_null_sha1(root->versions[1].sha1)) {
+		if (!S_ISDIR(root->versions[0].mode) || is_null_sha1(root->versions[0].sha1) || !hashcmp(root->versions[0].sha1, root->versions[1].sha1))
+			return;
+		// looks like it is currently unreachable, but let it be for a while
+		load_tree_content(&root->tree, root->versions[0].sha1);
+		for (i = 0; i < root->tree->entry_count; ++i) {
+			root->tree->entries[i]->versions[1].mode = 0;
+			hashclr(root->tree->entries[i]->versions[1].sha1);
+		}
+		return;
+	}
+
+	load_tree_content(&root->tree, root->versions[1].sha1);
+	if (!S_ISDIR(root->versions[0].mode) || is_null_sha1(root->versions[0].sha1) || !hashcmp(root->versions[0].sha1, root->versions[1].sha1))
+ 		return;
+
+	oldt = new_tree_content(8);
+	load_tree_content(&oldt, root->versions[0].sha1);
+
+	qsort(root->tree->entries, root->tree->entry_count, sizeof(root->tree->entries[0]), tecmp1);
+	qsort(oldt->entries, oldt->entry_count, sizeof(oldt->entries[0]), tecmp1);
+
+	n = root->tree->entry_count;
+	i = 0;
+	j = 0;
+	while (i < n || j < oldt->entry_count) {
+		int cmp = i == n ? 1 : j == oldt->entry_count ? -1 : tecmp1(root->tree->entries + i, oldt->entries + j);
+		if (cmp > 0) {
+			if (root->tree->entry_count == root->tree->entry_capacity)
+				root->tree = grow_tree_content(root->tree, root->tree->entry_count);
+			oldt->entries[j]->versions[1].mode = 0;
+			hashclr(oldt->entries[j]->versions[1].sha1);
+			root->tree->entries[root->tree->entry_count++] = oldt->entries[j];
+			oldt->entries[j] = NULL;
+			++j;
+		} else if (cmp < 0) {
+			root->tree->entries[i]->versions[0].mode = 0;
+			hashclr(root->tree->entries[i]->versions[0].sha1);
+			++i;
+		} else {
+			root->tree->entries[i]->versions[0].mode = oldt->entries[j]->versions[1].mode;
+			hashcpy(root->tree->entries[i]->versions[0].sha1, oldt->entries[j]->versions[1].sha1);
+			++i;
+			++j;
+		}
+	}
+	for (j = 0; j < oldt->entry_count; ++j)
+		if (oldt->entries[j]) {
+			release_tree_entry(oldt->entries[j]);
+			oldt->entries[j] = NULL;
+		}
+	release_tree_content(oldt);
+}
+
 static void drop_old(struct tree_entry *root)
 {
 	struct tree_content *t = root->tree;
-- 
1.7.3.4
