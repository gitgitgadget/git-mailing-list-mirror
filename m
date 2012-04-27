From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC/PATCH] Reduce cost of deletion in levenstein distance (4 -> 3)
Date: Fri, 27 Apr 2012 10:58:02 +0200
Message-ID: <1335517082-29325-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 27 10:58:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNh0T-0006i2-N4
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 10:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758481Ab2D0I6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Apr 2012 04:58:20 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58173 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754832Ab2D0I6S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2012 04:58:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q3R8pgik015543
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 27 Apr 2012 10:51:42 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SNh0I-0005jH-0D; Fri, 27 Apr 2012 10:58:14 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SNh0H-0007dg-Q1; Fri, 27 Apr 2012 10:58:13 +0200
X-Mailer: git-send-email 1.7.10.363.g9094b
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 27 Apr 2012 10:51:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3R8pgik015543
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1336121504.71404@biNkRNczKLZmjeG/MkX1Wg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196457>

Before this patch, a character deletion has the same cost as 2 swaps, or
4 additions, so Git prefers suggesting a completely scrambled command
name to removing a character. For example, "git tags" suggests "stage",
but not "tag".

By setting the deletion cost to 3, we keep it higher than swaps or
additions, but prefer 1 deletion to 2 swaps. "git tags" now suggests
"tag" in addition to staged.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
The funny thing is: A while ago, I reported that the typo "git tags"
was not suggesting "git tag" as alternative "did you mean this?". A
patch was posted and merged:

  http://thread.gmane.org/gmane.comp.version-control.git/101278

According to the discussion, I it worked for me. But I can't reproduce
this "works for me" even going back to the version right after the fix
above.

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
1.7.10.363.g9094b
