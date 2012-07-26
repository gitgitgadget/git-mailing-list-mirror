From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC 01/16] Implement a remote helper for svn in C.
Date: Thu, 26 Jul 2012 09:32:22 +0200
Message-ID: <1343287957-22040-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1343287957-22040-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 09:34:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuIaZ-0004iX-Kh
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 09:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360Ab2GZHeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 03:34:22 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58737 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125Ab2GZHeV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 03:34:21 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so1067267bkw.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 00:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=seRxYBQd2Z72AH0epRycRVy1lQe47cPhvXLEvqcG/Yc=;
        b=a00s6EW2JyLHNXxPuzEjTnL4m2gWsOQM4nJIDySpDem38hEs1wyOxX0+NgnvnYcvLD
         NlaGS4K1ARXZIZJYl0DqBJJX3ko/QSu7STabjnfxT+3Q/Idqp6GSxtYBI1dsxRCO17if
         ghhZo+/hKNawK/a29MnU5rmudicI9LHE/MMRqWPDaJCseuFAxAsm43jrtOEcG7TH20es
         FygcTXT6EaZQ9VJ5R/83TAH3pScb/soGP1K/lTX2wjiNX/2Gvs7hvRjMuMy9GGheK2/0
         +Ywi7ORa5cJdgU5gFohXTGt48WxJRzjNmXyTad4WwQkqdsXU+ea+hfAfhMUzD4lWrT7/
         uZPA==
Received: by 10.204.13.82 with SMTP id b18mr13584749bka.118.1343288060803;
        Thu, 26 Jul 2012 00:34:20 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id n5sm13880348bkv.14.2012.07.26.00.34.18
        (version=SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 00:34:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1343287957-22040-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202231>

Enables basic fetching from subversion repositories. When processing Remote URLs
starting with svn::, git invokes this remote-helper.
It starts svnrdump to extract revisions from the subversion repository in the
'dump file format', and converts them to a git-fast-import stream using
the functions of vcs-svn/.

Imported refs are created in a private namespace at refs/svn/<remote-name/master.
The revision history is imported linearly (no branch detection) and completely,
i.e. from revision 0 to HEAD.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 contrib/svn-fe/remote-svn.c |  219 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 219 insertions(+)
 create mode 100644 contrib/svn-fe/remote-svn.c

diff --git a/contrib/svn-fe/remote-svn.c b/contrib/svn-fe/remote-svn.c
new file mode 100644
index 0000000..29fc371
--- /dev/null
+++ b/contrib/svn-fe/remote-svn.c
@@ -0,0 +1,219 @@
+
+#include "cache.h"
+#include "remote.h"
+#include "strbuf.h"
+#include "url.h"
+#include "exec_cmd.h"
+#include "run-command.h"
+#include "svndump.h"
+#include "argv-array.h"
+
+static int debug;
+
+static inline void printd(const char *fmt, ...)
+{
+	if (debug) {
+		va_list vargs;
+		va_start(vargs, fmt);
+		fprintf(stderr, "rhsvn debug: ");
+		vfprintf(stderr, fmt, vargs);
+		fprintf(stderr, "\n");
+		va_end(vargs);
+	}
+}
+
+static const char *url;
+static const char *private_ref;
+static const char *remote_ref = "refs/heads/master";
+
+/*
+ * remote-helpers receive commands on their stdin. Command handler functions
+ * can return cmd_result, on fatal errors they die().
+ * NOT_HANDLED: the command was not handled by this function, name doesn't match.
+ * TERMINATE: Requests normal termination of the remote-helper.
+ */
+enum cmd_result { SUCCESS, NOT_HANDLED, TERMINATE };
+enum cmd_result cmd_capabilities(struct strbuf *line);
+enum cmd_result cmd_import(struct strbuf *line);
+enum cmd_result cmd_list(struct strbuf *line);
+enum cmd_result cmd_terminate(struct strbuf *line);
+
+typedef enum cmd_result (*input_command_handler)(struct strbuf *);
+
+const input_command_handler input_command_list[] = {
+		cmd_capabilities, cmd_import, cmd_list, cmd_terminate, NULL
+};
+
+enum cmd_result cmd_capabilities(struct strbuf *line)
+{
+	if (strcmp(line->buf, "capabilities"))
+		return NOT_HANDLED;
+
+	printf("import\n");
+	printf("refspec %s:%s\n\n", remote_ref, private_ref);
+	fflush(stdout);
+	return SUCCESS;
+}
+
+enum cmd_result cmd_import(struct strbuf *line)
+{
+	static int batch_active;
+	int code, report_fd;
+	char *back_pipe_env;
+	int dumpin_fd;
+	unsigned int startrev = 0;
+	struct argv_array svndump_argv = ARGV_ARRAY_INIT;
+	struct child_process svndump_proc;
+
+	/* terminate a current batch's fast-import stream */
+	if (line->len == 0 && batch_active) {
+		printf("done\n");
+		fflush(stdout);
+		batch_active = 0;
+		printd("import-batch finished.");
+		/*
+		 * should the remote helper terminate after a batch?
+		 * It seems that it should.
+		 */
+		return TERMINATE;
+	}
+	if (prefixcmp(line->buf, "import"))
+		return NOT_HANDLED;
+
+	/* import commands can be grouped together in a batch. Batches are ended by \n */
+	batch_active = 1;
+
+	/*
+	 * When the remote-helper is invoked by transport-helper.c it passes the
+	 * filename of this pipe in the env-var.
+	 */
+	back_pipe_env = getenv("GIT_REPORT_FIFO");
+	if (!back_pipe_env) {
+		die("Cannot get cat-blob-pipe from environment! GIT_REPORT_FIFO has to"
+				"be set by the caller.");
+	}
+
+	/*
+	 * Opening a fifo for reading usually blocks until a writer has opened it too.
+	 * Opening a fifo for writing usually blocks until a reader has opened it too.
+	 * Therefore, we open with RDWR on both sides to avoid deadlocks.
+	 * Especially if there's nothing to do and one pipe end is closed immediately.
+	 */
+	report_fd = open(back_pipe_env, O_RDWR);
+	if (report_fd < 0) {
+		die("Unable to open fast-import back-pipe! %s", strerror(errno));
+	}
+	printd("Opened fast-import back-pipe %s for reading.", back_pipe_env);
+
+	memset(&svndump_proc, 0, sizeof (struct child_process));
+	svndump_proc.out = -1;
+	argv_array_push(&svndump_argv, "svnrdump");
+	argv_array_push(&svndump_argv, "dump");
+	argv_array_push(&svndump_argv, url);
+	argv_array_pushf(&svndump_argv, "-r%u:HEAD", startrev);
+	svndump_proc.argv = svndump_argv.argv;
+
+	code = start_command(&svndump_proc);
+	if (code)
+		die("Unable to start %s, code %d", svndump_proc.argv[0], code);
+	dumpin_fd = svndump_proc.out;
+
+	svndump_init_fd(dumpin_fd, report_fd);
+	svndump_read(url, private_ref);
+	svndump_deinit();
+	svndump_reset();
+
+	close(dumpin_fd);
+	close(report_fd);
+	code = finish_command(&svndump_proc);
+	if (code)
+		warning("%s, returned %d", svndump_proc.argv[0], code);
+	argv_array_clear(&svndump_argv);
+
+	return SUCCESS;
+}
+
+enum cmd_result cmd_list(struct strbuf *line)
+{
+	if (strcmp(line->buf, "list"))
+		return NOT_HANDLED;
+
+	printf("? HEAD\n");
+	printf("? %s\n\n", remote_ref);
+	fflush(stdout);
+	return SUCCESS;
+}
+
+enum cmd_result cmd_terminate(struct strbuf *line)
+{
+	/* an empty line terminates the program, if not in a batch sequence */
+	if (line->len == 0)
+		return TERMINATE;
+	else
+		return NOT_HANDLED;
+}
+enum cmd_result do_command(struct strbuf *line)
+{
+	const input_command_handler *p = input_command_list;
+	enum cmd_result ret;
+	printd("command line '%s'", line->buf);
+	while(*p) {
+		ret = (*p)(line);
+		if (ret != NOT_HANDLED)
+			return ret;
+		p++;
+	}
+	warning("Unknown command '%s'\n", line->buf);
+	return ret;
+}
+
+int main(int argc, const char **argv)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int nongit;
+	static struct remote *remote;
+
+	if (getenv("GIT_TRANSPORT_HELPER_DEBUG"))
+		debug = 1;
+
+	git_extract_argv0_path(argv[0]);
+	setup_git_directory_gently(&nongit);
+	if (argc < 2) {
+		usage("git-remote-svn <remote-name> [<url>]");
+		return 1;
+	}
+
+	remote = remote_get(argv[1]);
+	if (argc == 3)
+		url = argv[2];
+	else if (argc == 2)
+		url = remote->url[0];
+	else
+		warning("Excess arguments!");
+
+	end_url_with_slash(&buf, url);
+	url = strbuf_detach(&buf, NULL);
+
+	printd("remote-svn starting with url %s", url);
+
+	strbuf_init(&buf, 0);
+	strbuf_addf(&buf, "refs/svn/%s/master", remote->name);
+	private_ref = strbuf_detach(&buf, NULL);
+
+	while(1) {
+		if (strbuf_getline(&buf, stdin, '\n') == EOF) {
+			if (ferror(stdin))
+				die_errno("Error reading command stream");
+			else
+				die_errno("Unexpected end of command stream");
+		}
+		if (do_command(&buf) == TERMINATE)
+			break;
+		strbuf_reset(&buf);
+	}
+
+	strbuf_release(&buf);
+	free((void*)url);
+	free((void*)private_ref);
+	return 0;
+}
-- 
1.7.9.5
