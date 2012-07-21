From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [RFC 4/4 v3] Add cat-blob report fifo from fast-import to remote-helper.
Date: Sat, 21 Jul 2012 14:45:20 +0200
Message-ID: <2448876.O3MA5kWbuX@flobuntu>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <1374057.qfvOg1c6C6@flobuntu> <1415957.ivnctqiWQE@flobuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>, jrnieder@gmail.com
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 14:46:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsZ4S-0004Ec-AC
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 14:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336Ab2GUMqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jul 2012 08:46:03 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56053 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318Ab2GUMpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2012 08:45:25 -0400
Received: by bkwj10 with SMTP id j10so4092384bkw.19
        for <git@vger.kernel.org>; Sat, 21 Jul 2012 05:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=OqhDs2REbZ3xs24Z2r4J+dSl6U1B2LwlsG4iXbacPmM=;
        b=Zl1cVfyJLvJTIF5JceoBdkXCeczm6HJaSQiQPyqNWuEpTXSKVeTof0IZptJQ/Au7AJ
         AHtC9deM/mnHolGJaRNhvg3LYh8Hi5w0+t+DVC+wURyQUhHWjuFcWdY4J2gAgX59rVMw
         KxpbbBM1AVi+Fm9wHgw1Okl16HgSTa5Xxz+6i/ICkVLOLunW9vuFiMARCUuyWXagRQxy
         L8ztuhbju26HdkBts5umOgSVaj0xivX3GXBEnAnqrlr7M8BWf7n5xzkp1MVS6iutecFY
         TJeM/nL489akTsp3pdeiZttU1uD5dYW9GrXA4yeUpfDmoz4FiqgBry5qMaVhZR9AVrpg
         GG8w==
Received: by 10.205.127.131 with SMTP id ha3mr4730282bkc.123.1342874724107;
        Sat, 21 Jul 2012 05:45:24 -0700 (PDT)
Received: from flobuntu.localnet (93-82-157-153.adsl.highway.telekom.at. [93.82.157.153])
        by mx.google.com with ESMTPS id y20sm4055682bkv.11.2012.07.21.05.45.21
        (version=SSLv3 cipher=OTHER);
        Sat, 21 Jul 2012 05:45:22 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.2.0-26-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <1415957.ivnctqiWQE@flobuntu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201806>

For some fast-import commands (e.g. cat-blob) an answer-channel
is required. For this purpose a fifo (aka named pipe) (mkfifo)
is created (.git/fast-import-report-fifo) by the transport-helper
when fetch via import is requested. The remote-helper and
fast-import open the ends of the pipe.

The filename of the fifo is passed to the remote-helper via
it's environment, helpers that don't use fast-import can
simply ignore it.
Add a new command line option --cat-blob-pipe to fast-import,
for this purpose.

Use argv_arrays in get_helper and get_importer.

Opening the pipe with O_RDWR prevents blocking open calls on both ends.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
diff: Opening the pipe with O_RDWR prevents blocking open calls on both ends.
 fast-import.c      |   15 ++++++++++++
 transport-helper.c |   64 ++++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 64 insertions(+), 15 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index eed97c8..65a9341 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3180,6 +3180,16 @@ static void option_cat_blob_fd(const char *fd)
 	cat_blob_fd = (int) n;
 }
 
+static void option_cat_blob_pipe(const char *name)
+{
+	int report_fd = open(name, O_RDWR);
+	warning("Opened pipe %s.", name);
+	if(report_fd < 0) {
+		die("Unable to open fast-import back-pipe! %s", strerror(errno));
+	}
+	cat_blob_fd = report_fd;
+}
+
 static void option_export_pack_edges(const char *edges)
 {
 	if (pack_edges)
@@ -3337,6 +3347,11 @@ static void parse_argv(void)
 			continue;
 		}
 
+		if(!prefixcmp(a + 2, "cat-blob-pipe=")) {
+			option_cat_blob_pipe(a + 2 + strlen("cat-blob-pipe="));
+			continue;
+		}
+
 		die("unknown option %s", a);
 	}
 	if (i != global_argc)
diff --git a/transport-helper.c b/transport-helper.c
index 61c928f..616db91 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -10,6 +10,7 @@
 #include "string-list.h"
 #include "thread-utils.h"
 #include "sigchain.h"
+#include "argv-array.h"
 
 static int debug;
 
@@ -17,6 +18,7 @@ struct helper_data {
 	const char *name;
 	struct child_process *helper;
 	FILE *out;
+	char *report_fifo;
 	unsigned fetch : 1,
 		import : 1,
 		export : 1,
@@ -101,6 +103,7 @@ static void do_take_over(struct transport *transport)
 static struct child_process *get_helper(struct transport *transport)
 {
 	struct helper_data *data = transport->data;
+	struct argv_array argv = ARGV_ARRAY_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	struct child_process *helper;
 	const char **refspecs = NULL;
@@ -111,6 +114,7 @@ static struct child_process *get_helper(struct transport *transport)
 	char git_dir_buf[sizeof(GIT_DIR_ENVIRONMENT) + PATH_MAX + 1];
 	const char *helper_env[] = {
 		git_dir_buf,
+		NULL,	/* placeholder */
 		NULL
 	};
 
@@ -122,17 +126,23 @@ static struct child_process *get_helper(struct transport *transport)
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
 
 	snprintf(git_dir_buf, sizeof(git_dir_buf), "%s=%s", GIT_DIR_ENVIRONMENT, get_git_dir());
 	helper->env = helper_env;
 
+	strbuf_init(&buf, 0);
+	strbuf_addf(&buf, "%s/fast-import-report-fifo", get_git_dir());
+	data->report_fifo = strbuf_detach(&buf, NULL);
+	strbuf_init(&buf, 0);
+	strbuf_addf(&buf, "GIT_REPORT_FIFO=%s", data->report_fifo);
+	helper_env[1] = strbuf_detach(&buf, NULL);
+
 	code = start_command(helper);
 	if (code < 0 && errno == ENOENT)
 		die("Unable to find remote helper for '%s'", data->name);
@@ -141,6 +151,8 @@ static struct child_process *get_helper(struct transport *transport)
 
 	data->helper = helper;
 	data->no_disconnect_req = 0;
+	free((void*) helper_env[1]);
+	argv_array_clear(&argv);
 
 	/*
 	 * Open the output as FILE* so strbuf_getline() can be used.
@@ -237,13 +249,13 @@ static int disconnect_helper(struct transport *transport)
 			xwrite(data->helper->in, "\n", 1);
 			sigchain_pop(SIGPIPE);
 		}
+
 		close(data->helper->in);
 		close(data->helper->out);
 		fclose(data->out);
 		res = finish_command(data->helper);
-		free((char *)data->helper->argv[0]);
-		free(data->helper->argv);
 		free(data->helper);
+		free(data->report_fifo);
 		data->helper = NULL;
 	}
 	return res;
@@ -373,16 +385,18 @@ static int fetch_with_fetch(struct transport *transport,
 	return 0;
 }
 
-static int get_importer(struct transport *transport, struct child_process *fastimport)
+static int get_importer(struct transport *transport, struct child_process *fastimport, struct argv_array *argv)
 {
 	struct child_process *helper = get_helper(transport);
+	struct helper_data *data = transport->data;
 	memset(fastimport, 0, sizeof(*fastimport));
 	fastimport->in = helper->out;
-	fastimport->argv = xcalloc(5, sizeof(*fastimport->argv));
-	fastimport->argv[0] = "fast-import";
-	fastimport->argv[1] = "--quiet";
-
+	argv_array_push(argv, "fast-import");
+	argv_array_push(argv, "--quiet");
+	argv_array_pushf(argv, "--cat-blob-pipe=%s", data->report_fifo);
+	fastimport->argv = argv->argv;
 	fastimport->git_cmd = 1;
+
 	return start_command(fastimport);
 }
 
@@ -421,10 +435,30 @@ static int fetch_with_import(struct transport *transport,
 	int i;
 	struct ref *posn;
 	struct strbuf buf = STRBUF_INIT;
+	struct argv_array importer_argv = ARGV_ARRAY_INIT;
+	struct stat fifostat;
+
+	/* create a fifo for back-reporting of fast-import to the remote helper,
+	 * if it doesn't exist. */
+	if(!stat(data->report_fifo, &fifostat)) {
+		if(S_ISFIFO(fifostat.st_mode)) {		/* exists and is fifo, unlink and recreate, to be sure that permissions are ok.. */
+			if (debug)
+				fprintf(stderr, "Debug: Remote helper: Unlinked existing fifo.\n");
+			if(unlink(data->report_fifo))
+				die_errno("Couldn't unlink fifo %s", data->report_fifo);
+		}
+		else
+			die("Fifo %s used by some other file.", data->report_fifo);
+	}
+	if(mkfifo(data->report_fifo, 0660))
+		die_errno("Couldn't create fifo %s", data->report_fifo);
+	if (debug)
+		fprintf(stderr, "Debug: Remote helper: Mkfifo %s\n", data->report_fifo);
+
 
 	get_helper(transport);
 
-	if (get_importer(transport, &fastimport))
+	if (get_importer(transport, &fastimport, &importer_argv))
 		die("Couldn't run fast-import");
 
 	for (i = 0; i < nr_heads; i++) {
@@ -441,8 +475,8 @@ static int fetch_with_import(struct transport *transport,
 
 	if (finish_command(&fastimport))
 		die("Error while running fast-import");
-	free(fastimport.argv);
-	fastimport.argv = NULL;
+
+	argv_array_clear(&importer_argv);
 
 	for (i = 0; i < nr_heads; i++) {
 		char *private;
-- 
1.7.9.5
