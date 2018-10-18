Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98A4B1F453
	for <e@80x24.org>; Thu, 18 Oct 2018 10:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbeJRSBD (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 14:01:03 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:44884 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbeJRSBC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 14:01:02 -0400
Received: from lindisfarne.localdomain ([92.26.121.144])
        by smtp.talktalk.net with SMTP
        id D56VgJF7wbZX5D56igknic; Thu, 18 Oct 2018 11:00:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1539856846;
        bh=o+079DACaL2FjrXND5AhiIQ+aANQ5CP14cXhrp04srg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=IwBdiX7UnrhKbHVyfNy5OcC96lErMfQI60dOGIDIM/BlNKQbEFCeDaL5xdbSTbCZ4
         pCI+sX4h3vnBnAY3sd9gHSqye5RKoBj2CqRABQ+sxV4kmxXs/8tIVhgDkr3tBmy6RN
         Lx9sOJYZu9rkMtJuKeepqS/xxUjMrq0KnXpD0DV4=
X-Originating-IP: [92.26.121.144]
X-Spam: 0
X-OAuthority: v=2.3 cv=Poq9kTE3 c=1 sm=1 tr=0 a=AM9PLn0bJgvrHi3wmEITIQ==:117
 a=AM9PLn0bJgvrHi3wmEITIQ==:17 a=evINK-nbAAAA:8 a=ptTNLviJEnKM3T6GpPoA:9
 a=15KBtRcXfXDZAP1d:21 a=VGg1cHLJUown9a68:21 a=RfR_gqz1fSpA9VikTjo0:22
 a=pHzHmUro8NiASowvMSCR:22 a=nt3jZW36AmriUCFCBwmW:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 4/5] add read_author_script() to libgit
Date:   Thu, 18 Oct 2018 11:00:22 +0100
Message-Id: <20181018100023.7327-5-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181018100023.7327-1-phillip.wood@talktalk.net>
References: <20180912101029.28052-1-phillip.wood@talktalk.net>
 <20181018100023.7327-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfFdb4mf0nSNJoZJRvqdk9FNnyP9FKd5vkrv+H2UQcQVLNoFf8TFFjuiDLhmfklSjnGOLqSTEHqqVXu3d6yJX/N/bUoFPm1S7Wt77IpIKPockAh+j6YoC
 F4HPtquckSkXS6fRPOWnkkORbPz48ivYZ/gzzhvjIv/HQmnAtfiu4qxv1awMoVK7dDnuAe17lwBB+nfF7GqkRgW9SpSMkyDIJatFqXeCKciDU468WhjqS+Zv
 BDveVGvJ5vOtkypMcNoVkTvAnAFPCZSvKT2Cav9Q9DN0Hec1iqF8dbb3LucUCKiVZhuFZ3Pdhva/6UxUAbQOFXDMT3PDFTvhC0c0NSrrMcM=
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

Notes:
    changes since v1:
     - added comment above read_author_script()
     - rebased to reflect changes added in patch 2

 builtin/am.c |  86 +----------------------------------------
 sequencer.c  | 105 +++++++++++++++++++++++++++++++++++++++++++++++++++
 sequencer.h  |   3 ++
 3 files changed, 110 insertions(+), 84 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 991d13f9a2..c5373158c0 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -260,36 +260,6 @@ static int read_state_file(struct strbuf *sb, const struct am_state *state,
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
-		if (!cp) {
-			np = strchrnul(buf, '\n');
-			return error(_("unable to parse '%.*s'"),
-				     (int) (np - buf), buf);
-		}
-		np = strchrnul(cp, '\n');
-		*cp++ = '\0';
-		item = string_list_append(list, buf);
-
-		buf = np + (*np == '\n');
-		*np = '\0';
-		cp = sq_dequote(cp);
-		if (!cp)
-			return error(_("unable to dequote value of '%s'"),
-				     item->string);
-		item->util = xstrdup(cp);
-	}
-	return 0;
-}
-
 /**
  * Reads and parses the state directory's "author-script" file, and sets
  * state->author_name, state->author_email and state->author_date accordingly.
@@ -309,65 +279,13 @@ static int parse_key_value_squoted(char *buf, struct string_list *list)
 static int read_am_author_script(struct am_state *state)
 {
 	const char *filename = am_path(state, "author-script");
-	struct strbuf buf = STRBUF_INIT;
-	struct string_list kv = STRING_LIST_INIT_DUP;
-	int retval = -1; /* assume failure */
-	int i, name_i = -2, email_i = -2, date_i = -2, err = 0;
-	int fd;
 
 	assert(!state->author_name);
 	assert(!state->author_email);
 	assert(!state->author_date);
 
-	fd = open(filename, O_RDONLY);
-	if (fd < 0) {
-		if (errno == ENOENT)
-			return 0;
-		return error_errno(_("could not open '%s' for reading"),
-				   filename);
-	}
-	strbuf_read(&buf, fd, 0);
-	close(fd);
-	if (parse_key_value_squoted(buf.buf, &kv))
-		goto finish;
-
-	for (i = 0; i < kv.nr; i++) {
-		if (!strcmp(kv.items[i].string, "GIT_AUTHOR_NAME")) {
-			if (name_i >= 0)
-				name_i = error(_("'GIT_AUTHOR_NAME' already given"));
-			else
-				name_i = i;
-		} else if (!strcmp(kv.items[i].string, "GIT_AUTHOR_EMAIL")) {
-			if (email_i >= 0)
-				email_i = error(_("'GIT_AUTHOR_EMAIL' already given"));
-			else
-				email_i = i;
-		} else if (!strcmp(kv.items[i].string, "GIT_AUTHOR_DATE")) {
-			if (date_i >= 0)
-				date_i = error(_("'GIT_AUTHOR_DATE' already given"));
-			else
-				date_i = i;
-		} else {
-			err = error(_("unknown variable '%s'"),
-				    kv.items[i].string);
-		}
-	}
-	if (name_i == -2)
-		error(_("missing 'GIT_AUTHOR_NAME'"));
-	if (email_i == -2)
-		error(_("missing 'GIT_AUTHOR_EMAIL'"));
-	if (date_i == -2)
-		error(_("missing 'GIT_AUTHOR_DATE'"));
-	if (date_i < 0 || email_i < 0 || date_i < 0 || err)
-		goto finish;
-	state->author_name = kv.items[name_i].util;
-	state->author_email = kv.items[email_i].util;
-	state->author_date = kv.items[date_i].util;
-	retval = 0;
-finish:
-	string_list_clear(&kv, !!retval);
-	strbuf_release(&buf);
-	return retval;
+	return read_author_script(filename, &state->author_name,
+				  &state->author_email, &state->author_date, 1);
 }
 
 /**
diff --git a/sequencer.c b/sequencer.c
index dc2c58d464..3530dbeb6c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -660,6 +660,111 @@ static int write_author_script(const char *message)
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
+		if (!cp) {
+			np = strchrnul(buf, '\n');
+			return error(_("unable to parse '%.*s'"),
+				     (int) (np - buf), buf);
+		}
+		np = strchrnul(cp, '\n');
+		*cp++ = '\0';
+		item = string_list_append(list, buf);
+
+		buf = np + (*np == '\n');
+		*np = '\0';
+		cp = sq_dequote(cp);
+		if (!cp)
+			return error(_("unable to dequote value of '%s'"),
+				     item->string);
+		item->util = xstrdup(cp);
+	}
+	return 0;
+}
+
+/**
+ * Reads and parses the state directory's "author-script" file, and sets name,
+ * email and date accordingly.
+ * Returns 0 on success, -1 if the file could not be parsed.
+ *
+ * The author script is of the format:
+ *
+ *	GIT_AUTHOR_NAME='$author_name'
+ *	GIT_AUTHOR_EMAIL='$author_email'
+ *	GIT_AUTHOR_DATE='$author_date'
+ *
+ * where $author_name, $author_email and $author_date are quoted. We are strict
+ * with our parsing, as the file was meant to be eval'd in the old
+ * git-am.sh/git-rebase--interactive.sh scripts, and thus if the file differs
+ * from what this function expects, it is better to bail out than to do
+ * something that the user does not expect.
+ */
+int read_author_script(const char *path, char **name, char **email, char **date,
+		       int allow_missing)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct string_list kv = STRING_LIST_INIT_DUP;
+	int retval = -1; /* assume failure */
+	int i, name_i = -2, email_i = -2, date_i = -2, err = 0;
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
+	if (parse_key_value_squoted(buf.buf, &kv))
+		goto finish;
+
+	for (i = 0; i < kv.nr; i++) {
+		if (!strcmp(kv.items[i].string, "GIT_AUTHOR_NAME")) {
+			if (name_i >= 0)
+				name_i = error(_("'GIT_AUTHOR_NAME' already given"));
+			else
+				name_i = i;
+		} else if (!strcmp(kv.items[i].string, "GIT_AUTHOR_EMAIL")) {
+			if (email_i >= 0)
+				email_i = error(_("'GIT_AUTHOR_EMAIL' already given"));
+			else
+				email_i = i;
+		} else if (!strcmp(kv.items[i].string, "GIT_AUTHOR_DATE")) {
+			if (date_i >= 0)
+				date_i = error(_("'GIT_AUTHOR_DATE' already given"));
+			else
+				date_i = i;
+		} else {
+			err = error(_("unknown variable '%s'"),
+				    kv.items[i].string);
+		}
+	}
+	if (name_i == -2)
+		error(_("missing 'GIT_AUTHOR_NAME'"));
+	if (email_i == -2)
+		error(_("missing 'GIT_AUTHOR_EMAIL'"));
+	if (date_i == -2)
+		error(_("missing 'GIT_AUTHOR_DATE'"));
+	if (date_i < 0 || email_i < 0 || date_i < 0 || err)
+		goto finish;
+	*name = kv.items[name_i].util;
+	*email = kv.items[email_i].util;
+	*date = kv.items[date_i].util;
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
2.19.0

