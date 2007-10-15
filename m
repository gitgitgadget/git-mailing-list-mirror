From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 6/7] Bisect: factorise "bisect_{bad,good,dunno}" into "bisect_state".
Date: Mon, 15 Oct 2007 05:42:17 +0200
Message-ID: <200710150542.17667.chriscool@tuxfamily.org>
References: <20071014143003.23ae649f.chriscool@tuxfamily.org> <Pine.LNX.4.64.0710141710230.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 15 05:35:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhGjm-0003YH-KO
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 05:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756152AbXJODfQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2007 23:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756216AbXJODfP
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 23:35:15 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:35005 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756102AbXJODfO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2007 23:35:14 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 4E5B21AB2AD;
	Mon, 15 Oct 2007 05:35:13 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 3581E1AB2AA;
	Mon, 15 Oct 2007 05:35:13 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <Pine.LNX.4.64.0710141710230.25221@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60937>

Le dimanche 14 octobre 2007, Johannes Schindelin a =E9crit :
> Hi,
>
> On Sun, 14 Oct 2007, Christian Couder wrote:
> > -bisect_bad() {
> > +bisect_state() {
> >  	bisect_autostart
> > -	case "$#" in
> > -	0)
> > -		rev=3D$(git rev-parse --verify HEAD) ;;
> > -	1)
> > -		rev=3D$(git rev-parse --verify "$1^{commit}") ;;
> > +	state=3D$1
> > +	case "$#,$state" in
> > +	0,*)
> > +		die "Please call 'bisect_state' with at least one argument." ;;
> > +	1,bad|1,good|1,dunno)
> > +		rev=3D$(git rev-parse --verify HEAD) ||
> > +			die "Bad rev input: HEAD"
> > +		bisect_write "$state" "$rev" ;;
> > +	2,bad)
> > +		rev=3D$(git rev-parse --verify "$2^{commit}") ||
> > +			die "Bad rev input: $2"
> > +		bisect_write "$state" "$rev" ;;
>
> Really?  As far as I see, "2,bad" is an error in the current bisect.

But the new "bisect_state" takes one more argument, because the first o=
ne=20
must be "good" "bad" or "dunno".

So when there is only one argument HEAD is used, and when there are 2=20
arguments, $2 is used as the good|bad|dunno rev.=20

> > @@ -404,17 +390,15 @@ bisect_run () {
> >  	  exit $res
> >        fi
> >
> > -      # Use "bisect_good" or "bisect_bad"
> > -      # depending on run success or failure.
> > +      # Find current state depending on run success or failure.
> >        if [ $res -gt 0 ]; then
> > -	  next_bisect=3D'bisect_bad'
> > +	  state=3D'bad'
> >        else
> > -	  next_bisect=3D'bisect_good'
> > +	  state=3D'good'
> >        fi
>
> Maybe it is time to have a special exit status for "dunno"?  But this=
 is
> not something to fix in your patch, just an idea for a future patch.

Yes, I will think about it.

Thanks,
Christian.
