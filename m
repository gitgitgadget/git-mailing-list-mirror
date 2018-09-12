Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D32E1F404
	for <e@80x24.org>; Wed, 12 Sep 2018 10:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbeILPOk (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 11:14:40 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:63794 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbeILPOk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 11:14:40 -0400
Received: from lindisfarne.localdomain ([89.242.190.162])
        by smtp.talktalk.net with SMTP
        id 026Ygd54KdJAe026igxHBG; Wed, 12 Sep 2018 11:10:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1536747048;
        bh=1VIpNeoWYmdwTqfa/7asWskmTPzvGqvfBwMKZoInxqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=Zw1vwYXCetiyD/IE8f0EDI6dkyRSKCQB9bXD+8vsM8Qy/C7mYV96QFQnZLrDWpWip
         C+B/96RZrJQ377XDih5H5DJvTegtqt+RjEsFWfDdtxIaWs3wuMmGesMh6rZ05JZ+4i
         +Ca4N5A0Gt7hYbE/T4bKf7nvoCBnPAFL/kZa4ERw=
X-Originating-IP: [89.242.190.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=yWw/b5KBQb65dAU66aqL/Q==:117
 a=yWw/b5KBQb65dAU66aqL/Q==:17 a=evINK-nbAAAA:8 a=hmY0TbxAJEL1NjLCw64A:9
 a=lUuLDBlSICsWFDiz:21 a=lDCOD0JcADFK45N1:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 3/3] sequencer: use read_author_script()
Date:   Wed, 12 Sep 2018 11:10:29 +0100
Message-Id: <20180912101029.28052-4-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912101029.28052-1-phillip.wood@talktalk.net>
References: <20180912101029.28052-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfIi185e51JesJuDTgTz7Woj9i43bDlV1gIgrGetHY+PXwC6g83mOR91TcwyrpLdYSlfhLNHfwrj3wDUyw3tr5M935PplUjcv3Ko01T377boEcVQqS18Q
 wEbl1ApSYjBzcIINOzEH9qq75brSCW9U2kle6o6gtTsjZII0FE4sjiJLE8EXvOGt+i72BTaMI/MdD9ZK/HdSSxxVs9/f9hrYMKNssCq8bPWTEplr5AHhg7my
 WWJ6+Ze8DBWhSc2PMSLBQoY5c5JIQwysXOnDOBvMpnWF5apKcpL8wta3+t2CGwQERE2sreor4QKeVBeMvnNbvN0lSh6k4uMHLpW3ZtP0Ueo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Use the new function to read the author script, updating
read_env_script() and read_author_ident(). This means we now have a
single code path that reads the author script and uses sq_dequote() to
dequote it. This fixes potential problems with user edited scripts
as read_env_script() which did not track quotes properly.

This commit also removes the fallback code for checking for a broken
author script after git is upgraded when a rebase is stopped. Now that
the parsing uses sq_dequote() it will reliably return an error if the
quoting is broken and the user will have to abort the rebase and
restart. This isn't ideal but it's a corner case and the detection of
the broken quoting could be confused by user edited author scripts.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 108 +++++++++++++++-------------------------------------
 1 file changed, 30 insertions(+), 78 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5d0ff8f1c1..630741cfe0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -723,54 +723,35 @@ int read_author_script(const char *path, char **name, char **email, char **date,
 	return retval;
 }
 
-/*
- * write_author_script() used to fail to terminate the last line with a "'" and
- * also escaped "'" incorrectly as "'\\\\''" rather than "'\\''". We check for
- * the terminating "'" on the last line to see how "'" has been escaped in case
- * git was upgraded while rebase was stopped.
- */
-static int quoting_is_broken(const char *s, size_t n)
-{
-	/* Skip any empty lines in case the file was hand edited */
-	while (n > 0 && s[--n] == '\n')
-		; /* empty */
-	if (n > 0 && s[n] != '\'')
-		return 1;
-
-	return 0;
-}
-
 /*
  * Read a list of environment variable assignments (such as the author-script
  * file) into an environment block. Returns -1 on error, 0 otherwise.
  */
 static int read_env_script(struct argv_array *env)
 {
 	struct strbuf script = STRBUF_INIT;
-	int i, count = 0, sq_bug;
-	const char *p2;
-	char *p;
+	char *name, *email, *date;
 
-	if (strbuf_read_file(&script, rebase_path_author_script(), 256) <= 0)
+	if (read_author_script(rebase_path_author_script(),
+			       &name, &email, &date, 0))
 		return -1;
-	/* write_author_script() used to quote incorrectly */
-	sq_bug = quoting_is_broken(script.buf, script.len);
-	for (p = script.buf; *p; p++)
-		if (sq_bug && skip_prefix(p, "'\\\\''", &p2))
-			strbuf_splice(&script, p - script.buf, p2 - p, "'", 1);
-		else if (skip_prefix(p, "'\\''", &p2))
-			strbuf_splice(&script, p - script.buf, p2 - p, "'", 1);
-		else if (*p == '\'')
-			strbuf_splice(&script, p-- - script.buf, 1, "", 0);
-		else if (*p == '\n') {
-			*p = '\0';
-			count++;
-		}
 
-	for (i = 0, p = script.buf; i < count; i++) {
-		argv_array_push(env, p);
-		p += strlen(p) + 1;
-	}
+	strbuf_addstr(&script, "GIT_AUTHOR_NAME=");
+	strbuf_addstr(&script, name);
+	argv_array_push(env, script.buf);
+	strbuf_reset(&script);
+	strbuf_addstr(&script, "GIT_AUTHOR_EMAIL=");
+	strbuf_addstr(&script, email);
+	argv_array_push(env, script.buf);
+	strbuf_reset(&script);
+	strbuf_addstr(&script, "GIT_AUTHOR_DATE=");
+	strbuf_addstr(&script, date);
+	argv_array_push(env, script.buf);
+	strbuf_release(&script);
+
+	free(name);
+	free(email);
+	free(date);
 
 	return 0;
 }
@@ -790,54 +771,25 @@ static char *get_author(const char *message)
 /* Read author-script and return an ident line (author <email> timestamp) */
 static const char *read_author_ident(struct strbuf *buf)
 {
-	const char *keys[] = {
-		"GIT_AUTHOR_NAME=", "GIT_AUTHOR_EMAIL=", "GIT_AUTHOR_DATE="
-	};
-	struct strbuf out = STRBUF_INIT;
-	char *in, *eol;
-	const char *val[3];
-	int i = 0;
+	char *name, *email, *date;
 
-	if (strbuf_read_file(buf, rebase_path_author_script(), 256) <= 0)
+	if (read_author_script(rebase_path_author_script(),
+			       &name, &email, &date, 0))
 		return NULL;
 
-	/* dequote values and construct ident line in-place */
-	for (in = buf->buf; i < 3 && in - buf->buf < buf->len; i++) {
-		if (!skip_prefix(in, keys[i], (const char **)&in)) {
-			warning(_("could not parse '%s' (looking for '%s')"),
-				rebase_path_author_script(), keys[i]);
-			return NULL;
-		}
-
-		eol = strchrnul(in, '\n');
-		*eol = '\0';
-		if (!sq_dequote(in)) {
-			warning(_("bad quoting on %s value in '%s'"),
-				keys[i], rebase_path_author_script());
-			return NULL;
-		}
-		val[i] = in;
-		in = eol + 1;
-	}
-
-	if (i < 3) {
-		warning(_("could not parse '%s' (looking for '%s')"),
-			rebase_path_author_script(), keys[i]);
-		return NULL;
-	}
-
 	/* validate date since fmt_ident() will die() on bad value */
-	if (parse_date(val[2], &out)){
+	if (parse_date(date, buf)){
 		warning(_("invalid date format '%s' in '%s'"),
-			val[2], rebase_path_author_script());
-		strbuf_release(&out);
+			date, rebase_path_author_script());
+		strbuf_release(buf);
 		return NULL;
 	}
 
-	strbuf_reset(&out);
-	strbuf_addstr(&out, fmt_ident(val[0], val[1], val[2], 0));
-	strbuf_swap(buf, &out);
-	strbuf_release(&out);
+	strbuf_reset(buf);
+	strbuf_addstr(buf, fmt_ident(name, email, date, 0));
+	free(name);
+	free(email);
+	free(date);
 	return buf->buf;
 }
 
-- 
2.18.0

