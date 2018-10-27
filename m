Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D48F11F453
	for <e@80x24.org>; Sat, 27 Oct 2018 21:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbeJ1GMV (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 02:12:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40445 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbeJ1GMU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 02:12:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id i17-v6so4606963wre.7
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 14:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJEHAKvAxNWxnFfAtDxhScuhxeMydUZOlP+8nhHGWX0=;
        b=bhDKOBmrba+XF7ZYVEEykTOgJ3iIy9Ri9I17wSabL0jckj/4MazdNVfEsTanmR3WPH
         H8VxXPJKQo+OGUKPUUoNZMpI25VMQm1vpZLHFHZsIjbwhdx++ziUKuvG04+nyoHmd1Eb
         2ZA5loKV79521YYJvyYhBH1aGhHGZgDbcaU/Fv57XnuIJOff63kgu7K9ak0q47CYHkIa
         wd9BlTEGY/YmBco7vZyzzPqDPz8i1CdytmF7R4ibVxbJrCx8ZjPkp0VJxJaiwPPJ/qG9
         W2+tKp1cZ4cKE83I10Q28XuK10zcaAnjjHkZaLOy4vODNtXYYr4Yh9qL7f+xCa2G1mWw
         KbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJEHAKvAxNWxnFfAtDxhScuhxeMydUZOlP+8nhHGWX0=;
        b=neEL6PRf75Mq5g1rJfCW5xmj1fDJM7mFj4YS17ROuvg4oK/D+/lkB6qDOk3QGOkGiU
         STgs1r/wasSDlFYvnmHx5TCwU71ytdVTvJuf8aY5u0WoWqQrAKJKhLQLUiYqRY245i6l
         5mR5ihqL93bSfFoQP2HV1Pz7eRf6Aw2tL5CKRz7KqFYUHAJXYIs//PJTVgWpRRYMohG+
         cH/7rNkjkDKXz+R/XPpDV2Ec2s3s/hsGyigi9srhAqAplafflcyLTmOdV4HK+OEpZsf+
         jQKgOZoJYjjTbMgrR4KfKYiL64uYKdau1vHxstKoGh8PE8/kXxfZS2CCX1a/GnEBAJZf
         OotQ==
X-Gm-Message-State: AGRZ1gLkHVEv6U19Qwzhd5mr3JOptKqKJ7PYhVEzW394hhfqG72D8E59
        Wk6rprh6zoHgBo/fsYZx/I+LK6GE
X-Google-Smtp-Source: AJdET5eVLyB9zinb0nsPtMKszllG8aW3RnJ+gXXt9wteGSb4ijtg4ZL+/mWqpLlZ9OsG3YFwMj78nw==
X-Received: by 2002:adf:e34d:: with SMTP id n13-v6mr2579870wrj.158.1540675799672;
        Sat, 27 Oct 2018 14:29:59 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-19-179.w86-222.abo.wanadoo.fr. [86.222.18.179])
        by smtp.googlemail.com with ESMTPSA id t198-v6sm9842514wmd.9.2018.10.27.14.29.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 14:29:59 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 06/16] sequencer: refactor sequencer_add_exec_commands() to work on a todo_list
Date:   Sat, 27 Oct 2018 23:29:20 +0200
Message-Id: <20181027212930.9303-7-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181027212930.9303-1-alban.gruin@gmail.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
 <20181027212930.9303-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This refactors sequencer_add_exec_commands() to work on a todo_list to
avoid redundant reads and writes to the disk.

An obvious way to do this would be to insert the `exec' command between
the other commands, and reparse it once this is done.  This is not what
is done here.  Instead, the command is appended to the buffer once, and
a new list of items is created.  Items from the old list are copied to
it, and new `exec' items are appended when necessary.  This eliminates
the need to reparse the todo list, but this also means its buffer cannot
be directly written to the disk, hence todo_list_write_to_disk().

sequencer_add_exec_commands() still reads the todo list from the disk,
as it is needed by rebase -p.  todo_list_add_exec_commands() works on a
todo_list structure, and reparses it at the end.

complete_action() still uses sequencer_add_exec_commands() for now.
This will be changed in a future commit.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 69 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 20 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e12860c047..12a3efeca8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4216,6 +4216,50 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
 	return 0;
 }
 
+static void todo_list_add_exec_commands(struct todo_list *todo_list,
+					const char *commands)
+{
+	struct strbuf *buf = &todo_list->buf;
+	const char *old_buf = buf->buf;
+	size_t commands_len = strlen(commands + strlen("exec ")) - 1;
+	int i, first = 1, nr = 0, alloc = 0;
+	struct todo_item *items = NULL,
+		base_item = {TODO_EXEC, NULL, 0, 0, commands_len, 0};
+
+	strbuf_addstr(buf, commands);
+	base_item.offset_in_buf = buf->len - commands_len - 1;
+	base_item.arg = buf->buf + base_item.offset_in_buf;
+
+	/*
+	 * Insert <commands> after every pick. Here, fixup/squash chains
+	 * are considered part of the pick, so we insert the commands *after*
+	 * those chains if there are any.
+	 */
+	for (i = 0; i < todo_list->nr; i++) {
+		enum todo_command command = todo_list->items[i].command;
+		if (todo_list->items[i].arg)
+			todo_list->items[i].arg = todo_list->items[i].arg - old_buf + buf->buf;
+
+		if (command == TODO_PICK && !first) {
+			ALLOC_GROW(items, nr + 1, alloc);
+			memcpy(items + nr++, &base_item, sizeof(struct todo_item));
+		}
+
+		ALLOC_GROW(items, nr + 1, alloc);
+		memcpy(items + nr++, todo_list->items + i, sizeof(struct todo_item));
+		first = 0;
+	}
+
+	/* insert or append final <commands> */
+	ALLOC_GROW(items, nr + 1, alloc);
+	memcpy(items + nr++, &base_item, sizeof(struct todo_item));
+
+	FREE_AND_NULL(todo_list->items);
+	todo_list->items = items;
+	todo_list->nr = nr;
+	todo_list->alloc = alloc;
+}
+
 /*
  * Add commands after pick and (series of) squash/fixup commands
  * in the todo list.
@@ -4224,10 +4268,7 @@ int sequencer_add_exec_commands(const char *commands)
 {
 	const char *todo_file = rebase_path_todo();
 	struct todo_list todo_list = TODO_LIST_INIT;
-	struct todo_item *item;
-	struct strbuf *buf = &todo_list.buf;
-	size_t offset = 0, commands_len = strlen(commands);
-	int i, first;
+	int res;
 
 	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
 		return error(_("could not read '%s'."), todo_file);
@@ -4237,23 +4278,11 @@ int sequencer_add_exec_commands(const char *commands)
 		return error(_("unusable todo list: '%s'"), todo_file);
 	}
 
-	first = 1;
-	/* insert <commands> before every pick except the first one */
-	for (item = todo_list.items, i = 0; i < todo_list.nr; i++, item++) {
-		if (item->command == TODO_PICK && !first) {
-			strbuf_insert(buf, item->offset_in_buf + offset,
-				      commands, commands_len);
-			offset += commands_len;
-		}
-		first = 0;
-	}
-
-	/* append final <commands> */
-	strbuf_add(buf, commands, commands_len);
-
-	i = write_message(buf->buf, buf->len, todo_file, 0);
+	todo_list_add_exec_commands(&todo_list, commands);
+	res = todo_list_write_to_file(&todo_list, todo_file, NULL, NULL, 0, 0, -1, 0);
 	todo_list_release(&todo_list);
-	return i;
+
+	return res;
 }
 
 static void todo_list_to_strbuf(struct todo_list *todo_list, struct strbuf *buf,
-- 
2.19.1

