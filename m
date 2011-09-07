From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [BUG] git bisect start fails when stale bisect data is left behind
Date: Wed, 7 Sep 2011 06:48:20 +0200
Message-ID: <201109070648.21211.chriscool@tuxfamily.org>
References: <CAC6WLetwT9UvBY_=Nf38hhkyU1mhmdWHWqscf3ebba1WRGS1LQ@mail.gmail.com> <CAP8UFD1h059dOyjszcP-qFauyho78c0RHBMQsGOPFgzZtp+7vg@mail.gmail.com> <7vehztaan4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	Joel Kaasinen <joel@zenrobotics.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 07 06:48:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1A3y-0001JZ-I1
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 06:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690Ab1IGEsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 00:48:33 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:48314 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752321Ab1IGEsc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 00:48:32 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B5EF2A61CB;
	Wed,  7 Sep 2011 06:48:22 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-10-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <7vehztaan4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180851>

On Tuesday 06 September 2011 18:38:55 Junio C Hamano wrote:
> Christian Couder <christian.couder@gmail.com> writes:
> >> How to reproduce:
> >> $ echo foo > .git/BISECT_START
> >> $ git bisect start HEAD HEAD^
> >> 
> >> Fails with "fatal: invalid reference:" on git 1.7.6.
> > 
> > Yeah, it looks like a very old behavior.
> > I'd suggest a simple improvement in the error message like this:
> > 
> > diff --git a/git-bisect.sh b/git-bisect.sh
> > index c21e33c..bd7155b 100755
> > --- a/git-bisect.sh
> > +++ b/git-bisect.sh
> > @@ -67,7 +67,8 @@ bisect_start() {
> > 
> >         then
> >         
> >                 # Reset to the rev from where we started.
> >                 start_head=$(cat "$GIT_DIR/BISECT_START")
> > 
> > -               git checkout "$start_head" -- || exit
> > +               git checkout "$start_head" -- ||
> > +               die "Could not checkout previous start point
> > '$start_head'. Try 'git bisect reset <branch>' first."
> 
> I do not necessarily think this is a bug to begin with --- the user had a
> bad state, and bisect stopped without doing further damage.

Yeah, in fact commit f3a186ffade15f793ea17713a10e10ec4f26ff11 (bisect: improve 
error message when branch checkout fails, Sat Apr 4, 2009) already improved 
the error message, but probably didn't go far enough.

> The real question is what the sensible suggestion/advice the new message
> should give. It would have to involve bisect reset in the end to get rid
> of the stale bisect state, but wouldn't the user potentially lose some
> other state if s/he blindly followed the die message's suggestion and ran
> "bisect reset"?

When using "git bisect start" with an existing $GIT_DIR/BISECT_START file, the 
next thing we do after checking out the previous head from the BISECT_START 
file is a call to "bisect_clean_state". So all the previous bisect state is 
discarded except the previous head that is in $start_head.

If checking out the previous head fails, that probably means that the previous 
head is bad because it has been deleted.

In this case running "git bisect reset <branch>" and then "git bisect start 
..." is ok because there is no valuable state lost compared to the situation 
where "git bisect start ..." succeeded in the first place.

Of course if checking out the previous head failed because the 
$GIT_DIR/BISECT_START file has been corrupted, then it might be better to fix 
the content of this file. But anyway if we are able to fix the content of the 
file, for example by putting "foobar" in it instead of the truncated "foo" that 
made the checkout fail, then running "git bisect reset foobar" and then "git 
bisect start ..." would probably do the trick too.

It wouldn't do the trick if the $GIT_DIR/BISECT_START file also needed a 
permission change or more free space on the disc or something like that. But 
in this case we will get an hopefully meaningful error message when running 
"git bisect reset foobar" or "git bisect start ..." and we would not lose 
information.

Thanks,
Christian.
