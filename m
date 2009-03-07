From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH v2 2/5] Use a single function to match names against
 patterns
Date: Sat, 7 Mar 2009 01:11:29 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0903070104230.19665@iabervon.org>
References: <alpine.LNX.1.00.0903052355110.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 07:13:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfpmW-0002N0-0f
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 07:13:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbZCGGLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 01:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbZCGGLc
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 01:11:32 -0500
Received: from iabervon.org ([66.92.72.58]:44320 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308AbZCGGLb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 01:11:31 -0500
Received: (qmail 6945 invoked by uid 1000); 7 Mar 2009 06:11:29 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Mar 2009 06:11:29 -0000
In-Reply-To: <alpine.LNX.1.00.0903052355110.19665@iabervon.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112513>

This will help when the matching changes.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
Improved the function name for its eventual use.

 remote.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index d7079c6..2816723 100644
--- a/remote.c
+++ b/remote.c
@@ -719,6 +719,12 @@ int remote_has_url(struct remote *remote, const char *url)
 	return 0;
 }
 
+static int match_name_with_pattern(const char *key, const char *name)
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
+			if (match_name_with_pattern(key, needle)) {
 				*result = xmalloc(strlen(value) +
 						  strlen(needle) -
 						  strlen(key) + 1);
@@ -1020,7 +1026,7 @@ static const struct refspec *check_pattern_match(const struct refspec *rs,
 			continue;
 		}
 
-		if (rs[i].pattern && !prefixcmp(src->name, rs[i].src))
+		if (rs[i].pattern && match_name_with_pattern(rs[i].src, src->name))
 			return rs + i;
 	}
 	if (matching_refs != -1)
@@ -1160,7 +1166,7 @@ static struct ref *get_expanded_map(const struct ref *remote_refs,
 	for (ref = remote_refs; ref; ref = ref->next) {
 		if (strchr(ref->name, '^'))
 			continue; /* a dereference item */
-		if (!prefixcmp(ref->name, refspec->src)) {
+		if (match_name_with_pattern(refspec->src, ref->name)) {
 			const char *match;
 			struct ref *cpy = copy_ref(ref);
 			match = ref->name + remote_prefix_len;
-- 
1.6.1.286.gd33a4.dirty
