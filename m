From: Junio C Hamano <junkio@cox.net>
Subject: Re: git pull fails to exit with non-zero status after fatal error
Date: Sat, 03 Mar 2007 12:56:06 -0800
Message-ID: <7vabyu9hcp.fsf@assigned-by-dhcp.cox.net>
References: <45E9A641.8020002@lightspeed.com>
	<Pine.LNX.4.63.0703031913100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Larry Streepy <larry@lightspeed.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 03 21:56:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNbHG-0004bo-Q1
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 21:56:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbXCCU4N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 15:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbXCCU4N
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 15:56:13 -0500
Received: from fed1rmmtai111.cox.net ([68.230.241.49]:40518 "EHLO
	fed1rmmtai111.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932348AbXCCU4N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 15:56:13 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070303205610.NKPR3546.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Mar 2007 15:56:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WLw61W00S1kojtg0000000; Sat, 03 Mar 2007 15:56:07 -0500
In-Reply-To: <Pine.LNX.4.63.0703031913100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 3 Mar 2007 19:13:41 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41326>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 3 Mar 2007, Larry Streepy wrote:
>
>> $ git pull
>> Updating b5d9263..506b347
>> tools/Pvt/Pvt.py: needs update
>> fatal: Entry 'tools/Pvt/Pvt.py' not uptodate. Cannot merge.
>> $ echo $?
>> 0
>> 
>> Notice the exit status of 0.
>
> Does this fix it?
>
> diff --git a/git-merge.sh b/git-merge.sh
> index 498c938..6b23bf5 100755
> --- a/git-merge.sh
> +++ b/git-merge.sh
> @@ -295,8 +295,9 @@ f,*)
>  	new_head=$(git-rev-parse --verify "$1^0") &&
>  	git-read-tree -v -m -u --exclude-per-directory=.gitignore $head "$new_head" &&
>  	finish "$new_head" "Fast forward"
> +	ret=$?
>  	dropsave
> -	exit 0
> +	exit $ret
>  	;;
>  ?,1,?*"$LF"?*,*)
>  	# We are not doing octopus and not fast forward.  Need a

The cation "dropsave" takes is to remove the files that are not
needed after a successful merge, so I think it is better to fail
if the && chain that ends with finish, like this.

diff --git a/git-merge.sh b/git-merge.sh
index 498c938..4afcd95 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -294,7 +294,7 @@ f,*)
 	git-update-index --refresh 2>/dev/null
 	new_head=$(git-rev-parse --verify "$1^0") &&
 	git-read-tree -v -m -u --exclude-per-directory=.gitignore $head "$new_head" &&
-	finish "$new_head" "Fast forward"
+	finish "$new_head" "Fast forward" || exit
 	dropsave
 	exit 0
 	;;
