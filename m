From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] bisect: error out when given any good rev that is not an ancestor of the bad rev
Date: Tue, 1 Jul 2008 01:16:30 +0200
Message-ID: <200807010116.30214.chriscool@tuxfamily.org>
References: <20080701004211.ba9b89c9.chriscool@tuxfamily.org> <7v3amuv8yg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 01:13:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDSYt-0004JC-FW
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 01:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960AbYF3XMf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jun 2008 19:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753970AbYF3XMf
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 19:12:35 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:47894 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753577AbYF3XMe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jun 2008 19:12:34 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 82B401AB2C0;
	Tue,  1 Jul 2008 01:12:33 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 1C1511AB2AC;
	Tue,  1 Jul 2008 01:12:32 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7v3amuv8yg.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86963>

Le mardi 1 juillet 2008, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > Before this patch "git bisect" doesn't really work when it is given
> > some good revs that are siblings of the bad rev.
> >
> > For example if there is the following history:
> >
> > A-B-C-D
> >    \E-F
> >
> > and we launch "git bisect start D F" then only C and D will be
> > considered as possible first bad commit. This is wrong because A, B=
 and
> > E may be bad too if the bug exists everywhere except in F that fixe=
s
> > it.
>
> Please don't.
>
> bisect is about finding a single regression by partitioning the graph
> into older good section and newer bad section with a *single* "first =
bad
> commit".
>
> For your "this could also be possible" scenario is already outside th=
e
> realm.  You are assuming A, B and F is good, and D is bad.

I am assuming the first bad commit in the graph is A and it is fixed by=
 F.

> But if E is=20
> bad, then that breakage cannot possibly affect the transition between=
 B
> and D from good to bad (E cannot break D), so C must *also* be bad.

Yes, I assume C is also bad.

> ... which means you are dealing with *two* breakages.  That's outside
> what bisect deals with.

Sorry, I don't understand why I am assuming 2 breakages.

> And this does not need to have forked development.  If the graph were
> like this:
>
>   A-B-C-D-E-F
>
> and if F is bad and B is good, with your logic, after checking that D=
 is
> already bad, we cannot discount E --- after somehow fixing D, we _mig=
ht_
> also be introducing another breakage with E.  You cannot even check f=
or
> that anyway, but the logic is the same.

I don't think the logic is the same because in your case git bisect wil=
l=20
report one first bad commit anyway even if this bad commit has been fix=
ed=20
latter.

In my case above, git bisect currently considers C and D as the only=20
possible bad commits because when it is told that F is good, it assumes=
=20
that all the ancestors or F are good too. And this means that B is=20
considered good so C will be found as the first bad commit. I think thi=
s=20
can be really misleading because there is no good->bad transition betwe=
en B=20
and C.

Regards,
Christian.
