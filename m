From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/7] Bisect: factorise "bisect_{bad,good,dunno}" into
 "bisect_state".
Date: Sun, 14 Oct 2007 17:15:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710141710230.25221@racer.site>
References: <20071014143003.23ae649f.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio Hamano <junkio@cox.net>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Oct 14 18:15:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih67k-0008Mr-EX
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 18:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756490AbXJNQPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 12:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756413AbXJNQPP
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 12:15:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:41215 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756480AbXJNQPO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 12:15:14 -0400
Received: (qmail invoked by alias); 14 Oct 2007 16:15:12 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp017) with SMTP; 14 Oct 2007 18:15:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+lPBEdr42l1ApaiVXqN/k9bIKjHhXG/7muxxIYYF
	/pF08oQ/FkD5ez
X-X-Sender: gene099@racer.site
In-Reply-To: <20071014143003.23ae649f.chriscool@tuxfamily.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60860>

Hi,

On Sun, 14 Oct 2007, Christian Couder wrote:

> -bisect_bad() {
> +bisect_state() {
>  	bisect_autostart
> -	case "$#" in
> -	0)
> -		rev=$(git rev-parse --verify HEAD) ;;
> -	1)
> -		rev=$(git rev-parse --verify "$1^{commit}") ;;
> +	state=$1
> +	case "$#,$state" in
> +	0,*)
> +		die "Please call 'bisect_state' with at least one argument." ;;
> +	1,bad|1,good|1,dunno)
> +		rev=$(git rev-parse --verify HEAD) ||
> +			die "Bad rev input: HEAD"
> +		bisect_write "$state" "$rev" ;;
> +	2,bad)
> +		rev=$(git rev-parse --verify "$2^{commit}") ||
> +			die "Bad rev input: $2"
> +		bisect_write "$state" "$rev" ;;

Really?  As far as I see, "2,bad" is an error in the current bisect.

> @@ -404,17 +390,15 @@ bisect_run () {
>  	  exit $res
>        fi
>  
> -      # Use "bisect_good" or "bisect_bad"
> -      # depending on run success or failure.
> +      # Find current state depending on run success or failure.
>        if [ $res -gt 0 ]; then
> -	  next_bisect='bisect_bad'
> +	  state='bad'
>        else
> -	  next_bisect='bisect_good'
> +	  state='good'
>        fi

Maybe it is time to have a special exit status for "dunno"?  But this is 
not something to fix in your patch, just an idea for a future patch.

Ciao,
Dscho
