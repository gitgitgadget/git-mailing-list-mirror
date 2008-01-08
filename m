From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] core.whitespace cr-at-eol-is-ok
Date: Tue, 08 Jan 2008 15:51:00 -0800
Message-ID: <7v4pdnri57.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 00:51:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCOEP-0006cH-2w
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 00:51:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbYAHXvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 18:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753997AbYAHXvK
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 18:51:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46902 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754363AbYAHXvH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 18:51:07 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C58CD78D7;
	Tue,  8 Jan 2008 18:51:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C8B5C78D5;
	Tue,  8 Jan 2008 18:51:03 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69937>

This allows a line to have a carriage return at the end when
checking and fixing trailing whitespaces.

I think the previous one to fix the message from --check is a
1.5.4 material, but this certainly is not.  The naming of the
rule is iffy at best and the semantics when enabling all error
checks via attributes by setting whitespace attribute to true
should not include this option.

I haven't tested this very seriously other than adding just a
few tests to an existing test script.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 builtin-apply.c         |   21 +++++++++++++++------
 cache.h                 |    1 +
 t/t4019-diff-wserror.sh |   40 ++++++++++++++++++++++++++++++++++++++++
 ws.c                    |   15 +++++++++++++--
 4 files changed, 69 insertions(+), 8 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index d57bb6e..dcd9f09 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1549,6 +1549,7 @@ static int apply_line(char *output, const char *patch, int plen,
 	 */
 	int i;
 	int add_nl_to_tail = 0;
+	int add_cr_to_tail = 0;
 	int fixed = 0;
 	int last_tab_in_indent = 0;
 	int last_space_in_indent = 0;
@@ -1564,14 +1565,20 @@ static int apply_line(char *output, const char *patch, int plen,
 	/*
 	 * Strip trailing whitespace
 	 */
-	if ((ws_rule & WS_TRAILING_SPACE) &&
-	    (1 < plen && isspace(patch[plen-1]))) {
-		if (patch[plen] == '\n')
+	if ((ws_rule & WS_TRAILING_SPACE)) {
+		if (patch[plen] == '\n') {
 			add_nl_to_tail = 1;
-		plen--;
-		while (0 < plen && isspace(patch[plen]))
 			plen--;
-		fixed = 1;
+			if (1 < plen && patch[plen - 1] == '\r') {
+				add_cr_to_tail = 1;
+				plen--;
+			}
+		}
+		if (isspace(patch[plen])) {
+			while (0 < plen && isspace(patch[plen]))
+				plen--;
+			fixed = 1;
+		}
 	}
 
 	/*
@@ -1633,6 +1640,8 @@ static int apply_line(char *output, const char *patch, int plen,
 		i = 1;
 
 	memcpy(output, patch + i, plen);
+	if (add_cr_to_tail)
+		output[plen++] = '\r';
 	if (add_nl_to_tail)
 		output[plen++] = '\n';
 	if (fixed)
diff --git a/cache.h b/cache.h
index 39331c2..3836176 100644
--- a/cache.h
+++ b/cache.h
@@ -651,6 +651,7 @@ void shift_tree(const unsigned char *, const unsigned char *, unsigned char *, i
 #define WS_TRAILING_SPACE	01
 #define WS_SPACE_BEFORE_TAB	02
 #define WS_INDENT_WITH_NON_TAB	04
+#define WS_CR_AT_EOL_IS_OK	010
 #define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB)
 extern unsigned whitespace_rule_cfg;
 extern unsigned whitespace_rule(const char *);
diff --git a/t/t4019-diff-wserror.sh b/t/t4019-diff-wserror.sh
index 67e080b..429d870 100755
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
@@ -70,6 +74,7 @@ test_expect_success 'without -space' '
 
 	grep Eight normal >/dev/null &&
 	grep HT normal >/dev/null &&
+	grep Return error >/dev/null &&
 	grep With error >/dev/null &&
 	grep No normal >/dev/null
 
@@ -85,6 +90,7 @@ test_expect_success 'without -space (attribute)' '
 
 	grep Eight normal >/dev/null &&
 	grep HT normal >/dev/null &&
+	grep Return error >/dev/null &&
 	grep With error >/dev/null &&
 	grep No normal >/dev/null
 
@@ -100,6 +106,7 @@ test_expect_success 'with indent-non-tab only' '
 
 	grep Eight error >/dev/null &&
 	grep HT normal >/dev/null &&
+	grep Return normal >/dev/null &&
 	grep With normal >/dev/null &&
 	grep No normal >/dev/null
 
@@ -115,9 +122,42 @@ test_expect_success 'with indent-non-tab only (attribute)' '
 
 	grep Eight error >/dev/null &&
 	grep HT normal >/dev/null &&
+	grep Return normal >/dev/null &&
 	grep With normal >/dev/null &&
 	grep No normal >/dev/null
 
 '
 
+test_expect_success 'with cr-at-eol-is-ok' '
+
+	rm -f .gitattributes
+	git config core.whitespace cr-at-eol-is-ok
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
+test_expect_success 'with cr-at-eol-is-ok (attribute)' '
+
+	git config --unset core.whitespace
+	echo "F whitespace=trailing,cr-at-eol-is-ok" >.gitattributes
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
 test_done
diff --git a/ws.c b/ws.c
index d09b9df..805be56 100644
--- a/ws.c
+++ b/ws.c
@@ -14,6 +14,7 @@ static struct whitespace_rule {
 	{ "trailing-space", WS_TRAILING_SPACE },
 	{ "space-before-tab", WS_SPACE_BEFORE_TAB },
 	{ "indent-with-non-tab", WS_INDENT_WITH_NON_TAB },
+	{ "cr-at-eol-is-ok", WS_CR_AT_EOL_IS_OK },
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
+	if ((ws_rule & WS_CR_AT_EOL_IS_OK) &&
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
