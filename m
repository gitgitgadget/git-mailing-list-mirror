From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] grep: fix word-regexp colouring
Date: Wed, 20 May 2009 23:31:53 +0200
Message-ID: <4A1476C9.8060900@lsrfire.ath.cx>
References: <4A144E41.4010303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dmitry Gryazin <dosagc@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 20 23:32:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6tOS-0003zy-6s
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 23:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334AbZETVb7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 17:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752761AbZETVb6
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 17:31:58 -0400
Received: from india601.server4you.de ([85.25.151.105]:59009 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbZETVb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 17:31:58 -0400
Received: from [10.0.1.101] (p57B7BC6E.dip.t-dialin.net [87.183.188.110])
	by india601.server4you.de (Postfix) with ESMTPSA id A34AD2F8044;
	Wed, 20 May 2009 23:31:58 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <4A144E41.4010303@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119634>

As noticed by Dmitry Gryazin: When a pattern is found but it doesn't
start and end at word boundaries, bol is forwarded to after the match and
the pattern is searched again.  When a pattern is finally found between
word boundaries, the match offsets are off by the number of characters
that have been skipped.

This patch corrects the offsets to be relative to the value of bol as
passed to match_one_pattern() by its caller.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 grep.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/grep.c b/grep.c
index 04c777a..a649f06 100644
--- a/grep.c
+++ b/grep.c
@@ -305,6 +305,7 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
 {
 	int hit = 0;
 	int saved_ch = 0;
+	const char *start = bol;
 
 	if ((p->token != GREP_PATTERN) &&
 	    ((p->token == GREP_PATTERN_HEAD) != (ctx == GREP_CONTEXT_HEAD)))
@@ -365,6 +366,10 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
 	}
 	if (p->token == GREP_PATTERN_HEAD && saved_ch)
 		*eol = saved_ch;
+	if (hit) {
+		pmatch[0].rm_so += bol - start;
+		pmatch[0].rm_eo += bol - start;
+	}
 	return hit;
 }
 
-- 
1.6.3.1
