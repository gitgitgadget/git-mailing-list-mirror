From: Johan Herland <johan@herland.net>
Subject: [RFCv2 01/12] Allow late reporting of fetched hashes
Date: Fri, 31 Jul 2009 12:00:21 +0200
Message-ID: <1249034432-31437-2-git-send-email-johan@herland.net>
References: <1249034432-31437-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Daniel Barkalow <barkalow@iabervon.org>, gitster@pobox.com,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 31 12:01:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWovZ-0007a3-KY
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 12:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbZGaKBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 06:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbZGaKBX
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 06:01:23 -0400
Received: from mx.getmail.no ([84.208.15.66]:46007 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751528AbZGaKBW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jul 2009 06:01:22 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNN00GD756A0220@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 31 Jul 2009 12:01:22 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNN005FA55FU840@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 31 Jul 2009 12:01:22 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.7.31.94825
X-Mailer: git-send-email 1.6.4.rc3.138.ga6b98.dirty
In-reply-to: <1249034432-31437-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124522>

From: Daniel Barkalow <barkalow@iabervon.org>

Some future transports (in particular, foreign VCS importers) will
only report the hashes of new commits when the objects are also
available. In preparation, allow fetch_refs() to modify the refs it
gets (in particular, the remote side's sha1), and treat the null sha1,
when reported by get_ref_list(), as different from any value,
including itself (which, when local, indicates that the local version
doesn't exist yet).

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin-clone.c |    6 ++++--
 transport.c     |   17 +++++++++--------
 transport.h     |    4 ++--
 3 files changed, 15 insertions(+), 12 deletions(-)

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
diff --git a/transport.c b/transport.c
index 8a42e76..349ccae 100644
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
@@ -500,7 +500,7 @@ static struct ref *get_refs_via_curl(struct transport *transport, int for_push)
 }
 
 static int fetch_objs_via_curl(struct transport *transport,
-				 int nr_objs, const struct ref **to_fetch)
+				 int nr_objs, struct ref **to_fetch)
 {
 	if (!transport->data)
 		transport->data = get_http_walker(transport->url,
@@ -540,7 +540,7 @@ static struct ref *get_refs_from_bundle(struct transport *transport, int for_pus
 }
 
 static int fetch_refs_from_bundle(struct transport *transport,
-			       int nr_heads, const struct ref **to_fetch)
+			       int nr_heads, struct ref **to_fetch)
 {
 	struct bundle_transport_data *data = transport->data;
 	return unbundle(&data->header, data->fd);
@@ -618,7 +618,7 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 }
 
 static int fetch_refs_via_pack(struct transport *transport,
-			       int nr_heads, const struct ref **to_fetch)
+			       int nr_heads, struct ref **to_fetch)
 {
 	struct git_transport_data *data = transport->data;
 	char **heads = xmalloc(nr_heads * sizeof(*heads));
@@ -1032,15 +1032,16 @@ const struct ref *transport_get_remote_refs(struct transport *transport)
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
index 51b5397..3cb0abc 100644
--- a/transport.h
+++ b/transport.h
@@ -19,7 +19,7 @@ struct transport {
 			  const char *value);
 
 	struct ref *(*get_refs_list)(struct transport *transport, int for_push);
-	int (*fetch)(struct transport *transport, int refs_nr, const struct ref **refs);
+	int (*fetch)(struct transport *transport, int refs_nr, struct ref **refs);
 	int (*push_refs)(struct transport *transport, struct ref *refs, int flags);
 	int (*push)(struct transport *connection, int refspec_nr, const char **refspec, int flags);
 
@@ -72,7 +72,7 @@ int transport_push(struct transport *connection,
 
 const struct ref *transport_get_remote_refs(struct transport *transport);
 
-int transport_fetch_refs(struct transport *transport, const struct ref *refs);
+int transport_fetch_refs(struct transport *transport, struct ref *refs);
 void transport_unlock_pack(struct transport *transport);
 int transport_disconnect(struct transport *transport);
 char *transport_anonymize_url(const char *url);
-- 
1.6.4.rc3.138.ga6b98.dirty
