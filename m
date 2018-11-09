Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E1931F453
	for <e@80x24.org>; Fri,  9 Nov 2018 08:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbeKIRsK (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 12:48:10 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40884 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbeKIRsK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 12:48:10 -0500
Received: by mail-wr1-f65.google.com with SMTP id i17-v6so872595wre.7
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 00:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kmDoMDylQvZalnCewT2X78OkOkPs00VUGa8xphHnbnA=;
        b=lMn24cfMlt2wZiGeEz+2svaffBFtljDywCJ6jQDEAO/xfwg7har9+O9vfS0aXeQcmz
         P4ljma6h8Hlyk5lpsUb57ASIXfK8Qck9UjHt8LNy3Qfuhx6rb3EEBLonDqZfMpjUCDwk
         1QVzhBG1JAPwbYTja8HO2LiJMiSZJUINJmIpjvI0ZsnuWcaD+ecG+bdwZZzdSxeEt3bP
         XBQA0OhaGAbFL02kSWFVDe203krMzM/lR2HC8KNy6buNfekJhU0HNj2uccTePFVD7T4G
         WmD6qtJSbx1dVWgjMyFmZTyoymzQMhb0TW9b0bTqoEFuy+RD8ME5Q+lDUUSUfpE5LvGe
         wDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kmDoMDylQvZalnCewT2X78OkOkPs00VUGa8xphHnbnA=;
        b=nHzQWlHeFNwIN1BJh+TVvHZK/d/UGuqgMFBYtSLLhViqmOP6tRi2kKOj1z/ZrlIO3F
         KrExHTOV/6otqAtKUawNnpf8Ri68Iv6Hz0T4pP8+Cghuacj5nv9P3PfNUPrGKtWjU38I
         hSJ8JY/lIIgVToakNYPxYeGJIGqloGetcYmHx5oAgCPHUz0RUigfTazGAJXAoy6+o8C9
         S3q/bTX4RUVtO+t84OSOlj0ubQC/QDQwhgE0brgLRwT/XIPX8aVQbm79v6iA0pv89zqz
         LbfER7Slkb75JRaMvitUh4PHvUSf5rTKhU+VLET52nUDyBoCtnzduXLLr+9SBEqVqimI
         s3hw==
X-Gm-Message-State: AGRZ1gJLVNkLPXR7EhPRgjRAqbYZij649GrauWOyvxAwDBDMXtyFboO2
        vyavJqk3N9HqwJuBaAICF6LNIFfo
X-Google-Smtp-Source: AJdET5fl6qUIUW8jR3fbJPqQN8S0jesx8WUFkjrwPxCB9nCo6rApHcB2Cp42Q/kCeQon1FVldPGX/g==
X-Received: by 2002:a5d:51cb:: with SMTP id n11-v6mr6855143wrv.121.1541750922316;
        Fri, 09 Nov 2018 00:08:42 -0800 (PST)
Received: from andromeda.lan (atoulouse-658-1-60-221.w92-136.abo.wanadoo.fr. [92.136.157.221])
        by smtp.googlemail.com with ESMTPSA id x194-v6sm3003973wmd.41.2018.11.09.00.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 00:08:41 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 10/16] sequencer: refactor skip_unnecessary_picks() to work on a todo_list
Date:   Fri,  9 Nov 2018 09:07:59 +0100
Message-Id: <20181109080805.6350-11-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181109080805.6350-1-alban.gruin@gmail.com>
References: <20181027212930.9303-1-alban.gruin@gmail.com>
 <20181109080805.6350-1-alban.gruin@gmail.com>
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
 sequencer.c | 79 ++++++++++++-----------------------------------------
 1 file changed, 17 insertions(+), 62 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 64a99ab84f..1c405763c3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4607,52 +4607,21 @@ int check_todo_list_from_file(void)
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
@@ -4666,37 +4635,21 @@ static int skip_unnecessary_picks(struct object_id *output_oid)
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
+		if (todo_list_write_to_file(todo_list, done_path, NULL, NULL, i, 0)) {
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
 
@@ -4770,6 +4723,11 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 		return -1;
 	}
 
+	if (opts->allow_ff && skip_unnecessary_picks(&new_todo, &oid)) {
+		todo_list_release(&new_todo);
+		return error(_("could not skip unnecessary pick commands"));
+	}
+
 	if (todo_list_write_to_file(&new_todo, todo_file, NULL, NULL, -1,
 				    flags & ~(TODO_LIST_SHORTEN_IDS))) {
 		todo_list_release(&new_todo);
@@ -4778,12 +4736,9 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 
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
2.19.1.872.ga867da739e

