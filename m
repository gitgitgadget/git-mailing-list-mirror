From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/5] Allow late reporting of fetched hashes
Date: Tue, 24 Mar 2009 23:04:07 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903242303070.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 04:05:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmJRB-00061j-9G
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 04:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756417AbZCYDEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 23:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755560AbZCYDEM
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 23:04:12 -0400
Received: from iabervon.org ([66.92.72.58]:43751 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752967AbZCYDEK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 23:04:10 -0400
Received: (qmail 11066 invoked by uid 1000); 25 Mar 2009 03:04:07 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Mar 2009 03:04:07 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114546>

Some future transports (in particular, foreign VCS importers) will
only report the hashes of new commits when the objects are also
available. In preparation, allow fetch_refs() to modify the refs it
gets (in particular, the remote side's sha1), and treat the null sha1,
when reported by get_ref_list(), as different from any value,
including itself (which, when local, indicates that the local version
doesn't exist yet).

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-clone.c |    6 ++++--
 transport.c     |   17 +++++++++--------
 transport.h     |    4 ++--
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 0031b5f..ab51974 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -485,8 +485,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 					     option_upload_pack);
 
 		refs = transport_get_remote_refs(transport);
-		if(refs)
-			transport_fetch_refs(transport, refs);
+		if (refs) {
+			struct ref *ref_cpy = copy_ref_list(refs);
+			transport_fetch_refs(transport, ref_cpy);
+		}
 	}
 
 	if (refs) {
diff --git a/transport.c b/transport.c
index 3dfb03c..26c578e 100644
--- a/transport.c
+++ b/transport.c
@@ -207,7 +207,7 @@ static struct ref *get_refs_via_rsync(struct transport *transport, int for_push)
 }
 
 static int fetch_objs_via_rsync(struct transport *transport,
-				int nr_objs, const struct ref **to_fetch)
+				int nr_objs, struct ref **to_fetch)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct child_process rsync;
@@ -356,7 +356,7 @@ static int rsync_transport_push(struct transport *transport,
 
 #ifndef NO_CURL /* http fetch is the only user */
 static int fetch_objs_via_walker(struct transport *transport,
-				 int nr_objs, const struct ref **to_fetch)
+				 int nr_objs, struct ref **to_fetch)
 {
 	char *dest = xstrdup(transport->url);
 	struct walker *walker = transport->data;
@@ -523,7 +523,7 @@ static struct ref *get_refs_via_curl(struct transport *transport, int for_push)
 }
 
 static int fetch_objs_via_curl(struct transport *transport,
-				 int nr_objs, const struct ref **to_fetch)
+				 int nr_objs, struct ref **to_fetch)
 {
 	if (!transport->data)
 		transport->data = get_http_walker(transport->url,
@@ -563,7 +563,7 @@ static struct ref *get_refs_from_bundle(struct transport *transport, int for_pus
 }
 
 static int fetch_refs_from_bundle(struct transport *transport,
-			       int nr_heads, const struct ref **to_fetch)
+			       int nr_heads, struct ref **to_fetch)
 {
 	struct bundle_transport_data *data = transport->data;
 	return unbundle(&data->header, data->fd);
@@ -641,7 +641,7 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 }
 
 static int fetch_refs_via_pack(struct transport *transport,
-			       int nr_heads, const struct ref **to_fetch)
+			       int nr_heads, struct ref **to_fetch)
 {
 	struct git_transport_data *data = transport->data;
 	char **heads = xmalloc(nr_heads * sizeof(*heads));
@@ -1046,15 +1046,16 @@ const struct ref *transport_get_remote_refs(struct transport *transport)
 	return transport->remote_refs;
 }
 
-int transport_fetch_refs(struct transport *transport, const struct ref *refs)
+int transport_fetch_refs(struct transport *transport, struct ref *refs)
 {
 	int rc;
 	int nr_heads = 0, nr_alloc = 0;
-	const struct ref **heads = NULL;
-	const struct ref *rm;
+	struct ref **heads = NULL;
+	struct ref *rm;
 
 	for (rm = refs; rm; rm = rm->next) {
 		if (rm->peer_ref &&
+		    !is_null_sha1(rm->old_sha1) &&
 		    !hashcmp(rm->peer_ref->old_sha1, rm->old_sha1))
 			continue;
 		ALLOC_GROW(heads, nr_heads + 1, nr_alloc);
diff --git a/transport.h b/transport.h
index b1c2252..489e96a 100644
--- a/transport.h
+++ b/transport.h
@@ -19,7 +19,7 @@ struct transport {
 			  const char *value);
 
 	struct ref *(*get_refs_list)(struct transport *transport, int for_push);
-	int (*fetch)(struct transport *transport, int refs_nr, const struct ref **refs);
+	int (*fetch)(struct transport *transport, int refs_nr, struct ref **refs);
 	int (*push_refs)(struct transport *transport, struct ref *refs, int flags);
 	int (*push)(struct transport *connection, int refspec_nr, const char **refspec, int flags);
 
@@ -71,7 +71,7 @@ int transport_push(struct transport *connection,
 
 const struct ref *transport_get_remote_refs(struct transport *transport);
 
-int transport_fetch_refs(struct transport *transport, const struct ref *refs);
+int transport_fetch_refs(struct transport *transport, struct ref *refs);
 void transport_unlock_pack(struct transport *transport);
 int transport_disconnect(struct transport *transport);
 
-- 
1.6.2.1.476.g9bf04b
