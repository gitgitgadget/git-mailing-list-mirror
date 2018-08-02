Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B9721F597
	for <e@80x24.org>; Thu,  2 Aug 2018 11:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbeHBNK7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 09:10:59 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:44167 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbeHBNK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 09:10:59 -0400
Received: from lindisfarne.localdomain ([92.22.30.174])
        by smtp.talktalk.net with SMTP
        id lBeMfoYRtbZX5lBeSf1fz3; Thu, 02 Aug 2018 12:20:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1533208816;
        bh=2lOF12YscEf5Je5HHXwOap83GBBRhevSSxwPaomHduY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=CmI6Gcrobx1kBycj1rJtvKaskwWdTXdZDXRWiAhJOsLXZqNAMmhYVnU5R8Fg0YI5o
         iQb13xf/dDfMkQ0iAbiapoKIdD0yqiZ2biM7vAkyuI82MHj/1ifvoTSurwjIs4IPCH
         3KgJ9P9NjVqyR5U9picDzQSdwPhPP/oCTDxfkETQ=
X-Originating-IP: [92.22.30.174]
X-Spam: 0
X-OAuthority: v=2.3 cv=Poq9kTE3 c=1 sm=1 tr=0 a=2xfjePbNG5I+/HyESt+5YA==:117
 a=2xfjePbNG5I+/HyESt+5YA==:17 a=evINK-nbAAAA:8 a=u-vJNOlgjG8qz3_isVcA:9
 a=WJVo-1wuODy17d0V:21 a=I4VlqCnzzEYvBj9m:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 1/2] sequencer: handle errors in read_author_ident()
Date:   Thu,  2 Aug 2018 12:20:01 +0100
Message-Id: <20180802112002.720-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180802112002.720-1-phillip.wood@talktalk.net>
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <20180802112002.720-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfPCM9MCjf3WR1hhevtuzww289Kt+Z0H/0FvXnsxGPJsasXFZVrEBnJFxk0rikLOajhMsbJxYwD7h/fZs+g/6h0EUTuEWKXpM/10CfCtuLMTUbc5dfz6c
 b0U5Vzx/WKxxTG2WxAVmjaWHKyx1n6VeJW4xike8kSRwytnQqZfS/fuFDpwhnhAX3S0qTnNHCWpRxMil0KzobPGq082fNSe90YyqV8D8cLkD1oDoB0d0lOWb
 m1GP8OD3S88jFoEBN/HQeSl7ez6E9YDH2VdlgAGBD29pbnJZ/oVvZ5PCyhDEWa9U1NkIONnQwEaTvvJmtwNy0GvSpljiD/WiFxUZYwV3z3Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The calling code did not treat NULL as an error. Instead NULL caused
it to fallback to using the default author when creating the new
commit. This changed the date and potentially the author of the
commit which corrupted the author data compared to its expected
value. Fix this by returning and integer and passing in a parameter to
receive the author.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    changes since v2:
    
     - Improved commit message
     - Fixed memory leak
     - Translated a couple of error messages

 sequencer.c | 52 ++++++++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 944dea6997..1bf8b0c431 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -701,57 +701,59 @@ static char *get_author(const char *message)
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
+	if (strbuf_read_file(&buf, rebase_path_author_script(), 256) <= 0) {
+		strbuf_release(&buf);
+		return -1;
+	}
 
-	/* dequote values and construct ident line in-place */
-	for (in = buf->buf; i < 3 && in - buf->buf < buf->len; i++) {
+	for (in = buf.buf; i < 3 && in - buf.buf < buf.len; i++) {
 		if (!skip_prefix(in, keys[i], (const char **)&in)) {
-			warning("could not parse '%s' (looking for '%s'",
-				rebase_path_author_script(), keys[i]);
-			return NULL;
+			strbuf_release(&buf);
+			return error(_("could not parse '%s' (looking for '%s')"),
+				       rebase_path_author_script(), keys[i]);
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
+		return error(_("could not parse '%s' (looking for '%s')"),
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
@@ -794,12 +796,14 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
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
 
@@ -817,7 +821,7 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 					  opts->gpg_sign);
 
 		strbuf_release(&msg);
-		strbuf_release(&script);
+		free(author);
 		if (!res) {
 			update_ref(NULL, "CHERRY_PICK_HEAD", &root_commit, NULL,
 				   REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR);
-- 
2.18.0

