From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Don't allow newlines to occur in $Id:$ collapse
Date: Fri, 25 May 2007 14:13:42 +0100
Message-ID: <200705251413.42389.andyparkins@gmail.com>
References: <200705251412.06196.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 25 15:13:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrZc7-0002vS-Mq
	for gcvg-git@gmane.org; Fri, 25 May 2007 15:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760619AbXEYNNr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 09:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760158AbXEYNNr
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 09:13:47 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:10609 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbXEYNNq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 09:13:46 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1116906ugf
        for <git@vger.kernel.org>; Fri, 25 May 2007 06:13:44 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=Gjqlr1TnTxWbROs6aS3b1v4eQs51v+ra1ub0Ei4zWN8ZT38xLxBHimR1oqeApXmT5qJN9/YPdpt0BVp8hvwvIhIWdNGiUuDJa9vqXRz3xRCpI0lhPgn3UCKguOkLHWs2/RKGMypRY0PCWRebWQcclZXonLmlo5+c3ZaB1Bo84S0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=s0SEWz+AMmFFUY5eARouxsWidBnQf77opKTnQKoPCOXS5fcgYryanM1E9Z2Xrc7+b4ZswQf2egSjlbMbgfoZyuUPOTtow2Q5KMz97AFy2m4HkGVcXjs1n2ZNqKvEZ1w7e8+31X5S2pvE4Ax/T51xA/++4LfLYS4W/fyT0pVg2do=
Received: by 10.66.221.19 with SMTP id t19mr2946339ugg.1180098824446;
        Fri, 25 May 2007 06:13:44 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b36sm418912ika.2007.05.25.06.13.43;
        Fri, 25 May 2007 06:13:43 -0700 (PDT)
In-Reply-To: <200705251412.06196.andyparkins@gmail.com>
X-TUID: 92c4fc417c93f23d
X-UID: 312
X-Length: 1480
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48370>

If a newline ever made it into an repository-side expanded $Id$ field,
the keyword would still be detected as a keyword and collapsed, before
rexpansion, e.g.

 $Id: all of this text would be removed, even if there
 were a newline in the middle of it$

This patch catches newlines in this case and abandons treating this as a
keyword expansion, this text would be left untouched in the working
checkout.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 convert.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/convert.c b/convert.c
index 3c44e3d..051366c 100644
--- a/convert.c
+++ b/convert.c
@@ -547,12 +547,14 @@ static char *ident_to_worktree(const char *path, const char *src, unsigned long
 				ch = *cp;
 				if (ch == '$')
 					break;
+				if (ch == '\n')
+					break;
 				cp++;
 				rem--;
 			} while (rem);
 			/* If the above finished because it ran out of characters, then
 			 * this is an incomplete keyword, so don't run the expansion */
-			if (!rem)
+			if (!rem || ch == '\n')
 				continue;
 		} else if (src[2] == '$')
 			cp = src + 2;
-- 
1.5.2.763.g8c5e-dirty
