From: Chris Webb <chris@arachsys.com>
Subject: [RFC 1/1] Add new indent-with-tab whitespace check
Date: Sat, 27 Mar 2010 14:08:01 +0000
Message-ID: <1269698881-26443-2-git-send-email-chris@arachsys.com>
References: <1269698881-26443-1-git-send-email-chris@arachsys.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 27 15:13:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvWlV-0003nf-IX
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 15:13:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372Ab0C0ONX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 10:13:23 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:56575 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327Ab0C0ONW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 10:13:22 -0400
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1NvWgE-0002Qa-Ge
	for git@vger.kernel.org; Sat, 27 Mar 2010 14:08:02 +0000
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <1269698881-26443-1-git-send-email-chris@arachsys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143333>

The indent-with-tab rule warns about any tab characters used in initial
indent, and highlights them in git diff --check.

Signed-off-by: Chris Webb <chris@arachsys.com>
---
 cache.h |    1 +
 ws.c    |   26 ++++++++++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index 2928107..d87bd85 100644
--- a/cache.h
+++ b/cache.h
@@ -1040,6 +1040,7 @@ void shift_tree_by(const unsigned char *, const unsigned char *, unsigned char *
 #define WS_INDENT_WITH_NON_TAB	04
 #define WS_CR_AT_EOL           010
 #define WS_BLANK_AT_EOF        020
+#define WS_INDENT_WITH_TAB     040
 #define WS_TRAILING_SPACE      (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
 #define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB)
 extern unsigned whitespace_rule_cfg;
diff --git a/ws.c b/ws.c
index c089338..e44a711 100644
--- a/ws.c
+++ b/ws.c
@@ -18,6 +18,7 @@ static struct whitespace_rule {
 	{ "cr-at-eol", WS_CR_AT_EOL, 1 },
 	{ "blank-at-eol", WS_BLANK_AT_EOL, 0 },
 	{ "blank-at-eof", WS_BLANK_AT_EOF, 0 },
+	{ "indent-with-tab", WS_INDENT_WITH_TAB, 0 },
 };
 
 unsigned parse_whitespace_rule(const char *string)
@@ -125,6 +126,11 @@ char *whitespace_error_string(unsigned ws)
 			strbuf_addstr(&err, ", ");
 		strbuf_addstr(&err, "indent with spaces");
 	}
+	if (ws & WS_INDENT_WITH_TAB) {
+		if (err.len)
+			strbuf_addstr(&err, ", ");
+		strbuf_addstr(&err, "indent with tab");
+	}
 	return strbuf_detach(&err, NULL);
 }
 
@@ -163,23 +169,31 @@ static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
 		}
 	}
 
-	/* Check for space before tab in initial indent. */
+	/* Check for indent using tab or space before tab in initial indent. */
 	for (i = 0; i < len; i++) {
 		if (line[i] == ' ')
 			continue;
 		if (line[i] != '\t')
 			break;
-		if ((ws_rule & WS_SPACE_BEFORE_TAB) && written < i) {
+		if (ws_rule & WS_INDENT_WITH_TAB) {
+			result |= WS_INDENT_WITH_TAB;
+			if (stream) {
+				fwrite(line + written, i - written, 1, stream);
+				fputs(ws, stream);
+				fwrite(line + i, 1, 1, stream);
+				fputs(reset, stream);
+			}
+		} else if ((ws_rule & WS_SPACE_BEFORE_TAB) && written < i) {
 			result |= WS_SPACE_BEFORE_TAB;
 			if (stream) {
 				fputs(ws, stream);
 				fwrite(line + written, i - written, 1, stream);
 				fputs(reset, stream);
+				fwrite(line + i, 1, 1, stream);
 			}
-		} else if (stream)
-			fwrite(line + written, i - written, 1, stream);
-		if (stream)
-			fwrite(line + i, 1, 1, stream);
+		} else if (stream) {
+			fwrite(line + written, i - written + 1, 1, stream);
+		}
 		written = i + 1;
 	}
 
-- 
1.7.0.1
