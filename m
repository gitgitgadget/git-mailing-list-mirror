From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH/WIP 5/7] fast-import: extract tree_content reading function
Date: Thu, 28 Jul 2011 10:46:08 +0600
Message-ID: <1311828370-30477-6-git-send-email-divanorama@gmail.com>
References: <1311828370-30477-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 06:43:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmIRl-0004W6-Jm
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 06:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754494Ab1G1Enf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 00:43:35 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36852 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754147Ab1G1Ene (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 00:43:34 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so881708fxh.19
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 21:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=LJ+oJ3i76+nYwszPRzG1/b6VOwL9AipqjvZycJsp+eM=;
        b=U7F1nxzjAmms4EpqZPqVtEcfVpuivB9heKBJMlwTibjLznTyD75sgHya3FV6rPPv12
         RnOr8Srp1CCTc6+EzLkDzYDjRLxwVdL5f0ZNP90pxX/ZrVh4/QG4HHDt4WcLSnI1O77Z
         4U9ub1r+9/1XkdnjZmTibH50cd2l20nm3SNwE=
Received: by 10.204.8.151 with SMTP id h23mr178222bkh.233.1311828213108;
        Wed, 27 Jul 2011 21:43:33 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id r24sm146189bkr.26.2011.07.27.21.43.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Jul 2011 21:43:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1311828370-30477-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178011>

It will be useful to fetch tree contents by a sha1. First, we can check
our in-memory tree against it. Second, we may need to read both old and
new tree contents and merge them in load_tree.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index d917ea6..9f0d2fe 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1344,19 +1344,14 @@ static const char *get_mode(const char *str, uint16_t *modep)
 	return str;
 }
 
-static void load_tree(struct tree_entry *root)
+static void load_tree_content(struct tree_content **root, unsigned char *sha1)
 {
-	unsigned char *sha1 = root->versions[1].sha1;
 	struct object_entry *myoe;
-	struct tree_content *t;
+	struct tree_content *t = *root;
 	unsigned long size;
 	char *buf;
 	const char *c;
 
-	root->tree = t = new_tree_content(8);
-	if (is_null_sha1(sha1))
-		return;
-
 	myoe = find_object(sha1);
 	if (myoe && myoe->pack_id != MAX_PACK_ID) {
 		if (myoe->type != OBJ_TREE)
@@ -1377,7 +1372,7 @@ static void load_tree(struct tree_entry *root)
 		struct tree_entry *e = new_tree_entry();
 
 		if (t->entry_count == t->entry_capacity)
-			root->tree = t = grow_tree_content(t, t->entry_count);
+			*root = t = grow_tree_content(t, t->entry_count);
 		t->entries[t->entry_count++] = e;
 
 		e->tree = NULL;
@@ -1394,6 +1389,14 @@ static void load_tree(struct tree_entry *root)
 	free(buf);
 }
 
+static void load_tree(struct tree_entry *root)
+{
+	root->tree = t = new_tree_content(8);
+	if (is_null_sha1(sha1))
+		return;
+       load_tree_content(&root->tree, root->versions[1].sha1);
+}
+
 static int tecmp0 (const void *_a, const void *_b)
 {
 	struct tree_entry *a = *((struct tree_entry**)_a);
-- 
1.7.3.4
