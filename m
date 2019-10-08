Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E52A41F4BE
	for <e@80x24.org>; Tue,  8 Oct 2019 07:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbfJHHzG (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 03:55:06 -0400
Received: from smtp.soverin.net ([159.69.232.138]:34279 "EHLO smtp.soverin.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730209AbfJHHzG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 03:55:06 -0400
X-Greylist: delayed 508 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Oct 2019 03:55:04 EDT
Received: from soverin.net by soverin.net
From:   Toon Claes <toon@iotcl.com>
To:     git@vger.kernel.org
Cc:     Toon Claes <toon@iotcl.com>,
        Zeger-Jan van de Weg <git@zjvandeweg.nl>
Subject: [PATCH 1/1] commit: add support to provide --coauthor
Date:   Tue,  8 Oct 2019 09:49:35 +0200
Message-Id: <20191008074935.10972-1-toon@iotcl.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.101.4 at c03mi01
X-Virus-Status: Clean
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add support to provide the Co-author when committing. For each
co-author provided with --coauthor=<coauthor>, a line is added at the
bottom of the commit message, like this:

    Co-authored-by: <coauthor>

It's a common practice use when pairing up with other people and both
authors want to in the commit message.

Co-authored-by: Zeger-Jan van de Weg <git@zjvandeweg.nl>
Signed-off-by: Toon Claes <toon@iotcl.com>
---
 Documentation/git-commit.txt |  5 ++++
 builtin/commit.c             |  7 ++++++
 sequencer.c                  | 44 ++++++++++++++++++++++++++----------
 sequencer.h                  |  2 ++
 t/t7502-commit-porcelain.sh  | 11 +++++++++
 5 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index afa7b75a23..c059944e38 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -140,6 +140,11 @@ OPTIONS
 	commit by that author (i.e. rev-list --all -i --author=<author>);
 	the commit author is then copied from the first such commit found.

+--coauthor=<coauthor>::
+        Add a Co-authored-by line with the specified author. Specify the
+	author using the standard `Co Artur <co-artur@example.com>`
+	format.
+
 --date=<date>::
 	Override the author date used in the commit.

diff --git a/builtin/commit.c b/builtin/commit.c
index ae7aaf6dc6..feb423ed6f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -110,6 +110,7 @@ static int config_commit_verbose = -1; /* unspecified */
 static int no_post_rewrite, allow_empty_message;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
 static char *sign_commit;
+static struct string_list coauthors = STRING_LIST_INIT_NODUP;

 /*
  * The default commit message cleanup mode will remove the lines
@@ -672,6 +673,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	int clean_message_contents = (cleanup_mode != COMMIT_MSG_CLEANUP_NONE);
 	int old_display_comment_prefix;
 	int merge_contains_scissors = 0;
+	int i;

 	/* This checks and barfs if author is badly specified */
 	determine_author_info(author_ident);
@@ -803,6 +805,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	if (clean_message_contents)
 		strbuf_stripspace(&sb, 0);

+	for (i = 0; i < coauthors.nr; i++) {
+		append_coauthor(&sb, coauthors.items[i].string);
+	}
+
 	if (signoff)
 		append_signoff(&sb, ignore_non_trailer(sb.buf, sb.len), 0);

@@ -1504,6 +1510,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
 		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
 		OPT_BOOL('s', "signoff", &signoff, N_("add Signed-off-by:")),
+		OPT_STRING_LIST(0, "coauthor", &coauthors, N_("co-author"), N_("add Co-authored-by:")),
 		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
 		OPT_CLEANUP(&cleanup_arg),
diff --git a/sequencer.c b/sequencer.c
index d648aaf416..8958a22470 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -36,6 +36,7 @@
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"

 static const char sign_off_header[] = "Signed-off-by: ";
+static const char coauthor_header[] = "Co-authored-by: ";
 static const char cherry_picked_prefix[] = "(cherry picked from commit ";

 GIT_PATH_FUNC(git_path_commit_editmsg, "COMMIT_EDITMSG")
@@ -4385,15 +4386,9 @@ int sequencer_pick_revisions(struct repository *r,
 	return res;
 }

-void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
+static void append_footer(struct strbuf *msgbuf, struct strbuf* sob, size_t ignore_footer, size_t no_dup_sob)
 {
-	unsigned no_dup_sob = flag & APPEND_SIGNOFF_DEDUP;
-	struct strbuf sob = STRBUF_INIT;
-	int has_footer;
-
-	strbuf_addstr(&sob, sign_off_header);
-	strbuf_addstr(&sob, fmt_name(WANT_COMMITTER_IDENT));
-	strbuf_addch(&sob, '\n');
+	size_t has_footer;

 	if (!ignore_footer)
 		strbuf_complete_line(msgbuf);
@@ -4402,11 +4397,11 @@ void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
 	 * If the whole message buffer is equal to the sob, pretend that we
 	 * found a conforming footer with a matching sob
 	 */
-	if (msgbuf->len - ignore_footer == sob.len &&
-	    !strncmp(msgbuf->buf, sob.buf, sob.len))
+	if (msgbuf->len - ignore_footer == sob->len &&
+	    !strncmp(msgbuf->buf, sob->buf, sob->len))
 		has_footer = 3;
 	else
-		has_footer = has_conforming_footer(msgbuf, &sob, ignore_footer);
+		has_footer = has_conforming_footer(msgbuf, sob, ignore_footer);

 	if (!has_footer) {
 		const char *append_newlines = NULL;
@@ -4440,7 +4435,32 @@ void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)

 	if (has_footer != 3 && (!no_dup_sob || has_footer != 2))
 		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
-				sob.buf, sob.len);
+				sob->buf, sob->len);
+}
+
+void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
+{
+	unsigned no_dup_sob = flag & APPEND_SIGNOFF_DEDUP;
+	struct strbuf sob = STRBUF_INIT;
+
+	strbuf_addstr(&sob, sign_off_header);
+	strbuf_addstr(&sob, fmt_name(WANT_COMMITTER_IDENT));
+	strbuf_addch(&sob, '\n');
+
+	append_footer(msgbuf, &sob, ignore_footer, no_dup_sob);
+
+	strbuf_release(&sob);
+}
+
+void append_coauthor(struct strbuf *msgbuf, const char *coauthor)
+{
+	struct strbuf sob = STRBUF_INIT;
+
+	strbuf_addstr(&sob, coauthor_header);
+	strbuf_addstr(&sob, coauthor);
+	strbuf_addch(&sob, '\n');
+
+	append_footer(msgbuf, &sob, 0, 1);

 	strbuf_release(&sob);
 }
diff --git a/sequencer.h b/sequencer.h
index 574260f621..e36489fce7 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -170,6 +170,8 @@ int todo_list_rearrange_squash(struct todo_list *todo_list);
  */
 void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag);

+void append_coauthor(struct strbuf *msgbuf, const char* co_author);
+
 void append_conflicts_hint(struct index_state *istate,
 		struct strbuf *msgbuf, enum commit_msg_cleanup_mode cleanup_mode);
 enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index 14c92e4c25..5ed6735cf4 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -138,6 +138,17 @@ test_expect_success 'partial removal' '

 '

+test_expect_success 'co-author' '
+
+	>coauthor &&
+	git add coauthor &&
+	git commit -m "thank you" --co-author="Author <author@example.com>" &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -ne "s/Co-authored-by: //p" commit.msg >actual &&
+	echo "Author <author@example.com>" >expected &&
+	test_cmp expected actual
+'
+
 test_expect_success 'sign off' '

 	>positive &&
--
2.22.0.rc3
