From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] grep: fix colouring of matches with zero length
Date: Mon, 01 Jun 2009 18:46:18 +0200
Message-ID: <4A2405DA.7010801@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 18:47:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBAfP-000758-TO
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 18:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754995AbZFAQqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 12:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756337AbZFAQqd
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 12:46:33 -0400
Received: from india601.server4you.de ([85.25.151.105]:50562 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757893AbZFAQqc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 12:46:32 -0400
Received: from [10.0.1.101] (p57B7E377.dip.t-dialin.net [87.183.227.119])
	by india601.server4you.de (Postfix) with ESMTPSA id 2D8902F8042;
	Mon,  1 Jun 2009 18:46:33 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120478>

The first hunk fixes match colouring if the patterns is the empty string.
Such a pattern matches the whole line, but fixmatch() sets the end offset
to the same value as the start offset.  Special case the empty pattern in
match_one_pattern() and thus avoid calling fixmatch().

The second hunk of the patch makes sure that grep match colouring doesn't
get stuck in an infinite loop if the length of a match is zero.  The rest
of the line is simply printed without colouring.  Even though the empty
pattern string doesn't result in empty matches any more, this defensive
measure catches unknown cases.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 grep.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/grep.c b/grep.c
index cc6d5b0..745b3c0 100644
--- a/grep.c
+++ b/grep.c
@@ -324,7 +324,11 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
 	}
 
  again:
-	if (p->fixed)
+	if (p->pattern[0] == '\0') {
+		hit = 1;
+		pmatch[0].rm_so = 0;
+		pmatch[0].rm_eo = eol - bol;
+	} else if (p->fixed)
 		hit = !fixmatch(p->pattern, bol, pmatch);
 	else
 		hit = !regexec(&p->regexp, bol, 1, pmatch, eflags);
@@ -500,6 +504,8 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 
 		*eol = '\0';
 		while (next_match(opt, bol, eol, ctx, &match, eflags)) {
+			if (match.rm_so == match.rm_eo)
+				break;
 			printf("%.*s%s%.*s%s",
 			       (int)match.rm_so, bol,
 			       opt->color_match,
-- 
1.6.3.1
