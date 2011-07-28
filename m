From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH/WIP 6/7] fast-import: workaround data corruption
Date: Thu, 28 Jul 2011 10:46:09 +0600
Message-ID: <1311828370-30477-7-git-send-email-divanorama@gmail.com>
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
	id 1QmIRm-0004W6-Ld
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 06:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563Ab1G1Enm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 00:43:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33373 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484Ab1G1Enf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 00:43:35 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so881739fxh.19
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 21:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=YHEh6e8DYynUK/CourXP8B5A/MnnZYmmIuJPx9YiLFk=;
        b=sAcnffk4/+LoiIQpfJlhYRayV3GZDCyDnPG14UGY6i7E8TWhA50C+pVfVV2UNvDjfs
         JL7HMgoGN8hc3YsJ96dqfaqMCWGfUQQniLuKLfYLMqRc3udKAakP0xZkzEgGjRp2k68w
         /CQ3ksR8sQDv8m4at4HJPNEJwG5EP+hFYqOpc=
Received: by 10.204.135.134 with SMTP id n6mr176745bkt.402.1311828214996;
        Wed, 27 Jul 2011 21:43:34 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id r24sm146189bkr.26.2011.07.27.21.43.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Jul 2011 21:43:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1311828370-30477-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178012>

fast-import keeps track of some delta-base for tree objects. When it is
time to compute the delta, base object is constructed from in-memory
tree representation using children's delta bases sha1. But these can be
unrelated due to several bugs, and it leads to object with wrong sha1
being delta-written to the packfile.

We have the base sha1 and what we think it's data is. Verify sha1 and if
it doesn't match, report it to stderr and don't use delta for this tree.

We could also die() here when bugs are fixed. Or we can see if the data
we've got is from our pack file and so still try to use it as a base.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 9f0d2fe..14a2a63 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1469,7 +1469,8 @@ static void drop_old(struct tree_entry *root)
 static void store_tree(struct tree_entry *root)
 {
 	struct tree_content *t = root->tree;
-	struct last_object lo = { STRBUF_INIT, 0, 0, /* no_swap */ 1 };
+	struct strbuf empty = STRBUF_INIT;
+	struct last_object lo = { empty, 0, 0, /* no_swap */ 1 };
 	struct object_entry *le;
 	unsigned int i;
 
@@ -1486,10 +1487,21 @@ static void store_tree(struct tree_entry *root)
 
 	le = find_object(root->versions[0].sha1);
 	if (S_ISDIR(root->versions[0].mode) && le && le->pack_id == pack_id) {
+		unsigned char sh[20];
 		mktree(t, 0, &old_tree);
 		lo.data = old_tree;
 		lo.offset = le->idx.offset;
 		lo.depth = t->delta_depth;
+
+		prepare_object_hash(OBJ_TREE, &old_tree, NULL, NULL, sh);
+		if (hashcmp(sh, root->versions[0].sha1)) {
+			fprintf(stderr, "internal sha1 delta base mismatch,"
+					" won't use delta for that tree\n");
+			lo.data = empty;
+			lo.offset = 0;
+			lo.depth = 0;
+		}
+
 	}
 
 	mktree(t, 1, &new_tree);
-- 
1.7.3.4
