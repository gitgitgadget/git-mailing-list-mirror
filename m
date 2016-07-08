Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8C7B2023C
	for <e@80x24.org>; Fri,  8 Jul 2016 09:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754360AbcGHJNB (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 05:13:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:41880 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754355AbcGHJM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 05:12:59 -0400
Received: (qmail 5182 invoked by uid 102); 8 Jul 2016 09:13:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 05:13:00 -0400
Received: (qmail 11934 invoked by uid 107); 8 Jul 2016 09:13:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 05:13:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Jul 2016 05:12:55 -0400
Date:	Fri, 8 Jul 2016 05:12:55 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 8/8] use write_file_buf where applicable
Message-ID: <20160708091255.GH10152@sigill.intra.peff.net>
References: <20160708090400.GA26594@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160708090400.GA26594@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

There are several places where we open a file, write some
content from a strbuf, and close it. These can be simplified
with write_file_buf(). As a bonus, many of these did not
catch write problems at close() time.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/am.c    |  7 +------
 builtin/merge.c | 45 +++++----------------------------------------
 2 files changed, 6 insertions(+), 46 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 339e360..3ac2448 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -403,13 +403,8 @@ static int read_commit_msg(struct am_state *state)
  */
 static void write_commit_msg(const struct am_state *state)
 {
-	int fd;
 	const char *filename = am_path(state, "final-commit");
-
-	fd = xopen(filename, O_WRONLY | O_CREAT, 0666);
-	if (write_in_full(fd, state->msg, state->msg_len) < 0)
-		die_errno(_("could not write to %s"), filename);
-	close(fd);
+	write_file_buf(filename, state->msg, state->msg_len);
 }
 
 /**
diff --git a/builtin/merge.c b/builtin/merge.c
index b555a1b..2e782db 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -336,15 +336,9 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
 	struct rev_info rev;
 	struct strbuf out = STRBUF_INIT;
 	struct commit_list *j;
-	const char *filename;
-	int fd;
 	struct pretty_print_context ctx = {0};
 
 	printf(_("Squash commit -- not updating HEAD\n"));
-	filename = git_path_squash_msg();
-	fd = open(filename, O_WRONLY | O_CREAT, 0666);
-	if (fd < 0)
-		die_errno(_("Could not write to '%s'"), filename);
 
 	init_revisions(&rev, NULL);
 	rev.ignore_merges = 1;
@@ -371,10 +365,7 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
 			oid_to_hex(&commit->object.oid));
 		pretty_print_commit(&ctx, commit, &out);
 	}
-	if (write_in_full(fd, out.buf, out.len) != out.len)
-		die_errno(_("Writing SQUASH_MSG"));
-	if (close(fd))
-		die_errno(_("Finishing SQUASH_MSG"));
+	write_file_buf(git_path_squash_msg(), out.buf, out.len);
 	strbuf_release(&out);
 }
 
@@ -756,18 +747,6 @@ static void add_strategies(const char *string, unsigned attr)
 
 }
 
-static void write_merge_msg(struct strbuf *msg)
-{
-	const char *filename = git_path_merge_msg();
-	int fd = open(filename, O_WRONLY | O_CREAT, 0666);
-	if (fd < 0)
-		die_errno(_("Could not open '%s' for writing"),
-			  filename);
-	if (write_in_full(fd, msg->buf, msg->len) != msg->len)
-		die_errno(_("Could not write to '%s'"), filename);
-	close(fd);
-}
-
 static void read_merge_msg(struct strbuf *msg)
 {
 	const char *filename = git_path_merge_msg();
@@ -801,7 +780,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	strbuf_addch(&msg, '\n');
 	if (0 < option_edit)
 		strbuf_commented_addf(&msg, _(merge_editor_comment), comment_line_char);
-	write_merge_msg(&msg);
+	write_file_buf(git_path_merge_msg(), msg.buf, msg.len);
 	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-msg",
 			    git_path_merge_msg(), "merge", NULL))
 		abort_commit(remoteheads, NULL);
@@ -964,8 +943,6 @@ static int setup_with_upstream(const char ***argv)
 
 static void write_merge_state(struct commit_list *remoteheads)
 {
-	const char *filename;
-	int fd;
 	struct commit_list *j;
 	struct strbuf buf = STRBUF_INIT;
 
@@ -979,26 +956,14 @@ static void write_merge_state(struct commit_list *remoteheads)
 		}
 		strbuf_addf(&buf, "%s\n", oid_to_hex(oid));
 	}
-	filename = git_path_merge_head();
-	fd = open(filename, O_WRONLY | O_CREAT, 0666);
-	if (fd < 0)
-		die_errno(_("Could not open '%s' for writing"), filename);
-	if (write_in_full(fd, buf.buf, buf.len) != buf.len)
-		die_errno(_("Could not write to '%s'"), filename);
-	close(fd);
+	write_file_buf(git_path_merge_head(), buf.buf, buf.len);
 	strbuf_addch(&merge_msg, '\n');
-	write_merge_msg(&merge_msg);
+	write_file_buf(git_path_merge_msg(), merge_msg.buf, merge_msg.len);
 
-	filename = git_path_merge_mode();
-	fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0666);
-	if (fd < 0)
-		die_errno(_("Could not open '%s' for writing"), filename);
 	strbuf_reset(&buf);
 	if (fast_forward == FF_NO)
 		strbuf_addf(&buf, "no-ff");
-	if (write_in_full(fd, buf.buf, buf.len) != buf.len)
-		die_errno(_("Could not write to '%s'"), filename);
-	close(fd);
+	write_file_buf(git_path_merge_mode(), buf.buf, buf.len);
 }
 
 static int default_edit_option(void)
-- 
2.9.0.393.g704e522
