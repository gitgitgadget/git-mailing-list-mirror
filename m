From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/2] grep -w: forward to next possible position after rejected
 match
Date: Sat, 10 Jan 2009 00:08:40 +0100
Message-ID: <4967D8F8.9070508@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 10 00:10:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLQUZ-0000xM-BZ
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 00:10:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754281AbZAIXIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 18:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753809AbZAIXIu
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 18:08:50 -0500
Received: from india601.server4you.de ([85.25.151.105]:55250 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbZAIXIt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 18:08:49 -0500
Received: from [10.0.1.101] (p57B7F734.dip.t-dialin.net [87.183.247.52])
	by india601.server4you.de (Postfix) with ESMTPSA id 524252F8042;
	Sat, 10 Jan 2009 00:08:45 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105044>

grep -w accepts matches between non-word characters, only.  If a match
from regexec() doesn't meet this criteria, grep continues its search
after the first character of that match.

We can be a bit smarter here and skip all positions that follow a word
character first, as they can't match our criteria.  This way we can
consume characters quite cheaply and don't need to special-case the
handling of the beginning of a line.

Here's a contrived example command on msysgit (best of five runs):

	$ time git grep -w ...... v1.6.1 >/dev/null

	real    0m1.611s
	user    0m0.000s
	sys     0m0.015s

With the patch it's quite a bit faster:

	$ time git grep -w ...... v1.6.1 >/dev/null

	real    0m1.179s
	user    0m0.000s
	sys     0m0.015s

More common search patterns will gain a lot less, but it's a nice clean
up anyway.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 grep.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/grep.c b/grep.c
index 49e9319..394703b 100644
--- a/grep.c
+++ b/grep.c
@@ -294,7 +294,6 @@ static struct {
 static int match_one_pattern(struct grep_opt *opt, struct grep_pat *p, char *bol, char *eol, enum grep_context ctx)
 {
 	int hit = 0;
-	int at_true_bol = 1;
 	int saved_ch = 0;
 	regmatch_t pmatch[10];
 
@@ -337,7 +336,7 @@ static int match_one_pattern(struct grep_opt *opt, struct grep_pat *p, char *bol
 		 * either end of the line, or at word boundary
 		 * (i.e. the next char must not be a word char).
 		 */
-		if ( ((pmatch[0].rm_so == 0 && at_true_bol) ||
+		if ( ((pmatch[0].rm_so == 0) ||
 		      !word_char(bol[pmatch[0].rm_so-1])) &&
 		     ((pmatch[0].rm_eo == (eol-bol)) ||
 		      !word_char(bol[pmatch[0].rm_eo])) )
@@ -349,10 +348,14 @@ static int match_one_pattern(struct grep_opt *opt, struct grep_pat *p, char *bol
 			/* There could be more than one match on the
 			 * line, and the first match might not be
 			 * strict word match.  But later ones could be!
+			 * Forward to the next possible start, i.e. the
+			 * next position following a non-word char.
 			 */
 			bol = pmatch[0].rm_so + bol + 1;
-			at_true_bol = 0;
-			goto again;
+			while (word_char(bol[-1]) && bol < eol)
+				bol++;
+			if (bol < eol)
+				goto again;
 		}
 	}
 	if (p->token == GREP_PATTERN_HEAD && saved_ch)
-- 
1.6.1
