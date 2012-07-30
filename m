From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC v2 01/16] Implement a remote helper for svn in C.
Date: Mon, 30 Jul 2012 16:31:08 +0200
Message-ID: <1343658683-10713-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1343287957-22040-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 16:39:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svr83-0007vB-CA
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 16:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754722Ab2G3OjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 10:39:14 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39226 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754679Ab2G3OjM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 10:39:12 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so2859087bkw.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 07:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Te1ZXMGmWA2qsZz6RjhiyniG7JlXfyLBMDCwS4i5oZA=;
        b=WBQTAjRbtAJ6jERRhJw/G7RrRxYGDZb/8luf0nzxUhcJXnmIjAHa+FEJaNNIa09UQO
         cTYrBGaR3S5EWBWIQXH4189tGX3yVWQPFQ7A/9KNe51uUGUE5WvZN8/xsev4oUuFoe+t
         r6iNtXAcaL8hJTZs1E/S/EybkMj6eXTBUwE1+WsqAYKBGzdl+YR7RkvBZl6KO/usKKBt
         0oNCRshCSbBXMSeMZX0UWdRKB+0yXYHGG+CG6U2eO73aJva6p7vSR8x/L0DVbKSaWZpE
         oNwwQepAeNkyAMZ1QPseYaYqVfx4l8Hz+tHennrVwAesCo3Fx77aQGSNKTByozAVNFRx
         H/kQ==
Received: by 10.204.152.136 with SMTP id g8mr3936200bkw.44.1343659151725;
        Mon, 30 Jul 2012 07:39:11 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id fu8sm3945866bkc.5.2012.07.30.07.39.10
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jul 2012 07:39:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1343658683-10713-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202548>

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
 contrib/svn-fe/remote-svn.c |  190 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 190 insertions(+)
 create mode 100644 contrib/svn-fe/remote-svn.c

diff --git a/contrib/svn-fe/remote-svn.c b/contrib/svn-fe/remote-svn.c
new file mode 100644
index 0000000..d5c2df8
--- /dev/null
+++ b/contrib/svn-fe/remote-svn.c
@@ -0,0 +1,190 @@
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
+static const char *url;
+static const char *private_ref;
+static const char *remote_ref = "refs/heads/master";
+
+int cmd_capabilities(struct strbuf *line);
+int cmd_import(struct strbuf *line);
+int cmd_list(struct strbuf *line);
+
+typedef int (*input_command_handler)(struct strbuf *);
+struct input_command_entry {
+	const char *name;
+	input_command_handler fct;
+	unsigned char batchable;	/* whether the command starts or is part of a batch */
+};
+
+static const struct input_command_entry input_command_list[] = {
+		{ "capabilities", cmd_capabilities, 0 },
+		{ "import", cmd_import, 1 },
+		{ "list", cmd_list, 0 },
+		{ NULL, NULL }
+};
+
+int cmd_capabilities(struct strbuf *line)
+{
+	printf("import\n");
+	printf("refspec %s:%s\n\n", remote_ref, private_ref);
+	fflush(stdout);
+	return 0;
+}
+
+static void terminate_batch() {
+	/* terminate a current batch's fast-import stream */
+		printf("done\n");
+		fflush(stdout);
+}
+
+int cmd_import(struct strbuf *line)
+{
+	int code, report_fd;
+	char *back_pipe_env;
+	int dumpin_fd;
+	unsigned int startrev = 0;
+	struct argv_array svndump_argv = ARGV_ARRAY_INIT;
+	struct child_process svndump_proc;
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
+	return 0;
+}
+
+int cmd_list(struct strbuf *line)
+{
+	printf("? HEAD\n");
+	printf("? %s\n\n", remote_ref);
+	fflush(stdout);
+	return 0;
+}
+
+int do_command(struct strbuf *line)
+{
+	const struct input_command_entry *p = input_command_list;
+	static int batch_active;
+	static struct strbuf batch_command = STRBUF_INIT;
+	/*
+	 * import commands can be grouped together in a batch.
+	 * Batches are ended by \n. If no batch is active the program ends.
+	 */
+	if (line->len == 0 ) {
+		if (batch_active) {
+			terminate_batch();
+			batch_active = 0;
+			return 0;
+		}
+		return 1;
+	}
+	if (batch_active && strcmp(batch_command.buf, line->buf))
+		die("Active %s batch interrupted by %s", batch_command.buf, line->buf);
+
+	for(p = input_command_list; p->name; p++) {
+		if (!prefixcmp(line->buf, p->name) &&
+				(strlen(p->name) == line->len || line->buf[strlen(p->name)] == ' ')) {
+			if (p->batchable) {
+				batch_active = 1;
+				strbuf_release(&batch_command);
+				strbuf_addbuf(&batch_command, line);
+			}
+			return p->fct(line);
+		}
+	}
+	warning("Unknown command '%s'\n", line->buf);
+	return 0;
+}
+
+int main(int argc, const char **argv)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int nongit;
+	static struct remote *remote;
+	const char *url_in;
+
+	git_extract_argv0_path(argv[0]);
+	setup_git_directory_gently(&nongit);
+	if (argc < 2 || argc > 3) {
+		usage("git-remote-svn <remote-name> [<url>]");
+		return 1;
+	}
+
+	remote = remote_get(argv[1]);
+	url_in = remote->url[0];
+	if (argc == 3)
+		url_in = argv[2];
+
+	end_url_with_slash(&buf, url_in);
+	url = strbuf_detach(&buf, NULL);
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
+		if (do_command(&buf))
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
