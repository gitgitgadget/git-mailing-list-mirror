From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v4 04/12] Allow fetch to modify refs
Date: Wed, 18 Nov 2009 02:42:24 +0100
Message-ID: <1258508552-20752-5-git-send-email-srabbelier@gmail.com>
References: <1258508552-20752-1-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-2-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-3-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-4-git-send-email-srabbelier@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 18 02:44:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAZap-0000vW-4P
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 02:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756830AbZKRBnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 20:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756828AbZKRBnb
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 20:43:31 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:40383 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756775AbZKRBn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 20:43:28 -0500
Received: by ey-out-2122.google.com with SMTP id 25so5818eya.19
        for <git@vger.kernel.org>; Tue, 17 Nov 2009 17:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=QDLDkttillFbfl44h0RLvKG7yz0GiIq1B6P/Q4bKjOQ=;
        b=YNySOxqUrSsJt+lXDWRqdCuoIQj03g9ImgzKv9X3ViB2iprpjG/tjG1Y0NQlrX/E/l
         kAm8+PzyroEhqiQXEEDpr9zsy0RSQ2id9AX+KHUoA/4fxbbFlQv4gmSrIOef/WYssDZj
         4i8AQKj40UhHCP8cH0ZF1lxIhVgIAln0/D9IM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=p4bbtmtQeZAoUSw4TmvdpwK4XxvLeD7W+CssfARApGe7xwvAqBjrjnfZvHxV+wuPB4
         ZDUF29E2NOFcPQYYsjJ8slqfEVPZXgq8gaRHXqOM7j20qSOMPMY94Jx9LPVlDX6DiVuf
         o7RfKomHGzquY2yUCvYRwbmOVhOsMisE4krAc=
Received: by 10.213.0.138 with SMTP id 10mr3023485ebb.12.1258508613503;
        Tue, 17 Nov 2009 17:43:33 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 28sm2372670eye.3.2009.11.17.17.43.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Nov 2009 17:43:32 -0800 (PST)
X-Mailer: git-send-email 1.6.5.3.164.g07b0c
In-Reply-To: <1258508552-20752-4-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133130>

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

	Unchanged.

 builtin-clone.c    |    3 ++-
 transport-helper.c |    4 ++--
 transport.c        |   13 +++++++------
 transport.h        |   41 +++++++++++++++++++++++++++++++++++++++--
 4 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index caf3025..5df8b0f 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -362,9 +362,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	const char *repo_name, *repo, *work_tree, *git_dir;
 	char *path, *dir;
 	int dest_exists;
-	const struct ref *refs, *remote_head, *mapped_refs;
+	const struct ref *refs, *remote_head;
 	const struct ref *remote_head_points_at;
 	const struct ref *our_head_points_at;
+	struct ref *mapped_refs;
 	struct strbuf key = STRBUF_INIT, value = STRBUF_INIT;
 	struct strbuf branch_top = STRBUF_INIT, reflog_msg = STRBUF_INIT;
 	struct transport *transport = NULL;
diff --git a/transport-helper.c b/transport-helper.c
index e24fcbb..53d8f08 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -75,7 +75,7 @@ static int release_helper(struct transport *transport)
 }
 
 static int fetch_with_fetch(struct transport *transport,
-			    int nr_heads, const struct ref **to_fetch)
+			    int nr_heads, struct ref **to_fetch)
 {
 	struct child_process *helper = get_helper(transport);
 	FILE *file = xfdopen(helper->out, "r");
@@ -99,7 +99,7 @@ static int fetch_with_fetch(struct transport *transport,
 }
 
 static int fetch(struct transport *transport,
-		 int nr_heads, const struct ref **to_fetch)
+		 int nr_heads, struct ref **to_fetch)
 {
 	struct helper_data *data = transport->data;
 	int i, count;
diff --git a/transport.c b/transport.c
index 4987555..e882991 100644
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
@@ -929,16 +929,17 @@ const struct ref *transport_get_remote_refs(struct transport *transport)
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
1.6.5.3.164.g07b0c
