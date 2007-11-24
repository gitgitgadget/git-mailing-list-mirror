From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] builtin-apply: teach whitespace_rules
Date: Fri, 23 Nov 2007 20:25:56 -0800
Message-ID: <7v4pfcs20b.fsf@gitster.siamese.dyndns.org>
References: <7v8x4os223.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 05:26:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ivmaz-0007fY-O1
	for gcvg-git-2@gmane.org; Sat, 24 Nov 2007 05:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbXKXE0D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 23:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752128AbXKXE0D
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 23:26:03 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:41737 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbXKXE0B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 23:26:01 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 7C8532EF;
	Fri, 23 Nov 2007 23:26:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 4C991992BF;
	Fri, 23 Nov 2007 23:26:20 -0500 (EST)
In-Reply-To: <7v8x4os223.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 23 Nov 2007 20:24:52 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65937>

We earlier introduced core.whitespace to allow users to tweak the
definition of what the "whitespace errors" are, for the purpose of diff
output highlighting.  This teaches the same to git-apply, so that the
command can both detect (when --whitespace=warn option is given) and fix
(when --whitespace=fix option is given) as configured.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-apply.c          |   68 +++++++++++++++++-------
 t/t4124-apply-ws-rule.sh |  133 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 182 insertions(+), 19 deletions(-)
 create mode 100755 t/t4124-apply-ws-rule.sh

diff --git a/builtin-apply.c b/builtin-apply.c
index eb09bfe..e04b493 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -910,23 +910,35 @@ static void check_whitespace(const char *line, int len)
 	 * this function.  That is, an addition of an empty line would
 	 * check the '+' here.  Sneaky...
 	 */
-	if (isspace(line[len-2]))
+	if ((whitespace_rule & WS_TRAILING_SPACE) && isspace(line[len-2]))
 		goto error;
 
 	/*
 	 * Make sure that there is no space followed by a tab in
 	 * indentation.
 	 */
-	err = "Space in indent is followed by a tab";
-	for (i = 1; i < len; i++) {
-		if (line[i] == '\t') {
-			if (seen_space)
-				goto error;
-		}
-		else if (line[i] == ' ')
-			seen_space = 1;
-		else
-			break;
+	if (whitespace_rule & WS_SPACE_BEFORE_TAB) {
+		err = "Space in indent is followed by a tab";
+		for (i = 1; i < len; i++) {
+			if (line[i] == '\t') {
+				if (seen_space)
+					goto error;
+			}
+			else if (line[i] == ' ')
+				seen_space = 1;
+			else
+				break;
+		}
+	}
+
+	/*
+	 * Make sure that the indentation does not contain more than
+	 * 8 spaces.
+	 */
+	if ((whitespace_rule & WS_INDENT_WITH_NON_TAB) &&
+	    (8 < len) && !strncmp("+        ", line, 9)) {
+		err = "Indent more than 8 places with spaces";
+		goto error;
 	}
 	return;
 
@@ -1581,7 +1593,8 @@ static int apply_line(char *output, const char *patch, int plen)
 	/*
 	 * Strip trailing whitespace
 	 */
-	if (1 < plen && isspace(patch[plen-1])) {
+	if ((whitespace_rule & WS_TRAILING_SPACE) &&
+	    (1 < plen && isspace(patch[plen-1]))) {
 		if (patch[plen] == '\n')
 			add_nl_to_tail = 1;
 		plen--;
@@ -1597,11 +1610,16 @@ static int apply_line(char *output, const char *patch, int plen)
 		char ch = patch[i];
 		if (ch == '\t') {
 			last_tab_in_indent = i;
-			if (0 <= last_space_in_indent)
+			if ((whitespace_rule & WS_SPACE_BEFORE_TAB) &&
+			    0 <= last_space_in_indent)
+			    need_fix_leading_space = 1;
+		} else if (ch == ' ') {
+			last_space_in_indent = i;
+			if ((whitespace_rule & WS_INDENT_WITH_NON_TAB) &&
+			    last_tab_in_indent < 0 &&
+			    8 <= i)
 				need_fix_leading_space = 1;
 		}
-		else if (ch == ' ')
-			last_space_in_indent = i;
 		else
 			break;
 	}
@@ -1609,11 +1627,21 @@ static int apply_line(char *output, const char *patch, int plen)
 	buf = output;
 	if (need_fix_leading_space) {
 		int consecutive_spaces = 0;
+		int last = last_tab_in_indent + 1;
+
+		if (whitespace_rule & WS_INDENT_WITH_NON_TAB) {
+			/* have "last" point at one past the indent */
+			if (last_tab_in_indent < last_space_in_indent)
+				last = last_space_in_indent + 1;
+			else
+				last = last_tab_in_indent + 1;
+		}
+
 		/*
-		 * between patch[1..last_tab_in_indent] strip the
-		 * funny spaces, updating them to tab as needed.
+		 * between patch[1..last], strip the funny spaces,
+		 * updating them to tab as needed.
 		 */
-		for (i = 1; i < last_tab_in_indent; i++, plen--) {
+		for (i = 1; i < last; i++, plen--) {
 			char ch = patch[i];
 			if (ch != ' ') {
 				consecutive_spaces = 0;
@@ -1626,8 +1654,10 @@ static int apply_line(char *output, const char *patch, int plen)
 				}
 			}
 		}
+		while (0 < consecutive_spaces--)
+			*output++ = ' ';
 		fixed = 1;
-		i = last_tab_in_indent;
+		i = last;
 	}
 	else
 		i = 1;
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
new file mode 100755
index 0000000..f53ac46
--- /dev/null
+++ b/t/t4124-apply-ws-rule.sh
@@ -0,0 +1,133 @@
+#!/bin/sh
+
+test_description='core.whitespace rules and git-apply'
+
+. ./test-lib.sh
+
+prepare_test_file () {
+
+	# A line that has character X is touched iff RULE is in effect:
+	#       X  RULE
+	#   	!  trailing-space
+	#   	@  space-before-tab
+	#   	#  indent-with-non-tab
+	sed -e "s/_/ /g" -e "s/>/	/" <<-\EOF
+		An_SP in an ordinary line>and a HT.
+		>A HT.
+		_>A SP and a HT (@).
+		_>_A SP, a HT and a SP (@).
+		_______Seven SP.
+		________Eight SP (#).
+		_______>Seven SP and a HT (@).
+		________>Eight SP and a HT (@#).
+		_______>_Seven SP, a HT and a SP (@).
+		________>_Eight SP, a HT and a SP (@#).
+		_______________Fifteen SP (#).
+		_______________>Fifteen SP and a HT (@#).
+		________________Sixteen SP (#).
+		________________>Sixteen SP and a HT (@#).
+		_____a__Five SP, a non WS, two SP.
+		A line with a (!) trailing SP_
+		A line with a (!) trailing HT>
+	EOF
+}
+
+apply_patch () {
+	>target &&
+	sed -e "s|\([ab]\)/file|\1/target|" <patch |
+	git apply "$@"
+}
+
+test_fix () {
+
+	# fix should not barf
+	apply_patch --whitespace=fix || return 1
+
+	# find touched lines
+	diff file target | sed -n -e "s/^> //p" >fixed
+
+	# the changed lines are all expeced to change
+	fixed_cnt=$(wc -l <fixed)
+	case "$1" in
+	'') expect_cnt=$fixed_cnt ;;
+	?*) expect_cnt=$(grep "[$1]" <fixed | wc -l) ;;
+	esac
+	test $fixed_cnt -eq $expect_cnt || return 1
+
+	# and we are not missing anything
+	case "$1" in
+	'') expect_cnt=0 ;;
+	?*) expect_cnt=$(grep "[$1]" <file | wc -l) ;;
+	esac
+	test $fixed_cnt -eq $expect_cnt || return 1
+
+	# Get the patch actually applied
+	git diff-files -p target >fixed-patch
+	test -s fixed-patch && return 0
+
+	# Make sure it is complaint-free
+	>target
+	git apply --whitespace=error-all <fixed-patch
+
+}
+
+test_expect_success setup '
+
+	>file &&
+	git add file &&
+	prepare_test_file >file &&
+	git diff-files -p >patch &&
+	>target &&
+	git add target
+
+'
+
+test_expect_success 'whitespace=nowarn, default rule' '
+
+	apply_patch --whitespace=nowarn &&
+	diff file target
+
+'
+
+test_expect_success 'whitespace=warn, default rule' '
+
+	apply_patch --whitespace=warn &&
+	diff file target
+
+'
+
+test_expect_success 'whitespace=error-all, default rule' '
+
+	apply_patch --whitespace=error-all && return 1
+	test -s target && return 1
+	: happy
+
+'
+
+test_expect_success 'whitespace=error-all, no rule' '
+
+	git config core.whitespace -trailing,-space-before,-indent &&
+	apply_patch --whitespace=error-all &&
+	diff file target
+
+'
+
+for t in - ''
+do
+	case "$t" in '') tt='!' ;; *) tt= ;; esac
+	for s in - ''
+	do
+		case "$s" in '') ts='@' ;; *) ts= ;; esac
+		for i in - ''
+		do
+			case "$i" in '') ti='#' ;; *) ti= ;; esac
+			rule=${t}trailing,${s}space,${i}indent &&
+			test_expect_success "rule=$rule" '
+				git config core.whitespace "$rule" &&
+				test_fix "$tt$ts$ti"
+			'
+		done
+	done
+done
+
+test_done
-- 
1.5.3.6.1991.ge56ac
