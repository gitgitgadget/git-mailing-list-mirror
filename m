Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B708920966
	for <e@80x24.org>; Tue, 28 Mar 2017 12:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751996AbdC1MXI (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 08:23:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:28717 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751882AbdC1MWw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 08:22:52 -0400
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP; 28 Mar 2017 05:22:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.36,236,1486454400"; 
   d="scan'208";a="71264311"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.35.174])
  by orsmga004.jf.intel.com with ESMTP; 28 Mar 2017 05:22:11 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH RFC 1/2] strbuf: move strbuf_add_tabexpand into strbuf.c
Date:   Tue, 28 Mar 2017 05:22:08 -0700
Message-Id: <20170328122209.4861-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.12.2.650.ga248b8c51283
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

In commit 7cc13c717b52 ("pretty: expand tabs in indented logs to make
things line up properly", 2016-03-16) a new function was added to insert
a line into a strbuf while expanding the tabs into spaces. This
functionality was used to help show the log message correctly when it
has been indented, so as to properly display the expected output.

This functionality will be useful in a future patch that adds similar
functionality into git diff, so lets move it into strbuf.c and make it
a public function.

While we're doing this, rename a few of the variables to fix the
surrounding strbuf code.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 pretty.c | 50 --------------------------------------------------
 strbuf.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 strbuf.h |  6 ++++++
 3 files changed, 56 insertions(+), 50 deletions(-)

diff --git a/pretty.c b/pretty.c
index d0f86f5d85ca..70368509ffea 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1658,56 +1658,6 @@ void pp_title_line(struct pretty_print_context *pp,
 	strbuf_release(&title);
 }
 
-static int pp_utf8_width(const char *start, const char *end)
-{
-	int width = 0;
-	size_t remain = end - start;
-
-	while (remain) {
-		int n = utf8_width(&start, &remain);
-		if (n < 0 || !start)
-			return -1;
-		width += n;
-	}
-	return width;
-}
-
-static void strbuf_add_tabexpand(struct strbuf *sb, int tabwidth,
-				 const char *line, int linelen)
-{
-	const char *tab;
-
-	while ((tab = memchr(line, '\t', linelen)) != NULL) {
-		int width = pp_utf8_width(line, tab);
-
-		/*
-		 * If it wasn't well-formed utf8, or it
-		 * had characters with badly defined
-		 * width (control characters etc), just
-		 * give up on trying to align things.
-		 */
-		if (width < 0)
-			break;
-
-		/* Output the data .. */
-		strbuf_add(sb, line, tab - line);
-
-		/* .. and the de-tabified tab */
-		strbuf_addchars(sb, ' ', tabwidth - (width % tabwidth));
-
-		/* Skip over the printed part .. */
-		linelen -= tab + 1 - line;
-		line = tab + 1;
-	}
-
-	/*
-	 * Print out everything after the last tab without
-	 * worrying about width - there's nothing more to
-	 * align.
-	 */
-	strbuf_add(sb, line, linelen);
-}
-
 /*
  * pp_handle_indent() prints out the intendation, and
  * the whole line (without the final newline), after
diff --git a/strbuf.c b/strbuf.c
index 00457940cfc1..6cecfcadb05b 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -275,6 +275,56 @@ void strbuf_commented_addf(struct strbuf *sb, const char *fmt, ...)
 	strbuf_release(&buf);
 }
 
+static int find_utf8_width(const char *start, const char *end)
+{
+	int width = 0;
+	size_t remain = end - start;
+
+	while (remain) {
+		int n = utf8_width(&start, &remain);
+		if (n < 0 || !start)
+			return -1;
+		width += n;
+	}
+	return width;
+}
+
+void strbuf_add_tabexpand(struct strbuf *sb, int tabwidth,
+			  const char *buf, size_t size)
+{
+	const char *tab;
+
+	while ((tab = memchr(buf, '\t', size)) != NULL) {
+		int width = find_utf8_width(buf, tab);
+
+		/*
+		 * If it wasn't well-formed utf8, or it
+		 * had characters with badly defined
+		 * width (control characters etc), just
+		 * give up on trying to align things.
+		 */
+		if (width < 0)
+			break;
+
+		/* Output the data .. */
+		strbuf_add(sb, buf, tab - buf);
+
+		/* .. and the de-tabified tab */
+		strbuf_addchars(sb, ' ', tabwidth - (width % tabwidth));
+
+		/* Skip over the printed part .. */
+		size -= tab + 1 - buf;
+		buf = tab + 1;
+	}
+
+	/*
+	 * Print out everything after the last tab without
+	 * worrying about width - there's nothing more to
+	 * align.
+	 */
+	strbuf_add(sb, buf, size);
+}
+
 void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap)
 {
 	int len;
diff --git a/strbuf.h b/strbuf.h
index 80047b1bb7b8..17e04911833e 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -238,6 +238,12 @@ extern void strbuf_splice(struct strbuf *, size_t pos, size_t len,
  */
 extern void strbuf_add_commented_lines(struct strbuf *out, const char *buf, size_t size);
 
+/**
+ * Add a NUL-terminated string to the buffer. Tabs will be expanded using the
+ * provided tabwidth.
+ */
+extern void strbuf_add_tabexpand(struct strbuf *sb, int tabwidth,
+				 const char *buf, size_t size);
 
 /**
  * Add data of given length to the buffer.
-- 
2.12.2.650.ga248b8c51283

