From: =?ISO-8859-15?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: Re: fix git-pack-redundant crashing sometimes
Date: Wed, 16 Nov 2005 00:13:14 +0100
Message-ID: <437A6B8A.8060905@etek.chalmers.se>
References: <81b0412b0511150749g5672158v7b39c02ffdf13e08@mail.gmail.com> <20051115213442.GA4256@steel.home> <437A560E.8020500@etek.chalmers.se> <20051115223340.GA3951@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Nov 16 00:14:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec9yx-0006Wg-24
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 00:12:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbVKOXMs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 15 Nov 2005 18:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbVKOXMs
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 18:12:48 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:51948 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932550AbVKOXMr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 18:12:47 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout1-sn2.hy.skanova.net (7.2.060.1)
        id 4378E95300070F73; Wed, 16 Nov 2005 00:12:46 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <20051115223340.GA3951@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11961>

Alex Riesen wrote:
> Lukas Sandstr=F6m, Tue, Nov 15, 2005 22:41:34 +0100:
>=20
>>>>llist_sorted_difference_inplace didn't handle the match in the firs=
t
>>>>sha1 correctly and the lists went wild everywhere.
>>>
>>>This wasn't enough. It never (>5 min on 2.4GHz PIV) finishes on
>>>my local mirror of git, which has 22 packs by now.
>>
>>If the patch I just sent out doesn't fix the problem, and you don't
>=20
>=20
> Sorry, it doesn't. The code loops here:
>=20
> 401             /* find the permutations which contain all missing ob=
jects */
> 402             perm_all =3D perm =3D get_all_permutations(non_unique=
);
> 403             while (perm) {
> 404                     if (is_superset(perm->pl, missing)) {
> 405                             new_perm =3D xmalloc(sizeof(struct pl=
l));
> 406                             new_perm->pl =3D perm->pl;
> 407                             new_perm->next =3D perm_ok;
> 408                             perm_ok =3D new_perm;
> (gdb)=20
> 409                     }
> 410                     perm =3D perm->next;
> 411             }
> 412
> 413             if (perm_ok =3D=3D NULL)
>=20
>=20
>=20
>>want to debug it yourself, could you please publish the .idx files
>>so I could have a look at them?
>=20
>=20
> Of course: http://home.arcor.de/fork0/download/idx.tar.gz
>=20

After giving it a quick look, I don't think it locks up. It is just hor=
ribly
slow. get_all_permutations returns (nice ASCII-art follows)

    ___n___
    \
     \ ____1____
n! * /  k!(n-k)!
    /______
      k=3D1

permutations, which for your case (22 packs) adds up to 4194303.

I'll look into an optimization so we won't have to call is_superset
for every one of them.

OTOH, I might be wrong and it could very well be an infinite loop.
Mind running it over the night? I won't look further into this in
20 hours or so anyway.
