From: Kirill Smelkov <kirr@navytux.spb.ru>
Subject: Re: [PATCH v2 18/19] tree-diff: rework diff_tree() to generate diffs
 for multiparent cases as well
Date: Tue, 8 Apr 2014 00:26:17 +0400
Organization: NAVYTUX.SPB.RU
Message-ID: <20140407202616.GA4140@mini.zxlink>
References: <xmqqmwfxm2rw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kirr@mns.spb.ru, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 22:23:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXG4O-0005Ju-2N
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 22:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687AbaDGUW7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Apr 2014 16:22:59 -0400
Received: from forward12.mail.yandex.net ([95.108.130.94]:51334 "EHLO
	forward12.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281AbaDGUW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 16:22:58 -0400
Received: from smtp11.mail.yandex.net (smtp11.mail.yandex.net [95.108.130.67])
	by forward12.mail.yandex.net (Yandex) with ESMTP id 4A859C20827;
	Tue,  8 Apr 2014 00:22:55 +0400 (MSK)
Received: from smtp11.mail.yandex.net (localhost [127.0.0.1])
	by smtp11.mail.yandex.net (Yandex) with ESMTP id E15137E014C;
	Tue,  8 Apr 2014 00:22:54 +0400 (MSK)
Received: from unknown (unknown [93.185.16.205])
	by smtp11.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id l9PVkxunAm-MlqCxm9k;
	Tue,  8 Apr 2014 00:22:53 +0400
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 4e7b6bf0-31c1-4f07-8337-9b05a20586ce
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navytux.spb.ru; s=mail;
	t=1396902174; bh=RFUsdV9Y6Uvq7WlPYmvaakjA5jmERRi/Q5/gRdAdsF8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization:User-Agent;
	b=Qxeya+9nBrD11z9qZDNreFzFUJ6g9FJ33n408Q6yv37fyZt4jWPSZNNsGdklxhD7H
	 +OrQDuoKp75Qe/QbJAj3XWL/g1/uXkGz1Td5iclA8LcMQRvBE/yOmAJbZERUhE9ze4
	 3DMN3mE6QQTdFQc7+mLt7JmOQEpK8FaAxl87XBvA=
Authentication-Results: smtp11.mail.yandex.net; dkim=pass header.i=@navytux.spb.ru
Received: from kirr by mini.zxlink with local (Exim 4.82)
	(envelope-from <kirr@mini.zxlink>)
	id 1WXG7V-0001LR-3z; Tue, 08 Apr 2014 00:26:17 +0400
Content-Disposition: inline
In-Reply-To: <xmqqmwfxm2rw.fsf@gitster.dls.corp.google.com>
 <xmqqr459m4j9.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245903>

On Mon, Apr 07, 2014 at 10:29:46AM -0700, Junio C Hamano wrote:
> Kirill Smelkov <kirr@navytux.spb.ru> writes:
>=20
> > The following
> > ...
> > maybe looks a bit simpler, but calls tree_entry_pathcmp twice more =
times.
> >
> > Besides for important nparent=3D1 case we were not calling
> > tree_entry_pathcmp at all and here we'll call it once, which would =
slow
> > execution down a bit, as base_name_compare shows measurable enough =
in profile.
> > To avoid that we'll need to add 'if (i=3D=3Dimin) continue' and thi=
s won't
> > be so simple then. And for general nparent case, as I've said, we'l=
l be
> > calling tree_entry_pathcmp twice more times...
> >
> > Because of all that I'd suggest to go with my original version.
>=20
> OK.

Thanks.

> > ... After some break on the topic,
> > with a fresh eye I see a lot of confusion goes from the notation I'=
ve
> > chosen initially (because of how I was reasoning about it on paper,=
 when
> > it was in flux) - i.e. xi for x[imin] and also using i as looping
> > variable. And also because xi was already used for x[imin] I've use=
d
> > another letter 'k' denoting all other x'es, which leads to confusio=
n...
> >
> >
> > I propose we do the following renaming to clarify things:
> >
> >     A/a     ->      T/t     (to match resulting tree t name in the =
code)
> >     X/x     ->      P/p     (to match parents trees tp in the code)
> >     i       ->      imin    (so that i would be free for other task=
s)
> >
> > then the above (with a prologue) would look like
> >
> > ---- 8< ----
> >  *       T     P1       Pn
> >  *       -     -        -
> >  *      |t|   |p1|     |pn|
> >  *      |-|   |--| ... |--|      imin =3D argmin(p1...pn)
> >  *      | |   |  |     |  |
> >  *      |-|   |--|     |--|
> >  *      |.|   |. |     |. |
> >  *       .     .        .
> >  *       .     .        .
> >  *
> >  * at any time there could be 3 cases:
> >  *
> >  *      1)  t < p[imin];
> >  *      2)  t > p[imin];
> >  *      3)  t =3D p[imin].
> >  *
> >  * Schematic deduction of what every case means, and what to do, fo=
llows:
> >  *
> >  * 1)  t < p[imin]  ->  =E2=88=80j t =E2=88=89 Pj  ->  "+t" =E2=88=88=
 D(T,Pj)  ->  D +=3D "+t";  t=E2=86=93
> >  *
> >  * 2)  t > p[imin]
> >  *
> >  *     2.1) =E2=88=83j: pj > p[imin]  ->  "-p[imin]" =E2=88=89 D(T,=
Pj)  ->  D +=3D =C3=B8;  =E2=88=80 pi=3Dp[imin]  pi=E2=86=93
> >  *     2.2) =E2=88=80i  pi =3D p[imin]  ->  pi =E2=88=89 T  ->  "-p=
i" =E2=88=88 D(T,Pi)  ->  D +=3D "-p[imin]";  =E2=88=80i pi=E2=86=93
> >  *
> >  * 3)  t =3D p[imin]
> >  *
> >  *     3.1) =E2=88=83j: pj > p[imin]  ->  "+t" =E2=88=88 D(T,Pj)  -=
>  only pi=3Dp[imin] remains to investigate
> >  *     3.2) pi =3D p[imin]  ->  investigate =CE=B4(t,pi)
> >  *      |
> >  *      |
> >  *      v
> >  *
> >  *     3.1+3.2) looking at =CE=B4(t,pi) =E2=88=80i: pi=3Dp[imin] - =
if all !=3D =C3=B8  ->
> >  *
> >  *                       =E2=8E=A7=CE=B4(t,pi)  - if pi=3Dp[imin]
> >  *              ->  D +=3D =E2=8E=A8
> >  *                       =E2=8E=A9"+t"     - if pi>p[imin]
> >  *
> >  *
> >  *     in any case t=E2=86=93  =E2=88=80 pi=3Dp[imin]  pi=E2=86=93
> > ...
> > now xk is gone and i matches p[i] (=3D pi) etc so variable names co=
rrelate
> > to algorithm description better.
> >
> > Does that maybe clarify things?
>=20
> That sounds more consistent (modulo perhaps s/argmin/min/ at the
> beginning?).

Thanks. argmin is there on purpose - min(p1...pn) is the minimal p, and
argmin(p1...pn) is imin such that p[imin] is minimal. As we are finding
the index of the minimal element we should use argmin.


> > P.S. Sorry for maybe some crept-in mistakes - I've tried to verify =
it
> > thoroughly, but am too sleepy to be completely sure. On the other h=
and I
> > think and hope the patch should be ok.
>=20
> Thanks and do not be sorry for "mistakes"---we have the review
> process exactly for catching them.

Thanks, I appreciate that.


On Mon, Apr 07, 2014 at 11:07:47AM -0700, Junio C Hamano wrote:
> Kirill Smelkov <kirr@navytux.spb.ru> writes:
>=20
> >> > +			if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER)) {
> >> > +				for (i =3D 0; i < nparent; ++i)
> >> > +					if (tp[i].entry.mode & S_IFXMIN_NEQ)
> >> > +						goto skip_emit_tp;
> >> > +			}
> >> > +
> >> > +			p =3D emit_path(p, base, opt, nparent,
> >> > +					/*t=3D*/NULL, tp, imin);
> >> > +
> >> > +		skip_emit_tp:
> >> > +			/* =E2=88=80 xk=3Dximin  xk=E2=86=93 */
> >> > +			update_tp_entries(tp, nparent);
> >>=20
> >> There are parents whose path sort earlier than what is in 't'
> >> (i.e. they were lost in the result---we would want to show
> >> removal).  What makes us jump to the skip label?
> >>=20
> >>     We are looking at path in 't', and some parents have paths tha=
t
> >>     sort earlier than that path.  We will not go to skip label if
> >>     any one of the parent's entry sorts after some other parent (o=
r
> >>     the parent in question has ran out its entries), which means w=
e
> >>     show the entry from the parents only when all the parents have
> >>     that same path, which is missing from 't'.
> >>=20
> >> I am not sure if I am reading this correctly, though.
> >>=20
> >> For the two-way diff, the above degenerates to "show all parent
> >> entries that come before the first entry in 't'", which is correct=
=2E
> >> For the combined diff, the current intersect_paths() makes sure th=
at
> >> each path appears in all the pair-wise diff between t and tp[],
> >> which again means that the above logic match the current behaviour=
=2E
> >
> > Yes, correct (modulo we *will* go to skip label if any one of the
> > parent's entry sorts after some other parent). By definition of com=
bined
> > diff we show a path only if it shows in every diff D(T,Pi), and if=20
> >
> >     2.1) =E2=88=83j: pj > p[imin]  ->  "-p[imin]" =E2=88=89 D(T,Pj)=
  ->  D +=3D =C3=B8;  =E2=88=80 pi=3Dp[imin]  pi=E2=86=93
> >
> > some pj sorts after p[imin] that would mean that Pj does not have
> > p[imin] and since t > p[imin] (which means T does not have p[imin]
> > either) diff D(T,Pj) does not have p[imin]. And because of that we =
know
> > the whole combined-diff will not have p[imin] as, by definition,
> > combined diff is sets intersection and one of the sets does not hav=
e
> > that path.
> >
> >   ( In usual words p[imin] is not changed between Pj..T - it was
> >     e.g. removed in Pj~, so merging parents to T does not bring any=
 new
> >     information wrt path p[imin] and that is why we do not want to =
show
> >     p[imin] in combined-diff output - no new change about that path=
 )
> >
> > So nothing to append to the output, and update minimum tree entries=
,
> > preparing for the next step.
>=20
> That's all in line with the current and traditional definition of
> combined diff.

Ok.


> This is a tangent that is outside the scope of this current topic,
> but I wonder if you found it disturbing that we treat the result 't'
> that has a path and the result 't' that does not have a path with
> respect to a parent that does not have the path in a somewhat
> assymmetric way.
>=20
> With a merge M between commits A and B, where they all have the same
> path with different contents, we obviously show that path in the
> combined diff format.  A merge N that records exactly the same tree
> as M that merges the same commits A and B plus another commit C that
> does not have that path still shows the combined diff, with one
> extra column to express "everything in the result N has been added
> with respect to C which did not have the path at all".
>=20
> However, a merge O between the same commits A and B, where A and B
> have a path and O loses it, shows the path in the combined format.
> A merge P among the same A, B and an extra parent C that does not
> have that path ceases to show it (this is the assymmetry).

Symmetry properties are very important and if something does not fit in=
to
symmetry - then something somewhere is really wrong for sure, but I
think there is no asymmetry here. In your example

      M=E2=88=86=E2=88=99    N=E2=88=86=E2=88=99
     / \ . '''
    / .'\  '  '
    A=E2=88=86   B=E2=88=99    C=C3=B8
    \ ''/. '  '
     \ /   '''
      O=C3=B8     P=C3=B8

let's say a path can be:

    =C3=B8   - empty
    =E2=88=86   - triangle
    =E2=88=99   - bullet
    =E2=88=86=E2=88=99  - triangle+bullet

then some symmetry operation is

    =E2=88=86=E2=88=99  <-> =C3=B8
    =E2=88=99   <-> =E2=88=99
    =E2=88=86   <-> =E2=88=86

so you "mirror" =E2=88=86=E2=88=99 to =C3=B8 (M,N->O,P), and so =C3=B8 =
is mirrored back to =E2=88=86=E2=88=99
(O,P->M,N). But then, when we mirror the whole graph, C=C3=B8 should be
mirrored to C'=E2=88=86=E2=88=99 and then that would be correct:

    A=E2=88=86   B=E2=88=99    C'=E2=88=86=E2=88=99
    \ ''/. '  '
     \ /   '''
      O=C3=B8     P=C3=B8

P to A,B,C' would show the path as N to A,B,C(without')


In other words a merge P among the same A, B and extra parent C' with
"contains everything" content is symmetrical to merge N to A,B and C
with empty content.


> It is a natural extension of "Do not show the path when the result
> matches one of the parent" rule, and in this case the result P takes
> contents, "the path does not exist", from one parent "C", so it is
> internally consistent, and I originally designed it that way on
> purpose, but somehow it feels a bit strange.

I hope it does not fill strange once the true symmetry is discovered,
and also P does not add a change compared to C, so the combined diff
should be empty as no new information is present in a merge itself.

A bit unusual on the first glance, but not strange, once you are used t=
o
it and consistent.

Thanks,
Kirill
