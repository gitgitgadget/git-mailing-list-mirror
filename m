From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] grep: fix empty word-regexp matches
Date: Wed, 03 Jun 2009 18:19:01 +0200
Message-ID: <4A26A275.7000900@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 18:19:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBtBJ-0005UM-NU
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 18:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755371AbZFCQTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 12:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755342AbZFCQTE
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 12:19:04 -0400
Received: from india601.server4you.de ([85.25.151.105]:34658 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754900AbZFCQTD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 12:19:03 -0400
Received: from [10.0.1.101] (p57B7CBE0.dip.t-dialin.net [87.183.203.224])
	by india601.server4you.de (Postfix) with ESMTPSA id 216D72F8042;
	Wed,  3 Jun 2009 18:19:04 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120618>

The command "git grep -w ''" dies as soon as it encounters an empty line,
reporting (wrongly) that "regexp returned nonsense".  The first hunk of
this patch relaxes the sanity check that is responsible for that,
allowing matches to start at the end.

The second hunk complements it by making sure that empty matches are
rejected if -w was specified, as they are not really words.

GNU grep does the same:

	$ echo foo | grep -c ''
	1
	$ echo foo | grep -c -w ''
	0

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 grep.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/grep.c b/grep.c
index 7bf4a60..92a47c7 100644
--- a/grep.c
+++ b/grep.c
@@ -331,7 +331,7 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
 
 	if (hit && p->word_regexp) {
 		if ((pmatch[0].rm_so < 0) ||
-		    (eol - bol) <= pmatch[0].rm_so ||
+		    (eol - bol) < pmatch[0].rm_so ||
 		    (pmatch[0].rm_eo < 0) ||
 		    (eol - bol) < pmatch[0].rm_eo)
 			die("regexp returned nonsense");
@@ -350,6 +350,10 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
 		else
 			hit = 0;
 
+		/* Words consist of at least one character. */
+		if (pmatch->rm_so == pmatch->rm_eo)
+			hit = 0;
+
 		if (!hit && pmatch[0].rm_so + bol + 1 < eol) {
 			/* There could be more than one match on the
 			 * line, and the first match might not be
-- 
1.6.3.1
