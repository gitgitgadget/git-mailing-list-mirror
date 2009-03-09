From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] grep: make show_line more portable
Date: Sun,  8 Mar 2009 21:15:26 -0400
Message-ID: <1236561326-1231-1-git-send-email-benji@silverinsanity.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 09 02:17:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgU71-0003SE-27
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 02:16:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684AbZCIBPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 21:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753659AbZCIBPa
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 21:15:30 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:60483 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753612AbZCIBP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 21:15:29 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 0D38E1FFC3FB; Mon,  9 Mar 2009 01:15:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-74-74-137-205.rochester.res.rr.com [74.74.137.205])
	by silverinsanity.com (Postfix) with ESMTPA id 073CC1FFC043;
	Mon,  9 Mar 2009 01:15:17 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.222.g01cbd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112661>

On OS X the printf specifier "%.0s" outputs the entire string instead
of 0 characters as POSIX states.

In addition, for * width or precision printf expects an integer
argument.  On systems were regoff_t is 64-bit, unexpected results can
occur.

To fix these, use if statements to catch 0 precisions and casts to
convert regoff_t to int.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---
 grep.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/grep.c b/grep.c
index cace1c8..ec68200 100644
--- a/grep.c
+++ b/grep.c
@@ -489,18 +489,22 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 
 		*eol = '\0';
 		while (next_match(opt, bol, eol, ctx, &match, eflags)) {
-			printf("%.*s%s%.*s%s",
-			       match.rm_so, bol,
-			       opt->color_match,
-			       match.rm_eo - match.rm_so, bol + match.rm_so,
-			       GIT_COLOR_RESET);
+			if( match.rm_so > 0 )
+				printf( "%.*s", (int) match.rm_so, bol );
+			if( match.rm_eo > match.rm_so )
+				printf("%s%.*s%s",
+					   opt->color_match,
+					  (int) (match.rm_eo - match.rm_so), bol + match.rm_so,
+					   GIT_COLOR_RESET);
 			bol += match.rm_eo;
 			rest -= match.rm_eo;
 			eflags = REG_NOTBOL;
 		}
 		*eol = ch;
 	}
-	printf("%.*s\n", rest, bol);
+	if( rest > 0 )
+		printf("%.*s", rest, bol);
+	printf("\n");
 }
 
 static int grep_buffer_1(struct grep_opt *opt, const char *name,
-- 
1.6.2.222.g01cbd
