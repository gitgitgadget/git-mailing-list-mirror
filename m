From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/2] Avoid unnecessary strlen() calls
Date: Mon, 19 Mar 2007 23:40:20 -0400
Message-ID: <20070320034020.GB29145@spearce.org>
References: <Pine.LNX.4.64.0703171822280.4964@woody.linux-foundation.org> <alpine.LFD.0.83.0703172136440.18328@xanadu.home> <Pine.LNX.4.64.0703171854270.6730@woody.linux-foundation.org> <alpine.LFD.0.83.0703172200060.18328@xanadu.home> <Pine.LNX.4.64.0703171911120.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0703171949190.6730@woody.linux-foundation.org> <7v8xdunavr.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0703180848580.6730@woody.linux-foundation.org> <Pine.LNX.4.63.0703200400230.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070320032947.GA29145@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Nicolas Pitre <nico@cam.org>,
	Morten Welinder <mwelinder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 20 04:40:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTVDH-000303-6z
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 04:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933257AbXCTDkh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 23:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933175AbXCTDkh
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 23:40:37 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35178 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933147AbXCTDkg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 23:40:36 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HTVCk-0001Nn-9b; Mon, 19 Mar 2007 23:40:10 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CD89920FBAE; Mon, 19 Mar 2007 23:40:20 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070320032947.GA29145@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42699>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > -- snipsnap --
> > [PATCH] xdiff/xutils.c(xdl_hash_record): factor out whitespace handling
...
> > ---
> > 
> > 	Please do not consider this patch _unless_ it is proven to enhance 
> > 	the profile statistics substantially.
> 
> This is a massive difference for me.
...
> # stock v1.5.1-rc1
> $ for a in 1 2 3 4 5;do /usr/bin/time ../lt-blame blame --incremental HEAD git-gui.sh >/dev/null;done
>         6.27 real         5.31 user         0.55 sys
>         6.40 real         5.32 user         0.55 sys
>         6.33 real         5.33 user         0.53 sys
>         6.67 real         5.32 user         0.55 sys
>         6.18 real         5.31 user         0.53 sys
> 
> # with the above patch
> $ for a in 1 2 3 4 5;do /usr/bin/time ../js-blame blame --incremental HEAD git-gui.sh >/dev/null;done
>         3.57 real         2.87 user         0.51 sys
>         3.58 real         2.87 user         0.51 sys
>         3.53 real         2.86 user         0.52 sys
>         3.61 real         2.86 user         0.51 sys
>         3.64 real         2.87 user         0.52 sys

DrNick suggested on #git to try flipping the isspace test around.
This is a smaller change and generated the same ~3.60 seconds run
as Dscho's patch.  I like DrNick's version better.  ;-)

-->8--
[PATCH] xdiff/xutils.c(xdl_hash_record): factor out whitespace handling

Since in at least one use case, xdl_hash_record() takes over 15%
of the CPU time, it makes sense to even micro-optimize it. For
many cases, no whitespace special handling is needed, and in these
cases we should not even bother to check for whitespace in _every_
iteration of the loop.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 xdiff/xutils.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 3653864..7b1f213 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -241,7 +241,7 @@ unsigned long xdl_hash_record(char const **data, char const *top, long flags) {
 	char const *ptr = *data;
 
 	for (; ptr < top && *ptr != '\n'; ptr++) {
-		if (isspace(*ptr) && (flags & XDF_WHITESPACE_FLAGS)) {
+		if ((flags & XDF_WHITESPACE_FLAGS) && isspace(*ptr)) {
 			const char *ptr2 = ptr;
 			while (ptr + 1 < top && isspace(ptr[1])
 					&& ptr[1] != '\n')
-- 
1.5.1.rc1.595.gd1206

-- 
Shawn.
