Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B7E61F453
	for <e@80x24.org>; Sat, 27 Oct 2018 21:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbeJ1GM0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 02:12:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39789 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbeJ1GMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 02:12:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id r10-v6so4654454wrv.6
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 14:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aCgVNTzZJiwcvEjaMFRkG/5QvG1A98RiznOWATvKmu8=;
        b=Rq79OkZb9nmjXQbPs+qdEK2ssg9qyuE3J2zcaEccOgVbq28bgRwpRcgD1wRw7S8lmU
         EaZ5HfEaQNSflksnSR4WOSwH9ZrPupZqBgbWv+HyaaEc0C8gO2HWL7dMuBK7qM8gTSzJ
         K+CVCf0mrautqNW8uEGyxXpFAf/Je3tzDqXpRnDPoqr6ogCrR7fQPDAnmFdONl7zyoq/
         P4l2rnv2xc1QM2JtTIoh2/01PqxS84o1ONQl9U9adAxKN7rwXm86Q/hUmNDsx31Wm54a
         qM5I7Yu/4qJkx/eCKKne8AUwyBzMQHC7yWxNbLozenAqx7EfkOv7lZkyKb36VlvFJTJ2
         plnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aCgVNTzZJiwcvEjaMFRkG/5QvG1A98RiznOWATvKmu8=;
        b=VId1Yvk7YBm2BC/ZQcv8u/5mx20qm11FKJcX/FLbu+1jh1rf6m1LgDplLHkB0H3+1F
         1Aodn3IKeKtMBZo+coqqWchXvCtgh4nOm3xotqYPty2xq+WHHjptZ7duXQdNDK4NcHRQ
         B6Tz1GiSr5FkSpj8ZfKxCGW90hUHbaWP6KH6O4zTDlp1qZ2Wdabt/U3MngdvcbiRGvKV
         zvaFffhhjzkbAZp8DkFvI1Kic6TAHztwvQahTdR2YliN5wxhR2I5W5SWV1O/KCcfsDpY
         bIfFE50MJ22My5OagUxovzegAcxqCbw2+Iz40zayjJTpFkc+XGn+iQWITpmDrdFwxCJy
         9I1Q==
X-Gm-Message-State: AGRZ1gJbfVv2o/21WZDU1TkwWwLxJveuBsuOb1ZPGbbt+MEhI7wv5BDE
        Rk99NJt6MtHxYHxluXXrnd+0XzF+
X-Google-Smtp-Source: AJdET5dH2ilmtXbYJ1d2jXrOIKRz4mIAcB54K2InP5bjUMVBYtB0jOp3r7QNgyaCOJrY6Rn65WLWIA==
X-Received: by 2002:a5d:4807:: with SMTP id l7-v6mr404974wrq.46.1540675805310;
        Sat, 27 Oct 2018 14:30:05 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-19-179.w86-222.abo.wanadoo.fr. [86.222.18.179])
        by smtp.googlemail.com with ESMTPSA id t198-v6sm9842514wmd.9.2018.10.27.14.30.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 14:30:04 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 10/16] sequencer: refactor skip_unnecessary_picks() to work on a todo_list
Date:   Sat, 27 Oct 2018 23:29:24 +0200
Message-Id: <20181027212930.9303-11-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181027212930.9303-1-alban.gruin@gmail.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
 <20181027212930.9303-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This refactors skip_unnecessary_picks() to work on a todo_list.  The
file-handling logic is completely dropped here, as its only usage is
made by complete_action().

Instead of truncating the todo list’s buffer, the items are moved to
the beginning of the list, eliminating the need to reparse the list.
This also means its buffer cannot be directly written to the disk.

rewrite_file() is then removed, as it is now unused.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 80 ++++++++++++-----------------------------------------
 1 file changed, 18 insertions(+), 62 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 1f7579328b..7286498572 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4408,52 +4408,21 @@ int check_todo_list_from_file(void)
 	return res;
 }
 
-static int rewrite_file(const char *path, const char *buf, size_t len)
-{
-	int rc = 0;
-	int fd = open(path, O_WRONLY | O_TRUNC);
-	if (fd < 0)
-		return error_errno(_("could not open '%s' for writing"), path);
-	if (write_in_full(fd, buf, len) < 0)
-		rc = error_errno(_("could not write to '%s'"), path);
-	if (close(fd) && !rc)
-		rc = error_errno(_("could not close '%s'"), path);
-	return rc;
-}
-
 /* skip picking commits whose parents are unchanged */
-static int skip_unnecessary_picks(struct object_id *output_oid)
+static int skip_unnecessary_picks(struct todo_list *todo_list,
+				  struct object_id *output_oid)
 {
-	const char *todo_file = rebase_path_todo();
-	struct strbuf buf = STRBUF_INIT;
-	struct todo_list todo_list = TODO_LIST_INIT;
 	struct object_id *parent_oid;
-	int fd, i;
-
-	if (!read_oneliner(&buf, rebase_path_onto(), 0))
-		return error(_("could not read 'onto'"));
-	if (get_oid(buf.buf, output_oid)) {
-		strbuf_release(&buf);
-		return error(_("need a HEAD to fixup"));
-	}
-	strbuf_release(&buf);
-
-	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
-		return -1;
-	if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
-		todo_list_release(&todo_list);
-		return -1;
-	}
+	int i;
 
-	for (i = 0; i < todo_list.nr; i++) {
-		struct todo_item *item = todo_list.items + i;
+	for (i = 0; i < todo_list->nr; i++) {
+		struct todo_item *item = todo_list->items + i;
 
 		if (item->command >= TODO_NOOP)
 			continue;
 		if (item->command != TODO_PICK)
 			break;
 		if (parse_commit(item->commit)) {
-			todo_list_release(&todo_list);
 			return error(_("could not parse commit '%s'"),
 				oid_to_hex(&item->commit->object.oid));
 		}
@@ -4467,37 +4436,22 @@ static int skip_unnecessary_picks(struct object_id *output_oid)
 		oidcpy(output_oid, &item->commit->object.oid);
 	}
 	if (i > 0) {
-		int offset = get_item_line_offset(&todo_list, i);
 		const char *done_path = rebase_path_done();
 
-		fd = open(done_path, O_CREAT | O_WRONLY | O_APPEND, 0666);
-		if (fd < 0) {
-			error_errno(_("could not open '%s' for writing"),
-				    done_path);
-			todo_list_release(&todo_list);
-			return -1;
-		}
-		if (write_in_full(fd, todo_list.buf.buf, offset) < 0) {
+		if (todo_list_write_to_file(todo_list, done_path, NULL, NULL, 0, 0, i, 0)) {
 			error_errno(_("could not write to '%s'"), done_path);
-			todo_list_release(&todo_list);
-			close(fd);
 			return -1;
 		}
-		close(fd);
 
-		if (rewrite_file(rebase_path_todo(), todo_list.buf.buf + offset,
-				 todo_list.buf.len - offset) < 0) {
-			todo_list_release(&todo_list);
-			return -1;
-		}
+		memmove(todo_list->items, todo_list->items + i,
+			sizeof(struct todo_item) * (todo_list->nr - i));
+		todo_list->nr -= i;
+		todo_list->current = 0;
 
-		todo_list.current = i;
-		if (is_fixup(peek_command(&todo_list, 0)))
-			record_in_rewritten(output_oid, peek_command(&todo_list, 0));
+		if (is_fixup(peek_command(todo_list, 0)))
+			record_in_rewritten(output_oid, peek_command(todo_list, 0));
 	}
 
-	todo_list_release(&todo_list);
-
 	return 0;
 }
 
@@ -4573,6 +4527,11 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 		return -1;
 	}
 
+	if (opts->allow_ff && skip_unnecessary_picks(&new_todo, &oid)) {
+		todo_list_release(&new_todo);
+		return error(_("could not skip unnecessary pick commands"));
+	}
+
 	if (todo_list_write_to_file(&new_todo, todo_file, NULL, NULL, 0, 0, -1,
 				    flags & ~(TODO_LIST_SHORTEN_IDS))) {
 		todo_list_release(&new_todo);
@@ -4581,12 +4540,9 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 
 	todo_list_release(&new_todo);
 
-	if (opts->allow_ff && skip_unnecessary_picks(&oid))
-		return error(_("could not skip unnecessary pick commands"));
-
 	if (checkout_onto(opts, onto_name, oid_to_hex(&oid), orig_head))
 		return -1;
-;
+
 	if (require_clean_work_tree("rebase", "", 1, 1))
 		return -1;
 
-- 
2.19.1

