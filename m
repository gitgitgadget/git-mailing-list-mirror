Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DFB52070F
	for <e@80x24.org>; Mon, 19 Sep 2016 18:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752522AbcISSzC (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 14:55:02 -0400
Received: from ikke.info ([178.21.113.177]:38812 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751543AbcISSzB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 14:55:01 -0400
Received: by vps892.directvps.nl (Postfix, from userid 182)
        id 26BC14400C0; Mon, 19 Sep 2016 20:55:00 +0200 (CEST)
Received: from io.ikke (unknown [10.8.0.30])
        by vps892.directvps.nl (Postfix) with ESMTP id 7FCE94400BD;
        Mon, 19 Sep 2016 20:54:57 +0200 (CEST)
From:   Kevin Daudt <me@ikke.info>
To:     git@vger.kernel.org
Cc:     Kevin Daudt <me@ikke.info>, Swift Geek <swiftgeek@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] mailinfo: unescape quoted-pair in header fields
Date:   Mon, 19 Sep 2016 20:54:40 +0200
Message-Id: <20160919185440.18234-3-me@ikke.info>
X-Mailer: git-send-email 2.10.0.86.g6ffa4f1.dirty
In-Reply-To: <20160919185440.18234-1-me@ikke.info>
References: <20160919185440.18234-1-me@ikke.info>
In-Reply-To: <20160916210204.31282-1-me@ikke.info>
References: <20160916210204.31282-1-me@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

rfc2822 has provisions for quoted strings in structured header fields,
but also allows for escaping these with so-called quoted-pairs.

The only thing git currently does is removing exterior quotes, but
quotes within are left alone.

Remove exterior quotes and remove escape characters so that they don't
show up in the author field.

Signed-off-by: Kevin Daudt <me@ikke.info>
---
 mailinfo.c                   | 46 ++++++++++++++++++++++++++++++++++++++++++++
 t/t5100-mailinfo.sh          | 14 ++++++++++++++
 t/t5100/comment.expect       |  5 +++++
 t/t5100/comment.in           |  9 +++++++++
 t/t5100/quoted-string.expect |  5 +++++
 t/t5100/quoted-string.in     |  9 +++++++++
 6 files changed, 88 insertions(+)
 create mode 100644 t/t5100/comment.expect
 create mode 100644 t/t5100/comment.in
 create mode 100644 t/t5100/quoted-string.expect
 create mode 100644 t/t5100/quoted-string.in

diff --git a/mailinfo.c b/mailinfo.c
index e19abe3..6a7c2f2 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -54,6 +54,50 @@ static void parse_bogus_from(struct mailinfo *mi, const struct strbuf *line)
 	get_sane_name(&mi->name, &mi->name, &mi->email);
 }
 
+static void unquote_quoted_string(struct strbuf *line)
+{
+	const char *in = strbuf_detach(line, NULL);
+	int c, take_next_literally = 0;
+	int found_error = 0;
+
+	/*
+	 * Stores the character that started the escape mode so that we know what
+	 * character will stop it
+	 */
+	char escape_context = 0;
+
+	while ((c = *in++) != 0) {
+		if (take_next_literally) {
+			take_next_literally = 0;
+		} else {
+			switch (c) {
+			case '"':
+				if (!escape_context)
+					escape_context = '"';
+				else if (escape_context == '"')
+					escape_context = 0;
+				continue;
+			case '\\':
+				if (escape_context) {
+					take_next_literally = 1;
+					continue;
+				}
+				break;
+			case '(':
+				if (!escape_context)
+					escape_context = '(';
+				break;
+			case ')':
+				if (escape_context == '(')
+					escape_context = 0;
+				break;
+			}
+		}
+
+		strbuf_addch(line, c);
+	}
+}
+
 static void handle_from(struct mailinfo *mi, const struct strbuf *from)
 {
 	char *at;
@@ -63,6 +107,8 @@ static void handle_from(struct mailinfo *mi, const struct strbuf *from)
 	strbuf_init(&f, from->len);
 	strbuf_addbuf(&f, from);
 
+	unquote_quoted_string(&f);
+
 	at = strchr(f.buf, '@');
 	if (!at) {
 		parse_bogus_from(mi, from);
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 27bf3b8..8c21434 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -144,4 +144,18 @@ test_expect_success 'mailinfo unescapes with --mboxrd' '
 	test_cmp expect mboxrd/msg
 '
 
+test_expect_success 'mailinfo handles rfc2822 quoted-string' '
+	mkdir quoted-string &&
+	git mailinfo /dev/null /dev/null <"$DATA"/quoted-string.in \
+		>quoted-string/info &&
+	test_cmp "$DATA"/quoted-string.expect quoted-string/info
+'
+
+test_expect_success 'mailinfo handles rfc2822 comment' '
+	mkdir comment &&
+	git mailinfo /dev/null /dev/null <"$DATA"/comment.in \
+		>comment/info &&
+	test_cmp "$DATA"/comment.expect comment/info
+'
+
 test_done
diff --git a/t/t5100/comment.expect b/t/t5100/comment.expect
new file mode 100644
index 0000000..1197e76
--- /dev/null
+++ b/t/t5100/comment.expect
@@ -0,0 +1,5 @@
+Author: A U Thor (this is a comment (really))
+Email: somebody@example.com
+Subject: testing comments
+Date: Sun, 25 May 2008 00:38:18 -0700
+
diff --git a/t/t5100/comment.in b/t/t5100/comment.in
new file mode 100644
index 0000000..430ba97
--- /dev/null
+++ b/t/t5100/comment.in
@@ -0,0 +1,9 @@
+From 1234567890123456789012345678901234567890 Mon Sep 17 00:00:00 2001
+From: "A U Thor" <somebody@example.com> (this is a comment \(really\))
+Date: Sun, 25 May 2008 00:38:18 -0700
+Subject: [PATCH] testing comments
+
+
+
+---
+patch
diff --git a/t/t5100/quoted-string.expect b/t/t5100/quoted-string.expect
new file mode 100644
index 0000000..cab1bce
--- /dev/null
+++ b/t/t5100/quoted-string.expect
@@ -0,0 +1,5 @@
+Author: Author "The Author" Name
+Email: somebody@example.com
+Subject: testing quoted-pair
+Date: Sun, 25 May 2008 00:38:18 -0700
+
diff --git a/t/t5100/quoted-string.in b/t/t5100/quoted-string.in
new file mode 100644
index 0000000..e2e627a
--- /dev/null
+++ b/t/t5100/quoted-string.in
@@ -0,0 +1,9 @@
+From 1234567890123456789012345678901234567890 Mon Sep 17 00:00:00 2001
+From: "Author \"The Author\" Name" <somebody@example.com>
+Date: Sun, 25 May 2008 00:38:18 -0700
+Subject: [PATCH] testing quoted-pair
+
+
+
+---
+patch
-- 
2.10.0.86.g6ffa4f1.dirty

