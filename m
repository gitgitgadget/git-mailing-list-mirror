Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34441207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 21:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757262AbcIPVCy (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 17:02:54 -0400
Received: from ikke.info ([178.21.113.177]:39100 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752437AbcIPVCw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 17:02:52 -0400
Received: by vps892.directvps.nl (Postfix, from userid 182)
        id 8DD924400C5; Fri, 16 Sep 2016 23:02:50 +0200 (CEST)
Received: from io.ikke (unknown [10.8.0.30])
        by vps892.directvps.nl (Postfix) with ESMTP id 4274E4400B7;
        Fri, 16 Sep 2016 23:02:49 +0200 (CEST)
From:   Kevin Daudt <me@ikke.info>
To:     git@vger.kernel.org
Cc:     Kevin Daudt <me@ikke.info>, Swift Geek <swiftgeek@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] mailinfo: unescape quoted-pair in header fields
Date:   Fri, 16 Sep 2016 23:02:04 +0200
Message-Id: <20160916210204.31282-1-me@ikke.info>
X-Mailer: git-send-email 2.10.0.86.g6ffa4f1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

rfc2822 has provisions for quoted strings in structured header fields,
but also allows for escaping these with so-called quoted-pairs.

The only thing git currently does is removing exterior quotes, but
quotes within are left alone.

Tell mailinfo to remove exterior quotes and remove escape characters from the
author so that they don't show up in the commits author field.

Signed-off-by: Kevin Daudt <me@ikke.info>
---
The only thing I could not easily fix is the prevent git am from removing any quotes around the author. This is done in fmt_ident, which calls `strbuf_addstr_without_crud`. 

 mailinfo.c                 | 54 ++++++++++++++++++++++++++++++++++++++++++++++
 t/t5100-mailinfo.sh        |  6 ++++++
 t/t5100/quoted-pair.expect |  5 +++++
 t/t5100/quoted-pair.in     |  9 ++++++++
 4 files changed, 74 insertions(+)
 create mode 100644 t/t5100/quoted-pair.expect
 create mode 100644 t/t5100/quoted-pair.in

diff --git a/mailinfo.c b/mailinfo.c
index e19abe3..04036f3 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -54,15 +54,69 @@ static void parse_bogus_from(struct mailinfo *mi, const struct strbuf *line)
 	get_sane_name(&mi->name, &mi->name, &mi->email);
 }
 
+static int unquote_quoted_string(struct strbuf *line)
+{
+	struct strbuf outbuf;
+	const char *in = line->buf;
+	int c, take_next_literally = 0;
+	int found_error = 0;
+	char escape_context=0;
+
+	strbuf_init(&outbuf, line->len);
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
+				else if (escape_context == '(')
+					found_error = 1;
+				break;
+			case ')':
+				if (escape_context == '(')
+					escape_context = 0;
+				break;
+			}
+		}
+
+		strbuf_addch(&outbuf, c);
+	}
+
+	strbuf_reset(line);
+	strbuf_addbuf(line, &outbuf);
+	strbuf_release(&outbuf);
+
+	return found_error;
+
+}
+
 static void handle_from(struct mailinfo *mi, const struct strbuf *from)
 {
 	char *at;
 	size_t el;
 	struct strbuf f;
 
+
 	strbuf_init(&f, from->len);
 	strbuf_addbuf(&f, from);
 
+	unquote_quoted_string(&f);
+
 	at = strchr(f.buf, '@');
 	if (!at) {
 		parse_bogus_from(mi, from);
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 1a5a546..d0c21fc 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -142,4 +142,10 @@ test_expect_success 'mailinfo unescapes with --mboxrd' '
 	test_cmp expect mboxrd/msg
 '
 
+test_expect_success 'mailinfo unescapes rfc2822 quoted-string' '
+    mkdir quoted-pair &&
+    git mailinfo /dev/null /dev/null <"$TEST_DIRECTORY"/t5100/quoted-pair.in >quoted-pair/info &&
+    test_cmp "$TEST_DIRECTORY"/t5100/quoted-pair.expect quoted-pair/info
+'
+
 test_done
diff --git a/t/t5100/quoted-pair.expect b/t/t5100/quoted-pair.expect
new file mode 100644
index 0000000..cab1bce
--- /dev/null
+++ b/t/t5100/quoted-pair.expect
@@ -0,0 +1,5 @@
+Author: Author "The Author" Name
+Email: somebody@example.com
+Subject: testing quoted-pair
+Date: Sun, 25 May 2008 00:38:18 -0700
+
diff --git a/t/t5100/quoted-pair.in b/t/t5100/quoted-pair.in
new file mode 100644
index 0000000..e2e627a
--- /dev/null
+++ b/t/t5100/quoted-pair.in
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

