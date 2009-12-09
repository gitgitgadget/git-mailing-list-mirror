From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [REROLL PATCH v2 6/8] Support remote helpers implementing smart transports
Date: Wed,  9 Dec 2009 17:26:32 +0200
Message-ID: <1260372394-16427-7-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1260372394-16427-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 09 16:27:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIORh-0002on-Od
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 16:27:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755576AbZLIP0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 10:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755539AbZLIP0o
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 10:26:44 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:42211 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755481AbZLIP0i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 10:26:38 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 70EE3C80F8
	for <git@vger.kernel.org>; Wed,  9 Dec 2009 17:26:44 +0200 (EET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A069C63971E; Wed, 09 Dec 2009 17:26:44 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 3AA1F1C638D
	for <git@vger.kernel.org>; Wed,  9 Dec 2009 17:26:43 +0200 (EET)
X-Mailer: git-send-email 1.6.6.rc1.300.gfbc27
In-Reply-To: <1260372394-16427-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134983>

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 Documentation/git-remote-helpers.txt |   25 +++++++-
 transport-helper.c                   |  126 ++++++++++++++++++++++++++++++++--
 2 files changed, 144 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 20a05fe..4685a89 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -93,6 +93,20 @@ Supported if the helper has the "push" capability.
 +
 Supported if the helper has the "import" capability.
 
+'connect' <service>::
+	Connects to given service. Standard input and standard output
+	of helper are connected to specified service (git prefix is
+	included in service name so e.g. fetching uses 'git-upload-pack'
+	as service) on remote side. Valid replies to this command are
+	empty line (connection established), 'fallback' (no smart
+	transport support, fall back to dumb transports) and just
+	exiting with error message printed (can't connect, don't
+	bother trying to fall back). After line feed terminating the
+	positive (empty) response, the output of service starts. After
+	the connection ends, the remote helper exits.
++
+Supported if the helper has the "connect" capability.
+
 If a fatal error occurs, the program writes the error message to
 stderr and exits. The caller should expect that a suitable error
 message has been printed if the child closes the connection without
@@ -126,6 +140,9 @@ CAPABILITIES
 	all, it must cover all refs reported by the list command; if
 	it is not used, it is effectively "*:*"
 
+'connect'::
+	This helper supports the 'connect' command.
+
 REF LIST ATTRIBUTES
 -------------------
 
@@ -168,9 +185,15 @@ OPTIONS
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
index 97eed6c..216af87 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -18,7 +18,9 @@ struct helper_data
 	unsigned fetch : 1,
 		import : 1,
 		option : 1,
-		push : 1;
+		push : 1,
+		connect : 1,
+		no_disconnect_req : 1;
 	/* These go from remote name (as in "list") to private name */
 	struct refspec *refspecs;
 	int refspec_nr;
@@ -37,12 +39,12 @@ static void sendline(struct helper_data *helper, struct strbuf *buffer)
 		die_errno("Full write to remote helper failed");
 }
 
-static int recvline(struct helper_data *helper, struct strbuf *buffer)
+static int recvline_fh(FILE *helper, struct strbuf *buffer)
 {
 	strbuf_reset(buffer);
 	if (debug)
 		fprintf(stderr, "Debug: Remote helper: Waiting...\n");
-	if (strbuf_getline(buffer, helper->out, '\n') == EOF) {
+	if (strbuf_getline(buffer, helper, '\n') == EOF) {
 		if (debug)
 			fprintf(stderr, "Debug: Remote helper quit.\n");
 		exit(128);
@@ -53,6 +55,11 @@ static int recvline(struct helper_data *helper, struct strbuf *buffer)
 	return 0;
 }
 
+static int recvline(struct helper_data *helper, struct strbuf *buffer)
+{
+	return recvline_fh(helper->out, buffer);
+}
+
 static void xchgline(struct helper_data *helper, struct strbuf *buffer)
 {
 	sendline(helper, buffer);
@@ -77,6 +84,15 @@ const char *remove_ext_force(const char *url)
 	return url;
 }
 
+static void do_take_over(struct transport *transport)
+{
+	struct helper_data *data;
+	data = (struct helper_data*)transport->data;
+	transport_take_over(transport, data->helper);
+	fclose(data->out);
+	free(data);
+}
+
 static struct child_process *get_helper(struct transport *transport)
 {
 	struct helper_data *data = transport->data;
@@ -103,12 +119,12 @@ static struct child_process *get_helper(struct transport *transport)
 	if (start_command(helper))
 		die("Unable to run helper: git %s", helper->argv[0]);
 	data->helper = helper;
+	data->no_disconnect_req = 0;
 
 	/*
 	 * Open the output as FILE* so strbuf_getline() can be used.
 	 * Do this with duped fd because fclose() will close the fd,
 	 * and stuff like taking over will require the fd to remain.
-	 *
 	 */
 	duped = dup(helper->out);
 	if (duped < 0)
@@ -146,6 +162,8 @@ static struct child_process *get_helper(struct transport *transport)
 				   refspec_nr + 1,
 				   refspec_alloc);
 			refspecs[refspec_nr++] = strdup(buf.buf + strlen("refspec "));
+		} else if (!strcmp(capname, "connect")) {
+			data->connect = 1;
 		} else if (mandatory) {
 			die("Unknown madatory capability %s. This remote "
 			    "helper probably needs newer version of Git.\n",
@@ -175,8 +193,10 @@ static int disconnect_helper(struct transport *transport)
 	if (data->helper) {
 		if (debug)
 			fprintf(stderr, "Debug: Disconnecting.\n");
-		strbuf_addf(&buf, "\n");
-		sendline(data, &buf);
+		if(!data->no_disconnect_req) {
+			strbuf_addf(&buf, "\n");
+			sendline(data, &buf);
+		}
 		close(data->helper->in);
 		close(data->helper->out);
 		fclose(data->out);
@@ -370,12 +390,96 @@ static int fetch_with_import(struct transport *transport,
 	return 0;
 }
 
+static int process_connect_service(struct transport *transport,
+				   const char *name, const char *exec)
+{
+	struct helper_data *data = transport->data;
+	struct strbuf cmdbuf = STRBUF_INIT;
+	struct child_process *helper;
+	int r, duped, ret = 0;
+	FILE *input;
+
+	helper = get_helper(transport);
+
+	/*
+	 * Yes, dup the pipe another time, as we need unbuffered version
+	 * of input pipe as FILE*. fclose() closes the underlying fd and
+	 * stream buffering only can be changed before first I/O operation
+	 * on it.
+	 */
+	duped = dup(helper->out);
+	if (duped < 0)
+		die_errno("Can't dup helper output fd");
+	input = xfdopen(duped, "r");
+	setvbuf(input, NULL, _IONBF, 0);
+
+	/*
+	 * Handle --upload-pack and friends. This is fire and forget...
+	 * just warn if it fails.
+	 */
+	if (strcmp(name, exec)) {
+		r = set_helper_option(transport, "servpath", exec);
+		if (r > 0)
+			fprintf(stderr, "Warning: Setting remote service path "
+				"not supported by protocol.\n");
+		else if (r < 0)
+			fprintf(stderr, "Warning: Invalid remote service "
+				"path.\n");
+	}
+
+	if (data->connect)
+		strbuf_addf(&cmdbuf, "connect %s\n", name);
+	else
+		goto exit;
+
+	sendline(data, &cmdbuf);
+	recvline_fh(input, &cmdbuf);
+	if (!strcmp(cmdbuf.buf, "")) {
+		data->no_disconnect_req = 1;
+		if (debug)
+			fprintf(stderr, "Debug: Smart transport connection "
+				"ready.\n");
+		ret = 1;
+	} else if (!strcmp(cmdbuf.buf, "fallback")) {
+		if (debug)
+			fprintf(stderr, "Debug: Falling back to dumb "
+				"transport.\n");
+	} else
+		die("Unknown response to connect: %s",
+			cmdbuf.buf);
+
+exit:
+	fclose(input);
+	return ret;
+}
+
+static int process_connect(struct transport *transport,
+				     int for_push)
+{
+	struct helper_data *data = transport->data;
+	const char *name;
+	const char *exec;
+
+	name = for_push ? "git-receive-pack" : "git-upload-pack";
+	if (for_push)
+		exec = data->transport_options.receivepack;
+	else
+		exec = data->transport_options.uploadpack;
+
+	return process_connect_service(transport, name, exec);
+}
+
 static int fetch(struct transport *transport,
 		 int nr_heads, struct ref **to_fetch)
 {
 	struct helper_data *data = transport->data;
 	int i, count;
 
+	if (process_connect(transport, 0)) {
+		do_take_over(transport);
+		return transport->fetch(transport, nr_heads, to_fetch);
+	}
+
 	count = 0;
 	for (i = 0; i < nr_heads; i++)
 		if (!(to_fetch[i]->status & REF_STATUS_UPTODATE))
@@ -403,6 +507,11 @@ static int push_refs(struct transport *transport,
 	struct child_process *helper;
 	struct ref *ref;
 
+	if (process_connect(transport, 1)) {
+		do_take_over(transport);
+		return transport->push_refs(transport, remote_refs, flags);
+	}
+
 	if (!remote_refs)
 		return 0;
 
@@ -543,6 +652,11 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 
 	helper = get_helper(transport);
 
+	if (process_connect(transport, for_push)) {
+		do_take_over(transport);
+		return transport->get_refs_list(transport, for_push);
+	}
+
 	if (data->push && for_push)
 		write_str_in_full(helper->in, "list for-push\n");
 	else
-- 
1.6.6.rc1.300.gfbc27
