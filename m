From: Brad King <brad.king@kitware.com>
Subject: [PATCH v4 7/8] update-ref: support multiple simultaneous updates
Date: Wed,  4 Sep 2013 11:22:44 -0400
Message-ID: <ad27a96b70198e837ac61995a1328960e10072bc.1378307529.git.brad.king@kitware.com>
References: <cover.1378142795.git.brad.king@kitware.com> <cover.1378307529.git.brad.king@kitware.com>
Cc: gitster@pobox.com, mhagger@alum.mit.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 04 17:25:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHEx4-0008E7-O2
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 17:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935112Ab3IDPYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 11:24:45 -0400
Received: from tripoint.kitware.com ([66.194.253.20]:60258 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S935080Ab3IDPYj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 11:24:39 -0400
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id 8C4759FB97; Wed,  4 Sep 2013 11:22:45 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.rc3
In-Reply-To: <cover.1378307529.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233842>

Add a --stdin signature to read update instructions from standard input
and apply multiple ref updates together.  Use an input format that
supports any update that could be specified via the command-line,
including object names like "branch:path with space".

Signed-off-by: Brad King <brad.king@kitware.com>
---
 Documentation/git-update-ref.txt |  22 +++++-
 builtin/update-ref.c             | 144 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 164 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 0df13ff..11dd9d3 100644
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
@@ -58,6 +58,26 @@ archive by creating a symlink tree).
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
+empty string (written as "") to specify a zero value.  Use `-z`
+to specify input with no whitespace, quoting, or escaping, and
+terminate each argument by NUL and each line by LF NUL.
+
+If all <ref>s can be locked with matching <oldvalue>s
+simultaneously, all modifications are performed.  Otherwise, no
+modifications are performed.  Note that while each individual
+<ref> is updated or deleted atomically, a concurrent reader may
+still see a subset of the modifications.
 
 Logging Updates
 ---------------
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 51d2684..9c348fb 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -2,23 +2,152 @@
 #include "refs.h"
 #include "builtin.h"
 #include "parse-options.h"
+#include "quote.h"
+#include "argv-array.h"
 
 static const char * const git_update_ref_usage[] = {
 	N_("git update-ref [options] -d <refname> [<oldval>]"),
 	N_("git update-ref [options]    <refname> <newval> [<oldval>]"),
+	N_("git update-ref [options] --stdin [-z]"),
 	NULL
 };
 
+static int updates_alloc;
+static int updates_count;
+static const struct ref_update **updates;
+
+static void update_refs_stdin(int argc, const char **argv)
+{
+	struct ref_update *update;
+
+	/* Skip blank lines */
+	if (!argc)
+		return;
+
+	/* Allocate and zero-init a struct ref_update */
+	update = xcalloc(1, sizeof(*update));
+	ALLOC_GROW(updates, updates_count+1, updates_alloc);
+	updates[updates_count++] = update;
+
+	/* Process options */
+	while (argc > 0 && argv[0][0] == '-') {
+		const char *arg = argv[0];
+		--argc;
+		++argv;
+		if (!strcmp(arg, "--no-deref"))
+			update->flags |= REF_NODEREF;
+		else if (!strcmp(arg, "--"))
+			break;
+		else
+			die("unknown option %s", arg);
+	}
+
+	/* Set the update ref_name */
+	if (argc < 1)
+		die("input line with no ref!");
+	if (check_refname_format(argv[0], REFNAME_ALLOW_ONELEVEL))
+		die("invalid ref format: %s", argv[0]);
+	update->ref_name = xstrdup(argv[0]);
+
+	/* Set the update new_sha1 and, if specified, old_sha1 */
+	if (argc < 2)
+		die("missing new value for ref %s", update->ref_name);
+	if (*argv[1] && get_sha1(argv[1], update->new_sha1))
+		die("invalid new value for ref %s: %s",
+		    update->ref_name, argv[1]);
+	if (argc >= 3) {
+		update->have_old = 1;
+		if (*argv[2] && get_sha1(argv[2], update->old_sha1))
+			die("invalid old value for ref %s: %s",
+			    update->ref_name, argv[2]);
+	}
+
+	if (argc > 3)
+		die("too many arguments for ref %s", update->ref_name);
+}
+
+static const char *update_refs_stdin_parse_arg(const char *next,
+					       struct strbuf *arg)
+{
+	/* Skip leading whitespace */
+	while (isspace(*next))
+		++next;
+
+	/* Return NULL when no argument is found */
+	if (!*next)
+		return NULL;
+
+	/* Parse the argument */
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
+static void update_refs_stdin_parse_line(const char *next)
+{
+	struct strbuf arg = STRBUF_INIT;
+	static struct argv_array args = ARGV_ARRAY_INIT;
+
+	/* Parse arguments on this line */
+	while ((next = update_refs_stdin_parse_arg(next, &arg)) != NULL)
+		argv_array_push(&args, arg.buf);
+
+	/* Process this command */
+	update_refs_stdin(args.argc, args.argv);
+
+	argv_array_clear(&args);
+	strbuf_release(&arg);
+}
+
+static void update_refs_stdin_read_n()
+{
+	struct strbuf line = STRBUF_INIT;
+
+	while (strbuf_getline(&line, stdin, '\n') != EOF)
+		update_refs_stdin_parse_line(line.buf);
+
+	strbuf_release(&line);
+}
+
+static void update_refs_stdin_read_z()
+{
+	struct strbuf arg = STRBUF_INIT;
+	static struct argv_array args = ARGV_ARRAY_INIT;
+
+	/* Process NUL-terminated arguments with commands ending in LF */
+	while (strbuf_getline(&arg, stdin, '\0') != EOF) {
+		if (!strcmp(arg.buf, "\n")) {
+			update_refs_stdin(args.argc, args.argv);
+			argv_array_clear(&args);
+		} else {
+			argv_array_push(&args, arg.buf);
+		}
+	}
+
+	if (args.argc > 0)
+		die("unterminated -z input sequence");
+
+	strbuf_release(&arg);
+}
+
 int cmd_update_ref(int argc, const char **argv, const char *prefix)
 {
 	const char *refname, *oldval, *msg = NULL;
 	unsigned char sha1[20], oldsha1[20];
-	int delete = 0, no_deref = 0, flags = 0;
+	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0, flags = 0;
 	struct option options[] = {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
 		OPT_BOOLEAN('d', NULL, &delete, N_("delete the reference")),
+		OPT_BOOLEAN('z', NULL, &end_null, N_("stdin has NUL-terminated arguments")),
 		OPT_BOOLEAN( 0 , "no-deref", &no_deref,
 					N_("update <refname> not the one it points to")),
+		OPT_BOOLEAN( 0 , "stdin", &read_stdin, N_("read updates from stdin")),
 		OPT_END(),
 	};
 
@@ -28,6 +157,19 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	if (msg && !*msg)
 		die("Refusing to perform update with empty message.");
 
+	if (read_stdin) {
+		if (delete || no_deref || argc > 0)
+			usage_with_options(git_update_ref_usage, options);
+		if (end_null)
+			update_refs_stdin_read_z();
+		else
+			update_refs_stdin_read_n();
+		return update_refs(msg, updates, updates_count, DIE_ON_ERR);
+	}
+
+	if (end_null)
+		usage_with_options(git_update_ref_usage, options);
+
 	if (delete) {
 		if (argc < 1 || argc > 2)
 			usage_with_options(git_update_ref_usage, options);
-- 
1.8.4.rc3
