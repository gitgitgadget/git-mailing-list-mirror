From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/2] Add allocation and freeing functions for struct refs
Date: Tue, 10 Jul 2007 00:47:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707100042150.6977@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jul 10 06:47:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I87dI-0005bY-P6
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 06:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbXGJErZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 00:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbXGJErZ
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 00:47:25 -0400
Received: from iabervon.org ([66.92.72.58]:3906 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751020AbXGJErY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 00:47:24 -0400
Received: (qmail 20499 invoked by uid 1000); 10 Jul 2007 04:47:23 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Jul 2007 04:47:23 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52040>

Instead of open-coding allocation wherever it happens, have a function. 
Also, add a function to free a list of refs, which we currently never 
actually do.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 connect.c |    2 +-
 remote.c  |   25 ++++++++++++++++++++++---
 remote.h  |    7 +++++++
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/connect.c b/connect.c
index 65e79ed..715cdc0 100644
--- a/connect.c
+++ b/connect.c
@@ -72,7 +72,7 @@ struct ref **get_remote_heads(int in, struct ref **list,
 			continue;
 		if (nr_match && !path_match(name, nr_match, match))
 			continue;
-		ref = xcalloc(1, sizeof(*ref) + len - 40);
+		ref = alloc_ref(len - 40);
 		hashcpy(ref->old_sha1, old_sha1);
 		memcpy(ref->name, buffer + 41, len - 40);
 		*list = ref;
diff --git a/remote.c b/remote.c
index 500ca4d..ed39764 100644
--- a/remote.c
+++ b/remote.c
@@ -320,6 +320,25 @@ int remote_find_tracking(struct remote *remote, struct refspec *refspec)
 	return -1;
 }
 
+struct ref *alloc_ref(unsigned namelen)
+{
+	struct ref *ret = xmalloc(sizeof(struct ref) + namelen);
+	memset(ret, 0, sizeof(struct ref) + namelen);
+	return ret;
+}
+
+void free_refs(struct ref *ref)
+{
+	struct ref *next;
+	while (ref) {
+		next = ref->next;
+		if (ref->peer_ref)
+			free(ref->peer_ref);
+		free(ref);
+		ref = next;
+	}
+}
+
 static int count_refspec_match(const char *pattern,
 			       struct ref *refs,
 			       struct ref **matched_ref)
@@ -391,7 +410,7 @@ static struct ref *try_explicit_object_name(const char *name)
 	int len;
 
 	if (!*name) {
-		ref = xcalloc(1, sizeof(*ref) + 20);
+		ref = alloc_ref(20);
 		strcpy(ref->name, "(delete)");
 		hashclr(ref->new_sha1);
 		return ref;
@@ -399,7 +418,7 @@ static struct ref *try_explicit_object_name(const char *name)
 	if (get_sha1(name, sha1))
 		return NULL;
 	len = strlen(name) + 1;
-	ref = xcalloc(1, sizeof(*ref) + len);
+	ref = alloc_ref(len);
 	memcpy(ref->name, name, len);
 	hashcpy(ref->new_sha1, sha1);
 	return ref;
@@ -411,7 +430,7 @@ static struct ref *make_dst(const char *name, struct ref ***dst_tail)
 	size_t len;
 
 	len = strlen(name) + 1;
-	dst = xcalloc(1, sizeof(*dst) + len);
+	dst = alloc_ref(len);
 	memcpy(dst->name, name, len);
 	link_dst_tail(dst, dst_tail);
 	return dst;
diff --git a/remote.h b/remote.h
index 01dbcef..080b7da 100644
--- a/remote.h
+++ b/remote.h
@@ -30,6 +30,13 @@ struct refspec {
 	char *dst;
 };
 
+struct ref *alloc_ref(unsigned namelen);
+
+/*
+ * Frees the entire list and peers of elements.
+ */
+void free_refs(struct ref *ref);
+
 int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 	       int nr_refspec, char **refspec, int all);
 
-- 
1.5.2.2.1399.g097d5-dirty
