From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Reduce cost of deletion in levenstein distance (4 -> 3)
Date: Sun, 27 May 2012 18:02:58 +0200
Message-ID: <1338134578-29011-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun May 27 18:03:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYfwZ-000676-0G
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 18:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703Ab2E0QDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 12:03:08 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35941 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752305Ab2E0QDF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 12:03:05 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q4RFspOh009716
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 27 May 2012 17:54:51 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SYfvn-0001I9-VW; Sun, 27 May 2012 18:03:00 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SYfvn-0007Yc-R1; Sun, 27 May 2012 18:02:59 +0200
X-Mailer: git-send-email 1.7.10.363.g7fcd3d.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 27 May 2012 17:54:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4RFspOh009716
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1338738891.85569@67nOrxIMerw26lnNPv5P+g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198614>

Before this patch, a character deletion has the same cost as 2 swaps, or
4 additions, so Git prefers suggesting a completely scrambled command
name to removing a character. For example, "git tags" suggests "stage",
but not "tag".

By setting the deletion cost to 3, we keep it higher than swaps or
additions, but prefer 1 deletion to 2 swaps. "git tags" now suggests
"tag" in addition to staged.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
The RFC sent earlier [1] didn't receive negative comments, so I think this
is a good change.

http://thread.gmane.org/gmane.comp.version-control.git/196457

 help.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/help.c b/help.c
index 14eefc9..fdaa90d 100644
--- a/help.c
+++ b/help.c
@@ -334,7 +334,7 @@ const char *help_unknown_cmd(const char *cmd)
 		}
 
 		main_cmds.names[i]->len =
-			levenshtein(cmd, candidate, 0, 2, 1, 4) + 1;
+			levenshtein(cmd, candidate, 0, 2, 1, 3) + 1;
 	}
 
 	qsort(main_cmds.names, main_cmds.cnt,
-- 
1.7.10.363.g7fcd3d.dirty
