From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] bisect: use "$GIT_DIR/BISECT_START" to check if we are bisecting
Date: Thu, 29 May 2008 06:01:18 +0200
Message-ID: <200805290601.19067.chriscool@tuxfamily.org>
References: <20080528185702.4dcd2955.chriscool@tuxfamily.org> <7vmymauzqg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 29 05:58:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1ZHG-0003kP-Fc
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 05:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211AbYE2D4x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 May 2008 23:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752784AbYE2D4x
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 23:56:53 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:47599 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752049AbYE2D4w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 May 2008 23:56:52 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 13EC51AB2BB;
	Thu, 29 May 2008 05:56:51 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id E579E1AB2BA;
	Thu, 29 May 2008 05:56:50 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vmymauzqg.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83169>

Le mercredi 28 mai 2008, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > It seems simpler and safer to use the BISECT_START file everywhere
> > to decide if we are bisecting or not, instead of using it in some
> > places and BISECT_NAMES in other places.
> >
> > In commit 6459c7c6786aa9bda0c7a095c9db66c36da0e5f0 (Nov 18 2007,
> > Bisect: use "$GIT_DIR/BISECT_NAMES" to check if we are bisecting.),
> > we decided to use BISECT_NAMES but code changed a lot and we now
> > have to check BISECT_START first in the "bisect_start" function
> > anyway.
> >
> > This patch also makes things a little bit safer by creating
> > the BISECT_START file first and deleting it last, and also by
> > adding checks in "bisect_clean_state".
> >
> > Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>
> What's the breakage scenario that this patch fixes?

Before this patch, in "bisect_clean_state" we removed the BISECT_START =
file=20
before the other files, so for example if the process is killed after=20
having removed this file but not the others, then we are in an inconsis=
tent=20
state.

In this inconsistent state, if "git bisect reset" is called (perhaps ag=
ain),=20
then it would checkout the "master" branch (because the BISECT_START fi=
le=20
does not exists, but the BISECT_NAMES file still exists).

> > diff --git a/git-bisect.sh b/git-bisect.sh
> > index 4bcbace..991b2ef 100755
> > --- a/git-bisect.sh
> > +++ b/git-bisect.sh
> > @@ -44,7 +44,7 @@ sq() {
> >  }
> >
> >  bisect_autostart() {
> > -	test -f "$GIT_DIR/BISECT_NAMES" || {
> > +	test -s "$GIT_DIR/BISECT_START" || {
>
> The reason you ignore an existing but empty BISECT_START file is...?

=2E.. that it should not happen, because this file is only written=20
in "bisect_start" and there its content comes either from the current H=
EAD=20
or from a previous not empty BISECT_START file.

We might add a check for an empty BISECT_START file and warn in this ca=
se=20
that the file may have been corrupted, but that may be for another patc=
h.

Thanks,
Christian.
