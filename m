From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v6 01/16] Implement a remote helper for svn in C
Date: Wed, 22 Aug 2012 21:15:46 +0200
Message-ID: <1345662961-9587-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345662961-9587-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 21:16:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4GQ6-0001Ql-EM
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 21:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021Ab2HVTQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 15:16:35 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53740 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964917Ab2HVTQc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 15:16:32 -0400
Received: by bkwj10 with SMTP id j10so449687bkw.19
        for <git@vger.kernel.org>; Wed, 22 Aug 2012 12:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SP+D7rdpqiMMjQXLXSSf1NS5uqZb6YUbbqxnbI0r230=;
        b=NCW+EeEqqIi1gs3I/YOjtoVEb9a9x8bJqmWJhR7uzc24KuCiLBPeAoBw4bowW5rcOs
         UkbSoy16M9012a697sCrrD/4yk/nPDQ5SDTKuhi0AehLTrmn4deW3+Yn+WKlsYYfLj6y
         slB37k0y+MyA/1TTmCPhE29XWrEFhAlkVrfxsKOJ6TnGllTMzO4JnXSTImvUfN5ZUHX2
         vGRT2/jCE/HmAFJJZEwF4CiNaJGZCIXfCFczz7AMp8v7wu04jq2ZAX600a1h2JGvojrS
         mP6GJEa+2VyUZVlu2b1+zAma26ttIrNABOdIXtUhee9zHQom/yHBjA89CsdfQbb7rX6r
         EwUw==
Received: by 10.204.148.66 with SMTP id o2mr6860907bkv.43.1345662990765;
        Wed, 22 Aug 2012 12:16:30 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id ht18sm3346763bkc.16.2012.08.22.12.16.28
        (version=SSLv3 cipher=OTHER);
        Wed, 22 Aug 2012 12:16:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345662961-9587-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204069>

Enable basic fetching from subversion repositories. When processing
remote URLs starting with testsvn::, git invokes this remote-helper.
It starts svnrdump to extract revisions from the subversion repository
in the 'dump file format', and converts them to a git-fast-import stream
using the functions of vcs-svn/.

Imported refs are created in a private namespace at
refs/svn/<remote-name>/master.  The revision history is imported
linearly (no branch detection) and completely, i.e. from revision 0 to
HEAD.

The 'bidi-import' capability is used. The remote-helper expects data
from fast-import on its stdin. It buffers a batch of 'import' command
lines in a string_list before starting to process them.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote-testsvn.c |  174 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 174 insertions(+)
 create mode 100644 remote-testsvn.c

diff --git a/remote-testsvn.c b/remote-testsvn.c
new file mode 100644
index 0000000..ebe803b
--- /dev/null
+++ b/remote-testsvn.c
@@ -0,0 +1,174 @@
+#include "cache.h"
+#include "remote.h"
+#include "strbuf.h"
+#include "url.h"
+#include "exec_cmd.h"
+#include "run-command.h"
+#include "vcs-svn/svndump.h"
+#include "notes.h"
+#include "argv-array.h"
+
+static const char *url;
+static const char *private_ref;
+static const char *remote_ref = "refs/heads/master";
+
+static int cmd_capabilities(const char *line);
+static int cmd_import(const char *line);
+static int cmd_list(const char *line);
+
+typedef int (*input_command_handler)(const char *);
+struct input_command_entry {
+	const char *name;
+	input_command_handler fn;
+	unsigned char batchable;	/* whether the command starts or is part of a batch */
+};
+
+static const struct input_command_entry input_command_list[] = {
+	{ "capabilities", cmd_capabilities, 0 },
+	{ "import", cmd_import, 1 },
+	{ "list", cmd_list, 0 },
+	{ NULL, NULL }
+};
+
+static int cmd_capabilities(const char *line) {
+	printf("import\n");
+	printf("bidi-import\n");
+	printf("refspec %s:%s\n\n", remote_ref, private_ref);
+	fflush(stdout);
+	return 0;
+}
+
+static void terminate_batch(void)
+{
+	/* terminate a current batch's fast-import stream */
+	printf("done\n");
+	fflush(stdout);
+}
+
+static int cmd_import(const char *line)
+{
+	int code;
+	int dumpin_fd;
+	unsigned int startrev = 0;
+	struct argv_array svndump_argv = ARGV_ARRAY_INIT;
+	struct child_process svndump_proc;
+
+	memset(&svndump_proc, 0, sizeof(struct child_process));
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
+	svndump_init_fd(dumpin_fd, STDIN_FILENO);
+	svndump_read(url, private_ref);
+	svndump_deinit();
+	svndump_reset();
+
+	close(dumpin_fd);
+	code = finish_command(&svndump_proc);
+	if (code)
+		warning("%s, returned %d", svndump_proc.argv[0], code);
+	argv_array_clear(&svndump_argv);
+
+	return 0;
+}
+
+static int cmd_list(const char *line)
+{
+	printf("? %s\n\n", remote_ref);
+	fflush(stdout);
+	return 0;
+}
+
+static int do_command(struct strbuf *line)
+{
+	const struct input_command_entry *p = input_command_list;
+	static struct string_list batchlines = STRING_LIST_INIT_DUP;
+	static const struct input_command_entry *batch_cmd;
+	/*
+	 * commands can be grouped together in a batch.
+	 * Batches are ended by \n. If no batch is active the program ends.
+	 * During a batch all lines are buffered and passed to the handler function
+	 * when the batch is terminated.
+	 */
+	if (line->len == 0) {
+		if (batch_cmd) {
+			struct string_list_item *item;
+			for_each_string_list_item(item, &batchlines)
+				batch_cmd->fn(item->string);
+			terminate_batch();
+			batch_cmd = NULL;
+			string_list_clear(&batchlines, 0);
+			return 0;	/* end of the batch, continue reading other commands. */
+		}
+		return 1;	/* end of command stream, quit */
+	}
+	if (batch_cmd) {
+		if (prefixcmp(batch_cmd->name, line->buf))
+			die("Active %s batch interrupted by %s", batch_cmd->name, line->buf);
+		/* buffer batch lines */
+		string_list_append(&batchlines, line->buf);
+		return 0;
+	}
+
+	for (p = input_command_list; p->name; p++) {
+		if (!prefixcmp(line->buf, p->name) && (strlen(p->name) == line->len ||
+				line->buf[strlen(p->name)] == ' ')) {
+			if (p->batchable) {
+				batch_cmd = p;
+				string_list_append(&batchlines, line->buf);
+				return 0;
+			}
+			return p->fn(line->buf);
+		}
+	}
+	die("Unknown command '%s'\n", line->buf);
+	return 0;
+}
+
+int main(int argc, const char **argv)
+{
+	struct strbuf buf = STRBUF_INIT;
+	static struct remote *remote;
+	const char *url_in;
+
+	git_extract_argv0_path(argv[0]);
+	setup_git_directory();
+	if (argc < 2 || argc > 3) {
+		usage("git-remote-svn <remote-name> [<url>]");
+		return 1;
+	}
+
+	remote = remote_get(argv[1]);
+	url_in = (argc == 3) ? argv[2] : remote->url[0];
+
+	end_url_with_slash(&buf, url_in);
+	url = strbuf_detach(&buf, NULL);
+
+	strbuf_addf(&buf, "refs/svn/%s/master", remote->name);
+	private_ref = strbuf_detach(&buf, NULL);
+
+	while(1) {
+		if (strbuf_getline(&buf, stdin, '\n') == EOF) {
+			if (ferror(stdin))
+				die("Error reading command stream");
+			else
+				die("Unexpected end of command stream");
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
