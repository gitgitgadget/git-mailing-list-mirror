From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 7/7] bisect: use "rev-list --bisect-skip" and remove "filter_skipped" function
Date: Fri, 13 Mar 2009 06:29:25 +0100
Message-ID: <200903130629.25452.chriscool@tuxfamily.org>
References: <20090312085140.c22cd336.chriscool@tuxfamily.org> <7viqmfkuyt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 06:31:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhzzt-00005G-Kf
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 06:31:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbZCMFaX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Mar 2009 01:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbZCMFaX
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 01:30:23 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:57982 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751218AbZCMFaW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2009 01:30:22 -0400
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 1A456E08053;
	Fri, 13 Mar 2009 06:30:12 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 253FAE08094;
	Fri, 13 Mar 2009 06:30:09 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7viqmfkuyt.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113142>

Le jeudi 12 mars 2009, Junio C Hamano a =E9crit :
> These (except for the first one which I do not think belongs to the
> series) look more or less straightforward changes.

I added the first one to the series because I use strbuf_split with the=
 new=20
behavior in the series.

> One worrysome thing that the series introduces is that you used to ho=
ld
> all the skipped ones in a shell variable $skip and fed it internally =
to
> the filter_skipped shell function, but now you give them from the com=
mand
> line.  When you have tons of skipped commits, this can easily bust th=
e
> command line length limit on some system, while the shell may still b=
e Ok
> with such a large string variable.

Yeah. I will send a patch (8/7) that makes "git rev-list" read the skip=
ped=20
commits from stdin when "--bisect-skip" is passed, and that changes=20
git-bisect.sh accordingly. If this behavior is ok, then I can reorder t=
he=20
series if you want.

> Because the operations in rev-list related to bisect are very closely
> tied to the implementation of the bisect Porcelain anyway, I am wonde=
ring
> if it makes more sense to just feed the name of the toplevel refname
> hierarchy, i.e. "refs/bisect", as a rev-list parameter and let rev-li=
st
> enumerate what is skipped, which commits are good and which ones are =
bad.

Yeah that could be an improvement, but then the enumeration will happen=
 once=20
in git-bisect.sh and once in "git rev-list", instead of just once in=20
git-bisect.sh. And we also have to deal with the other command line=20
arguments passed to "git rev-list" on top of the enumerated commits fro=
m=20
the refname hierachy, so I don't think that would be very consistent.

But perhaps we could create a new "git rev-bisect" builtin plumbing com=
mand=20
that could do that. And later we could improve this new command so that=
 it=20
checks merge bases (like what is done in bisect_next in git-bisect.sh) =
and=20
so that it also checks out the source code of the new revision to be te=
sted=20
(like what is done in bisect_checkout in git-bisect.sh).

Thanks,
Christian.
