From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH 2/2 v2] Make the tab width used for whitespace checks configurable
Date: Tue, 30 Nov 2010 09:29:11 +0100
Message-ID: <4CF4B5D7.2090309@viscovery.net>
References: <4CF366B1.8070400@viscovery.net> <7vhbezwqan.fsf@alter.siamese.dyndns.org> <4CF4B42C.4080104@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 30 09:29:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNLaT-00037O-Gg
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 09:29:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553Ab0K3I3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Nov 2010 03:29:17 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:52266 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754041Ab0K3I3O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Nov 2010 03:29:14 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PNLaK-0007OU-2L; Tue, 30 Nov 2010 09:29:12 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id C68C91660F;
	Tue, 30 Nov 2010 09:29:11 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <4CF4B42C.4080104@viscovery.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162481>

From: Johannes Sixt <j6t@kdbg.org>

A new whitespace "rule" is added that sets the tab width to use for
whitespace checks and fix-ups and replaces the hard-coded constant 8.

Since the setting is part of the rules, it can be set per file using
.gitattributes.

The new configuration is backwards compatible because older git versions
simply ignore unknown whitespace rules.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Compared to the first submission, I added a warning() when tabwidth=foo
 is junk or out of range and tweaked the documentation. The interdiff is:

	diff --git a/Documentation/config.txt b/Documentation/config.txt
	index d88db1c..7aff5ce 100644
	--- a/Documentation/config.txt
	+++ b/Documentation/config.txt
	@@ -514,7 +514,7 @@ core.whitespace::
	   does not trigger if the character before such a carriage-return
	   is not a whitespace (not enabled by default).
	 * `tabwidth=<n>` tells how many character positions a tab occupies; this
	-  is relevant for `indent-with-non-tab` and when git fixes whitespace
	+  is relevant for `indent-with-non-tab` and when git fixes `tab-in-indent`
	   errors. The default tab width is 8. Allowed values are 1 to 63.
	 
	 core.fsyncobjectfiles::
	diff --git a/ws.c b/ws.c
	index 0a2914c..e80e156 100644
	--- a/ws.c
	+++ b/ws.c
	@@ -60,6 +60,9 @@ unsigned parse_whitespace_rule(const char *string)
				unsigned tabwidth = atoi(string + 9);
				if (0 < tabwidth && tabwidth < 0100)
					rule &= ~WS_TAB_WIDTH_MASK, rule |= tabwidth;
	+			else
	+				warning("tabwidth %.*s out of range",
	+					len - 9, string + 9);
			}
			string = ep;
		}
	@@ -368,12 +371,13 @@ void ws_fix_copy(struct strbuf *dst, 
			fixed = 1;
		} else if ((ws_rule & WS_TAB_IN_INDENT) && last_tab_in_indent >= 0) {
			/* Expand tabs into spaces */
	+		int start = dst->len;
			int last = last_tab_in_indent + 1;
			for (i = 0; i < last; i++) {
				if (src[i] == '\t')
					do {
						strbuf_addch(dst, ' ');
	-				} while (dst->len % ws_tab_width(ws_rule));
	+				} while ((dst->len - start) % ws_tab_width(ws_rule));
				else
					strbuf_addch(dst, src[i]);
			}

 Documentation/config.txt        |    3 +
 Documentation/gitattributes.txt |    6 ++-
 cache.h                         |   17 +++++---
 t/t4015-diff-whitespace.sh      |   28 +++++++++++++
 t/t4019-diff-wserror.sh         |   85 +++++++++++++++++++++++++++++++++++++++
 t/t4124-apply-ws-rule.sh        |   23 ++++++++---
 ws.c                            |   20 ++++++---
 7 files changed, 161 insertions(+), 21 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6a6c0b5..7aff5ce 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -513,6 +513,9 @@ core.whitespace::
   part of the line terminator, i.e. with it, `trailing-space`
   does not trigger if the character before such a carriage-return
   is not a whitespace (not enabled by default).
+* `tabwidth=<n>` tells how many character positions a tab occupies; this
+  is relevant for `indent-with-non-tab` and when git fixes `tab-in-indent`
+  errors. The default tab width is 8. Allowed values are 1 to 63.
 
 core.fsyncobjectfiles::
 	This boolean will enable 'fsync()' when writing object files.
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index f7e4523..a79a06b 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -722,6 +722,8 @@ control per path.
 Set::
 
 	Notice all types of potential whitespace errors known to git.
+	The tab width is taken from the value of the `core.whitespace`
+	configuration variable.
 
 Unset::
 
@@ -729,13 +731,13 @@ Unset::
 
 Unspecified::
 
-	Use the value of `core.whitespace` configuration variable to
+	Use the value of the `core.whitespace` configuration variable to
 	decide what to notice as error.
 
 String::
 
 	Specify a comma separate list of common whitespace problems to
-	notice in the same format as `core.whitespace` configuration
+	notice in the same format as the `core.whitespace` configuration
 	variable.
 
 
diff --git a/cache.h b/cache.h
index 33decd9..8e8c9d4 100644
--- a/cache.h
+++ b/cache.h
@@ -1087,15 +1087,17 @@ void shift_tree_by(const unsigned char *, const unsigned char *, unsigned char *
 /*
  * whitespace rules.
  * used by both diff and apply
+ * last two digits are tab width
  */
-#define WS_BLANK_AT_EOL         01
-#define WS_SPACE_BEFORE_TAB	02
-#define WS_INDENT_WITH_NON_TAB	04
-#define WS_CR_AT_EOL           010
-#define WS_BLANK_AT_EOF        020
-#define WS_TAB_IN_INDENT       040
+#define WS_BLANK_AT_EOL         0100
+#define WS_SPACE_BEFORE_TAB     0200
+#define WS_INDENT_WITH_NON_TAB  0400
+#define WS_CR_AT_EOL           01000
+#define WS_BLANK_AT_EOF        02000
+#define WS_TAB_IN_INDENT       04000
 #define WS_TRAILING_SPACE      (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
-#define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB)
+#define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB|8)
+#define WS_TAB_WIDTH_MASK        077
 extern unsigned whitespace_rule_cfg;
 extern unsigned whitespace_rule(const char *);
 extern unsigned parse_whitespace_rule(const char *);
@@ -1104,6 +1106,7 @@ extern void ws_check_emit(const char *line, int len, unsigned ws_rule, FILE *str
 extern char *whitespace_error_string(unsigned ws);
 extern void ws_fix_copy(struct strbuf *, const char *, int, unsigned, int *);
 extern int ws_blank_line(const char *line, int len, unsigned ws_rule);
+#define ws_tab_width(rule)     ((rule) & WS_TAB_WIDTH_MASK)
 
 /* ls-files */
 int report_path_error(const char *ps_matched, const char **pathspec, int prefix_offset);
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 8622eb5..9059bcd 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -344,6 +344,13 @@ test_expect_success 'check spaces as indentation (indent-with-non-tab: on)' '
 
 '
 
+test_expect_success 'ditto, but tabwidth=9' '
+
+	git config core.whitespace "indent-with-non-tab,tabwidth=9" &&
+	git diff --check
+
+'
+
 test_expect_success 'check tabs and spaces as indentation (indent-with-non-tab: on)' '
 
 	git config core.whitespace "indent-with-non-tab" &&
@@ -352,6 +359,20 @@ test_expect_success 'check tabs and spaces as indentation (indent-with-non-tab:
 
 '
 
+test_expect_success 'ditto, but tabwidth=10' '
+
+	git config core.whitespace "indent-with-non-tab,tabwidth=10" &&
+	test_must_fail git diff --check
+
+'
+
+test_expect_success 'ditto, but tabwidth=20' '
+
+	git config core.whitespace "indent-with-non-tab,tabwidth=20" &&
+	git diff --check
+
+'
+
 test_expect_success 'check tabs as indentation (tab-in-indent: off)' '
 
 	git config core.whitespace "-tab-in-indent" &&
@@ -376,6 +397,13 @@ test_expect_success 'check tabs and spaces as indentation (tab-in-indent: on)' '
 
 '
 
+test_expect_success 'ditto, but tabwidth=1 (must be irrelevant)' '
+
+	git config core.whitespace "tab-in-indent,tabwidth=1" &&
+	test_must_fail git diff --check
+
+'
+
 test_expect_success 'check tab-in-indent and indent-with-non-tab conflict' '
 
 	git config core.whitespace "tab-in-indent,indent-with-non-tab" &&
diff --git a/t/t4019-diff-wserror.sh b/t/t4019-diff-wserror.sh
index f7c85ec..6f992c8 100755
--- a/t/t4019-diff-wserror.sh
+++ b/t/t4019-diff-wserror.sh
@@ -51,8 +51,65 @@ test_expect_success default '
 
 '
 
+test_expect_success 'default (attribute)' '
+
+	test_might_fail git config --unset core.whitespace &&
+	echo "F whitespace" >.gitattributes &&
+	prepare_output &&
+
+	grep Eight error >/dev/null &&
+	grep HT error >/dev/null &&
+	grep With error >/dev/null &&
+	grep Return error >/dev/null &&
+	grep No normal >/dev/null
+
+'
+
+test_expect_success 'default, tabwidth=10 (attribute)' '
+
+	git config core.whitespace "tabwidth=10" &&
+	echo "F whitespace" >.gitattributes &&
+	prepare_output &&
+
+	grep Eight normal >/dev/null &&
+	grep HT error >/dev/null &&
+	grep With error >/dev/null &&
+	grep Return error >/dev/null &&
+	grep No normal >/dev/null
+
+'
+
+test_expect_success 'no check (attribute)' '
+
+	test_might_fail git config --unset core.whitespace &&
+	echo "F -whitespace" >.gitattributes &&
+	prepare_output &&
+
+	grep Eight normal >/dev/null &&
+	grep HT normal >/dev/null &&
+	grep With normal >/dev/null &&
+	grep Return normal >/dev/null &&
+	grep No normal >/dev/null
+
+'
+
+test_expect_success 'no check, tabwidth=10 (attribute), must be irrelevant' '
+
+	git config core.whitespace "tabwidth=10" &&
+	echo "F -whitespace" >.gitattributes &&
+	prepare_output &&
+
+	grep Eight normal >/dev/null &&
+	grep HT normal >/dev/null &&
+	grep With normal >/dev/null &&
+	grep Return normal >/dev/null &&
+	grep No normal >/dev/null
+
+'
+
 test_expect_success 'without -trail' '
 
+	rm -f .gitattributes &&
 	git config core.whitespace -trail &&
 	prepare_output &&
 
@@ -134,6 +191,34 @@ test_expect_success 'with indent-non-tab only (attribute)' '
 
 '
 
+test_expect_success 'with indent-non-tab only, tabwidth=10' '
+
+	rm -f .gitattributes &&
+	git config core.whitespace indent,tabwidth=10,-trailing,-space &&
+	prepare_output &&
+
+	grep Eight normal >/dev/null &&
+	grep HT normal >/dev/null &&
+	grep With normal >/dev/null &&
+	grep Return normal >/dev/null &&
+	grep No normal >/dev/null
+
+'
+
+test_expect_success 'with indent-non-tab only, tabwidth=10 (attribute)' '
+
+	test_might_fail git config --unset core.whitespace &&
+	echo "F whitespace=indent,-trailing,-space,tabwidth=10" >.gitattributes &&
+	prepare_output &&
+
+	grep Eight normal >/dev/null &&
+	grep HT normal >/dev/null &&
+	grep With normal >/dev/null &&
+	grep Return normal >/dev/null &&
+	grep No normal >/dev/null
+
+'
+
 test_expect_success 'with cr-at-eol' '
 
 	rm -f .gitattributes &&
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 40e5842..6f6ee88 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -10,7 +10,8 @@ prepare_test_file () {
 	#       X  RULE
 	#   	!  trailing-space
 	#   	@  space-before-tab
-	#   	#  indent-with-non-tab
+	#   	#  indent-with-non-tab (default tab width 8)
+	#	=  indent-with-non-tab,tabwidth=16
 	#   	%  tab-in-indent
 	sed -e "s/_/ /g" -e "s/>/	/" <<-\EOF
 		An_SP in an ordinary line>and a HT.
@@ -25,8 +26,8 @@ prepare_test_file () {
 		________>_Eight SP, a HT and a SP (@#%).
 		_______________Fifteen SP (#).
 		_______________>Fifteen SP and a HT (@#%).
-		________________Sixteen SP (#).
-		________________>Sixteen SP and a HT (@#%).
+		________________Sixteen SP (#=).
+		________________>Sixteen SP and a HT (@#%=).
 		_____a__Five SP, a non WS, two SP.
 		A line with a (!) trailing SP_
 		A line with a (!) trailing HT>
@@ -139,8 +140,8 @@ test_expect_success 'spaces inserted by tab-in-indent' '
 		_________________Eight SP, a HT and a SP (@#%).
 		_______________Fifteen SP (#).
 		________________Fifteen SP and a HT (@#%).
-		________________Sixteen SP (#).
-		________________________Sixteen SP and a HT (@#%).
+		________________Sixteen SP (#=).
+		________________________Sixteen SP and a HT (@#%=).
 		_____a__Five SP, a non WS, two SP.
 		A line with a (!) trailing SP_
 		A line with a (!) trailing HT>
@@ -157,7 +158,7 @@ do
 		case "$s" in '') ts='@' ;; *) ts= ;; esac
 		for i in - ''
 		do
-			case "$i" in '') ti='#' ;; *) ti= ;; esac
+			case "$i" in '') ti='#' ti16='=';; *) ti= ti16= ;; esac
 			for h in - ''
 			do
 				[ -z "$h$i" ] && continue
@@ -170,12 +171,22 @@ do
 					test_fix "$tt$ts$ti$th"
 				'
 
+				test_expect_success "rule=$rule,tabwidth=16" '
+					git config core.whitespace "$rule,tabwidth=16" &&
+					test_fix "$tt$ts$ti16$th"
+				'
+
 				test_expect_success "rule=$rule (attributes)" '
 					git config --unset core.whitespace &&
 					echo "target whitespace=$rule" >.gitattributes &&
 					test_fix "$tt$ts$ti$th"
 				'
 
+				test_expect_success "rule=$rule,tabwidth=16 (attributes)" '
+					echo "target whitespace=$rule,tabwidth=16" >.gitattributes &&
+					test_fix "$tt$ts$ti16$th"
+				'
+
 			done
 		done
 	done
diff --git a/ws.c b/ws.c
index e350436..e80e156 100644
--- a/ws.c
+++ b/ws.c
@@ -56,6 +56,14 @@ unsigned parse_whitespace_rule(const char *string)
 				rule |= whitespace_rule_names[i].rule_bits;
 			break;
 		}
+		if (strncmp(string, "tabwidth=", 9) == 0) {
+			unsigned tabwidth = atoi(string + 9);
+			if (0 < tabwidth && tabwidth < 0100)
+				rule &= ~WS_TAB_WIDTH_MASK, rule |= tabwidth;
+			else
+				warning("tabwidth %.*s out of range",
+					len - 9, string + 9);
+		}
 		string = ep;
 	}
 
@@ -84,7 +92,7 @@ unsigned whitespace_rule(const char *pathname)
 		value = attr_whitespace_rule.value;
 		if (ATTR_TRUE(value)) {
 			/* true (whitespace) */
-			unsigned all_rule = 0;
+			unsigned all_rule = ws_tab_width(whitespace_rule_cfg);
 			int i;
 			for (i = 0; i < ARRAY_SIZE(whitespace_rule_names); i++)
 				if (!whitespace_rule_names[i].loosens_error &&
@@ -93,7 +101,7 @@ unsigned whitespace_rule(const char *pathname)
 			return all_rule;
 		} else if (ATTR_FALSE(value)) {
 			/* false (-whitespace) */
-			return 0;
+			return ws_tab_width(whitespace_rule_cfg);
 		} else if (ATTR_UNSET(value)) {
 			/* reset to default (!whitespace) */
 			return whitespace_rule_cfg;
@@ -206,7 +214,7 @@ static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
 	}
 
 	/* Check for indent using non-tab. */
-	if ((ws_rule & WS_INDENT_WITH_NON_TAB) && i - written >= 8) {
+	if ((ws_rule & WS_INDENT_WITH_NON_TAB) && i - written >= ws_tab_width(ws_rule)) {
 		result |= WS_INDENT_WITH_NON_TAB;
 		if (stream) {
 			fputs(ws, stream);
@@ -320,7 +328,7 @@ void ws_fix_copy(struct strbuf *dst, const char *src, int len, unsigned ws_rule,
 		} else if (ch == ' ') {
 			last_space_in_indent = i;
 			if ((ws_rule & WS_INDENT_WITH_NON_TAB) &&
-			    8 <= i - last_tab_in_indent)
+			    ws_tab_width(ws_rule) <= i - last_tab_in_indent)
 				need_fix_leading_space = 1;
 		} else
 			break;
@@ -350,7 +358,7 @@ void ws_fix_copy(struct strbuf *dst, const char *src, int len, unsigned ws_rule,
 				strbuf_addch(dst, ch);
 			} else {
 				consecutive_spaces++;
-				if (consecutive_spaces == 8) {
+				if (consecutive_spaces == ws_tab_width(ws_rule)) {
 					strbuf_addch(dst, '\t');
 					consecutive_spaces = 0;
 				}
@@ -369,7 +377,7 @@ void ws_fix_copy(struct strbuf *dst, const char *src, int len, unsigned ws_rule,
 			if (src[i] == '\t')
 				do {
 					strbuf_addch(dst, ' ');
-				} while ((dst->len - start) % 8);
+				} while ((dst->len - start) % ws_tab_width(ws_rule));
 			else
 				strbuf_addch(dst, src[i]);
 		}
-- 
1.7.3.67.gcc234
