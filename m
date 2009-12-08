From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [REROLL PATCH 1/8] Add remote helper debug mode
Date: Tue,  8 Dec 2009 15:16:10 +0200
Message-ID: <1260278177-9029-2-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1260278177-9029-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 08 14:17:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHzvz-0006BE-R1
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 14:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690AbZLHNQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 08:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754675AbZLHNQQ
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 08:16:16 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:39947 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754657AbZLHNQO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 08:16:14 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 1BB2F18D7B4
	for <git@vger.kernel.org>; Tue,  8 Dec 2009 15:16:20 +0200 (EET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A06C1016DD8; Tue, 08 Dec 2009 15:16:20 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id E08FD1C6390
	for <git@vger.kernel.org>; Tue,  8 Dec 2009 15:16:18 +0200 (EET)
X-Mailer: git-send-email 1.6.6.rc1.300.gfbc27
In-Reply-To: <1260278177-9029-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134862>

Remote helpers deadlock easily, so support debug mode which shows the
interaction steps.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 transport-helper.c |   94 ++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 69 insertions(+), 25 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 11f3d7e..a721dc2 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -8,6 +8,8 @@
 #include "quote.h"
 #include "remote.h"
 
+static int debug;
+
 struct helper_data
 {
 	const char *name;
@@ -22,6 +24,45 @@ struct helper_data
 	int refspec_nr;
 };
 
+static void sendline(struct helper_data *helper, struct strbuf *buffer)
+{
+	if (debug)
+		fprintf(stderr, "Debug: Remote helper: -> %s", buffer->buf);
+	if (write_in_full(helper->helper->in, buffer->buf, buffer->len)
+		!= buffer->len)
+		die_errno("Full write to remote helper failed");
+}
+
+static int recvline(struct helper_data *helper, struct strbuf *buffer)
+{
+	strbuf_reset(buffer);
+	if (debug)
+		fprintf(stderr, "Debug: Remote helper: Waiting...\n");
+	if (strbuf_getline(buffer, helper->out, '\n') == EOF) {
+		if (debug)
+			fprintf(stderr, "Debug: Remote helper quit.\n");
+		exit(128);
+	}
+
+	if (debug)
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
+	if (debug)
+		fprintf(stderr, "Debug: Remote helper: -> %s", str);
+	if (write_in_full(fd, str, strlen(str)) != strlen(str))
+		die_errno("Full write to remote helper failed");
+}
+
 static struct child_process *get_helper(struct transport *transport)
 {
 	struct helper_data *data = transport->data;
@@ -48,15 +89,16 @@ static struct child_process *get_helper(struct transport *transport)
 		die("Unable to run helper: git %s", helper->argv[0]);
 	data->helper = helper;
 
-	write_str_in_full(helper->in, "capabilities\n");
+	write_constant(helper->in, "capabilities\n");
 
 	data->out = xfdopen(helper->out, "r");
 	while (1) {
-		if (strbuf_getline(&buf, data->out, '\n') == EOF)
-			exit(128); /* child died, message supplied already */
+		recvline(data, &buf);
 
 		if (!*buf.buf)
 			break;
+		if (debug)
+			fprintf(stderr, "Debug: Got cap %s\n", buf.buf);
 		if (!strcmp(buf.buf, "fetch"))
 			data->fetch = 1;
 		if (!strcmp(buf.buf, "option"))
@@ -82,14 +124,21 @@ static struct child_process *get_helper(struct transport *transport)
 		free(refspecs);
 	}
 	strbuf_release(&buf);
+	if (debug)
+		fprintf(stderr, "Debug: Capabilities complete.\n");
 	return data->helper;
 }
 
 static int disconnect_helper(struct transport *transport)
 {
 	struct helper_data *data = transport->data;
+	struct strbuf buf = STRBUF_INIT;
+
 	if (data->helper) {
-		write_str_in_full(data->helper->in, "\n");
+		if (debug)
+			fprintf(stderr, "Debug: Disconnecting.\n");
+		strbuf_addf(&buf, "\n");
+		sendline(data, &buf);
 		close(data->helper->in);
 		fclose(data->out);
 		finish_command(data->helper);
@@ -117,10 +166,11 @@ static int set_helper_option(struct transport *transport,
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
 
@@ -143,12 +193,7 @@ static int set_helper_option(struct transport *transport,
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
@@ -208,13 +253,10 @@ static int fetch_with_fetch(struct transport *transport,
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
@@ -249,12 +291,13 @@ static int fetch_with_import(struct transport *transport,
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
 
@@ -264,7 +307,7 @@ static int fetch_with_import(struct transport *transport,
 			continue;
 
 		strbuf_addf(&buf, "import %s\n", posn->name);
-		write_in_full(helper->in, buf.buf, buf.len);
+		sendline(data, &buf);
 		strbuf_reset(&buf);
 	}
 	disconnect_helper(transport);
@@ -369,17 +412,14 @@ static int push_refs(struct transport *transport,
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
 
@@ -471,8 +511,7 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 
 	while (1) {
 		char *eov, *eon;
-		if (strbuf_getline(&buf, data->out, '\n') == EOF)
-			exit(128); /* child died, message supplied already */
+		recvline(data, &buf);
 
 		if (!*buf.buf)
 			break;
@@ -497,6 +536,8 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 		}
 		tail = &((*tail)->next);
 	}
+	if (debug)
+		fprintf(stderr, "Debug: Read ref listing.\n");
 	strbuf_release(&buf);
 
 	for (posn = ret; posn; posn = posn->next)
@@ -510,6 +551,9 @@ int transport_helper_init(struct transport *transport, const char *name)
 	struct helper_data *data = xcalloc(sizeof(*data), 1);
 	data->name = name;
 
+	if (getenv("GIT_TRANSPORT_HELPER_DEBUG"))
+		debug = 1;
+
 	transport->data = data;
 	transport->set_option = set_helper_option;
 	transport->get_refs_list = get_refs_list;
-- 
1.6.6.rc1.300.gfbc27
