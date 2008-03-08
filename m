From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 04/11] Mark the list of refs to fetch as const
Date: Sat, 8 Mar 2008 18:04:06 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803081804050.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 09 00:04:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY85v-0008Ar-HR
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 00:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbYCHXEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 18:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752019AbYCHXEJ
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 18:04:09 -0500
Received: from iabervon.org ([66.92.72.58]:42225 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977AbYCHXEI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 18:04:08 -0500
Received: (qmail 18571 invoked by uid 1000); 8 Mar 2008 23:04:06 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Mar 2008 23:04:06 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76603>

Fetching the objects doesn't actually modify the list in any of the
code paths, so this will allow code that fetches the entire (const)
list of available refs to just pass the list in directly.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 transport.c |   16 ++++++++--------
 transport.h |    4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/transport.c b/transport.c
index 393e0e8..a3b8052 100644
--- a/transport.c
+++ b/transport.c
@@ -203,7 +203,7 @@ static struct ref *get_refs_via_rsync(struct transport *transport)
 }
 
 static int fetch_objs_via_rsync(struct transport *transport,
-				 int nr_objs, struct ref **to_fetch)
+				int nr_objs, const struct ref **to_fetch)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct child_process rsync;
@@ -350,7 +350,7 @@ static int rsync_transport_push(struct transport *transport,
 
 #ifndef NO_CURL /* http fetch is the only user */
 static int fetch_objs_via_walker(struct transport *transport,
-				 int nr_objs, struct ref **to_fetch)
+				 int nr_objs, const struct ref **to_fetch)
 {
 	char *dest = xstrdup(transport->url);
 	struct walker *walker = transport->data;
@@ -504,7 +504,7 @@ static struct ref *get_refs_via_curl(struct transport *transport)
 }
 
 static int fetch_objs_via_curl(struct transport *transport,
-				 int nr_objs, struct ref **to_fetch)
+				 int nr_objs, const struct ref **to_fetch)
 {
 	if (!transport->data)
 		transport->data = get_http_walker(transport->url,
@@ -542,7 +542,7 @@ static struct ref *get_refs_from_bundle(struct transport *transport)
 }
 
 static int fetch_refs_from_bundle(struct transport *transport,
-			       int nr_heads, struct ref **to_fetch)
+			       int nr_heads, const struct ref **to_fetch)
 {
 	struct bundle_transport_data *data = transport->data;
 	return unbundle(&data->header, data->fd);
@@ -616,7 +616,7 @@ static struct ref *get_refs_via_connect(struct transport *transport)
 }
 
 static int fetch_refs_via_pack(struct transport *transport,
-			       int nr_heads, struct ref **to_fetch)
+			       int nr_heads, const struct ref **to_fetch)
 {
 	struct git_transport_data *data = transport->data;
 	char **heads = xmalloc(nr_heads * sizeof(*heads));
@@ -784,12 +784,12 @@ const struct ref *transport_get_remote_refs(struct transport *transport)
 	return transport->remote_refs;
 }
 
-int transport_fetch_refs(struct transport *transport, struct ref *refs)
+int transport_fetch_refs(struct transport *transport, const struct ref *refs)
 {
 	int rc;
 	int nr_heads = 0, nr_alloc = 0;
-	struct ref **heads = NULL;
-	struct ref *rm;
+	const struct ref **heads = NULL;
+	const struct ref *rm;
 
 	for (rm = refs; rm; rm = rm->next) {
 		if (rm->peer_ref &&
diff --git a/transport.h b/transport.h
index 8abfc0a..d0b5205 100644
--- a/transport.h
+++ b/transport.h
@@ -19,7 +19,7 @@ struct transport {
 			  const char *value);
 
 	struct ref *(*get_refs_list)(struct transport *transport);
-	int (*fetch)(struct transport *transport, int refs_nr, struct ref **refs);
+	int (*fetch)(struct transport *transport, int refs_nr, const struct ref **refs);
 	int (*push)(struct transport *connection, int refspec_nr, const char **refspec, int flags);
 
 	int (*disconnect)(struct transport *connection);
@@ -68,7 +68,7 @@ int transport_push(struct transport *connection,
 
 const struct ref *transport_get_remote_refs(struct transport *transport);
 
-int transport_fetch_refs(struct transport *transport, struct ref *refs);
+int transport_fetch_refs(struct transport *transport, const struct ref *refs);
 void transport_unlock_pack(struct transport *transport);
 int transport_disconnect(struct transport *transport);
 
-- 
1.5.4.3.327.g614d7.dirty

