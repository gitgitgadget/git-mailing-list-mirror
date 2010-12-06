From: Anders Kaseorg <andersk@ksplice.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_describe=3A_Don=E2=80=99t_look_up_commits_with_--exact-match?=
Date: Mon, 6 Dec 2010 02:19:52 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1012060149550.23348@dr-wily.mit.edu>
References: <alpine.DEB.2.02.1011171830050.14285@dr-wily.mit.edu> <20101203084348.GD18202@burratino>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 06 08:20:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPVMi-0002HY-VX
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 08:20:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476Ab0LFHT5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Dec 2010 02:19:57 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:43907 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425Ab0LFHT4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Dec 2010 02:19:56 -0500
Received: by qwd7 with SMTP id 7so934242qwd.19
        for <git@vger.kernel.org>; Sun, 05 Dec 2010 23:19:55 -0800 (PST)
Received: by 10.224.89.78 with SMTP id d14mr2241453qam.263.1291619995485;
        Sun, 05 Dec 2010 23:19:55 -0800 (PST)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
        by mx.google.com with ESMTPS id s34sm3360431qcp.8.2010.12.05.23.19.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Dec 2010 23:19:54 -0800 (PST)
X-X-Sender: andersk@dr-wily.mit.edu
In-Reply-To: <20101203084348.GD18202@burratino>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162977>

On Fri, 3 Dec 2010, Jonathan Nieder wrote:
>  - static?
>  - the convention in git is to leave off the zero-initializers
>    for bss-allocated vars (static and globals).

Will fix.

> The usual convention is to use !hashcmp(...) to match the !strcmp(...=
)
> idiom.

Will fix (I hate that idiom, but yeah, match existing style).

> > +	for (e =3D names; e; e =3D e->next) {
> > +		if (!hashcmp(e->peeled, cmit->object.sha1) &&
> > +		    replace_name(n, e->prio, e->sha1, &e->tag))
> > +			n =3D e;
> > +	}
>=20
> Instead of looking up the commit to be matched exactly in the commits
> hash table, this makes a linear search.
>=20
> No change to the assymptotic running time, but would this make things
> much slower in the case of many tags?  How many before it's a problem
> (if ever)?

I don=E2=80=99t think it=E2=80=99s ever a problem: in my repository wit=
h 1800 tags on a=20
warm cache, that loop accounts for about 0.1% of even the fastest=20
non-exact-match query (a commit right after a tag).

> (If it's a problem in ordinary cases, I think the optimization could =
be=20
> limited to --exact-match pretty easily.)

Then you=E2=80=99d lose the speedup in the case where --exact-match was=
n=E2=80=99t=20
specified but a tag happens to match exactly (which isn=E2=80=99t criti=
cal, but=20
seemed nice).

> > -	for_each_ref(get_name, NULL);
> > +	for_each_rawref(get_name, NULL);
>=20
> Orthogonal change snuck in?

This does fall under the category of =E2=80=9CDon=E2=80=99t lookup comm=
its,=E2=80=9D and is=20
necessary to get the speedup (otherwise for_each_ref has already looked=
 up=20
the commits that the rest of the patch is trying to avoid looking up). =
=20
But I could split it out if you want.

Anders
