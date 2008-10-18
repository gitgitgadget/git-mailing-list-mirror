From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/3] add alloc_ref_with_prefix()
Date: Sat, 18 Oct 2008 10:37:40 +0200
Message-ID: <48F9A054.4010703@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 18 10:39:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kr7Ky-0000GK-Tl
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 10:39:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbYJRIhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 04:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbYJRIhu
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 04:37:50 -0400
Received: from india601.server4you.de ([85.25.151.105]:39363 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbYJRIht (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 04:37:49 -0400
Received: from [10.0.1.101] (p57B7E475.dip.t-dialin.net [87.183.228.117])
	by india601.server4you.de (Postfix) with ESMTPSA id 726ED2F8058;
	Sat, 18 Oct 2008 10:37:47 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98527>

In three cases in remote.c, a "raw" ref is allocated using alloc_ref()
and then its is constructed using sprintf().  Clean it up by adding a
helper function, alloc_ref_with_prefix(), which creates a composite
name.  Use it in alloc_ref_from_str(), too, as it simplifies the code.

Open code alloc_ref() in alloc_ref_with_prefix(), as the former is
going to be removed in the patch after the next.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 remote.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/remote.c b/remote.c
index 8a04066..98cbcf9 100644
--- a/remote.c
+++ b/remote.c
@@ -749,6 +749,16 @@ int remote_find_tracking(struct remote *remote, struct refspec *refspec)
 	return -1;
 }
 
+static struct ref *alloc_ref_with_prefix(const char *prefix, size_t prefixlen,
+		const char *name)
+{
+	size_t len = strlen(name);
+	struct ref *ref = xcalloc(1, sizeof(struct ref) + prefixlen + len + 1);
+	memcpy(ref->name, prefix, prefixlen);
+	memcpy(ref->name + prefixlen, name, len);
+	return ref;
+}
+
 struct ref *alloc_ref(unsigned namelen)
 {
 	struct ref *ret = xcalloc(1, sizeof(struct ref) + namelen);
@@ -757,9 +767,7 @@ struct ref *alloc_ref(unsigned namelen)
 
 struct ref *alloc_ref_from_str(const char* str)
 {
-	struct ref *ret = alloc_ref(strlen(str) + 1);
-	strcpy(ret->name, str);
-	return ret;
+	return alloc_ref_with_prefix("", 0, str);
 }
 
 static struct ref *copy_ref(const struct ref *ref)
@@ -1152,10 +1160,8 @@ static struct ref *get_expanded_map(const struct ref *remote_refs,
 			struct ref *cpy = copy_ref(ref);
 			match = ref->name + remote_prefix_len;
 
-			cpy->peer_ref = alloc_ref(local_prefix_len +
-						  strlen(match) + 1);
-			sprintf(cpy->peer_ref->name, "%s%s",
-				refspec->dst, match);
+			cpy->peer_ref = alloc_ref_with_prefix(refspec->dst,
+					local_prefix_len, match);
 			if (refspec->force)
 				cpy->peer_ref->force = 1;
 			*tail = cpy;
@@ -1188,7 +1194,6 @@ struct ref *get_remote_ref(const struct ref *remote_refs, const char *name)
 
 static struct ref *get_local_ref(const char *name)
 {
-	struct ref *ret;
 	if (!name)
 		return NULL;
 
@@ -1198,15 +1203,10 @@ static struct ref *get_local_ref(const char *name)
 
 	if (!prefixcmp(name, "heads/") ||
 	    !prefixcmp(name, "tags/") ||
-	    !prefixcmp(name, "remotes/")) {
-		ret = alloc_ref(strlen(name) + 6);
-		sprintf(ret->name, "refs/%s", name);
-		return ret;
-	}
+	    !prefixcmp(name, "remotes/"))
+		return alloc_ref_with_prefix("refs/", 5, name);
 
-	ret = alloc_ref(strlen(name) + 12);
-	sprintf(ret->name, "refs/heads/%s", name);
-	return ret;
+	return alloc_ref_with_prefix("refs/heads/", 11, name);
 }
 
 int get_fetch_map(const struct ref *remote_refs,
-- 
1.6.0.2.542.gde55
