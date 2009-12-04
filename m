From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH v2 7/8] Add remote helper debug mode
Date: Fri,  4 Dec 2009 17:56:07 +0200
Message-ID: <1259942168-24869-10-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1259942168-24869-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 04 17:00:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGaX1-0002ad-LZ
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 16:57:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756894AbZLDP5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 10:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755894AbZLDP5G
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 10:57:06 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:42571 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756892AbZLDP5E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 10:57:04 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id 7784013B6CA
	for <git@vger.kernel.org>; Fri,  4 Dec 2009 17:57:10 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A04D8575164; Fri, 04 Dec 2009 17:57:10 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 29D4C403E
	for <git@vger.kernel.org>; Fri,  4 Dec 2009 17:57:07 +0200 (EET)
X-Mailer: git-send-email 1.6.6.rc1.288.g40e67
In-Reply-To: <1259942168-24869-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134525>

Remote helpers deadlock easily, so support debug mode which shows the
interaction steps.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 transport-helper.c |   96 ++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 67 insertions(+), 29 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 21aa4ab..03920bb 100644
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
@@ -24,6 +26,46 @@ struct helper_data
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
+static int recvline(struct helper_data *helper, struct strbuf *buffer)
+{
+	strbuf_reset(buffer);
+	if(debug)
+		fprintf(stderr, "Debug: Remote helper: Waiting...\n");
+	if (strbuf_getline(buffer, helper->out, '\n') == EOF) {
+		if(debug)
+			fprintf(stderr, "Debug: Remote helper quit.\n");
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
+	recvline(helper, buffer);
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
@@ -95,14 +137,14 @@ static struct child_process *get_helper(struct transport *transport)
 	data->out = xfdopen(duped, "r");
 	setvbuf(data->out, NULL, _IONBF, 0);
 
-	write_str_in_full(helper->in, "capabilities\n");
+	write_constant(helper->in, "capabilities\n");
 
 	while (1) {
-		if (strbuf_getline(&buf, data->out, '\n') == EOF)
-			exit(128); /* child died, message supplied already */
+		recvline(data, &buf);
 
 		if (!*buf.buf)
 			break;
+		if(debug) fprintf(stderr, "Debug: Got cap %s\n", buf.buf);
 		if (!strcmp(buf.buf, "fetch"))
 			data->fetch = 1;
 		if (!strcmp(buf.buf, "option"))
@@ -130,14 +172,19 @@ static struct child_process *get_helper(struct transport *transport)
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
@@ -166,10 +213,11 @@ static int set_helper_option(struct transport *transport,
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
 
@@ -192,12 +240,7 @@ static int set_helper_option(struct transport *transport,
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
@@ -257,13 +300,10 @@ static int fetch_with_fetch(struct transport *transport,
 	}
 
 	strbuf_addch(&buf, '\n');
-	if (write_in_full(data->helper->in, buf.buf, buf.len) != buf.len)
-		die_errno("cannot send fetch to %s", data->name);
+	sendline(data, &buf);
 
 	while (1) {
-		strbuf_reset(&buf);
-		if (strbuf_getline(&buf, data->out, '\n') == EOF)
-			exit(128); /* child died, message supplied already */
+		recvline(data, &buf);
 
 		if (!prefixcmp(buf.buf, "lock ")) {
 			const char *name = buf.buf + 5;
@@ -298,12 +338,13 @@ static int fetch_with_import(struct transport *transport,
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
 
@@ -313,7 +354,7 @@ static int fetch_with_import(struct transport *transport,
 			continue;
 
 		strbuf_addf(&buf, "import %s\n", posn->name);
-		write_in_full(helper->in, buf.buf, buf.len);
+		sendline(data, &buf);
 		strbuf_reset(&buf);
 	}
 	disconnect_helper(transport);
@@ -364,10 +405,7 @@ static int _process_connect(struct transport *transport,
 	} else
 		return 0;
 
-	write_in_full(helper->in, cmdbuf.buf, cmdbuf.len);
-	strbuf_reset(&cmdbuf);
-	if (strbuf_getline(&cmdbuf, data->out, '\n') == EOF)
-		exit(128); /* child died, message supplied already */
+	xchgline(data, &cmdbuf);
 	if(!strcmp(cmdbuf.buf, ""))
 		return 1;
 	else if(!strcmp(cmdbuf.buf, "FALLBACK"))
@@ -500,17 +538,14 @@ static int push_refs(struct transport *transport,
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
+		recvline(data, &buf);
 		if (!buf.len)
 			break;
 
@@ -605,8 +640,7 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 
 	while (1) {
 		char *eov, *eon;
-		if (strbuf_getline(&buf, data->out, '\n') == EOF)
-			exit(128); /* child died, message supplied already */
+		recvline(data, &buf);
 
 		if (!*buf.buf)
 			break;
@@ -631,6 +665,7 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 		}
 		tail = &((*tail)->next);
 	}
+	if(debug) fprintf(stderr, "Debug: Read ref listing.\n");
 	strbuf_release(&buf);
 
 	for (posn = ret; posn; posn = posn->next)
@@ -644,6 +679,9 @@ int transport_helper_init(struct transport *transport, const char *name)
 	struct helper_data *data = xcalloc(sizeof(*data), 1);
 	data->name = name;
 
+	if(getenv("GIT_TRANSPORT_HELPER_DEBUG"))
+		debug = 1;
+
 	transport->data = data;
 	transport->set_option = set_helper_option;
 	transport->get_refs_list = get_refs_list;
-- 
1.6.6.rc1.288.g40e67
