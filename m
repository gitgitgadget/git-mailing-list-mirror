From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH v2 4/8] Support remote helpers implementing smart transports
Date: Fri,  4 Dec 2009 17:56:04 +0200
Message-ID: <1259942168-24869-7-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1259942168-24869-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 04 17:00:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGaWg-0002Il-IU
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 16:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756869AbZLDP4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 10:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756865AbZLDP4q
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 10:56:46 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:42402 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756845AbZLDP4p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 10:56:45 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id 698EF13B703
	for <git@vger.kernel.org>; Fri,  4 Dec 2009 17:56:48 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A02EFF65DDA; Fri, 04 Dec 2009 17:56:48 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 02B83402E
	for <git@vger.kernel.org>; Fri,  4 Dec 2009 17:56:45 +0200 (EET)
X-Mailer: git-send-email 1.6.6.rc1.288.g40e67
In-Reply-To: <1259942168-24869-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134529>

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 Documentation/git-remote-helpers.txt |   28 ++++++++++-
 transport-helper.c                   |   96 +++++++++++++++++++++++++++++++++-
 transport.c                          |   21 +++++++
 transport.h                          |    5 ++
 4 files changed, 147 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 5cfdc0c..91cd9eb 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -90,6 +90,23 @@ Supported if the helper has the "push" capability.
 +
 Supported if the helper has the "import" capability.
 
+'connect' <service>::
+	Connects to given service. Stdin and stdout of helper are
+	connected to specified service (git prefix is included in service
+	name so e.g. fetching uses 'git-upload-pack' as service) on
+	remote side. Valid replies to this command are empty line
+	(connection established), 'FALLBACK' (no smart transport support,
+	fall back to dumb transports) and just exiting with error message
+	printed (can't connect, don't bother trying to fall back). After
+	line feed terminating the positive (empty) response, the output
+	of service starts. After the connection ends, the remote
+	helper exits. Note that to prevent deadlocking, all read data
+	should be immediately flushed to outgoing connection (excepting
+	remote initial advertisments, which should be flushed on first
+	flush packet (0000 as length) encountered.
++
+Supported if the helper has the "connect" capability.
+
 If a fatal error occurs, the program writes the error message to
 stderr and exits. The caller should expect that a suitable error
 message has been printed if the child closes the connection without
@@ -123,6 +140,9 @@ CAPABILITIES
 	all, it must cover all refs reported by the list command; if
 	it is not used, it is effectively "*:*"
 
+'connect'::
+	This helper supports the 'connect' command.
+
 REF LIST ATTRIBUTES
 -------------------
 
@@ -165,9 +185,15 @@ OPTIONS
 	but don't actually change any repository data.	For most
 	helpers this only applies to the 'push', if supported.
 
+'option servpath <c-style-quoted-path>'::
+	Set service path (--upload-pack, --receive-pack etc.) for
+	next connect. Remote helper MAY support this option. Remote
+	helper MUST NOT rely on this option being set before
+	connect request occurs.
+
 Documentation
 -------------
-Documentation by Daniel Barkalow.
+Documentation by Daniel Barkalow and Ilari Liusvaara
 
 GIT
 ---
diff --git a/transport-helper.c b/transport-helper.c
index 5d17fb5..21aa4ab 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -16,7 +16,8 @@ struct helper_data
 	unsigned fetch : 1,
 		import : 1,
 		option : 1,
-		push : 1;
+		push : 1,
+		connect : 1;
 	/* These go from remote name (as in "list") to private name */
 	struct refspec *refspecs;
 	int refspec_nr;
@@ -72,7 +73,10 @@ static struct child_process *get_helper(struct transport *transport)
 	helper->argv = xcalloc(4, sizeof(*helper->argv));
 	strbuf_addf(&buf, "remote-%s", data->name);
 	helper->argv[0] = strbuf_detach(&buf, NULL);
-	helper->argv[1] = transport->remote->name;
+	if(transport->remote)
+		helper->argv[1] = transport->remote->name;
+	else
+		helper->argv[1] = "";
 	helper->argv[2] = remove_ext_force(transport->url);
 	helper->git_cmd = 1;
 	if (start_command(helper))
@@ -113,6 +117,8 @@ static struct child_process *get_helper(struct transport *transport)
 				   refspec_alloc);
 			refspecs[refspec_nr++] = strdup(buf.buf + strlen("refspec "));
 		}
+		if (!strcmp(buf.buf, "connect"))
+			data->connect = 1;
 	}
 	if (refspecs) {
 		int i;
@@ -331,12 +337,91 @@ static int fetch_with_import(struct transport *transport,
 	return 0;
 }
 
+static int _process_connect(struct transport *transport,
+				      const char *name, const char *exec)
+{
+	struct helper_data *data = transport->data;
+	struct strbuf cmdbuf = STRBUF_INIT;
+	struct child_process *helper;
+	int r;
+
+	helper = get_helper(transport);
+
+	/* Handle --upload-pack and friends. This is fire and forget...
+	   just warn if it fails. */
+	if(exec && strcmp(name, exec)) {
+		r = set_helper_option(transport, "servpath", exec);
+		if(r > 0)
+			fprintf(stderr, "Warning: Setting remote service path "
+				"not supported by protocol.\n");
+		else if(r < 0)
+			fprintf(stderr, "Warning: Invalid remote service "
+				"path.\n");
+	}
+
+	if(data->connect) {
+		strbuf_addf(&cmdbuf, "connect %s\n", name);
+	} else
+		return 0;
+
+	write_in_full(helper->in, cmdbuf.buf, cmdbuf.len);
+	strbuf_reset(&cmdbuf);
+	if (strbuf_getline(&cmdbuf, data->out, '\n') == EOF)
+		exit(128); /* child died, message supplied already */
+	if(!strcmp(cmdbuf.buf, ""))
+		return 1;
+	else if(!strcmp(cmdbuf.buf, "FALLBACK"))
+		return 0;
+	else
+		die("Unknown response to connect: %s",
+			cmdbuf.buf);
+
+	return 0;	/* Shouldn't be here. */
+}
+
+static int process_connect(struct transport* transport,
+				     int for_push)
+{
+	struct helper_data *data = transport->data;
+	const char *name;
+	const char *exec;
+
+	name = for_push ? "git-receive-pack" : "git-upload-pack";
+	if(for_push)
+		exec = data->gitoptions.receivepack;
+	else
+		exec = data->gitoptions.uploadpack;
+
+	return _process_connect(transport, name, exec);
+}
+
+static int connect_helper(struct transport *transport, const char *name,
+		   const char *exec, int fd[2])
+{
+	struct helper_data *data = transport->data;
+
+	/* Get_helper so connect is inited. */
+	get_helper(transport);
+	if(!data->connect)
+		die("Operation not supported by protocol.");
+
+	if(!_process_connect(transport, name, exec))
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
 
+	if(process_connect(transport, 0))
+		return TRANSPORT_LAYER6_READY;
+
 	count = 0;
 	for (i = 0; i < nr_heads; i++)
 		if (!(to_fetch[i]->status & REF_STATUS_UPTODATE))
@@ -364,6 +449,9 @@ static int push_refs(struct transport *transport,
 	struct child_process *helper;
 	struct ref *ref;
 
+	if(process_connect(transport, 1))
+		return TRANSPORT_LAYER6_READY;
+
 	if (!remote_refs)
 		return 0;
 
@@ -507,6 +595,9 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 
 	helper = get_helper(transport);
 
+	if(process_connect(transport, for_push))
+		return &special_transport_layer6_ready;
+
 	if (data->push && for_push)
 		write_str_in_full(helper->in, "list for-push\n");
 	else
@@ -559,6 +650,7 @@ int transport_helper_init(struct transport *transport, const char *name)
 	transport->fetch = fetch;
 	transport->push_refs = push_refs;
 	transport->disconnect = release_helper;
+	transport->connect = connect_helper;
 	transport->disown = helper_disown;
 	transport->smart_options = &(data->gitoptions);
 	return 0;
diff --git a/transport.c b/transport.c
index 7e6ef2b..1488cfe 100644
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
1.6.6.rc1.288.g40e67
