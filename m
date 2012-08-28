From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v7 05/16] Connect fast-import to the remote-helper via pipe, adding 'bidi-import' capability
Date: Tue, 28 Aug 2012 10:49:39 +0200
Message-ID: <1346143790-23491-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1346143790-23491-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 28 10:52:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6HWr-0002Rb-4D
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 10:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236Ab2H1Ivf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 04:51:35 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:42001 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393Ab2H1IvI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 04:51:08 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so1532823bkw.19
        for <git@vger.kernel.org>; Tue, 28 Aug 2012 01:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=aNo8VBlZVCaX+K+xhf5NIIJ8nuzZlKUqDfgTXv/Pdac=;
        b=AsTJ0Z4RdDPwX1pQ4gA33WqlbtNLR4Uf2sQ1c/Cr6WJAN6TbRxdFQSZaqrKY7di0d0
         +j01kZy5ORy7cF9XvI4F1XEZ0B5+oi5TzDzbsGJqXxJCaXZyinkjyZPU9QdNRFqeUqXA
         MIQXDT7eTLXwyuewBj1kkVWMZUPebBPITrDVFk2du7nZb4FH9v1ESL8u/qycv1Zbrb8k
         aG91fk2tdoXNGifSMfXgI4c4glXSiXcI/bX5WIf+8yXVuzOD+s+g67fwz0r6PhIhObWX
         z1Q3bu/Mhk2c4JmFLkzRzyMWwPZw84EiRsOotDWkI/dMtgwXWEjktOjNBdfM7Qe97wcU
         9Nag==
Received: by 10.205.129.17 with SMTP id hg17mr4691199bkc.88.1346143868184;
        Tue, 28 Aug 2012 01:51:08 -0700 (PDT)
Received: from flobuntu.lan (91-115-85-203.adsl.highway.telekom.at. [91.115.85.203])
        by mx.google.com with ESMTPS id m9sm12047800bkm.10.2012.08.28.01.51.05
        (version=SSLv3 cipher=OTHER);
        Tue, 28 Aug 2012 01:51:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1346143790-23491-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204414>

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
