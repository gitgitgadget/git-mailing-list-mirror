From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 3/5] Use the matching function to generate the match
 results
Date: Thu, 5 Mar 2009 23:56:20 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0903052355240.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 05:58:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfS8S-00005C-3Y
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 05:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210AbZCFE43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 23:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbZCFE42
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 23:56:28 -0500
Received: from iabervon.org ([66.92.72.58]:51780 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752757AbZCFE41 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 23:56:27 -0500
Received: (qmail 6373 invoked by uid 1000); 6 Mar 2009 04:56:20 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Mar 2009 04:56:20 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112382>

This puts all of the interpretation of the pattern representation in a
single function for easy manipulation.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 remote.c |   45 +++++++++++++++++++++++----------------------
 1 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/remote.c b/remote.c
index 709300b..93fd03d 100644
--- a/remote.c
+++ b/remote.c
@@ -719,9 +719,19 @@ int remote_has_url(struct remote *remote, const char *url)
 	return 0;
 }
 
-static int name_fits_pattern(const char *key, const char *name)
+static int name_fits_pattern(const char *key, const char *name,
+			     const char *value, char **result)
 {
-	int ret = !prefixcmp(key, name);
+	size_t klen = strlen(key);
+	int ret = !strncmp(key, name, klen);
+	if (ret && value) {
+		size_t vlen = strlen(value);
+		*result = xmalloc(vlen +
+				  strlen(name) -
+				  klen + 1);
+		strcpy(*result, value);
+		strcpy(*result + vlen, name + klen);
+	}
 	return ret;
 }
 
@@ -748,13 +758,7 @@ int remote_find_tracking(struct remote *remote, struct refspec *refspec)
 		if (!fetch->dst)
 			continue;
 		if (fetch->pattern) {
-			if (name_fits_pattern(key, needle)) {
-				*result = xmalloc(strlen(value) +
-						  strlen(needle) -
-						  strlen(key) + 1);
-				strcpy(*result, value);
-				strcpy(*result + strlen(value),
-				       needle + strlen(key));
+			if (name_fits_pattern(key, needle, value, result)) {
 				refspec->force = fetch->force;
 				return 0;
 			}
@@ -1026,7 +1030,8 @@ static const struct refspec *check_pattern_match(const struct refspec *rs,
 			continue;
 		}
 
-		if (rs[i].pattern && name_fits_pattern(rs[i].src, src->name))
+		if (rs[i].pattern && name_fits_pattern(rs[i].src, src->name,
+						       NULL, NULL))
 			return rs + i;
 	}
 	if (matching_refs != -1)
@@ -1080,11 +1085,9 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 
 		} else {
 			const char *dst_side = pat->dst ? pat->dst : pat->src;
-			dst_name = xmalloc(strlen(dst_side) +
-					   strlen(src->name) -
-					   strlen(pat->src) + 2);
-			strcpy(dst_name, dst_side);
-			strcat(dst_name, src->name + strlen(pat->src));
+			if (!name_fits_pattern(pat->src, src->name,
+					       dst_side, &dst_name))
+				die("Didn't think it matches any more");
 		}
 		dst_peer = find_ref_by_name(dst, dst_name);
 		if (dst_peer) {
@@ -1160,19 +1163,17 @@ static struct ref *get_expanded_map(const struct ref *remote_refs,
 	struct ref *ret = NULL;
 	struct ref **tail = &ret;
 
-	int remote_prefix_len = strlen(refspec->src);
-	int local_prefix_len = strlen(refspec->dst);
+	char *expn_name;
 
 	for (ref = remote_refs; ref; ref = ref->next) {
 		if (strchr(ref->name, '^'))
 			continue; /* a dereference item */
-		if (name_fits_pattern(refspec->src, ref->name)) {
-			const char *match;
+		if (name_fits_pattern(refspec->src, ref->name,
+				      refspec->dst, &expn_name)) {
 			struct ref *cpy = copy_ref(ref);
-			match = ref->name + remote_prefix_len;
 
-			cpy->peer_ref = alloc_ref_with_prefix(refspec->dst,
-					local_prefix_len, match);
+			cpy->peer_ref = alloc_ref(expn_name);
+			free(expn_name);
 			if (refspec->force)
 				cpy->peer_ref->force = 1;
 			*tail = cpy;
-- 
1.6.1.286.gd33a4.dirty
