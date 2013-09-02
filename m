From: Brad King <brad.king@kitware.com>
Subject: [PATCH v3 7/8] update-ref: support multiple simultaneous updates
Date: Mon,  2 Sep 2013 13:48:55 -0400
Message-ID: <93efe58835dc2e569fe1e398a4cba5ec4d4b3771.1378142796.git.brad.king@kitware.com>
References: <cover.1377885441.git.brad.king@kitware.com> <cover.1378142795.git.brad.king@kitware.com>
Cc: gitster@pobox.com, mhagger@alum.mit.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 02 19:51:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGYHO-0006Dn-1h
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 19:51:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758874Ab3IBRuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 13:50:51 -0400
Received: from tripoint.kitware.com ([66.194.253.20]:55787 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758853Ab3IBRuo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 13:50:44 -0400
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id B07139FB90; Mon,  2 Sep 2013 13:48:56 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1378142795.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233651>

Add a --stdin signature to read update instructions from standard input
and apply multiple ref updates together.  Use an input format that
supports any update that could be specified via the command-line,
including object names like "branch:path with space".

Signed-off-by: Brad King <brad.king@kitware.com>
---
 Documentation/git-update-ref.txt |   20 +++++++-
 builtin/update-ref.c             |  103 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 121 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 0df13ff..01019f1 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -8,7 +8,7 @@ git-update-ref - Update the object name stored in a ref safely
 SYNOPSIS
 --------
 [verse]
-'git update-ref' [-m <reason>] (-d <ref> [<oldvalue>] | [--no-deref] <ref> <newvalue> [<oldvalue>])
+'git update-ref' [-m <reason>] (-d <ref> [<oldvalue>] | [--no-deref] <ref> <newvalue> [<oldvalue>] | --stdin)
 
 DESCRIPTION
 -----------
@@ -58,6 +58,24 @@ archive by creating a symlink tree).
 With `-d` flag, it deletes the named <ref> after verifying it
 still contains <oldvalue>.
 
+With `--stdin`, update-ref reads instructions from standard input and
+performs all modifications together.  Empty lines are ignored.
+Each non-empty line is parsed as whitespace-separated arguments.
+Quote arguments containing whitespace as if in C source code.
+Specify updates with lines of the form:
+
+	[--no-deref] [--] <ref> <newvalue> [<oldvalue>]
+
+Lines of any other format or a repeated <ref> produce an error.
+Specify a zero <newvalue> to delete a ref and/or a zero <oldvalue>
+to make sure that a ref not exist.  Use either 40 "0" or the
+empty string (written as "") to specify a zero value.
+
+If all <ref>s can be locked with matching <oldvalue>s
+simultaneously, all modifications are performed.  Otherwise, no
+modifications are performed.  Note that while each individual
+<ref> is updated or deleted atomically, a concurrent reader may
+still see a subset of the modifications.
 
 Logging Updates
 ---------------
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 51d2684..12a3c76 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -2,23 +2,115 @@
 #include "refs.h"
 #include "builtin.h"
 #include "parse-options.h"
+#include "quote.h"
 
 static const char * const git_update_ref_usage[] = {
 	N_("git update-ref [options] -d <refname> [<oldval>]"),
 	N_("git update-ref [options]    <refname> <newval> [<oldval>]"),
+	N_("git update-ref [options] --stdin"),
 	NULL
 };
 
+static int updates_alloc;
+static int updates_count;
+static const struct ref_update **updates;
+
+static const char* update_refs_stdin_next_arg(const char* next,
+					      struct strbuf *arg)
+{
+	/* Skip leading whitespace: */
+	while (isspace(*next))
+		++next;
+
+	/* Return NULL when no argument is found: */
+	if (!*next)
+		return NULL;
+
+	/* Parse the argument: */
+	strbuf_reset(arg);
+	if (*next == '"') {
+		if (unquote_c_style(arg, next, &next))
+			die("badly quoted argument: %s", next);
+		return next;
+	}
+	while (*next && !isspace(*next))
+		strbuf_addch(arg, *next++);
+	return next;
+}
+
+static void update_refs_stdin(const char *line)
+{
+	int options = 1, flags = 0, argc = 0;
+	char *argv[3] = {0, 0, 0};
+	struct strbuf arg = STRBUF_INIT;
+	struct ref_update *update;
+	const char *next = line;
+
+	/* Skip blank lines: */
+	if (!line[0])
+		return;
+
+	/* Parse arguments on this line: */
+	while ((next = update_refs_stdin_next_arg(next, &arg)) != NULL) {
+		if (options && arg.buf[0] == '-')
+			if (!strcmp(arg.buf, "--no-deref"))
+				flags |= REF_NODEREF;
+			else if (!strcmp(arg.buf, "--"))
+				options = 0;
+			else
+				die("unknown option %s", arg.buf);
+		else if (argc >= 3)
+			die("too many arguments on line: %s", line);
+		else {
+			argv[argc++] = xstrdup(arg.buf);
+			options = 0;
+		}
+	}
+	strbuf_release(&arg);
+
+	/* Allocate and zero-init a struct ref_update: */
+	update = xcalloc(1, sizeof(*update));
+	ALLOC_GROW(updates, updates_count+1, updates_alloc);
+	updates[updates_count++] = update;
+
+	/* Set the update ref_name: */
+	if (!argv[0])
+		die("no ref on line: %s", line);
+	if (check_refname_format(argv[0], REFNAME_ALLOW_ONELEVEL))
+		die("invalid ref format on line: %s", line);
+	update->ref_name = argv[0];
+	argv[0] = 0;
+
+	/* Set the update new_sha1 and, if specified, old_sha1: */
+	if (!argv[1])
+		die("missing new value on line: %s", line);
+	if (*argv[1] && get_sha1(argv[1], update->new_sha1))
+		die("invalid new value on line: %s", line);
+	if (argv[2]) {
+		update->have_old = 1;
+		if (*argv[2] && get_sha1(argv[2], update->old_sha1))
+			die("invalid old value on line: %s", line);
+	}
+
+	/* Set the update flags: */
+	update->flags = flags;
+
+	while (argc > 0)
+		free(argv[--argc]);
+}
+
 int cmd_update_ref(int argc, const char **argv, const char *prefix)
 {
 	const char *refname, *oldval, *msg = NULL;
 	unsigned char sha1[20], oldsha1[20];
-	int delete = 0, no_deref = 0, flags = 0;
+	int delete = 0, no_deref = 0, read_stdin = 0, flags = 0;
+	struct strbuf line = STRBUF_INIT;
 	struct option options[] = {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
 		OPT_BOOLEAN('d', NULL, &delete, N_("delete the reference")),
 		OPT_BOOLEAN( 0 , "no-deref", &no_deref,
 					N_("update <refname> not the one it points to")),
+		OPT_BOOLEAN( 0 , "stdin", &read_stdin, N_("read updates from stdin")),
 		OPT_END(),
 	};
 
@@ -28,6 +120,15 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	if (msg && !*msg)
 		die("Refusing to perform update with empty message.");
 
+	if (read_stdin) {
+		if (delete || no_deref || argc > 0)
+			usage_with_options(git_update_ref_usage, options);
+		while (strbuf_getline(&line, stdin, '\n') != EOF)
+			update_refs_stdin(line.buf);
+		strbuf_release(&line);
+		return update_refs(msg, updates, updates_count, DIE_ON_ERR);
+	}
+
 	if (delete) {
 		if (argc < 1 || argc > 2)
 			usage_with_options(git_update_ref_usage, options);
-- 
1.7.10.4
