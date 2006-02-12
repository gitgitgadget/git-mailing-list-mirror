From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Properly git-bisect reset after bisecting from non-master head
Date: Sun, 12 Feb 2006 11:33:26 -0800
Message-ID: <7vhd749xtl.fsf@assigned-by-dhcp.cox.net>
References: <20060212160614.GV31278@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 20:33:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8MyR-0002o6-BE
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 20:33:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWBLTd2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 14:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWBLTd2
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 14:33:28 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:46322 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750881AbWBLTd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2006 14:33:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060212193222.BPJK3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 12 Feb 2006 14:32:22 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060212160614.GV31278@pasky.or.cz> (Petr Baudis's message of
	"Sun, 12 Feb 2006 17:06:14 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16015>

Petr Baudis <pasky@suse.cz> writes:

> diff --git a/git-bisect.sh b/git-bisect.sh
> index 51e1e44..3c024aa 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -49,9 +49,16 @@ bisect_start() {
>  	die "Bad HEAD - I need a symbolic ref"
>  	case "$head" in
>  	refs/heads/bisect*)
> -		git checkout master || exit
> +		if [ -s "$GIT_DIR/head-name" ]; then
> +		    branch=`cat "$GIT_DIR/head-name"`
> +		else
> +		    branch=master
> +	        fi
> +		git checkout $branch || exit
>  		;;
>  	refs/heads/*)
> +		[ -s "$GIT_DIR/head-name" ] && die "won't bisect on seeked tree"
> +		echo "$head" | sed 's#^refs/heads/##' >"$GIT_DIR/head-name"
>  		;;

Hmph.  It seems that $GIT_DIR/head-name might want to be a
symbolic ref?

But other than that the patch looks sane, being able to go back
to the original branch, and preventing starting to bisect while
bisecting are useful and safe changes.  Thanks.
