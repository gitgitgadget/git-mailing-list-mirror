From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Use proper strbuf API, and also simplify cmd_data code.
Date: Tue,  4 Sep 2007 16:01:14 +0200
Message-ID: <11889144741561-git-send-email-madcoder@debian.org>
References: <20070904115317.GA3381@artemis.corp>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 04 16:02:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISYy0-0005lj-UF
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 16:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561AbXIDOBQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 10:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753591AbXIDOBQ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 10:01:16 -0400
Received: from pan.madism.org ([88.191.52.104]:40916 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753557AbXIDOBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 10:01:16 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 189D81DE35;
	Tue,  4 Sep 2007 16:01:15 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 51A3A2D42C2; Tue,  4 Sep 2007 16:01:14 +0200 (CEST)
X-Mailer: git-send-email 1.5.3
In-Reply-To: <20070904115317.GA3381@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57572>

  This patch features the use of strbuf_detach, and prevent the programmer
to mess with allocation directly. The code is as efficent as before, just
more concise and more straightforward.
---
 fast-import.c |   29 ++++++++++++-----------------
 1 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 2f7baf4..1a02481 100644
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
@@ -1638,17 +1638,15 @@ static void cmd_mark(void)
 
 static void *cmd_data (size_t *size)
 {
-	size_t length;
-	char *buffer;
+	struct strbuf buffer = STRBUF_INIT;
 
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
@@ -1656,21 +1654,18 @@ static void *cmd_data (size_t *size)
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
@@ -1679,8 +1674,8 @@ static void *cmd_data (size_t *size)
 	}
 
 	skip_optional_lf();
-	*size = length;
-	return buffer;
+	*size = buffer.len;
+	return strbuf_detach(&buffer);
 }
 
 static int validate_raw_date(const char *src, char *result, int maxlen)
-- 
1.5.3
