From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] notes: rework subcommands and parse options
Date: Sat, 27 Feb 2010 00:59:22 -0800
Message-ID: <1267261162-31750-1-git-send-email-bebarino@gmail.com>
References: <1267086261-7675-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 10:30:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlJ03-0007A2-PL
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 10:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968053Ab0B0JaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 04:30:08 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60861 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968038Ab0B0JaF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 04:30:05 -0500
Received: by pwj8 with SMTP id 8so625421pwj.19
        for <git@vger.kernel.org>; Sat, 27 Feb 2010 01:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=aqnVE84UEUTGq1zTxdDHcRUZWXjcGJb8Pba4Yu7SYp4=;
        b=svim8XTUHPJzQfFLjUjSXu3GHnL9zOx2ZVkKnIGpbPzGdFqkNYJEaasaNHe2ZsaX61
         N87gCVIYOK3GDug5r7grRtvqrTA0QmyceHwtbfPQheikqXv+P8Q6DzqkIt7iWP4RBCp/
         yC4Xyikp3Sj8RhL6XUKO08zv0S/toSodV7pl0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Kuz4p4BU9SqyzLHiUwEPO1AfiRH1nCAxCYnQtedJygtk2m2fSPamaA9oEbptpkHJ4d
         GrGcBiwYJx0eCPA9TqTpoktZGAmE99d8lMakkIMd6TKypT1ZSlL9kpjLZ+eS9wp5HvOd
         3p7bvuy6Y7vegxZWkt4tt0XpA8SjATwooPVKY=
Received: by 10.115.117.4 with SMTP id u4mr929127wam.174.1267261165283;
        Sat, 27 Feb 2010 00:59:25 -0800 (PST)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 20sm948013pzk.11.2010.02.27.00.59.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Feb 2010 00:59:24 -0800 (PST)
X-Mailer: git-send-email 1.7.0.94.gf7311
In-Reply-To: <1267086261-7675-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141193>

Running 'git notes copy -h' is not very helfpul right now. It lists
the options for all the git notes subcommands and is rather confusing.
Fix this by splitting cmd_notes() into separate functions for each
subcommand (besides append and edit since they're very similar) and
only providing a usage message for the subcommand.

This has an added benefit of reducing the code complexity while making
it safer and easier to read. The downside is we get some code bloat
from similar setup and teardown needed for notes and options parsing.
We also get a bit stricter in options parsing by only allowing
the ref option to come before the subcommand.

Acked-by: Johan Herland <johan@herland.net>
Cc: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

Based on latest version of tr/notes-display in pu.

Thanks to Tim Henigan for the suggestion and Johan Herland for the
suggestions/cleanup.

 builtin-notes.c  |  549 +++++++++++++++++++++++++++++++++++++----------------
 t/t3301-notes.sh |   11 +
 2 files changed, 394 insertions(+), 166 deletions(-)

diff --git a/builtin-notes.c b/builtin-notes.c
index 2e45be9..3b84392 100644
--- a/builtin-notes.c
+++ b/builtin-notes.c
@@ -19,13 +19,54 @@
 #include "string-list.h"
 
 static const char * const git_notes_usage[] = {
+	"git notes [--ref <notes_ref>] [list [<object>]]",
+	"git notes [--ref <notes_ref>] add [-f] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]",
+	"git notes [--ref <notes_ref>] copy [-f] <from-object> <to-object>",
+	"git notes [--ref <notes_ref>] append [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]",
+	"git notes [--ref <notes_ref>] edit [<object>]",
+	"git notes [--ref <notes_ref>] show [<object>]",
+	"git notes [--ref <notes_ref>] remove [<object>]",
+	"git notes [--ref <notes_ref>] prune",
+	NULL
+};
+
+static const char * const git_notes_list_usage[] = {
 	"git notes [list [<object>]]",
-	"git notes add [-f] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]",
-	"git notes copy [-f] <from-object> <to-object>",
-	"git notes append [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]",
+	NULL
+};
+
+static const char * const git_notes_add_usage[] = {
+	"git notes add [<options>] [<object>]",
+	NULL
+};
+
+static const char * const git_notes_copy_usage[] = {
+	"git notes copy [<options>] <from-object> <to-object>",
+	"git notes copy --stdin [<from-object> <to-object>]...",
+	NULL
+};
+
+static const char * const git_notes_append_usage[] = {
+	"git notes append [<options>] [<object>]",
+	NULL
+};
+
+static const char * const git_notes_edit_usage[] = {
 	"git notes edit [<object>]",
+	NULL
+};
+
+static const char * const git_notes_show_usage[] = {
 	"git notes show [<object>]",
+	NULL
+};
+
+static const char * const git_notes_remove_usage[] = {
 	"git notes remove [<object>]",
+	NULL
+};
+
+static const char * const git_notes_prune_usage[] = {
 	"git notes prune",
 	NULL
 };
@@ -279,7 +320,6 @@ int commit_notes(struct notes_tree *t, const char *msg)
 	return 0;
 }
 
-
 combine_notes_fn *parse_combine_notes_fn(const char *v)
 {
 	if (!strcasecmp(v, "overwrite"))
@@ -434,219 +474,396 @@ int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 	return ret;
 }
 
-int cmd_notes(int argc, const char **argv, const char *prefix)
+static struct notes_tree *init_notes_check(const char *subcommand)
 {
 	struct notes_tree *t;
-	unsigned char object[20], from_obj[20], new_note[20];
-	const unsigned char *note;
-	const char *object_ref;
-	char logmsg[100];
+	init_notes(NULL, NULL, NULL, 0);
+	t = &default_notes_tree;
 
-	int list = 0, add = 0, copy = 0, append = 0, edit = 0, show = 0,
-	    remove = 0, prune = 0, force = 0, from_stdin = 0;
-	int given_object = 0, i = 1, retval = 0;
-	struct msg_arg msg = { 0, 0, STRBUF_INIT };
-	const char *rewrite_cmd = NULL;
-	const char *override_notes_ref = NULL;
+	if (prefixcmp(t->ref, "refs/notes/"))
+		die("Refusing to %s notes in %s (outside of refs/notes/)",
+		    subcommand, t->ref);
+	return t;
+}
+
+static int list(int argc, const char **argv, const char *prefix)
+{
+	struct notes_tree *t;
+	unsigned char object[20];
+	const unsigned char *note;
+	int retval = -1;
 	struct option options[] = {
-		OPT_GROUP("Notes options"),
-		OPT_CALLBACK('m', "message", &msg, "MSG",
-			     "note contents as a string", parse_msg_arg),
-		OPT_CALLBACK('F', "file", &msg, "FILE",
-			     "note contents in a file", parse_file_arg),
-		OPT_CALLBACK('c', "reedit-message", &msg, "OBJECT",
-			   "reuse and edit specified note object", parse_reedit_arg),
-		OPT_CALLBACK('C', "reuse-message", &msg, "OBJECT",
-			   "reuse specified note object", parse_reuse_arg),
-		OPT_BOOLEAN('f', "force", &force, "replace existing notes"),
-		OPT_BOOLEAN(0, "stdin", &from_stdin, "read objects from stdin"),
-		OPT_STRING(0, "ref", &override_notes_ref, "notes_ref",
-			   "use notes from <notes_ref>"),
-		OPT_STRING(0, "for-rewrite", &rewrite_cmd, "command",
-			   "load rewriting config for <command> (implies --stdin)"),
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
-
-	argc = parse_options(argc, argv, prefix, options, git_notes_usage, 0);
+	if (argc)
+		argc = parse_options(argc, argv, prefix, options,
+				     git_notes_list_usage, 0);
 
-	if (override_notes_ref) {
-		struct strbuf sb = STRBUF_INIT;
-		if (!prefixcmp(override_notes_ref, "refs/notes/"))
-			/* we're happy */;
-		else if (!prefixcmp(override_notes_ref, "notes/"))
-			strbuf_addstr(&sb, "refs/");
-		else
-			strbuf_addstr(&sb, "refs/notes/");
-		strbuf_addstr(&sb, override_notes_ref);
-		setenv("GIT_NOTES_REF", sb.buf, 1);
-		strbuf_release(&sb);
+	if (1 < argc) {
+		error("too many parameters");
+		usage_with_options(git_notes_list_usage, options);
 	}
 
-	if (argc && !strcmp(argv[0], "list"))
-		list = 1;
-	else if (argc && !strcmp(argv[0], "add"))
-		add = 1;
-	else if (argc && !strcmp(argv[0], "copy"))
-		copy = 1;
-	else if (argc && !strcmp(argv[0], "append"))
-		append = 1;
-	else if (argc && !strcmp(argv[0], "edit"))
-		edit = 1;
-	else if (argc && !strcmp(argv[0], "show"))
-		show = 1;
-	else if (argc && !strcmp(argv[0], "remove"))
-		remove = 1;
-	else if (argc && !strcmp(argv[0], "prune"))
-		prune = 1;
-	else if (!argc) {
-		list = 1; /* Default to 'list' if no other subcommand given */
-		i = 0;
-	}
+	t = init_notes_check("list");
+	if (argc) {
+		if (get_sha1(argv[0], object))
+			die("Failed to resolve '%s' as a valid ref.", argv[0]);
+		note = get_note(t, object);
+		if (note) {
+			puts(sha1_to_hex(note));
+			retval = 0;
+		} else
+			retval = error("No note found for object %s.",
+				       sha1_to_hex(object));
+	} else
+		retval = for_each_note(t, 0, list_each_note, NULL);
 
-	if (list + add + copy + append + edit + show + remove + prune != 1)
-		usage_with_options(git_notes_usage, options);
+	free_notes(t);
+	return retval;
+}
 
-	if (msg.given && !(add || append || edit)) {
-		error("cannot use -m/-F/-c/-C options with %s subcommand.",
-		      argv[0]);
-		usage_with_options(git_notes_usage, options);
-	}
+static int add(int argc, const char **argv, const char *prefix)
+{
+	int retval = 0, force = 0;
+	const char *object_ref;
+	struct notes_tree *t;
+	unsigned char object[20], new_note[20];
+	char logmsg[100];
+	const unsigned char *note;
+	struct msg_arg msg = { 0, 0, STRBUF_INIT };
+	struct option options[] = {
+		{ OPTION_CALLBACK, 'm', "message", &msg, "MSG",
+			"note contents as a string", PARSE_OPT_NONEG,
+			parse_msg_arg},
+		{ OPTION_CALLBACK, 'F', "file", &msg, "FILE",
+			"note contents in a file", PARSE_OPT_NONEG,
+			parse_file_arg},
+		{ OPTION_CALLBACK, 'c', "reedit-message", &msg, "OBJECT",
+			"reuse and edit specified note object", PARSE_OPT_NONEG,
+			parse_reedit_arg},
+		{ OPTION_CALLBACK, 'C', "reuse-message", &msg, "OBJECT",
+			"reuse specified note object", PARSE_OPT_NONEG,
+			parse_reuse_arg},
+		OPT_BOOLEAN('f', "force", &force, "replace existing notes"),
+		OPT_END()
+	};
 
-	if (msg.given && edit) {
-		fprintf(stderr, "The -m/-F/-c/-C options have been deprecated "
-			"for the 'edit' subcommand.\n"
-			"Please use 'git notes add -f -m/-F/-c/-C' instead.\n");
-	}
+	argc = parse_options(argc, argv, prefix, options, git_notes_add_usage,
+			     0);
 
-	if (force && !(add || copy)) {
-		error("cannot use -f option with %s subcommand.", argv[0]);
-		usage_with_options(git_notes_usage, options);
+	if (1 < argc) {
+		error("too many parameters");
+		usage_with_options(git_notes_add_usage, options);
 	}
 
-	if (!copy && rewrite_cmd) {
-		error("cannot use --for-rewrite with %s subcommand.", argv[0]);
-		usage_with_options(git_notes_usage, options);
-	}
-	if (!copy && from_stdin) {
-		error("cannot use --stdin with %s subcommand.", argv[0]);
-		usage_with_options(git_notes_usage, options);
-	}
+	object_ref = argc ? argv[0] : "HEAD";
 
-	if (copy) {
-		const char *from_ref;
-		if (from_stdin || rewrite_cmd) {
-			if (argc > 1) {
-				error("too many parameters");
-				usage_with_options(git_notes_usage, options);
-			} else {
-				return notes_copy_from_stdin(force, rewrite_cmd);
-			}
-		}
-		if (argc < 3) {
-			error("too few parameters");
-			usage_with_options(git_notes_usage, options);
-		}
-		from_ref = argv[i++];
-		if (get_sha1(from_ref, from_obj))
-			die("Failed to resolve '%s' as a valid ref.", from_ref);
-	}
+	if (get_sha1(object_ref, object))
+		die("Failed to resolve '%s' as a valid ref.", object_ref);
 
-	given_object = argc > i;
-	object_ref = given_object ? argv[i++] : "HEAD";
+	t = init_notes_check("add");
+	note = get_note(t, object);
 
-	if (argc > i || (prune && given_object)) {
-		error("too many parameters");
-		usage_with_options(git_notes_usage, options);
+	if (note) {
+		if (!force) {
+			retval = error("Cannot add notes. Found existing notes "
+				       "for object %s. Use '-f' to overwrite "
+				       "existing notes", sha1_to_hex(object));
+			goto out;
+		}
+		fprintf(stderr, "Overwriting existing notes for object %s\n",
+			sha1_to_hex(object));
 	}
 
-	if (get_sha1(object_ref, object))
-		die("Failed to resolve '%s' as a valid ref.", object_ref);
+	create_note(object, &msg, 0, note, new_note);
 
-	init_notes(NULL, NULL, NULL, 0);
-	t = &default_notes_tree;
+	if (is_null_sha1(new_note))
+		remove_note(t, object);
+	else
+		add_note(t, object, new_note, combine_notes_overwrite);
 
-	if (prefixcmp(t->ref, "refs/notes/"))
-		die("Refusing to %s notes in %s (outside of refs/notes/)",
-		    argv[0], t->ref);
+	snprintf(logmsg, sizeof(logmsg), "Notes %s by 'git notes %s'",
+		 is_null_sha1(new_note) ? "removed" : "added", "add");
+	commit_notes(t, logmsg);
+out:
+	free_notes(t);
+	strbuf_release(&(msg.buf));
+	return retval;
+}
 
-	note = get_note(t, object);
+static int copy(int argc, const char **argv, const char *prefix)
+{
+	int retval = 0, force = 0, from_stdin = 0;
+	const unsigned char *from_note, *note;
+	const char *object_ref;
+	unsigned char object[20], from_obj[20];
+	struct notes_tree *t;
+	const char *rewrite_cmd = NULL;
+	struct option options[] = {
+		OPT_BOOLEAN('f', "force", &force, "replace existing notes"),
+		OPT_BOOLEAN(0, "stdin", &from_stdin, "read objects from stdin"),
+		OPT_STRING(0, "for-rewrite", &rewrite_cmd, "command",
+			   "load rewriting config for <command> (implies "
+			   "--stdin)"),
+		OPT_END()
+	};
 
-	/* list command */
+	argc = parse_options(argc, argv, prefix, options, git_notes_copy_usage,
+			     0);
 
-	if (list) {
-		if (given_object) {
-			if (note) {
-				puts(sha1_to_hex(note));
-				goto end;
-			}
+	if (from_stdin || rewrite_cmd) {
+		if (argc) {
+			error("too many parameters");
+			usage_with_options(git_notes_copy_usage, options);
 		} else {
-			retval = for_each_note(t, 0, list_each_note, NULL);
-			goto end;
+			return notes_copy_from_stdin(force, rewrite_cmd);
 		}
 	}
 
-	/* show command */
-
-	if ((list || show) && !note) {
-		error("No note found for object %s.", sha1_to_hex(object));
-		retval = 1;
-		goto end;
-	} else if (show) {
-		const char *show_args[3] = {"show", sha1_to_hex(note), NULL};
-		retval = execv_git_cmd(show_args);
-		goto end;
+	if (2 < argc) {
+		error("too many parameters");
+		usage_with_options(git_notes_copy_usage, options);
 	}
 
-	/* add/append/edit/remove/prune command */
+	if (get_sha1(argv[0], from_obj))
+		die("Failed to resolve '%s' as a valid ref.", argv[0]);
+
+	object_ref = 1 < argc ? argv[1] : "HEAD";
+
+	if (get_sha1(object_ref, object))
+		die("Failed to resolve '%s' as a valid ref.", object_ref);
 
-	if ((add || copy) && note) {
+	t = init_notes_check("copy");
+	note = get_note(t, object);
+
+	if (note) {
 		if (!force) {
-			error("Cannot %s notes. Found existing notes for object"
-			      " %s. Use '-f' to overwrite existing notes",
-			      argv[0], sha1_to_hex(object));
-			retval = 1;
-			goto end;
+			retval = error("Cannot copy notes. Found existing "
+				       "notes for object %s. Use '-f' to "
+				       "overwrite existing notes",
+				       sha1_to_hex(object));
+			goto out;
 		}
 		fprintf(stderr, "Overwriting existing notes for object %s\n",
 			sha1_to_hex(object));
 	}
 
-	if (remove) {
-		msg.given = 1;
-		msg.use_editor = 0;
-		strbuf_reset(&(msg.buf));
+	from_note = get_note(t, from_obj);
+	if (!from_note) {
+		retval = error("Missing notes on source object %s. Cannot "
+			       "copy.", sha1_to_hex(from_obj));
+		goto out;
 	}
 
-	if (prune) {
-		hashclr(new_note);
-		prune_notes(t);
-		goto commit;
-	} else if (copy) {
-		const unsigned char *from_note = get_note(t, from_obj);
-		if (!from_note) {
-			error("Missing notes on source object %s. Cannot copy.",
-			      sha1_to_hex(from_obj));
-			retval = 1;
-			goto end;
-		}
-		hashcpy(new_note, from_note);
-	} else
-		create_note(object, &msg, append, note, new_note);
+	add_note(t, object, from_note, combine_notes_overwrite);
+	commit_notes(t, "Notes added by 'git notes copy'");
+out:
+	free_notes(t);
+	return retval;
+}
+
+static int append_edit(int argc, const char **argv, const char *prefix)
+{
+	const char *object_ref;
+	struct notes_tree *t;
+	unsigned char object[20], new_note[20];
+	const unsigned char *note;
+	char logmsg[100];
+	const char * const *usage;
+	struct msg_arg msg = { 0, 0, STRBUF_INIT };
+	struct option options[] = {
+		{ OPTION_CALLBACK, 'm', "message", &msg, "MSG",
+			"note contents as a string", PARSE_OPT_NONEG,
+			parse_msg_arg},
+		{ OPTION_CALLBACK, 'F', "file", &msg, "FILE",
+			"note contents in a file", PARSE_OPT_NONEG,
+			parse_file_arg},
+		{ OPTION_CALLBACK, 'c', "reedit-message", &msg, "OBJECT",
+			"reuse and edit specified note object", PARSE_OPT_NONEG,
+			parse_reedit_arg},
+		{ OPTION_CALLBACK, 'C', "reuse-message", &msg, "OBJECT",
+			"reuse specified note object", PARSE_OPT_NONEG,
+			parse_reuse_arg},
+		OPT_END()
+	};
+	int edit = !strcmp(argv[0], "edit");
+
+	usage = edit ? git_notes_edit_usage : git_notes_append_usage;
+	argc = parse_options(argc, argv, prefix, options, usage,
+			     PARSE_OPT_KEEP_ARGV0);
+
+	if (2 < argc) {
+		error("too many parameters");
+		usage_with_options(usage, options);
+	}
+
+	if (msg.given && edit)
+		fprintf(stderr, "The -m/-F/-c/-C options have been deprecated "
+			"for the 'edit' subcommand.\n"
+			"Please use 'git notes add -f -m/-F/-c/-C' instead.\n");
+
+	object_ref = 1 < argc ? argv[1] : "HEAD";
+
+	if (get_sha1(object_ref, object))
+		die("Failed to resolve '%s' as a valid ref.", object_ref);
+
+	t = init_notes_check(argv[0]);
+	note = get_note(t, object);
+
+	create_note(object, &msg, !edit, note, new_note);
 
 	if (is_null_sha1(new_note))
 		remove_note(t, object);
 	else
 		add_note(t, object, new_note, combine_notes_overwrite);
 
-commit:
 	snprintf(logmsg, sizeof(logmsg), "Notes %s by 'git notes %s'",
 		 is_null_sha1(new_note) ? "removed" : "added", argv[0]);
 	commit_notes(t, logmsg);
-
-end:
 	free_notes(t);
 	strbuf_release(&(msg.buf));
+	return 0;
+}
+
+static int show(int argc, const char **argv, const char *prefix)
+{
+	const char *object_ref;
+	struct notes_tree *t;
+	unsigned char object[20];
+	const unsigned char *note;
+	int retval;
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options, git_notes_show_usage,
+			     0);
+
+	if (1 < argc) {
+		error("too many parameters");
+		usage_with_options(git_notes_show_usage, options);
+	}
+
+	object_ref = argc ? argv[0] : "HEAD";
+
+	if (get_sha1(object_ref, object))
+		die("Failed to resolve '%s' as a valid ref.", object_ref);
+
+	t = init_notes_check("show");
+	note = get_note(t, object);
+
+	if (!note)
+		retval = error("No note found for object %s.",
+			       sha1_to_hex(object));
+	else {
+		const char *show_args[3] = {"show", sha1_to_hex(note), NULL};
+		retval = execv_git_cmd(show_args);
+	}
+	free_notes(t);
 	return retval;
 }
+
+static int remove_cmd(int argc, const char **argv, const char *prefix)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+	const char *object_ref;
+	struct notes_tree *t;
+	unsigned char object[20];
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_notes_remove_usage, 0);
+
+	if (1 < argc) {
+		error("too many parameters");
+		usage_with_options(git_notes_remove_usage, options);
+	}
+
+	object_ref = argc ? argv[0] : "HEAD";
+
+	if (get_sha1(object_ref, object))
+		die("Failed to resolve '%s' as a valid ref.", object_ref);
+
+	t = init_notes_check("remove");
+
+	fprintf(stderr, "Removing note for object %s\n", sha1_to_hex(object));
+	remove_note(t, object);
+
+	commit_notes(t, "Notes removed by 'git notes remove'");
+	free_notes(t);
+	return 0;
+}
+
+static int prune(int argc, const char **argv, const char *prefix)
+{
+	struct notes_tree *t;
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options, git_notes_prune_usage,
+			     0);
+
+	if (argc) {
+		error("too many parameters");
+		usage_with_options(git_notes_prune_usage, options);
+	}
+
+	t = init_notes_check("prune");
+
+	prune_notes(t);
+	commit_notes(t, "Notes removed by 'git notes prune'");
+	free_notes(t);
+	return 0;
+}
+
+int cmd_notes(int argc, const char **argv, const char *prefix)
+{
+	int result;
+	const char *override_notes_ref = NULL;
+	struct option options[] = {
+		OPT_STRING(0, "ref", &override_notes_ref, "notes_ref",
+			   "use notes from <notes_ref>"),
+		OPT_END()
+	};
+
+	git_config(git_default_config, NULL);
+	argc = parse_options(argc, argv, prefix, options, git_notes_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (override_notes_ref) {
+		struct strbuf sb = STRBUF_INIT;
+		if (!prefixcmp(override_notes_ref, "refs/notes/"))
+			/* we're happy */;
+		else if (!prefixcmp(override_notes_ref, "notes/"))
+			strbuf_addstr(&sb, "refs/");
+		else
+			strbuf_addstr(&sb, "refs/notes/");
+		strbuf_addstr(&sb, override_notes_ref);
+		setenv("GIT_NOTES_REF", sb.buf, 1);
+		strbuf_release(&sb);
+	}
+
+	if (argc < 1 || !strcmp(argv[0], "list"))
+		result = list(argc, argv, prefix);
+	else if (!strcmp(argv[0], "add"))
+		result = add(argc, argv, prefix);
+	else if (!strcmp(argv[0], "copy"))
+		result = copy(argc, argv, prefix);
+	else if (!strcmp(argv[0], "append") || !strcmp(argv[0], "edit"))
+		result = append_edit(argc, argv, prefix);
+	else if (!strcmp(argv[0], "show"))
+		result = show(argc, argv, prefix);
+	else if (!strcmp(argv[0], "remove"))
+		result = remove_cmd(argc, argv, prefix);
+	else if (!strcmp(argv[0], "prune"))
+		result = prune(argc, argv, prefix);
+	else {
+		result = error("Unknown subcommand: %s", argv[0]);
+		usage_with_options(git_notes_usage, options);
+	}
+
+	return result ? 1 : 0;
+}
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index aeec90a..5b26211 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -377,6 +377,17 @@ test_expect_success 'append to existing note with "git notes append"' '
 	test_cmp expect output
 '
 
+cat > expect_list << EOF
+c18dc024e14f08d18d14eea0d747ff692d66d6a3 1584215f1d29c65e99c6c6848626553fdd07fd75
+c9c6af7f78bc47490dbf3e822cf2f3c24d4b9061 268048bfb8a1fb38e703baceb8ab235421bf80c5
+4b6ad22357cc8a1296720574b8d2fbc22fab0671 bd1753200303d0a0344be813e504253b3d98e74d
+EOF
+
+test_expect_success '"git notes list" does not expand to "git notes list HEAD"' '
+	git notes list > output &&
+	test_cmp expect_list output
+'
+
 test_expect_success 'appending empty string does not change existing note' '
 	git notes append -m "" &&
 	git notes show > output &&
-- 
1.7.0.94.gf7311
