From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 3/8] Allow fetch to modify refs
Date: Sun, 9 Aug 2009 15:28:15 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908091526550.27553@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 21:29:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaE4f-0005Sd-RT
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 21:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbZHIT2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 15:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752779AbZHIT2R
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 15:28:17 -0400
Received: from iabervon.org ([66.92.72.58]:33230 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752476AbZHIT2P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 15:28:15 -0400
Received: (qmail 12201 invoked by uid 1000); 9 Aug 2009 19:28:15 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Aug 2009 19:28:15 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125369>

This allows the transport to use the null sha1 for a ref reported to
be present in the remote repository to indicate that a ref exists but
its actual value is presently unknown and will be set if the objects
are fetched.

Also adds documentation to the API to specify exactly what the methods
should do and how they should interpret arguments.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-clone.c    |    6 ++++--
 transport-helper.c |    4 ++--
 transport.c        |   13 +++++++------
 transport.h        |   41 +++++++++++++++++++++++++++++++++++++++--
 4 files changed, 52 insertions(+), 12 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 32dea74..f281756 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -509,8 +509,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
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
diff --git a/transport-helper.c b/transport-helper.c
index cb255e4..a5ac575 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -70,7 +70,7 @@ static int disconnect_helper(struct transport *transport)
 }
 
 static int fetch_with_fetch(struct transport *transport,
-			    int nr_heads, const struct ref **to_fetch)
+			    int nr_heads, struct ref **to_fetch)
 {
 	struct child_process *helper = get_helper(transport);
 	FILE *file = fdopen(helper->out, "r");
@@ -94,7 +94,7 @@ static int fetch_with_fetch(struct transport *transport,
 }
 
 static int fetch(struct transport *transport,
-		 int nr_heads, const struct ref **to_fetch)
+		 int nr_heads, struct ref **to_fetch)
 {
 	struct helper_data *data = transport->data;
 	int i, count;
diff --git a/transport.c b/transport.c
index 6e8a651..6fcdf59 100644
--- a/transport.c
+++ b/transport.c
@@ -204,7 +204,7 @@ static struct ref *get_refs_via_rsync(struct transport *transport, int for_push)
 }
 
 static int fetch_objs_via_rsync(struct transport *transport,
-				int nr_objs, const struct ref **to_fetch)
+				int nr_objs, struct ref **to_fetch)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct child_process rsync;
@@ -408,7 +408,7 @@ static struct ref *get_refs_from_bundle(struct transport *transport, int for_pus
 }
 
 static int fetch_refs_from_bundle(struct transport *transport,
-			       int nr_heads, const struct ref **to_fetch)
+			       int nr_heads, struct ref **to_fetch)
 {
 	struct bundle_transport_data *data = transport->data;
 	return unbundle(&data->header, data->fd);
@@ -486,7 +486,7 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 }
 
 static int fetch_refs_via_pack(struct transport *transport,
-			       int nr_heads, const struct ref **to_fetch)
+			       int nr_heads, struct ref **to_fetch)
 {
 	struct git_transport_data *data = transport->data;
 	char **heads = xmalloc(nr_heads * sizeof(*heads));
@@ -917,15 +917,16 @@ const struct ref *transport_get_remote_refs(struct transport *transport)
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
index 9787fc8..d6aacf6 100644
--- a/transport.h
+++ b/transport.h
@@ -18,11 +18,48 @@ struct transport {
 	int (*set_option)(struct transport *connection, const char *name,
 			  const char *value);
 
+	/**
+	 * Returns a list of the remote side's refs. In order to allow
+	 * the transport to try to share connections, for_push is a
+	 * hint as to whether the ultimate operation is a push or a fetch.
+	 *
+	 * If the transport is able to determine the remote hash for
+	 * the ref without a huge amount of effort, it should store it
+	 * in the ref's old_sha1 field; otherwise it should be all 0.
+	 **/
 	struct ref *(*get_refs_list)(struct transport *transport, int for_push);
-	int (*fetch)(struct transport *transport, int refs_nr, const struct ref **refs);
+
+	/**
+	 * Fetch the objects for the given refs. Note that this gets
+	 * an array, and should ignore the list structure.
+	 *
+	 * If the transport did not get hashes for refs in
+	 * get_refs_list(), it should set the old_sha1 fields in the
+	 * provided refs now.
+	 **/
+	int (*fetch)(struct transport *transport, int refs_nr, struct ref **refs);
+
+	/**
+	 * Push the objects and refs. Send the necessary objects, and
+	 * then, for any refs where peer_ref is set and
+	 * peer_ref->new_sha1 is different from old_sha1, tell the
+	 * remote side to update each ref in the list from old_sha1 to
+	 * peer_ref->new_sha1.
+	 *
+	 * Where possible, set the status for each ref appropriately.
+	 *
+	 * The transport must modify new_sha1 in the ref to the new
+	 * value if the remote accepted the change. Note that this
+	 * could be a different value from peer_ref->new_sha1 if the
+	 * process involved generating new commits.
+	 **/
 	int (*push_refs)(struct transport *transport, struct ref *refs, int flags);
 	int (*push)(struct transport *connection, int refspec_nr, const char **refspec, int flags);
 
+	/** get_refs_list(), fetch(), and push_refs() can keep
+	 * resources (such as a connection) reserved for futher
+	 * use. disconnect() releases these resources.
+	 **/
 	int (*disconnect)(struct transport *connection);
 	char *pack_lockfile;
 	signed verbose : 2;
@@ -73,7 +110,7 @@ int transport_push(struct transport *connection,
 
 const struct ref *transport_get_remote_refs(struct transport *transport);
 
-int transport_fetch_refs(struct transport *transport, const struct ref *refs);
+int transport_fetch_refs(struct transport *transport, struct ref *refs);
 void transport_unlock_pack(struct transport *transport);
 int transport_disconnect(struct transport *transport);
 char *transport_anonymize_url(const char *url);
-- 
1.6.4.183.g77eb9.dirty
