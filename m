Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CF571F405
	for <e@80x24.org>; Sat, 29 Dec 2018 16:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbeL2QFW (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 11:05:22 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40115 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbeL2QFR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 11:05:17 -0500
Received: by mail-ed1-f65.google.com with SMTP id g22so19665114edr.7
        for <git@vger.kernel.org>; Sat, 29 Dec 2018 08:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gyL/ONIgyYv/AAUsMJdSx4mFXEFmfNWU167kjivzRTc=;
        b=Kl7qJDdqEvcTTjZj7j+gVjeNrG0SNc18nmggn66eJEe5kHwtBuHoHkVBJaImTIZ0fp
         +8/SYoQ1lTBbYGrXhN+oF0Je2pyADMOczsS3wKn2A3+L6gHPkYTYXjTvH+lU7Wh1rW0D
         4LCdX+0Yj3KZsvQifHa+LKT8xTyPW8e/Q/PxulEQQOzjSrIuN7GgP989x3q77fHmRqjs
         kVJ/Lf5kIREosBdn5mJSGVLS5edUDOYmIa4RPTmRdYhwOteW7N20Xl85ULhQqONkMpOG
         LNhnWs5zb5sensxc6tIXLklA9NJK62zuP91ZDjkY8jBN4XTiqX11WpYSwpaeVvsBk2RD
         P/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gyL/ONIgyYv/AAUsMJdSx4mFXEFmfNWU167kjivzRTc=;
        b=UwFq1ygZhtf8Rfl2xyahUAtFlK/6oF909PubzQDouDkLfTUTBbRgaCjJvNOupl1EYM
         2/VOgRINV4LsntA9neXSS+IHOGrAOvdPaiar/6xEhL/S6xTMueoFyqnPtWarI9tGqlFH
         EsSf5ugNaH/88ceCrnEfWOZCanpgVlWBXaGx/Yit7gvI9AKqbycy/vcWVmwFAHFICi8f
         H/V9p8irWzS/gWvWV5cdTpbNgpxJmxemQXROD8bEtcboAlvXMDiedNMRhfQEKwLaP6pV
         iLpxzm6p5WG02DPEKcTijcndGuXbPwx1eT8oSa46J9XlJV1VOoKFg6TkLno3aBnB2YWD
         gSlw==
X-Gm-Message-State: AA+aEWbXXEaO1c+k27lFrq0b1+cmSQCeONYbaX753tBW9UAWOQ5QleJx
        LeEQg98blt7y9qUdwbTVzbLVC9eA
X-Google-Smtp-Source: AFSGD/VS+m6SaonOS1IiqPA0VV3IMUFalObcQrmB1zLDGcIgjKCYqTzTSC2tSuFFuRr7Mg4bTZdd+g==
X-Received: by 2002:a17:906:81cc:: with SMTP id e12-v6mr22787967ejx.138.1546099515621;
        Sat, 29 Dec 2018 08:05:15 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-184-107.w86-199.abo.wanadoo.fr. [86.199.39.107])
        by smtp.googlemail.com with ESMTPSA id b49sm15108663edb.73.2018.12.29.08.05.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 08:05:15 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v4 11/16] sequencer: refactor skip_unnecessary_picks() to work on a todo_list
Date:   Sat, 29 Dec 2018 17:04:08 +0100
Message-Id: <20181229160413.19333-12-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181229160413.19333-1-alban.gruin@gmail.com>
References: <20181109080805.6350-1-alban.gruin@gmail.com>
 <20181229160413.19333-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This refactors skip_unnecessary_picks() to work on a todo_list.  As this
function is only called by complete_action() (and thus is not used by
rebase -p), the file-handling logic is completely dropped here.

Instead of truncating the todo list’s buffer, the items are moved to
the beginning of the list, eliminating the need to reparse the list.
This also means its buffer cannot be directly written to the disk.

rewrite_file() is then removed, as it is now unused.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 78 ++++++++++++-----------------------------------------
 1 file changed, 17 insertions(+), 61 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ea5cea81a8..dfdba5cec0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4655,52 +4655,22 @@ int check_todo_list_from_file(struct repository *r)
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
-static int skip_unnecessary_picks(struct repository *r, struct object_id *output_oid)
+static int skip_unnecessary_picks(struct repository *r,
+				  struct todo_list *todo_list,
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
-	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list) < 0) {
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
@@ -4714,37 +4684,21 @@ static int skip_unnecessary_picks(struct repository *r, struct object_id *output
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
+		if (todo_list_write_to_file(r, todo_list, done_path, NULL, NULL, i, 0)) {
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
+		MOVE_ARRAY(todo_list->items, todo_list->items + i, todo_list->nr - i);
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
 
@@ -4817,6 +4771,11 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		return -1;
 	}
 
+	if (opts->allow_ff && skip_unnecessary_picks(r, &new_todo, &oid)) {
+		todo_list_release(&new_todo);
+		return error(_("could not skip unnecessary pick commands"));
+	}
+
 	if (todo_list_write_to_file(r, &new_todo, todo_file, NULL, NULL, -1,
 				    flags & ~(TODO_LIST_SHORTEN_IDS))) {
 		todo_list_release(&new_todo);
@@ -4825,9 +4784,6 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 
 	todo_list_release(&new_todo);
 
-	if (opts->allow_ff && skip_unnecessary_picks(r, &oid))
-		return error(_("could not skip unnecessary pick commands"));
-
 	if (checkout_onto(opts, onto_name, oid_to_hex(&oid), orig_head))
 		return -1;
 
-- 
2.20.1

