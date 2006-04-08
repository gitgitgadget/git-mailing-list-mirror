From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: [PATCH] xdiff/xdiffi.c: fix warnings about possibly uninitialized variables
Date: Sat, 8 Apr 2006 17:27:20 +0200
Message-ID: <20060408152720.GA11125@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Sat Apr 08 17:27:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSFLY-0007lI-OB
	for gcvg-git@gmane.org; Sat, 08 Apr 2006 17:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbWDHP1Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Apr 2006 11:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbWDHP1Y
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Apr 2006 11:27:24 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:35714 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S964988AbWDHP1X
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 8 Apr 2006 11:27:23 -0400
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.54)
	id 1FSFLM-0002u0-3g; Sat, 08 Apr 2006 17:27:20 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18518>

Compiling this module gave the following warnings (some double dutch!):

xdiff/xdiffi.c: In functie 'xdl_recs_cmp':
xdiff/xdiffi.c:298: let op: 'spl.i1' may be used uninitialized in this function
xdiff/xdiffi.c:298: let op: 'spl.i2' may be used uninitialized in this function
xdiff/xdiffi.c:219: let op: 'fbest1' may be used uninitialized in this function
xdiff/xdiffi.c:219: let op: 'bbest1' may be used uninitialized in this function

A superficial tracking of their usage, without deeper knowledge about the
algorithm, indeed confirms that there are code paths on which these
variables will be used uninitialized. In practice these code paths might never
be reached, but then these fixes will not change the algorithm. If these
code paths are ever reached we now at least have a predictable outcome. And
should the very small performance impact of these initializations be
noticeable, then they should at least be replaced by comments why certain
code paths will never be reached.

Some extra initializations in this patch now fix the warnings.

---

 xdiff/xdiffi.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

0b0bf00d67a66b3ef47862cc51b1d37763f4b99b
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index e81bca6..641362d 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -218,7 +218,7 @@ static long xdl_split(unsigned long cons
 		if (ec >= xenv->mxcost) {
 			long fbest, fbest1, bbest, bbest1;
 
-			fbest = -1;
+			fbest = fbest1 = -1;
 			for (d = fmax; d >= fmin; d -= 2) {
 				i1 = XDL_MIN(kvdf[d], lim1);
 				i2 = i1 - d;
@@ -230,7 +230,7 @@ static long xdl_split(unsigned long cons
 				}
 			}
 
-			bbest = XDL_LINE_MAX;
+			bbest = bbest1 = XDL_LINE_MAX;
 			for (d = bmax; d >= bmin; d -= 2) {
 				i1 = XDL_MAX(off1, kvdb[d]);
 				i2 = i1 - d;
@@ -296,6 +296,7 @@ int xdl_recs_cmp(diffdata_t *dd1, long o
 	} else {
 		long ec;
 		xdpsplit_t spl;
+		spl.i1 = spl.i2 = 0;
 
 		/*
 		 * Divide ...
-- 
1.3.0.rc3.gad0b
