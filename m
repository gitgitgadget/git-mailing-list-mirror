From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 1/3] bisect: add parameters to "filter_skipped"
Date: Sat, 6 Jun 2009 06:38:14 +0200
Message-ID: <200906060638.15267.chriscool@tuxfamily.org>
References: <20090605040238.8885.92790.chriscool@tuxfamily.org> <20090605041044.8885.91204.chriscool@tuxfamily.org> <7vtz2vp45e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 06:41:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCniI-0005v6-H5
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 06:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbZFFEiT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Jun 2009 00:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbZFFEiS
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 00:38:18 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:41171 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750720AbZFFEiR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Jun 2009 00:38:17 -0400
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 2E8ABD48072;
	Sat,  6 Jun 2009 06:38:10 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 0EB89D48015;
	Sat,  6 Jun 2009 06:38:07 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vtz2vp45e.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120868>

Le Friday 05 June 2009, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > because we will need to get more information from this function in
> > some later patches.
> >
> > The new "int *count" parameter gives the number of commits left aft=
er
> > the skipped commit have been filtered out.
> >
> > The new "int *skipped_first" parameter tells us if the first commit
> > in the list has been skipped. Note that using this parameter also
> > changes the behavior of the function if the first commit is indeed
> > skipped. Because we assume that in this case we will want all the
> > filtered commits, not just the first one, even if "show_all" is not
> > set.
>
> The way you use (*skipped_first =3D=3D -1) as a marker to mean "we've=
 already
> checked more than one commit_list so even when we see a one to be
> skipped, it won't be the first one" is unreadable, especially without
> explanation. Worse yet, the above paragraph explains what the paramet=
er
> does, but why is it so special to skip the one that happens to be the
> first on the input list, especially when one does not know how the li=
st
> is sorted to begin with.

I added the following comment before the function:

/*
 * In this function, passing a not NULL skipped_first is very special.
 * It means that we want to know if the first commit in the list is
 * skipped because we will want to test a commit away from it if it is
 * indeed skipped.
 * So if the first commit is skipped, we cannot take the shortcut to
 * just "return list" when we find the first non skipped commit, we
 * have to return a fully filtered list.
 *
 * We use (*skipped_first =3D=3D -1) to mean "it has been found that th=
e
 * first commit is not skipped". In this case *skipped_first is set bac=
k
 * to 0 just before the function returns.
 */

I hope this is enough to clarify what this function does.

> I understand that the list is sorted by the "goodness" value, i.e. th=
e
> one that cuts the graph into closer-to-equal halves comes earlier in =
the
> list, but still it is unclear why having to skip the best one is so
> special compared to having to skip say the second best one, especiall=
y
> when you imagine a case where the first two on the list are of equal
> "goodness" value.

The reason why only having to skip the best one is special is just beca=
use=20
it is simpler to only check if the best one is skipped or not.

I agree that it could be an improvement to consider if other commits wi=
th=20
the same goodness value are also skipped, but I think it would make the=
=20
code more complex.

Thanks,
Christian.
