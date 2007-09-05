From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Simplify write_tree using strbuf's.
Date: Wed,  5 Sep 2007 21:18:40 +0200
Message-ID: <11890199233357-git-send-email-madcoder@debian.org>
References: <20070905085720.GD31750@artemis.corp>
 <11890199232110-git-send-email-madcoder@debian.org>
 <11890199232128-git-send-email-madcoder@debian.org>
 <11890199232646-git-send-email-madcoder@debian.org>
 <1189019923740-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 05 21:18:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT0Op-0003ur-LM
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 21:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755681AbXIETSq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 15:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755486AbXIETSq
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 15:18:46 -0400
Received: from pan.madism.org ([88.191.52.104]:46559 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755058AbXIETSp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 15:18:45 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 3E9E21E1D6;
	Wed,  5 Sep 2007 21:18:44 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id D2E9F3244BA; Wed,  5 Sep 2007 21:18:43 +0200 (CEST)
X-Mailer: git-send-email 1.5.3
In-Reply-To: <1189019923740-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57743>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 mktree.c |   22 +++++++---------------
 1 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/mktree.c b/mktree.c
index 86de5eb..3d11ac3 100644
--- a/mktree.c
+++ b/mktree.c
@@ -44,30 +44,22 @@ static int ent_compare(const void *a_, const void *b_)
 
 static void write_tree(unsigned char *sha1)
 {
-	char *buffer;
-	unsigned long size, offset;
+	struct strbuf buf = STRBUF_INIT;
+	size_t size;
 	int i;
 
 	qsort(entries, used, sizeof(*entries), ent_compare);
 	for (size = i = 0; i < used; i++)
 		size += 32 + entries[i]->len;
-	buffer = xmalloc(size);
-	offset = 0;
+	strbuf_grow(&buf, size);
 
 	for (i = 0; i < used; i++) {
 		struct treeent *ent = entries[i];
-
-		if (offset + ent->len + 100 < size) {
-			size = alloc_nr(offset + ent->len + 100);
-			buffer = xrealloc(buffer, size);
-		}
-		offset += sprintf(buffer + offset, "%o ", ent->mode);
-		offset += sprintf(buffer + offset, "%s", ent->name);
-		buffer[offset++] = 0;
-		hashcpy((unsigned char*)buffer + offset, ent->sha1);
-		offset += 20;
+		strbuf_addf(&buf, "%o %s%c", ent->mode, ent->name, '\0');
+		strbuf_add(&buf, ent->sha1, 20);
 	}
-	write_sha1_file(buffer, offset, tree_type, sha1);
+
+	write_sha1_file(buf.buf, buf.len, tree_type, sha1);
 }
 
 static const char mktree_usage[] = "git-mktree [-z]";
-- 
1.5.3
