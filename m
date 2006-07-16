From: fork0@t-online.de (Alex Riesen)
Subject: [PATCH 1/2] add git-quote: shell and C quoting tool
Date: Mon, 17 Jul 2006 00:27:57 +0200
Message-ID: <20060716222757.GA10135@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jul 17 00:29:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from [209.132.176.167] (helo=vger.kernel.org)
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2F6n-0004Ls-Bi
	for gcvg-git@gmane.org; Mon, 17 Jul 2006 00:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWGPW2G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Jul 2006 18:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWGPW2G
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Jul 2006 18:28:06 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:10210 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751316AbWGPW2F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jul 2006 18:28:05 -0400
Received: from fwd28.aul.t-online.de 
	by mailout06.sul.t-online.com with smtp 
	id 1G2F5k-000414-00; Mon, 17 Jul 2006 00:28:00 +0200
Received: from tigra.home (TWfe72ZfgewNtJxwhN2JSl3DWR9GtevGv0LCLuhiP8EuVqWSLM+Ec7@[84.160.88.78]) by fwd28.sul.t-online.de
	with esmtp id 1G2F5j-0qMROq0; Mon, 17 Jul 2006 00:27:59 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id E385C277AF;
	Mon, 17 Jul 2006 00:27:58 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1G2F5h-0002eN-UI; Mon, 17 Jul 2006 00:27:58 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-ID: TWfe72ZfgewNtJxwhN2JSl3DWR9GtevGv0LCLuhiP8EuVqWSLM+Ec7
X-TOI-MSGID: 9811c751-00a9-485b-9e8b-b211c0b22dea
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23956>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

As git-stripspace, it may ne useful for something. As an example, the
next patch converts git-bisect.sh to use of this tool.

In case anyone asks why isn't it a standalone tool nor is it put into
git-stripspace: I don't know. Maybe it should be.

 Makefile        |    3 +-
 builtin-quote.c |  102 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h       |    2 +
 git.c           |    1 +
 4 files changed, 107 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 01fb9cf..9fcbf3b 100644
--- a/Makefile
+++ b/Makefile
@@ -234,7 +234,8 @@ BUILTIN_OBJS = \
 	builtin-apply.o builtin-show-branch.o builtin-diff-files.o \
 	builtin-diff-index.o builtin-diff-stages.o builtin-diff-tree.o \
 	builtin-cat-file.o builtin-mailsplit.o builtin-stripspace.o \
-	builtin-update-ref.o builtin-fmt-merge-msg.o builtin-prune.o
+	builtin-update-ref.o builtin-fmt-merge-msg.o builtin-prune.o \
+	builtin-quote.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
diff --git a/builtin-quote.c b/builtin-quote.c
new file mode 100644
index 0000000..cbd822d
--- /dev/null
+++ b/builtin-quote.c
@@ -0,0 +1,102 @@
+/*
+ * "git quote" builtin command
+ *
+ * DOES NOT QUOTE \0 (truncates lines at it)
+ */
+#include "cache.h"
+#include "builtin.h"
+#include "quote.h"
+
+enum {SHELL_QUOTE, C_QUOTE};
+static int style = SHELL_QUOTE,
+	   use_stdin = 0;
+static const char *separator = NULL; /* default is space */
+static unsigned sep_len = 0;
+
+static const char builtin_quote_usage[] =
+"git-quote [--c] [--sep=<c-quoted> | -z] ( [--stdin] | [--] ... )";
+
+static void print_quoted(const char *text)
+{
+	switch (style)
+	{
+	case SHELL_QUOTE:
+		sq_quote_print(stdout, text);
+		break;
+	case C_QUOTE:
+		quote_c_style(text, NULL, stdout, 0);
+		break;
+	}
+	fwrite(separator, 1, sep_len, stdout);
+}
+
+int cmd_quote(int argc, const char **argv, char **envp)
+{
+	int i;
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+
+		if (arg[0] != '-')
+			break;
+		if (!strcmp(arg, "--")) {
+			i++;
+			break;
+		}
+		if (!strcmp(arg, "--stdin")) {
+			use_stdin = 1;
+			if ( !separator ) {
+				separator = "\n";
+				sep_len = 1;
+			}
+			break;
+		}
+		if (!strcmp(arg, "--c")) {
+			style = C_QUOTE;
+			continue;
+		}
+		if (!strcmp(arg, "-z")) {
+			separator = "";
+			sep_len = 1;
+			continue;
+		}
+		if (!strncmp(arg, "--sep=", 6)) {
+			const char *end;
+			char *tmp;
+			arg += 6;
+			if ('"' == *arg)
+				tmp = strdup(arg);
+			else {
+				size_t l = strlen(arg);
+				tmp = malloc(l + 3);
+				sprintf(tmp, "\"%s\"", arg);
+			}
+			separator = unquote_c_style(tmp, &end);
+			sep_len = strlen(separator);
+			/* this will leak if multiple --sep= given */
+			continue;
+		}
+		die(builtin_quote_usage);
+	}
+	if (!separator) {
+		sep_len = 1;
+		separator = "\x20";
+	}
+	if (use_stdin) {
+		size_t size = BUFSIZ;
+		char *buf = xmalloc(size);
+		int ch, pos = 0;
+		while (EOF != (ch = fgetc(stdin))) {
+			if (pos == size)
+				buf = xrealloc(buf, size <<= 1);
+			buf[pos++] = ch;
+			if ('\n' == ch) {
+				buf[--pos] = '\0';
+				pos = 0;
+				print_quoted(buf);
+			}
+		}
+	} else
+		for (; argv[i]; ++i)
+			print_quoted(argv[i]);
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index 5339d86..9bd522e 100644
--- a/builtin.h
+++ b/builtin.h
@@ -64,4 +64,6 @@ extern int mailinfo(FILE *in, FILE *out,
 
 extern int cmd_stripspace(int argc, const char **argv, char **envp);
 extern void stripspace(FILE *in, FILE *out);
+
+extern int cmd_quote(int argc, const char **argv, char **envp);
 #endif
diff --git a/git.c b/git.c
index ee5a0e8..f94d25a 100644
--- a/git.c
+++ b/git.c
@@ -202,6 +202,7 @@ static void handle_internal_command(int 
 		{ "update-ref", cmd_update_ref },
 		{ "fmt-merge-msg", cmd_fmt_merge_msg },
 		{ "prune", cmd_prune },
+		{ "quote", cmd_quote },
 	};
 	int i;
 
-- 
1.4.1.gb944
