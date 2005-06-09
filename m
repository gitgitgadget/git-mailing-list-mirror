From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Fix cogito handling of timezones
Date: Thu, 9 Jun 2005 10:29:49 +0200
Message-ID: <20050609082949.GC29665@pasky.ji.cz>
References: <42A7BA17.5050707@tuxrocks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 09 12:28:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgIMs-0007AU-Hw
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 10:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbVFIIaK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 04:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbVFIIaJ
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 04:30:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:30700 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262336AbVFII3w (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 04:29:52 -0400
Received: (qmail 6733 invoked by uid 2001); 9 Jun 2005 08:29:49 -0000
To: Frank Sorenson <frank@tuxrocks.com>
Content-Disposition: inline
In-Reply-To: <42A7BA17.5050707@tuxrocks.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Jun 09, 2005 at 05:40:07AM CEST, I got a letter
where Frank Sorenson <frank@tuxrocks.com> told me that...
> Current cogito behavior treats the timezone offset as if it's decimal,
> but most zone offsets begin with a 0.  As a result, the computation
> in cg-Xlib uses the zone offset as an octal number.  -0700 looks like
> 4 1/2 hours offset, rather than 7, and -0800 is an invalid octal
> number.
> 
> This patch fixes the behavior to strip off leading 0s.  It's ugly,
> but it should produce the right values until someone with better
> bash scripting skills than I can fix it.
> 
> Signed-off-by: Frank Sorenson <frank@tuxrocks.com>
> 
> diff --git a/cg-Xlib b/cg-Xlib
> --- a/cg-Xlib
> +++ b/cg-Xlib
> @@ -51,8 +53,12 @@ showdate () {
>  	[ "$format" ] || format=-R
>  	sec=${date[0]}; tz=${date[1]}
>  	if [ "$has_gnudate" ]; then
> -	        dtz=${tz/+/}
> -		lsec=$(($dtz / 100 * 3600 + $dtz % 100 * 60 + $sec))
> +		sign=${tz%%[0-9]*}
> +		sign=${sign:?+}
> +		dtz=${tz/[+-]}
> +		dtz=${dtz##*(0)}
> +		dtz=${dtz:?0}
> +		lsec=$(($sec + $dtz % 100 $sign $dtz / 100 * 3600))

It looks ok, but shouldn't this be
+		lsec=$(($sec + $dtz % 100 * 60 $sign $dtz / 100 * 3600))

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
