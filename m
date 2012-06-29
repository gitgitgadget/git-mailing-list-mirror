From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC 1/4 v2] Implement a basic remote helper for svn in C.
Date: Fri, 29 Jun 2012 09:54:51 +0200
Message-ID: <23122876.7xH9dZiP4M@flobuntu>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <1374057.qfvOg1c6C6@flobuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 29 10:01:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkW8q-0002qL-WB
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jun 2012 10:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761Ab2F2IBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jun 2012 04:01:17 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50678 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812Ab2F2IBM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2012 04:01:12 -0400
Received: by mail-bk0-f46.google.com with SMTP id ji2so2723356bkc.19
        for <git@vger.kernel.org>; Fri, 29 Jun 2012 01:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=pI7eyKBQhFsx1wkpwbgQj7h+7OpWwF1/3nWJS9kDy5k=;
        b=LTvJLLCbznPEOwEPEmC9m9VpTKj9eAlkYsqBf566XpfZpG/2mGyc+F5xQ061T2hZYN
         wHzkq05JJdIfPkREx4jDIoD8hJ//Jj2PUTn1dQj3mBBRzVK2i+jB0dbWEZO6Jf4mgTTI
         f5iKu3BQpS1xt2eHtZQXVUJPbIpJoxzzZVSKNhBkrmX1lH25VoA7gghrIQDvVmJW6j1M
         2b7hOJH/30/xF91s8TivSqzhqkWJ8MPbkxxNHfqGSCBbEcwQrltX7MAeGKnNKYZAaQrh
         uLC6qOe6SDat5hlkY/ehJ2pRhiUo/hihY8TBXeXCEl8Y/TAQSN+zUZQAzo+2//mO9Hen
         4Ocw==
Received: by 10.204.152.152 with SMTP id g24mr194282bkw.104.1340956871357;
        Fri, 29 Jun 2012 01:01:11 -0700 (PDT)
Received: from flobuntu.localnet (m-149.vc-graz.ac.at. [193.170.224.149])
        by mx.google.com with ESMTPS id hg13sm1841138bkc.7.2012.06.29.01.01.09
        (version=SSLv3 cipher=OTHER);
        Fri, 29 Jun 2012 01:01:10 -0700 (PDT)
User-Agent: KMail/4.8.3 (Linux/3.2.0-26-generic; KDE/4.8.3; x86_64; ; )
In-Reply-To: <1374057.qfvOg1c6C6@flobuntu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200808>

Experimental implementation.
Inspired by the existing shell script at divanorama/remote-svn-alpha.
It doesn't use marks or notes yet, always imports the full history.

svnrdump is started as a subprocess while svn-fe's functions
are called directly.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
diff: Use fifo instead of pipe: Retrieve the name of the pipe from env and open it
for svndump.

 contrib/svn-fe/remote-svn.c |  207 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 207 insertions(+)
 create mode 100644 contrib/svn-fe/remote-svn.c

diff --git a/contrib/svn-fe/remote-svn.c b/contrib/svn-fe/remote-svn.c
new file mode 100644
index 0000000..5ec7fbb
--- /dev/null
+++ b/contrib/svn-fe/remote-svn.c
@@ -0,0 +1,207 @@
+
+#include <stdlib.h>
+#include <string.h>
+#include <stdio.h>
+#include "cache.h"
+#include "remote.h"
+#include "strbuf.h"
+#include "url.h"
+#include "exec_cmd.h"
+#include "run-command.h"
+#include "svndump.h"
+
+static int debug = 0;
+
+static inline void printd(const char* fmt, ...)
+{
+	if(debug) {
+		va_list vargs;
+		va_start(vargs, fmt);
+		fprintf(stderr, "rhsvn debug: ");
+		vfprintf(stderr, fmt, vargs);
+		fprintf(stderr, "\n");
+		va_end(vargs);
+	}
+}
+
+static struct remote* remote;
+static const char* url;
+const char* private_refs = "refs/remote-svn/";		/* + remote->name. */
+const char* remote_ref = "refs/heads/master";
+
+enum cmd_result cmd_capabilities(struct strbuf* line);
+enum cmd_result cmd_import(struct strbuf* line);
+enum cmd_result cmd_list(struct strbuf* line);
+
+enum cmd_result { SUCCESS, NOT_HANDLED, ERROR };
+typedef enum cmd_result (*command)(struct strbuf*);
+
+const command command_list[] = {
+		cmd_capabilities, cmd_import, cmd_list, NULL
+};
+
+enum cmd_result cmd_capabilities(struct strbuf* line)
+{
+	if(strcmp(line->buf, "capabilities"))
+		return NOT_HANDLED;
+
+	printf("import\n");
+	printf("\n");
+	fflush(stdout);
+	return SUCCESS;
+}
+
+enum cmd_result cmd_import(struct strbuf* line)
+{
+	const char* revs = "-r0:HEAD";
+	int code, report_fd;
+	char* back_pipe_env;
+	struct child_process svndump_proc = {
+			.argv = NULL,		/* comes later .. */
+			/* we want a pipe to the child's stdout, but stdin, stderr inherited.
+			 The user can be asked for e.g. a password */
+			.in = 0, .out = -1, .err = 0,
+			.no_stdin = 0, .no_stdout = 0, .no_stderr = 0,
+			.git_cmd = 0,
+			.silent_exec_failure = 0,
+			.stdout_to_stderr = 0,
+			.use_shell = 0,
+			.clean_on_exit = 0,
+			.preexec_cb = NULL,
+			.env = NULL,
+			.dir = NULL
+	};
+
+	if(prefixcmp(line->buf, "import"))
+		return NOT_HANDLED;
+
+	back_pipe_env = getenv("GIT_REPORT_FIFO");
+	if(!back_pipe_env) {
+		die("Cannot get cat-blob-pipe from environment!");
+	}
+
+	/* opening a fifo for usually reading blocks until a writer has opened it too.
+	 * Therefore, we open with RDWR.
+	 */
+	report_fd = open(back_pipe_env, O_RDWR);
+	if(report_fd < 0) {
+		die("Unable to open fast-import back-pipe! %s", strerror(errno));
+	}
+
+	printd("Opened fast-import back-pipe %s for reading.", back_pipe_env);
+
+	svndump_proc.argv = xcalloc(5, sizeof(char*));
+	svndump_proc.argv[0] = "svnrdump";
+	svndump_proc.argv[1] = "dump";
+	svndump_proc.argv[2] = url;
+	svndump_proc.argv[3] = revs;
+
+	code = start_command(&svndump_proc);
+	if(code)
+		die("Unable to start %s, code %d", svndump_proc.argv[0], code);
+
+
+
+	svndump_init_fd(svndump_proc.out, report_fd);
+	svndump_read(url);
+	svndump_deinit();
+	svndump_reset();
+
+	close(svndump_proc.out);
+	close(report_fd);
+
+	code = finish_command(&svndump_proc);
+	if(code)
+		warning("Something went wrong with termination of %s, code %d", svndump_proc.argv[0], code);
+	free(svndump_proc.argv);
+
+	printf("done\n");
+	return SUCCESS;
+
+
+
+}
+
+enum cmd_result cmd_list(struct strbuf* line)
+{
+	if(strcmp(line->buf, "list"))
+		return NOT_HANDLED;
+
+	printf("? HEAD\n");
+	printf("? %s\n", remote_ref);
+	printf("\n");
+	fflush(stdout);
+	return SUCCESS;
+}
+
+enum cmd_result do_command(struct strbuf* line)
+{
+	const command* p = command_list;
+	enum cmd_result ret;
+	printd("command line '%s'", line->buf);
+	while(*p) {
+		ret = (*p)(line);
+		if(ret != NOT_HANDLED)
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
+
+	if (getenv("GIT_TRANSPORT_HELPER_DEBUG"))
+		debug = 1;
+
+	git_extract_argv0_path(argv[0]);
+	setup_git_directory_gently(&nongit);
+	if (argc < 2) {
+		fprintf(stderr, "Remote needed\n");
+		return 1;
+	}
+
+	remote = remote_get(argv[1]);
+	if (argc == 3) {
+		end_url_with_slash(&buf, argv[2]);
+	} else if (argc == 2) {
+		end_url_with_slash(&buf, remote->url[0]);
+	} else {
+		warning("Excess arguments!");
+	}
+
+	url = strbuf_detach(&buf, NULL);
+
+	printd("remote-svn starting with url %s", url);
+
+	/* build private ref namespace path for this svn remote. */
+	strbuf_init(&buf, 0);
+	strbuf_addstr(&buf, private_refs);
+	strbuf_addstr(&buf, remote->name);
+	strbuf_addch(&buf, '/');
+	private_refs = strbuf_detach(&buf, NULL);
+
+	while(1) {
+		if (strbuf_getline(&buf, stdin, '\n') == EOF) {
+			if (ferror(stdin))
+				fprintf(stderr, "Error reading command stream\n");
+			else
+				fprintf(stderr, "Unexpected end of command stream\n");
+			return 1;
+		}
+		/* an empty line terminates the command stream */
+		if(buf.len == 0)
+			break;
+
+		do_command(&buf);
+		strbuf_reset(&buf);
+	}
+
+	strbuf_release(&buf);
+	free((void*)url);
+	free((void*)private_refs);
+	return 0;
+}
-- 
1.7.9.5
