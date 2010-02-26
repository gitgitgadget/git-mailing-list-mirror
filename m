From: Johan Herland <johan@herland.net>
Subject: Re: [RFC/PATCH] notes: rework subcommands and parse options
Date: Fri, 26 Feb 2010 12:22:24 +0100
Message-ID: <201002261222.25209.johan@herland.net>
References: <1267086261-7675-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 12:22:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkyHG-0000gM-1e
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 12:22:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934697Ab0BZLWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 06:22:31 -0500
Received: from smtp.getmail.no ([84.208.15.66]:63807 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934303Ab0BZLWa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 06:22:30 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KYG004WS4XGM720@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 26 Feb 2010 12:22:28 +0100 (MET)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KYG0045P4XD4V40@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 26 Feb 2010 12:22:28 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.26.110928
User-Agent: KMail/1.13.0 (Linux/2.6.32-ARCH; KDE/4.4.0; x86_64; ; )
In-reply-to: <1267086261-7675-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141122>

On Thursday 25 February 2010, Stephen Boyd wrote:
> Running 'git notes copy -h' is not very helfpul right now. It lists
> the options for all the git notes subcommands and is rather confusing.
> Fix this by splitting cmd_notes() into separate functions for each
> subcommand (besides append and edit since they're very similar) and
> only providing a usage message for the subcommand.
> 
> This has an added benefit of reducing the code complexity while making
> it safer and easier to read. The downside is we get some code bloat
> from similar setup and teardown needed for notes and options parsing.
> We also get a bit stricter in options parsing by only allowing
> the ref option to come before the subcommand.
> 
> Cc: Johan Herland <johan@herland.net>
> Cc: Thomas Rast <trast@student.ethz.ch>
> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
> ---
> 
> This is based on tr/notes-display in pu.
> 
> I think this will be a better approach and probably easier to
> maintain in the long run. Maybe some more common code can be combined?

I like the intent of this, but the implementation is not there yet:

(your patch edited for clarity while revieweing)

> +static int list(int argc, const char **argv, const char *prefix)

[...]

> +	object_ref = argc ? argv[0] : "HEAD";
> 
> +	if (get_sha1(object_ref, object))
> +		die("Failed to resolve '%s' as a valid ref.", object_ref);
> 
> +	t = init_notes_check("list");
> +	note = get_note(t, object);
> 
> +	if (note) {
> +		puts(sha1_to_hex(note));
> +		retval = 0;
> +	} else if (argc == 0)
> +		retval = for_each_note(t, 0, list_each_note, NULL);

This changes the semantics when calling "git notes list" (in the case where
HEAD has notes) from displaying all notes, to displaying HEAD's notes.

IMO, "git notes list" without further parameters should always show a list
of all notes regardless of whether HEAD has notes or not.

My patch below fixes this, and adds a test verifying those semantics (i.e.
the test succeeds before applying your patch, fails after applying it, and
succeeds again after squashing in my additional patch below).

> +static int add(int argc, const char **argv, const char *prefix)

[...]

> +	if (note) {
> +		if (!force)
> +			return	error("Cannot add notes. Found existing notes "
> +				      "for object %s. Use '-f' to overwrite "
> +				      "existing notes", sha1_to_hex(object));

Missing cleanup code before the "return":

	free_notes(t);
	strbuf_release(&(msg.buf));

Also s/<tab>/<space>/ between "return" and "error"

> +static int copy(int argc, const char **argv, const char *prefix)

[...]

> +	if (2 < argc) {
> +		error("too few parameters");

s/few/many/

[...]

> +	if (note) {
> +		if (!force)
> +			return error("Cannot copy notes. Found existing notes "
> +				     "for object %s. Use '-f' to overwrite "
> +				     "existing notes", sha1_to_hex(object));

Missing cleanup code before the "return":

	free_notes(t);

>  		fprintf(stderr, "Overwriting existing notes for object %s\n",
>  			sha1_to_hex(object));
>  	}
> 
> +	from_note = get_note(t, from_obj);
> +	if (!from_note)
> +		return error("Missing notes on source object %s. Cannot copy.",
> +			     sha1_to_hex(from_obj));

Missing cleanup code before the "return":

	free_notes(t);

> +	hashcpy(new_note, from_note);
> +
> +	if (is_null_sha1(new_note))
> +		remove_note(t, object);
> +	else
> +		add_note(t, object, new_note, combine_notes_overwrite);
> +
> +	snprintf(logmsg, sizeof(logmsg), "Notes %s by 'git notes %s'",
> +		 is_null_sha1(new_note) ? "removed" : "added", "copy");
> +	commit_notes(t, logmsg);

Can get rid of "new_note" and "logmsg" in this block. Also is_null_sha1()
should never happen. Hence, simply replace with:

	add_note(t, object, from_note, combine_notes_overwrite);
	commit_notes(t, "Notes added by 'git notes copy'");

> +static int show(int argc, const char **argv, const char *prefix)

[...]

> +	if (!note)
> +		retval = error("No note found for object %s.",
> +				sha1_to_hex(object));

Minor whitespace issue (replace last TAB with 7 spaces)

> +int cmd_notes(int argc, const char **argv, const char *prefix)
> +{
> +	int result;
> +	const char *override_notes_ref = NULL;
> +	struct option options[] = {
> +		OPT_STRING(0, "ref", &override_notes_ref, "notes_ref",
> +			   "use notes from <notes_ref>"),
> +		OPT_END()
> +	};
> +	git_config(git_default_config, NULL);
> +	argc = parse_options(argc, argv, prefix, options, git_notes_usage,
> +			     PARSE_OPT_STOP_AT_NON_OPTION);

Here, you move --ref from being a "git notes <subcommand>" option to a
"git notes" option (i.e. given _before_ the <subcommand>). There is
nothing wrong with this per se, but it needs to be reflected in
git_notes_usage[] (see my patch below for a proposal).

[...]

> +	if (argc < 1 || !strcmp(argv[0], "list"))
> +		result = list(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "add"))
> +		result = add(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "copy"))
> +		result = copy(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "append") || !strcmp(argv[0], "edit"))
> +		result = append_edit(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "show"))
> +		result = show(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "remove"))
> +		result = remove_cmd(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "prune"))
> +		result = prune(argc, argv, prefix);
> +	else {
> +		result = error("Unknown subcommand: %s", argv[0]);

As Tim Henigan already noted, you need

	usage_with_options(git_notes_usage, options);

If you squash in the following patch (fixes all of my above complaints),
you can add

	Acked-by: Johan Herland <johan@herland.net>

to your commit message. :)

---
 builtin/notes.c  |   77 ++++++++++++++++++++++++++---------------------------
 t/t3301-notes.sh |   11 +++++++
 2 files changed, 49 insertions(+), 39 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index d9dd1f2..e471b28 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -19,14 +19,14 @@
 #include "string-list.h"
 
 static const char * const git_notes_usage[] = {
-	"git notes [list [<object>]]",
-	"git notes add [-f] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]",
-	"git notes copy [-f] <from-object> <to-object>",
-	"git notes append [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]",
-	"git notes edit [<object>]",
-	"git notes show [<object>]",
-	"git notes remove [<object>]",
-	"git notes prune",
+	"git notes [--ref <notes_ref>] [list [<object>]]",
+	"git notes [--ref <notes_ref>] add [-f] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]",
+	"git notes [--ref <notes_ref>] copy [-f] <from-object> <to-object>",
+	"git notes [--ref <notes_ref>] append [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]",
+	"git notes [--ref <notes_ref>] edit [<object>]",
+	"git notes [--ref <notes_ref>] show [<object>]",
+	"git notes [--ref <notes_ref>] remove [<object>]",
+	"git notes [--ref <notes_ref>] prune",
 	NULL
 };
 
@@ -478,7 +478,6 @@ static struct notes_tree *init_notes_check(const char *subcommand)
 
 static int list(int argc, const char **argv, const char *prefix)
 {
-	const char *object_ref;
 	struct notes_tree *t;
 	unsigned char object[20];
 	const unsigned char *note;
@@ -496,18 +495,18 @@ static int list(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_notes_list_usage, options);
 	}
 
-	object_ref = argc ? argv[0] : "HEAD";
-
-	if (get_sha1(object_ref, object))
-		die("Failed to resolve '%s' as a valid ref.", object_ref);
-
 	t = init_notes_check("list");
-	note = get_note(t, object);
-
-	if (note) {
-		puts(sha1_to_hex(note));
-		retval = 0;
-	} else if (argc == 0)
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
 		retval = for_each_note(t, 0, list_each_note, NULL);
 
 	free_notes(t);
@@ -557,10 +556,13 @@ static int add(int argc, const char **argv, const char *prefix)
 	note = get_note(t, object);
 
 	if (note) {
-		if (!force)
-			return	error("Cannot add notes. Found existing notes "
-				      "for object %s. Use '-f' to overwrite "
-				      "existing notes", sha1_to_hex(object));
+		if (!force) {
+			free_notes(t);
+			strbuf_release(&(msg.buf));
+			return error("Cannot add notes. Found existing notes "
+				     "for object %s. Use '-f' to overwrite "
+				     "existing notes", sha1_to_hex(object));
+		}
 		fprintf(stderr, "Overwriting existing notes for object %s\n",
 			sha1_to_hex(object));
 	}
@@ -585,8 +587,7 @@ static int copy(int argc, const char **argv, const char *prefix)
 	int force = 0, from_stdin = 0;
 	const unsigned char *from_note, *note;
 	const char *object_ref;
-	unsigned char object[20], from_obj[20], new_note[20];
-	char logmsg[100];
+	unsigned char object[20], from_obj[20];
 	struct notes_tree *t;
 	const char *rewrite_cmd = NULL;
 	struct option options[] = {
@@ -611,7 +612,7 @@ static int copy(int argc, const char **argv, const char *prefix)
 	}
 
 	if (2 < argc) {
-		error("too few parameters");
+		error("too many parameters");
 		usage_with_options(git_notes_copy_usage, options);
 	}
 
@@ -627,28 +628,25 @@ static int copy(int argc, const char **argv, const char *prefix)
 	note = get_note(t, object);
 
 	if (note) {
-		if (!force)
+		if (!force) {
+			free_notes(t);
 			return error("Cannot copy notes. Found existing notes "
 				     "for object %s. Use '-f' to overwrite "
 				     "existing notes", sha1_to_hex(object));
+		}
 		fprintf(stderr, "Overwriting existing notes for object %s\n",
 			sha1_to_hex(object));
 	}
 
 	from_note = get_note(t, from_obj);
-	if (!from_note)
+	if (!from_note) {
+		free_notes(t);
 		return error("Missing notes on source object %s. Cannot copy.",
 			     sha1_to_hex(from_obj));
-	hashcpy(new_note, from_note);
-
-	if (is_null_sha1(new_note))
-		remove_note(t, object);
-	else
-		add_note(t, object, new_note, combine_notes_overwrite);
+	}
 
-	snprintf(logmsg, sizeof(logmsg), "Notes %s by 'git notes %s'",
-		 is_null_sha1(new_note) ? "removed" : "added", "copy");
-	commit_notes(t, logmsg);
+	add_note(t, object, from_note, combine_notes_overwrite);
+	commit_notes(t, "Notes added by 'git notes copy'");
 	free_notes(t);
 	return 0;
 }
@@ -745,7 +743,7 @@ static int show(int argc, const char **argv, const char *prefix)
 
 	if (!note)
 		retval = error("No note found for object %s.",
-				sha1_to_hex(object));
+			       sha1_to_hex(object));
 	else {
 		const char *show_args[3] = {"show", sha1_to_hex(note), NULL};
 		retval = execv_git_cmd(show_args);
@@ -852,6 +850,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		result = prune(argc, argv, prefix);
 	else {
 		result = error("Unknown subcommand: %s", argv[0]);
+		usage_with_options(git_notes_usage, options);
 	}
 
 	return result ? 1 : 0;
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index a4a0b1d..1d6cd45 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -378,6 +378,17 @@ test_expect_success 'append to existing note with "git notes append"' '
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
1.7.0.207.gac4ec


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
