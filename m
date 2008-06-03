From: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH] Keep committer and committer dates
Date: Tue, 3 Jun 2008 16:59:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0806031647320.1798@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 17:34:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3YX9-0006RP-Aw
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 17:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725AbYFCPdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 11:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752771AbYFCPdx
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 11:33:53 -0400
Received: from mail1.perex.cz ([212.20.107.53]:43962 "EHLO mail1.perex.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752712AbYFCPdv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 11:33:51 -0400
X-Greylist: delayed 2061 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Jun 2008 11:33:50 EDT
Received: from server.perex.cz (server.perex.cz [172.16.0.20])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 7B8F1149E6B
	for <git@vger.kernel.org>; Tue,  3 Jun 2008 16:59:23 +0200 (CEST)
Received: from tm8103.perex-int.cz (localhost [127.0.0.1])
	by server.perex.cz (Perex's E-mail Delivery System) with ESMTP id 6500184364
	for <git@vger.kernel.org>; Tue,  3 Jun 2008 16:59:23 +0200 (CEST)
Received: by tm8103.perex-int.cz (Postfix, from userid 1000)
	id 4A13B573DD; Tue,  3 Jun 2008 16:59:22 +0200 (CEST)
X-X-Sender: perex@tm8103-a.perex-int.cz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83675>

Hi all,

	I hope that you will find this patch useful. Please, CC: me (I'm 
not on git list).

	Full patch is also here:

http://git.alsa-project.org/?p=git.git;a=commit;h=cbf280c58b11c9ea32095ad0e9f8823f29093a87

					Thanks,
						Jaroslav

===========
From cbf280c58b11c9ea32095ad0e9f8823f29093a87 Mon Sep 17 00:00:00 2001
From: Jaroslav Kysela <perex@perex.cz>
Date: Tue, 3 Jun 2008 16:40:03 +0200
Subject: [PATCH] Keep committer and committer dates - am, rebase, mailinfo, format-patch

Sometimes, it should be avoided to modify committer information when
rebasing or shuffling patches. The --committer parameter was added
to git-am and git-rebase.

It implies next extensions to format-patch and mailinfo to store
and extract X-Git-Committer / X-Git-CommitterDate e-mail headers.

The git-rebase in this patch contains also --signoff for --continue
action extension to allow signing of modified contents of patch.
The git-am accepts --signresolved to pass this information.

Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 Documentation/git-am.txt           |   15 +++++++++-
 Documentation/git-format-patch.txt |    5 +++
 Documentation/git-rebase.txt       |   14 ++++++++-
 builtin-log.c                      |    5 +++-
 builtin-mailinfo.c                 |    8 +++++-
 commit.h                           |    1 +
 git-am.sh                          |   51 +++++++++++++++++++++++++++++++++++-
 git-rebase.sh                      |   32 +++++++++++++++++-----
 log-tree.c                         |    3 +-
 pretty.c                           |   31 ++++++++++++++--------
 10 files changed, 138 insertions(+), 27 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 2387a8d..cd83c0e 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -10,10 +10,11 @@ SYNOPSIS
 --------
 [verse]
 'git-am' [--signoff] [--keep] [--utf8 | --no-utf8]
-         [--3way] [--interactive] [--binary]
+         [--3way] [--interactive] [--binary] [--committer]
          [--whitespace=<option>] [-C<n>] [-p<n>]
          <mbox>|<Maildir>...
-'git-am' [--skip | --resolved]
+'git-am' --skip
+`git-am` [--signresolved] --resolved
 
 DESCRIPTION
 -----------
@@ -59,6 +60,11 @@ default.   You could use `--no-utf8` to override this.
 	Pass `--allow-binary-replacement` flag to `git-apply`
 	(see linkgit:git-apply[1]).
 
+--committer
+	Use committer and committer date extracted from
+	`X-Git-Committer` and `X-Git-CommitterDate` header
+	lines.
+
 --whitespace=<option>::
 	This flag is passed to the `git-apply` (see linkgit:git-apply[1])
 	program that applies
@@ -91,6 +97,11 @@ default.   You could use `--no-utf8` to override this.
 	or `--skip` to handle the failure.  This is solely
 	for internal use between `git-rebase` and `git-am`.
 
+--signresolved
+        Add `Signed-off-by:` line to the commit message, using
+        the committer identity of yourself for resolved merge.
+	Can be used only for `--resolved`.
+
 DISCUSSION
 ----------
 
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index fefcd26..662659f 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -19,6 +19,7 @@ SYNOPSIS
 		   [--subject-prefix=Subject-Prefix]
 		   [--cc=<email>]
 		   [--cover-letter]
+		   [--committer]
 		   [ <since> | <revision range> ]
 
 DESCRIPTION
@@ -141,6 +142,10 @@ include::diff-options.txt[]
 	Add a "Cc:" header to the email headers. This is in addition
 	to any configured headers, and may be used multiple times.
 
+--committer::
+	Store original commiter information to `X-Git-Committer` and
+        `X-Git-CommitterDate` headers.
+
 --cover-letter::
 	Generate a cover letter template.  You still have to fill in
 	a description, but the shortlog and the diffstat will be
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index e0412e0..c64e6b0 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -11,8 +11,9 @@ SYNOPSIS
 'git-rebase' [-i | --interactive] [-v | --verbose] [-m | --merge]
 	[-s <strategy> | --strategy=<strategy>]
 	[-C<n>] [ --whitespace=<option>] [-p | --preserve-merges]
-	[--onto <newbase>] <upstream> [<branch>]
-'git-rebase' --continue | --skip | --abort
+	[--onto <newbase>] [--committer] <upstream> [<branch>]
+'git-rebase' --skip | --abort
+'git-rebase' [--signoff] --continue
 
 DESCRIPTION
 -----------
@@ -247,6 +248,15 @@ OPTIONS
 	Instead of ignoring merges, try to recreate them.  This option
 	only works in interactive mode.
 
+--committer
+	Preserve original commmitter and committer date.
+
+--signoff
+        Add `Signed-off-by:` line to the commit message, using
+        the committer identity of yourself for resolved merge.
+	Can be used only for `--continue`.
+
+
 include::merge-strategies.txt[]
 
 NOTES
diff --git a/builtin-log.c b/builtin-log.c
index 9817d6f..1c51e29 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -882,6 +882,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			cover_letter = 1;
 		else if (!strcmp(argv[i], "--no-binary"))
 			no_binary_diff = 1;
+		else if (!strcmp(argv[i], "--committer"))
+			rev.commit_format = CMIT_FMT_CEMAIL;
 		else
 			argv[j++] = argv[i];
 	}
@@ -1015,7 +1017,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (cover_letter) {
 		if (thread)
 			gen_message_id(&rev, "cover");
-		make_cover_letter(&rev, use_stdout, numbered, numbered_files,
+		make_cover_letter(&rev, use_stdout,
+				  numbered, numbered_files,
 				  origin, nr, list, head);
 		total++;
 		start_number--;
diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 97c1ff9..9af0d6d 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -289,7 +289,7 @@ static void cleanup_space(char *buf)
 
 static void decode_header(char *it, unsigned itsize);
 static const char *header[MAX_HDR_PARSED] = {
-	"From","Subject","Date",
+	"From","Subject","Date","X-Git-Committer","X-Git-CommitterDate"
 };
 
 static int check_header(char *line, unsigned linesize, char **hdr_data, int overwrite)
@@ -911,6 +911,12 @@ static void handle_info(void)
 			handle_from(hdr);
 			fprintf(fout, "Author: %s\n", name);
 			fprintf(fout, "Email: %s\n", email);
+		} else if (!memcmp(header[i], "X-Git-Committer\0", 16)) {
+			handle_from(hdr);
+			fprintf(fout, "Committer: %s\n", name);
+			fprintf(fout, "CommitterEmail: %s\n", email);
+		} else if (!memcmp(header[i], "X-Git-CommitterDate\0", 20)) {
+			fprintf(fout, "CommitterDate: %s\n", hdr);
 		} else {
 			cleanup_space(hdr);
 			fprintf(fout, "%s: %s\n", header[i], hdr);
diff --git a/commit.h b/commit.h
index 2d94d41..f6ec25e 100644
--- a/commit.h
+++ b/commit.h
@@ -57,6 +57,7 @@ enum cmit_fmt {
 	CMIT_FMT_FULLER,
 	CMIT_FMT_ONELINE,
 	CMIT_FMT_EMAIL,
+	CMIT_FMT_CEMAIL,
 	CMIT_FMT_USERFORMAT,
 
 	CMIT_FMT_UNSPECIFIED,
diff --git a/git-am.sh b/git-am.sh
index b48096e..010d13c 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -14,8 +14,10 @@ i,interactive   run interactively
 b,binary        pass --allow-binary-replacement to git-apply
 3,3way          allow fall back on 3way merging if needed
 s,signoff       add a Signed-off-by line to the commit message
+signresolved    only for --resolved command - sign-off-by the change
 u,utf8          recode into utf8 (default)
 k,keep          pass -k flag to git-mailinfo
+committer       handle committer and committer date
 whitespace=     pass it through git-apply
 C=              pass it through git-apply
 p=              pass it through git-apply
@@ -120,7 +122,7 @@ It does not apply to blobs recorded in its index."
 prec=4
 dotest=".dotest"
 sign= utf8=t keep= skip= interactive= resolved= binary= rebasing=
-resolvemsg= resume=
+resolvemsg= resume= committer= signresolved=
 git_apply_opt=
 
 while test $# != 0
@@ -142,6 +144,8 @@ do
 		keep=t ;;
 	-r|--resolved)
 		resolved=t ;;
+	--signresolved)
+		signresolved=t ;;
 	--skip)
 		skip=t ;;
 	--rebasing)
@@ -155,6 +159,8 @@ do
 		git_apply_opt="$git_apply_opt $1=$2"; shift ;;
 	-C|-p)
 		git_apply_opt="$git_apply_opt $1$2"; shift ;;
+	--committer)
+		committer="--committer"; shift ;;
 	--)
 		shift; break ;;
 	*)
@@ -347,6 +353,17 @@ do
 	GIT_AUTHOR_NAME="$(sed -n '/^Author/ s/Author: //p' "$dotest/info")"
 	GIT_AUTHOR_EMAIL="$(sed -n '/^Email/ s/Email: //p' "$dotest/info")"
 	GIT_AUTHOR_DATE="$(sed -n '/^Date/ s/Date: //p' "$dotest/info")"
+	if test -n "$committer" -a -z "$resume"
+	then
+		GIT_COMMITTER_NAME="$(sed -n '/^Committer/ s/Committer: //p' "$dotest/info")"
+		GIT_COMMITTER_EMAIL="$(sed -n '/^CommitterEmail/ s/CommitterEmail: //p' "$dotest/info")"
+		GIT_COMMITTER_DATE="$(sed -n '/^CommitterDate/ s/CommitterDate: //p' "$dotest/info")"
+		if test -z "$GIT_COMMITTER_EMAIL"
+		then
+			echo "Patch does not have a valid committer e-mail address."
+			stop_here $this
+		fi
+	fi
 
 	if test -z "$GIT_AUTHOR_EMAIL"
 	then
@@ -355,6 +372,10 @@ do
 	fi
 
 	export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
+	if test -n "$committer" -a -z "$resume"
+	then
+		export GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL GIT_COMMITTER_DATE
+	fi
 
 	case "$resume" in
 	'')
@@ -393,6 +414,34 @@ do
 		esac
 	esac
 
+	if test -n "$signresolved" -a -n "$resume"
+	then
+	    SIGNOFF1=`git-var GIT_COMMITTER_IDENT | sed -e '
+			s/>.*/>/
+			s/^/Signed-off-by: /'
+	    `
+	    LAST_SIGNED_OFF_BY=`
+		    sed -ne '/^Signed-off-by: /p' \
+		    "$dotest/final-commit" |
+		    sed -ne '$p'
+	    `
+	    ADD_SIGNOFF=`
+		    test "$LAST_SIGNED_OFF_BY" = "$SIGNOFF1" || {
+		    test '' = "$LAST_SIGNED_OFF_BY" && echo
+		    echo "$SIGNOFF1"
+	    }`
+	    {
+		if test -s "$dotest/final-commit"
+		then
+			cat "$dotest/final-commit"
+		fi
+		if test '' != "$ADD_SIGNOFF"
+		then
+			echo "$ADD_SIGNOFF"
+		fi
+	    } >"$dotest/final-commit"
+	fi
+
 	resume=
 	if test "$interactive" = t
 	then
diff --git a/git-rebase.sh b/git-rebase.sh
index dd7dfe1..d835f30 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -12,9 +12,9 @@ It then attempts to create a new commit for each commit from the original
 
 It is possible that a merge failure will prevent this process from being
 completely automatic.  You will have to resolve any such merge failure
-and run git rebase --continue.  Another option is to bypass the commit
-that caused the merge failure with git rebase --skip.  To restore the
-original <branch> and remove the .dotest working files, use the command
+and run git rebase [--signoff] --continue.  Another option is to bypass
+the commit that caused the merge failure with git rebase --skip.  To restore
+the original <branch> and remove the .dotest working files, use the command
 git rebase --abort instead.
 
 Note that if <branch> is not specified on the command line, the
@@ -46,6 +46,7 @@ dotest=$GIT_DIR/.dotest-merge
 prec=4
 verbose=
 git_am_opt=
+committer=
 
 continue_merge () {
 	test -n "$prev_head" || die "prev_head must be defined"
@@ -170,10 +171,16 @@ do
 			finish_rb_merge
 			exit
 		fi
+		signresolved=
+		if test -n "$signoff"
+		then
+			signresolved="--signresolved"
+		fi
 		head_name=$(cat .dotest/head-name) &&
 		onto=$(cat .dotest/onto) &&
 		orig_head=$(cat .dotest/orig-head) &&
-		git am --resolved --3way --resolvemsg="$RESOLVEMSG" &&
+		committer=$(cat .dotest/committer) &&
+		git am --resolved $signresolved --3way --resolvemsg="$RESOLVEMSG" $committer &&
 		move_to_original_branch
 		exit
 		;;
@@ -198,7 +205,8 @@ do
 		head_name=$(cat .dotest/head-name) &&
 		onto=$(cat .dotest/onto) &&
 		orig_head=$(cat .dotest/orig-head) &&
-		git am -3 --skip --resolvemsg="$RESOLVEMSG" &&
+		committer=$(cat .dotest/committer) &&
+		git am -3 --skip --resolvemsg="$RESOLVEMSG" $committer &&
 		move_to_original_branch
 		exit
 		;;
@@ -249,6 +257,12 @@ do
 	-C*)
 		git_am_opt="$git_am_opt $1"
 		;;
+	--committer)
+		committer="--committer"
+		;;
+	--signoff)
+		signoff=t
+		;;
 	-*)
 		usage
 		;;
@@ -386,14 +400,15 @@ fi
 if test -z "$do_merge"
 then
 	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
-		"$upstream..$orig_head" |
-	git am $git_am_opt --rebasing --resolvemsg="$RESOLVEMSG" &&
+		$committer "$upstream..$orig_head" |
+	git am $git_am_opt --rebasing --resolvemsg="$RESOLVEMSG" $committer &&
 	move_to_original_branch
 	ret=$?
 	test 0 != $ret -a -d .dotest &&
 		echo $head_name > .dotest/head-name &&
 		echo $onto > .dotest/onto &&
-		echo $orig_head > .dotest/orig-head
+		echo $orig_head > .dotest/orig-head &&
+		echo $committer > .dotest/committer
 	exit $ret
 fi
 
@@ -407,6 +422,7 @@ prev_head=$orig_head
 echo "$prev_head" > "$dotest/prev_head"
 echo "$orig_head" > "$dotest/orig-head"
 echo "$head_name" > "$dotest/head-name"
+echo "$committer" > "$dotest/committer"
 
 msgnum=0
 for cmt in `git rev-list --reverse --no-merges "$upstream..$orig_head"`
diff --git a/log-tree.c b/log-tree.c
index 5505606..da319ef 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -287,7 +287,8 @@ void show_log(struct rev_info *opt)
 	 * Print header line of header..
 	 */
 
-	if (opt->commit_format == CMIT_FMT_EMAIL) {
+	if (opt->commit_format == CMIT_FMT_EMAIL ||
+	    opt->commit_format == CMIT_FMT_CEMAIL) {
 		log_write_email_headers(opt, sha1_to_hex(commit->object.sha1),
 					&subject, &extra_headers,
 					&need_8bit_cte);
diff --git a/pretty.c b/pretty.c
index 8eb39e9..2fb062f 100644
--- a/pretty.c
+++ b/pretty.c
@@ -18,6 +18,7 @@ void get_commit_format(const char *arg, struct rev_info *rev)
 		{ "medium",	1,	CMIT_FMT_MEDIUM },
 		{ "short",	1,	CMIT_FMT_SHORT },
 		{ "email",	1,	CMIT_FMT_EMAIL },
+		{ "cemail",	1,	CMIT_FMT_CEMAIL },
 		{ "full",	5,	CMIT_FMT_FULL },
 		{ "fuller",	5,	CMIT_FMT_FULLER },
 		{ "oneline",	1,	CMIT_FMT_ONELINE },
@@ -135,7 +136,7 @@ void pp_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
 	time = strtoul(date, &date, 10);
 	tz = strtol(date, NULL, 10);
 
-	if (fmt == CMIT_FMT_EMAIL) {
+	if (fmt == CMIT_FMT_EMAIL || fmt == CMIT_FMT_CEMAIL) {
 		char *name_tail = strchr(line, '<');
 		int display_name_length;
 		if (!name_tail)
@@ -144,7 +145,12 @@ void pp_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
 			name_tail--;
 		display_name_length = name_tail - line;
 		filler = "";
-		strbuf_addstr(sb, "From: ");
+		if (fmt == CMIT_FMT_CEMAIL) {
+			strbuf_addstr(sb, what);
+			strbuf_addstr(sb, ": ");
+		} else {
+			strbuf_addstr(sb, "From: ");
+		}
 		add_rfc2047(sb, line, display_name_length, encoding);
 		strbuf_add(sb, name_tail, namelen - display_name_length);
 		strbuf_addch(sb, '\n');
@@ -160,6 +166,7 @@ void pp_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
 	case CMIT_FMT_EMAIL:
 		strbuf_addf(sb, "Date: %s\n", show_date(time, tz, DATE_RFC2822));
 		break;
+	case CMIT_FMT_CEMAIL:
 	case CMIT_FMT_FULLER:
 		strbuf_addf(sb, "%sDate: %s\n", what, show_date(time, tz, dmode));
 		break;
@@ -184,7 +191,7 @@ static void add_merge_info(enum cmit_fmt fmt, struct strbuf *sb,
 	struct commit_list *parent = commit->parents;
 
 	if ((fmt == CMIT_FMT_ONELINE) || (fmt == CMIT_FMT_EMAIL) ||
-	    !parent || !parent->next)
+	    (fmt == CMIT_FMT_CEMAIL) || !parent || !parent->next)
 		return;
 
 	strbuf_addstr(sb, "Merge:");
@@ -638,12 +645,13 @@ static void pp_header(enum cmit_fmt fmt,
 		 */
 		if (!memcmp(line, "author ", 7)) {
 			strbuf_grow(sb, linelen + 80);
-			pp_user_info("Author", fmt, sb, line + 7, dmode, encoding);
+			pp_user_info("Author", fmt == CMIT_FMT_CEMAIL ? CMIT_FMT_EMAIL : fmt, sb, line + 7, dmode, encoding);
 		}
 		if (!memcmp(line, "committer ", 10) &&
-		    (fmt == CMIT_FMT_FULL || fmt == CMIT_FMT_FULLER)) {
+		    (fmt == CMIT_FMT_FULL || fmt == CMIT_FMT_FULLER ||
+		     fmt == CMIT_FMT_CEMAIL)) {
 			strbuf_grow(sb, linelen + 80);
-			pp_user_info("Commit", fmt, sb, line + 10, dmode, encoding);
+			pp_user_info(fmt == CMIT_FMT_CEMAIL ? "X-Git-Committer" : "Commit", fmt, sb, line + 10, dmode, encoding);
 		}
 	}
 }
@@ -742,6 +750,7 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 {
 	unsigned long beginning_of_body;
 	int indent = 4;
+	int email = fmt == CMIT_FMT_EMAIL || fmt == CMIT_FMT_CEMAIL;
 	const char *msg = commit->buffer;
 	char *reencoded;
 	const char *encoding;
@@ -761,14 +770,14 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 		msg = reencoded;
 	}
 
-	if (fmt == CMIT_FMT_ONELINE || fmt == CMIT_FMT_EMAIL)
+	if (fmt == CMIT_FMT_ONELINE || email)
 		indent = 0;
 
 	/*
 	 * We need to check and emit Content-type: to mark it
 	 * as 8-bit if we haven't done so.
 	 */
-	if (fmt == CMIT_FMT_EMAIL && need_8bit_cte == 0) {
+	if (email && need_8bit_cte == 0) {
 		int i, ch, in_body;
 
 		for (in_body = i = 0; (ch = msg[i]); i++) {
@@ -804,8 +813,8 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 	}
 
 	/* These formats treat the title line specially. */
-	if (fmt == CMIT_FMT_ONELINE || fmt == CMIT_FMT_EMAIL)
-		pp_title_line(fmt, &msg, sb, subject,
+	if (fmt == CMIT_FMT_ONELINE || email)
+		pp_title_line(email ? CMIT_FMT_EMAIL : fmt, &msg, sb, subject,
 			      after_subject, encoding, need_8bit_cte);
 
 	beginning_of_body = sb->len;
@@ -822,7 +831,7 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 	 * format.  Make sure we did not strip the blank line
 	 * between the header and the body.
 	 */
-	if (fmt == CMIT_FMT_EMAIL && sb->len <= beginning_of_body)
+	if (email && sb->len <= beginning_of_body)
 		strbuf_addch(sb, '\n');
 	free(reencoded);
 }
-- 
1.5.6.rc1.dirty
===========

Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
