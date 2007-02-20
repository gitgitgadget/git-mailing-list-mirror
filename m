From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/4] prefixcmp(): fix-up mechanical conversion.
Date: Tue, 20 Feb 2007 01:54:00 -0800
Message-ID: <7vy7mtw3wn.fsf_-_@assigned-by-dhcp.cox.net>
References: <200702191839.05784.andyparkins@gmail.com>
	<7vlkit7vy5.fsf@assigned-by-dhcp.cox.net>
	<200702200942.18654.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 20 10:54:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJRhI-0000kp-5R
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 10:54:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932701AbXBTJyE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 04:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbXBTJyD
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 04:54:03 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:53975 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932701AbXBTJyB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 04:54:01 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070220095401.GLWI21668.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Tue, 20 Feb 2007 04:54:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Rlu01W0021kojtg0000000; Tue, 20 Feb 2007 04:54:00 -0500
In-Reply-To: <200702200942.18654.andyparkins@gmail.com> (Andy Parkins's
	message of "Tue, 20 Feb 2007 09:42:17 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40222>

Previous step converted use of strncmp() with literal string
mechanically even when the result is only used as a boolean (not
comparison):

	if (!strncmp("foo", arg, 3)) ==> if (!(-prefixcmp(arg, "foo")))

This step manually cleans them up.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-archive.c      |    2 +-
 builtin-blame.c        |    6 +++---
 builtin-grep.c         |    6 +++---
 builtin-pack-objects.c |    6 +++---
 builtin-push.c         |    4 ++--
 builtin-rerere.c       |    6 +++---
 builtin-show-branch.c  |    4 ++--
 builtin-tar-tree.c     |    2 +-
 daemon.c               |    2 +-
 fast-import.c          |   30 +++++++++++++++---------------
 fetch-pack.c           |   10 +++++-----
 peek-remote.c          |    4 ++--
 upload-pack.c          |    6 +++---
 13 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/builtin-archive.c b/builtin-archive.c
index 0c56de0..8ea6cb1 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -35,7 +35,7 @@ static int run_remote_archiver(const char *remote, int argc,
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
-		if (!(-prefixcmp(arg, "--exec="))) {
+		if (!prefixcmp(arg, "--exec=")) {
 			if (exec_at)
 				die("multiple --exec specified");
 			exec = arg + 7;
diff --git a/builtin-blame.c b/builtin-blame.c
index db311bf..530b97f 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2097,17 +2097,17 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 			output_option |= OUTPUT_LONG_OBJECT_NAME;
 		else if (!strcmp("-S", arg) && ++i < argc)
 			revs_file = argv[i];
-		else if (!(-prefixcmp(arg, "-M"))) {
+		else if (!prefixcmp(arg, "-M")) {
 			opt |= PICKAXE_BLAME_MOVE;
 			blame_move_score = parse_score(arg+2);
 		}
-		else if (!(-prefixcmp(arg, "-C"))) {
+		else if (!prefixcmp(arg, "-C")) {
 			if (opt & PICKAXE_BLAME_COPY)
 				opt |= PICKAXE_BLAME_COPY_HARDER;
 			opt |= PICKAXE_BLAME_COPY | PICKAXE_BLAME_MOVE;
 			blame_copy_score = parse_score(arg+2);
 		}
-		else if (!(-prefixcmp(arg, "-L"))) {
+		else if (!prefixcmp(arg, "-L")) {
 			if (!arg[2]) {
 				if (++i >= argc)
 					usage(blame_usage);
diff --git a/builtin-grep.c b/builtin-grep.c
index cec2204..f35f2d0 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -527,9 +527,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			opt.word_regexp = 1;
 			continue;
 		}
-		if (!(-prefixcmp(arg, "-A")) ||
-		    !(-prefixcmp(arg, "-B")) ||
-		    !(-prefixcmp(arg, "-C")) ||
+		if (!prefixcmp(arg, "-A") ||
+		    !prefixcmp(arg, "-B") ||
+		    !prefixcmp(arg, "-C") ||
 		    (arg[0] == '-' && '1' <= arg[1] && arg[1] <= '9')) {
 			unsigned num;
 			const char *scan;
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 71113d8..b5ed9ce 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1579,14 +1579,14 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			incremental = 1;
 			continue;
 		}
-		if (!(-prefixcmp(arg, "--window="))) {
+		if (!prefixcmp(arg, "--window=")) {
 			char *end;
 			window = strtoul(arg+9, &end, 0);
 			if (!arg[9] || *end)
 				usage(pack_usage);
 			continue;
 		}
-		if (!(-prefixcmp(arg, "--depth="))) {
+		if (!prefixcmp(arg, "--depth=")) {
 			char *end;
 			depth = strtoul(arg+8, &end, 0);
 			if (!arg[8] || *end)
@@ -1622,7 +1622,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		if (!strcmp("--unpacked", arg) ||
-		    !(-prefixcmp(arg, "--unpacked=")) ||
+		    !prefixcmp(arg, "--unpacked=") ||
 		    !strcmp("--reflog", arg) ||
 		    !strcmp("--all", arg)) {
 			use_internal_rev_list = 1;
diff --git a/builtin-push.c b/builtin-push.c
index 2b98ba3..979efcc 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -149,10 +149,10 @@ static int get_remotes_uri(const char *repo, const char *uri[MAX_URI])
 		int is_refspec;
 		char *s, *p;
 
-		if (!(-prefixcmp(buffer, "URL:"))) {
+		if (!prefixcmp(buffer, "URL:")) {
 			is_refspec = 0;
 			s = buffer + 4;
-		} else if (!(-prefixcmp(buffer, "Push:"))) {
+		} else if (!prefixcmp(buffer, "Push:")) {
 			is_refspec = 1;
 			s = buffer + 5;
 		} else
diff --git a/builtin-rerere.c b/builtin-rerere.c
index 978105b..dd1d4c1 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -105,11 +105,11 @@ static int handle_file(const char *path,
 		SHA1_Init(&ctx);
 
 	while (fgets(buf, sizeof(buf), f)) {
-		if (!(-prefixcmp(buf, "<<<<<<< ")))
+		if (!prefixcmp(buf, "<<<<<<< "))
 			hunk = 1;
-		else if (!(-prefixcmp(buf, "=======")))
+		else if (!prefixcmp(buf, "======="))
 			hunk = 2;
-		else if (!(-prefixcmp(buf, ">>>>>>> "))) {
+		else if (!prefixcmp(buf, ">>>>>>> ")) {
 			hunk_no++;
 			hunk = 0;
 			if (memcmp(one->ptr, two->ptr, one->nr < two->nr ?
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index bf6aee4..402a8f7 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -435,9 +435,9 @@ static int append_matching_ref(const char *refname, const unsigned char *sha1, i
 		return 0;
 	if (fnmatch(match_ref_pattern, tail, 0))
 		return 0;
-	if (!(-prefixcmp(refname, "refs/heads/")))
+	if (!prefixcmp(refname, "refs/heads/"))
 		return append_head_ref(refname, sha1, flag, cb_data);
-	if (!(-prefixcmp(refname, "refs/tags/")))
+	if (!prefixcmp(refname, "refs/tags/"))
 		return append_tag_ref(refname, sha1, flag, cb_data);
 	return append_ref(refname, sha1, 0);
 }
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index 28f8c1c..b04719e 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -31,7 +31,7 @@ int cmd_tar_tree(int argc, const char **argv, const char *prefix)
 	nargv[nargc++] = "git-archive";
 	nargv[nargc++] = "--format=tar";
 
-	if (2 <= argc && !(-prefixcmp(argv[1], "--remote="))) {
+	if (2 <= argc && !prefixcmp(argv[1], "--remote=")) {
 		nargv[nargc++] = argv[1];
 		argv++;
 		argc--;
diff --git a/daemon.c b/daemon.c
index cdbc23f..e74ecac 100644
--- a/daemon.c
+++ b/daemon.c
@@ -562,7 +562,7 @@ static int execute(struct sockaddr *addr)
 	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
 		struct daemon_service *s = &(daemon_service[i]);
 		int namelen = strlen(s->name);
-		if (!(-prefixcmp(line, "git-")) &&
+		if (!prefixcmp(line, "git-") &&
 		    !strncmp(s->name, line + 4, namelen) &&
 		    line[namelen + 4] == ' ') {
 			/*
diff --git a/fast-import.c b/fast-import.c
index ee7c04c..580eadc 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1397,7 +1397,7 @@ static void read_next_command(void)
 
 static void cmd_mark(void)
 {
-	if (!(-prefixcmp(command_buf.buf, "mark :"))) {
+	if (!prefixcmp(command_buf.buf, "mark :")) {
 		next_mark = strtoumax(command_buf.buf + 6, NULL, 10);
 		read_next_command();
 	}
@@ -1410,10 +1410,10 @@ static void *cmd_data (size_t *size)
 	size_t length;
 	char *buffer;
 
-	if ((-prefixcmp(command_buf.buf, "data ")))
+	if (prefixcmp(command_buf.buf, "data "))
 		die("Expected 'data n' command, found: %s", command_buf.buf);
 
-	if (!(-prefixcmp(command_buf.buf + 5, "<<"))) {
+	if (!prefixcmp(command_buf.buf + 5, "<<")) {
 		char *term = xstrdup(command_buf.buf + 5 + 2);
 		size_t sz = 8192, term_len = command_buf.len - 5 - 2;
 		length = 0;
@@ -1600,7 +1600,7 @@ static void file_change_m(struct branch *b)
 		oe = find_mark(strtoumax(p + 1, &x, 10));
 		hashcpy(sha1, oe->sha1);
 		p = x;
-	} else if (!(-prefixcmp(p, "inline"))) {
+	} else if (!prefixcmp(p, "inline")) {
 		inline_data = 1;
 		p += 6;
 	} else {
@@ -1673,7 +1673,7 @@ static void cmd_from(struct branch *b)
 	const char *from;
 	struct branch *s;
 
-	if ((-prefixcmp(command_buf.buf, "from ")))
+	if (prefixcmp(command_buf.buf, "from "))
 		return;
 
 	if (b->branch_tree.tree) {
@@ -1739,7 +1739,7 @@ static struct hash_list *cmd_merge(unsigned int *count)
 	struct branch *s;
 
 	*count = 0;
-	while (!(-prefixcmp(command_buf.buf, "merge "))) {
+	while (!prefixcmp(command_buf.buf, "merge ")) {
 		from = strchr(command_buf.buf, ' ') + 1;
 		n = xmalloc(sizeof(*n));
 		s = lookup_branch(from);
@@ -1785,11 +1785,11 @@ static void cmd_new_commit(void)
 
 	read_next_command();
 	cmd_mark();
-	if (!(-prefixcmp(command_buf.buf, "author "))) {
+	if (!prefixcmp(command_buf.buf, "author ")) {
 		author = parse_ident(command_buf.buf + 7);
 		read_next_command();
 	}
-	if (!(-prefixcmp(command_buf.buf, "committer "))) {
+	if (!prefixcmp(command_buf.buf, "committer ")) {
 		committer = parse_ident(command_buf.buf + 10);
 		read_next_command();
 	}
@@ -1810,9 +1810,9 @@ static void cmd_new_commit(void)
 	for (;;) {
 		if (1 == command_buf.len)
 			break;
-		else if (!(-prefixcmp(command_buf.buf, "M ")))
+		else if (!prefixcmp(command_buf.buf, "M "))
 			file_change_m(b);
-		else if (!(-prefixcmp(command_buf.buf, "D ")))
+		else if (!prefixcmp(command_buf.buf, "D "))
 			file_change_d(b);
 		else if (!strcmp("deleteall", command_buf.buf))
 			file_change_deleteall(b);
@@ -1882,7 +1882,7 @@ static void cmd_new_tag(void)
 	read_next_command();
 
 	/* from ... */
-	if ((-prefixcmp(command_buf.buf, "from ")))
+	if (prefixcmp(command_buf.buf, "from "))
 		die("Expected from command, got %s", command_buf.buf);
 	from = strchr(command_buf.buf, ' ') + 1;
 	s = lookup_branch(from);
@@ -1909,7 +1909,7 @@ static void cmd_new_tag(void)
 	read_next_command();
 
 	/* tagger ... */
-	if ((-prefixcmp(command_buf.buf, "tagger ")))
+	if (prefixcmp(command_buf.buf, "tagger "))
 		die("Expected tagger command, got %s", command_buf.buf);
 	tagger = parse_ident(command_buf.buf + 7);
 
@@ -2038,11 +2038,11 @@ int main(int argc, const char **argv)
 			break;
 		else if (!strcmp("blob", command_buf.buf))
 			cmd_new_blob();
-		else if (!(-prefixcmp(command_buf.buf, "commit ")))
+		else if (!prefixcmp(command_buf.buf, "commit "))
 			cmd_new_commit();
-		else if (!(-prefixcmp(command_buf.buf, "tag ")))
+		else if (!prefixcmp(command_buf.buf, "tag "))
 			cmd_new_tag();
-		else if (!(-prefixcmp(command_buf.buf, "reset ")))
+		else if (!prefixcmp(command_buf.buf, "reset "))
 			cmd_reset_branch();
 		else if (!strcmp("checkpoint", command_buf.buf))
 			cmd_checkpoint();
diff --git a/fetch-pack.c b/fetch-pack.c
index 1fd2c3a..41bdd27 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -198,13 +198,13 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 		int len;
 
 		while ((len = packet_read_line(fd[0], line, sizeof(line)))) {
-			if (!(-prefixcmp(line, "shallow "))) {
+			if (!prefixcmp(line, "shallow ")) {
 				if (get_sha1_hex(line + 8, sha1))
 					die("invalid shallow line: %s", line);
 				register_shallow(sha1);
 				continue;
 			}
-			if (!(-prefixcmp(line, "unshallow "))) {
+			if (!prefixcmp(line, "unshallow ")) {
 				if (get_sha1_hex(line + 10, sha1))
 					die("invalid unshallow line: %s", line);
 				if (!lookup_object(sha1))
@@ -683,11 +683,11 @@ int main(int argc, char **argv)
 		char *arg = argv[i];
 
 		if (*arg == '-') {
-			if (!(-prefixcmp(arg, "--upload-pack="))) {
+			if (!prefixcmp(arg, "--upload-pack=")) {
 				uploadpack = arg + 14;
 				continue;
 			}
-			if (!(-prefixcmp(arg, "--exec="))) {
+			if (!prefixcmp(arg, "--exec=")) {
 				uploadpack = arg + 7;
 				continue;
 			}
@@ -712,7 +712,7 @@ int main(int argc, char **argv)
 				verbose = 1;
 				continue;
 			}
-			if (!(-prefixcmp(arg, "--depth="))) {
+			if (!prefixcmp(arg, "--depth=")) {
 				depth = strtol(arg + 8, NULL, 0);
 				if (stat(git_path("shallow"), &st))
 					st.st_mtime = 0;
diff --git a/peek-remote.c b/peek-remote.c
index 7b66228..96bfac4 100644
--- a/peek-remote.c
+++ b/peek-remote.c
@@ -35,11 +35,11 @@ int main(int argc, char **argv)
 		char *arg = argv[i];
 
 		if (*arg == '-') {
-			if (!(-prefixcmp(arg, "--upload-pack="))) {
+			if (!prefixcmp(arg, "--upload-pack=")) {
 				uploadpack = arg + 14;
 				continue;
 			}
-			if (!(-prefixcmp(arg, "--exec="))) {
+			if (!prefixcmp(arg, "--exec=")) {
 				uploadpack = arg + 7;
 				continue;
 			}
diff --git a/upload-pack.c b/upload-pack.c
index d7876ca..804bbb6 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -502,7 +502,7 @@ static void receive_needs(void)
 		if (!len)
 			break;
 
-		if (!(-prefixcmp(line, "shallow "))) {
+		if (!prefixcmp(line, "shallow ")) {
 			unsigned char sha1[20];
 			struct object *object;
 			use_thin_pack = 0;
@@ -515,7 +515,7 @@ static void receive_needs(void)
 			add_object_array(object, NULL, &shallows);
 			continue;
 		}
-		if (!(-prefixcmp(line, "deepen "))) {
+		if (!prefixcmp(line, "deepen ")) {
 			char *end;
 			use_thin_pack = 0;
 			depth = strtol(line + 7, &end, 0);
@@ -523,7 +523,7 @@ static void receive_needs(void)
 				die("Invalid deepen: %s", line);
 			continue;
 		}
-		if ((-prefixcmp(line, "want ")) ||
+		if (prefixcmp(line, "want ") ||
 		    get_sha1_hex(line+5, sha1_buf))
 			die("git-upload-pack: protocol error, "
 			    "expected to get sha, not '%s'", line);
-- 
1.5.0.1.571.ge5a1a
