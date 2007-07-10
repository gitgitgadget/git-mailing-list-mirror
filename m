From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/2] Some cosmetic changes to remote library
Date: Tue, 10 Jul 2007 00:47:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707100045380.6977@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jul 10 06:47:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I87dT-0005dU-Rw
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 06:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbXGJEr3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 00:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbXGJEr3
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 00:47:29 -0400
Received: from iabervon.org ([66.92.72.58]:3908 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751303AbXGJEr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 00:47:28 -0400
Received: (qmail 20503 invoked by uid 1000); 10 Jul 2007 04:47:26 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Jul 2007 04:47:26 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52041>

Functions for managing ref lists were named based on their use in
match_refs (for push). For fetch, they will be used for other purposes, so 
rename them as a separate patch to make the future code readable.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 remote.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/remote.c b/remote.c
index ed39764..0b831c5 100644
--- a/remote.c
+++ b/remote.c
@@ -396,11 +396,12 @@ static int count_refspec_match(const char *pattern,
 	}
 }
 
-static void link_dst_tail(struct ref *ref, struct ref ***tail)
+static void tail_link_ref(struct ref *ref, struct ref ***tail)
 {
 	**tail = ref;
+	while (ref->next)
+		ref = ref->next;
 	*tail = &ref->next;
-	**tail = NULL;
 }
 
 static struct ref *try_explicit_object_name(const char *name)
@@ -424,16 +425,16 @@ static struct ref *try_explicit_object_name(const char *name)
 	return ref;
 }
 
-static struct ref *make_dst(const char *name, struct ref ***dst_tail)
+static struct ref *make_linked_ref(const char *name, struct ref ***tail)
 {
-	struct ref *dst;
+	struct ref *ret;
 	size_t len;
 
 	len = strlen(name) + 1;
-	dst = alloc_ref(len);
-	memcpy(dst->name, name, len);
-	link_dst_tail(dst, dst_tail);
-	return dst;
+	ret = alloc_ref(len);
+	memcpy(ret->name, name, len);
+	tail_link_ref(ret, tail);
+	return ret;
 }
 
 static int match_explicit(struct ref *src, struct ref *dst,
@@ -481,7 +482,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		break;
 	case 0:
 		if (!memcmp(dst_value, "refs/", 5))
-			matched_dst = make_dst(dst_value, dst_tail);
+			matched_dst = make_linked_ref(dst_value, dst_tail);
 		else
 			error("dst refspec %s does not match any "
 			      "existing ref on the remote and does "
@@ -584,7 +585,7 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 			goto free_name;
 		if (!dst_peer) {
 			/* Create a new one and link it */
-			dst_peer = make_dst(dst_name, dst_tail);
+			dst_peer = make_linked_ref(dst_name, dst_tail);
 			hashcpy(dst_peer->new_sha1, src->new_sha1);
 		}
 		dst_peer->peer_ref = src;
-- 
1.5.2.2.1399.g097d5-dirty
