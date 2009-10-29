From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 02/19] Allow fetch to modify refs
Date: Thu, 29 Oct 2009 11:01:10 -0700
Message-ID: <1256839287-19016-3-git-send-email-srabbelier@gmail.com>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 29 19:02:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ZKi-0004ac-Qo
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 19:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753584AbZJ2SCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 14:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753111AbZJ2SCP
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 14:02:15 -0400
Received: from mail-pz0-f188.google.com ([209.85.222.188]:43668 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110AbZJ2SCK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 14:02:10 -0400
Received: by pzk26 with SMTP id 26so1412783pzk.4
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 11:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=2xNUTboHL/rMnNjvZQqWsakMtutVxk9UpvuHGra2KdE=;
        b=dse/5w7Mmdy4MM/ZrJ23mnTdIIODMoE5usv93/6RzZvdsxyz7CRbpqzcmx/iMKpoWT
         zSxfghH+rrlff9s+vQRWBhfT9aRXq7zFigqJiRrslatOGqEKvSRyBeizWXa4WvFh/WlZ
         CjqYumFMqDzn4wuYMiJy03n38TLyeZF4r5PYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=sbibWkDsJo5QcKcPYeRBvg/+LkC/yHQ2YBy8oUfuedufu+DxIHdjcBWcD6ihFHCBzI
         XIUwP+KiMP0ze/cqNxeH+aBthnruwX/PeTHfkOHjaUfibRyynUGRkJ2aW2lmwDiOGDfZ
         ft1SOvqpJGwx/OI3HMyL6eqVN1F7nbhs+8Jzw=
Received: by 10.115.80.7 with SMTP id h7mr273567wal.60.1256839334678;
        Thu, 29 Oct 2009 11:02:14 -0700 (PDT)
Received: from localhost.localdomain (ip67-152-86-163.z86-152-67.customer.algx.net [67.152.86.163])
        by mx.google.com with ESMTPS id 23sm1332445pxi.5.2009.10.29.11.02.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Oct 2009 11:02:13 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.2.291.gf76a3
In-Reply-To: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131622>

From: Daniel Barkalow <barkalow@iabervon.org>

This allows the transport to use the null sha1 for a ref reported to
be present in the remote repository to indicate that a ref exists but
its actual value is presently unknown and will be set if the objects
are fetched.

Also adds documentation to the API to specify exactly what the methods
should do and how they should interpret arguments.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	Signed off by me because I rebased it on master and fixed the
	conflicts with nico's patch.

 builtin-clone.c    |    5 +++--
 transport-helper.c |    4 ++--
 transport.c        |   13 +++++++------
 transport.h        |   41 +++++++++++++++++++++++++++++++++++++++--
 4 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 5762a6f..0042bee 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -526,8 +526,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 		refs = transport_get_remote_refs(transport);
 		if (refs) {
-			mapped_refs = wanted_peer_refs(refs, refspec);
-			transport_fetch_refs(transport, mapped_refs);
+			struct ref *ref_cpy = wanted_peer_refs(refs, refspec);
+			mapped_refs = ref_cpy;
+			transport_fetch_refs(transport, ref_cpy);
 		}
 	}
 
diff --git a/transport-helper.c b/transport-helper.c
index f57e84c..a0e4219 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -68,7 +68,7 @@ static int disconnect_helper(struct transport *transport)
 }
 
 static int fetch_with_fetch(struct transport *transport,
-			    int nr_heads, const struct ref **to_fetch)
+			    int nr_heads, struct ref **to_fetch)
 {
 	struct child_process *helper = get_helper(transport);
 	FILE *file = xfdopen(helper->out, "r");
@@ -92,7 +92,7 @@ static int fetch_with_fetch(struct transport *transport,
 }
 
 static int fetch(struct transport *transport,
-		 int nr_heads, const struct ref **to_fetch)
+		 int nr_heads, struct ref **to_fetch)
 {
 	struct helper_data *data = transport->data;
 	int i, count;
diff --git a/transport.c b/transport.c
index 644a30a..3822fc7 100644
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
@@ -923,16 +923,17 @@ const struct ref *transport_get_remote_refs(struct transport *transport)
 	return transport->remote_refs;
 }
 
-int transport_fetch_refs(struct transport *transport, const struct ref *refs)
+int transport_fetch_refs(struct transport *transport, struct ref *refs)
 {
 	int rc;
 	int nr_heads = 0, nr_alloc = 0, nr_refs = 0;
-	const struct ref **heads = NULL;
-	const struct ref *rm;
+	struct ref **heads = NULL;
+	struct ref *rm;
 
 	for (rm = refs; rm; rm = rm->next) {
 		nr_refs++;
 		if (rm->peer_ref &&
+		    !is_null_sha1(rm->old_sha1) &&
 		    !hashcmp(rm->peer_ref->old_sha1, rm->old_sha1))
 			continue;
 		ALLOC_GROW(heads, nr_heads + 1, nr_alloc);
diff --git a/transport.h b/transport.h
index c14da6f..503db11 100644
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
@@ -74,7 +111,7 @@ int transport_push(struct transport *connection,
 
 const struct ref *transport_get_remote_refs(struct transport *transport);
 
-int transport_fetch_refs(struct transport *transport, const struct ref *refs);
+int transport_fetch_refs(struct transport *transport, struct ref *refs);
 void transport_unlock_pack(struct transport *transport);
 int transport_disconnect(struct transport *transport);
 char *transport_anonymize_url(const char *url);
-- 
1.6.5.2.291.gf76a3
