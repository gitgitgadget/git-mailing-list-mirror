From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/4] Mechanical conversion to use prefixcmp()
Date: Tue, 20 Feb 2007 01:53:29 -0800
Message-ID: <7v3b51xihy.fsf_-_@assigned-by-dhcp.cox.net>
References: <200702191839.05784.andyparkins@gmail.com>
	<7vlkit7vy5.fsf@assigned-by-dhcp.cox.net>
	<200702200942.18654.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 20 10:53:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJRgp-0000Vs-0z
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 10:53:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569AbXBTJxf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 04:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbXBTJxf
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 04:53:35 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:50222 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932569AbXBTJxb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 04:53:31 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070220095331.BIXG1300.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 20 Feb 2007 04:53:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RltV1W0051kojtg0000000; Tue, 20 Feb 2007 04:53:30 -0500
In-Reply-To: <200702200942.18654.andyparkins@gmail.com> (Andy Parkins's
	message of "Tue, 20 Feb 2007 09:42:17 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40221>

This mechanically converts strncmp() to use prefixcmp(), but only when
the parameters match specific patterns, so that they can be verified
easily.  Leftover from this will be fixed in a separate step, including
idiotic conversions like

	if (!strncmp("foo", arg, 3))

  =>

	if (!(-prefixcmp(arg, "foo")))

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This was done by using this script in px.perl

   #!/usr/bin/perl -i.bak -p
   if (/strncmp\(([^,]+), "([^\\"]*)", (\d+)\)/ && (length($2) == $3)) {
           s|strncmp\(([^,]+), "([^\\"]*)", (\d+)\)|prefixcmp($1, "$2")|;
   }
   if (/strncmp\("([^\\"]*)", ([^,]+), (\d+)\)/ && (length($1) == $3)) {
           s|strncmp\("([^\\"]*)", ([^,]+), (\d+)\)|(-prefixcmp($2, "$1"))|;
   }

   and running:

   $ git grep -l strncmp -- '*.c' | xargs perl px.perl

 builtin-apply.c          |   12 ++++++------
 builtin-archive.c        |   10 +++++-----
 builtin-blame.c          |    6 +++---
 builtin-branch.c         |   12 ++++++------
 builtin-checkout-index.c |    4 ++--
 builtin-describe.c       |    6 +++---
 builtin-fmt-merge-msg.c  |   10 +++++-----
 builtin-for-each-ref.c   |    6 +++---
 builtin-fsck.c           |    2 +-
 builtin-grep.c           |    6 +++---
 builtin-init-db.c        |    4 ++--
 builtin-log.c            |   12 ++++++------
 builtin-ls-files.c       |    8 ++++----
 builtin-mailinfo.c       |    2 +-
 builtin-name-rev.c       |    8 ++++----
 builtin-pack-objects.c   |    6 +++---
 builtin-pack-refs.c      |    2 +-
 builtin-push.c           |   18 +++++++++---------
 builtin-read-tree.c      |    4 ++--
 builtin-reflog.c         |    4 ++--
 builtin-rerere.c         |    6 +++---
 builtin-rev-parse.c      |   10 +++++-----
 builtin-shortlog.c       |    6 +++---
 builtin-show-branch.c    |   20 ++++++++++----------
 builtin-show-ref.c       |   12 ++++++------
 builtin-tar-tree.c       |    2 +-
 builtin-unpack-objects.c |    2 +-
 builtin-write-tree.c     |    2 +-
 connect.c                |    6 +++---
 daemon.c                 |   32 ++++++++++++++++----------------
 diff.c                   |   30 +++++++++++++++---------------
 exec_cmd.c               |    2 +-
 fast-import.c            |   42 +++++++++++++++++++++---------------------
 fetch-pack.c             |   12 ++++++------
 git.c                    |   10 +++++-----
 help.c                   |    4 ++--
 http-fetch.c             |    2 +-
 http-push.c              |    8 ++++----
 index-pack.c             |    4 ++--
 peek-remote.c            |    4 ++--
 receive-pack.c           |    4 ++--
 refs.c                   |    8 ++++----
 revision.c               |   30 +++++++++++++++---------------
 send-pack.c              |    4 ++--
 setup.c                  |    2 +-
 shell.c                  |    2 +-
 upload-pack.c            |   10 +++++-----
 wt-status.c              |    4 ++--
 48 files changed, 211 insertions(+), 211 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index abe3538..d678178 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1129,11 +1129,11 @@ static struct fragment *parse_binary_hunk(char **buf_p,
 
 	*status_p = 0;
 
-	if (!strncmp(buffer, "delta ", 6)) {
+	if (!prefixcmp(buffer, "delta ")) {
 		patch_method = BINARY_DELTA_DEFLATED;
 		origlen = strtoul(buffer + 6, NULL, 10);
 	}
-	else if (!strncmp(buffer, "literal ", 8)) {
+	else if (!prefixcmp(buffer, "literal ")) {
 		patch_method = BINARY_LITERAL_DEFLATED;
 		origlen = strtoul(buffer + 8, NULL, 10);
 	}
@@ -2608,14 +2608,14 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 			read_stdin = 0;
 			continue;
 		}
-		if (!strncmp(arg, "--exclude=", 10)) {
+		if (!prefixcmp(arg, "--exclude=")) {
 			struct excludes *x = xmalloc(sizeof(*x));
 			x->path = arg + 10;
 			x->next = excludes;
 			excludes = x;
 			continue;
 		}
-		if (!strncmp(arg, "-p", 2)) {
+		if (!prefixcmp(arg, "-p")) {
 			p_value = atoi(arg + 2);
 			continue;
 		}
@@ -2669,13 +2669,13 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 			line_termination = 0;
 			continue;
 		}
-		if (!strncmp(arg, "-C", 2)) {
+		if (!prefixcmp(arg, "-C")) {
 			p_context = strtoul(arg + 2, &end, 0);
 			if (*end != '\0')
 				die("unrecognized context count '%s'", arg + 2);
 			continue;
 		}
-		if (!strncmp(arg, "--whitespace=", 13)) {
+		if (!prefixcmp(arg, "--whitespace=")) {
 			whitespace_option = arg + 13;
 			parse_whitespace_option(arg + 13);
 			continue;
diff --git a/builtin-archive.c b/builtin-archive.c
index f613ac2..0c56de0 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -35,7 +35,7 @@ static int run_remote_archiver(const char *remote, int argc,
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
-		if (!strncmp("--exec=", arg, 7)) {
+		if (!(-prefixcmp(arg, "--exec="))) {
 			if (exec_at)
 				die("multiple --exec specified");
 			exec = arg + 7;
@@ -62,7 +62,7 @@ static int run_remote_archiver(const char *remote, int argc,
 	if (buf[len-1] == '\n')
 		buf[--len] = 0;
 	if (strcmp(buf, "ACK")) {
-		if (len > 5 && !strncmp(buf, "NACK ", 5))
+		if (len > 5 && !prefixcmp(buf, "NACK "))
 			die("git-archive: NACK %s", buf + 5);
 		die("git-archive: protocol error");
 	}
@@ -166,11 +166,11 @@ int parse_archive_args(int argc, const char **argv, struct archiver *ar)
 			verbose = 1;
 			continue;
 		}
-		if (!strncmp(arg, "--format=", 9)) {
+		if (!prefixcmp(arg, "--format=")) {
 			format = arg + 9;
 			continue;
 		}
-		if (!strncmp(arg, "--prefix=", 9)) {
+		if (!prefixcmp(arg, "--prefix=")) {
 			base = arg + 9;
 			continue;
 		}
@@ -218,7 +218,7 @@ static const char *extract_remote_arg(int *ac, const char **av)
 		if (!strcmp(arg, "--"))
 			no_more_options = 1;
 		if (!no_more_options) {
-			if (!strncmp(arg, "--remote=", 9)) {
+			if (!prefixcmp(arg, "--remote=")) {
 				if (remote)
 					die("Multiple --remote specified");
 				remote = arg + 9;
diff --git a/builtin-blame.c b/builtin-blame.c
index 5669a16..db311bf 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2097,17 +2097,17 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 			output_option |= OUTPUT_LONG_OBJECT_NAME;
 		else if (!strcmp("-S", arg) && ++i < argc)
 			revs_file = argv[i];
-		else if (!strncmp("-M", arg, 2)) {
+		else if (!(-prefixcmp(arg, "-M"))) {
 			opt |= PICKAXE_BLAME_MOVE;
 			blame_move_score = parse_score(arg+2);
 		}
-		else if (!strncmp("-C", arg, 2)) {
+		else if (!(-prefixcmp(arg, "-C"))) {
 			if (opt & PICKAXE_BLAME_COPY)
 				opt |= PICKAXE_BLAME_COPY_HARDER;
 			opt |= PICKAXE_BLAME_COPY | PICKAXE_BLAME_MOVE;
 			blame_copy_score = parse_score(arg+2);
 		}
-		else if (!strncmp("-L", arg, 2)) {
+		else if (!(-prefixcmp(arg, "-L"))) {
 			if (!arg[2]) {
 				if (++i >= argc)
 					usage(blame_usage);
diff --git a/builtin-branch.c b/builtin-branch.c
index d0e7209..d0179b0 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -59,7 +59,7 @@ int git_branch_config(const char *var, const char *value)
 		branch_use_color = git_config_colorbool(var, value);
 		return 0;
 	}
-	if (!strncmp(var, "color.branch.", 13)) {
+	if (!prefixcmp(var, "color.branch.")) {
 		int slot = parse_branch_color_slot(var, 13);
 		color_parse(value, var, branch_colors[slot]);
 		return 0;
@@ -178,13 +178,13 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	int len;
 
 	/* Detect kind */
-	if (!strncmp(refname, "refs/heads/", 11)) {
+	if (!prefixcmp(refname, "refs/heads/")) {
 		kind = REF_LOCAL_BRANCH;
 		refname += 11;
-	} else if (!strncmp(refname, "refs/remotes/", 13)) {
+	} else if (!prefixcmp(refname, "refs/remotes/")) {
 		kind = REF_REMOTE_BRANCH;
 		refname += 13;
-	} else if (!strncmp(refname, "refs/tags/", 10)) {
+	} else if (!prefixcmp(refname, "refs/tags/")) {
 		kind = REF_TAG;
 		refname += 10;
 	}
@@ -446,7 +446,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			reflog = 1;
 			continue;
 		}
-		if (!strncmp(arg, "--abbrev=", 9)) {
+		if (!prefixcmp(arg, "--abbrev=")) {
 			abbrev = atoi(arg+9);
 			continue;
 		}
@@ -476,7 +476,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		detached = 1;
 	}
 	else {
-		if (strncmp(head, "refs/heads/", 11))
+		if (prefixcmp(head, "refs/heads/"))
 			die("HEAD not found below refs/heads!");
 		head += 11;
 	}
diff --git a/builtin-checkout-index.c b/builtin-checkout-index.c
index b097c88..afe4b0e 100644
--- a/builtin-checkout-index.c
+++ b/builtin-checkout-index.c
@@ -223,12 +223,12 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 			to_tempfile = 1;
 			continue;
 		}
-		if (!strncmp(arg, "--prefix=", 9)) {
+		if (!prefixcmp(arg, "--prefix=")) {
 			state.base_dir = arg+9;
 			state.base_dir_len = strlen(state.base_dir);
 			continue;
 		}
-		if (!strncmp(arg, "--stage=", 8)) {
+		if (!prefixcmp(arg, "--stage=")) {
 			if (!strcmp(arg + 8, "all")) {
 				to_tempfile = 1;
 				checkout_stage = CHECKOUT_ALL;
diff --git a/builtin-describe.c b/builtin-describe.c
index bcc6456..165917e 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -52,7 +52,7 @@ static int get_name(const char *path, const unsigned char *sha1, int flag, void
 	 * If --tags, then any tags are used.
 	 * Otherwise only annotated tags are used.
 	 */
-	if (!strncmp(path, "refs/tags/", 10)) {
+	if (!prefixcmp(path, "refs/tags/")) {
 		if (object->type == OBJ_TAG)
 			prio = 2;
 		else
@@ -254,12 +254,12 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			all = 1;
 		else if (!strcmp(arg, "--tags"))
 			tags = 1;
-		else if (!strncmp(arg, "--abbrev=", 9)) {
+		else if (!prefixcmp(arg, "--abbrev=")) {
 			abbrev = strtoul(arg + 9, NULL, 10);
 			if (abbrev != 0 && (abbrev < MINIMUM_ABBREV || 40 < abbrev))
 				abbrev = DEFAULT_ABBREV;
 		}
-		else if (!strncmp(arg, "--candidates=", 13)) {
+		else if (!prefixcmp(arg, "--candidates=")) {
 			max_candidates = strtoul(arg + 13, NULL, 10);
 			if (max_candidates < 1)
 				max_candidates = 1;
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index 87d3d63..1489883 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -81,7 +81,7 @@ static int handle_line(char *line)
 	if (len < 43 || line[40] != '\t')
 		return 1;
 
-	if (!strncmp(line + 41, "not-for-merge", 13))
+	if (!prefixcmp(line + 41, "not-for-merge"))
 		return 0;
 
 	if (line[41] != '\t')
@@ -119,15 +119,15 @@ static int handle_line(char *line)
 	if (pulling_head) {
 		origin = xstrdup(src);
 		src_data->head_status |= 1;
-	} else if (!strncmp(line, "branch ", 7)) {
+	} else if (!prefixcmp(line, "branch ")) {
 		origin = xstrdup(line + 7);
 		append_to_list(&src_data->branch, origin, NULL);
 		src_data->head_status |= 2;
-	} else if (!strncmp(line, "tag ", 4)) {
+	} else if (!prefixcmp(line, "tag ")) {
 		origin = line;
 		append_to_list(&src_data->tag, xstrdup(origin + 4), NULL);
 		src_data->head_status |= 2;
-	} else if (!strncmp(line, "remote branch ", 14)) {
+	} else if (!prefixcmp(line, "remote branch ")) {
 		origin = xstrdup(line + 14);
 		append_to_list(&src_data->r_branch, origin, NULL);
 		src_data->head_status |= 2;
@@ -280,7 +280,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 	current_branch = resolve_ref("HEAD", head_sha1, 1, NULL);
 	if (!current_branch)
 		die("No current branch");
-	if (!strncmp(current_branch, "refs/heads/", 11))
+	if (!prefixcmp(current_branch, "refs/heads/"))
 		current_branch += 11;
 
 	while (fgets(line, sizeof(line), in)) {
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 16c785f..ac0b9f6 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -814,7 +814,7 @@ int cmd_for_each_ref(int ac, const char **av, char *prefix)
 			i++;
 			break;
 		}
-		if (!strncmp(arg, "--format=", 9)) {
+		if (!prefixcmp(arg, "--format=")) {
 			if (format)
 				die("more than one --format?");
 			format = arg + 9;
@@ -844,7 +844,7 @@ int cmd_for_each_ref(int ac, const char **av, char *prefix)
 			quote_style = QUOTE_TCL;
 			continue;
 		}
-		if (!strncmp(arg, "--count=", 8)) {
+		if (!prefixcmp(arg, "--count=")) {
 			if (maxcount)
 				die("more than one --count?");
 			maxcount = atoi(arg + 8);
@@ -852,7 +852,7 @@ int cmd_for_each_ref(int ac, const char **av, char *prefix)
 				die("The number %s did not parse", arg);
 			continue;
 		}
-		if (!strncmp(arg, "--sort=", 7)) {
+		if (!prefixcmp(arg, "--sort=")) {
 			struct ref_sort *s = xcalloc(1, sizeof(*s));
 			int len;
 
diff --git a/builtin-fsck.c b/builtin-fsck.c
index 6da3814..6abf498 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -546,7 +546,7 @@ static int fsck_head_link(void)
 
 	if (!head_points_at || !(flag & REF_ISSYMREF))
 		return error("HEAD is not a symbolic ref");
-	if (strncmp(head_points_at, "refs/heads/", 11))
+	if (prefixcmp(head_points_at, "refs/heads/"))
 		return error("HEAD points to something strange (%s)",
 			     head_points_at);
 	if (is_null_sha1(sha1))
diff --git a/builtin-grep.c b/builtin-grep.c
index 2bfbdb7..cec2204 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -527,9 +527,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			opt.word_regexp = 1;
 			continue;
 		}
-		if (!strncmp("-A", arg, 2) ||
-		    !strncmp("-B", arg, 2) ||
-		    !strncmp("-C", arg, 2) ||
+		if (!(-prefixcmp(arg, "-A")) ||
+		    !(-prefixcmp(arg, "-B")) ||
+		    !(-prefixcmp(arg, "-C")) ||
 		    (arg[0] == '-' && '1' <= arg[1] && arg[1] <= '9')) {
 			unsigned num;
 			const char *scan;
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 12e43d0..4df9fd0 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -283,11 +283,11 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 
 	for (i = 1; i < argc; i++, argv++) {
 		const char *arg = argv[1];
-		if (!strncmp(arg, "--template=", 11))
+		if (!prefixcmp(arg, "--template="))
 			template_dir = arg+11;
 		else if (!strcmp(arg, "--shared"))
 			shared_repository = PERM_GROUP;
-		else if (!strncmp(arg, "--shared=", 9))
+		else if (!prefixcmp(arg, "--shared="))
 			shared_repository = git_config_perm("arg", arg+9);
 		else
 			usage(init_db_usage);
diff --git a/builtin-log.c b/builtin-log.c
index af2de54..ad1e8c0 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -32,7 +32,7 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		rev->always_show_header = 0;
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
-		if (!strncmp(arg, "--encoding=", 11)) {
+		if (!prefixcmp(arg, "--encoding=")) {
 			arg += 11;
 			if (strcmp(arg, "none"))
 				git_log_output_encoding = strdup(arg);
@@ -287,7 +287,7 @@ static void reopen_stdout(struct commit *commit, int nr, int keep_subject)
 
 		sol += 2;
 		/* strip [PATCH] or [PATCH blabla] */
-		if (!keep_subject && !strncmp(sol, "[PATCH", 6)) {
+		if (!keep_subject && !prefixcmp(sol, "[PATCH")) {
 			char *eos = strchr(sol + 6, ']');
 			if (eos) {
 				while (isspace(*eos))
@@ -435,7 +435,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(argv[i], "-n") ||
 				!strcmp(argv[i], "--numbered"))
 			numbered = 1;
-		else if (!strncmp(argv[i], "--start-number=", 15))
+		else if (!prefixcmp(argv[i], "--start-number="))
 			start_number = strtol(argv[i] + 15, NULL, 10);
 		else if (!strcmp(argv[i], "--start-number")) {
 			i++;
@@ -471,13 +471,13 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		}
 		else if (!strcmp(argv[i], "--attach"))
 			rev.mime_boundary = git_version_string;
-		else if (!strncmp(argv[i], "--attach=", 9))
+		else if (!prefixcmp(argv[i], "--attach="))
 			rev.mime_boundary = argv[i] + 9;
 		else if (!strcmp(argv[i], "--ignore-if-in-upstream"))
 			ignore_if_in_upstream = 1;
 		else if (!strcmp(argv[i], "--thread"))
 			thread = 1;
-		else if (!strncmp(argv[i], "--in-reply-to=", 14))
+		else if (!prefixcmp(argv[i], "--in-reply-to="))
 			in_reply_to = argv[i] + 14;
 		else if (!strcmp(argv[i], "--in-reply-to")) {
 			i++;
@@ -485,7 +485,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 				die("Need a Message-Id for --in-reply-to");
 			in_reply_to = argv[i];
 		}
-		else if (!strncmp(argv[i], "--suffix=", 9))
+		else if (!prefixcmp(argv[i], "--suffix="))
 			fmt_patch_suffix = argv[i] + 9;
 		else
 			argv[j++] = argv[i];
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index ac89eb2..4e1d5af 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -406,7 +406,7 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 			add_exclude(argv[++i], "", 0, &dir.exclude_list[EXC_CMDL]);
 			continue;
 		}
-		if (!strncmp(arg, "--exclude=", 10)) {
+		if (!prefixcmp(arg, "--exclude=")) {
 			exc_given = 1;
 			add_exclude(arg+10, "", 0, &dir.exclude_list[EXC_CMDL]);
 			continue;
@@ -416,12 +416,12 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 			add_excludes_from_file(&dir, argv[++i]);
 			continue;
 		}
-		if (!strncmp(arg, "--exclude-from=", 15)) {
+		if (!prefixcmp(arg, "--exclude-from=")) {
 			exc_given = 1;
 			add_excludes_from_file(&dir, arg+15);
 			continue;
 		}
-		if (!strncmp(arg, "--exclude-per-directory=", 24)) {
+		if (!prefixcmp(arg, "--exclude-per-directory=")) {
 			exc_given = 1;
 			dir.exclude_per_dir = arg + 24;
 			continue;
@@ -434,7 +434,7 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 			error_unmatch = 1;
 			continue;
 		}
-		if (!strncmp(arg, "--abbrev=", 9)) {
+		if (!prefixcmp(arg, "--abbrev=")) {
 			abbrev = strtoul(arg+9, NULL, 10);
 			if (abbrev && abbrev < MINIMUM_ABBREV)
 				abbrev = MINIMUM_ABBREV;
diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 583da38..6ee6b0b 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -811,7 +811,7 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 			metainfo_charset = def_charset;
 		else if (!strcmp(argv[1], "-n"))
 			metainfo_charset = NULL;
-		else if (!strncmp(argv[1], "--encoding=", 11))
+		else if (!prefixcmp(argv[1], "--encoding="))
 			metainfo_charset = argv[1] + 11;
 		else
 			usage(mailinfo_usage);
diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index 36f1ba6..2c3d14c 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -85,7 +85,7 @@ static int name_ref(const char *path, const unsigned char *sha1, int flags, void
 	struct name_ref_data *data = cb_data;
 	int deref = 0;
 
-	if (data->tags_only && strncmp(path, "refs/tags/", 10))
+	if (data->tags_only && prefixcmp(path, "refs/tags/"))
 		return 0;
 
 	if (data->ref_filter && fnmatch(data->ref_filter, path, 0))
@@ -101,9 +101,9 @@ static int name_ref(const char *path, const unsigned char *sha1, int flags, void
 	if (o && o->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)o;
 
-		if (!strncmp(path, "refs/heads/", 11))
+		if (!prefixcmp(path, "refs/heads/"))
 			path = path + 11;
-		else if (!strncmp(path, "refs/", 5))
+		else if (!prefixcmp(path, "refs/"))
 			path = path + 5;
 
 		name_rev(commit, xstrdup(path), 0, 0, deref);
@@ -156,7 +156,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 			} else if (!strcmp(*argv, "--tags")) {
 				data.tags_only = 1;
 				continue;
-			} else  if (!strncmp(*argv, "--refs=", 7)) {
+			} else  if (!prefixcmp(*argv, "--refs=")) {
 				data.ref_filter = *argv + 7;
 				continue;
 			} else if (!strcmp(*argv, "--all")) {
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 3824ee3..71113d8 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1579,14 +1579,14 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			incremental = 1;
 			continue;
 		}
-		if (!strncmp("--window=", arg, 9)) {
+		if (!(-prefixcmp(arg, "--window="))) {
 			char *end;
 			window = strtoul(arg+9, &end, 0);
 			if (!arg[9] || *end)
 				usage(pack_usage);
 			continue;
 		}
-		if (!strncmp("--depth=", arg, 8)) {
+		if (!(-prefixcmp(arg, "--depth="))) {
 			char *end;
 			depth = strtoul(arg+8, &end, 0);
 			if (!arg[8] || *end)
@@ -1622,7 +1622,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		if (!strcmp("--unpacked", arg) ||
-		    !strncmp("--unpacked=", arg, 11) ||
+		    !(-prefixcmp(arg, "--unpacked=")) ||
 		    !strcmp("--reflog", arg) ||
 		    !strcmp("--all", arg)) {
 			use_internal_rev_list = 1;
diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
index 3de9b3e..d080e30 100644
--- a/builtin-pack-refs.c
+++ b/builtin-pack-refs.c
@@ -36,7 +36,7 @@ static int handle_one_ref(const char *path, const unsigned char *sha1,
 	/* Do not pack the symbolic refs */
 	if ((flags & REF_ISSYMREF))
 		return 0;
-	is_tag_ref = !strncmp(path, "refs/tags/", 10);
+	is_tag_ref = !prefixcmp(path, "refs/tags/");
 
 	/* ALWAYS pack refs that were already packed or are tags */
 	if (!cb->all && !is_tag_ref && !(flags & REF_ISPACKED))
diff --git a/builtin-push.c b/builtin-push.c
index c45649e..2b98ba3 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -32,7 +32,7 @@ static int expand_one_ref(const char *ref, const unsigned char *sha1, int flag,
 	/* Ignore the "refs/" at the beginning of the refname */
 	ref += 5;
 
-	if (!strncmp(ref, "tags/", 5))
+	if (!prefixcmp(ref, "tags/"))
 		add_refspec(xstrdup(ref));
 	return 0;
 }
@@ -149,10 +149,10 @@ static int get_remotes_uri(const char *repo, const char *uri[MAX_URI])
 		int is_refspec;
 		char *s, *p;
 
-		if (!strncmp("URL:", buffer, 4)) {
+		if (!(-prefixcmp(buffer, "URL:"))) {
 			is_refspec = 0;
 			s = buffer + 4;
-		} else if (!strncmp("Push:", buffer, 5)) {
+		} else if (!(-prefixcmp(buffer, "Push:"))) {
 			is_refspec = 1;
 			s = buffer + 5;
 		} else
@@ -195,7 +195,7 @@ static int config_get_receivepack;
 
 static int get_remote_config(const char* key, const char* value)
 {
-	if (!strncmp(key, "remote.", 7) &&
+	if (!prefixcmp(key, "remote.") &&
 	    !strncmp(key + 7, config_repo, config_repo_len)) {
 		if (!strcmp(key + 7 + config_repo_len, ".url")) {
 			if (config_current_uri < MAX_URI)
@@ -324,8 +324,8 @@ static int do_push(const char *repo)
 		const char **dest_refspec = refspec;
 		const char *dest = uri[i];
 		const char *sender = "git-send-pack";
-		if (!strncmp(dest, "http://", 7) ||
-		    !strncmp(dest, "https://", 8))
+		if (!prefixcmp(dest, "http://") ||
+		    !prefixcmp(dest, "https://"))
 			sender = "git-http-push";
 		else if (thin)
 			argv[dest_argc++] = "--thin";
@@ -373,7 +373,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 			verbose=1;
 			continue;
 		}
-		if (!strncmp(arg, "--repo=", 7)) {
+		if (!prefixcmp(arg, "--repo=")) {
 			repo = arg+7;
 			continue;
 		}
@@ -397,11 +397,11 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 			thin = 0;
 			continue;
 		}
-		if (!strncmp(arg, "--receive-pack=", 15)) {
+		if (!prefixcmp(arg, "--receive-pack=")) {
 			receivepack = arg;
 			continue;
 		}
-		if (!strncmp(arg, "--exec=", 7)) {
+		if (!prefixcmp(arg, "--exec=")) {
 			receivepack = arg;
 			continue;
 		}
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 8ba436d..e477155 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -133,7 +133,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 		 *  entries and put the entries from the tree under the
 		 * given subdirectory.
 		 */
-		if (!strncmp(arg, "--prefix=", 9)) {
+		if (!prefixcmp(arg, "--prefix=")) {
 			if (stage || opts.merge || opts.prefix)
 				usage(read_tree_usage);
 			opts.prefix = arg + 9;
@@ -179,7 +179,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 			continue;
 		}
 
-		if (!strncmp(arg, "--exclude-per-directory=", 24)) {
+		if (!prefixcmp(arg, "--exclude-per-directory=")) {
 			struct dir_struct *dir;
 
 			if (opts.dir)
diff --git a/builtin-reflog.c b/builtin-reflog.c
index 3415551..cefb40d 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -321,9 +321,9 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		const char *arg = argv[i];
 		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
 			cb.dry_run = 1;
-		else if (!strncmp(arg, "--expire=", 9))
+		else if (!prefixcmp(arg, "--expire="))
 			cb.expire_total = approxidate(arg + 9);
-		else if (!strncmp(arg, "--expire-unreachable=", 21))
+		else if (!prefixcmp(arg, "--expire-unreachable="))
 			cb.expire_unreachable = approxidate(arg + 21);
 		else if (!strcmp(arg, "--stale-fix"))
 			cb.stalefix = 1;
diff --git a/builtin-rerere.c b/builtin-rerere.c
index 318d959..978105b 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -105,11 +105,11 @@ static int handle_file(const char *path,
 		SHA1_Init(&ctx);
 
 	while (fgets(buf, sizeof(buf), f)) {
-		if (!strncmp("<<<<<<< ", buf, 8))
+		if (!(-prefixcmp(buf, "<<<<<<< ")))
 			hunk = 1;
-		else if (!strncmp("=======", buf, 7))
+		else if (!(-prefixcmp(buf, "=======")))
 			hunk = 2;
-		else if (!strncmp(">>>>>>> ", buf, 8)) {
+		else if (!(-prefixcmp(buf, ">>>>>>> "))) {
 			hunk_no++;
 			hunk = 0;
 			if (memcmp(one->ptr, two->ptr, one->nr < two->nr ?
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index d53deaa..a1c3411 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -274,7 +274,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--short") ||
-			    !strncmp(arg, "--short=", 8)) {
+			    !prefixcmp(arg, "--short=")) {
 				filter &= ~(DO_FLAGS|DO_NOREV);
 				verify = 1;
 				abbrev = DEFAULT_ABBREV;
@@ -352,19 +352,19 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 						: "false");
 				continue;
 			}
-			if (!strncmp(arg, "--since=", 8)) {
+			if (!prefixcmp(arg, "--since=")) {
 				show_datestring("--max-age=", arg+8);
 				continue;
 			}
-			if (!strncmp(arg, "--after=", 8)) {
+			if (!prefixcmp(arg, "--after=")) {
 				show_datestring("--max-age=", arg+8);
 				continue;
 			}
-			if (!strncmp(arg, "--before=", 9)) {
+			if (!prefixcmp(arg, "--before=")) {
 				show_datestring("--min-age=", arg+9);
 				continue;
 			}
-			if (!strncmp(arg, "--until=", 8)) {
+			if (!prefixcmp(arg, "--until=")) {
 				show_datestring("--min-age=", arg+8);
 				continue;
 			}
diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index edb4042..2f71a2a 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -124,7 +124,7 @@ static void insert_author_oneline(struct path_list *list,
 	else
 		free(buffer);
 
-	if (!strncmp(oneline, "[PATCH", 6)) {
+	if (!prefixcmp(oneline, "[PATCH")) {
 		char *eob = strchr(oneline, ']');
 
 		if (eob) {
@@ -179,7 +179,7 @@ static void read_from_stdin(struct path_list *list)
 	while (fgets(buffer, sizeof(buffer), stdin) != NULL) {
 		char *bob;
 		if ((buffer[0] == 'A' || buffer[0] == 'a') &&
-				!strncmp(buffer + 1, "uthor: ", 7) &&
+				!prefixcmp(buffer + 1, "uthor: ") &&
 				(bob = strchr(buffer + 7, '<')) != NULL) {
 			char buffer2[1024], offset = 0;
 
@@ -230,7 +230,7 @@ static void get_from_rev(struct rev_info *rev, struct path_list *list)
 			else
 				eol++;
 
-			if (!strncmp(buffer, "author ", 7)) {
+			if (!prefixcmp(buffer, "author ")) {
 				char *bracket = strchr(buffer, '<');
 
 				if (bracket == NULL || bracket > eol)
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 0d94e40..bf6aee4 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -266,7 +266,7 @@ static void show_one_commit(struct commit *commit, int no_name)
 				    pretty, sizeof(pretty), 0, NULL, NULL, 0);
 	else
 		strcpy(pretty, "(unavailable)");
-	if (!strncmp(pretty, "[PATCH] ", 8))
+	if (!prefixcmp(pretty, "[PATCH] "))
 		cp = pretty + 8;
 	else
 		cp = pretty;
@@ -404,7 +404,7 @@ static int append_remote_ref(const char *refname, const unsigned char *sha1, int
 
 static int append_tag_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
-	if (strncmp(refname, "refs/tags/", 10))
+	if (prefixcmp(refname, "refs/tags/"))
 		return 0;
 	return append_ref(refname + 5, sha1, 0);
 }
@@ -435,9 +435,9 @@ static int append_matching_ref(const char *refname, const unsigned char *sha1, i
 		return 0;
 	if (fnmatch(match_ref_pattern, tail, 0))
 		return 0;
-	if (!strncmp("refs/heads/", refname, 11))
+	if (!(-prefixcmp(refname, "refs/heads/")))
 		return append_head_ref(refname, sha1, flag, cb_data);
-	if (!strncmp("refs/tags/", refname, 10))
+	if (!(-prefixcmp(refname, "refs/tags/")))
 		return append_tag_ref(refname, sha1, flag, cb_data);
 	return append_ref(refname, sha1, 0);
 }
@@ -462,11 +462,11 @@ static int rev_is_head(char *head, int headlen, char *name,
 	if ((!head[0]) ||
 	    (head_sha1 && sha1 && hashcmp(head_sha1, sha1)))
 		return 0;
-	if (!strncmp(head, "refs/heads/", 11))
+	if (!prefixcmp(head, "refs/heads/"))
 		head += 11;
-	if (!strncmp(name, "refs/heads/", 11))
+	if (!prefixcmp(name, "refs/heads/"))
 		name += 11;
-	else if (!strncmp(name, "heads/", 6))
+	else if (!prefixcmp(name, "heads/"))
 		name += 6;
 	return !strcmp(head, name);
 }
@@ -635,7 +635,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			with_current_branch = 1;
 		else if (!strcmp(arg, "--sha1-name"))
 			sha1_name = 1;
-		else if (!strncmp(arg, "--more=", 7))
+		else if (!prefixcmp(arg, "--more="))
 			extra = atoi(arg + 7);
 		else if (!strcmp(arg, "--merge-base"))
 			merge_base = 1;
@@ -652,9 +652,9 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		else if (!strcmp(arg, "--reflog") || !strcmp(arg, "-g")) {
 			reflog = DEFAULT_REFLOG;
 		}
-		else if (!strncmp(arg, "--reflog=", 9))
+		else if (!prefixcmp(arg, "--reflog="))
 			parse_reflog_param(arg + 9, &reflog, &reflog_base);
-		else if (!strncmp(arg, "-g=", 3))
+		else if (!prefixcmp(arg, "-g="))
 			parse_reflog_param(arg + 3, &reflog, &reflog_base);
 		else
 			usage(show_branch_usage);
diff --git a/builtin-show-ref.c b/builtin-show-ref.c
index 853f13f..ae0eddd 100644
--- a/builtin-show-ref.c
+++ b/builtin-show-ref.c
@@ -28,8 +28,8 @@ static int show_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	if (tags_only || heads_only) {
 		int match;
 
-		match = heads_only && !strncmp(refname, "refs/heads/", 11);
-		match |= tags_only && !strncmp(refname, "refs/tags/", 10);
+		match = heads_only && !prefixcmp(refname, "refs/heads/");
+		match |= tags_only && !prefixcmp(refname, "refs/tags/");
 		if (!match)
 			return 0;
 	}
@@ -178,8 +178,8 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
 			hash_only = 1;
 			continue;
 		}
-		if (!strncmp(arg, "--hash=", 7) ||
-		    (!strncmp(arg, "--abbrev", 8) &&
+		if (!prefixcmp(arg, "--hash=") ||
+		    (!prefixcmp(arg, "--abbrev") &&
 		     (arg[8] == '=' || arg[8] == '\0'))) {
 			if (arg[2] != 'h' && !arg[8])
 				/* --abbrev only */
@@ -215,7 +215,7 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
 		}
 		if (!strcmp(arg, "--exclude-existing"))
 			return exclude_existing(NULL);
-		if (!strncmp(arg, "--exclude-existing=", 19))
+		if (!prefixcmp(arg, "--exclude-existing="))
 			return exclude_existing(arg + 19);
 		usage(show_ref_usage);
 	}
@@ -224,7 +224,7 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
 		unsigned char sha1[20];
 
 		while (*pattern) {
-			if (!strncmp(*pattern, "refs/", 5) &&
+			if (!prefixcmp(*pattern, "refs/") &&
 			    resolve_ref(*pattern, sha1, 1, NULL)) {
 				if (!quiet)
 					show_one(*pattern, sha1);
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index 8055dda..28f8c1c 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -31,7 +31,7 @@ int cmd_tar_tree(int argc, const char **argv, const char *prefix)
 	nargv[nargc++] = "git-archive";
 	nargv[nargc++] = "--format=tar";
 
-	if (2 <= argc && !strncmp("--remote=", argv[1], 9)) {
+	if (2 <= argc && !(-prefixcmp(argv[1], "--remote="))) {
 		nargv[nargc++] = argv[1];
 		argv++;
 		argc--;
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index d351e02..8f8e898 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -369,7 +369,7 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 				recover = 1;
 				continue;
 			}
-			if (!strncmp(arg, "--pack_header=", 14)) {
+			if (!prefixcmp(arg, "--pack_header=")) {
 				struct pack_header *hdr;
 				char *c;
 
diff --git a/builtin-write-tree.c b/builtin-write-tree.c
index 50670dc..90fc1cf 100644
--- a/builtin-write-tree.c
+++ b/builtin-write-tree.c
@@ -70,7 +70,7 @@ int cmd_write_tree(int argc, const char **argv, const char *unused_prefix)
 		const char *arg = argv[1];
 		if (!strcmp(arg, "--missing-ok"))
 			missing_ok = 1;
-		else if (!strncmp(arg, "--prefix=", 9))
+		else if (!prefixcmp(arg, "--prefix="))
 			prefix = arg + 9;
 		else
 			usage(write_tree_usage);
diff --git a/connect.c b/connect.c
index 7844888..8a8a13b 100644
--- a/connect.c
+++ b/connect.c
@@ -96,7 +96,7 @@ int get_ack(int fd, unsigned char *result_sha1)
 		line[--len] = 0;
 	if (!strcmp(line, "NAK"))
 		return 0;
-	if (!strncmp(line, "ACK ", 4)) {
+	if (!prefixcmp(line, "ACK ")) {
 		if (!get_sha1_hex(line+4, result_sha1)) {
 			if (strstr(line+45, "continue"))
 				return 2;
@@ -196,8 +196,8 @@ static int count_refspec_match(const char *pattern,
 		 */
 		if (namelen != patlen &&
 		    patlen != namelen - 5 &&
-		    strncmp(name, "refs/heads/", 11) &&
-		    strncmp(name, "refs/tags/", 10)) {
+		    prefixcmp(name, "refs/heads/") &&
+		    prefixcmp(name, "refs/tags/")) {
 			/* We want to catch the case where only weak
 			 * matches are found and there are multiple
 			 * matches, and where more than one strong
diff --git a/daemon.c b/daemon.c
index 66f8d6f..cdbc23f 100644
--- a/daemon.c
+++ b/daemon.c
@@ -286,7 +286,7 @@ static int service_enabled;
 
 static int git_daemon_config(const char *var, const char *value)
 {
-	if (!strncmp(var, "daemon.", 7) &&
+	if (!prefixcmp(var, "daemon.") &&
 	    !strcmp(var + 7, service_looking_at->config_name)) {
 		service_enabled = git_config_bool(var, value);
 		return 0;
@@ -562,7 +562,7 @@ static int execute(struct sockaddr *addr)
 	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
 		struct daemon_service *s = &(daemon_service[i]);
 		int namelen = strlen(s->name);
-		if (!strncmp("git-", line, 4) &&
+		if (!(-prefixcmp(line, "git-")) &&
 		    !strncmp(s->name, line + 4, namelen) &&
 		    line[namelen + 4] == ' ') {
 			/*
@@ -1011,7 +1011,7 @@ int main(int argc, char **argv)
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
 
-		if (!strncmp(arg, "--listen=", 9)) {
+		if (!prefixcmp(arg, "--listen=")) {
 		    char *p = arg + 9;
 		    char *ph = listen_addr = xmalloc(strlen(arg + 9) + 1);
 		    while (*p)
@@ -1019,7 +1019,7 @@ int main(int argc, char **argv)
 		    *ph = 0;
 		    continue;
 		}
-		if (!strncmp(arg, "--port=", 7)) {
+		if (!prefixcmp(arg, "--port=")) {
 			char *end;
 			unsigned long n;
 			n = strtoul(arg+7, &end, 0);
@@ -1045,11 +1045,11 @@ int main(int argc, char **argv)
 			export_all_trees = 1;
 			continue;
 		}
-		if (!strncmp(arg, "--timeout=", 10)) {
+		if (!prefixcmp(arg, "--timeout=")) {
 			timeout = atoi(arg+10);
 			continue;
 		}
-		if (!strncmp(arg, "--init-timeout=", 15)) {
+		if (!prefixcmp(arg, "--init-timeout=")) {
 			init_timeout = atoi(arg+15);
 			continue;
 		}
@@ -1057,11 +1057,11 @@ int main(int argc, char **argv)
 			strict_paths = 1;
 			continue;
 		}
-		if (!strncmp(arg, "--base-path=", 12)) {
+		if (!prefixcmp(arg, "--base-path=")) {
 			base_path = arg+12;
 			continue;
 		}
-		if (!strncmp(arg, "--interpolated-path=", 20)) {
+		if (!prefixcmp(arg, "--interpolated-path=")) {
 			interpolated_path = arg+20;
 			continue;
 		}
@@ -1073,11 +1073,11 @@ int main(int argc, char **argv)
 			user_path = "";
 			continue;
 		}
-		if (!strncmp(arg, "--user-path=", 12)) {
+		if (!prefixcmp(arg, "--user-path=")) {
 			user_path = arg + 12;
 			continue;
 		}
-		if (!strncmp(arg, "--pid-file=", 11)) {
+		if (!prefixcmp(arg, "--pid-file=")) {
 			pid_file = arg + 11;
 			continue;
 		}
@@ -1086,27 +1086,27 @@ int main(int argc, char **argv)
 			log_syslog = 1;
 			continue;
 		}
-		if (!strncmp(arg, "--user=", 7)) {
+		if (!prefixcmp(arg, "--user=")) {
 			user_name = arg + 7;
 			continue;
 		}
-		if (!strncmp(arg, "--group=", 8)) {
+		if (!prefixcmp(arg, "--group=")) {
 			group_name = arg + 8;
 			continue;
 		}
-		if (!strncmp(arg, "--enable=", 9)) {
+		if (!prefixcmp(arg, "--enable=")) {
 			enable_service(arg + 9, 1);
 			continue;
 		}
-		if (!strncmp(arg, "--disable=", 10)) {
+		if (!prefixcmp(arg, "--disable=")) {
 			enable_service(arg + 10, 0);
 			continue;
 		}
-		if (!strncmp(arg, "--allow-override=", 17)) {
+		if (!prefixcmp(arg, "--allow-override=")) {
 			make_service_overridable(arg + 17, 1);
 			continue;
 		}
-		if (!strncmp(arg, "--forbid-override=", 18)) {
+		if (!prefixcmp(arg, "--forbid-override=")) {
 			make_service_overridable(arg + 18, 0);
 			continue;
 		}
diff --git a/diff.c b/diff.c
index 07589c3..fad13ab 100644
--- a/diff.c
+++ b/diff.c
@@ -77,7 +77,7 @@ int git_diff_ui_config(const char *var, const char *value)
 			diff_detect_rename_default = DIFF_DETECT_RENAME;
 		return 0;
 	}
-	if (!strncmp(var, "diff.color.", 11) || !strncmp(var, "color.diff.", 11)) {
+	if (!prefixcmp(var, "diff.color.") || !strncmp(var, "color.diff.", 11)) {
 		int slot = parse_diff_color_slot(var, 11);
 		color_parse(value, var, diff_colors[slot]);
 		return 0;
@@ -1119,9 +1119,9 @@ static void builtin_diff(const char *name_a,
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
 		if (!diffopts)
 			;
-		else if (!strncmp(diffopts, "--unified=", 10))
+		else if (!prefixcmp(diffopts, "--unified="))
 			xecfg.ctxlen = strtoul(diffopts + 10, NULL, 10);
-		else if (!strncmp(diffopts, "-u", 2))
+		else if (!prefixcmp(diffopts, "-u"))
 			xecfg.ctxlen = strtoul(diffopts + 2, NULL, 10);
 		ecb.outf = xdiff_outf;
 		ecb.priv = &ecbdata;
@@ -1957,7 +1957,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	else if (!strcmp(arg, "--shortstat")) {
 		options->output_format |= DIFF_FORMAT_SHORTSTAT;
 	}
-	else if (!strncmp(arg, "--stat", 6)) {
+	else if (!prefixcmp(arg, "--stat")) {
 		char *end;
 		int width = options->stat_width;
 		int name_width = options->stat_name_width;
@@ -1966,9 +1966,9 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 
 		switch (*arg) {
 		case '-':
-			if (!strncmp(arg, "-width=", 7))
+			if (!prefixcmp(arg, "-width="))
 				width = strtoul(arg + 7, &end, 10);
-			else if (!strncmp(arg, "-name-width=", 12))
+			else if (!prefixcmp(arg, "-name-width="))
 				name_width = strtoul(arg + 12, &end, 10);
 			break;
 		case '=':
@@ -1993,7 +1993,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	}
 	else if (!strcmp(arg, "-z"))
 		options->line_termination = 0;
-	else if (!strncmp(arg, "-l", 2))
+	else if (!prefixcmp(arg, "-l"))
 		options->rename_limit = strtoul(arg+2, NULL, 10);
 	else if (!strcmp(arg, "--full-index"))
 		options->full_index = 1;
@@ -2010,31 +2010,31 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->output_format |= DIFF_FORMAT_NAME_STATUS;
 	else if (!strcmp(arg, "-R"))
 		options->reverse_diff = 1;
-	else if (!strncmp(arg, "-S", 2))
+	else if (!prefixcmp(arg, "-S"))
 		options->pickaxe = arg + 2;
 	else if (!strcmp(arg, "-s")) {
 		options->output_format |= DIFF_FORMAT_NO_OUTPUT;
 	}
-	else if (!strncmp(arg, "-O", 2))
+	else if (!prefixcmp(arg, "-O"))
 		options->orderfile = arg + 2;
-	else if (!strncmp(arg, "--diff-filter=", 14))
+	else if (!prefixcmp(arg, "--diff-filter="))
 		options->filter = arg + 14;
 	else if (!strcmp(arg, "--pickaxe-all"))
 		options->pickaxe_opts = DIFF_PICKAXE_ALL;
 	else if (!strcmp(arg, "--pickaxe-regex"))
 		options->pickaxe_opts = DIFF_PICKAXE_REGEX;
-	else if (!strncmp(arg, "-B", 2)) {
+	else if (!prefixcmp(arg, "-B")) {
 		if ((options->break_opt =
 		     diff_scoreopt_parse(arg)) == -1)
 			return -1;
 	}
-	else if (!strncmp(arg, "-M", 2)) {
+	else if (!prefixcmp(arg, "-M")) {
 		if ((options->rename_score =
 		     diff_scoreopt_parse(arg)) == -1)
 			return -1;
 		options->detect_rename = DIFF_DETECT_RENAME;
 	}
-	else if (!strncmp(arg, "-C", 2)) {
+	else if (!prefixcmp(arg, "-C")) {
 		if ((options->rename_score =
 		     diff_scoreopt_parse(arg)) == -1)
 			return -1;
@@ -2044,7 +2044,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->find_copies_harder = 1;
 	else if (!strcmp(arg, "--abbrev"))
 		options->abbrev = DEFAULT_ABBREV;
-	else if (!strncmp(arg, "--abbrev=", 9)) {
+	else if (!prefixcmp(arg, "--abbrev=")) {
 		options->abbrev = strtoul(arg + 9, NULL, 10);
 		if (options->abbrev < MINIMUM_ABBREV)
 			options->abbrev = MINIMUM_ABBREV;
@@ -2553,7 +2553,7 @@ static void patch_id_consume(void *priv, char *line, unsigned long len)
 	int new_len;
 
 	/* Ignore line numbers when computing the SHA1 of the patch */
-	if (!strncmp(line, "@@ -", 4))
+	if (!prefixcmp(line, "@@ -"))
 		return;
 
 	new_len = remove_space(line, len);
diff --git a/exec_cmd.c b/exec_cmd.c
index 3996bce..9b74ed2 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -56,7 +56,7 @@ int execv_git_cmd(const char **argv)
 			len = strlen(git_command);
 
 			/* Trivial cleanup */
-			while (!strncmp(exec_dir, "./", 2)) {
+			while (!prefixcmp(exec_dir, "./")) {
 				exec_dir += 2;
 				while (*exec_dir == '/')
 					exec_dir++;
diff --git a/fast-import.c b/fast-import.c
index ad32300..ee7c04c 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1397,7 +1397,7 @@ static void read_next_command(void)
 
 static void cmd_mark(void)
 {
-	if (!strncmp("mark :", command_buf.buf, 6)) {
+	if (!(-prefixcmp(command_buf.buf, "mark :"))) {
 		next_mark = strtoumax(command_buf.buf + 6, NULL, 10);
 		read_next_command();
 	}
@@ -1410,10 +1410,10 @@ static void *cmd_data (size_t *size)
 	size_t length;
 	char *buffer;
 
-	if (strncmp("data ", command_buf.buf, 5))
+	if ((-prefixcmp(command_buf.buf, "data ")))
 		die("Expected 'data n' command, found: %s", command_buf.buf);
 
-	if (!strncmp("<<", command_buf.buf + 5, 2)) {
+	if (!(-prefixcmp(command_buf.buf + 5, "<<"))) {
 		char *term = xstrdup(command_buf.buf + 5 + 2);
 		size_t sz = 8192, term_len = command_buf.len - 5 - 2;
 		length = 0;
@@ -1600,7 +1600,7 @@ static void file_change_m(struct branch *b)
 		oe = find_mark(strtoumax(p + 1, &x, 10));
 		hashcpy(sha1, oe->sha1);
 		p = x;
-	} else if (!strncmp("inline", p, 6)) {
+	} else if (!(-prefixcmp(p, "inline"))) {
 		inline_data = 1;
 		p += 6;
 	} else {
@@ -1673,7 +1673,7 @@ static void cmd_from(struct branch *b)
 	const char *from;
 	struct branch *s;
 
-	if (strncmp("from ", command_buf.buf, 5))
+	if ((-prefixcmp(command_buf.buf, "from ")))
 		return;
 
 	if (b->branch_tree.tree) {
@@ -1739,7 +1739,7 @@ static struct hash_list *cmd_merge(unsigned int *count)
 	struct branch *s;
 
 	*count = 0;
-	while (!strncmp("merge ", command_buf.buf, 6)) {
+	while (!(-prefixcmp(command_buf.buf, "merge "))) {
 		from = strchr(command_buf.buf, ' ') + 1;
 		n = xmalloc(sizeof(*n));
 		s = lookup_branch(from);
@@ -1785,11 +1785,11 @@ static void cmd_new_commit(void)
 
 	read_next_command();
 	cmd_mark();
-	if (!strncmp("author ", command_buf.buf, 7)) {
+	if (!(-prefixcmp(command_buf.buf, "author "))) {
 		author = parse_ident(command_buf.buf + 7);
 		read_next_command();
 	}
-	if (!strncmp("committer ", command_buf.buf, 10)) {
+	if (!(-prefixcmp(command_buf.buf, "committer "))) {
 		committer = parse_ident(command_buf.buf + 10);
 		read_next_command();
 	}
@@ -1810,9 +1810,9 @@ static void cmd_new_commit(void)
 	for (;;) {
 		if (1 == command_buf.len)
 			break;
-		else if (!strncmp("M ", command_buf.buf, 2))
+		else if (!(-prefixcmp(command_buf.buf, "M ")))
 			file_change_m(b);
-		else if (!strncmp("D ", command_buf.buf, 2))
+		else if (!(-prefixcmp(command_buf.buf, "D ")))
 			file_change_d(b);
 		else if (!strcmp("deleteall", command_buf.buf))
 			file_change_deleteall(b);
@@ -1882,7 +1882,7 @@ static void cmd_new_tag(void)
 	read_next_command();
 
 	/* from ... */
-	if (strncmp("from ", command_buf.buf, 5))
+	if ((-prefixcmp(command_buf.buf, "from ")))
 		die("Expected from command, got %s", command_buf.buf);
 	from = strchr(command_buf.buf, ' ') + 1;
 	s = lookup_branch(from);
@@ -1909,7 +1909,7 @@ static void cmd_new_tag(void)
 	read_next_command();
 
 	/* tagger ... */
-	if (strncmp("tagger ", command_buf.buf, 7))
+	if ((-prefixcmp(command_buf.buf, "tagger ")))
 		die("Expected tagger command, got %s", command_buf.buf);
 	tagger = parse_ident(command_buf.buf + 7);
 
@@ -1986,7 +1986,7 @@ int main(int argc, const char **argv)
 
 		if (*a != '-' || !strcmp(a, "--"))
 			break;
-		else if (!strncmp(a, "--date-format=", 14)) {
+		else if (!prefixcmp(a, "--date-format=")) {
 			const char *fmt = a + 14;
 			if (!strcmp(fmt, "raw"))
 				whenspec = WHENSPEC_RAW;
@@ -1997,15 +1997,15 @@ int main(int argc, const char **argv)
 			else
 				die("unknown --date-format argument %s", fmt);
 		}
-		else if (!strncmp(a, "--max-pack-size=", 16))
+		else if (!prefixcmp(a, "--max-pack-size="))
 			max_packsize = strtoumax(a + 16, NULL, 0) * 1024 * 1024;
-		else if (!strncmp(a, "--depth=", 8))
+		else if (!prefixcmp(a, "--depth="))
 			max_depth = strtoul(a + 8, NULL, 0);
-		else if (!strncmp(a, "--active-branches=", 18))
+		else if (!prefixcmp(a, "--active-branches="))
 			max_active_branches = strtoul(a + 18, NULL, 0);
-		else if (!strncmp(a, "--export-marks=", 15))
+		else if (!prefixcmp(a, "--export-marks="))
 			mark_file = a + 15;
-		else if (!strncmp(a, "--export-pack-edges=", 20)) {
+		else if (!prefixcmp(a, "--export-pack-edges=")) {
 			if (pack_edges)
 				fclose(pack_edges);
 			pack_edges = fopen(a + 20, "a");
@@ -2038,11 +2038,11 @@ int main(int argc, const char **argv)
 			break;
 		else if (!strcmp("blob", command_buf.buf))
 			cmd_new_blob();
-		else if (!strncmp("commit ", command_buf.buf, 7))
+		else if (!(-prefixcmp(command_buf.buf, "commit ")))
 			cmd_new_commit();
-		else if (!strncmp("tag ", command_buf.buf, 4))
+		else if (!(-prefixcmp(command_buf.buf, "tag ")))
 			cmd_new_tag();
-		else if (!strncmp("reset ", command_buf.buf, 6))
+		else if (!(-prefixcmp(command_buf.buf, "reset ")))
 			cmd_reset_branch();
 		else if (!strcmp("checkpoint", command_buf.buf))
 			cmd_checkpoint();
diff --git a/fetch-pack.c b/fetch-pack.c
index c787106..1fd2c3a 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -198,13 +198,13 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 		int len;
 
 		while ((len = packet_read_line(fd[0], line, sizeof(line)))) {
-			if (!strncmp("shallow ", line, 8)) {
+			if (!(-prefixcmp(line, "shallow "))) {
 				if (get_sha1_hex(line + 8, sha1))
 					die("invalid shallow line: %s", line);
 				register_shallow(sha1);
 				continue;
 			}
-			if (!strncmp("unshallow ", line, 10)) {
+			if (!(-prefixcmp(line, "unshallow "))) {
 				if (get_sha1_hex(line + 10, sha1))
 					die("invalid unshallow line: %s", line);
 				if (!lookup_object(sha1))
@@ -346,7 +346,7 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
 		    check_ref_format(ref->name + 5))
 			; /* trash */
 		else if (fetch_all &&
-			 (!depth || strncmp(ref->name, "refs/tags/", 10) )) {
+			 (!depth || prefixcmp(ref->name, "refs/tags/") )) {
 			*newtail = ref;
 			ref->next = NULL;
 			newtail = &ref->next;
@@ -683,11 +683,11 @@ int main(int argc, char **argv)
 		char *arg = argv[i];
 
 		if (*arg == '-') {
-			if (!strncmp("--upload-pack=", arg, 14)) {
+			if (!(-prefixcmp(arg, "--upload-pack="))) {
 				uploadpack = arg + 14;
 				continue;
 			}
-			if (!strncmp("--exec=", arg, 7)) {
+			if (!(-prefixcmp(arg, "--exec="))) {
 				uploadpack = arg + 7;
 				continue;
 			}
@@ -712,7 +712,7 @@ int main(int argc, char **argv)
 				verbose = 1;
 				continue;
 			}
-			if (!strncmp("--depth=", arg, 8)) {
+			if (!(-prefixcmp(arg, "--depth="))) {
 				depth = strtol(arg + 8, NULL, 0);
 				if (stat(git_path("shallow"), &st))
 					st.st_mtime = 0;
diff --git a/git.c b/git.c
index 4dd1967..1fad852 100644
--- a/git.c
+++ b/git.c
@@ -48,7 +48,7 @@ static int handle_options(const char*** argv, int* argc)
 		/*
 		 * Check remaining flags.
 		 */
-		if (!strncmp(cmd, "--exec-path", 11)) {
+		if (!prefixcmp(cmd, "--exec-path")) {
 			cmd += 11;
 			if (*cmd == '=')
 				git_set_exec_path(cmd + 1);
@@ -66,7 +66,7 @@ static int handle_options(const char*** argv, int* argc)
 			setenv(GIT_DIR_ENVIRONMENT, (*argv)[1], 1);
 			(*argv)++;
 			(*argc)--;
-		} else if (!strncmp(cmd, "--git-dir=", 10)) {
+		} else if (!prefixcmp(cmd, "--git-dir=")) {
 			setenv(GIT_DIR_ENVIRONMENT, cmd + 10, 1);
 		} else if (!strcmp(cmd, "--bare")) {
 			static char git_dir[PATH_MAX+1];
@@ -88,7 +88,7 @@ static char *alias_string;
 
 static int git_alias_config(const char *var, const char *value)
 {
-	if (!strncmp(var, "alias.", 6) && !strcmp(var + 6, alias_command)) {
+	if (!prefixcmp(var, "alias.") && !strcmp(var + 6, alias_command)) {
 		alias_string = xstrdup(value);
 	}
 	return 0;
@@ -348,7 +348,7 @@ int main(int argc, const char **argv, char **envp)
 	 * So we just directly call the internal command handler, and
 	 * die if that one cannot handle it.
 	 */
-	if (!strncmp(cmd, "git-", 4)) {
+	if (!prefixcmp(cmd, "git-")) {
 		cmd += 4;
 		argv[0] = cmd;
 		handle_internal_command(argc, argv, envp);
@@ -360,7 +360,7 @@ int main(int argc, const char **argv, char **envp)
 	argc--;
 	handle_options(&argv, &argc);
 	if (argc > 0) {
-		if (!strncmp(argv[0], "--", 2))
+		if (!prefixcmp(argv[0], "--"))
 			argv[0] += 2;
 	} else {
 		/* Default command: "help" */
diff --git a/help.c b/help.c
index b667463..0893fea 100644
--- a/help.c
+++ b/help.c
@@ -130,7 +130,7 @@ static void list_commands(const char *exec_path, const char *pattern)
 		struct stat st;
 		int entlen;
 
-		if (strncmp(de->d_name, "git-", 4))
+		if (prefixcmp(de->d_name, "git-"))
 			continue;
 		strcpy(path+dirlen, de->d_name);
 		if (stat(path, &st) || /* stat, not lstat */
@@ -179,7 +179,7 @@ static void show_man_page(const char *git_cmd)
 {
 	const char *page;
 
-	if (!strncmp(git_cmd, "git", 3))
+	if (!prefixcmp(git_cmd, "git"))
 		page = git_cmd;
 	else {
 		int page_len = strlen(git_cmd) + 4;
diff --git a/http-fetch.c b/http-fetch.c
index 9f790a0..d9a4561 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -717,7 +717,7 @@ static int fetch_indices(struct alt_base *repo)
 		case 'P':
 			i++;
 			if (i + 52 <= buffer.posn &&
-			    !strncmp(data + i, " pack-", 6) &&
+			    !prefixcmp(data + i, " pack-") &&
 			    !strncmp(data + i + 46, ".pack\n", 6)) {
 				get_sha1_hex(data + i + 6, sha1);
 				setup_index(repo, sha1);
diff --git a/http-push.c b/http-push.c
index b128c01..eb77c9a 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1060,7 +1060,7 @@ static int fetch_indices(void)
 		case 'P':
 			i++;
 			if (i + 52 < buffer.posn &&
-			    !strncmp(data + i, " pack-", 6) &&
+			    !prefixcmp(data + i, " pack-") &&
 			    !strncmp(data + i + 46, ".pack\n", 6)) {
 				get_sha1_hex(data + i + 6, sha1);
 				setup_index(sha1);
@@ -1206,11 +1206,11 @@ static void handle_new_lock_ctx(struct xml_ctx *ctx, int tag_closed)
 			lock->owner = xmalloc(strlen(ctx->cdata) + 1);
 			strcpy(lock->owner, ctx->cdata);
 		} else if (!strcmp(ctx->name, DAV_ACTIVELOCK_TIMEOUT)) {
-			if (!strncmp(ctx->cdata, "Second-", 7))
+			if (!prefixcmp(ctx->cdata, "Second-"))
 				lock->timeout =
 					strtol(ctx->cdata + 7, NULL, 10);
 		} else if (!strcmp(ctx->name, DAV_ACTIVELOCK_TOKEN)) {
-			if (!strncmp(ctx->cdata, "opaquelocktoken:", 16)) {
+			if (!prefixcmp(ctx->cdata, "opaquelocktoken:")) {
 				lock->token = xmalloc(strlen(ctx->cdata) - 15);
 				strcpy(lock->token, ctx->cdata + 16);
 			}
@@ -2168,7 +2168,7 @@ static void fetch_symref(const char *path, char **symref, unsigned char *sha1)
 		return;
 
 	/* If it's a symref, set the refname; otherwise try for a sha1 */
-	if (!strncmp((char *)buffer.buffer, "ref: ", 5)) {
+	if (!prefixcmp((char *)buffer.buffer, "ref: ")) {
 		*symref = xmalloc(buffer.posn - 5);
 		strlcpy(*symref, (char *)buffer.buffer + 5, buffer.posn - 5);
 	} else {
diff --git a/index-pack.c b/index-pack.c
index 72e0962..fa9a0e7 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -849,9 +849,9 @@ int main(int argc, char **argv)
 				fix_thin_pack = 1;
 			} else if (!strcmp(arg, "--keep")) {
 				keep_msg = "";
-			} else if (!strncmp(arg, "--keep=", 7)) {
+			} else if (!prefixcmp(arg, "--keep=")) {
 				keep_msg = arg + 7;
-			} else if (!strncmp(arg, "--pack_header=", 14)) {
+			} else if (!prefixcmp(arg, "--pack_header=")) {
 				struct pack_header *hdr;
 				char *c;
 
diff --git a/peek-remote.c b/peek-remote.c
index ef3c76c..7b66228 100644
--- a/peek-remote.c
+++ b/peek-remote.c
@@ -35,11 +35,11 @@ int main(int argc, char **argv)
 		char *arg = argv[i];
 
 		if (*arg == '-') {
-			if (!strncmp("--upload-pack=", arg, 14)) {
+			if (!(-prefixcmp(arg, "--upload-pack="))) {
 				uploadpack = arg + 14;
 				continue;
 			}
-			if (!strncmp("--exec=", arg, 7)) {
+			if (!(-prefixcmp(arg, "--exec="))) {
 				uploadpack = arg + 7;
 				continue;
 			}
diff --git a/receive-pack.c b/receive-pack.c
index 7311c82..7f1dcc0 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -109,7 +109,7 @@ static int update(struct command *cmd)
 	struct ref_lock *lock;
 
 	cmd->error_string = NULL;
-	if (!strncmp(name, "refs/", 5) && check_ref_format(name + 5)) {
+	if (!prefixcmp(name, "refs/") && check_ref_format(name + 5)) {
 		cmd->error_string = "funny refname";
 		return error("refusing to create funny ref '%s' locally",
 			     name);
@@ -125,7 +125,7 @@ static int update(struct command *cmd)
 	}
 	if (deny_non_fast_forwards && !is_null_sha1(new_sha1) &&
 	    !is_null_sha1(old_sha1) &&
-	    !strncmp(name, "refs/heads/", 11)) {
+	    !prefixcmp(name, "refs/heads/")) {
 		struct commit *old_commit, *new_commit;
 		struct commit_list *bases, *ent;
 
diff --git a/refs.c b/refs.c
index 6387703..d347876 100644
--- a/refs.c
+++ b/refs.c
@@ -828,8 +828,8 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 		goto rollback;
 	}
 
-	if (!strncmp(oldref, "refs/heads/", 11) &&
-			!strncmp(newref, "refs/heads/", 11)) {
+	if (!prefixcmp(oldref, "refs/heads/") &&
+			!prefixcmp(newref, "refs/heads/")) {
 		char oldsection[1024], newsection[1024];
 
 		snprintf(oldsection, 1024, "branch.%s", oldref + 11);
@@ -894,8 +894,8 @@ static int log_ref_write(const char *ref_name, const unsigned char *old_sha1,
 	log_file = git_path("logs/%s", ref_name);
 
 	if (log_all_ref_updates &&
-	    (!strncmp(ref_name, "refs/heads/", 11) ||
-	     !strncmp(ref_name, "refs/remotes/", 13) ||
+	    (!prefixcmp(ref_name, "refs/heads/") ||
+	     !prefixcmp(ref_name, "refs/remotes/") ||
 	     !strcmp(ref_name, "HEAD"))) {
 		if (safe_create_leading_directories(log_file) < 0)
 			return error("unable to create directory for %s",
diff --git a/revision.c b/revision.c
index 5b1794b..abab3b9 100644
--- a/revision.c
+++ b/revision.c
@@ -813,11 +813,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		const char *arg = argv[i];
 		if (*arg == '-') {
 			int opts;
-			if (!strncmp(arg, "--max-count=", 12)) {
+			if (!prefixcmp(arg, "--max-count=")) {
 				revs->max_count = atoi(arg + 12);
 				continue;
 			}
-			if (!strncmp(arg, "--skip=", 7)) {
+			if (!prefixcmp(arg, "--skip=")) {
 				revs->skip_count = atoi(arg + 7);
 				continue;
 			}
@@ -836,27 +836,27 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				revs->max_count = atoi(arg + 2);
 				continue;
 			}
-			if (!strncmp(arg, "--max-age=", 10)) {
+			if (!prefixcmp(arg, "--max-age=")) {
 				revs->max_age = atoi(arg + 10);
 				continue;
 			}
-			if (!strncmp(arg, "--since=", 8)) {
+			if (!prefixcmp(arg, "--since=")) {
 				revs->max_age = approxidate(arg + 8);
 				continue;
 			}
-			if (!strncmp(arg, "--after=", 8)) {
+			if (!prefixcmp(arg, "--after=")) {
 				revs->max_age = approxidate(arg + 8);
 				continue;
 			}
-			if (!strncmp(arg, "--min-age=", 10)) {
+			if (!prefixcmp(arg, "--min-age=")) {
 				revs->min_age = atoi(arg + 10);
 				continue;
 			}
-			if (!strncmp(arg, "--before=", 9)) {
+			if (!prefixcmp(arg, "--before=")) {
 				revs->min_age = approxidate(arg + 9);
 				continue;
 			}
-			if (!strncmp(arg, "--until=", 8)) {
+			if (!prefixcmp(arg, "--until=")) {
 				revs->min_age = approxidate(arg + 8);
 				continue;
 			}
@@ -944,7 +944,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				revs->num_ignore_packed = 0;
 				continue;
 			}
-			if (!strncmp(arg, "--unpacked=", 11)) {
+			if (!prefixcmp(arg, "--unpacked=")) {
 				revs->unpacked = 1;
 				add_ignore_packed(revs, arg+11);
 				continue;
@@ -980,7 +980,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				revs->verbose_header = 1;
 				continue;
 			}
-			if (!strncmp(arg, "--pretty", 8)) {
+			if (!prefixcmp(arg, "--pretty")) {
 				revs->verbose_header = 1;
 				revs->commit_format = get_commit_format(arg+8);
 				continue;
@@ -1005,7 +1005,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				revs->abbrev = DEFAULT_ABBREV;
 				continue;
 			}
-			if (!strncmp(arg, "--abbrev=", 9)) {
+			if (!prefixcmp(arg, "--abbrev=")) {
 				revs->abbrev = strtoul(arg + 9, NULL, 10);
 				if (revs->abbrev < MINIMUM_ABBREV)
 					revs->abbrev = MINIMUM_ABBREV;
@@ -1034,15 +1034,15 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 			/*
 			 * Grepping the commit log
 			 */
-			if (!strncmp(arg, "--author=", 9)) {
+			if (!prefixcmp(arg, "--author=")) {
 				add_header_grep(revs, "author", arg+9);
 				continue;
 			}
-			if (!strncmp(arg, "--committer=", 12)) {
+			if (!prefixcmp(arg, "--committer=")) {
 				add_header_grep(revs, "committer", arg+12);
 				continue;
 			}
-			if (!strncmp(arg, "--grep=", 7)) {
+			if (!prefixcmp(arg, "--grep=")) {
 				add_message_grep(revs, arg+7);
 				continue;
 			}
@@ -1050,7 +1050,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				all_match = 1;
 				continue;
 			}
-			if (!strncmp(arg, "--encoding=", 11)) {
+			if (!prefixcmp(arg, "--encoding=")) {
 				arg += 11;
 				if (strcmp(arg, "none"))
 					git_log_output_encoding = strdup(arg);
diff --git a/send-pack.c b/send-pack.c
index 33e69db..512b660 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -379,11 +379,11 @@ int main(int argc, char **argv)
 		char *arg = *argv;
 
 		if (*arg == '-') {
-			if (!strncmp(arg, "--receive-pack=", 15)) {
+			if (!prefixcmp(arg, "--receive-pack=")) {
 				receivepack = arg + 15;
 				continue;
 			}
-			if (!strncmp(arg, "--exec=", 7)) {
+			if (!prefixcmp(arg, "--exec=")) {
 				receivepack = arg + 7;
 				continue;
 			}
diff --git a/setup.c b/setup.c
index e9d3f5a..dda67d2 100644
--- a/setup.c
+++ b/setup.c
@@ -251,7 +251,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	offset++;
 	cwd[len++] = '/';
 	cwd[len] = 0;
-	inside_git_dir = !strncmp(cwd + offset, ".git/", 5);
+	inside_git_dir = !prefixcmp(cwd + offset, ".git/");
 	return cwd + offset;
 }
 
diff --git a/shell.c b/shell.c
index 8c08cf0..c983fc7 100644
--- a/shell.c
+++ b/shell.c
@@ -8,7 +8,7 @@ static int do_generic_cmd(const char *me, char *arg)
 
 	if (!arg || !(arg = sq_dequote(arg)))
 		die("bad argument");
-	if (strncmp(me, "git-", 4))
+	if (prefixcmp(me, "git-"))
 		die("bad command");
 
 	my_argv[0] = me + 4;
diff --git a/upload-pack.c b/upload-pack.c
index 3648aae..d7876ca 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -455,7 +455,7 @@ static int get_common_commits(void)
 			continue;
 		}
 		len = strip(line, len);
-		if (!strncmp(line, "have ", 5)) {
+		if (!prefixcmp(line, "have ")) {
 			switch (got_sha1(line+5, sha1)) {
 			case -1: /* they have what we do not */
 				if (multi_ack && ok_to_give_up())
@@ -502,7 +502,7 @@ static void receive_needs(void)
 		if (!len)
 			break;
 
-		if (!strncmp("shallow ", line, 8)) {
+		if (!(-prefixcmp(line, "shallow "))) {
 			unsigned char sha1[20];
 			struct object *object;
 			use_thin_pack = 0;
@@ -515,7 +515,7 @@ static void receive_needs(void)
 			add_object_array(object, NULL, &shallows);
 			continue;
 		}
-		if (!strncmp("deepen ", line, 7)) {
+		if (!(-prefixcmp(line, "deepen "))) {
 			char *end;
 			use_thin_pack = 0;
 			depth = strtol(line + 7, &end, 0);
@@ -523,7 +523,7 @@ static void receive_needs(void)
 				die("Invalid deepen: %s", line);
 			continue;
 		}
-		if (strncmp("want ", line, 5) ||
+		if ((-prefixcmp(line, "want ")) ||
 		    get_sha1_hex(line+5, sha1_buf))
 			die("git-upload-pack: protocol error, "
 			    "expected to get sha, not '%s'", line);
@@ -656,7 +656,7 @@ int main(int argc, char **argv)
 			strict = 1;
 			continue;
 		}
-		if (!strncmp(arg, "--timeout=", 10)) {
+		if (!prefixcmp(arg, "--timeout=")) {
 			timeout = atoi(arg+10);
 			continue;
 		}
diff --git a/wt-status.c b/wt-status.c
index 2879c3d..d17a6ba 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -298,7 +298,7 @@ void wt_status_print(struct wt_status *s)
 	if (s->branch) {
 		const char *on_what = "On branch ";
 		const char *branch_name = s->branch;
-		if (!strncmp(branch_name, "refs/heads/", 11))
+		if (!prefixcmp(branch_name, "refs/heads/"))
 			branch_name += 11;
 		else if (!strcmp(branch_name, "HEAD")) {
 			branch_name = "";
@@ -344,7 +344,7 @@ int git_status_config(const char *k, const char *v)
 		wt_status_use_color = git_config_colorbool(k, v);
 		return 0;
 	}
-	if (!strncmp(k, "status.color.", 13) || !strncmp(k, "color.status.", 13)) {
+	if (!prefixcmp(k, "status.color.") || !strncmp(k, "color.status.", 13)) {
 		int slot = parse_status_slot(k, 13);
 		color_parse(v, k, wt_status_colors[slot]);
 	}
-- 
1.5.0.1.571.ge5a1a
