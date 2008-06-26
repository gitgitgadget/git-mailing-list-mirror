From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [NON-TOY PATCH] git bisect: introduce 'fixed' and 'unfixed'
Date: Thu, 26 Jun 2008 08:03:20 +0200
Message-ID: <200806260803.20731.chriscool@tuxfamily.org>
References: <alpine.DEB.1.00.0806241515460.9925@racer> <alpine.DEB.1.00.0806242137120.9925@racer> <7v8wwubh3j.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 08:00:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBkWt-00077f-AQ
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 08:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754788AbYFZF70 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Jun 2008 01:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754712AbYFZF7Z
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 01:59:25 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:37863 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752575AbYFZF7U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jun 2008 01:59:20 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id E22561AB2E0;
	Thu, 26 Jun 2008 07:59:17 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 825D91AB2BA;
	Thu, 26 Jun 2008 07:59:17 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7v8wwubh3j.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86400>

Le mercredi 25 juin 2008, Junio C Hamano a =E9crit :
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > On Tue, 24 Jun 2008, Michael Haggerty wrote:
> > ...
> >
> >> It seems to me that your problem is that git-bisect requires the
> >> "good" revision to be older than the "bad" one. =20

Yes, "git bisect" works if the good revisions are ancestors of the bad=20
revision.

Currently if you mistake good and bad revs (and if one of the rev is
an ancestor of the other) you get something like:

$ git bisect start HEAD~3 HEAD
'git rev-list --bisect-vars' failed:
maybe you mistake good and bad revs?

I also noticed that if the good and bad are siblings for example like:

A-B-C-D
   \E-F

and you say:

$ git bisect start D F

(that means D is bad and F is good)

then it will kind of "work" but only C and D will be considered as poss=
ible=20
first bad commits. This is arguably a bug because for example E could h=
ave=20
fixed a bug that always existed, and then the first bad commit is B or =
A=20
depending how we define it.

> >> If this requirement=20
> >> were removed, would there still be a need for "fixed" vs. "unfixed=
"?

Well this requirement can be "removed" in different ways.

1) We could just allow anything to be called "bad" and "good" as long a=
s=20
there is either:

- only one bad revision and all good revisions are its ancestor, or
- only one good revision and all bad revisions are its ancestor

2) Another way to remove the requirement is to make it work in the sibl=
ings=20
case above.

> > Nope.
> >
> > The thing that makes "fixed" and "bad" special is that _one_ commit
> > introduced that.
>
> That was my initial reaction, and I actually was about to phrase it m=
ore
> bluntly: you do not understand what "bisect" is.
>
> But that was a reaction without thinking things through.  It may not =
be
> what "git bisect" currently is, but the suggestion does not go agains=
t
> what the underlying "git rev-list --bisect" is at all.

If we want to make the siblings case (case 2) work, then "git=20
rev-list --bisect" needs work though.

> I think what=20
> Michael is speculating is different, and it makes sense in its own wa=
y.
>
> Instead of having a set of bisect/good-* refs and a single bisect-bad
> ref, your "fixed and unfixed" mode could work quite differently.  By
> noticing that the topology the user specified with initial good and b=
ad
> have ancient bad and recent good --- that is, "it used to be bad but =
now
> it is good" --- you could instead use a set of bisect/bad-* refs and =
a
> single bisect-good ref, and feed good and bad swapped to "rev-list
> --bisect" in bisect_next().  That way, the labels given by visualize =
will
> match what the user is doing automatically.

Yes, that is the case 1 above.

> I said "it makes sense in its own way", because it is _quite_ differe=
nt
> from how git-bisect currently assumes, and restructuring git-bisect t=
o
> operate naturally in a way Michael describes would be a much larger
> surgery with costs (including risks of bugs) associated with it, whic=
h
> needs to be weighed in when judging that approach would actually make
> sense.

Yes it needs work in git-bisect.sh and I don't think the current situat=
ion=20
with the "maybe you mistake good and bad revs?" error message is too ba=
d.

Regards,
Christian.
