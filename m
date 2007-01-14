From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] Correct priority of lightweight tags in git-describe.
Date: Sun, 14 Jan 2007 18:17:49 -0500
Message-ID: <20070114231749.GE10888@spearce.org>
References: <2a044746b474f7c1840116762e79481b4669900e.1168767397.git.spearce@spearce.org> <20070114093744.GB15007@spearce.org> <7vodp1flrt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 19:58:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6Vhm-0006S3-Un
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:33:10 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V8P-0003eK-HB
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:56:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbXANXRz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 18:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbXANXRz
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 18:17:55 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56686 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbXANXRy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 18:17:54 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H6Ebe-0002C7-2S; Sun, 14 Jan 2007 18:17:42 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 07EB020FBAE; Sun, 14 Jan 2007 18:17:49 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vodp1flrt.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36853>

Junio C Hamano <junkio@cox.net> wrote:
> How about this on top?
> 
>  * We seem to do "a_" more often than "_a" for parameter names
>    we type-cast.

I copied the header from the compare_names routine in
builtin-describe.c.  Maybe apply this too?

-- >8 --
diff --git a/builtin-describe.c b/builtin-describe.c
index e38c899..e514bc3 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -104,10 +104,10 @@ static int get_name(const char *path, const unsigned char *sha1, int flag, void
 	return 0;
 }
 
-static int compare_names(const void *_a, const void *_b)
+static int compare_names(const void *a_, const void *b_)
 {
-	struct commit_name *a = *(struct commit_name **)_a;
-	struct commit_name *b = *(struct commit_name **)_b;
+	struct commit_name *a = *(struct commit_name **)a_;
+	struct commit_name *b = *(struct commit_name **)b_;
 	unsigned long a_date = a->commit->date;
 	unsigned long b_date = b->commit->date;
 	int cmp = hashcmp(a->commit->object.sha1, b->commit->object.sha1);
-- <8 --

>  * int would be enough for 'depth', not long.  Also, "return
>    (a->depth - b->depth)" is kosher only when it is signed,
>    although it works in practice on sane platforms.

I originally went with unsigned long as that matches the size
of a packfile, and I wasn't using depth in a signed way.  Until
that patch.  Good catch.

>  * I did not find mergesort(); if we want stable, explicitly do
>    so.  In practice, qsort() seems stable (as you know qsort()
>    does not have to be implemented as quicksort).

Must be a *BSD extension.  Oops.


Patch looked good.  Thanks.

-- 
Shawn.
