Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E93A1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 11:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731953AbeGaMzf (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 08:55:35 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:15544 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731395AbeGaMzf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 08:55:35 -0400
Received: from lindisfarne.localdomain ([92.22.0.63])
        by smtp.talktalk.net with SMTP
        id kScrfkUhMbZX5kScyf0ev9; Tue, 31 Jul 2018 12:15:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1533035745;
        bh=sPTDFzKohA1yykh7RPlFmCIR967IBY7ytVhzGn3ejXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=J8akxCEwUew3LYV2R5wAzTIMNR4CL3Y6eBgHZv9W+zwqQgZAiG0cyfVOeRuoWDvor
         sFyzPM7iSJRT14KO9kpc1GFiAMSjIUKrC+XXRRuWo0iqxjz2chGiA7MMiIvymZj36R
         nyKSH3bPheb2Nvm2XTt/azbDxrQTjEwXjz5Y1/+I=
X-Originating-IP: [92.22.0.63]
X-Spam: 0
X-OAuthority: v=2.3 cv=Poq9kTE3 c=1 sm=1 tr=0 a=ohMtzhKkgcX7CUCE/LoB2A==:117
 a=ohMtzhKkgcX7CUCE/LoB2A==:17 a=evINK-nbAAAA:8 a=RTGcDvLxpLT6ixxLo1UA:9
 a=CVX4a4TfG-echOjI:21 a=-feyu9rFGGrjqLM5:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 1/2] sequencer: handle errors in read_author_ident()
Date:   Tue, 31 Jul 2018 12:15:31 +0100
Message-Id: <20180731111532.9358-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731111532.9358-1-phillip.wood@talktalk.net>
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <20180731111532.9358-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfLESVUgpZqxcI01vs8U8qVkDtpvNcq62INVDnI9QRZkuLE++naK0k3zST2N8vG+A757xFCiJvpgS3f/YFyz5ByWqJEkA2j2oaV/CUICiMl1EiJnWvQMf
 aYMxWzsSmHcSJTg1EViC19lfn8aitjXLWr7S/Js8DNVLpErS7k0+OZuK4qSMFEBC+UKHQ5J41h13h4lQi23DLcpuJg9iKCgCjFHO0JYQ1NCRGvrTQF4K59iy
 /63EQtHG4ZOe/JIU2SmUxnaWgl3YK+HYf7a7PzS32oRwKwS+o1XIx3JpHK/UZnu7A/W2iCLiKWNtqoW/o0zjfYCvdMcjdQaJQ8+tIcXsc0w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The calling code treated NULL as a valid return value, so fix this by
returning and integer and passing in a parameter to receive the author.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 49 ++++++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 944dea6997..212b912420 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -701,57 +701,58 @@ static char *get_author(const char *message)
 }
 
 /* Read author-script and return an ident line (author <email> timestamp) */
-static const char *read_author_ident(struct strbuf *buf)
+static int read_author_ident(char **author)
 {
 	const char *keys[] = {
 		"GIT_AUTHOR_NAME=", "GIT_AUTHOR_EMAIL=", "GIT_AUTHOR_DATE="
 	};
+	struct strbuf buf = STRBUF_INIT;
 	struct strbuf out = STRBUF_INIT;
 	char *in, *eol;
 	const char *val[3];
 	int i = 0;
 
-	if (strbuf_read_file(buf, rebase_path_author_script(), 256) <= 0)
-		return NULL;
+	if (strbuf_read_file(&buf, rebase_path_author_script(), 256) <= 0)
+		return -1;
 
 	/* dequote values and construct ident line in-place */
-	for (in = buf->buf; i < 3 && in - buf->buf < buf->len; i++) {
+	for (in = buf.buf; i < 3 && in - buf.buf < buf.len; i++) {
 		if (!skip_prefix(in, keys[i], (const char **)&in)) {
-			warning("could not parse '%s' (looking for '%s'",
-				rebase_path_author_script(), keys[i]);
-			return NULL;
+			strbuf_release(&buf);
+			return error("could not parse '%s' (looking for '%s'",
+				     rebase_path_author_script(), keys[i]);
 		}
-
 		eol = strchrnul(in, '\n');
 		*eol = '\0';
 		if (!sq_dequote(in)) {
-			warning(_("bad quoting on %s value in '%s'"),
-				keys[i], rebase_path_author_script());
-			return NULL;
+			strbuf_release(&buf);
+			return error(_("bad quoting on %s value in '%s'"),
+				     keys[i], rebase_path_author_script());
 		}
 		val[i] = in;
 		in = eol + 1;
 	}
 
 	if (i < 3) {
-		warning("could not parse '%s' (looking for '%s')",
-			rebase_path_author_script(), keys[i]);
-		return NULL;
+		strbuf_release(&buf);
+		return error("could not parse '%s' (looking for '%s')",
+			     rebase_path_author_script(), keys[i]);
 	}
 
 	/* validate date since fmt_ident() will die() on bad value */
 	if (parse_date(val[2], &out)){
-		warning(_("invalid date format '%s' in '%s'"),
+		error(_("invalid date format '%s' in '%s'"),
 			val[2], rebase_path_author_script());
 		strbuf_release(&out);
-		return NULL;
+		strbuf_release(&buf);
+		return -1;
 	}
 
 	strbuf_reset(&out);
 	strbuf_addstr(&out, fmt_ident(val[0], val[1], val[2], 0));
-	strbuf_swap(buf, &out);
-	strbuf_release(&out);
-	return buf->buf;
+	*author = strbuf_detach(&out, NULL);
+	strbuf_release(&buf);
+	return 0;
 }
 
 static const char staged_changes_advice[] =
@@ -794,12 +795,14 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	const char *value;
 
 	if ((flags & CREATE_ROOT_COMMIT) && !(flags & AMEND_MSG)) {
-		struct strbuf msg = STRBUF_INIT, script = STRBUF_INIT;
-		const char *author = is_rebase_i(opts) ?
-			read_author_ident(&script) : NULL;
+		struct strbuf msg = STRBUF_INIT;
+		char *author = NULL;
 		struct object_id root_commit, *cache_tree_oid;
 		int res = 0;
 
+		if (is_rebase_i(opts) && read_author_ident(&author))
+			return -1;
+
 		if (!defmsg)
 			BUG("root commit without message");
 
@@ -817,7 +820,7 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 					  opts->gpg_sign);
 
 		strbuf_release(&msg);
-		strbuf_release(&script);
+		free(author);
 		if (!res) {
 			update_ref(NULL, "CHERRY_PICK_HEAD", &root_commit, NULL,
 				   REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR);
-- 
2.18.0

