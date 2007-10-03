From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-diff: complain about >=8 consecutive spaces in initial indent
Date: Tue, 02 Oct 2007 18:00:27 -0700
Message-ID: <7vfy0thv10.fsf_-_@gitster.siamese.dyndns.org>
References: <11899829424040-git-send-email-bfields@citi.umich.edu>
	<11899829424173-git-send-email-bfields@citi.umich.edu>
	<1189982942187-git-send-email-bfields@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@citi.umich.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 03 03:00:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcsbR-0008Ok-F8
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 03:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413AbXJCBAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 21:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752869AbXJCBAd
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 21:00:33 -0400
Received: from rune.pobox.com ([208.210.124.79]:60561 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752357AbXJCBAd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 21:00:33 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id D8A0B14091E;
	Tue,  2 Oct 2007 21:00:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 3FBCE140764;
	Tue,  2 Oct 2007 21:00:51 -0400 (EDT)
In-Reply-To: <1189982942187-git-send-email-bfields@citi.umich.edu> (J. Bruce
	Fields's message of "Sun, 16 Sep 2007 18:49:01 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59765>

This teaches coloring code in "diff" to detect indent of 8 or
more places using SP, which can and should (in some projects
including the kernel and git itself) use HT instead.

---

 * This is primarily meant as a "reminder" patch, and not for
   inclusion.  We earlier saw a patch to "git-apply" to rewrite
   them to HT but rejected it, because some projects use "no HT,
   all SP" policy (e.g. Python).

   We probably should resurrect the earlier "git-apply" patch,
   and teach it and this patch to selectively enable/disable
   detection of different kinds of whitespace breakages.

 diff.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 0ee9ea1..647377b 100644
--- a/diff.c
+++ b/diff.c
@@ -531,8 +531,10 @@ static void emit_line_with_ws(int nparents,
 	int i;
 	int tail = len;
 	int need_highlight_leading_space = 0;
-	/* The line is a newly added line.  Does it have funny leading
-	 * whitespaces?  In indent, SP should never precede a TAB.
+	/*
+	 * The line is a newly added line.  Does it have funny leading
+	 * whitespaces?  In indent, SP should never precede a TAB, and
+	 * there shouldn't be more than 8 consecutive spaces.
 	 */
 	for (i = col0; i < len; i++) {
 		if (line[i] == '\t') {
@@ -545,6 +547,11 @@ static void emit_line_with_ws(int nparents,
 		else
 			break;
 	}
+	if (0 <= last_space_in_indent && last_tab_in_indent < 0 &&
+	    8 <= (i - col0)) {
+		last_tab_in_indent = i;
+		need_highlight_leading_space = 1;
+	}
 	fputs(set, stdout);
 	fwrite(line, col0, 1, stdout);
 	fputs(reset, stdout);
