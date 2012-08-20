From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v5 05/16] Connect fast-import to the remote-helper via pipe, adding 'bidi-import' capability
Date: Mon, 20 Aug 2012 23:52:11 +0200
Message-ID: <1345499542-15536-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345499542-15536-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 23:53:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3ZuY-0008Es-MW
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 23:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755871Ab2HTVxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 17:53:16 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:43593 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755855Ab2HTVxM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 17:53:12 -0400
Received: by mail-we0-f174.google.com with SMTP id x8so4177354wey.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 14:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=aNo8VBlZVCaX+K+xhf5NIIJ8nuzZlKUqDfgTXv/Pdac=;
        b=h8eAHDEU4Xgflqc4d8WM1ZN/crxzvBzhWEMmFWIino/EcBsIh78V8EuKCHwU/tpOKc
         1U36ABSFAuattAJx/1HvYvBt4gQgDTC+JfZCOkmaVst9UJZN/L3RWPsGAB2pZcj3F5Hc
         9xCKvqH5yd+cCTUlPUDXxZWhOuCP8Ec16oLVsp6luPbYwgZyYmR48d6M+jQKa8N28RyB
         kFXwwEvw9aVCJG6+qGsBJkzfYaGgGFWoIlL5eEaUoBGSqYl+PU9L2X0NuvJHjqgKLMJk
         ebFrMOlOgQRfh6cDF9taLyj0lDvOfC6F67b3qhSVgwZ+rstXy65hXWC3aZRMbOujynF0
         kglg==
Received: by 10.180.75.209 with SMTP id e17mr37541364wiw.0.1345499591644;
        Mon, 20 Aug 2012 14:53:11 -0700 (PDT)
Received: from flomedio.lan (91-115-90-54.adsl.highway.telekom.at. [91.115.90.54])
        by mx.google.com with ESMTPS id w7sm30196654wiz.0.2012.08.20.14.53.09
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 14:53:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345499542-15536-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203880>

The fast-import commands 'cat-blob' and 'ls' can be used by
remote-helpers to retrieve information about blobs and trees that
already exist in fast-import's memory. This requires a channel from
fast-import to the remote-helper.

remote-helpers that use these features shall advertise the new
'bidi-import' capability to signal that they require the communication
channel.  When forking fast-import in transport-helper.c connect it to
a dup of the remote-helper's stdin-pipe. The additional file
descriptor is passed to fast-import via its command line
(--cat-blob-fd).  It follows that git and fast-import are connected to
the remote-helpers's stdin.

Because git can send multiple commands to the remote-helper on it's
stdin, it is required that helpers that advertise 'bidi-import' buffer
all input commands until the batch of 'import' commands is ended by a
newline before sending data to fast-import.  This is to prevent mixing
commands and fast-import responses on the helper's stdin.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 transport-helper.c |   44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index cfe0988..3523f1f 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -10,6 +10,7 @@
 #include "string-list.h"
 #include "thread-utils.h"
 #include "sigchain.h"
+#include "argv-array.h"
 
 static int debug;
 
@@ -19,6 +20,7 @@ struct helper_data {
 	FILE *out;
 	unsigned fetch : 1,
 		import : 1,
+		bidi_import : 1,
 		export : 1,
 		option : 1,
 		push : 1,
@@ -101,6 +103,7 @@ static void do_take_over(struct transport *transport)
 static struct child_process *get_helper(struct transport *transport)
 {
 	struct helper_data *data = transport->data;
+	struct argv_array argv = ARGV_ARRAY_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	struct child_process *helper;
 	const char **refspecs = NULL;
@@ -122,11 +125,10 @@ static struct child_process *get_helper(struct transport *transport)
 	helper->in = -1;
 	helper->out = -1;
 	helper->err = 0;
-	helper->argv = xcalloc(4, sizeof(*helper->argv));
-	strbuf_addf(&buf, "git-remote-%s", data->name);
-	helper->argv[0] = strbuf_detach(&buf, NULL);
-	helper->argv[1] = transport->remote->name;
-	helper->argv[2] = remove_ext_force(transport->url);
+	argv_array_pushf(&argv, "git-remote-%s", data->name);
+	argv_array_push(&argv, transport->remote->name);
+	argv_array_push(&argv, remove_ext_force(transport->url));
+	helper->argv = argv_array_detach(&argv, NULL);
 	helper->git_cmd = 0;
 	helper->silent_exec_failure = 1;
 
@@ -178,6 +180,8 @@ static struct child_process *get_helper(struct transport *transport)
 			data->push = 1;
 		else if (!strcmp(capname, "import"))
 			data->import = 1;
+		else if (!strcmp(capname, "bidi-import"))
+			data->bidi_import = 1;
 		else if (!strcmp(capname, "export"))
 			data->export = 1;
 		else if (!data->refspecs && !prefixcmp(capname, "refspec ")) {
@@ -241,8 +245,7 @@ static int disconnect_helper(struct transport *transport)
 		close(data->helper->out);
 		fclose(data->out);
 		res = finish_command(data->helper);
-		free((char *)data->helper->argv[0]);
-		free(data->helper->argv);
+		argv_array_free_detached(data->helper->argv);
 		free(data->helper);
 		data->helper = NULL;
 	}
@@ -376,14 +379,23 @@ static int fetch_with_fetch(struct transport *transport,
 static int get_importer(struct transport *transport, struct child_process *fastimport)
 {
 	struct child_process *helper = get_helper(transport);
+	struct helper_data *data = transport->data;
+	struct argv_array argv = ARGV_ARRAY_INIT;
+	int cat_blob_fd, code;
 	memset(fastimport, 0, sizeof(*fastimport));
 	fastimport->in = helper->out;
-	fastimport->argv = xcalloc(5, sizeof(*fastimport->argv));
-	fastimport->argv[0] = "fast-import";
-	fastimport->argv[1] = "--quiet";
+	argv_array_push(&argv, "fast-import");
+	argv_array_push(&argv, "--quiet");
 
+	if (data->bidi_import) {
+		cat_blob_fd = xdup(helper->in);
+		argv_array_pushf(&argv, "--cat-blob-fd=%d", cat_blob_fd);
+	}
+	fastimport->argv = argv.argv;
 	fastimport->git_cmd = 1;
-	return start_command(fastimport);
+
+	code = start_command(fastimport);
+	return code;
 }
 
 static int get_exporter(struct transport *transport,
@@ -438,11 +450,17 @@ static int fetch_with_import(struct transport *transport,
 	}
 
 	write_constant(data->helper->in, "\n");
+	/*
+	 * remote-helpers that advertise the bidi-import capability are required to
+	 * buffer the complete batch of import commands until this newline before
+	 * sending data to fast-import.
+	 * These helpers read back data from fast-import on their stdin, which could
+	 * be mixed with import commands, otherwise.
+	 */
 
 	if (finish_command(&fastimport))
 		die("Error while running fast-import");
-	free(fastimport.argv);
-	fastimport.argv = NULL;
+	argv_array_free_detached(fastimport.argv);
 
 	/*
 	 * The fast-import stream of a remote helper that advertises
-- 
1.7.9.5
