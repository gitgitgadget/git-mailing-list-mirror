From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 5/7] remote-helpers: add support for an export command
Date: Mon, 29 Mar 2010 11:48:27 -0500
Message-ID: <1269881309-19690-6-git-send-email-srabbelier@gmail.com>
References: <1269881309-19690-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Git List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jonathan Niede
X-From: git-owner@vger.kernel.org Mon Mar 29 18:49:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwI9b-0007r6-JP
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 18:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953Ab0C2Qsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 12:48:55 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:40760 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754926Ab0C2Qsx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 12:48:53 -0400
Received: by mail-gw0-f46.google.com with SMTP id a18so4135768gwa.19
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 09:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Tv94PSuKv0GIUbSR+6gHM3EJUkSlyh5w7EbxzP3vsDI=;
        b=BaPHpCiBph+fLTV1NISOp/ryfY4Eps1sasf1R2PbVPPr+g31I9nxIeDStOB7T2YzD+
         heFvekDRckfa7hQmDANAbU4VsTAxR+sjHcMmvgH/ALAqsOMWLvDuvirhfffuF4zpXN/L
         gIFGDiX+NdDx5t/bF+6TLk8a+EzG9XzORrnb4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=D0aZACYVj82/vIo67UfdQfrGAEih/HQEKj0BF++BfmU7EneeNrIAyk8gHGbNnWPXlW
         1a20oimNun/UayVY98kjtpzMBj5iQl0+RTqeUyc/L8mj7NYbQ9MdCGnn073KGdwKq/Y5
         f/1kPt07Spa1MMCXP8fil1KpX8YmobJ/Gu5So=
Received: by 10.143.128.5 with SMTP id f5mr1327864wfn.271.1269881332849;
        Mon, 29 Mar 2010 09:48:52 -0700 (PDT)
Received: from localhost.localdomain (97-114-181-145.frgo.qwest.net [97.114.181.145])
        by mx.google.com with ESMTPS id 23sm4102040iwn.10.2010.03.29.09.48.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Mar 2010 09:48:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.317.gbb04ec
In-Reply-To: <1269881309-19690-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143496>

---

	This complements the 'import' capability, making it possible
	to use remote-helpers with only fast-import/fast-exports
	streams.

 transport-helper.c |  136 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 124 insertions(+), 12 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index c8705b7..f9ce036 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -7,6 +7,7 @@
 #include "revision.h"
 #include "quote.h"
 #include "remote.h"
+#include "string-list.h"
 
 static int debug;
 
@@ -17,6 +18,7 @@ struct helper_data
 	FILE *out;
 	unsigned fetch : 1,
 		import : 1,
+		export : 1,
 		option : 1,
 		push : 1,
 		connect : 1,
@@ -163,6 +165,8 @@ static struct child_process *get_helper(struct transport *transport)
 			data->push = 1;
 		else if (!strcmp(capname, "import"))
 			data->import = 1;
+		else if (!strcmp(capname, "export"))
+			data->export = 1;
 		else if (!data->refspecs && !prefixcmp(capname, "refspec ")) {
 			ALLOC_GROW(refspecs,
 				   refspec_nr + 1,
@@ -356,6 +360,33 @@ static int get_importer(struct transport *transport, struct child_process *fasti
 	return start_command(fastimport);
 }
 
+static int get_exporter(struct transport *transport,
+			struct child_process *fastexport,
+			const char *export_marks,
+			const char *import_marks,
+			struct string_list* revlist_args)
+{
+	struct child_process *helper = get_helper(transport);
+	int argc = 0, i;
+	memset(fastexport, 0, sizeof(*fastexport));
+
+	/* we need to duplicate helper->in because we want to use it after
+	 * fastexport is done with it. */
+	fastexport->out = dup(helper->in);
+	fastexport->argv = xcalloc(4 + revlist_args->nr, sizeof(*fastexport->argv));
+	fastexport->argv[argc++] = "fast-export";
+	if(export_marks)
+		fastexport->argv[argc++] = export_marks;
+	if(import_marks)
+		fastexport->argv[argc++] = import_marks;
+
+	for(i = 0; i < revlist_args->nr; i++)
+		fastexport->argv[argc++] = revlist_args->items[i].string;
+
+	fastexport->git_cmd = 1;
+	return start_command(fastexport);
+}
+
 static int fetch_with_import(struct transport *transport,
 			     int nr_heads, struct ref **to_fetch)
 {
@@ -523,7 +554,7 @@ static int fetch(struct transport *transport,
 	return -1;
 }
 
-static int push_refs(struct transport *transport,
+static int push_refs_with_push(struct transport *transport,
 		struct ref *remote_refs, int flags)
 {
 	int force_all = flags & TRANSPORT_PUSH_FORCE;
@@ -533,17 +564,6 @@ static int push_refs(struct transport *transport,
 	struct child_process *helper;
 	struct ref *ref;
 
-	if (process_connect(transport, 1)) {
-		do_take_over(transport);
-		return transport->push_refs(transport, remote_refs, flags);
-	}
-
-	if (!remote_refs) {
-		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
-			"Perhaps you should specify a branch such as 'master'.\n");
-		return 0;
-	}
-
 	helper = get_helper(transport);
 	if (!data->push)
 		return 1;
@@ -662,6 +682,98 @@ static int push_refs(struct transport *transport,
 	return 0;
 }
 
+static int push_refs_with_export(struct transport *transport,
+		struct ref *remote_refs, int flags)
+{
+	struct ref *ref;
+	struct child_process *helper, exporter;
+	struct helper_data *data = transport->data;
+	char *export_marks = NULL, *import_marks = NULL;
+	struct string_list revlist_args = { NULL, 0, 0 };
+	struct strbuf buf = STRBUF_INIT;
+
+	helper = get_helper(transport);
+
+	write_constant(helper->in, "export\n");
+
+	recvline(data, &buf);
+	if (debug)
+		fprintf(stderr, "Debug: Got export_marks '%s'\n", buf.buf);
+	if(buf.len)
+	{
+		struct strbuf arg = STRBUF_INIT;
+		strbuf_addstr(&arg, "--export-marks=");
+		strbuf_addbuf(&arg, &buf);
+		export_marks = strbuf_detach(&arg, NULL);
+	}
+
+	recvline(data, &buf);
+	if (debug)
+		fprintf(stderr, "Debug: Got import_marks '%s'\n", buf.buf);
+	if(buf.len)
+	{
+		struct strbuf arg = STRBUF_INIT;
+		strbuf_addstr(&arg, "--import-marks=");
+		strbuf_addbuf(&arg, &buf);
+		import_marks = strbuf_detach(&arg, NULL);
+	}
+
+	strbuf_reset(&buf);
+
+	for(ref = remote_refs; ref; ref = ref->next) {
+		char* private;
+		unsigned char sha1[20];
+
+
+		if(data->refspecs)
+			private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
+
+		if(private && !get_sha1(private, sha1))
+		{
+			strbuf_addf(&buf, "^%s", private);
+			string_list_append(strbuf_detach(&buf, NULL), &revlist_args);
+		}
+
+		string_list_append(ref->name, &revlist_args);
+
+	}
+
+	if (get_exporter(transport, &exporter,
+			 export_marks, import_marks, &revlist_args))
+		die("Couldn't run fast-export");
+
+	data->no_disconnect_req = 1;
+	finish_command(&exporter);
+	disconnect_helper(transport);
+	return 0;
+}
+
+static int push_refs(struct transport *transport,
+		struct ref *remote_refs, int flags)
+{
+	struct helper_data *data = transport->data;
+
+	if (process_connect(transport, 1)) {
+		do_take_over(transport);
+		return transport->push_refs(transport, remote_refs, flags);
+	}
+
+	if (!remote_refs) {
+		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
+			"Perhaps you should specify a branch such as 'master'.\n");
+		return 0;
+	}
+
+	if (data->push)
+		return push_refs_with_push(transport, remote_refs, flags);
+
+	if (data->export)
+		return push_refs_with_export(transport, remote_refs, flags);
+
+	return -1;
+}
+
+
 static int has_attribute(const char *attrs, const char *attr) {
 	int len;
 	if (!attrs)
-- 
1.7.0.3.317.gbb04ec
