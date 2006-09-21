From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] add receive.denyNonFastforwards config variable
Date: Thu, 21 Sep 2006 02:17:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609210211570.19042@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0609210027430.19042@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfyemf9ah.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0609210107140.19042@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vlkoeds82.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 02:17:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQCFs-0005hd-Of
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 02:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWIUARZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 20:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWIUARZ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 20:17:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:48023 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750811AbWIUARY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 20:17:24 -0400
Received: (qmail invoked by alias); 21 Sep 2006 00:17:22 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 21 Sep 2006 02:17:22 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkoeds82.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27440>

Hi,

On Wed, 20 Sep 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > 	No longer barfs on new refs, and tries all merge bases (even if I
> > 	cannot come up with any scenario where there is more than one merge
> > 	base in the case of a fast forward).
> 
> Hmm.  If that is the case (and I think it is although I haven't
> come up with a proof),

>From git-fetch.sh:

            # Require fast-forward.
            mb=$(git-merge-base "$local" "$2") &&
            case "$2,$mb" in
            $local,*)
                if test -n "$verbose"
                then
                        echo >&2 "* $1: same as $3"
                fi
                ;;
            *,$local)
                echo >&2 "* $1: fast forward to $3"
                echo >&2 "  from $local to $2"
                git-update-ref -m "$rloga: fast-forward" "$1" "$2" "$local"
                ;;

So we indeed assumed that git-merge-base returns the old commit in the 
case of a fast-forward (git-merge-base returns just the first item of the 
result of get_merge_bases()).

Note that I have no proof that this assumption is true. It might be wrong 
in this case:

    X - a - b - c - Y
  /           /
o - d - e - f

where X is the old commit, and Y is the new commit. But I am too tired to 
test it right now.

>... the test can be written like this:
> 
> 	if (bases && !bases->next &&
>             hashcmp(old_sha1, bases->item->object.sha1))
>         	; /* happy */
> 	else
>         	return error("not a fast forward");

Plus

	free_commit_list(bases);

as Jeff pointed out.

Ciao,
Dscho
