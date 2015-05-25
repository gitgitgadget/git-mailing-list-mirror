From: Christian Brabandt <cblists@256bit.org>,
	Christian Brabandt <cb@256bit.org>
Subject: Mark trailing whitespace error in del lines of diff
Date: Mon, 25 May 2015 23:11:34 +0200
Message-ID: <9b8e349e223dc9cd871fc5f7915e590548322932.1432585659.git.cb@256bit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 23:51:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yx0H5-0005S9-V8
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 23:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbbEYVvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 17:51:04 -0400
Received: from 256bit.org ([144.76.87.176]:44293 "EHLO 256bit.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929AbbEYVvA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2015 17:51:00 -0400
X-Greylist: delayed 2364 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 May 2015 17:51:00 EDT
Received: from chrisbra by 256bit.org with local (Exim 4.76)
	(envelope-from <chrisbra@256bit.org>)
	id 1Ywzeo-0007sy-Dv
	for git@vger.kernel.org; Mon, 25 May 2015 23:11:34 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: chrisbra@256bit.org
X-SA-Exim-Scanned: No (on 256bit.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269912>

Currently git-diff only highlights trailing whitespace in the new lines
(prefixed with '+'), thus it is not visible in the deleted lines
(prefixed with '-').

Therefore introduce a new configuration variable for the core.whitespace
setting "blank-at-eol-old" (default off) that will highlight trailing
whitespace in those lines as well.

Signed-off-by: Christian Brabandt <cb@256bit.org>
---

Hi,
please be gentle, this is the first time I contribute to the git 
development.

Here is my use case: I have been working in a team repository, 
reformatting the source and wondered, why my reformatting did introduce 
some trailing whitespace. I suspected a bug in Vim and started to debug 
it, until I found out, that git-diff simply does not show trailing 
whitespace in the deleted lines. Therefore, I'd like to have an option, 
to also show trailing whitespace in the deleted lines of a diff. So here 
is the patch.

As far as I can see, this does not break any tests and also the 
behaviour of git-diff --check does not change. 

 Documentation/config.txt | 2 ++
 cache.h                  | 1 +
 diff.c                   | 8 +++++++-
 ws.c                     | 8 ++++++--
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0f668bb..f73f0f7 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -670,6 +670,8 @@ core.whitespace::
 +
 * `blank-at-eol` treats trailing whitespaces at the end of the line
   as an error (enabled by default).
+* `blank-at-eol-old` like `blank-at-eol`, but for the deleted lines
+  of a patch (i.e. those preceeded with a '-') (not enabled by default)
 * `space-before-tab` treats a space character that appears immediately
   before a tab character in the initial indent part of the line as an
   error (enabled by default).
diff --git a/cache.h b/cache.h
index 1f4226b..811b640 100644
--- a/cache.h
+++ b/cache.h
@@ -1618,6 +1618,7 @@ void shift_tree_by(const unsigned char *, const unsigned char *, unsigned char *
 #define WS_CR_AT_EOL           01000
 #define WS_BLANK_AT_EOF        02000
 #define WS_TAB_IN_INDENT       04000
+#define WS_BLANK_AT_EOL_OLD    010000
 #define WS_TRAILING_SPACE      (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
 #define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB|8)
 #define WS_TAB_WIDTH_MASK        077
diff --git a/diff.c b/diff.c
index 7500c55..4245956 100644
--- a/diff.c
+++ b/diff.c
@@ -1254,10 +1254,16 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		const char *color =
 			diff_get_color(ecbdata->color_diff,
 				       line[0] == '-' ? DIFF_FILE_OLD : DIFF_PLAIN);
+		const char *ws = diff_get_color(ecbdata->color_diff, DIFF_WHITESPACE);
+
 		ecbdata->lno_in_preimage++;
 		if (line[0] == ' ')
 			ecbdata->lno_in_postimage++;
-		emit_line(ecbdata->opt, color, reset, line, len);
+		if (*ws && ecbdata->ws_rule & WS_BLANK_AT_EOL_OLD)
+			ws_check_emit(line, len, ecbdata->ws_rule,
+				ecbdata->opt->file, color, reset, ws);
+		else
+			emit_line(ecbdata->opt, color, reset, line, len);
 	} else {
 		ecbdata->lno_in_postimage++;
 		emit_add_line(reset, ecbdata, line + 1, len - 1);
diff --git a/ws.c b/ws.c
index ea4b2b1..09e04f0 100644
--- a/ws.c
+++ b/ws.c
@@ -18,6 +18,7 @@ static struct whitespace_rule {
 	{ "indent-with-non-tab", WS_INDENT_WITH_NON_TAB, 0 },
 	{ "cr-at-eol", WS_CR_AT_EOL, 1 },
 	{ "blank-at-eol", WS_BLANK_AT_EOL, 0 },
+	{ "blank-at-eol-del", WS_BLANK_AT_EOL_OLD, 0, 1 },
 	{ "blank-at-eof", WS_BLANK_AT_EOF, 0 },
 	{ "tab-in-indent", WS_TAB_IN_INDENT, 0, 1 },
 };
@@ -170,11 +171,14 @@ static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
 	}
 
 	/* Check for trailing whitespace. */
-	if (ws_rule & WS_BLANK_AT_EOL) {
+	if ((ws_rule & WS_BLANK_AT_EOL) || (ws_rule & WS_BLANK_AT_EOL_OLD)) {
 		for (i = len - 1; i >= 0; i--) {
 			if (isspace(line[i])) {
 				trailing_whitespace = i;
-				result |= WS_BLANK_AT_EOL;
+				if (ws_rule & WS_BLANK_AT_EOL)
+					result |= WS_BLANK_AT_EOL;
+				else
+					result |= WS_BLANK_AT_EOL_OLD;
 			}
 			else
 				break;
