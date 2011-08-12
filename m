From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 6/6] Retain caches of submodule refs
Date: Sat, 13 Aug 2011 00:36:29 +0200
Message-ID: <1313188589-2330-7-git-send-email-mhagger@alum.mit.edu>
References: <1313188589-2330-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 00:38:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qs0Mj-0005fJ-Bf
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 00:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703Ab1HLWiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 18:38:06 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:41171 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702Ab1HLWiC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 18:38:02 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.homenet.telecomitalia.it (p54BEAA34.dip.t-dialin.net [84.190.170.52])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p7CMaXJT010513;
	Sat, 13 Aug 2011 00:37:41 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1313188589-2330-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179265>

Instead of keeping track of one cache for refs in the main repo and
another single cache shared among submodules, keep a linked list of
cached_refs objects, one for each module/submodule. Change
invalidate_cached_refs() to invalidate all caches. (Previously, it
only invalidated the cache of the main repo because the submodule
caches were not reused anyway.)

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   34 +++++++++++++++++++++-------------
 1 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index 8d1055d..f02cf94 100644
--- a/refs.c
+++ b/refs.c
@@ -153,13 +153,15 @@ static struct ref_list *sort_ref_list(struct ref_list *list)
  * when doing a full libification.
  */
 static struct cached_refs {
+	struct cached_refs *next;
 	char did_loose;
 	char did_packed;
 	struct ref_list *loose;
 	struct ref_list *packed;
 	/* The submodule name, or "" for the main repo. */
 	char name[FLEX_ARRAY];
-} *cached_refs, *submodule_refs;
+} *cached_refs;
+
 static struct ref_list *current_ref;
 
 static struct ref_list *extra_refs;
@@ -191,6 +193,7 @@ struct cached_refs *create_cached_refs(const char *submodule)
 		submodule = "";
 	len = strlen(submodule) + 1;
 	refs = xmalloc(sizeof(struct cached_refs) + len);
+	refs->next = NULL;
 	refs->did_loose = refs->did_packed = 0;
 	refs->loose = refs->packed = NULL;
 	memcpy(refs->name, submodule, len);
@@ -205,23 +208,28 @@ struct cached_refs *create_cached_refs(const char *submodule)
  */
 static struct cached_refs *get_cached_refs(const char *submodule)
 {
-	if (! submodule) {
-		if (!cached_refs)
-			cached_refs = create_cached_refs(submodule);
-		return cached_refs;
-	} else {
-		if (!submodule_refs)
-			submodule_refs = create_cached_refs(submodule);
-		else
-			/* For now, don't reuse the refs cache for submodules. */
-			clear_cached_refs(submodule_refs);
-		return submodule_refs;
+	struct cached_refs *refs = cached_refs;
+	if (! submodule)
+		submodule = "";
+	while (refs) {
+		if (!strcmp(submodule, refs->name))
+			return refs;
+		refs = refs->next;
 	}
+
+	refs = create_cached_refs(submodule);
+	refs->next = cached_refs;
+	cached_refs = refs;
+	return refs;
 }
 
 static void invalidate_cached_refs(void)
 {
-	clear_cached_refs(get_cached_refs(NULL));
+	struct cached_refs *refs = cached_refs;
+	while (refs) {
+		clear_cached_refs(refs);
+		refs = refs->next;
+	}
 }
 
 static struct ref_list *read_packed_refs(FILE *f)
-- 
1.7.6.8.gd2879
