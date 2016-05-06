From: Stefan Dotterweich <stefandotterweich@gmx.de>
Subject: [PATCH] gitk: Fix missing commits when using -S or -G
Date: Fri, 6 May 2016 13:56:21 +0200
Message-ID: <572C8665.8090707@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 13:45:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayeC5-0006OO-T0
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 13:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbcEFLpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 07:45:10 -0400
Received: from mout.gmx.net ([212.227.15.19]:60911 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756625AbcEFLoy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 07:44:54 -0400
Received: from [192.168.1.68] ([2.242.37.191]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M0QAP-1bmMUp3iHN-00ubTO; Fri, 06 May 2016 13:44:50
 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
X-Provags-ID: V03:K0:4BVRiCXrCSFRVeEhOTWVF55A8lPz1tYaIaCtmqdMVM+I2eCZi5R
 q0Jhv2qgwLo/srhq4M9/Nsri5m7BzjX0BjZG9XPMDBJNV6VGwcEGtkPXgbSfVeUbGsgf8J2
 zR1CFR9wF4Z71yoxbWtBlL348FblrkUHGzT/Mg4PIUPQ0Nb7GP/I942hBAOzyo76UdtHZrX
 zRa485Kvz8gZK83T82rzg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pKH6ZnnVuSk=:mp0Q49WqsBJUATuJZww1Ux
 Z0Ssfz4eDs5eX8PbA7fmqEvPPCEOp+qn0CHbndkiV7sEGfGnutnEajzWkrARnqMUerY6uYjCT
 +EQgfYopg82S90rVXAn6xLGitRxp3iCUV2x9U0SGLmmFf7Hg15aC2mqHpEBbf+r8qjgLon2WT
 M4q4+sWHjmfOUGxCxCyR94yGHtZuId3tjNbOUrZZr0rzDwtTAb4b+ZFdTrfw5gdDjOtY1VLeI
 rkKcIDXYIoIeOkj8cEsOoyI2jnIIcAn4VcnB8DvanUoSDsYIrYHekxBzaVF1Lcnq9/vKycIgf
 MajPT8SYStcXHmpjNFk9Qc6DaO49ZMDskfCNJcWfba9ha+RaOQ7CFyA+yzaTM+rh3CMtkG0LX
 32OhkUbUytcC+bw7AcgY42G4TVZ0tLrvcn36v8JhJf5LkO7BbEHBCBbUybPCpzSAQrcktmSsa
 OJvEo6BnolnrrBTyw/jcz0RXwKfbKeyNIBCtdFCgod9T4kwaBXdZFDlCM1XFy8Q0T51OpfuU1
 sb81sl5t0+5WqtV7cdAgZKRpQS3nyfnqLh7Bryj/xKdi+uYbNS1V3bWtKn/uQfDLmcJx0lcrC
 HlQWo9S567qH/e0AiAIEURG9GHPMIthys611qta97k3dIypgXQRlQsgK0IQncWqgf7T+twoqQ
 VgUFgO42BeIgEAopZ44zG/p9k3Ct90y8JfhdNGEtqYCVOZAhx4K2a+HBEsQa/9ht7hCQJnlQ3
 dQ+LjZfGCR6Q9lPLJdqYN0m7dEag151MDDcR1b8L7jnz8plr+VMGOwnPv/7MY8Xx75ki4auk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293760>

When -S or -G is used as a filter option, the resulting commit list
rarely contains all matching commits. Only a certain number of commits
are displayed and the rest are missing.

"git log --boundary -S" does not return as many boundary commits as you
might expect. gitk makes up for this in closevargs() by adding missing
parent (boundary) commits. However, it does not change $numcommits,
which limits how many commits are shown. In the end, some commits at the
end of the commit list are simply not shown.

Change $numcommits whenever a missing parent is added.

Signed-off-by: Stefan Dotterweich <stefandotterweich@gmx.de>
---
 gitk | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 805a1c7..b0da174 100755
--- a/gitk
+++ b/gitk
@@ -1315,7 +1315,7 @@ proc commitonrow {row} {
  proc closevarcs {v} {
     global varctok varccommits varcid parents children
-    global cmitlisted commitidx vtokmod
+    global cmitlisted commitidx vtokmod numcommits
      set missing_parents 0
     set scripts {}
@@ -1339,7 +1339,7 @@ proc closevarcs {v} {
 		modify_arc $v $b
 	    }
 	    lappend varccommits($v,$b) $p
-	    incr commitidx($v)
+	    set numcommits [incr commitidx($v)]
 	    set scripts [check_interest $p $scripts]
 	}
     }
-- 
2.7.4
