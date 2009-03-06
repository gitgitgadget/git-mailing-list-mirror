From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/5] Use a single function to match names against patterns
Date: Thu, 5 Mar 2009 23:56:18 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0903052355110.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 05:57:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfS83-0008Rl-0Z
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 05:57:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752971AbZCFE4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 23:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752650AbZCFE4W
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 23:56:22 -0500
Received: from iabervon.org ([66.92.72.58]:51778 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752757AbZCFE4V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 23:56:21 -0500
Received: (qmail 6364 invoked by uid 1000); 6 Mar 2009 04:56:18 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Mar 2009 04:56:18 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112381>

This will help when the matching changes.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 remote.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index d7079c6..709300b 100644
--- a/remote.c
+++ b/remote.c
@@ -719,6 +719,12 @@ int remote_has_url(struct remote *remote, const char *url)
 	return 0;
 }
 
+static int name_fits_pattern(const char *key, const char *name)
+{
+	int ret = !prefixcmp(key, name);
+	return ret;
+}
+
 int remote_find_tracking(struct remote *remote, struct refspec *refspec)
 {
 	int find_src = refspec->src == NULL;
@@ -742,7 +748,7 @@ int remote_find_tracking(struct remote *remote, struct refspec *refspec)
 		if (!fetch->dst)
 			continue;
 		if (fetch->pattern) {
-			if (!prefixcmp(needle, key)) {
+			if (name_fits_pattern(key, needle)) {
 				*result = xmalloc(strlen(value) +
 						  strlen(needle) -
 						  strlen(key) + 1);
@@ -1020,7 +1026,7 @@ static const struct refspec *check_pattern_match(const struct refspec *rs,
 			continue;
 		}
 
-		if (rs[i].pattern && !prefixcmp(src->name, rs[i].src))
+		if (rs[i].pattern && name_fits_pattern(rs[i].src, src->name))
 			return rs + i;
 	}
 	if (matching_refs != -1)
@@ -1160,7 +1166,7 @@ static struct ref *get_expanded_map(const struct ref *remote_refs,
 	for (ref = remote_refs; ref; ref = ref->next) {
 		if (strchr(ref->name, '^'))
 			continue; /* a dereference item */
-		if (!prefixcmp(ref->name, refspec->src)) {
+		if (name_fits_pattern(refspec->src, ref->name)) {
 			const char *match;
 			struct ref *cpy = copy_ref(ref);
 			match = ref->name + remote_prefix_len;
-- 
1.6.1.286.gd33a4.dirty
