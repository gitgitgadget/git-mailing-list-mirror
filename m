From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC 1/4] Implement a basic remote helper vor svn in C.
Date: Mon,  4 Jun 2012 19:20:52 +0200
Message-ID: <1338830455-3091-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 19:21:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbayA-0002lr-9X
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 19:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681Ab2FDRV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 13:21:26 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:42845 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753622Ab2FDRVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 13:21:25 -0400
Received: by bkcji2 with SMTP id ji2so3818518bkc.19
        for <git@vger.kernel.org>; Mon, 04 Jun 2012 10:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=tmByauDdPigrjHa68jMV97n+YEFK3OiH1ThYSfUYy2g=;
        b=qTdnmb+s7pstTwzpmpyVZ6dDvQuIA7cPjNSTh9UCCqiAp9JGBWxRQZ3IPlVkbjkfoL
         haKJ19a6Dg4wNYGm68yO2Y1t0Dg97QfO+HdfQXWVQztqhdKRwCDvgmSQfrm2dRlPyTMK
         jDDXWWZ4RyNz8PB6SF0LNobx0CZ0pxXqxQN8PFautNDnNhaVIpVG5uWj97BuRcASfs3h
         Nh4mU07ayTQvEo98UBUMnYjBNu6VZt75SXnY14ez7AXW/7D28qS0NguzehJTgeV7I562
         WCs1czYyM8HRv7HhSTUgldZxgY3sV4N+frs+o+0s4nF1TACUUJ10MVr0jDQMuZlvQ2aF
         Pchw==
Received: by 10.204.154.214 with SMTP id p22mr7170345bkw.115.1338830483910;
        Mon, 04 Jun 2012 10:21:23 -0700 (PDT)
Received: from flobuntu.lan (m-149.vc-graz.ac.at. [193.170.224.149])
        by mx.google.com with ESMTPS id m2sm11224637bkm.2.2012.06.04.10.21.22
        (version=SSLv3 cipher=OTHER);
        Mon, 04 Jun 2012 10:21:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199155>

Experimental implementation.
Inspired by the existing shell script at divanorama/remote-svn-alpha.
It doesn't use marks or notes yet, always imports the full history.

svnrdump is started as a subprocess while svn-fe's functions
are called directly.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 contrib/svn-fe/remote-svn.c |  188 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 188 insertions(+)
 create mode 100644 contrib/svn-fe/remote-svn.c

diff --git a/contrib/svn-fe/remote-svn.c b/contrib/svn-fe/remote-svn.c
new file mode 100644
index 0000000..ac09cc5
--- /dev/null
+++ b/contrib/svn-fe/remote-svn.c
@@ -0,0 +1,188 @@
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
+	int code;
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
+	svndump_init_fd(svndump_proc.out);
+	svndump_read(url);
+	svndump_deinit();
+	svndump_reset();
+
+	close(svndump_proc.out);
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
