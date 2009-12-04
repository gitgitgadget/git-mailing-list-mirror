From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH v2 3/8] Support taking over transports
Date: Fri,  4 Dec 2009 17:56:03 +0200
Message-ID: <1259942168-24869-6-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1259942168-24869-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 04 16:59:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGaWW-00029p-Mh
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 16:56:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756841AbZLDP4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 10:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756845AbZLDP4f
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 10:56:35 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:41968 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756841AbZLDP4f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 10:56:35 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 5E45E18D486
	for <git@vger.kernel.org>; Fri,  4 Dec 2009 17:56:40 +0200 (EET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A03DB95B442; Fri, 04 Dec 2009 17:56:40 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id B9E782BD44
	for <git@vger.kernel.org>; Fri,  4 Dec 2009 17:56:37 +0200 (EET)
X-Mailer: git-send-email 1.6.6.rc1.288.g40e67
In-Reply-To: <1259942168-24869-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134520>

Add support for taking over transports that turn out to be smart.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 transport-helper.c |   12 +++++++
 transport.c        |   89 +++++++++++++++++++++++++++++++++++++++++++++++----
 transport.h        |   15 +++++++++
 3 files changed, 109 insertions(+), 7 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index d3aad5c..5d17fb5 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -20,8 +20,18 @@ struct helper_data
 	/* These go from remote name (as in "list") to private name */
 	struct refspec *refspecs;
 	int refspec_nr;
+	struct git_transport_options gitoptions;
 };
 
+static struct child_process* helper_disown(struct transport *transport)
+{
+	struct helper_data *data = transport->data;
+	struct child_process *child = data->helper;
+	fclose(data->out);
+	free(data);
+	return child;
+}
+
 const char* remove_ext_force(const char* url)
 {
 	const char* url2 = url;
@@ -549,5 +559,7 @@ int transport_helper_init(struct transport *transport, const char *name)
 	transport->fetch = fetch;
 	transport->push_refs = push_refs;
 	transport->disconnect = release_helper;
+	transport->disown = helper_disown;
+	transport->smart_options = &(data->gitoptions);
 	return 0;
 }
diff --git a/transport.c b/transport.c
index 21310c5..7e6ef2b 100644
--- a/transport.c
+++ b/transport.c
@@ -9,6 +9,8 @@
 #include "dir.h"
 #include "refs.h"
 
+struct ref special_transport_layer6_ready;
+
 /* rsync support */
 
 /*
@@ -398,6 +400,8 @@ struct git_transport_data {
 	struct git_transport_options options;
 	struct child_process *conn;
 	int fd[2];
+	/* Connection is fully up. */
+	unsigned virtual_connected : 1;
 	struct extra_have_objects extra_have;
 };
 
@@ -432,10 +436,21 @@ static int set_git_option(struct git_transport_options *opts,
 static int connect_setup(struct transport *transport, int for_push, int verbose)
 {
 	struct git_transport_data *data = transport->data;
+
+	if(!data->virtual_connected && data->conn) {
+		/* Just mark it connected. */
+		data->virtual_connected = 1;
+		return 0;
+	}
+
 	data->conn = git_connect(data->fd, transport->url,
 				 for_push ? data->options.receivepack :
 				 data->options.uploadpack,
 				 verbose ? CONNECT_VERBOSE : 0);
+
+	if(data->conn)
+		data->virtual_connected = 1;
+
 	return 0;
 }
 
@@ -477,7 +492,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	for (i = 0; i < nr_heads; i++)
 		origh[i] = heads[i] = xstrdup(to_fetch[i]->name);
 
-	if (!data->conn) {
+	if (!data->virtual_connected) {
 		connect_setup(transport, 0, 0);
 		get_remote_heads(data->fd[0], &refs_tmp, 0, NULL, 0, NULL);
 	}
@@ -490,6 +505,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	if (finish_connect(data->conn))
 		refs = NULL;
 	data->conn = NULL;
+	data->virtual_connected = 0;
 
 	free_refs(refs_tmp);
 
@@ -718,7 +734,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	struct send_pack_args args;
 	int ret;
 
-	if (!data->conn) {
+	if (!data->virtual_connected) {
 		struct ref *tmp_refs;
 		connect_setup(transport, 1, 0);
 
@@ -741,6 +757,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	close(data->fd[0]);
 	ret |= finish_connect(data->conn);
 	data->conn = NULL;
+	data->virtual_connected = 0;
 
 	return ret;
 }
@@ -749,7 +766,8 @@ static int disconnect_git(struct transport *transport)
 {
 	struct git_transport_data *data = transport->data;
 	if (data->conn) {
-		packet_flush(data->fd[1]);
+		if(data->virtual_connected)
+			packet_flush(data->fd[1]);
 		close(data->fd[0]);
 		close(data->fd[1]);
 		finish_connect(data->conn);
@@ -759,6 +777,35 @@ static int disconnect_git(struct transport *transport)
 	return 0;
 }
 
+static void git_take_over_transport(struct transport *transport)
+{
+	struct git_transport_data *data;
+
+	if(!transport->disown)
+		die("Bug detected: Taking over transport requires non-NULL "
+		    "disown method.");
+	if(!transport->smart_options)
+		die("Bug detected: Taking over transport requires non-NULL "
+		    "smart_options field.");
+
+	data = xcalloc(1, sizeof(*data));
+	data->options = *transport->smart_options;
+	data->conn = transport->disown(transport);
+	data->fd[0] = data->conn->out;
+	data->fd[1] = data->conn->in;
+	data->virtual_connected = 0;
+	transport->data = data;
+
+	transport->set_option = NULL;
+	transport->get_refs_list = get_refs_via_connect;
+	transport->fetch = fetch_refs_via_pack;
+	transport->push = NULL;
+	transport->push_refs = git_transport_push;
+	transport->disconnect = disconnect_git;
+	transport->smart_options = &(data->options);
+	transport->disown = NULL;
+}
+
 static int is_local(const char *url)
 {
 	const char *colon = strchr(url, ':');
@@ -857,6 +904,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		ret->fetch = fetch_objs_via_rsync;
 		ret->push = rsync_transport_push;
 		ret->smart_options = NULL;
+		ret->disown = NULL;
 	} else if (is_local(url) && is_file(url)) {
 		struct bundle_transport_data *data = xcalloc(1, sizeof(*data));
 		ret->data = data;
@@ -864,6 +912,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		ret->fetch = fetch_refs_from_bundle;
 		ret->disconnect = close_bundle;
 		ret->smart_options = NULL;
+		ret->disown = NULL;
 	} else if(!is_url(url)
 		|| !prefixcmp(url, "file://")
 		|| !prefixcmp(url, "git://")
@@ -879,8 +928,10 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		ret->push_refs = git_transport_push;
 		ret->disconnect = disconnect_git;
 		ret->smart_options = &(data->options);
+		ret->disown = NULL;
 
 		data->conn = NULL;
+		data->virtual_connected = 0;
 	} else if (!prefixcmp(url, "http://")
 		|| !prefixcmp(url, "https://")
 		|| !prefixcmp(url, "ftp://")) {
@@ -938,14 +989,25 @@ int transport_push(struct transport *transport,
 		   int refspec_nr, const char **refspec, int flags,
 		   int *nonfastforward)
 {
+	int rc = 0;
 	*nonfastforward = 0;
 	verify_remote_names(refspec_nr, refspec);
 
-	if (transport->push)
-		return transport->push(transport, refspec_nr, refspec, flags);
-	if (transport->push_refs) {
+retry:
+	if (transport->push) {
+		rc = transport->push(transport, refspec_nr, refspec, flags);
+		if(rc == TRANSPORT_LAYER6_READY) {
+			git_take_over_transport(transport);
+			goto retry;
+		}
+		return rc;
+	} else if (transport->push_refs) {
 		struct ref *remote_refs =
 			transport->get_refs_list(transport, 1);
+		if(remote_refs == &special_transport_layer6_ready) {
+			git_take_over_transport(transport);
+			goto retry;
+		}
 		struct ref *local_refs = get_local_heads();
 		int match_flags = MATCH_REFS_NONE;
 		int verbose = flags & TRANSPORT_PUSH_VERBOSE;
@@ -985,8 +1047,15 @@ int transport_push(struct transport *transport,
 
 const struct ref *transport_get_remote_refs(struct transport *transport)
 {
-	if (!transport->remote_refs)
+	if (!transport->remote_refs) {
+retry:
 		transport->remote_refs = transport->get_refs_list(transport, 0);
+		if(transport->remote_refs == &special_transport_layer6_ready) {
+			git_take_over_transport(transport);
+			goto retry;
+		}
+	}
+
 	return transport->remote_refs;
 }
 
@@ -1020,7 +1089,13 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 			heads[nr_heads++] = rm;
 	}
 
+retry:
 	rc = transport->fetch(transport, nr_heads, heads);
+	if(rc == TRANSPORT_LAYER6_READY) {
+		git_take_over_transport(transport);
+		goto retry;
+	}
+
 	free(heads);
 	return rc;
 }
diff --git a/transport.h b/transport.h
index 5949132..f3ee890 100644
--- a/transport.h
+++ b/transport.h
@@ -65,6 +65,15 @@ struct transport {
 	int (*push_refs)(struct transport *transport, struct ref *refs, int flags);
 	int (*push)(struct transport *connection, int refspec_nr, const char **refspec, int flags);
 
+	/**
+	 * Disown the transport helper. Releases all resources used
+	 * by field pointed by member data, except that the child
+	 * process is not released but returned and whatever is pointed
+	 * by smart transport options structure is not freed (but the
+	 * smart transport options structure itself is).
+	 **/
+	struct child_process* (*disown)(struct transport* connection);
+
 	/** get_refs_list(), fetch(), and push_refs() can keep
 	 * resources (such as a connection) reserved for futher
 	 * use. disconnect() releases these resources.
@@ -79,6 +88,12 @@ struct transport {
 	struct git_transport_options* smart_options;
 };
 
+/* Returned by get_refs_list, fetch or push methods of struct transport: Layer 6 is ready,
+   take over the transport and retry operation. */
+#define TRANSPORT_LAYER6_READY -42
+extern struct ref special_transport_layer6_ready;
+
+
 #define TRANSPORT_PUSH_ALL 1
 #define TRANSPORT_PUSH_FORCE 2
 #define TRANSPORT_PUSH_DRY_RUN 4
-- 
1.6.6.rc1.288.g40e67
