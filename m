From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: Re: HEAD branch duplicated in remotes/origin
Date: Thu, 8 Jun 2006 14:33:38 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060608123337.GA12456@informatik.uni-freiburg.de>
References: <20060608073857.GA5072@informatik.uni-freiburg.de> <7vverc9i4i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 08 14:33:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoJhn-00025P-I3
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 14:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWFHMdk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 08:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWFHMdk
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 08:33:40 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:40899 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1751327AbWFHMdj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 08:33:39 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1FoJhi-0006f4-Ey; Thu, 08 Jun 2006 14:33:38 +0200
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.11.7p2+Sun/8.12.11) id k58CXcA13078;
	Thu, 8 Jun 2006 14:33:38 +0200 (MEST)
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vverc9i4i.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21485>

Hello Junio,

Junio C Hamano wrote:
> Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de> writes:
> 
> > when cloning with --use-separate-remote, $GITDIR/remotes/origin contains
> > two references to refs/heads/master.
> 
> Thanks for noticing.
> 
> Very lightly tested but I think this should fix it.
> -- >8 --
> git-clone: fix duplicated "master" in $GIT_DIR/remotes/origin
> 
> Under --use-separate-remote we ended up duplicating the branch
> remote HEAD pointed at in $GIT_DIR/remotes/origin file.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---
> diff --git a/git-clone.sh b/git-clone.sh
> index de59904..64318b4 100755
> --- a/git-clone.sh
> +++ b/git-clone.sh
> @@ -391,11 +391,16 @@ Pull: refs/heads/$head_points_at:$origin
>  		(cd "$GIT_DIR/$remote_top" && find . -type f -print) |
>  		while read dotslref
>  		do
> -			name=`expr "$dotslref" : './\(.*\)'` &&
> -			test "$use_separate_remote" = '' && {
> -				test "$head_points_at" = "$name" ||
> -				test "$origin" = "$name"
> -			} ||
> +			name=`expr "$dotslref" : './\(.*\)'`
> +			if test "z$head_points_at" = "z$name"
> +			then
> +				continue
> +			fi
> +			if test "$use_separate_remote" = '' &&
> +			   test "z$origin" = "z$name"
> +			then
> +				continue
> +			fi
>  			echo "Pull: refs/heads/${name}:$remote_top/${name}"
>  		done >>"$GIT_DIR/remotes/$origin" &&
>  		case "$use_separate_remote" in
> 
I wonder if this is easier not to add the other duplicate.  That is let
this as it is and don't add the head HEAD points at.  Don't know, didn't
look into it.

Moreover, is it sound to error if a Pull: line is duplicated?  In my
eyes at least the error message is wrong/missleading.  Otherwise the
patch works for me, but probably I only did the same testing as you.

Best regards
Uwe

-- 
Uwe Zeisberger

cal 9 1752 | grep 10
