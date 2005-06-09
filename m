From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Handle entry removals during merge correctly.
Date: Thu, 09 Jun 2005 15:47:10 -0700
Message-ID: <7voeaf9mhd.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0506081336080.2286@ppc970.osdl.org>
	<7vis0o30sc.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506081629370.2286@ppc970.osdl.org>
	<7voeagrp11.fsf_-_@assigned-by-dhcp.cox.net>
	<7v64woroui.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506090800580.2286@ppc970.osdl.org>
	<7v7jh3phkk.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506091033300.2286@ppc970.osdl.org>
	<7vbr6fnzf0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506091152530.2286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 00:44:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgVk5-0003iT-ER
	for gcvg-git@gmane.org; Fri, 10 Jun 2005 00:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVFIWrZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 18:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVFIWrZ
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 18:47:25 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:53209 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261300AbVFIWrM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2005 18:47:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050609224711.UPTL12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Jun 2005 18:47:11 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506091152530.2286@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 9 Jun 2005 12:03:04 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>

We could handle delete the same way - to set the ce_mode to zero
and add them to the "dst" array, and teach write-cache not to
write them out. Then the same loop that goes around doing the
CE_UPDATE thing could check for the delete case.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** Linus, did I get the patch submission format right?  This is
*** essentially what you wrote (with one correction) but not
*** really "a forwarded e-mail".

 read-cache.c |   10 ++++++++--
 read-tree.c  |   30 ++++++++++++++++++++----------
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/read-cache.c b/read-cache.c
--- a/read-cache.c
+++ b/read-cache.c
@@ -440,11 +440,15 @@ int write_cache(int newfd, struct cache_
 {
 	SHA_CTX c;
 	struct cache_header hdr;
-	int i;
+	int i, removed;
+
+	for (i = removed = 0; i < entries; i++)
+		if (!cache[i]->ce_mode)
+			removed++;
 
 	hdr.hdr_signature = htonl(CACHE_SIGNATURE);
 	hdr.hdr_version = htonl(2);
-	hdr.hdr_entries = htonl(entries);
+	hdr.hdr_entries = htonl(entries - removed);
 
 	SHA1_Init(&c);
 	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
@@ -452,6 +456,8 @@ int write_cache(int newfd, struct cache_
 
 	for (i = 0; i < entries; i++) {
 		struct cache_entry *ce = cache[i];
+		if (!ce->ce_mode)
+			continue;
 		if (ce_write(&c, newfd, ce, ce_size(ce)) < 0)
 			return -1;
 	}
diff --git a/read-tree.c b/read-tree.c
--- a/read-tree.c
+++ b/read-tree.c
@@ -124,6 +124,15 @@ static int merged_entry(struct cache_ent
 	return 1;
 }
 
+static int deleted_entry(struct cache_entry *ce, struct cache_entry *old, struct cache_entry **dst)
+{
+	if (old)
+		verify_uptodate(old);
+	ce->ce_mode = 0;
+	*dst++ = ce;
+	return 1;
+}
+
 static int threeway_merge(struct cache_entry *stages[4], struct cache_entry **dst)
 {
 	struct cache_entry *i = stages[0];
@@ -181,25 +190,21 @@ static int twoway_merge(struct cache_ent
 			*dst++ = current;
 			return 1;
 		}
-		else if (oldtree && !newtree && same(current, oldtree)) {
+		else if (oldtree && !newtree && same(current, oldtree))
 			/* 10 or 11 */
-			verify_uptodate(current);
-			return 0;
-		}
+			return deleted_entry(oldtree, current, dst);
 		else if (oldtree && newtree &&
-			 same(current, oldtree) && !same(current, newtree)) {
+			 same(current, oldtree) && !same(current, newtree))
 			/* 20 or 21 */
-			verify_uptodate(current);
-			return merged_entry(newtree, NULL, dst);
-		}
+			return merged_entry(newtree, current, dst);
 		else
 			/* all other failures */
 			return -1;
 	}
 	else if (newtree)
-		return merged_entry(newtree, NULL, dst);
+		return merged_entry(newtree, current, dst);
 	else
-		return 0;
+		return deleted_entry(oldtree, current, dst);
 }
 
 /*
@@ -236,6 +241,11 @@ static void check_updates(struct cache_e
 	unsigned short mask = htons(CE_UPDATE);
 	while (nr--) {
 		struct cache_entry *ce = *src++;
+		if (!ce->ce_mode) {
+			if (update)
+				unlink(ce->name);
+			continue;
+		}
 		if (ce->ce_flags & mask) {
 			ce->ce_flags &= ~mask;
 			if (update)
------------

