From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] pickaxe: count regex matches only once
Date: Mon, 16 Mar 2009 19:38:42 +0100
Message-ID: <49BE9CB2.3090404@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 16 19:40:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjHjc-0001kV-DX
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 19:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754364AbZCPSiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 14:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753514AbZCPSiu
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 14:38:50 -0400
Received: from india601.server4you.de ([85.25.151.105]:43513 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087AbZCPSiu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 14:38:50 -0400
Received: from [10.0.1.101] (p57B7E56F.dip.t-dialin.net [87.183.229.111])
	by india601.server4you.de (Postfix) with ESMTPSA id 8C92E2F8050;
	Mon, 16 Mar 2009 19:38:47 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113351>

When --pickaxe-regex is used, forward past the end of matches instead of
advancing to the byte after their start.  This way matches count only
once, even if the regular expression matches their tail -- like in the
fixed-string fork of the code.

E.g.: /.*/ used to count the number of bytes instead of the number of
lines.  /aa/ resulted in a count of two in "aaa" instead of one.

Also document the fact that regexec() needs a NUL-terminated string as
its second argument by adding an assert().

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 diffcore-pickaxe.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 574b3e8..d0ef839 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -25,10 +25,12 @@ static unsigned int contains(struct diff_filespec *one,
 		regmatch_t regmatch;
 		int flags = 0;
 
+		assert(data[sz] == '\0');
 		while (*data && !regexec(regexp, data, 1, &regmatch, flags)) {
 			flags |= REG_NOTBOL;
-			data += regmatch.rm_so;
-			if (*data) data++;
+			data += regmatch.rm_eo;
+			if (*data && regmatch.rm_so == regmatch.rm_eo)
+				data++;
 			cnt++;
 		}
 
-- 
1.6.2.1
