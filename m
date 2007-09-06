From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 3/7] Use proper strbuf API, and also simplify cmd_data code.
Date: Thu,  6 Sep 2007 13:20:07 +0200
Message-ID: <11890776112292-git-send-email-madcoder@debian.org>
References: <20070902224213.GB431@artemis.corp>
 <11890776114037-git-send-email-madcoder@debian.org>
 <118907761140-git-send-email-madcoder@debian.org>
 <11890776111843-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 13:20:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITFPl-0008PZ-0M
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 13:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228AbXIFLUU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 07:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752839AbXIFLUT
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 07:20:19 -0400
Received: from pan.madism.org ([88.191.52.104]:52607 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751645AbXIFLUN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 07:20:13 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id DFA251E404;
	Thu,  6 Sep 2007 13:20:12 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id D62661A3BF; Thu,  6 Sep 2007 13:20:11 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <11890776111843-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57865>

  This patch features the use of strbuf_detach, and prevent the programmer
to mess with allocation directly. The code is as efficent as before, just
more concise and more straightforward.
---
 fast-import.c |   30 +++++++++++++-----------------
 1 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 2f7baf4..74ff0fd 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -340,7 +340,7 @@ static struct tag *last_tag;
 
 /* Input stream parsing */
 static whenspec_type whenspec = WHENSPEC_RAW;
-static struct strbuf command_buf;
+static struct strbuf command_buf = STRBUF_INIT;
 static int unread_command_buf;
 static struct recent_command cmd_hist = {&cmd_hist, &cmd_hist, NULL};
 static struct recent_command *cmd_tail = &cmd_hist;
@@ -1638,17 +1638,16 @@ static void cmd_mark(void)
 
 static void *cmd_data (size_t *size)
 {
-	size_t length;
-	char *buffer;
+	struct strbuf buffer;
 
+	strbuf_init(&buffer);
 	if (prefixcmp(command_buf.buf, "data "))
 		die("Expected 'data n' command, found: %s", command_buf.buf);
 
 	if (!prefixcmp(command_buf.buf + 5, "<<")) {
 		char *term = xstrdup(command_buf.buf + 5 + 2);
-		size_t sz = 8192, term_len = command_buf.len - 5 - 2;
-		length = 0;
-		buffer = xmalloc(sz);
+		size_t term_len = command_buf.len - 5 - 2;
+
 		for (;;) {
 			read_line(&command_buf, stdin, '\n');
 			if (command_buf.eof)
@@ -1656,21 +1655,18 @@ static void *cmd_data (size_t *size)
 			if (term_len == command_buf.len
 				&& !strcmp(term, command_buf.buf))
 				break;
-			ALLOC_GROW(buffer, length + command_buf.len + 1, sz);
-			memcpy(buffer + length,
-				command_buf.buf,
-				command_buf.len);
-			length += command_buf.len;
-			buffer[length++] = '\n';
+			strbuf_addbuf(&buffer, &command_buf);
+			strbuf_addch(&buffer, '\n');
 		}
 		free(term);
 	}
 	else {
-		size_t n = 0;
+		size_t n = 0, length;
+
 		length = strtoul(command_buf.buf + 5, NULL, 10);
-		buffer = xmalloc(length);
+
 		while (n < length) {
-			size_t s = fread(buffer + n, 1, length - n, stdin);
+			size_t s = strbuf_fread(&buffer, length - n, stdin);
 			if (!s && feof(stdin))
 				die("EOF in data (%lu bytes remaining)",
 					(unsigned long)(length - n));
@@ -1679,8 +1675,8 @@ static void *cmd_data (size_t *size)
 	}
 
 	skip_optional_lf();
-	*size = length;
-	return buffer;
+	*size = buffer.len;
+	return strbuf_detach(&buffer);
 }
 
 static int validate_raw_date(const char *src, char *result, int maxlen)
-- 
1.5.3.1
