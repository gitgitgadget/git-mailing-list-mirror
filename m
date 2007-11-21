From: Eric Wong <normalperson@yhbt.net>
Subject: Re: t9106 failure, bisect weirdness
Date: Wed, 21 Nov 2007 01:10:01 -0800
Message-ID: <20071121091001.GA23266@soma>
References: <20071119230601.GA15624@net-ronin.org> <200711200552.27001.chriscool@tuxfamily.org> <20071120061314.GA21819@net-ronin.org> <200711210508.27455.chriscool@tuxfamily.org> <20071121045638.GA9184@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: carbonated beverage <ramune@net-ronin.org>
X-From: git-owner@vger.kernel.org Wed Nov 21 10:10:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IulbE-0006YU-Mg
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 10:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222AbXKUJKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 04:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbXKUJKF
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 04:10:05 -0500
Received: from hand.yhbt.net ([66.150.188.102]:36401 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751198AbXKUJKD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 04:10:03 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id A24137DC0FE;
	Wed, 21 Nov 2007 01:10:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20071121045638.GA9184@net-ronin.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65620>

Hi, thanks for the heads up, Christian

carbonated beverage <ramune@net-ronin.org> wrote:
> > Ok thanks for doing that too.
> > Could you also look at the "file" when the test succeed and when it does not 
> > and send us both versions and a diff between them (if it's not too big).
> 
> Size-wise, they're tiny -- though there's a lot of lines.
> 
> The diff:
> 
> ramune/lycaeum:t: diff -u works.t fails.t 
> --- works.t     2007-11-20 21:54:29.000000000 -0700
> +++ fails.t     2007-11-20 21:54:39.000000000 -0700
> @@ -55,9 +55,9 @@
>  55
>  56
>  57
> -5588
> +58
>  59
>  60
> -6611
> +61
>  62
>  63

Ah, these changes should've been made on the svn side.  But I'm betting
a race condition appears on faster computers (which we've seen before in
other tests).

I can't reproduce it at all on any of my boxes, but does the following
one-liner fix it consistently?

Thanks,

From: Eric Wong <normalperson@yhbt.net>
Date: Wed, 21 Nov 2007 00:57:33 -0800
Subject: [PATCH] t9106: fix a race condition that caused svn to miss modifications

carbonated beverage noticed this test was occasionally failing.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 t/t9106-git-svn-dcommit-clobber-series.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/t9106-git-svn-dcommit-clobber-series.sh b/t/t9106-git-svn-dcommit-clobber-series.sh
index d59acc8..7452546 100755
--- a/t/t9106-git-svn-dcommit-clobber-series.sh
+++ b/t/t9106-git-svn-dcommit-clobber-series.sh
@@ -22,6 +22,7 @@ test_expect_success '(supposedly) non-conflicting change from SVN' "
 	cd tmp &&
 		perl -i -p -e 's/^58\$/5588/' file &&
 		perl -i -p -e 's/^61\$/6611/' file &&
+		poke file &&
 		test x\"\`sed -n -e 58p < file\`\" = x5588 &&
 		test x\"\`sed -n -e 61p < file\`\" = x6611 &&
 		svn commit -m '58 => 5588, 61 => 6611' &&
-- 
Eric Wong
