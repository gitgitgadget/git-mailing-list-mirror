From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Tighten refspec processing
Date: Mon, 17 Mar 2008 22:05:23 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803172204420.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 03:06:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbRDM-0004GV-3R
	for gcvg-git-2@gmane.org; Tue, 18 Mar 2008 03:06:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752915AbYCRCF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 22:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752858AbYCRCF2
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 22:05:28 -0400
Received: from iabervon.org ([66.92.72.58]:41026 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752603AbYCRCF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 22:05:28 -0400
Received: (qmail 16613 invoked by uid 1000); 18 Mar 2008 02:05:23 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Mar 2008 02:05:23 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77480>

This changes the pattern matching code to not store the required final
/ before the *, and then to require each side to be a valid ref (or
empty). In particular, any refspec that looks like it should be a
pattern but doesn't quite meet the requirements will be found to be
invalid as a fallback non-pattern.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
(replaces the earlier patch)

 remote.c |   47 ++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/remote.c b/remote.c
index f3f7375..476b8ef 100644
--- a/remote.c
+++ b/remote.c
@@ -396,6 +396,7 @@ static void read_config(void)
 struct refspec *parse_ref_spec(int nr_refspec, const char **refspec)
 {
 	int i;
+	int st;
 	struct refspec *rs = xcalloc(sizeof(*rs), nr_refspec);
 	for (i = 0; i < nr_refspec; i++) {
 		const char *sp, *ep, *gp;
@@ -404,13 +405,15 @@ struct refspec *parse_ref_spec(int nr_refspec, const char **refspec)
 			rs[i].force = 1;
 			sp++;
 		}
-		gp = strchr(sp, '*');
+		gp = strstr(sp, "/*");
 		ep = strchr(sp, ':');
 		if (gp && ep && gp > ep)
 			gp = NULL;
 		if (ep) {
 			if (ep[1]) {
-				const char *glob = strchr(ep + 1, '*');
+				const char *glob = strstr(ep + 1, "/*");
+				if (glob && glob[2])
+					glob = NULL;
 				if (!glob)
 					gp = NULL;
 				if (gp)
@@ -422,11 +425,24 @@ struct refspec *parse_ref_spec(int nr_refspec, const char **refspec)
 		} else {
 			ep = sp + strlen(sp);
 		}
+		if (gp && gp + 2 != ep)
+			gp = NULL;
 		if (gp) {
 			rs[i].pattern = 1;
 			ep = gp;
 		}
 		rs[i].src = xstrndup(sp, ep - sp);
+
+		if (*rs[i].src) {
+			st = check_ref_format(rs[i].src);
+			if (st && st != CHECK_REF_FORMAT_ONELEVEL)
+				die("Invalid refspec '%s'", refspec[i]);
+		}
+		if (rs[i].dst && *rs[i].dst) {
+			st = check_ref_format(rs[i].dst);
+			if (st && st != CHECK_REF_FORMAT_ONELEVEL)
+				die("Invalid refspec '%s'", refspec[i]);
+		}
 	}
 	return rs;
 }
@@ -543,7 +559,8 @@ int remote_find_tracking(struct remote *remote, struct refspec *refspec)
 		if (!fetch->dst)
 			continue;
 		if (fetch->pattern) {
-			if (!prefixcmp(needle, key)) {
+			if (!prefixcmp(needle, key) &&
+			    needle[strlen(key)] == '/') {
 				*result = xmalloc(strlen(value) +
 						  strlen(needle) -
 						  strlen(key) + 1);
@@ -790,7 +807,9 @@ static const struct refspec *check_pattern_match(const struct refspec *rs,
 {
 	int i;
 	for (i = 0; i < rs_nr; i++) {
-		if (rs[i].pattern && !prefixcmp(src->name, rs[i].src))
+		if (rs[i].pattern && 
+		    !prefixcmp(src->name, rs[i].src) &&
+		    src->name[strlen(rs[i].src)] == '/')
 			return rs + i;
 	}
 	return NULL;
@@ -989,7 +1008,7 @@ int get_fetch_map(const struct ref *remote_refs,
 		  struct ref ***tail,
 		  int missing_ok)
 {
-	struct ref *ref_map, *rm;
+	struct ref *ref_map, **rmp;
 
 	if (refspec->pattern) {
 		ref_map = get_expanded_map(remote_refs, refspec);
@@ -1006,10 +1025,20 @@ int get_fetch_map(const struct ref *remote_refs,
 		}
 	}
 
-	for (rm = ref_map; rm; rm = rm->next) {
-		if (rm->peer_ref && check_ref_format(rm->peer_ref->name + 5))
-			die("* refusing to create funny ref '%s' locally",
-			    rm->peer_ref->name);
+	for (rmp = &ref_map; *rmp; ) {
+		if ((*rmp)->peer_ref) {
+			int st = check_ref_format((*rmp)->peer_ref->name + 5);
+			if (st && st != CHECK_REF_FORMAT_ONELEVEL) {
+				struct ref *ignore = *rmp;
+				error("* Ignoring funny ref '%s' locally",
+				      (*rmp)->peer_ref->name);
+				*rmp = (*rmp)->next;
+				free(ignore->peer_ref);
+				free(ignore);
+				continue;
+			}
+		}
+		rmp = &((*rmp)->next);
 	}
 
 	if (ref_map)
-- 
1.5.4.3.610.gea6cd
