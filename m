From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/2] Make ls-remote http://... list HEAD, like for
 git://...
Date: Sat, 26 Apr 2008 15:53:12 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804261542080.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: John Wiegley <johnw@newartisans.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 21:54:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpqTD-0001GD-3i
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 21:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755654AbYDZTxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 15:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762013AbYDZTxR
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 15:53:17 -0400
Received: from iabervon.org ([66.92.72.58]:47488 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762033AbYDZTxN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2008 15:53:13 -0400
Received: (qmail 26970 invoked by uid 1000); 26 Apr 2008 19:53:12 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Apr 2008 19:53:12 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80388>

This makes a struct ref able to represent a symref, and makes http.c
able to recognize one, and makes transport.c look for "HEAD" as a ref
in the list, and makes it dereference symrefs for the resulting ref,
if any.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
Getting HEAD for HTTP turns out to be surprisingly tricky. First, you need 
to look for it explicitly, because it's not in info/refs. Then, it's 
normally a symref, so you have to be able to handle that as a response. 
And you don't have the list of things it can reference at that point in 
the code.

In any case, it will be useful to be able to have the response from 
transport_get_remote_refs() able to mention that HEAD is a symref, and 
what it links to, so that the HEAD detection can use the remote repo's 
actual information (instead of guessing) when the remote repo provides 
that information.

 cache.h     |    1 +
 http.c      |    5 ++++-
 remote.c    |   23 ++++++++++++++++++++++-
 remote.h    |    2 ++
 transport.c |   14 ++++++++++++++
 5 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 50b28fa..7674277 100644
--- a/cache.h
+++ b/cache.h
@@ -624,6 +624,7 @@ struct ref {
 	struct ref *next;
 	unsigned char old_sha1[20];
 	unsigned char new_sha1[20];
+	char *symref;
 	unsigned int force:1,
 		merge:1,
 		nonfastforward:1,
diff --git a/http.c b/http.c
index c8df13b..acf746a 100644
--- a/http.c
+++ b/http.c
@@ -626,7 +626,10 @@ int http_fetch_ref(const char *base, struct ref *ref)
 			strbuf_rtrim(&buffer);
 			if (buffer.len == 40)
 				ret = get_sha1_hex(buffer.buf, ref->old_sha1);
-			else
+			else if (!prefixcmp(buffer.buf, "ref: ")) {
+				ref->symref = xstrdup(buffer.buf + 5);
+				ret = 0;
+			} else
 				ret = 1;
 		} else {
 			ret = error("Couldn't get %s for %s\n%s",
diff --git a/remote.c b/remote.c
index 06ad156..a54f0f7 100644
--- a/remote.c
+++ b/remote.c
@@ -706,13 +706,22 @@ struct ref *copy_ref_list(const struct ref *ref)
 	return ret;
 }
 
+void free_ref(struct ref *ref)
+{
+	if (!ref)
+		return;
+	free(ref->remote_status);
+	free(ref->symref);
+	free(ref);
+}
+
 void free_refs(struct ref *ref)
 {
 	struct ref *next;
 	while (ref) {
 		next = ref->next;
 		free(ref->peer_ref);
-		free(ref);
+		free_ref(ref);
 		ref = next;
 	}
 }
@@ -1146,3 +1155,15 @@ int get_fetch_map(const struct ref *remote_refs,
 
 	return 0;
 }
+
+int resolve_remote_symref(struct ref *ref, struct ref *list)
+{
+	if (!ref->symref)
+		return 0;
+	for (; list; list = list->next)
+		if (!strcmp(ref->symref, list->name)) {
+			hashcpy(ref->old_sha1, list->old_sha1);
+			return 0;
+		}
+	return 1;
+}
diff --git a/remote.h b/remote.h
index a38774b..ab82308 100644
--- a/remote.h
+++ b/remote.h
@@ -62,6 +62,8 @@ int check_ref_type(const struct ref *ref, int flags);
  */
 void free_refs(struct ref *ref);
 
+int resolve_remote_symref(struct ref *ref, struct ref *list);
+
 /*
  * Removes and frees any duplicate refs in the map.
  */
diff --git a/transport.c b/transport.c
index 393e0e8..b012a28 100644
--- a/transport.c
+++ b/transport.c
@@ -441,10 +441,14 @@ static struct ref *get_refs_via_curl(struct transport *transport)
 	struct ref *ref = NULL;
 	struct ref *last_ref = NULL;
 
+	struct walker *walker;
+
 	if (!transport->data)
 		transport->data = get_http_walker(transport->url,
 						transport->remote);
 
+	walker = transport->data;
+
 	refs_url = xmalloc(strlen(transport->url) + 11);
 	sprintf(refs_url, "%s/info/refs", transport->url);
 
@@ -500,6 +504,16 @@ static struct ref *get_refs_via_curl(struct transport *transport)
 
 	strbuf_release(&buffer);
 
+	ref = alloc_ref(strlen("HEAD") + 1);
+	strcpy(ref->name, "HEAD");
+	if (!walker->fetch_ref(walker, ref) &&
+	    !resolve_remote_symref(ref, refs)) {
+		ref->next = refs;
+		refs = ref;
+	} else {
+		free(ref);
+	}
+
 	return refs;
 }
 
-- 
1.5.4.3.610.gea6cd
