From: Stephen Boyd <bebarino@gmail.com>
Subject: [RFC/PATCH] notes: rework subcommands and parse options
Date: Thu, 25 Feb 2010 00:24:21 -0800
Message-ID: <1267086261-7675-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 25 09:24:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkZ1N-00080A-SG
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 09:24:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948Ab0BYIY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 03:24:28 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:35966 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741Ab0BYIY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 03:24:26 -0500
Received: by gwj16 with SMTP id 16so1579170gwj.19
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 00:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=rBbMyhGE4cDqJcAt4X/aH615hDoz06bGMbaOYK/kuoM=;
        b=LCcT1EljEuerYfuMqgPOk9c7c8EqYRR3lC/qQDRCT39RKYIfoGqUsuWtxLS1kACMV2
         1p8hKWaB9CFTQiZI+2eJVewbHenTlg3RxlKWx/rwUxpOpJAYLpio3mUdzUubOWajliDz
         8y5EYTIXi8/ubRtCbVycmRE3joLuUc+Upl1t0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=sAVKLTSjNk1l7DEDFLQ2cMaBV3i30ZwpCSVmkClKg/ZNCPEoyyIS9+M+bbol0PHRtp
         6Zua3KQMvt4oxEwBYQBicY3pS8kvltDRj6Sk25UddplCDhRrizGpOsODivUussjeC/6f
         vBX9UtuQjmbNPQ4vklt1QtPV4vyCVM+z6eeb8=
Received: by 10.101.212.6 with SMTP id o6mr1196886anq.42.1267086265622;
        Thu, 25 Feb 2010 00:24:25 -0800 (PST)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 21sm2362365ywh.32.2010.02.25.00.24.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Feb 2010 00:24:24 -0800 (PST)
X-Mailer: git-send-email 1.7.0.90.g251a4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141033>

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

Cc: Johan Herland <johan@herland.net>
Cc: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

This is based on tr/notes-display in pu.

I think this will be a better approach and probably easier to
maintain in the long run. Maybe some more common code can be combined?

 builtin-notes.c |  543 ++++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 379 insertions(+), 164 deletions(-)

diff --git a/builtin-notes.c b/builtin-notes.c
index 2e45be9..a8a8bef 100644
--- a/builtin-notes.c
+++ b/builtin-notes.c
@@ -30,6 +30,46 @@ static const char * const git_notes_usage[] = {
 	NULL
 };
 
+static const char * const git_notes_list_usage[] = {
+	"git notes [list [<object>]]",
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
+	NULL
+};
+
+static const char * const git_notes_append_usage[] = {
+	"git notes append [<options>] [<object>]",
+	NULL
+};
+
+static const char * const git_notes_edit_usage[] = {
+	"git notes edit [<object>]",
+	NULL
+};
+
+static const char * const git_notes_show_usage[] = {
+	"git notes show [<object>]",
+	NULL
+};
+
+static const char * const git_notes_remove_usage[] = {
+	"git notes remove [<object>]",
+	NULL
+};
+
+static const char * const git_notes_prune_usage[] = {
+	"git notes prune",
+	NULL
+};
+
 static const char note_template[] =
 	"\n"
 	"#\n"
@@ -279,7 +319,6 @@ int commit_notes(struct notes_tree *t, const char *msg)
 	return 0;
 }
 
-
 combine_notes_fn *parse_combine_notes_fn(const char *v)
 {
 	if (!strcasecmp(v, "overwrite"))
@@ -434,219 +473,395 @@ int notes_copy_from_stdin(int force, const char *rewrite_cmd)
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
+	const char *object_ref;
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
-	}
-
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
+	if (1 < argc) {
+		error("too many parameters");
+		usage_with_options(git_notes_list_usage, options);
 	}
 
-	if (list + add + copy + append + edit + show + remove + prune != 1)
-		usage_with_options(git_notes_usage, options);
+	object_ref = argc ? argv[0] : "HEAD";
 
-	if (msg.given && !(add || append || edit)) {
-		error("cannot use -m/-F/-c/-C options with %s subcommand.",
-		      argv[0]);
-		usage_with_options(git_notes_usage, options);
-	}
+	if (get_sha1(object_ref, object))
+		die("Failed to resolve '%s' as a valid ref.", object_ref);
 
-	if (msg.given && edit) {
-		fprintf(stderr, "The -m/-F/-c/-C options have been deprecated "
-			"for the 'edit' subcommand.\n"
-			"Please use 'git notes add -f -m/-F/-c/-C' instead.\n");
-	}
+	t = init_notes_check("list");
+	note = get_note(t, object);
 
-	if (force && !(add || copy)) {
-		error("cannot use -f option with %s subcommand.", argv[0]);
-		usage_with_options(git_notes_usage, options);
-	}
+	if (note) {
+		puts(sha1_to_hex(note));
+		retval = 0;
+	} else if (argc == 0)
+		retval = for_each_note(t, 0, list_each_note, NULL);
 
-	if (!copy && rewrite_cmd) {
-		error("cannot use --for-rewrite with %s subcommand.", argv[0]);
-		usage_with_options(git_notes_usage, options);
-	}
-	if (!copy && from_stdin) {
-		error("cannot use --stdin with %s subcommand.", argv[0]);
-		usage_with_options(git_notes_usage, options);
-	}
+	free_notes(t);
+	return retval;
+}
 
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
+static int add(int argc, const char **argv, const char *prefix)
+{
+	int force = 0;
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
 
-	given_object = argc > i;
-	object_ref = given_object ? argv[i++] : "HEAD";
+	argc = parse_options(argc, argv, prefix, options, git_notes_add_usage,
+			     0);
 
-	if (argc > i || (prune && given_object)) {
+	if (1 < argc) {
 		error("too many parameters");
-		usage_with_options(git_notes_usage, options);
+		usage_with_options(git_notes_add_usage, options);
 	}
 
+	object_ref = argc ? argv[0] : "HEAD";
+
 	if (get_sha1(object_ref, object))
 		die("Failed to resolve '%s' as a valid ref.", object_ref);
 
-	init_notes(NULL, NULL, NULL, 0);
-	t = &default_notes_tree;
+	t = init_notes_check("add");
+	note = get_note(t, object);
 
-	if (prefixcmp(t->ref, "refs/notes/"))
-		die("Refusing to %s notes in %s (outside of refs/notes/)",
-		    argv[0], t->ref);
+	if (note) {
+		if (!force)
+			return	error("Cannot add notes. Found existing notes "
+				      "for object %s. Use '-f' to overwrite "
+				      "existing notes", sha1_to_hex(object));
+		fprintf(stderr, "Overwriting existing notes for object %s\n",
+			sha1_to_hex(object));
+	}
 
-	note = get_note(t, object);
+	create_note(object, &msg, 0, note, new_note);
 
-	/* list command */
+	if (is_null_sha1(new_note))
+		remove_note(t, object);
+	else
+		add_note(t, object, new_note, combine_notes_overwrite);
 
-	if (list) {
-		if (given_object) {
-			if (note) {
-				puts(sha1_to_hex(note));
-				goto end;
-			}
+	snprintf(logmsg, sizeof(logmsg), "Notes %s by 'git notes %s'",
+		 is_null_sha1(new_note) ? "removed" : "added", "add");
+	commit_notes(t, logmsg);
+	free_notes(t);
+	strbuf_release(&(msg.buf));
+	return 0;
+}
+
+static int copy(int argc, const char **argv, const char *prefix)
+{
+	int force = 0, from_stdin = 0;
+	const unsigned char *from_note, *note;
+	const char *object_ref;
+	unsigned char object[20], from_obj[20], new_note[20];
+	char logmsg[100];
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
+
+	argc = parse_options(argc, argv, prefix, options, git_notes_copy_usage,
+			     0);
+
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
+		error("too few parameters");
+		usage_with_options(git_notes_copy_usage, options);
 	}
 
-	/* add/append/edit/remove/prune command */
+	if (get_sha1(argv[0], from_obj))
+		die("Failed to resolve '%s' as a valid ref.", argv[0]);
 
-	if ((add || copy) && note) {
-		if (!force) {
-			error("Cannot %s notes. Found existing notes for object"
-			      " %s. Use '-f' to overwrite existing notes",
-			      argv[0], sha1_to_hex(object));
-			retval = 1;
-			goto end;
-		}
+	object_ref = 1 < argc ? argv[1] : "HEAD";
+
+	if (get_sha1(object_ref, object))
+		die("Failed to resolve '%s' as a valid ref.", object_ref);
+
+	t = init_notes_check("copy");
+	note = get_note(t, object);
+
+	if (note) {
+		if (!force)
+			return error("Cannot copy notes. Found existing notes "
+				     "for object %s. Use '-f' to overwrite "
+				     "existing notes", sha1_to_hex(object));
 		fprintf(stderr, "Overwriting existing notes for object %s\n",
 			sha1_to_hex(object));
 	}
 
-	if (remove) {
-		msg.given = 1;
-		msg.use_editor = 0;
-		strbuf_reset(&(msg.buf));
+	from_note = get_note(t, from_obj);
+	if (!from_note)
+		return error("Missing notes on source object %s. Cannot copy.",
+			     sha1_to_hex(from_obj));
+	hashcpy(new_note, from_note);
+
+	if (is_null_sha1(new_note))
+		remove_note(t, object);
+	else
+		add_note(t, object, new_note, combine_notes_overwrite);
+
+	snprintf(logmsg, sizeof(logmsg), "Notes %s by 'git notes %s'",
+		 is_null_sha1(new_note) ? "removed" : "added", "copy");
+	commit_notes(t, logmsg);
+	free_notes(t);
+	return 0;
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
+				sha1_to_hex(object));
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
+	}
+
+	return result ? 1 : 0;
+}
-- 
1.7.0.90.g251a4
