From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] git-apply: second war on whitespace.
Date: Sat, 23 Sep 2006 00:47:49 -0700
Message-ID: <7vac4rvxay.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Sep 23 09:47:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GR2Es-0002rY-Kf
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 09:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWIWHrv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 03:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWIWHrv
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 03:47:51 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:18854 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751043AbWIWHru (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Sep 2006 03:47:50 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060923074750.ZYKP18985.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Sat, 23 Sep 2006 03:47:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Rjnr1V00e1kojtg0000000
	Sat, 23 Sep 2006 03:47:52 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27567>

This makes --whitespace={warn,error,strip} option to also notice
the leading whitespace errors in addition to the trailing
whitespace errors.  Spaces that are followed by a tab in indent
are detected as errors, and --whitespace=strip option fixes them.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-apply.c |  122 ++++++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 97 insertions(+), 25 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 25e90d8..de5f855 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -854,6 +854,49 @@ static int find_header(char *line, unsig
 	return -1;
 }
 
+static void check_whitespace(const char *line, int len)
+{
+	const char *err = "Adds trailing whitespace";
+	int seen_space = 0;
+	int i;
+
+	/*
+	 * We know len is at least two, since we have a '+' and we
+	 * checked that the last character was a '\n' before calling
+	 * this function.  That is, an addition of an empty line would
+	 * check the '+' here.  Sneaky...
+	 */
+	if (isspace(line[len-2]))
+		goto error;
+
+	/*
+	 * Make sure that there is no space followed by a tab in
+	 * indentation.
+	 */
+	err = "Space in indent is followed by a tab";
+	for (i = 1; i < len; i++) {
+		if (line[i] == '\t') {
+			if (seen_space)
+				goto error;
+		}
+		else if (line[i] == ' ')
+			seen_space = 1;
+		else
+			break;
+	}
+	return;
+
+ error:
+	whitespace_error++;
+	if (squelch_whitespace_errors &&
+	    squelch_whitespace_errors < whitespace_error)
+		;
+	else
+		fprintf(stderr, "%s.\n%s:%d:%.*s\n",
+			err, patch_input_file, linenr, len-2, line+1);
+}
+
+
 /*
  * Parse a unified diff. Note that this really needs to parse each
  * fragment separately, since the only way to know the difference
@@ -904,25 +947,8 @@ static int parse_fragment(char *line, un
 			trailing = 0;
 			break;
 		case '+':
-			/*
-			 * We know len is at least two, since we have a '+' and
-			 * we checked that the last character was a '\n' above.
-			 * That is, an addition of an empty line would check
-			 * the '+' here.  Sneaky...
-			 */
-			if ((new_whitespace != nowarn_whitespace) &&
-			    isspace(line[len-2])) {
-				whitespace_error++;
-				if (squelch_whitespace_errors &&
-				    squelch_whitespace_errors <
-				    whitespace_error)
-					;
-				else {
-					fprintf(stderr, "Adds trailing whitespace.\n%s:%d:%.*s\n",
-						patch_input_file,
-						linenr, len-2, line+1);
-				}
-			}
+			if (new_whitespace != nowarn_whitespace)
+				check_whitespace(line, len);
 			added++;
 			newlines--;
 			trailing = 0;
@@ -1494,22 +1520,68 @@ static int apply_line(char *output, cons
 {
 	/* plen is number of bytes to be copied from patch,
 	 * starting at patch+1 (patch[0] is '+').  Typically
-	 * patch[plen] is '\n'.
+	 * patch[plen] is '\n', unless this is the incomplete
+	 * last line.
 	 */
+	int i;
 	int add_nl_to_tail = 0;
-	if ((new_whitespace == strip_whitespace) &&
-	    1 < plen && isspace(patch[plen-1])) {
+	int fixed = 0;
+	int last_tab_in_indent = -1;
+	int last_space_in_indent = -1;
+	int need_fix_leading_space = 0;
+	char *buf;
+
+	if ((new_whitespace != strip_whitespace) || !whitespace_error) {
+		memcpy(output, patch + 1, plen);
+		return plen;
+	}
+
+	if (1 < plen && isspace(patch[plen-1])) {
 		if (patch[plen] == '\n')
 			add_nl_to_tail = 1;
 		plen--;
 		while (0 < plen && isspace(patch[plen]))
 			plen--;
-		applied_after_stripping++;
+		fixed = 1;
 	}
-	memcpy(output, patch + 1, plen);
+
+	for (i = 1; i < plen; i++) {
+		char ch = patch[i];
+		if (ch == '\t') {
+			last_tab_in_indent = i;
+			if (0 <= last_space_in_indent)
+				need_fix_leading_space = 1;
+		}
+		else if (ch == ' ')
+			last_space_in_indent = i;
+		else
+			break;
+	}
+
+	buf = output;
+	if (need_fix_leading_space) {
+		/* between patch[1..last_tab_in_indent] strip the
+		 * funny spaces, updating them to tab as needed.
+		 */
+		for (i = 1; i < last_tab_in_indent; i++, plen--) {
+			char ch = patch[i];
+			if (ch != ' ')
+				*output++ = ch;
+			else if ((i % 8) == 0)
+				*output++ = '\t';
+		}
+		fixed = 1;
+		i = last_tab_in_indent;
+	}
+	else
+		i = 1;
+
+	memcpy(output, patch + i, plen);
 	if (add_nl_to_tail)
 		output[plen++] = '\n';
-	return plen;
+	if (fixed)
+		applied_after_stripping++;
+	return output + plen - buf;
 }
 
 static int apply_one_fragment(struct buffer_desc *desc, struct fragment *frag, int inaccurate_eof)
-- 
1.4.2.1.gf2bba
