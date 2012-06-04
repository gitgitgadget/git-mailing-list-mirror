From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC 4/4] Add cat-blob report pipe from fast-import to remote-helper.
Date: Mon,  4 Jun 2012 19:20:55 +0200
Message-ID: <1338830455-3091-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1338830455-3091-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1338830455-3091-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1338830455-3091-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 19:21:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbayJ-0003FD-NK
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 19:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754795Ab2FDRVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 13:21:31 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:51121 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754769Ab2FDRV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 13:21:29 -0400
Received: by mail-bk0-f46.google.com with SMTP id ji2so3818493bkc.19
        for <git@vger.kernel.org>; Mon, 04 Jun 2012 10:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4RVSzszjuMl3/bPTKJuLorjLdkY6cWurNnIpvD/MRTA=;
        b=BivIQNKEtBSR8T2S+DdzFYnhNO0oVJnzcgKnhCczqA+oYdCJZuTof2ga4QsMbM3nua
         xA0MDDPCQUx88kMMsfFeNjO8s/YAP0I9n1W0wtvDnKJcePQTvai8/kC0671mNaO6Sk6o
         WU4/x1ja+QsoCQ39MBRNWXz2N6zQQMDbysnrPKAJbis40BkvZMrsiZCNW/DzGvQkY+UB
         rnZr142uMbdbMy1G4ycqv13vnB1y01yVzt/Ip4Umw4rHFIEvfIURSNNit1IhoAq+C8jM
         +xiGEBtJXbSkdnt4IPEbp3d+cYY88pTANTlbTQZmBUaomuPvB3F4uzc5l06e6rfPfcV9
         b0kQ==
Received: by 10.204.150.89 with SMTP id x25mr7424909bkv.24.1338830488268;
        Mon, 04 Jun 2012 10:21:28 -0700 (PDT)
Received: from flobuntu.lan (m-149.vc-graz.ac.at. [193.170.224.149])
        by mx.google.com with ESMTPS id m2sm11224637bkm.2.2012.06.04.10.21.26
        (version=SSLv3 cipher=OTHER);
        Mon, 04 Jun 2012 10:21:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1338830455-3091-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199157>

On invocation of a helper a new pipe is opened.
To close the other end after fork, the prexec_cb feature
of the run_command api is used.
If the helper is not used with fast-import later the pipe
is unused.
The FD is passed to the remote-helper via it's environment,
helpers that don't use fast-import can simply ignore it.
fast-import has an argv for that.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 transport-helper.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/svndump.c  |    9 ++++++++-
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index 61c928f..b438040 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -17,6 +17,7 @@ struct helper_data {
 	const char *name;
 	struct child_process *helper;
 	FILE *out;
+	int fast_import_backchannel_pipe[2];
 	unsigned fetch : 1,
 		import : 1,
 		export : 1,
@@ -98,19 +99,30 @@ static void do_take_over(struct transport *transport)
 	free(data);
 }
 
+static int fd_to_close;
+void close_fd_prexec_cb(void)
+{
+	if(debug)
+		fprintf(stderr, "close_fd_prexec_cb closing %d\n", fd_to_close);
+	close(fd_to_close);
+}
+
 static struct child_process *get_helper(struct transport *transport)
 {
 	struct helper_data *data = transport->data;
 	struct strbuf buf = STRBUF_INIT;
+	struct strbuf envbuf = STRBUF_INIT;
 	struct child_process *helper;
 	const char **refspecs = NULL;
 	int refspec_nr = 0;
 	int refspec_alloc = 0;
 	int duped;
 	int code;
+	int err;
 	char git_dir_buf[sizeof(GIT_DIR_ENVIRONMENT) + PATH_MAX + 1];
 	const char *helper_env[] = {
 		git_dir_buf,
+		NULL,	/* placeholder */
 		NULL
 	};
 
@@ -133,6 +145,24 @@ static struct child_process *get_helper(struct transport *transport)
 	snprintf(git_dir_buf, sizeof(git_dir_buf), "%s=%s", GIT_DIR_ENVIRONMENT, get_git_dir());
 	helper->env = helper_env;
 
+
+	/* create an additional pipe from fast-import to the helper */
+	err = pipe(data->fast_import_backchannel_pipe);
+	if(err)
+		die("cannot create fast_import_backchannel_pipe: %s", strerror(errno));
+
+	if(debug)
+		fprintf(stderr, "Remote helper created fast_import_backchannel_pipe { %d, %d }\n",
+				data->fast_import_backchannel_pipe[0], data->fast_import_backchannel_pipe[1]);
+
+	strbuf_addf(&envbuf, "GIT_REPORT_FILENO=%d", data->fast_import_backchannel_pipe[0]);
+	helper_env[1] = strbuf_detach(&envbuf, NULL);
+
+	/* after the fork, we need to close the write end in the helper */
+	fd_to_close = data->fast_import_backchannel_pipe[1];
+	/* the prexec callback is run just before exec */
+	helper->preexec_cb = close_fd_prexec_cb;
+
 	code = start_command(helper);
 	if (code < 0 && errno == ENOENT)
 		die("Unable to find remote helper for '%s'", data->name);
@@ -141,6 +171,7 @@ static struct child_process *get_helper(struct transport *transport)
 
 	data->helper = helper;
 	data->no_disconnect_req = 0;
+	free((void*)helper_env[1]);
 
 	/*
 	 * Open the output as FILE* so strbuf_getline() can be used.
@@ -237,6 +268,10 @@ static int disconnect_helper(struct transport *transport)
 			xwrite(data->helper->in, "\n", 1);
 			sigchain_pop(SIGPIPE);
 		}
+		/* close the pipe, it is still open if it wasn't used for fast-import. */
+		close(data->fast_import_backchannel_pipe[0]);
+		close(data->fast_import_backchannel_pipe[1]);
+
 		close(data->helper->in);
 		close(data->helper->out);
 		fclose(data->out);
@@ -376,13 +411,20 @@ static int fetch_with_fetch(struct transport *transport,
 static int get_importer(struct transport *transport, struct child_process *fastimport)
 {
 	struct child_process *helper = get_helper(transport);
+	struct helper_data *data = transport->data;
+	struct strbuf buf = STRBUF_INIT;
 	memset(fastimport, 0, sizeof(*fastimport));
 	fastimport->in = helper->out;
 	fastimport->argv = xcalloc(5, sizeof(*fastimport->argv));
 	fastimport->argv[0] = "fast-import";
 	fastimport->argv[1] = "--quiet";
+	strbuf_addf(&buf, "--cat-blob-fd=%d", data->fast_import_backchannel_pipe[1]);
+	fastimport->argv[2] = strbuf_detach(&buf, NULL);
 
 	fastimport->git_cmd = 1;
+
+	fd_to_close = data->fast_import_backchannel_pipe[0];
+	fastimport->preexec_cb = close_fd_prexec_cb;
 	return start_command(fastimport);
 }
 
@@ -427,6 +469,11 @@ static int fetch_with_import(struct transport *transport,
 	if (get_importer(transport, &fastimport))
 		die("Couldn't run fast-import");
 
+
+	/* in the parent process we close both pipe ends. */
+	close(data->fast_import_backchannel_pipe[0]);
+	close(data->fast_import_backchannel_pipe[1]);
+
 	for (i = 0; i < nr_heads; i++) {
 		posn = to_fetch[i];
 		if (posn->status & REF_STATUS_UPTODATE)
@@ -441,6 +488,7 @@ static int fetch_with_import(struct transport *transport,
 
 	if (finish_command(&fastimport))
 		die("Error while running fast-import");
+	free((void*)fastimport.argv[2]);
 	free(fastimport.argv);
 	fastimport.argv = NULL;
 
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 2f0089f..b1fe03f 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -467,7 +467,14 @@ void svndump_read(const char *url)
 
 static void init()
 {
-	fast_export_init(REPORT_FILENO);
+	int report_fd;
+	char* back_fd_env = getenv("GIT_REPORT_FILENO");
+	if(!back_fd_env || sscanf(back_fd_env, "%d", &report_fd) != 1) {
+		warning("Cannot get cat-blob fd from environment, using default!");
+		report_fd = REPORT_FILENO;
+	}
+
+	fast_export_init(report_fd);
 	strbuf_init(&dump_ctx.uuid, 4096);
 	strbuf_init(&dump_ctx.url, 4096);
 	strbuf_init(&rev_ctx.log, 4096);
-- 
1.7.9.5
