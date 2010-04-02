From: Chris Webb <chris@arachsys.com>
Subject: [PATCH 2/6] whitespace: add tab-in-indent error class
Date: Sat, 3 Apr 2010 00:37:08 +0100
Message-ID: <c2612b53dc7105805a2455a4188667552b1ee606.1270250437.git.chris@arachsys.com>
References: <cover.1270250437.git.chris@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 03 01:37:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxqQo-00051w-Hx
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 01:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755057Ab0DBXhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 19:37:14 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:39385 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754149Ab0DBXhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 19:37:09 -0400
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1NxqQG-0004vf-Bb; Sat, 03 Apr 2010 00:37:08 +0100
Content-Disposition: inline
In-Reply-To: <cover.1270250437.git.chris@arachsys.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143862>

Some projects and languages use coding style where no tab character is used to
indent the lines.

This only adds support and documentation for "apply --whitespace=warn" and
"diff --check"; later patches add "apply --whitespace=fix" and tests.

Signed-off-by: Chris Webb <chris@arachsys.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |    2 ++
 cache.h                  |    1 +
 ws.c                     |   27 ++++++++++++++++++++++-----
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 06b2f82..9bb8f3d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -481,6 +481,8 @@ core.whitespace::
   error (enabled by default).
 * `indent-with-non-tab` treats a line that is indented with 8 or more
   space characters as an error (not enabled by default).
+* `tab-in-indent` treats a tab character in the initial indent part of
+  the line as an error (not enabled by default).
 * `blank-at-eof` treats blank lines added at the end of file as an error
   (enabled by default).
 * `trailing-space` is a short-hand to cover both `blank-at-eol` and
diff --git a/cache.h b/cache.h
index 6dcb100..030af32 100644
--- a/cache.h
+++ b/cache.h
@@ -1040,6 +1040,7 @@ void shift_tree_by(const unsigned char *, const unsigned char *, unsigned char *
 #define WS_INDENT_WITH_NON_TAB	04
 #define WS_CR_AT_EOL           010
 #define WS_BLANK_AT_EOF        020
+#define WS_TAB_IN_INDENT       040
 #define WS_TRAILING_SPACE      (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
 #define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB)
 extern unsigned whitespace_rule_cfg;
diff --git a/ws.c b/ws.c
index f4afcdd..0302ef5 100644
--- a/ws.c
+++ b/ws.c
@@ -19,6 +19,7 @@ static struct whitespace_rule {
 	{ "cr-at-eol", WS_CR_AT_EOL, 1 },
 	{ "blank-at-eol", WS_BLANK_AT_EOL, 0 },
 	{ "blank-at-eof", WS_BLANK_AT_EOF, 0 },
+	{ "tab-in-indent", WS_TAB_IN_INDENT, 0, 1 },
 };
 
 unsigned parse_whitespace_rule(const char *string)
@@ -57,6 +58,9 @@ unsigned parse_whitespace_rule(const char *string)
 		}
 		string = ep;
 	}
+
+	if (rule & WS_TAB_IN_INDENT && rule & WS_INDENT_WITH_NON_TAB)
+		die("cannot enforce both tab-in-indent and indent-with-non-tab");
 	return rule;
 }
 
@@ -127,6 +131,11 @@ char *whitespace_error_string(unsigned ws)
 			strbuf_addstr(&err, ", ");
 		strbuf_addstr(&err, "indent with spaces");
 	}
+	if (ws & WS_TAB_IN_INDENT) {
+		if (err.len)
+			strbuf_addstr(&err, ", ");
+		strbuf_addstr(&err, "tab in indent");
+	}
 	return strbuf_detach(&err, NULL);
 }
 
@@ -165,7 +174,7 @@ static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
 		}
 	}
 
-	/* Check for space before tab in initial indent. */
+	/* Check indentation */
 	for (i = 0; i < len; i++) {
 		if (line[i] == ' ')
 			continue;
@@ -177,11 +186,19 @@ static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
 				fputs(ws, stream);
 				fwrite(line + written, i - written, 1, stream);
 				fputs(reset, stream);
+				fwrite(line + i, 1, 1, stream);
 			}
-		} else if (stream)
-			fwrite(line + written, i - written, 1, stream);
-		if (stream)
-			fwrite(line + i, 1, 1, stream);
+		} else if (ws_rule & WS_TAB_IN_INDENT) {
+			result |= WS_TAB_IN_INDENT;
+			if (stream) {
+				fwrite(line + written, i - written, 1, stream);
+				fputs(ws, stream);
+				fwrite(line + i, 1, 1, stream);
+				fputs(reset, stream);
+			}
+		} else if (stream) {
+			fwrite(line + written, i - written + 1, 1, stream);
+		}
 		written = i + 1;
 	}
 
-- 
1.7.0.3
