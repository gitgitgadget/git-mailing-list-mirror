From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] git-diff: complain about >=8 consecutive spaces in initial indent
Date: Fri, 02 Nov 2007 00:38:03 -0700
Message-ID: <7vr6j95c84.fsf@gitster.siamese.dyndns.org>
References: <7vwst15ceq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Downing <bdowning@lavos.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 08:38:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inr6n-0006nf-JY
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 08:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532AbXKBHiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 03:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752524AbXKBHiL
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 03:38:11 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:35041 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476AbXKBHiK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 03:38:10 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id B62BE2EF;
	Fri,  2 Nov 2007 03:38:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 19E0E9041B;
	Fri,  2 Nov 2007 03:38:28 -0400 (EDT)
In-Reply-To: <7vwst15ceq.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 02 Nov 2007 00:34:05 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63070>

This introduces a new whitespace error type, "indent-with-non-tab".
The error is about starting a line with 8 or more SP, instead of
indenting it with a HT.

This is not enabled by default, as some projects employ an
indenting policy to use only SPs and no HTs.

The kernel folks and git contributors may want to enable this
detection with:

	[core]
		whitespace = indent-with-non-tab

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Obviously, it is too late at night for me to do the same for
   git-apply, but it's Ok as I know there are capable interested
   parties on the list.  Hint, hint...

 cache.h  |    1 +
 config.c |    1 +
 diff.c   |   14 ++++++++++++--
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index a6e5988..3f42827 100644
--- a/cache.h
+++ b/cache.h
@@ -608,6 +608,7 @@ void shift_tree(const unsigned char *, const unsigned char *, unsigned char *, i
  */
 #define WS_TRAILING_SPACE	01
 #define WS_SPACE_BEFORE_TAB	02
+#define WS_INDENT_WITH_NON_TAB	04
 #define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB)
 extern unsigned whitespace_rule;
 
diff --git a/config.c b/config.c
index ffb418c..d5b9766 100644
--- a/config.c
+++ b/config.c
@@ -252,6 +252,7 @@ static struct whitespace_rule {
 } whitespace_rule_names[] = {
 	{ "trailing-space", WS_TRAILING_SPACE },
 	{ "space-before-tab", WS_SPACE_BEFORE_TAB },
+	{ "indent-with-non-tab", WS_INDENT_WITH_NON_TAB },
 };
 
 static unsigned parse_whitespace_rule(const char *string)
diff --git a/diff.c b/diff.c
index 2112353..6bb902f 100644
--- a/diff.c
+++ b/diff.c
@@ -502,8 +502,11 @@ static void emit_line_with_ws(int nparents,
 	int i;
 	int tail = len;
 	int need_highlight_leading_space = 0;
-	/* The line is a newly added line.  Does it have funny leading
-	 * whitespaces?  In indent, SP should never precede a TAB.
+	/*
+	 * The line is a newly added line.  Does it have funny leading
+	 * whitespaces?  In indent, SP should never precede a TAB.  In
+	 * addition, under "indent with non tab" rule, there should not
+	 * be more than 8 consecutive spaces.
 	 */
 	for (i = col0; i < len; i++) {
 		if (line[i] == '\t') {
@@ -517,6 +520,13 @@ static void emit_line_with_ws(int nparents,
 		else
 			break;
 	}
+	if ((whitespace_rule & WS_INDENT_WITH_NON_TAB) &&
+	    0 <= last_space_in_indent &&
+	    last_tab_in_indent < 0 &&
+	    8 <= (i - col0)) {
+		last_tab_in_indent = i;
+		need_highlight_leading_space = 1;
+	}
 	fputs(set, stdout);
 	fwrite(line, col0, 1, stdout);
 	fputs(reset, stdout);
-- 
1.5.3.5.1452.ga93d
