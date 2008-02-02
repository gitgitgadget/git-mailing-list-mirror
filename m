From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 13/13] core.whitespace: cr-at-eol
Date: Sat,  2 Feb 2008 02:54:19 -0800
Message-ID: <1201949659-27725-14-git-send-email-gitster@pobox.com>
References: <1201949659-27725-1-git-send-email-gitster@pobox.com>
 <1201949659-27725-2-git-send-email-gitster@pobox.com>
 <1201949659-27725-3-git-send-email-gitster@pobox.com>
 <1201949659-27725-4-git-send-email-gitster@pobox.com>
 <1201949659-27725-5-git-send-email-gitster@pobox.com>
 <1201949659-27725-6-git-send-email-gitster@pobox.com>
 <1201949659-27725-7-git-send-email-gitster@pobox.com>
 <1201949659-27725-8-git-send-email-gitster@pobox.com>
 <1201949659-27725-9-git-send-email-gitster@pobox.com>
 <1201949659-27725-10-git-send-email-gitster@pobox.com>
 <1201949659-27725-11-git-send-email-gitster@pobox.com>
 <1201949659-27725-12-git-send-email-gitster@pobox.com>
 <1201949659-27725-13-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 11:56:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLG2v-0005Ue-F8
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 11:56:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763295AbYBBKzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 05:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763545AbYBBKzM
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 05:55:12 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43771 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763117AbYBBKzH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 05:55:07 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4873450FB
	for <git@vger.kernel.org>; Sat,  2 Feb 2008 05:55:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CBEB50FA
	for <git@vger.kernel.org>; Sat,  2 Feb 2008 05:55:03 -0500 (EST)
X-Mailer: git-send-email 1.5.4.2.g41ac4
In-Reply-To: <1201949659-27725-13-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72255>

This new error mode allows a line to have a carriage return at the
end of the line when checking and fixing trailing whitespace errors.

Some people like to keep CRLF line ending recorded in the repository,
and still want to take advantage of the automated trailing whitespace
stripping.  We still show ^M in the diff output piped to "less" to
remind them that they do have the CR at the end, but these carriage
return characters at the end are no longer flagged as errors.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |    4 ++++
 builtin-apply.c          |   18 ++++++++++++++----
 cache.h                  |    1 +
 t/t4019-diff-wserror.sh  |   40 ++++++++++++++++++++++++++++++++++++++++
 ws.c                     |   15 +++++++++++++--
 5 files changed, 72 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4e222f1..44cb640 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -308,6 +308,10 @@ core.whitespace::
   error (enabled by default).
 * `indent-with-non-tab` treats a line that is indented with 8 or more
   space characters as an error (not enabled by default).
+* `cr-at-eol` treats a carriage-return at the end of line as
+  part of the line terminator, i.e. with it, `trailing-space`
+  does not trigger if the character before such a carriage-return
+  is not a whitespace (not enabled by default).
 
 alias.*::
 	Command aliases for the linkgit:git[1] command wrapper - e.g.
diff --git a/builtin-apply.c b/builtin-apply.c
index fccf4a4..2b8ba81 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1525,6 +1525,7 @@ static int copy_wsfix(char *output, const char *patch, int plen,
 	 */
 	int i;
 	int add_nl_to_tail = 0;
+	int add_cr_to_tail = 0;
 	int fixed = 0;
 	int last_tab_in_indent = -1;
 	int last_space_in_indent = -1;
@@ -1536,12 +1537,19 @@ static int copy_wsfix(char *output, const char *patch, int plen,
 	 */
 	if ((ws_rule & WS_TRAILING_SPACE) &&
 	    (2 < plen && isspace(patch[plen-2]))) {
-		if (patch[plen-1] == '\n')
+		if (patch[plen - 1] == '\n') {
 			add_nl_to_tail = 1;
-		plen--;
-		while (0 < plen && isspace(patch[plen-1]))
 			plen--;
-		fixed = 1;
+			if (1 < plen && patch[plen - 1] == '\r') {
+				add_cr_to_tail = !!(ws_rule & WS_CR_AT_EOL);
+				plen--;
+			}
+		}
+		if (0 < plen && isspace(patch[plen - 1])) {
+			while (0 < plen && isspace(patch[plen-1]))
+				plen--;
+			fixed = 1;
+		}
 	}
 
 	/*
@@ -1602,6 +1610,8 @@ static int copy_wsfix(char *output, const char *patch, int plen,
 	}
 
 	memcpy(output, patch, plen);
+	if (add_cr_to_tail)
+		output[plen++] = '\r';
 	if (add_nl_to_tail)
 		output[plen++] = '\n';
 	if (fixed && count_error)
diff --git a/cache.h b/cache.h
index 549f4bb..ad11c90 100644
--- a/cache.h
+++ b/cache.h
@@ -652,6 +652,7 @@ void shift_tree(const unsigned char *, const unsigned char *, unsigned char *, i
 #define WS_TRAILING_SPACE	01
 #define WS_SPACE_BEFORE_TAB	02
 #define WS_INDENT_WITH_NON_TAB	04
+#define WS_CR_AT_EOL           010
 #define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB)
 extern unsigned whitespace_rule_cfg;
 extern unsigned whitespace_rule(const char *);
diff --git a/t/t4019-diff-wserror.sh b/t/t4019-diff-wserror.sh
index 67e080b..0d9cbb6 100755
--- a/t/t4019-diff-wserror.sh
+++ b/t/t4019-diff-wserror.sh
@@ -12,6 +12,7 @@ test_expect_success setup '
 	echo "         Eight SP indent" >>F &&
 	echo " 	HT and SP indent" >>F &&
 	echo "With trailing SP " >>F &&
+	echo "Carriage ReturnQ" | tr Q "\015" >>F &&
 	echo "No problem" >>F
 
 '
@@ -27,6 +28,7 @@ test_expect_success default '
 	grep Eight normal >/dev/null &&
 	grep HT error >/dev/null &&
 	grep With error >/dev/null &&
+	grep Return error >/dev/null &&
 	grep No normal >/dev/null
 
 '
@@ -41,6 +43,7 @@ test_expect_success 'without -trail' '
 	grep Eight normal >/dev/null &&
 	grep HT error >/dev/null &&
 	grep With normal >/dev/null &&
+	grep Return normal >/dev/null &&
 	grep No normal >/dev/null
 
 '
@@ -56,6 +59,7 @@ test_expect_success 'without -trail (attribute)' '
 	grep Eight normal >/dev/null &&
 	grep HT error >/dev/null &&
 	grep With normal >/dev/null &&
+	grep Return normal >/dev/null &&
 	grep No normal >/dev/null
 
 '
@@ -71,6 +75,7 @@ test_expect_success 'without -space' '
 	grep Eight normal >/dev/null &&
 	grep HT normal >/dev/null &&
 	grep With error >/dev/null &&
+	grep Return error >/dev/null &&
 	grep No normal >/dev/null
 
 '
@@ -86,6 +91,7 @@ test_expect_success 'without -space (attribute)' '
 	grep Eight normal >/dev/null &&
 	grep HT normal >/dev/null &&
 	grep With error >/dev/null &&
+	grep Return error >/dev/null &&
 	grep No normal >/dev/null
 
 '
@@ -101,6 +107,7 @@ test_expect_success 'with indent-non-tab only' '
 	grep Eight error >/dev/null &&
 	grep HT normal >/dev/null &&
 	grep With normal >/dev/null &&
+	grep Return normal >/dev/null &&
 	grep No normal >/dev/null
 
 '
@@ -116,6 +123,39 @@ test_expect_success 'with indent-non-tab only (attribute)' '
 	grep Eight error >/dev/null &&
 	grep HT normal >/dev/null &&
 	grep With normal >/dev/null &&
+	grep Return normal >/dev/null &&
+	grep No normal >/dev/null
+
+'
+
+test_expect_success 'with cr-at-eol' '
+
+	rm -f .gitattributes
+	git config core.whitespace cr-at-eol
+	git diff --color >output
+	grep "$blue_grep" output >error
+	grep -v "$blue_grep" output >normal
+
+	grep Eight normal >/dev/null &&
+	grep HT error >/dev/null &&
+	grep With error >/dev/null &&
+	grep Return normal >/dev/null &&
+	grep No normal >/dev/null
+
+'
+
+test_expect_success 'with cr-at-eol (attribute)' '
+
+	git config --unset core.whitespace
+	echo "F whitespace=trailing,cr-at-eol" >.gitattributes
+	git diff --color >output
+	grep "$blue_grep" output >error
+	grep -v "$blue_grep" output >normal
+
+	grep Eight normal >/dev/null &&
+	grep HT error >/dev/null &&
+	grep With error >/dev/null &&
+	grep Return normal >/dev/null &&
 	grep No normal >/dev/null
 
 '
diff --git a/ws.c b/ws.c
index d09b9df..5a9ac45 100644
--- a/ws.c
+++ b/ws.c
@@ -14,6 +14,7 @@ static struct whitespace_rule {
 	{ "trailing-space", WS_TRAILING_SPACE },
 	{ "space-before-tab", WS_SPACE_BEFORE_TAB },
 	{ "indent-with-non-tab", WS_INDENT_WITH_NON_TAB },
+	{ "cr-at-eol", WS_CR_AT_EOL },
 };
 
 unsigned parse_whitespace_rule(const char *string)
@@ -124,6 +125,7 @@ unsigned check_and_emit_line(const char *line, int len, unsigned ws_rule,
 	int written = 0;
 	int trailing_whitespace = -1;
 	int trailing_newline = 0;
+	int trailing_carriage_return = 0;
 	int i;
 
 	/* Logic is simpler if we temporarily ignore the trailing newline. */
@@ -131,6 +133,11 @@ unsigned check_and_emit_line(const char *line, int len, unsigned ws_rule,
 		trailing_newline = 1;
 		len--;
 	}
+	if ((ws_rule & WS_CR_AT_EOL) &&
+	    len > 0 && line[len - 1] == '\r') {
+		trailing_carriage_return = 1;
+		len--;
+	}
 
 	/* Check for trailing whitespace. */
 	if (ws_rule & WS_TRAILING_SPACE) {
@@ -176,8 +183,10 @@ unsigned check_and_emit_line(const char *line, int len, unsigned ws_rule,
 	}
 
 	if (stream) {
-		/* Now the rest of the line starts at written.
-		 * The non-highlighted part ends at trailing_whitespace. */
+		/*
+		 * Now the rest of the line starts at "written".
+		 * The non-highlighted part ends at "trailing_whitespace".
+		 */
 		if (trailing_whitespace == -1)
 			trailing_whitespace = len;
 
@@ -196,6 +205,8 @@ unsigned check_and_emit_line(const char *line, int len, unsigned ws_rule,
 			    len - trailing_whitespace, 1, stream);
 			fputs(reset, stream);
 		}
+		if (trailing_carriage_return)
+			fputc('\r', stream);
 		if (trailing_newline)
 			fputc('\n', stream);
 	}
-- 
1.5.4.2.g41ac4
