From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH/RFC v3 04/16] Connect fast-import to the remote-helper via pipe, adding 'bidi-import' capability.
Date: Tue, 14 Aug 2012 21:13:06 +0200
Message-ID: <1344971598-8213-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1344971598-8213-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 21:17:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1Mc9-0003IV-RW
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 21:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756526Ab2HNTRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 15:17:08 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44490 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755740Ab2HNTRE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 15:17:04 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so265503bkw.19
        for <git@vger.kernel.org>; Tue, 14 Aug 2012 12:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0M6GdZOrVl7I0B/agQZBg/95+LEb7ahZw2v8gm2Ph+4=;
        b=z2sjqMOGFIt7+SbI/2TF9DZN//TCHlSXwdp37S7P/8SnU8DLbppRsNdglStB1w2bj6
         s3i3MAJkiTB2whNVc393beknKfKe2UQCQVXwJ/UT+wVMUVVAHbeM20oP8w64y78msRe0
         TVJx7D1awU5a0coEoG8xFxdJsJpxjcGH/TmPRHjzckPpJsa5+aa4mOnUBb0RyssG/iAA
         cp/4ErhXK/jZKsJ9ivYC+zubKQWiM6IJ+b2aeAqRpzmLgJoj+PbNK3wS0J5Fr7wSV4um
         GM/nJY4cqos06baU39GRtzfSJOo+o5jW+p08CFelXyVcU85V+ykMqgVhnae/pbmmmPlG
         O4Pw==
Received: by 10.204.152.136 with SMTP id g8mr6733832bkw.44.1344971824011;
        Tue, 14 Aug 2012 12:17:04 -0700 (PDT)
Received: from localhost.localdomain (089144206125.atnat0015.highway.a1.net. [89.144.206.125])
        by mx.google.com with ESMTPS id fu8sm1681583bkc.5.2012.08.14.12.17.00
        (version=SSLv3 cipher=OTHER);
        Tue, 14 Aug 2012 12:17:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1344971598-8213-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203430>

The fast-import commands 'cat-blob' and 'ls' can be used by remote-helpers
to retrieve information about blobs and trees that already exist in
fast-import's memory. This requires a channel from fast-import to the
remote-helper.
remote-helpers that use this features shall advertise the new 'bidi-import'
capability so signal that they require the communication channel.
When forking fast-import in transport-helper.c connect it to a dup of
the remote-helper's stdin-pipe. The additional file descriptor is passed
to fast-import via it's command line (--cat-blob-fd).
It follows that git and fast-import are connected to the remote-helpers's
stdin.
Because git can send multiple commands to the remote-helper on it's stdin,
it is required that helpers that advertise 'bidi-import' buffer all input
commands until the batch of 'import' commands is ended by a newline
before sending data to fast-import.
This is to prevent mixing commands and fast-import responses on the
helper's stdin.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 transport-helper.c |   45 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index cfe0988..257274b 100644
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
+	helper->argv = argv.argv;
 	helper->git_cmd = 0;
 	helper->silent_exec_failure = 1;
 
@@ -141,6 +143,8 @@ static struct child_process *get_helper(struct transport *transport)
 
 	data->helper = helper;
 	data->no_disconnect_req = 0;
+	free((void*) helper_env[1]);
+	argv_array_clear(&argv);
 
 	/*
 	 * Open the output as FILE* so strbuf_getline() can be used.
@@ -178,6 +182,8 @@ static struct child_process *get_helper(struct transport *transport)
 			data->push = 1;
 		else if (!strcmp(capname, "import"))
 			data->import = 1;
+		else if (!strcmp(capname, "bidi-import"))
+			data->bidi_import = 1;
 		else if (!strcmp(capname, "export"))
 			data->export = 1;
 		else if (!data->refspecs && !prefixcmp(capname, "refspec ")) {
@@ -241,8 +247,6 @@ static int disconnect_helper(struct transport *transport)
 		close(data->helper->out);
 		fclose(data->out);
 		res = finish_command(data->helper);
-		free((char *)data->helper->argv[0]);
-		free(data->helper->argv);
 		free(data->helper);
 		data->helper = NULL;
 	}
@@ -376,14 +380,24 @@ static int fetch_with_fetch(struct transport *transport,
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
+	argv_array_clear(&argv);
+	return code;
 }
 
 static int get_exporter(struct transport *transport,
@@ -438,11 +452,16 @@ static int fetch_with_import(struct transport *transport,
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
 
 	/*
 	 * The fast-import stream of a remote helper that advertises
-- 
1.7.9.5
