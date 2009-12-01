From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH 7/8] Add remote helper debug mode
Date: Tue,  1 Dec 2009 15:57:17 +0200
Message-ID: <1259675838-14692-8-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 15:08:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFTPR-0000SF-9Q
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 15:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752742AbZLAOIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 09:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752641AbZLAOI3
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 09:08:29 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:42062 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408AbZLAOI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 09:08:27 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 9BC4BC7FF9
	for <git@vger.kernel.org>; Tue,  1 Dec 2009 15:57:56 +0200 (EET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A0419B987B5; Tue, 01 Dec 2009 15:57:56 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 18E171C6383
	for <git@vger.kernel.org>; Tue,  1 Dec 2009 15:57:54 +0200 (EET)
X-Mailer: git-send-email 1.6.6.rc0.64.g5593e
In-Reply-To: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134207>

Remote helpers deadlock easily, so support debug mode which shows the
interaction steps.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 transport-helper.c |  110 ++++++++++++++++++++++++++++++++++------------------
 1 files changed, 72 insertions(+), 38 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 0e4da79..697f026 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -8,6 +8,8 @@
 #include "quote.h"
 #include "remote.h"
 
+static int debug = 0;
+
 struct helper_data
 {
 	const char *name;
@@ -25,6 +27,47 @@ struct helper_data
 	struct git_transport_options gitoptions;
 };
 
+static void sendline(struct helper_data *helper, struct strbuf *buffer)
+{
+	if(debug)
+		fprintf(stderr, "Debug: Remote helper: -> %s", buffer->buf);
+	if(write_in_full(helper->helper->in, buffer->buf, buffer->len)
+		!= buffer->len) {
+		die_errno("Full write to remote helper failed");
+	}
+}
+
+static int recvline(struct helper_data *helper, struct strbuf *buffer,
+		    int supress_finish)
+{
+	strbuf_reset(buffer);
+	if (strbuf_getline(buffer, helper->out, '\n') == EOF) {
+		if(debug)
+			fprintf(stderr, "Debug: Remote helper quit.\n");
+		if(!supress_finish)
+			finish_command(helper->helper);
+		exit(128);
+	}
+
+	if(debug)
+		fprintf(stderr, "Debug: Remote helper: <- %s\n", buffer->buf);
+	return 0;
+}
+
+static void xchgline(struct helper_data *helper, struct strbuf *buffer)
+{
+	sendline(helper, buffer);
+	recvline(helper, buffer, 1);
+}
+
+static void write_constant(int fd, const char *str)
+{
+	if(debug)
+		fprintf(stderr, "Debug: Remote helper: -> %s", str);
+	if(write_in_full(fd, str, strlen(str)) != strlen(str))
+		die_errno("Full write to remote helper failed");
+}
+
 static struct child_process* helper_disown(struct transport *transport)
 {
 	struct helper_data *data = transport->data;
@@ -99,23 +142,15 @@ static struct child_process *get_helper(struct transport *transport)
 	data->out = xfdopen(duped, "r");
 	setvbuf(data->out, NULL, _IONBF, 0);
 
-	write_str_in_full(helper->in, "capabilities\n");
+	write_constant(helper->in, "capabilities\n");
 
 	while (1) {
-		if (strbuf_getline(&buf, data->out, '\n') == EOF) {
-			/* If we haven't seen line yet, try to finish the
-			   command so we get error message about failed
-			   execution. */
-			if(!seen_line)
-				finish_command(helper);
-
-			exit(128); /* child died, message supplied already */
-		}
-
+		recvline(data, &buf, seen_line);
 		seen_line = 1;
 
 		if (!*buf.buf)
 			break;
+		if(debug) fprintf(stderr, "Debug: Got cap %s\n", buf.buf);
 		if (!strcmp(buf.buf, "fetch"))
 			data->fetch = 1;
 		if (!strcmp(buf.buf, "option"))
@@ -145,14 +180,19 @@ static struct child_process *get_helper(struct transport *transport)
 		free(refspecs);
 	}
 	strbuf_release(&buf);
+	if(debug) fprintf(stderr, "Debug: Capabilities complete.\n");
 	return data->helper;
 }
 
 static int disconnect_helper(struct transport *transport)
 {
 	struct helper_data *data = transport->data;
+	struct strbuf buf = STRBUF_INIT;
+
 	if (data->helper) {
-		write_str_in_full(data->helper->in, "\n");
+		if(debug) fprintf(stderr, "Debug: Disconnecting.\n");
+		strbuf_addf(&buf, "\n");
+		sendline(data, &buf);
 		close(data->helper->in);
 		close(data->helper->out);
 		fclose(data->out);
@@ -182,10 +222,11 @@ static int set_helper_option(struct transport *transport,
 			  const char *name, const char *value)
 {
 	struct helper_data *data = transport->data;
-	struct child_process *helper = get_helper(transport);
 	struct strbuf buf = STRBUF_INIT;
 	int i, ret, is_bool = 0;
 
+	get_helper(transport);
+
 	if (!data->option)
 		return 1;
 
@@ -208,12 +249,7 @@ static int set_helper_option(struct transport *transport,
 		quote_c_style(value, &buf, NULL, 0);
 	strbuf_addch(&buf, '\n');
 
-	if (write_in_full(helper->in, buf.buf, buf.len) != buf.len)
-		die_errno("cannot send option to %s", data->name);
-
-	strbuf_reset(&buf);
-	if (strbuf_getline(&buf, data->out, '\n') == EOF)
-		exit(128); /* child died, message supplied already */
+	xchgline(data, &buf);
 
 	if (!strcmp(buf.buf, "ok"))
 		ret = 0;
@@ -273,13 +309,10 @@ static int fetch_with_fetch(struct transport *transport,
 	}
 
 	strbuf_addch(&buf, '\n');
-	if (write_in_full(data->helper->in, buf.buf, buf.len) != buf.len)
-		die_errno("cannot send fetch to %s", data->name);
+	sendline(data, &buf);
 
 	while (1) {
-		strbuf_reset(&buf);
-		if (strbuf_getline(&buf, data->out, '\n') == EOF)
-			exit(128); /* child died, message supplied already */
+		recvline(data, &buf, 1);
 
 		if (!prefixcmp(buf.buf, "lock ")) {
 			const char *name = buf.buf + 5;
@@ -314,12 +347,13 @@ static int fetch_with_import(struct transport *transport,
 			     int nr_heads, struct ref **to_fetch)
 {
 	struct child_process fastimport;
-	struct child_process *helper = get_helper(transport);
 	struct helper_data *data = transport->data;
 	int i;
 	struct ref *posn;
 	struct strbuf buf = STRBUF_INIT;
 
+	get_helper(transport);
+
 	if (get_importer(transport, &fastimport))
 		die("Couldn't run fast-import");
 
@@ -329,7 +363,7 @@ static int fetch_with_import(struct transport *transport,
 			continue;
 
 		strbuf_addf(&buf, "import %s\n", posn->name);
-		write_in_full(helper->in, buf.buf, buf.len);
+		sendline(data, &buf);
 		strbuf_reset(&buf);
 	}
 	disconnect_helper(transport);
@@ -370,12 +404,12 @@ static int _process_connect_or_invoke(struct transport *transport,
 	} else
 		return 0;
 
-	write_in_full(helper->in, cmdbuf.buf, cmdbuf.len);
-	strbuf_reset(&cmdbuf);
-	if (strbuf_getline(&cmdbuf, data->out, '\n') == EOF)
-		exit(128); /* child died, message supplied already */
-	if(!strcmp(cmdbuf.buf, "OK"))
+	xchgline(data, &cmdbuf);
+	if(!strcmp(cmdbuf.buf, "OK")) {
+		if(debug) fprintf(stderr, "Debug: Layer 6 link ready, "
+				  "starting layer 7...\n");
 		return 1;
+	}
 	else if(!strcmp(cmdbuf.buf, "FALLBACK"))
 		return 0;
 	else if(!strcmp(cmdbuf.buf, "ERROR"))
@@ -508,17 +542,14 @@ static int push_refs(struct transport *transport,
 	}
 
 	strbuf_addch(&buf, '\n');
-	if (write_in_full(helper->in, buf.buf, buf.len) != buf.len)
-		exit(128);
+	sendline(data, &buf);
 
 	ref = remote_refs;
 	while (1) {
 		char *refname, *msg;
 		int status;
 
-		strbuf_reset(&buf);
-		if (strbuf_getline(&buf, data->out, '\n') == EOF)
-			exit(128); /* child died, message supplied already */
+		recvline(data, &buf, 1);
 		if (!buf.len)
 			break;
 
@@ -608,8 +639,7 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 
 	while (1) {
 		char *eov, *eon;
-		if (strbuf_getline(&buf, data->out, '\n') == EOF)
-			exit(128); /* child died, message supplied already */
+		recvline(data, &buf, 1);
 
 		if (!*buf.buf)
 			break;
@@ -634,6 +664,7 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 		}
 		tail = &((*tail)->next);
 	}
+	if(debug) fprintf(stderr, "Debug: Read ref listing.\n");
 	strbuf_release(&buf);
 
 	for (posn = ret; posn; posn = posn->next)
@@ -647,6 +678,9 @@ int transport_helper_init(struct transport *transport, const char *name)
 	struct helper_data *data = xcalloc(sizeof(*data), 1);
 	data->name = name;
 
+	if(getenv("GIT_TRANSPORT_HELPER_DEBUG"))
+		debug = 1;
+
 	transport->data = data;
 	transport->set_option = set_helper_option;
 	transport->get_refs_list = get_refs_list;
-- 
1.6.6.rc0.64.g5593e
