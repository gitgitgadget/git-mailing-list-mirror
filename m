From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH 4/8] Support remote helpers implementing smart transports
Date: Tue,  1 Dec 2009 15:57:14 +0200
Message-ID: <1259675838-14692-5-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 15:08:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFTPQ-0000SF-PE
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 15:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408AbZLAOI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 09:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752340AbZLAOI1
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 09:08:27 -0500
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:60958 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbZLAOIY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 09:08:24 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id 043CE8C486
	for <git@vger.kernel.org>; Tue,  1 Dec 2009 15:57:45 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A02A8B014DC; Tue, 01 Dec 2009 15:57:45 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id C63D64055
	for <git@vger.kernel.org>; Tue,  1 Dec 2009 15:57:42 +0200 (EET)
X-Mailer: git-send-email 1.6.6.rc0.64.g5593e
In-Reply-To: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134208>

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 Documentation/git-remote-helpers.txt |   30 ++++++++++-
 transport-helper.c                   |   94 +++++++++++++++++++++++++++++++--
 transport.c                          |   21 ++++++++
 transport.h                          |    5 ++
 4 files changed, 143 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 5cfdc0c..adf815c 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -90,6 +90,28 @@ Supported if the helper has the "push" capability.
 +
 Supported if the helper has the "import" capability.
 
+'connect-r' <service>::
+	Connects to given service. Stdin and stdout of helper are
+	connected to specified service (no git or git- prefixes are used,
+	so e.g. fetching uses 'upload-pack' as service) on remote side.
+	Valid replies to this command are 'OK' (connection established),
+	'FALLBACK' (no smart transport support, fall back to dumb
+	transports) and 'ERROR' (can't connect, don't bother trying to
+	fall back). After line feed terminating the OK response, the
+	output of service starts. After the connection ends, the remote
+	helper exits. Note that to prevent deadlocking, all read data
+	should be immediately flushed to outgoing connection.
++
+Supported if the helper has the "connect-r" capability. Not used if
+helper has the "invoke-r" capability, as invoke is preferred to connect.
+
+'invoke-r' <cmdlength> <cmd>::
+	Like connect-r command, but instead of service name, command
+	line is given. The length of command field is given in command
+	length field.
++
+Supported if the helper has the "invoke-r" capability.
+
 If a fatal error occurs, the program writes the error message to
 stderr and exits. The caller should expect that a suitable error
 message has been printed if the child closes the connection without
@@ -123,6 +145,12 @@ CAPABILITIES
 	all, it must cover all refs reported by the list command; if
 	it is not used, it is effectively "*:*"
 
+'connect-r'::
+	This helper supports the 'connect-r' command.
+
+'invoke-r'::
+	This helper supports the 'invoke-r' command.
+
 REF LIST ATTRIBUTES
 -------------------
 
@@ -167,7 +195,7 @@ OPTIONS
 
 Documentation
 -------------
-Documentation by Daniel Barkalow.
+Documentation by Daniel Barkalow and Ilari Liusvaara
 
 GIT
 ---
diff --git a/transport-helper.c b/transport-helper.c
index 777ecbb..0e4da79 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -16,7 +16,9 @@ struct helper_data
 	unsigned fetch : 1,
 		import : 1,
 		option : 1,
-		push : 1;
+		push : 1,
+		connect_r : 1,
+		invoke_r : 1;
 	/* These go from remote name (as in "list") to private name */
 	struct refspec *refspecs;
 	int refspec_nr;
@@ -75,7 +77,10 @@ static struct child_process *get_helper(struct transport *transport)
 	   would run and print totally inapporiate error message. */
 	strbuf_addf(&buf, "git-remote-%s", data->name);
 	helper->argv[0] = strbuf_detach(&buf, NULL);
-	helper->argv[1] = transport->remote->name;
+	if(transport->remote)
+		helper->argv[1] = transport->remote->name;
+	else
+		helper->argv[1] = "";
 	helper->argv[2] = remove_ext_force(transport->url);
 	helper->git_cmd = 0;
 	if (start_command(helper))
@@ -125,6 +130,10 @@ static struct child_process *get_helper(struct transport *transport)
 				   refspec_alloc);
 			refspecs[refspec_nr++] = strdup(buf.buf + strlen("refspec "));
 		}
+		if (!strcmp(buf.buf, "connect-r"))
+			data->connect_r = 1;
+		if (!strcmp(buf.buf, "invoke-r"))
+			data->invoke_r = 1;
 	}
 	if (refspecs) {
 		int i;
@@ -344,12 +353,83 @@ static int fetch_with_import(struct transport *transport,
 	return 0;
 }
 
+static int _process_connect_or_invoke(struct transport *transport,
+				      const char *name, const char *exec)
+{
+	struct helper_data *data = transport->data;
+	struct strbuf cmdbuf = STRBUF_INIT;
+	struct child_process *helper;
+
+	helper = get_helper(transport);
+
+	if(data->invoke_r) {
+		strbuf_addf(&cmdbuf, "invoke-r %i %s\n",
+			    strlen(exec), exec);
+	} else if(data->connect_r) {
+		strbuf_addf(&cmdbuf, "connect-r %s\n", name);
+	} else
+		return 0;
+
+	write_in_full(helper->in, cmdbuf.buf, cmdbuf.len);
+	strbuf_reset(&cmdbuf);
+	if (strbuf_getline(&cmdbuf, data->out, '\n') == EOF)
+		exit(128); /* child died, message supplied already */
+	if(!strcmp(cmdbuf.buf, "OK"))
+		return 1;
+	else if(!strcmp(cmdbuf.buf, "FALLBACK"))
+		return 0;
+	else if(!strcmp(cmdbuf.buf, "ERROR"))
+		exit(128); /* Error already suppiled. */
+	else
+		die("Unknown response to invoke/connect: %s",
+			cmdbuf.buf);
+
+	return 0;	/* Shouldn't be here. */
+}
+
+static int process_connect_or_invoke(struct transport* transport,
+				     int for_push)
+{
+	struct helper_data *data = transport->data;
+	const char *name;
+	const char *exec;
+
+	name = for_push ? "receive-pack" : "upload-pack";
+	if(for_push)
+		exec = data->gitoptions.receivepack;
+	else
+		exec = data->gitoptions.uploadpack;
+
+	return _process_connect_or_invoke(transport, name, exec);
+}
+
+static int connect_helper(struct transport *transport, const char *name,
+		   const char *exec, int fd[2])
+{
+	struct helper_data *data = transport->data;
+
+	/* Get_helper so invoke_r and connect_r are inited. */
+	get_helper(transport);
+	if(!data->invoke_r && !data->connect_r)
+		die("Operation not supported by protocol.");
+
+	if(!_process_connect_or_invoke(transport, name, exec))
+		die("Can't connect to subservice %s.", name);
+
+	fd[0] = data->helper->out;
+	fd[1] = data->helper->in;
+	return 0;
+}
+
 static int fetch(struct transport *transport,
 		 int nr_heads, struct ref **to_fetch)
 {
 	struct helper_data *data = transport->data;
 	int i, count;
 
+	if(process_connect_or_invoke(transport, 0))
+		return TRANSPORT_LAYER6_READY;
+
 	count = 0;
 	for (i = 0; i < nr_heads; i++)
 		if (!(to_fetch[i]->status & REF_STATUS_UPTODATE))
@@ -377,6 +457,9 @@ static int push_refs(struct transport *transport,
 	struct child_process *helper;
 	struct ref *ref;
 
+	if(process_connect_or_invoke(transport, 1))
+		return TRANSPORT_LAYER6_READY;
+
 	if (!remote_refs)
 		return 0;
 
@@ -520,10 +603,8 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 
 	helper = get_helper(transport);
 
-	if (data->push && for_push)
-		write_str_in_full(helper->in, "list for-push\n");
-	else
-		write_str_in_full(helper->in, "list\n");
+	if(process_connect_or_invoke(transport, for_push))
+		return &special_transport_layer6_ready;
 
 	while (1) {
 		char *eov, *eon;
@@ -572,6 +653,7 @@ int transport_helper_init(struct transport *transport, const char *name)
 	transport->fetch = fetch;
 	transport->push_refs = push_refs;
 	transport->disconnect = release_helper;
+	transport->connect = connect_helper;
 	transport->disown = helper_disown;
 	transport->smart_options = &(data->gitoptions);
 	return 0;
diff --git a/transport.c b/transport.c
index 09e4c97..a32f405 100644
--- a/transport.c
+++ b/transport.c
@@ -762,6 +762,17 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	return ret;
 }
 
+static int connect_git(struct transport *transport, const char* name,
+		       const char* executable, int fd[2])
+{
+	struct git_transport_data *data = transport->data;
+	data->conn = git_connect(data->fd, transport->url,
+				 executable, 0);
+	fd[0] = data->fd[0];
+	fd[1] = data->fd[1];
+	return 0;
+}
+
 static int disconnect_git(struct transport *transport)
 {
 	struct git_transport_data *data = transport->data;
@@ -926,6 +937,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		ret->get_refs_list = get_refs_via_connect;
 		ret->fetch = fetch_refs_via_pack;
 		ret->push_refs = git_transport_push;
+		ret->connect = connect_git;
 		ret->disconnect = disconnect_git;
 		ret->smart_options = &(data->options);
 		ret->disown = NULL;
@@ -1109,6 +1121,15 @@ void transport_unlock_pack(struct transport *transport)
 	}
 }
 
+int transport_connect(struct transport *transport, const char *name,
+		      const char* exec, int fd[2])
+{
+	if(transport->connect) {
+		return transport->connect(transport, name, exec, fd);
+	} else
+		die("Operation not supported by protocol");
+}
+
 int transport_disconnect(struct transport *transport)
 {
 	int ret = 0;
diff --git a/transport.h b/transport.h
index f3ee890..c86329a 100644
--- a/transport.h
+++ b/transport.h
@@ -64,6 +64,8 @@ struct transport {
 	 **/
 	int (*push_refs)(struct transport *transport, struct ref *refs, int flags);
 	int (*push)(struct transport *connection, int refspec_nr, const char **refspec, int flags);
+	int (*connect)(struct transport *connection, const char* name, const char* executable,
+		       int fd[2]);
 
 	/**
 	 * Disown the transport helper. Releases all resources used
@@ -143,6 +145,9 @@ void transport_unlock_pack(struct transport *transport);
 int transport_disconnect(struct transport *transport);
 char *transport_anonymize_url(const char *url);
 
+int transport_connect(struct transport *transport, const char *name,
+		      const char* exec, int fd[2]);
+
 /* Transport methods defined outside transport.c */
 int transport_helper_init(struct transport *transport, const char *name);
 
-- 
1.6.6.rc0.64.g5593e
