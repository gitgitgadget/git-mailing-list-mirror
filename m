From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 4/7] Simplify write_tree using strbuf's.
Date: Thu,  6 Sep 2007 13:20:08 +0200
Message-ID: <11890776111670-git-send-email-madcoder@debian.org>
References: <20070902224213.GB431@artemis.corp>
 <11890776114037-git-send-email-madcoder@debian.org>
 <118907761140-git-send-email-madcoder@debian.org>
 <11890776111843-git-send-email-madcoder@debian.org>
 <11890776112292-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 13:20:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITFPJ-0008IQ-IE
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 13:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbXIFLUR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 07:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbXIFLUQ
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 07:20:16 -0400
Received: from pan.madism.org ([88.191.52.104]:52605 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751624AbXIFLUN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 07:20:13 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id DE0761E403;
	Thu,  6 Sep 2007 13:20:12 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id DAE2F1A3C0; Thu,  6 Sep 2007 13:20:11 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <11890776112292-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57863>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 mktree.c |   23 ++++++++---------------
 1 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/mktree.c b/mktree.c
index 86de5eb..2e84889 100644
--- a/mktree.c
+++ b/mktree.c
@@ -44,30 +44,23 @@ static int ent_compare(const void *a_, const void *b_)
 
 static void write_tree(unsigned char *sha1)
 {
-	char *buffer;
-	unsigned long size, offset;
+	struct strbuf buf;
+	size_t size;
 	int i;
 
 	qsort(entries, used, sizeof(*entries), ent_compare);
 	for (size = i = 0; i < used; i++)
 		size += 32 + entries[i]->len;
-	buffer = xmalloc(size);
-	offset = 0;
+	strbuf_init(&buf);
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
1.5.3.1
