From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH v2 09/21] bisect: make algorithm behavior independent of DEBUG_BISECT
Date: Sun, 10 Apr 2016 15:19:02 +0200
Message-ID: <1460294354-7031-10-git-send-email-s-beyer@gmx.net>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 15:21:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apFJ2-0000h0-F6
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 15:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692AbcDJNVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 09:21:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:60282 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753259AbcDJNUH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 09:20:07 -0400
Received: from fermat.fritz.box ([92.76.224.62]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MgpmG-1bB9t52GCu-00M4f4; Sun, 10 Apr 2016 15:20:03
 +0200
X-Mailer: git-send-email 2.8.1.137.g522756c
In-Reply-To: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:xkMzI3CyXb2ItgCxHAF13Y+Yn25+On5W+vOUkujkw5H17jf+Fvx
 J6ljvTWDrKxjr+wlmVXPt2ScpR5jEKIvFp/HGu6rwJY0FFgT+B02nzxol1Gp3jMJ/I+wkML
 HMN0gWg+f5om/IMDwtqVGPbnx/FxbYxhDkxx1iUbwhuIMzSzmEWDif3hgHJcr0mtjKp1Bm8
 P0no1+iBxDe1NftbDrxiw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QpCkQ1o5MzI=:NLtjGz4Bw6qaLRh5OV4WhY
 3gFgNRnsVQSoEEi/pADnj4lnMoztvA8e57DgQFzFvHzObnKYyydFlbIZEQwoLaHVHfOU9kylO
 BidAIVgap6JR35pADORlx3yO5OIs8zbT+kRDyFmmcG7G6AQ7IMpL6fBMd/Lqr4WS/XHunE+F1
 pVf4jaYs8LrX789VkiyHg6hSSaQgWqoerlXYkgxZFtXj2/Ahyryf5Ognh7fKqXuuet/nFIAYx
 MbdY0oXxbbxLGaQUrco+ufWBOWJgjfqSyL1rByN0K69v7uQX6GPTFTwtKPzdYdGO+X1f81eAH
 fDFBc5z+aqttP4gbmYkzawywy8Vjmb3+tumLMrsEoztap1hXPSktjfceoj2BH6gvxRtA3IhCb
 lgzZnLejRd0jnzhsV8RGHdmiAJbpt07ALHyurhkBaiaQF61XYaveCu0tkg6CkpKLQfT6UT/R1
 uPySgv+yLjxXYkLSMTXZrTDSXTcbKJTQVFuCw7acga9n63x2DSROFHDYVbyPjDDO0wRJs17OX
 l7HvJ/pIrR/OIV7QT4UQ3Q15oUTb7uXsAUm55J7ZpMtSf5oRPW3jcAgj7POY2DDpzgEr6TI1A
 TCvAPn2pTZkjhYKToDRXMbi++kdcPXRcL/VYjeXvubDcBYbEABNs7MpEzNSYVcePRroEGYTti
 1V7t/cbHM/ZMrek/cInH1HOb+TkHcDzwLGIrskN8kZMckPVOZzzQWGYwG7WwS2gDfIAENtq/3
 4dqc7Z0VTfK3fw/pn/hlkZZytVRr2bIMta4cKrEOBNP1t7QNc5PcbFZ30Fo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291165>

If DEBUG_BISECT is set to 1, bisect does not only show debug
information but also changes the algorithm behavior: halfway()
is always false.

This commit makes the algorithm independent of DEBUG_BISECT.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 bisect.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index 2f54d96..1a13f35 100644
--- a/bisect.c
+++ b/bisect.c
@@ -101,8 +101,6 @@ static inline int halfway(struct commit_list *p, int nr)
 	 */
 	if (p->item->object.flags & TREESAME)
 		return 0;
-	if (DEBUG_BISECT)
-		return 0;
 	/*
 	 * 2 and 3 are halfway of 5.
 	 * 3 is halfway of 6 but 2 and 4 are not.
-- 
2.8.1.137.g522756c
