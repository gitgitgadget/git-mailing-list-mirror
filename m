From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH v3 5/8] Support taking over transports
Date: Sun,  6 Dec 2009 18:28:48 +0200
Message-ID: <1260116931-16549-6-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1260116931-16549-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 06 17:29:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHJzO-0006Vu-7F
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 17:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933869AbZLFQ3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 11:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932938AbZLFQ3F
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 11:29:05 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:58611 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932948AbZLFQ2x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 11:28:53 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id 51CD7EF263
	for <git@vger.kernel.org>; Sun,  6 Dec 2009 18:28:59 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A011EE4E1FB; Sun, 06 Dec 2009 18:28:59 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 15C204035
	for <git@vger.kernel.org>; Sun,  6 Dec 2009 18:28:58 +0200 (EET)
X-Mailer: git-send-email 1.6.6.rc1.300.gfbc27
In-Reply-To: <1260116931-16549-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134676>

Add support for taking over transports that turn out to be smart.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 transport-helper.c |   28 ++++++++++++++++++++++++-
 transport.c        |   57 +++++++++++++++++++++++++++++++++++++++++++++++----
 transport.h        |   10 +++++++++
 3 files changed, 89 insertions(+), 6 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 95aaa02..3d99fe1 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -22,6 +22,7 @@ struct helper_data
 	/* These go from remote name (as in "list") to private name */
 	struct refspec *refspecs;
 	int refspec_nr;
+	struct git_transport_options gitoptions;
 };
 
 static void sendline(struct helper_data *helper, struct strbuf *buffer)
@@ -63,6 +64,15 @@ static void write_constant(int fd, const char *str)
 		die_errno("Full write to remote helper failed");
 }
 
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
@@ -91,6 +101,7 @@ static struct child_process *get_helper(struct transport *transport)
 	const char **refspecs = NULL;
 	int refspec_nr = 0;
 	int refspec_alloc = 0;
+	int duped;
 
 	if (data->helper)
 		return data->helper;
@@ -109,9 +120,21 @@ static struct child_process *get_helper(struct transport *transport)
 		die("Unable to run helper: git %s", helper->argv[0]);
 	data->helper = helper;
 
+	/* Open the output as FILE* so strbuf_getline() can be used.
+	   Do this with duped fd because fclose() will close the fd,
+	   and stuff like disowning will require the fd to remain.
+
+	   Set the stream to unbuffered because some reads are critical
+	   in sense that any overreading will cause deadlocks.
+	*/
+        duped = dup(helper->out);
+	if (duped < 0)
+		die_errno("Can't dup helper output fd");
+	data->out = xfdopen(duped, "r");
+	setvbuf(data->out, NULL, _IONBF, 0);
+
 	write_constant(helper->in, "capabilities\n");
 
-	data->out = xfdopen(helper->out, "r");
 	while (1) {
 		const char* capname;
 		int mandatory = 0;
@@ -171,6 +194,7 @@ static int disconnect_helper(struct transport *transport)
 		strbuf_addf(&buf, "\n");
 		sendline(data, &buf);
 		close(data->helper->in);
+		close(data->helper->out);
 		fclose(data->out);
 		finish_command(data->helper);
 		free((char *)data->helper->argv[0]);
@@ -590,5 +614,7 @@ int transport_helper_init(struct transport *transport, const char *name)
 	transport->fetch = fetch;
 	transport->push_refs = push_refs;
 	transport->disconnect = release_helper;
+	transport->disown = helper_disown;
+	transport->smart_options = &(data->gitoptions);
 	return 0;
 }
diff --git a/transport.c b/transport.c
index deaf983..e9802e3 100644
--- a/transport.c
+++ b/transport.c
@@ -398,6 +398,7 @@ struct git_transport_data {
 	struct git_transport_options options;
 	struct child_process *conn;
 	int fd[2];
+	unsigned got_remote_heads : 1;
 	struct extra_have_objects extra_have;
 };
 
@@ -432,10 +433,15 @@ static int set_git_option(struct git_transport_options *opts,
 static int connect_setup(struct transport *transport, int for_push, int verbose)
 {
 	struct git_transport_data *data = transport->data;
+
+	if (data->conn)
+		return 0;
+
 	data->conn = git_connect(data->fd, transport->url,
 				 for_push ? data->options.receivepack :
 				 data->options.uploadpack,
 				 verbose ? CONNECT_VERBOSE : 0);
+
 	return 0;
 }
 
@@ -447,6 +453,7 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 	connect_setup(transport, for_push, 0);
 	get_remote_heads(data->fd[0], &refs, 0, NULL,
 			 for_push ? REF_NORMAL : 0, &data->extra_have);
+	data->got_remote_heads = 1;
 
 	return refs;
 }
@@ -477,9 +484,10 @@ static int fetch_refs_via_pack(struct transport *transport,
 	for (i = 0; i < nr_heads; i++)
 		origh[i] = heads[i] = xstrdup(to_fetch[i]->name);
 
-	if (!data->conn) {
+	if (!data->got_remote_heads) {
 		connect_setup(transport, 0, 0);
 		get_remote_heads(data->fd[0], &refs_tmp, 0, NULL, 0, NULL);
+		data->got_remote_heads = 1;
 	}
 
 	refs = fetch_pack(&args, data->fd, data->conn,
@@ -490,6 +498,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	if (finish_connect(data->conn))
 		refs = NULL;
 	data->conn = NULL;
+	data->got_remote_heads = 0;
 
 	free_refs(refs_tmp);
 
@@ -718,12 +727,13 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	struct send_pack_args args;
 	int ret;
 
-	if (!data->conn) {
+	if (!data->got_remote_heads) {
 		struct ref *tmp_refs;
 		connect_setup(transport, 1, 0);
 
 		get_remote_heads(data->fd[0], &tmp_refs, 0, NULL, REF_NORMAL,
 				 NULL);
+		data->got_remote_heads = 1;
 	}
 
 	memset(&args, 0, sizeof(args));
@@ -741,6 +751,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	close(data->fd[0]);
 	ret |= finish_connect(data->conn);
 	data->conn = NULL;
+	data->got_remote_heads = 0;
 
 	return ret;
 }
@@ -749,7 +760,8 @@ static int disconnect_git(struct transport *transport)
 {
 	struct git_transport_data *data = transport->data;
 	if (data->conn) {
-		packet_flush(data->fd[1]);
+		if (data->got_remote_heads)
+			packet_flush(data->fd[1]);
 		close(data->fd[0]);
 		close(data->fd[1]);
 		finish_connect(data->conn);
@@ -759,6 +771,35 @@ static int disconnect_git(struct transport *transport)
 	return 0;
 }
 
+void transport_take_over(struct transport *transport)
+{
+	struct git_transport_data *data;
+
+	if (!transport->disown)
+		die("Bug detected: Taking over transport requires non-NULL "
+		    "disown method.");
+	if (!transport->smart_options)
+		die("Bug detected: Taking over transport requires non-NULL "
+		    "smart_options field.");
+
+	data = xcalloc(1, sizeof(*data));
+	data->options = *transport->smart_options;
+	data->conn = transport->disown(transport);
+	data->fd[0] = data->conn->out;
+	data->fd[1] = data->conn->in;
+	data->got_remote_heads = 0;
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
@@ -854,6 +895,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		ret->fetch = fetch_objs_via_rsync;
 		ret->push = rsync_transport_push;
 		ret->smart_options = NULL;
+		ret->disown = NULL;
 	} else if (is_local(url) && is_file(url)) {
 		struct bundle_transport_data *data = xcalloc(1, sizeof(*data));
 		ret->data = data;
@@ -861,6 +903,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		ret->fetch = fetch_refs_from_bundle;
 		ret->disconnect = close_bundle;
 		ret->smart_options = NULL;
+		ret->disown = NULL;
 	} else if (!is_url(url)
 		|| !prefixcmp(url, "file://")
 		|| !prefixcmp(url, "git://")
@@ -876,8 +919,10 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		ret->push_refs = git_transport_push;
 		ret->disconnect = disconnect_git;
 		ret->smart_options = &(data->options);
+		ret->disown = NULL;
 
 		data->conn = NULL;
+		data->got_remote_heads = 0;
 	} else if (!prefixcmp(url, "http://")
 		|| !prefixcmp(url, "https://")
 		|| !prefixcmp(url, "ftp://")) {
@@ -938,9 +983,9 @@ int transport_push(struct transport *transport,
 	*nonfastforward = 0;
 	verify_remote_names(refspec_nr, refspec);
 
-	if (transport->push)
+	if (transport->push) {
 		return transport->push(transport, refspec_nr, refspec, flags);
-	if (transport->push_refs) {
+	} else if (transport->push_refs) {
 		struct ref *remote_refs =
 			transport->get_refs_list(transport, 1);
 		struct ref *local_refs = get_local_heads();
@@ -984,6 +1029,7 @@ const struct ref *transport_get_remote_refs(struct transport *transport)
 {
 	if (!transport->remote_refs)
 		transport->remote_refs = transport->get_refs_list(transport, 0);
+
 	return transport->remote_refs;
 }
 
@@ -1018,6 +1064,7 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 	}
 
 	rc = transport->fetch(transport, nr_heads, heads);
+
 	free(heads);
 	return rc;
 }
diff --git a/transport.h b/transport.h
index d0192f9..499962d 100644
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
@@ -128,6 +137,7 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs);
 void transport_unlock_pack(struct transport *transport);
 int transport_disconnect(struct transport *transport);
 char *transport_anonymize_url(const char *url);
+void transport_take_over(struct transport *transport);
 
 /* Transport methods defined outside transport.c */
 int transport_helper_init(struct transport *transport, const char *name);
-- 
1.6.6.rc1.300.gfbc27
