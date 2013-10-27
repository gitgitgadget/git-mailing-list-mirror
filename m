From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH] commit: Add -f, --fixes <commit> option to add Fixes: line
Date: Sun, 27 Oct 2013 01:34:02 +0000
Message-ID: <20131027013402.GA7146@leaf>
References: <20131024122255.GI9378@mwanda>
 <20131024122512.GB9534@mwanda>
 <20131026181709.GB10488@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Greg KH <greg@kroah.com>,
	ksummit-2013-discuss@lists.linuxfoundation.org,
	ksummit-attendees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Sun Oct 27 02:34:36 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1VaFFP-0001U2-7E
	for glk-linux-kernel-3@plane.gmane.org; Sun, 27 Oct 2013 02:34:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864Ab3J0BeL (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sat, 26 Oct 2013 21:34:11 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:50993 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551Ab3J0BeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Oct 2013 21:34:09 -0400
Received: from mfilter5-d.gandi.net (mfilter5-d.gandi.net [217.70.178.132])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id D2FF5A80BB;
	Sun, 27 Oct 2013 02:34:06 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter5-d.gandi.net
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
	by mfilter5-d.gandi.net (mfilter5-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id eHERHgjhncXP; Sun, 27 Oct 2013 02:34:05 +0100 (CET)
X-Originating-IP: 77.221.165.98
Received: from leaf (ip-77-221-165-98.dsl.twang.net [77.221.165.98])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 14801A808E;
	Sun, 27 Oct 2013 02:34:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131026181709.GB10488@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236770>

Linux Kernel Summit 2013 decided on a commit message convention to
identify commits containing bugs fixed by a commit: a "Fixes:" line,
included in the standard commit footer (along with "Signed-off-by:" if
present), containing an abbreviated commit hash (at least 12 characters
to keep it valid for a long time) and the subject of the commit (for
human readers).  This helps people (or automated tools) determine how
far to backport a commit.

Add a command line option for git commit to automatically construct the
"Fixes:" line for a commit.  This avoids the need to manually construct
that line by copy-pasting the commit hash and subject.

Also works with --amend to modify an existing commit's message.  To add
a Fixes line to an earlier commit in a series, use rebase -i and add the
following line after the existing commit:
x git commit --amend --no-edit -f $commit_containing_bug

Generalize append_signoff to support appending arbitrary extra lines to
a commit in the signoff block; this avoids duplicating the logic to find
or construct that block.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 Documentation/git-commit.txt | 12 ++++++++++--
 builtin/commit.c             | 29 +++++++++++++++++++++++++++--
 sequencer.c                  | 31 +++++++++++++++++++++++--------
 sequencer.h                  |  3 +++
 t/t7502-commit.sh            | 39 ++++++++++++++++++++++++++++++++++++++-
 5 files changed, 101 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 1a7616c..fcc6ed2 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -8,8 +8,8 @@ git-commit - Record changes to the repository
 SYNOPSIS
 --------
 [verse]
-'git commit' [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
-	   [--dry-run] [(-c | -C | --fixup | --squash) <commit>]
+'git commit' [-a | --interactive | --patch] [-s] [-f <commit>] [-v] [-u<mode>]
+	   [--amend] [--dry-run] [(-c | -C | --fixup | --squash) <commit>]
 	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
 	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
@@ -156,6 +156,14 @@ OPTIONS
 	Add Signed-off-by line by the committer at the end of the commit
 	log message.
 
+-f <commit>::
+--fixes=<commit>::
+	Add Fixes line for the specified commit at the end of the commit
+	log message.  This line includes an abbreviated commit hash for
+	the specified commit; the `core.abbrev` option determines the
+	length of the abbreviated commit hash used, with a minimum length
+	of 12 hex digits.
+
 -n::
 --no-verify::
 	This option bypasses the pre-commit and commit-msg hooks.
diff --git a/builtin/commit.c b/builtin/commit.c
index 6ab4605..9bbcd8a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -123,6 +123,7 @@ static int use_editor = 1, include_status = 1;
 static int show_ignored_in_status, have_option_m;
 static const char *only_include_assumed;
 static struct strbuf message = STRBUF_INIT;
+static struct strbuf fixes = STRBUF_INIT;
 
 static enum status_format {
 	STATUS_FORMAT_NONE = 0,
@@ -133,6 +134,28 @@ static enum status_format {
 	STATUS_FORMAT_UNSPECIFIED
 } status_format = STATUS_FORMAT_UNSPECIFIED;
 
+static int opt_parse_f(const struct option *opt, const char *arg, int unset)
+{
+	struct strbuf *sb = opt->value;
+	if (unset) {
+		strbuf_setlen(sb, 0);
+	} else {
+		struct pretty_print_context ctx = {0};
+		struct commit *commit;
+
+		commit = lookup_commit_reference_by_name(arg);
+		if (!commit)
+			die(_("could not lookup commit %s"), arg);
+		ctx.output_encoding = get_commit_output_encoding();
+		ctx.abbrev = DEFAULT_ABBREV;
+		if (ctx.abbrev < 12)
+			ctx.abbrev = 12;
+		format_commit_message(commit, "Fixes: %h ('%s')\n", sb, &ctx);
+	}
+
+	return 0;
+}
+
 static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 {
 	struct strbuf *buf = opt->value;
@@ -718,7 +741,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	if (clean_message_contents)
 		stripspace(&sb, 0);
 
-	if (signoff) {
+	if (signoff || fixes.len) {
 		/*
 		 * See if we have a Conflicts: block at the end. If yes, count
 		 * its size, so we can ignore it.
@@ -742,7 +765,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			previous = eol;
 		}
 
-		append_signoff(&sb, ignore_footer, 0);
+		append_signoff_extra(&sb, ignore_footer,
+				     signoff ? 0 : APPEND_EXTRA_ONLY, &fixes);
 	}
 
 	if (fwrite(sb.buf, 1, sb.len, s->fp) < sb.len)
@@ -1463,6 +1487,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
 		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
 		OPT_BOOL('s', "signoff", &signoff, N_("add Signed-off-by:")),
+		OPT_CALLBACK('f', "fixes", &fixes, N_("commit"), N_("add Fixes: for the specified commit"), opt_parse_f),
 		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
 		OPT_STRING(0, "cleanup", &cleanup_arg, N_("default"), N_("how to strip spaces and #comments from message")),
diff --git a/sequencer.c b/sequencer.c
index 06e52b4..f4cf0e1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1135,26 +1135,33 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	return pick_commits(todo_list, opts);
 }
 
-void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
+void append_signoff_extra(struct strbuf *msgbuf, int ignore_footer,
+			  unsigned flag, struct strbuf *extrabuf)
 {
 	unsigned no_dup_sob = flag & APPEND_SIGNOFF_DEDUP;
+	unsigned append_sob = !(flag & APPEND_EXTRA_ONLY);
 	struct strbuf sob = STRBUF_INIT;
 	int has_footer;
 
-	strbuf_addstr(&sob, sign_off_header);
-	strbuf_addstr(&sob, fmt_name(getenv("GIT_COMMITTER_NAME"),
-				getenv("GIT_COMMITTER_EMAIL")));
-	strbuf_addch(&sob, '\n');
+	if (append_sob) {
+		strbuf_addstr(&sob, sign_off_header);
+		strbuf_addstr(&sob, fmt_name(getenv("GIT_COMMITTER_NAME"),
+					getenv("GIT_COMMITTER_EMAIL")));
+		strbuf_addch(&sob, '\n');
+	}
 
 	/*
 	 * If the whole message buffer is equal to the sob, pretend that we
 	 * found a conforming footer with a matching sob
 	 */
-	if (msgbuf->len - ignore_footer == sob.len &&
+	if (append_sob &&
+	    msgbuf->len - ignore_footer == sob.len &&
 	    !strncmp(msgbuf->buf, sob.buf, sob.len))
 		has_footer = 3;
 	else
-		has_footer = has_conforming_footer(msgbuf, &sob, ignore_footer);
+		has_footer = has_conforming_footer(msgbuf,
+						   append_sob ? &sob : NULL,
+						   ignore_footer);
 
 	if (!has_footer) {
 		const char *append_newlines = NULL;
@@ -1193,9 +1200,17 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
 				append_newlines, strlen(append_newlines));
 	}
 
-	if (has_footer != 3 && (!no_dup_sob || has_footer != 2))
+	if (append_sob && has_footer != 3 && (!no_dup_sob || has_footer != 2))
 		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
 				sob.buf, sob.len);
+	if (extrabuf)
+		strbuf_insert(msgbuf, msgbuf->len - ignore_footer,
+				extrabuf->buf, extrabuf->len);
 
 	strbuf_release(&sob);
 }
+
+void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
+{
+	append_signoff_extra(msgbuf, ignore_footer, flag, NULL);
+}
diff --git a/sequencer.h b/sequencer.h
index 1fc22dc..8716ad0 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -7,6 +7,7 @@
 #define SEQ_OPTS_FILE	"sequencer/opts"
 
 #define APPEND_SIGNOFF_DEDUP (1u << 0)
+#define APPEND_EXTRA_ONLY (1u << 1)
 
 enum replay_action {
 	REPLAY_REVERT,
@@ -51,5 +52,7 @@ int sequencer_pick_revisions(struct replay_opts *opts);
 extern const char sign_off_header[];
 
 void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
+void append_signoff_extra(struct strbuf *msgbuf, int ignore_footer,
+			  unsigned flag, struct strbuf *extrabuf);
 
 #endif
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 6313da2..12b123a 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -137,13 +137,50 @@ test_expect_success 'partial removal' '
 
 '
 
+signoff_ident () {
+	git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/"
+}
+
 test_expect_success 'sign off' '
 
 	>positive &&
 	git add positive &&
 	git commit -s -m "thank you" &&
 	actual=$(git cat-file commit HEAD | sed -ne "s/Signed-off-by: //p") &&
-	expected=$(git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/") &&
+	expected=$(signoff_ident) &&
+	test "z$actual" = "z$expected"
+
+'
+
+fixes_for_commits () {
+	for commit in "$@"; do
+		git -c core.abbrev=12 log -1 --pretty=format:"Fixes: %h ('%s')%n" "$commit"
+	done
+}
+
+test_expect_success '--fixes' '
+
+	echo >>positive &&
+	git add positive &&
+	git commit -f HEAD -m "fix bug" &&
+	actual=$(git cat-file commit HEAD | sed -e "1,/^\$/d") &&
+	expected=$(echo fix bug; echo; fixes_for_commits HEAD^) &&
+	test "z$actual" = "z$expected"
+
+'
+
+test_expect_success 'multiple --fixes with signoff' '
+
+	echo >>positive &&
+	git add positive &&
+	git commit -f HEAD^ -f HEAD -s -m "signed bugfix" &&
+	actual=$(git cat-file commit HEAD | sed -e "1,/^\$/d") &&
+	expected=$(
+		echo signed bugfix
+		echo
+		echo "Signed-off-by: $(signoff_ident)"
+		fixes_for_commits HEAD^^ HEAD^
+	) &&
 	test "z$actual" = "z$expected"
 
 '
-- 
1.8.4.rc3
