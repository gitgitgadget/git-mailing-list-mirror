From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [REROLL PATCH 5/8] Support taking over transports
Date: Tue,  8 Dec 2009 15:16:14 +0200
Message-ID: <1260278177-9029-6-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1260278177-9029-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 08 14:17:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHzw3-0006BE-2k
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 14:16:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754759AbZLHNQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 08:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754747AbZLHNQa
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 08:16:30 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:52202 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754672AbZLHNQT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 08:16:19 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id AF2A1EF8BB
	for <git@vger.kernel.org>; Tue,  8 Dec 2009 15:16:25 +0200 (EET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A06162A08BD; Tue, 08 Dec 2009 15:16:25 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 7384B158A71
	for <git@vger.kernel.org>; Tue,  8 Dec 2009 15:16:24 +0200 (EET)
X-Mailer: git-send-email 1.6.6.rc1.300.gfbc27
In-Reply-To: <1260278177-9029-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134864>

Add support for taking over transports that turn out to be smart.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 transport-helper.c |   16 +++++++++++++++-
 transport.c        |   51 ++++++++++++++++++++++++++++++++++++++++++++++-----
 transport.h        |    2 ++
 3 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 0e82553..3b7340c 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -22,6 +22,7 @@ struct helper_data
 	/* These go from remote name (as in "list") to private name */
 	struct refspec *refspecs;
 	int refspec_nr;
+	struct git_transport_options gitoptions;
 };
 
 static void sendline(struct helper_data *helper, struct strbuf *buffer)
@@ -91,6 +92,7 @@ static struct child_process *get_helper(struct transport *transport)
 	const char **refspecs = NULL;
 	int refspec_nr = 0;
 	int refspec_alloc = 0;
+	int duped;
 
 	if (data->helper)
 		return data->helper;
@@ -109,9 +111,19 @@ static struct child_process *get_helper(struct transport *transport)
 		die("Unable to run helper: git %s", helper->argv[0]);
 	data->helper = helper;
 
+	/*
+	 * Open the output as FILE* so strbuf_getline() can be used.
+	 * Do this with duped fd because fclose() will close the fd,
+	 * and stuff like taking over will require the fd to remain.
+	 *
+	 */
+	duped = dup(helper->out);
+	if (duped < 0)
+		die_errno("Can't dup helper output fd");
+	data->out = xfdopen(duped, "r");
+
 	write_constant(helper->in, "capabilities\n");
 
-	data->out = xfdopen(helper->out, "r");
 	while (1) {
 		const char *capname;
 		int mandatory = 0;
@@ -174,6 +186,7 @@ static int disconnect_helper(struct transport *transport)
 		strbuf_addf(&buf, "\n");
 		sendline(data, &buf);
 		close(data->helper->in);
+		close(data->helper->out);
 		fclose(data->out);
 		finish_command(data->helper);
 		free((char *)data->helper->argv[0]);
@@ -594,5 +607,6 @@ int transport_helper_init(struct transport *transport, const char *name)
 	transport->fetch = fetch;
 	transport->push_refs = push_refs;
 	transport->disconnect = release_helper;
+	transport->smart_options = &(data->gitoptions);
 	return 0;
 }
diff --git a/transport.c b/transport.c
index b3e22ec..c4ecec4 100644
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
@@ -759,6 +771,32 @@ static int disconnect_git(struct transport *transport)
 	return 0;
 }
 
+void transport_take_over(struct transport *transport,
+			 struct child_process *child)
+{
+	struct git_transport_data *data;
+
+	if (!transport->smart_options)
+		die("Bug detected: Taking over transport requires non-NULL "
+		    "smart_options field.");
+
+	data = xcalloc(1, sizeof(*data));
+	data->options = *transport->smart_options;
+	data->conn = child;
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
+}
+
 static int is_local(const char *url)
 {
 	const char *colon = strchr(url, ':');
@@ -881,6 +919,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		ret->smart_options = &(data->options);
 
 		data->conn = NULL;
+		data->got_remote_heads = 0;
 	} else if (!prefixcmp(url, "http://")
 		|| !prefixcmp(url, "https://")
 		|| !prefixcmp(url, "ftp://")) {
@@ -941,9 +980,9 @@ int transport_push(struct transport *transport,
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
@@ -987,6 +1026,7 @@ const struct ref *transport_get_remote_refs(struct transport *transport)
 {
 	if (!transport->remote_refs)
 		transport->remote_refs = transport->get_refs_list(transport, 0);
+
 	return transport->remote_refs;
 }
 
@@ -1021,6 +1061,7 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 	}
 
 	rc = transport->fetch(transport, nr_heads, heads);
+
 	free(heads);
 	return rc;
 }
diff --git a/transport.h b/transport.h
index e90c285..781db2e 100644
--- a/transport.h
+++ b/transport.h
@@ -130,6 +130,8 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs);
 void transport_unlock_pack(struct transport *transport);
 int transport_disconnect(struct transport *transport);
 char *transport_anonymize_url(const char *url);
+void transport_take_over(struct transport *transport,
+			 struct child_process *child);
 
 /* Transport methods defined outside transport.c */
 int transport_helper_init(struct transport *transport, const char *name);
-- 
1.6.6.rc1.300.gfbc27
