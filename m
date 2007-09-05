From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Use proper strbuf API, and also simplify cmd_data code.
Date: Wed,  5 Sep 2007 21:18:39 +0200
Message-ID: <1189019923740-git-send-email-madcoder@debian.org>
References: <20070905085720.GD31750@artemis.corp>
 <11890199232110-git-send-email-madcoder@debian.org>
 <11890199232128-git-send-email-madcoder@debian.org>
 <11890199232646-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 05 21:18:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT0Oq-0003ur-Qe
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 21:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755700AbXIETSt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 15:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755678AbXIETSt
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 15:18:49 -0400
Received: from pan.madism.org ([88.191.52.104]:46561 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755095AbXIETSp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 15:18:45 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 3F2E71E1D7;
	Wed,  5 Sep 2007 21:18:44 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id CA8F13244B6; Wed,  5 Sep 2007 21:18:43 +0200 (CEST)
X-Mailer: git-send-email 1.5.3
In-Reply-To: <11890199232646-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57745>

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
