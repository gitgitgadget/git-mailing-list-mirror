X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/3] diff_tree_sha1(): avoid rereading trees if possible
Date: Sun, 10 Dec 2006 00:55:34 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612100055160.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061207101707.GA19139@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 9 Dec 2006 23:55:54 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061207101707.GA19139@spearce.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33850>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtC2j-0001An-JX for gcvg-git@gmane.org; Sun, 10 Dec
 2006 00:55:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757734AbWLIXzh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 18:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758826AbWLIXzh
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 18:55:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:39443 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1757734AbWLIXzg
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006 18:55:36 -0500
Received: (qmail invoked by alias); 09 Dec 2006 23:55:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp035) with SMTP; 10 Dec 2006 00:55:35 +0100
To: "Shawn O. Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org


If the tree has already been read, no need to read it into memory
again.

This also helps when this function is called on temporary trees;
these no longer have to be written to disk.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 tree-diff.c |   33 ++++++++++++++++++++++-----------
 1 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 9d80dfb..54a6b44 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -195,23 +195,34 @@ int diff_tree(struct tree_desc *t1, struct tree_desc *t2, const char *base, stru
 	return 0;
 }
 
+static int get_tree_desc_from_sha1(const unsigned char *sha1,
+		struct tree_desc *t)
+{
+	struct object *o;
+
+	o = lookup_object(sha1);
+	if (o && o->type == OBJ_TREE && o->parsed) {
+		struct tree *tree = (struct tree *)o;
+		t->size = tree->size;
+		t->buf = xmalloc(t->size);
+		memcpy(t->buf, tree->buffer, t->size);
+	} else {
+		t->buf = read_object_with_reference(sha1,
+				tree_type, &t->size, NULL);
+		if (!t->buf)
+			die("unable to read source tree (%s)",
+					sha1_to_hex(sha1));
+	}
+}
+
 int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const char *base, struct diff_options *opt)
 {
-	void *tree1, *tree2;
 	struct tree_desc t1, t2;
 	int retval;
 
-	tree1 = read_object_with_reference(old, tree_type, &t1.size, NULL);
-	if (!tree1)
-		die("unable to read source tree (%s)", sha1_to_hex(old));
-	tree2 = read_object_with_reference(new, tree_type, &t2.size, NULL);
-	if (!tree2)
-		die("unable to read destination tree (%s)", sha1_to_hex(new));
-	t1.buf = tree1;
-	t2.buf = tree2;
+	get_tree_desc_from_sha1(old, &t1);
+	get_tree_desc_from_sha1(new, &t2);
 	retval = diff_tree(&t1, &t2, base, opt);
-	free(tree1);
-	free(tree2);
 	return retval;
 }
 
-- 
1.4.4.2.g0f32-dirty

