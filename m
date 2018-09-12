Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01B001F404
	for <e@80x24.org>; Wed, 12 Sep 2018 10:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbeILPOk (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 11:14:40 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:4446 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbeILPOk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 11:14:40 -0400
Received: from lindisfarne.localdomain ([89.242.190.162])
        by smtp.talktalk.net with SMTP
        id 026Ygd54KdJAe026hgxHBB; Wed, 12 Sep 2018 11:10:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1536747048;
        bh=mp4+/E8O9jXda2Qd9EIkoDDztXK3Aoi1K0IVjp3p57I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=UxSwmFY9dxTcJNmKXSF0YdsZiGGMYoW6qGxyeiEcUXKoSbwj8le4rk+MUzO3s1ody
         Jq1ZX7Rfc1q70N38NR1vVotozDcCNSQJ2pmJ4cTT9B25FULdtXxpDSY/KJq/jbfCZS
         FtC6bOm45PeSldWiIT7psixxiyEutncFysDkp26U=
X-Originating-IP: [89.242.190.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=yWw/b5KBQb65dAU66aqL/Q==:117
 a=yWw/b5KBQb65dAU66aqL/Q==:17 a=evINK-nbAAAA:8 a=vWm1S-qXhEGamv5ALUgA:9
 a=g6tL_zFA9Chf9GHQ:21 a=YTKOyC_TbRCNyoDt:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 2/3] add read_author_script() to libgit
Date:   Wed, 12 Sep 2018 11:10:28 +0100
Message-Id: <20180912101029.28052-3-phillip.wood@talktalk.net>
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

Add read_author_script() to sequencer.c based on the implementation in
builtin/am.c and update read_am_author_script() to use
read_author_script(). The sequencer code that reads the author script
will be updated in the next commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/am.c | 57 ++++-------------------------------------------
 sequencer.c  | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 sequencer.h  |  3 +++
 3 files changed, 69 insertions(+), 53 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 8c165f747b..aa5de0ee73 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -260,32 +260,6 @@ static int read_state_file(struct strbuf *sb, const struct am_state *state,
 	die_errno(_("could not read '%s'"), am_path(state, file));
 }
 
-/**
- * Take a series of KEY='VALUE' lines where VALUE part is
- * sq-quoted, and append <KEY, VALUE> at the end of the string list
- */
-static int parse_key_value_squoted(char *buf, struct string_list *list)
-{
-	while (*buf) {
-		struct string_list_item *item;
-		char *np;
-		char *cp = strchr(buf, '=');
-		if (!cp)
-			return -1;
-		np = strchrnul(cp, '\n');
-		*cp++ = '\0';
-		item = string_list_append(list, buf);
-
-		buf = np + (*np == '\n');
-		*np = '\0';
-		cp = sq_dequote(cp);
-		if (!cp)
-			return -1;
-		item->util = xstrdup(cp);
-	}
-	return 0;
-}
-
 /**
  * Reads and parses the state directory's "author-script" file, and sets
  * state->author_name, state->author_email and state->author_date accordingly.
@@ -305,39 +279,16 @@ static int parse_key_value_squoted(char *buf, struct string_list *list)
 static int read_am_author_script(struct am_state *state)
 {
 	const char *filename = am_path(state, "author-script");
-	struct strbuf buf = STRBUF_INIT;
-	struct string_list kv = STRING_LIST_INIT_DUP;
-	int retval = -1; /* assume failure */
-	int fd;
 
 	assert(!state->author_name);
 	assert(!state->author_email);
 	assert(!state->author_date);
 
-	fd = open(filename, O_RDONLY);
-	if (fd < 0) {
-		if (errno == ENOENT)
-			return 0;
-		die_errno(_("could not open '%s' for reading"), filename);
-	}
-	strbuf_read(&buf, fd, 0);
-	close(fd);
-	if (parse_key_value_squoted(buf.buf, &kv))
-		goto finish;
+	if (read_author_script(filename, &state->author_name,
+			       &state->author_email, &state->author_date, 1))
+		exit(128);
 
-	if (kv.nr != 3 ||
-	    strcmp(kv.items[0].string, "GIT_AUTHOR_NAME") ||
-	    strcmp(kv.items[1].string, "GIT_AUTHOR_EMAIL") ||
-	    strcmp(kv.items[2].string, "GIT_AUTHOR_DATE"))
-		goto finish;
-	state->author_name = kv.items[0].util;
-	state->author_email = kv.items[1].util;
-	state->author_date = kv.items[2].util;
-	retval = 0;
-finish:
-	string_list_clear(&kv, !!retval);
-	strbuf_release(&buf);
-	return retval;
+	return 0;
 }
 
 /**
diff --git a/sequencer.c b/sequencer.c
index dc2c58d464..5d0ff8f1c1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -660,6 +660,68 @@ static int write_author_script(const char *message)
 	return res;
 }
 
+/**
+ * Take a series of KEY='VALUE' lines where VALUE part is
+ * sq-quoted, and append <KEY, VALUE> at the end of the string list
+ */
+static int parse_key_value_squoted(char *buf, struct string_list *list)
+{
+	while (*buf) {
+		struct string_list_item *item;
+		char *np;
+		char *cp = strchr(buf, '=');
+		if (!cp)
+			return -1;
+		np = strchrnul(cp, '\n');
+		*cp++ = '\0';
+		item = string_list_append(list, buf);
+
+		buf = np + (*np == '\n');
+		*np = '\0';
+		cp = sq_dequote(cp);
+		if (!cp)
+			return -1;
+		item->util = xstrdup(cp);
+	}
+	return 0;
+}
+
+int read_author_script(const char *path, char **name, char **email, char **date,
+		       int allow_missing)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct string_list kv = STRING_LIST_INIT_DUP;
+	int retval = -1;
+
+	if (strbuf_read_file(&buf, path, 256) <= 0) {
+		strbuf_release(&buf);
+		if (errno == ENOENT && allow_missing)
+			return 0;
+		else
+			return error_errno(_("could not open '%s' for reading"),
+					   path);
+	}
+
+	if (parse_key_value_squoted(buf.buf, &kv)) {
+		error(_("unable to parse '%s'"), path);
+		goto finish;
+	}
+	if (kv.nr != 3 ||
+	    strcmp(kv.items[0].string, "GIT_AUTHOR_NAME") ||
+	    strcmp(kv.items[1].string, "GIT_AUTHOR_EMAIL") ||
+	    strcmp(kv.items[2].string, "GIT_AUTHOR_DATE")) {
+		error(_("unable to parse '%s'"), path);
+		goto finish;
+	}
+	*name = kv.items[0].util;
+	*email = kv.items[1].util;
+	*date = kv.items[2].util;
+	retval = 0;
+finish:
+	string_list_clear(&kv, !!retval);
+	strbuf_release(&buf);
+	return retval;
+}
 
 /*
  * write_author_script() used to fail to terminate the last line with a "'" and
diff --git a/sequencer.h b/sequencer.h
index c751c9d6e4..3713f955f5 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -107,4 +107,7 @@ void commit_post_rewrite(const struct commit *current_head,
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
 void print_commit_summary(const char *prefix, const struct object_id *oid,
 			  unsigned int flags);
+
+int read_author_script(const char *path, char **name, char **email, char **date,
+		       int allow_missing);
 #endif
-- 
2.18.0

