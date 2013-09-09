From: Brad King <brad.king@kitware.com>
Subject: [PATCH v5 7/8] update-ref: support multiple simultaneous updates
Date: Mon,  9 Sep 2013 09:22:32 -0400
Message-ID: <8cda356bce181bd94dcb9e1625929693874161f6.1378732710.git.brad.king@kitware.com>
References: <cover.1378307529.git.brad.king@kitware.com> <cover.1378732710.git.brad.king@kitware.com>
Cc: gitster@pobox.com, mhagger@alum.mit.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 09 15:24:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ1SO-0003iv-6n
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 15:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921Ab3IINYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 09:24:41 -0400
Received: from tripoint.kitware.com ([66.194.253.20]:40307 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752503Ab3IINYi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 09:24:38 -0400
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id 826219FB8D; Mon,  9 Sep 2013 09:22:33 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.rc3
In-Reply-To: <cover.1378732710.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234325>

Add a --stdin signature to read update instructions from standard input
and apply multiple ref updates together.  Use an input format that
supports any update that could be specified via the command-line,
including object names like "branch:path with space".

Signed-off-by: Brad King <brad.king@kitware.com>
---
 Documentation/git-update-ref.txt |  54 ++++++++-
 builtin/update-ref.c             | 252 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 304 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 0df13ff..0a0a551 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -8,7 +8,7 @@ git-update-ref - Update the object name stored in a ref safely
 SYNOPSIS
 --------
 [verse]
-'git update-ref' [-m <reason>] (-d <ref> [<oldvalue>] | [--no-deref] <ref> <newvalue> [<oldvalue>])
+'git update-ref' [-m <reason>] (-d <ref> [<oldvalue>] | [--no-deref] <ref> <newvalue> [<oldvalue>] | --stdin [-z])
 
 DESCRIPTION
 -----------
@@ -58,6 +58,58 @@ archive by creating a symlink tree).
 With `-d` flag, it deletes the named <ref> after verifying it
 still contains <oldvalue>.
 
+With `--stdin`, update-ref reads instructions from standard input and
+performs all modifications together.  Specify commands of the form:
+
+	update SP <ref> SP <newvalue> [SP <oldvalue>] LF
+	create SP <ref> SP <newvalue> LF
+	delete SP <ref> [SP <oldvalue>] LF
+	verify SP <ref> [SP <oldvalue>] LF
+	option SP <opt> LF
+
+Quote fields containing whitespace as if they were strings in C source
+code.  Alternatively, use `-z` to specify commands without quoting:
+
+	update SP <ref> NUL <newvalue> NUL [<oldvalue>] NUL
+	create SP <ref> NUL <newvalue> NUL
+	delete SP <ref> NUL [<oldvalue>] NUL
+	verify SP <ref> NUL [<oldvalue>] NUL
+	option SP <opt> NUL
+
+Lines of any other format or a repeated <ref> produce an error.
+Command meanings are:
+
+update::
+	Set <ref> to <newvalue> after verifying <oldvalue>, if given.
+	Specify a zero <newvalue> to ensure the ref does not exist
+	after the update and/or a zero <oldvalue> to make sure the
+	ref does not exist before the update.
+
+create::
+	Create <ref> with <newvalue> after verifying it does not
+	exist.  The given <newvalue> may not be zero.
+
+delete::
+	Delete <ref> after verifying it exists with <oldvalue>, if
+	given.  If given, <oldvalue> may not be zero.
+
+verify::
+	Verify <ref> against <oldvalue> but do not change it.  If
+	<oldvalue> zero or missing, the ref must not exist.
+
+option::
+	Modify behavior of the next command naming a <ref>.
+	The only valid option is `no-deref` to avoid dereferencing
+	a symbolic ref.
+
+Use 40 "0" or the empty string to specify a zero value, except that
+with `-z` an empty <oldvalue> is considered missing.
+
+If all <ref>s can be locked with matching <oldvalue>s
+simultaneously, all modifications are performed.  Otherwise, no
+modifications are performed.  Note that while each individual
+<ref> is updated or deleted atomically, a concurrent reader may
+still see a subset of the modifications.
 
 Logging Updates
 ---------------
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 51d2684..894f16b 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -2,23 +2,261 @@
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
+static char line_termination = '\n';
+static int update_flags;
+
+static struct ref_update *update_alloc(void)
+{
+	struct ref_update *update;
+
+	/* Allocate and zero-init a struct ref_update */
+	update = xcalloc(1, sizeof(*update));
+	ALLOC_GROW(updates, updates_count + 1, updates_alloc);
+	updates[updates_count++] = update;
+
+	/* Store and reset accumulated options */
+	update->flags = update_flags;
+	update_flags = 0;
+
+	return update;
+}
+
+static void update_store_ref_name(struct ref_update *update,
+				  const char *ref_name)
+{
+	if (check_refname_format(ref_name, REFNAME_ALLOW_ONELEVEL))
+		die("invalid ref format: %s", ref_name);
+	update->ref_name = xstrdup(ref_name);
+}
+
+static void update_store_new_sha1(struct ref_update *update,
+				  const char *newvalue)
+{
+	if (*newvalue && get_sha1(newvalue, update->new_sha1))
+		die("invalid new value for ref %s: %s",
+		    update->ref_name, newvalue);
+}
+
+static void update_store_old_sha1(struct ref_update *update,
+				  const char *oldvalue)
+{
+	if (*oldvalue && get_sha1(oldvalue, update->old_sha1))
+		die("invalid old value for ref %s: %s",
+		    update->ref_name, oldvalue);
+
+	/* We have an old value if non-empty, or if empty without -z */
+	update->have_old = *oldvalue || line_termination;
+}
+
+static const char *parse_arg(const char *next, struct strbuf *arg)
+{
+	/* Parse SP-terminated, possibly C-quoted argument */
+	if (*next != '"')
+		while (*next && !isspace(*next))
+			strbuf_addch(arg, *next++);
+	else if (unquote_c_style(arg, next, &next))
+		die("badly quoted argument: %s", next);
+
+	/* Return position after the argument */
+	return next;
+}
+
+static const char *parse_first_arg(const char *next, struct strbuf *arg)
+{
+	/* Parse argument immediately after "command SP" */
+	strbuf_reset(arg);
+	if (line_termination) {
+		/* Without -z, use the next argument */
+		next = parse_arg(next, arg);
+	} else {
+		/* With -z, use rest of first NUL-terminated line */
+		strbuf_addstr(arg, next);
+		next = next + arg->len;
+	}
+	return next;
+}
+
+static const char *parse_next_arg(const char *next, struct strbuf *arg)
+{
+	/* Parse next SP-terminated or NUL-terminated argument, if any */
+	strbuf_reset(arg);
+	if (line_termination) {
+		/* Without -z, consume SP and use next argument */
+		if (!*next)
+			return NULL;
+		if (*next != ' ')
+			die("expected SP but got: %s", next);
+		next = parse_arg(next + 1, arg);
+	} else {
+		/* With -z, read the next NUL-terminated line */
+		if (*next)
+			die("expected NUL but got: %s", next);
+		if (strbuf_getline(arg, stdin, '\0') == EOF)
+			return NULL;
+		next = arg->buf + arg->len;
+	}
+	return next;
+}
+
+static void parse_cmd_update(const char *next)
+{
+	struct strbuf ref = STRBUF_INIT;
+	struct strbuf newvalue = STRBUF_INIT;
+	struct strbuf oldvalue = STRBUF_INIT;
+	struct ref_update *update;
+
+	update = update_alloc();
+
+	if ((next = parse_first_arg(next, &ref)) != NULL && ref.buf[0])
+		update_store_ref_name(update, ref.buf);
+	else
+		die("update line missing <ref>");
+
+	if ((next = parse_next_arg(next, &newvalue)) != NULL)
+		update_store_new_sha1(update, newvalue.buf);
+	else
+		die("update %s missing <newvalue>", ref.buf);
+
+	if ((next = parse_next_arg(next, &oldvalue)) != NULL)
+		update_store_old_sha1(update, oldvalue.buf);
+	else if(!line_termination)
+		die("update %s missing [<oldvalue>] NUL", ref.buf);
+
+	if (next && *next)
+		die("update %s has extra input: %s", ref.buf, next);
+}
+
+static void parse_cmd_create(const char *next)
+{
+	struct strbuf ref = STRBUF_INIT;
+	struct strbuf newvalue = STRBUF_INIT;
+	struct ref_update *update;
+
+	update = update_alloc();
+
+	if ((next = parse_first_arg(next, &ref)) != NULL && ref.buf[0])
+		update_store_ref_name(update, ref.buf);
+	else
+		die("create line missing <ref>");
+
+	if ((next = parse_next_arg(next, &newvalue)) != NULL)
+		update_store_new_sha1(update, newvalue.buf);
+	else
+		die("create %s missing <newvalue>", ref.buf);
+	if (is_null_sha1(update->new_sha1))
+		die("create %s given zero new value", ref.buf);
+
+	if (next && *next)
+		die("create %s has extra input: %s", ref.buf, next);
+}
+
+static void parse_cmd_delete(const char *next)
+{
+	struct strbuf ref = STRBUF_INIT;
+	struct strbuf oldvalue = STRBUF_INIT;
+	struct ref_update *update;
+
+	update = update_alloc();
+
+	if ((next = parse_first_arg(next, &ref)) != NULL && ref.buf[0])
+		update_store_ref_name(update, ref.buf);
+	else
+		die("delete line missing <ref>");
+
+	if ((next = parse_next_arg(next, &oldvalue)) != NULL)
+		update_store_old_sha1(update, oldvalue.buf);
+	else if(!line_termination)
+		die("delete %s missing [<oldvalue>] NUL", ref.buf);
+	if (update->have_old && is_null_sha1(update->old_sha1))
+		die("delete %s given zero old value", ref.buf);
+
+	if (next && *next)
+		die("delete %s has extra input: %s", ref.buf, next);
+}
+
+static void parse_cmd_verify(const char *next)
+{
+	struct strbuf ref = STRBUF_INIT;
+	struct strbuf value = STRBUF_INIT;
+	struct ref_update *update;
+
+	update = update_alloc();
+
+	if ((next = parse_first_arg(next, &ref)) != NULL && ref.buf[0])
+		update_store_ref_name(update, ref.buf);
+	else
+		die("verify line missing <ref>");
+
+	if ((next = parse_next_arg(next, &value)) != NULL) {
+		update_store_old_sha1(update, value.buf);
+		update_store_new_sha1(update, value.buf);
+	} else if(!line_termination)
+		die("verify %s missing [<oldvalue>] NUL", ref.buf);
+
+	if (next && *next)
+		die("verify %s has extra input: %s", ref.buf, next);
+}
+
+static void parse_cmd_option(const char *next)
+{
+	if (!strcmp(next, "no-deref"))
+		update_flags |= REF_NODEREF;
+	else
+		die("option unknown: %s", next);
+}
+
+static void update_refs_stdin(void)
+{
+	struct strbuf cmd = STRBUF_INIT;
+
+	/* Read each line dispatch its command */
+	while (strbuf_getline(&cmd, stdin, line_termination) != EOF)
+		if (!cmd.buf[0])
+			die("empty command in input");
+		else if (isspace(*cmd.buf))
+			die("whitespace before command: %s", cmd.buf);
+		else if (!prefixcmp(cmd.buf, "update "))
+			parse_cmd_update(cmd.buf + 7);
+		else if (!prefixcmp(cmd.buf, "create "))
+			parse_cmd_create(cmd.buf + 7);
+		else if (!prefixcmp(cmd.buf, "delete "))
+			parse_cmd_delete(cmd.buf + 7);
+		else if (!prefixcmp(cmd.buf, "verify "))
+			parse_cmd_verify(cmd.buf + 7);
+		else if (!prefixcmp(cmd.buf, "option "))
+			parse_cmd_option(cmd.buf + 7);
+		else
+			die("unknown command: %s", cmd.buf);
+
+	strbuf_release(&cmd);
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
 
@@ -28,6 +266,18 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	if (msg && !*msg)
 		die("Refusing to perform update with empty message.");
 
+	if (read_stdin) {
+		if (delete || no_deref || argc > 0)
+			usage_with_options(git_update_ref_usage, options);
+		if (end_null)
+			line_termination = '\0';
+		update_refs_stdin();
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
