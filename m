From: Pavel Roskin <proski@gnu.org>
Subject: Re: [COGITO PATCH] Optimized print_help()
Date: Wed, 15 Jun 2005 17:14:59 -0400
Message-ID: <1118870099.21882.16.camel@dv>
References: <1118791576.3890.4.camel@dv>  <20050615000001.GB17152@diku.dk>
	 <1118795583.3890.27.camel@dv>  <42B07A6F.3000001@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 15 23:10:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dif9U-0002pJ-2R
	for gcvg-git@gmane.org; Wed, 15 Jun 2005 23:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVFOVPU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Jun 2005 17:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbVFOVPU
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jun 2005 17:15:20 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:20968
	"EHLO dv.roinet.com") by vger.kernel.org with ESMTP id S261571AbVFOVPB
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2005 17:15:01 -0400
Received: from dv.roinet.com (localhost.localdomain [127.0.0.1])
	by dv.roinet.com (8.13.4/8.13.4) with ESMTP id j5FLExWO022128;
	Wed, 15 Jun 2005 17:14:59 -0400
Received: (from proski@localhost)
	by dv.roinet.com (8.13.4/8.13.4/Submit) id j5FLEx4p022125;
	Wed, 15 Jun 2005 17:14:59 -0400
X-Authentication-Warning: dv.roinet.com: proski set sender to proski@gnu.org using -f
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <42B07A6F.3000001@lsrfire.ath.cx>
X-Mailer: Evolution 2.2.2 (2.2.2-8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello, Rene!

On Wed, 2005-06-15 at 20:58 +0200, Rene Scharfe wrote:
> It doesn't matter if the shell opens the file or if sed does it itself,
> sed's ability to close the file and quit when done doesn't depend on
> that.

I checked sed 4.1.4 and found following:

1) sed won't close stdin ever, but it will close files specified on the
command line.

2) sed will exit when told to do so by a command such as "q", and it
won't read the reminder of the file, whether it's stdin or not.

3) sed has code that makes it exit after it has processed all address
ranges and the "-n" option is used.  However, this feature is buggy and
disabled by default (see EXPERIMENTAL_DASH_N_OPTIMIZATION). It may be
enabled in the future versions.

In other words, you are correct (except the part about closing the
file).

>   So this call is equivalent and has the advantage of being
> resistant against filenames starting with a "-":
> 
>    sed -n '3,/^$/s/^# *//p' <"$toolpath"

OK.  Here's the third version of the patch.

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
+	sed -n '/^USAGE=/,0s/.*"\(.*\)"/Usage: \1/p' <"$toolpath"
 	echo
-	cat $(which cg-$1) | sed -n '3,/^$/s/^# *//p'
+	sed -n '3,/^$/s/^# *//p' <"$toolpath"
 	exit
 }
 



-- 
Regards,
Pavel Roskin

