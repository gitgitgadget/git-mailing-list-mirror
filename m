From: Pavel Roskin <proski@gnu.org>
Subject: Re: [COGITO PATCH] Optimized print_help()
Date: Tue, 14 Jun 2005 20:33:03 -0400
Message-ID: <1118795583.3890.27.camel@dv>
References: <1118791576.3890.4.camel@dv>  <20050615000001.GB17152@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 15 02:28:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DiLlW-0001Fz-RL
	for gcvg-git@gmane.org; Wed, 15 Jun 2005 02:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVFOAdM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Jun 2005 20:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVFOAdM
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jun 2005 20:33:12 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:4328 "EHLO
	dv.roinet.com") by vger.kernel.org with ESMTP id S261442AbVFOAdG
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2005 20:33:06 -0400
Received: from dv.roinet.com (localhost.localdomain [127.0.0.1])
	by dv.roinet.com (8.13.4/8.13.4) with ESMTP id j5F0X4YI013340;
	Tue, 14 Jun 2005 20:33:04 -0400
Received: (from proski@localhost)
	by dv.roinet.com (8.13.4/8.13.4/Submit) id j5F0X3JK013337;
	Tue, 14 Jun 2005 20:33:03 -0400
X-Authentication-Warning: dv.roinet.com: proski set sender to proski@gnu.org using -f
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <20050615000001.GB17152@diku.dk>
X-Mailer: Evolution 2.2.2 (2.2.2-8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-06-15 at 02:00 +0200, Jonas Fonseca wrote:
> Shouldn't $toolpath be quoted here to make it safer? Although it seems
> the make install don't handle irregular toolpaths at the moment.

Sure.

> > +	cat $toolpath | sed -n '3,/^$/s/^# *//p'
> 
> What about also removing UUOC from this line ...

UUOC?  I had too look it up :-)

It's not just "useless use of cat", but also useless use of redirection
in both cases.  I guess sed can exit after it finishes processing the
range (I don't know if it actually does), so feeding it the whole file
is not need.

OK, here's an improved patch.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/cg-Xlib b/cg-Xlib
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -130,10 +130,11 @@ update_index () {
 
 
 print_help () {
-	which "cg-$1" >/dev/null 2>&1 || exit 1
-	sed -n '/^USAGE=/,0s/.*"\(.*\)"/Usage: \1/p' < $(which cg-$1) 
+	local toolpath=$(which cg-$1 2>/dev/null)
+	[ -z "$toolpath" ] && exit 1
+	sed -n '/^USAGE=/,0s/.*"\(.*\)"/Usage: \1/p' "$toolpath"
 	echo
-	cat $(which cg-$1) | sed -n '3,/^$/s/^# *//p'
+	sed -n '3,/^$/s/^# *//p' "$toolpath"
 	exit
 }
 

P.S. Maybe we could use "type" rather than "which" because the former is
a shell built-in.  Or maybe we should hardcode the prefix on install.
Anyway, it's out of scope of this patch.

P.P.S. I hope that $toolpath doesn't start with "-".  I could add "--"
to the sed command line, but I'm not sure if BSD sed would like it.

-- 
Regards,
Pavel Roskin

