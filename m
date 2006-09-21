From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] add receive.denyNonFastforwards config variable
Date: Wed, 20 Sep 2006 23:26:05 -0700
Message-ID: <7vfyeld9c2.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0609210027430.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vfyemf9ah.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0609210107140.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vzmcudt3t.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0609210208350.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 08:26:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQI1R-0005Nb-A8
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 08:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWIUG0j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 02:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWIUG0i
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 02:26:38 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:10196 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750870AbWIUG0i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 02:26:38 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060921062637.XGKJ26416.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Sep 2006 02:26:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id QuSP1V0041kojtg0000000
	Thu, 21 Sep 2006 02:26:23 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0609210208350.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 21 Sep 2006 02:10:30 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27455>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
> index f3694ac..6be3c80 100755
> --- a/t/t5400-send-pack.sh
> +++ b/t/t5400-send-pack.sh
> @@ -64,4 +64,14 @@ test_expect_success \
>  	cmp victim/.git/refs/heads/master .git/refs/heads/master
>  '
>  
> +test_expect_success \
> +        'pushing with --force should be denied with denyNonFastforwards' '
> +	cd victim &&
> +	git-repo-config receive.denyNonFastforwards true &&
> +	cd .. &&
> +	git-update-ref refs/heads/master master^ &&
> +	git-send-pack --force ./victim/.git/ master &&
> +	! diff -u .git/refs/heads/master victim/.git/refs/heads/master
> +'
> +
>  test_done

The change shown by "git -SGIT_CONFIG -p t/Makefile" seems to
interfere with this test.  When I run it from shell by hand it
works OK, but when I run it like this:

	cd t && make T=t5400*.sh

it barfs.  s/git-send-pack/strace -f git-send-pack/ seems to
indicate that the receiving end is trying to open .git/config
(rightly, because you told it to do so three months ago ;-)
while its $cwd is victim/.git and fails to read the setting you
are trying to test.  Not good.

I think the change to t/Makefile from 9c3796fc needs to be
rethought.  Most of the tests would be fine with .git/config
(they never step outside t/trash/.git repository), but others
need tweaking, including unsetting it (while unsetting HOME at
the same time perhaps when you do not want to be affected).
Also it may make sense to do the default setting of GIT_CONFIG
in t/test-lib.sh, with a prominent warning why we explicitly
set it to a known value.

In the meantime, I got things working with this patch on top of
your test update.

---

diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 6be3c80..be47ee2 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -64,6 +64,10 @@ test_expect_success \
 	cmp victim/.git/refs/heads/master .git/refs/heads/master
 '
 
+unset GIT_CONFIG GIT_CONFIG_LOCAL
+HOME=`pwd`/no-such-directory
+export HOME ;# this way we force the victim/.git/config to be used.
+
 test_expect_success \
         'pushing with --force should be denied with denyNonFastforwards' '
 	cd victim &&
