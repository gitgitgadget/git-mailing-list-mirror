Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4E621F453
	for <e@80x24.org>; Tue, 30 Oct 2018 10:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbeJ3TcY (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 15:32:24 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:34662 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbeJ3TcY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 15:32:24 -0400
Received: from lindisfarne.localdomain ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id HRQbg5GIzdJAeHRQkgS6N6; Tue, 30 Oct 2018 10:39:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1540895966;
        bh=7F9WReZg7ga6+/PQWusQsogHlg+1J4/vhBNZ1dK9Qqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=BQE1taqpLnloBngUic7o6SVESrFon3oZedQy5Ql32CBwfWiHjlqICbam5RRQ/pfSO
         DSEwzR74t8uTOVlqPPdueyhhseblhEG/IjRe3Yso3HA1bO3nlNsjgBcWjXpaZAVxUZ
         WSrzzjCN+AHraj2y8Ld/QZa7XeXNiKeE1kmgkpOo=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=evINK-nbAAAA:8 a=hmY0TbxAJEL1NjLCw64A:9
 a=VF1MDj8z9UGIESg9:21 a=KeheEo3eoYsdSEJ7:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 5/5] sequencer: use read_author_script()
Date:   Tue, 30 Oct 2018 10:39:16 +0000
Message-Id: <20181030103916.6241-6-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181030103916.6241-1-phillip.wood@talktalk.net>
References: <20180912101029.28052-1-phillip.wood@talktalk.net>
 <20181030103916.6241-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfIhW44sJHgmCWlHLTqmNEFHAkETef7oAqgeLze42SXCAthVohqaGV6KBGC7Q1cSi0vWCvPlBsFDoM9QVvCSnlROAzO37FNxu9fweOqAojCR6odBjxC7L
 d/6EufXrvuHoxk8iqT5U7pojJi/GnDJYh53Kk21sj99gewxWyGMR30nFwABkfMqXDGAGADlhb2AX77zKQUSaeUftqIphiGJy9y5qMqDQpb9TtBVEZiL1E/+U
 Q1ydxHc1GDIWK5oJHIexwV0KkCpxA0WCpSw6IJRYUyLFHhN+zDdjo5coPzgV1s8RaZ4fDIPXdb6099ZcOgz++0bLguuzktOeGjdmookHcms=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Use the new function added in the last commit to read the author
script, updating read_env_script() and read_author_ident(). We now
have a single code path that reads the author script for am and all
flavors of rebase. This changes the behavior of read_env_script() as
previously it would set any environment variables that were in the
author-script file. Now it is an error if the file contains other
variables or any of GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL and
GIT_AUTHOR_DATE are missing. This is what am and the non interactive
version of rebase have been doing for several years so hopefully it
will not cause a problem for interactive rebase users. The advantage
is that we are reusing existing code from am which uses sq_dequote()
to properly dequote variables. This fixes potential problems with user
edited scripts as read_env_script() which did not track quotes
properly.

This commit also removes the fallback code for checking for a broken
author script after git is upgraded when a rebase is stopped. Now that
the parsing uses sq_dequote() it will reliably return an error if the
quoting is broken and the user will have to abort the rebase and
restart. This isn't ideal but it's a corner case and the detection of
the broken quoting could be confused by user edited author scripts.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    changes since v1
     - use argv_array_pushf() as suggested by Eric
     - fixed strbuf handling as suggested by Eric
     - fix comments and commit message to reflect changed behavior of
       read_env_script()

 sequencer.c | 97 ++++++++++++-----------------------------------------
 1 file changed, 21 insertions(+), 76 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 3530dbeb6c..987542f67c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -767,53 +767,24 @@ int read_author_script(const char *path, char **name, char **email, char **date,
 }
 
 /*
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
-/*
- * Read a list of environment variable assignments (such as the author-script
- * file) into an environment block. Returns -1 on error, 0 otherwise.
+ * Read a GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL AND GIT_AUTHOR_DATE from a
+ * file with shell quoting into struct argv_array. Returns -1 on
+ * error, 0 otherwise.
  */
 static int read_env_script(struct argv_array *env)
 {
-	struct strbuf script = STRBUF_INIT;
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
+	argv_array_pushf(env, "GIT_AUTHOR_NAME=%s", name);
+	argv_array_pushf(env, "GIT_AUTHOR_EMAIL=%s", email);
+	argv_array_pushf(env, "GIT_AUTHOR_DATE=%s", date);
+	free(name);
+	free(email);
+	free(date);
 
 	return 0;
 }
@@ -833,54 +804,28 @@ static char *get_author(const char *message)
 /* Read author-script and return an ident line (author <email> timestamp) */
 static const char *read_author_ident(struct strbuf *buf)
 {
-	const char *keys[] = {
-		"GIT_AUTHOR_NAME=", "GIT_AUTHOR_EMAIL=", "GIT_AUTHOR_DATE="
-	};
 	struct strbuf out = STRBUF_INIT;
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
+	if (parse_date(date, &out)){
 		warning(_("invalid date format '%s' in '%s'"),
-			val[2], rebase_path_author_script());
+			date, rebase_path_author_script());
 		strbuf_release(&out);
 		return NULL;
 	}
 
 	strbuf_reset(&out);
-	strbuf_addstr(&out, fmt_ident(val[0], val[1], val[2], 0));
+	strbuf_addstr(&out, fmt_ident(name, email, date, 0));
 	strbuf_swap(buf, &out);
 	strbuf_release(&out);
+	free(name);
+	free(email);
+	free(date);
 	return buf->buf;
 }
 
-- 
2.19.1

