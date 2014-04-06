From: Kirill Smelkov <kirr@navytux.spb.ru>
Subject: Re: [PATCH v2 18/19] tree-diff: rework diff_tree() to generate diffs
 for multiparent cases as well
Date: Mon, 7 Apr 2014 01:46:26 +0400
Organization: NAVYTUX.SPB.RU
Message-ID: <20140406214626.GA3843@mini.zxlink>
References: <cover.1393257006.git.kirr@mns.spb.ru>
 <7b307610fe214f47643a46b3e815487558db244e.1393257006.git.kirr@mns.spb.ru>
 <20140327142354.GD17333@mini.zxlink>
 <xmqqppkxos0w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kirr@mns.spb.ru, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 06 23:43:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWuql-0004FS-9R
	for gcvg-git-2@plane.gmane.org; Sun, 06 Apr 2014 23:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301AbaDFVnB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Apr 2014 17:43:01 -0400
Received: from forward1o.mail.yandex.net ([37.140.190.30]:59229 "EHLO
	forward1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbaDFVm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2014 17:42:59 -0400
Received: from smtp4o.mail.yandex.net (smtp4o.mail.yandex.net [37.140.190.29])
	by forward1o.mail.yandex.net (Yandex) with ESMTP id 93FAA13011F2;
	Mon,  7 Apr 2014 01:42:54 +0400 (MSK)
Received: from smtp4o.mail.yandex.net (localhost [127.0.0.1])
	by smtp4o.mail.yandex.net (Yandex) with ESMTP id 30B77232155B;
	Mon,  7 Apr 2014 01:42:54 +0400 (MSK)
Received: from unknown (unknown [93.185.17.232])
	by smtp4o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 9gSpvmy8zc-gp2WwiVM;
	Mon,  7 Apr 2014 01:42:52 +0400
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 8e2a9c90-9363-4b02-9c97-1b53989e3ee0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navytux.spb.ru; s=mail;
	t=1396820572; bh=nU9msRVPHzR7cDFuT643HmKukzCE1A8wqbp4CY3q++8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:Organization:User-Agent;
	b=GCXVTk7D4QXz7yglSgEEXMYA/PB/IF5kuAUJl/BNINcOEuFWV/CbxTYovIOEcCA0O
	 41sI0BITrDRa2bMFRVf0zmEcjhftdbE2LXc50IXIIaCFnz6T5vsuamGtcT1pl73EuF
	 PcPg1VC3zSsy5yoNy7KinCm63NCyhya+gE+OBDrY=
Authentication-Results: smtp4o.mail.yandex.net; dkim=pass header.i=@navytux.spb.ru
Received: from kirr by mini.zxlink with local (Exim 4.82)
	(envelope-from <kirr@mini.zxlink>)
	id 1WWutW-0003oH-E9; Mon, 07 Apr 2014 01:46:26 +0400
Content-Disposition: inline
In-Reply-To: <xmqqppkxos0w.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245792>

Junio,

=46irst of all thanks a lot for reviewing this patch. I'll reply inline
with corrected version attached in the end.

On Fri, Apr 04, 2014 at 11:42:39AM -0700, Junio C Hamano wrote:
> Kirill Smelkov <kirr@navytux.spb.ru> writes:
>=20
> > +extern
> > +struct combine_diff_path *diff_tree_paths(
>=20
> These two on the same line, please.

Ok

> > +	struct combine_diff_path *p, const unsigned char *sha1,
> > +	const unsigned char **parent_sha1, int nparent,
> > +	struct strbuf *base, struct diff_options *opt);
> >  extern int diff_tree_sha1(const unsigned char *old, const unsigned=
 char *new,
> >  			  const char *base, struct diff_options *opt);
> > ...
> > +/*
> > + * convert path -> opt->diff_*() callbacks
> > + *
> > + * emits diff to first parent only, and tells diff tree-walker tha=
t we are done
> > + * with p and it can be freed.
> > + */
> > +static int emit_diff_first_parent_only(struct diff_options *opt, s=
truct combine_diff_path *p)
> >  {
>=20
> Very straight-forward; good.

Thanks

> > +static struct combine_diff_path *path_appendnew(struct combine_dif=
f_path *last,
> > +	int nparent, const struct strbuf *base, const char *path, int pat=
hlen,
> > +	unsigned mode, const unsigned char *sha1)
> > +{
> > +	struct combine_diff_path *p;
> > +	int len =3D base->len + pathlen;
> > +	int alloclen =3D combine_diff_path_size(nparent, len);
> > +
> > +	/* if last->next is !NULL - it is a pre-allocated memory, we can =
reuse */
> > +	p =3D last->next;
> > +	if (p && (alloclen > (intptr_t)p->next)) {
> > +		free(p);
> > +		p =3D NULL;
> > +	}
> > +
> > +	if (!p) {
> > +		p =3D xmalloc(alloclen);
> > +
> > +		/*
> > +		 * until we go to it next round, .next holds how many bytes we
> > +		 * allocated (for faster realloc - we don't need copying old dat=
a).
> > +		 */
> > +		p->next =3D (struct combine_diff_path *)(intptr_t)alloclen;
>=20
> This reuse of the .next field is somewhat yucky, but it is very
> localized inside a function that has a single callsite to this
> function, so let's let it pass.

I agree it is not pretty, but it was the best approach I could find
for avoiding memory re-allocation without introducing new fields into
`struct combine_diff_path`. And yes, the trick is localized, so let's
let it live.


> > +static struct combine_diff_path *emit_path(struct combine_diff_pat=
h *p,
> > +	struct strbuf *base, struct diff_options *opt, int nparent,
> > +	struct tree_desc *t, struct tree_desc *tp,
> > +	int imin)
> >  {
>=20
> Again, fairly straight-forward and good.

Thanks again.


> > +/*
> > + * generate paths for combined diff D(sha1,parents_sha1[])
> > + ...
> > +static struct combine_diff_path *ll_diff_tree_paths(
> > +	struct combine_diff_path *p, const unsigned char *sha1,
> > +	const unsigned char **parents_sha1, int nparent,
> > +	struct strbuf *base, struct diff_options *opt)
> > +{
> > +	struct tree_desc t, *tp;
> > +	void *ttree, **tptree;
> > +	int i;
> > +
> > +	tp     =3D xalloca(nparent * sizeof(tp[0]));
> > +	tptree =3D xalloca(nparent * sizeof(tptree[0]));
> > +
> > +	/*
> > +	 * load parents first, as they are probably already cached.
> > +	 *
> > +	 * ( log_tree_diff() parses commit->parent before calling here vi=
a
> > +	 *   diff_tree_sha1(parent, commit) )
> > +	 */
> > +	for (i =3D 0; i < nparent; ++i)
> > +		tptree[i] =3D fill_tree_descriptor(&tp[i], parents_sha1[i]);
> > +	ttree =3D fill_tree_descriptor(&t, sha1);
> > =20
> >  	/* Enable recursion indefinitely */
> >  	opt->pathspec.recursive =3D DIFF_OPT_TST(opt, RECURSIVE);
> > =20
> >  	for (;;) {
> > -		int cmp;
> > +		int imin, cmp;
> > =20
> >  		if (diff_can_quit_early(opt))
> >  			break;
> > +
> >  		if (opt->pathspec.nr) {
> > -			skip_uninteresting(&t1, base, opt);
> > -			skip_uninteresting(&t2, base, opt);
> > +			skip_uninteresting(&t, base, opt);
> > +			for (i =3D 0; i < nparent; i++)
> > +				skip_uninteresting(&tp[i], base, opt);
> >  		}
> > -		if (!t1.size && !t2.size)
> > -			break;
> > =20
> > -		cmp =3D tree_entry_pathcmp(&t1, &t2);
> > +		/* comparing is finished when all trees are done */
> > +		if (!t.size) {
> > +			int done =3D 1;
> > +			for (i =3D 0; i < nparent; ++i)
> > +				if (tp[i].size) {
> > +					done =3D 0;
> > +					break;
> > +				}
> > +			if (done)
> > +				break;
> > +		}
> > +
> > +		/*
> > +		 * lookup imin =3D argmin(x1...xn),
> > +		 * mark entries whether they =3Dtp[imin] along the way
> > +		 */
> > +		imin =3D 0;
> > +		tp[0].entry.mode &=3D ~S_IFXMIN_NEQ;
> > +
> > +		for (i =3D 1; i < nparent; ++i) {
> > +			cmp =3D tree_entry_pathcmp(&tp[i], &tp[imin]);
> > +			if (cmp < 0) {
> > +				imin =3D i;
> > +				tp[i].entry.mode &=3D ~S_IFXMIN_NEQ;
> > +			}
> > +			else if (cmp =3D=3D 0) {
> > +				tp[i].entry.mode &=3D ~S_IFXMIN_NEQ;
> > +			}
> > +			else {
> > +				tp[i].entry.mode |=3D S_IFXMIN_NEQ;
> > +			}
> > +		}
> > +
> > +		/* fixup markings for entries before imin */
> > +		for (i =3D 0; i < imin; ++i)
> > +			tp[i].entry.mode |=3D S_IFXMIN_NEQ;	/* x[i] > x[imin] */
> > +
>=20
> These two loop made my reading hiccup for a while.  With these you
> are scanning the tp[] array 1.5 times (and doing the bitwise
> assignment to entry.mode 1.5 * nparent times), but I suspect it may
> have been a lot easier to read if the first loop only identified the
> imin, and the second loop only did the entry.mode for _all_ nparents.

Hmm, if in the first loop, we identify imin only, then in the second
loop we would have to call tree_entry_pathcmp(tp[i], tp[imin]) again,
which, in my view, would be not better and even worse - in the original
case we are scanning the parents nparent times comparing paths, and onl=
y
then do simple fixup up-to imin entry.

The following

---- 8< ---
                /* lookup imin =3D argmin(p1...pn) */
                imin =3D 0;
                for (i =3D 1; i < nparent; ++i) {
                        cmp =3D tree_entry_pathcmp(&tp[i], &tp[imin]);
                        if (cmp < 0)=20
                                imin =3D i;
                }

                /* mark entries whether they =3Dp[imin] */
                for (i =3D 0; i < nparent; ++i) {
                        cmp =3D tree_entry_pathcmp(&tp[i], &tp[imin]);
                        if (cmp)
                                tp[i].entry.mode |=3D S_IFXMIN_NEQ;    =
  =20
                        else
                                tp[i].entry.mode &=3D S_IFXMIN_NEQ;
                }
---- 8< ----

maybe looks a bit simpler, but calls tree_entry_pathcmp twice more time=
s.

Besides for important nparent=3D1 case we were not calling
tree_entry_pathcmp at all and here we'll call it once, which would slow
execution down a bit, as base_name_compare shows measurable enough in p=
rofile.
To avoid that we'll need to add 'if (i=3D=3Dimin) continue' and this wo=
n't
be so simple then. And for general nparent case, as I've said, we'll be
calling tree_entry_pathcmp twice more times...

Because of all that I'd suggest to go with my original version.


> > +		/* compare a vs x[imin] */
> > +		cmp =3D tree_entry_pathcmp(&t, &tp[imin]);
> > +
> > +		/* a =3D xi */
> > +		if (cmp =3D=3D 0) {
> > +			/* are either xk > xi or diff(a,xk) !=3D =C3=B8 ? */
> > +			if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER)) {
> > +				for (i =3D 0; i < nparent; ++i) {
> > +					/* x[i] > x[imin] */
> > +					if (tp[i].entry.mode & S_IFXMIN_NEQ)
> > +						continue;
> > +
> > +					/* diff(a,xk) !=3D =C3=B8 */
> > +					if (hashcmp(t.entry.sha1, tp[i].entry.sha1) ||
> > +					    (t.entry.mode !=3D tp[i].entry.mode))
> > +						continue;
> > +
> > +					goto skip_emit_t_tp;
> > +				}
> > +			}
>=20
> Please bear with me.  The notation scares me as I am not good at math=
=2E
>=20
> In short, the above loop is about:
>=20
>     We are looking at path in 't' and some parents have the same
>     path.  If any of these parents have that path with the contents
>     identical to 't', then do not emit this path.

Yes, correct.

> which makes sense to me, but these notation also made my reading
> hiccup, especially because it is hard to guess what "xk" refers to
> (e.g. "any k where 0 <=3D k < nparent && i !=3D k"? "all such k"?).  =
I
> still haven't figured out what you meant to say with "xk", but I
> think I got what the code wants to do.

Sorry about scaring you and about hiccup. After some break on the topic=
,
with a fresh eye I see a lot of confusion goes from the notation I've
chosen initially (because of how I was reasoning about it on paper, whe=
n
it was in flux) - i.e. xi for x[imin] and also using i as looping
variable. And also because xi was already used for x[imin] I've used
another letter 'k' denoting all other x'es, which leads to confusion...


I propose we do the following renaming to clarify things:

    A/a     ->      T/t     (to match resulting tree t name in the code=
)
    X/x     ->      P/p     (to match parents trees tp in the code)
    i       ->      imin    (so that i would be free for other tasks)

then the above (with a prologue) would look like

---- 8< ----
 *       T     P1       Pn
 *       -     -        -
 *      |t|   |p1|     |pn|
 *      |-|   |--| ... |--|      imin =3D argmin(p1...pn)
 *      | |   |  |     |  |
 *      |-|   |--|     |--|
 *      |.|   |. |     |. |
 *       .     .        .
 *       .     .        .
 *
 * at any time there could be 3 cases:
 *
 *      1)  t < p[imin];
 *      2)  t > p[imin];
 *      3)  t =3D p[imin].
 *
 * Schematic deduction of what every case means, and what to do, follow=
s:
 *
 * 1)  t < p[imin]  ->  =E2=88=80j t =E2=88=89 Pj  ->  "+t" =E2=88=88 D=
(T,Pj)  ->  D +=3D "+t";  t=E2=86=93
 *
 * 2)  t > p[imin]
 *
 *     2.1) =E2=88=83j: pj > p[imin]  ->  "-p[imin]" =E2=88=89 D(T,Pj) =
 ->  D +=3D =C3=B8;  =E2=88=80 pi=3Dp[imin]  pi=E2=86=93
 *     2.2) =E2=88=80i  pi =3D p[imin]  ->  pi =E2=88=89 T  ->  "-pi" =E2=
=88=88 D(T,Pi)  ->  D +=3D "-p[imin]";  =E2=88=80i pi=E2=86=93
 *
 * 3)  t =3D p[imin]
 *
 *     3.1) =E2=88=83j: pj > p[imin]  ->  "+t" =E2=88=88 D(T,Pj)  ->  o=
nly pi=3Dp[imin] remains to investigate
 *     3.2) pi =3D p[imin]  ->  investigate =CE=B4(t,pi)
 *      |
 *      |
 *      v
 *
 *     3.1+3.2) looking at =CE=B4(t,pi) =E2=88=80i: pi=3Dp[imin] - if a=
ll !=3D =C3=B8  ->
 *
 *                       =E2=8E=A7=CE=B4(t,pi)  - if pi=3Dp[imin]
 *              ->  D +=3D =E2=8E=A8
 *                       =E2=8E=A9"+t"     - if pi>p[imin]
 *
 *
 *     in any case t=E2=86=93  =E2=88=80 pi=3Dp[imin]  pi=E2=86=93

 ...

                /* compare t vs p[imin] */
                cmp =3D tree_entry_pathcmp(&t, &tp[imin]);

                /* t =3D p[imin] */
                if (cmp =3D=3D 0) {
                        /* are either pi > p[imin] or diff(t,pi) !=3D =C3=
=B8 ? */
                        if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER)) {
                                for (i =3D 0; i < nparent; ++i) {
                                        /* p[i] > p[imin] */
                                        if (tp[i].entry.mode & S_IFXMIN=
_NEQ)
                                                continue;

                                        /* diff(t,pi) !=3D =C3=B8 */
                                        if (hashcmp(t.entry.sha1, tp[i]=
=2Eentry.sha1) ||
                                            (t.entry.mode !=3D tp[i].en=
try.mode))
                                                continue;

                                        goto skip_emit_t_tp;
                                }
                        }

                        /* D +=3D {=CE=B4(t,pi) if pi=3Dp[imin];  "+a" =
if pi > p[imin]} */
                        p =3D emit_path(p, base, opt, nparent,
                                        &t, tp, imin);

                skip_emit_t_tp:
                        /* t=E2=86=93,  =E2=88=80 pi=3Dp[imin]  pi=E2=86=
=93 */
                        update_tree_entry(&t);
                        update_tp_entries(tp, nparent);
                }
---- 8< ----

now xk is gone and i matches p[i] (=3D pi) etc so variable names correl=
ate
to algorithm description better.

Does that maybe clarify things?


> How does the "the (virtual) path from a tree that has ran out of
> entries sorts later than anything else" comparison rule influence
> the picture?  A parent that has ran out would have _NEQ bit set and
> would not count as having the same contents as the path from 't'.
> If 't' has ran out, the only way t and tp[imin] could compare equal
> is when tp[imin] has also ran out, but that can happen only when all
> the parents are done with, so we would have broken out of the loop
> even before we try to figure out imin.  So there is no funnies
> there, which is good.

Yes, exactly.


> > +			/* D +=3D {=CE=B4(a,xk) if xk=3Dxi;  "+a" if xk > xi} */
> > +			p =3D emit_path(p, base, opt, nparent,
> > +					&t, tp, imin);
> > +
> > +		skip_emit_t_tp:
> > +			/* a=E2=86=93,  =E2=88=80 xk=3Dximin  xk=E2=86=93 */
> > +			update_tree_entry(&t);
> > +			update_tp_entries(tp, nparent);
> >  		}
> > =20
> > -		/* t1 < t2 */
> > +		/* a < xi */
> >  		else if (cmp < 0) {
> > -			show_path(base, opt, &t1, /*t2=3D*/NULL);
> > -			update_tree_entry(&t1);
> > +			/* D +=3D "+a" */
> > +			p =3D emit_path(p, base, opt, nparent,
> > +					&t, /*tp=3D*/NULL, -1);
> > +
> > +			/* a=E2=86=93 */
> > +			update_tree_entry(&t);
>=20
> This is straight-forward.  No parent has path 't' has, so only the
> entry from 't' is given, and we deal with the next entry in 't'
> without touching any of the parents in the next iteration.  Good.

Yes. I hope with the renaming it looks a bit more cleaner:

                /* t < p[imin] */
                else if (cmp < 0) {
                        /* D +=3D "+t" */
                        p =3D emit_path(p, base, opt, nparent,
                                        &t, /*tp=3D*/NULL, -1);

                        /* t=E2=86=93 */
                        update_tree_entry(&t);
                }

>=20
> >  		}
> > =20
> > -		/* t1 > t2 */
> > +		/* a > xi */
> >  		else {
> > -			show_path(base, opt, /*t1=3D*/NULL, &t2);
> > -			update_tree_entry(&t2);
> > +			/* =E2=88=80j xj=3Dximin -> D +=3D "-xi" */
>=20
> Did you mean "-xj"?

No, ximin, which was denoted in the earlier iterations of patch as xi -
if all parents current paths are equal and t does not have this path -
remove the path present in parents. It does not strictly differs betwee=
n
ximin and xj here, but xj is looping so ximin is better to have as some
defined path.

With the renaming the code looks like this

---- 8< ----
 * 2)  t > p[imin]
 *
 *     2.1) =E2=88=83j: pj > p[imin]  ->  "-p[imin]" =E2=88=89 D(T,Pj) =
 ->  D +=3D =C3=B8;  =E2=88=80 pi=3Dp[imin]  pi=E2=86=93
 *     2.2) =E2=88=80i  pi =3D p[imin]  ->  pi =E2=88=89 T  ->  "-pi" =E2=
=88=88 D(T,Pi)  ->  D +=3D "-p[imin]";  =E2=88=80i pi=E2=86=93
 ...
                /* t > p[imin] */
                else {
                        /* =E2=88=80i pi=3Dp[imin] -> D +=3D "-p[imin]"=
 */
                        if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER)) {
                                for (i =3D 0; i < nparent; ++i)
                                        if (tp[i].entry.mode & S_IFXMIN=
_NEQ)
                                                goto skip_emit_tp;
                        }

                        p =3D emit_path(p, base, opt, nparent,
                                        /*t=3D*/NULL, tp, imin);

                skip_emit_tp:
                        /* =E2=88=80 pi=3Dp[imin]  pi=E2=86=93 */
                        update_tp_entries(tp, nparent);
                }
---- 8< ----

Thanks for spotting it.


> > +			if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER)) {
> > +				for (i =3D 0; i < nparent; ++i)
> > +					if (tp[i].entry.mode & S_IFXMIN_NEQ)
> > +						goto skip_emit_tp;
> > +			}
> > +
> > +			p =3D emit_path(p, base, opt, nparent,
> > +					/*t=3D*/NULL, tp, imin);
> > +
> > +		skip_emit_tp:
> > +			/* =E2=88=80 xk=3Dximin  xk=E2=86=93 */
> > +			update_tp_entries(tp, nparent);
>=20
> There are parents whose path sort earlier than what is in 't'
> (i.e. they were lost in the result---we would want to show
> removal).  What makes us jump to the skip label?
>=20
>     We are looking at path in 't', and some parents have paths that
>     sort earlier than that path.  We will not go to skip label if
>     any one of the parent's entry sorts after some other parent (or
>     the parent in question has ran out its entries), which means we
>     show the entry from the parents only when all the parents have
>     that same path, which is missing from 't'.
>=20
> I am not sure if I am reading this correctly, though.
>=20
> For the two-way diff, the above degenerates to "show all parent
> entries that come before the first entry in 't'", which is correct.
> For the combined diff, the current intersect_paths() makes sure that
> each path appears in all the pair-wise diff between t and tp[],
> which again means that the above logic match the current behaviour.

Yes, correct (modulo we *will* go to skip label if any one of the
parent's entry sorts after some other parent). By definition of combine=
d
diff we show a path only if it shows in every diff D(T,Pi), and if=20

    2.1) =E2=88=83j: pj > p[imin]  ->  "-p[imin]" =E2=88=89 D(T,Pj)  ->=
  D +=3D =C3=B8;  =E2=88=80 pi=3Dp[imin]  pi=E2=86=93

some pj sorts after p[imin] that would mean that Pj does not have
p[imin] and since t > p[imin] (which means T does not have p[imin]
either) diff D(T,Pj) does not have p[imin]. And because of that we know
the whole combined-diff will not have p[imin] as, by definition,
combined diff is sets intersection and one of the sets does not have
that path.

  ( In usual words p[imin] is not changed between Pj..T - it was
    e.g. removed in Pj~, so merging parents to T does not bring any new
    information wrt path p[imin] and that is why we do not want to show
    p[imin] in combined-diff output - no new change about that path )

So nothing to append to the output, and update minimum tree entries,
preparing for the next step.

> > +struct combine_diff_path *diff_tree_paths(
> > +	struct combine_diff_path *p, const unsigned char *sha1,
> > +	const unsigned char **parents_sha1, int nparent,
> > +	struct strbuf *base, struct diff_options *opt)
> > +{
> > +	p =3D ll_diff_tree_paths(p, sha1, parents_sha1, nparent, base, op=
t);
> > +
> > +	/*
> > +	 * free pre-allocated last element, if any
> > +	 * (see path_appendnew() for details about why)
> > +	 */
> > +	if (p->next) {
> > +		free(p->next);
> > +		p->next =3D NULL;
> > +	}
> > +
> > +	return p;
> >  }
> > =20
> >  /*
> > @@ -308,6 +664,27 @@ static void try_to_follow_renames(const unsign=
ed char *old, const unsigned char
> >  	q->nr =3D 1;
> >  }
> > =20
> > +static int ll_diff_tree_sha1(const unsigned char *old, const unsig=
ned char *new,
> > +			     struct strbuf *base, struct diff_options *opt)
> > +{
> > +	struct combine_diff_path phead, *p;
> > +	const unsigned char *parents_sha1[1] =3D {old};
> > +	pathchange_fn_t pathchange_old =3D opt->pathchange;
> > +
> > +	phead.next =3D NULL;
> > +	opt->pathchange =3D emit_diff_first_parent_only;
> > +	diff_tree_paths(&phead, new, parents_sha1, 1, base, opt);
>=20
> Hmph.  I would have expected
>=20
> 	const unsigned char **parents_sha1 =3D &old;
>=20
> or even
>=20
> 	diff_tree_paths(&phead, new, &old, 1, base, opt);
>=20
> here.

I agree, the last one is better - thanks for spotting this.

I'm attaching corrected patch with renaming and fixups with smaller
issues you've mentioned.

Thanks,
Kirill

P.S. Sorry for maybe some crept-in mistakes - I've tried to verify it
thoroughly, but am too sleepy to be completely sure. On the other hand =
I
think and hope the patch should be ok.

---- 8< ----
=46rom: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH] tree-diff: rework diff_tree() to generate diffs for mu=
ltiparent cases as well

Previously diff_tree(), which is now named ll_diff_tree_sha1(), was
generating diff_filepair(s) for two trees t1 and t2, and that was
usually used for a commit as t1=3DHEAD~, and t2=3DHEAD - i.e. to see ch=
anges
a commit introduces.

In Git, however, we have fundamentally built flexibility in that a
commit can have many parents - 1 for a plain commit, 2 for a simple mer=
ge,
but also more than 2 for merging several heads at once.

=46or merges there is a so called combine-diff, which shows diff, a mer=
ge
introduces by itself, omitting changes done by any parent. That works
through first finding paths, that are different to all parents, and the=
n
showing generalized diff, with separate columns for +/- for each parent=
=2E
The code lives in combine-diff.c .

There is an impedance mismatch, however, in that a commit could
generally have any number of parents, and that while diffing trees, we
divide cases for 2-tree diffs and more-than-2-tree diffs. I mean there
is no special casing for multiple parents commits in e.g.
revision-walker .

That impedance mismatch *hurts* *performance* *badly* for generating
combined diffs - in "combine-diff: optimize combine_diff_path
sets intersection" I've already removed some slowness from it, but from
the timings provided there, it could be seen, that combined diffs still
cost more than an order of magnitude more cpu time, compared to diff fo=
r
usual commits, and that would only be an optimistic estimate, if we tak=
e
into account that for e.g. linux.git there is only one merge for severa=
l
dozens of plain commits.

That slowness comes from the fact that currently, while generating
combined diff, a lot of time is spent computing diff(commit,commit^2)
just to only then intersect that huge diff to almost small set of files
from diff(commit,commit^1).

That's because at present, to compute combine-diff, for first finding
paths, that "every parent touches", we use the following combine-diff
property/definition:

D(A,P1...Pn) =3D D(A,P1) ^ ... ^ D(A,Pn)      (w.r.t. paths)

where

D(A,P1...Pn) is combined diff between commit A, and parents Pi

and

D(A,Pi) is usual two-tree diff Pi..A

So if any of that D(A,Pi) is huge, tracting 1 n-parent combine-diff as =
n
1-parent diffs and intersecting results will be slow.

And usually, for linux.git and other topic-based workflows, that
D(A,P2) is huge, because, if merge-base of A and P2, is several dozens
of merges (from A, via first parent) below, that D(A,P2) will be diffin=
g
sum of merges from several subsystems to 1 subsystem.

The solution is to avoid computing n 1-parent diffs, and to find
changed-to-all-parents paths via scanning A's and all Pi's trees
simultaneously, at each step comparing their entries, and based on that
comparison, populate paths result, and deduce we could *skip*
*recursing* into subdirectories, if at least for 1 parent, sha1 of that
dir tree is the same as in A. That would save us from doing significant
amount of needless work.

Such approach is very similar to what diff_tree() does, only there we
deal with scanning only 2 trees simultaneously, and for n+1 tree, the
logic is a bit more complex:

D(T,P1...Pn) calculation scheme
-------------------------------

D(T,P1...Pn) =3D D(T,P1) ^ ... ^ D(T,Pn)	(regarding resulting paths set=
)

    D(T,Pj)		- diff between T..Pj
    D(T,P1...Pn)	- combined diff from T to parents P1,...,Pn

We start from all trees, which are sorted, and compare their entries in
lock-step:

     T     P1       Pn
     -     -        -
    |t|   |p1|     |pn|
    |-|   |--| ... |--|      imin =3D argmin(p1...pn)
    | |   |  |     |  |
    |-|   |--|     |--|
    |.|   |. |     |. |
     .     .        .
     .     .        .

at any time there could be 3 cases:

    1)  t < p[imin];
    2)  t > p[imin];
    3)  t =3D p[imin].

Schematic deduction of what every case means, and what to do, follows:

1)  t < p[imin]  ->  =E2=88=80j t =E2=88=89 Pj  ->  "+t" =E2=88=88 D(T,=
Pj)  ->  D +=3D "+t";  t=E2=86=93

2)  t > p[imin]

    2.1) =E2=88=83j: pj > p[imin]  ->  "-p[imin]" =E2=88=89 D(T,Pj)  ->=
  D +=3D =C3=B8;  =E2=88=80 pi=3Dp[imin]  pi=E2=86=93
    2.2) =E2=88=80i  pi =3D p[imin]  ->  pi =E2=88=89 T  ->  "-pi" =E2=88=
=88 D(T,Pi)  ->  D +=3D "-p[imin]";  =E2=88=80i pi=E2=86=93

3)  t =3D p[imin]

    3.1) =E2=88=83j: pj > p[imin]  ->  "+t" =E2=88=88 D(T,Pj)  ->  only=
 pi=3Dp[imin] remains to investigate
    3.2) pi =3D p[imin]  ->  investigate =CE=B4(t,pi)
     |
     |
     v

    3.1+3.2) looking at =CE=B4(t,pi) =E2=88=80i: pi=3Dp[imin] - if all =
!=3D =C3=B8  ->

                      =E2=8E=A7=CE=B4(t,pi)  - if pi=3Dp[imin]
             ->  D +=3D =E2=8E=A8
                      =E2=8E=A9"+t"     - if pi>p[imin]

    in any case t=E2=86=93  =E2=88=80 pi=3Dp[imin]  pi=E2=86=93

~

=46or comparison, here is how diff_tree() works:

D(A,B) calculation scheme
-------------------------

    A     B
    -     -
   |a|   |b|    a < b   ->  a =E2=88=89 B   ->   D(A,B) +=3D  +a    a=E2=
=86=93
   |-|   |-|    a > b   ->  b =E2=88=89 A   ->   D(A,B) +=3D  -b    b=E2=
=86=93
   | |   | |    a =3D b   ->  investigate =CE=B4(a,b)            a=E2=86=
=93 b=E2=86=93
   |-|   |-|
   |.|   |.|
    .     .
    .     .

~~~~~~~~

This patch generalizes diff tree-walker to work with arbitrary number o=
f
parents as described above - i.e. now there is a resulting tree t, and
some parents trees tp[i] i=3D[0..nparent). The generalization builds on
the fact that usual diff

D(A,B)

is by definition the same as combined diff

D(A,[B]),

so if we could rework the code for common case and make it be not slowe=
r
for nparent=3D1 case, usual diff(t1,t2) generation will not be slower, =
and
multiparent diff tree-walker would greatly benefit generating
combine-diff.

What we do is as follows:

1) diff tree-walker ll_diff_tree_sha1() is internally reworked to be
   a paths generator (new name diff_tree_paths()), with each generated =
path
   being `struct combine_diff_path` with info for path, new sha1,mode a=
nd for
   every parent which sha1,mode it was in it.

2) From that info, we can still generate usual diff queue with
   struct diff_filepairs, via "exporting" generated
   combine_diff_path, if we know we run for nparent=3D1 case.
   (see emit_diff() which is now named emit_diff_first_parent_only())

3) In order for diff_can_quit_early(), which checks

       DIFF_OPT_TST(opt, HAS_CHANGES))

   to work, that exporting have to be happening not in bulk, but
   incrementally, one diff path at a time.

   For such consumers, there is a new callback in diff_options
   introduced:

       ->pathchange(opt, struct combine_diff_path *)

   which, if set to !NULL, is called for every generated path.

   (see new compat ll_diff_tree_sha1() wrapper around new paths
    generator for setup)

4) The paths generation itself, is reworked from previous
   ll_diff_tree_sha1() code according to "D(A,P1...Pn) calculation
   scheme" provided above:

   On the start we allocate [nparent] arrays in place what was
   earlier just for one parent tree.

   then we just generalize loops, and comparison according to the
   algorithm.

Some notes(*):

1) alloca(), for small arrays, is used for "runs not slower for
   nparent=3D1 case than before" goal - if we change it to xmalloc()/fr=
ee()
   the timings get ~1% worse. For alloca() we use just-introduced
   xalloca/xalloca_free compatibility wrappers, so it should not be a
   portability problem.

2) For every parent tree, we need to keep a tag, whether entry from tha=
t
   parent equals to entry from minimal parent. For performance reasons =
I'm
   keeping that tag in entry's mode field in unused bit - see S_IFXMIN_=
NEQ.
   Not doing so, we'd need to alloca another [nparent] array, which hur=
ts
   performance.

3) For emitted paths, memory could be reused, if we know the path was
   processed via callback and will not be needed later. We use efficien=
t
   hand-made realloc-style path_appendnew(), that saves us from ~1-1.5%
   of potential additional slowdown.

4) goto(s) are used in several places, as the code executes a little bi=
t
   faster with lowered register pressure.

Also

- we should now check for FIND_COPIES_HARDER not only when two entries
  names are the same, and their hashes are equal, but also for a case,
  when a path was removed from some of all parents having it.

  The reason is, if we don't, that path won't be emitted at all (see
  "a > xi" case), and we'll just skip it, and FIND_COPIES_HARDER wants
  all paths - with diff or without - to be emitted, to be later analyze=
d
  for being copies sources.

  The new check is only necessary for nparent >1, as for nparent=3D1 ca=
se
  xmin_eqtotal always =3D1 =3Dnparent, and a path is always added to di=
ff as
  removal.

~~~~~~~~

Timings for

    # without -c, i.e. testing only nparent=3D1 case
    `git log --raw --no-abbrev --no-renames`

before and after the patch are as follows:

                navy.git        linux.git v3.10..v3.11

    before      0.611s          1.889s
    after       0.619s          1.907s
    slowdown    1.3%            0.9%

This timings show we did no harm to usual diff(tree1,tree2) generation.
=46rom the table we can see that we actually did ~1% slowdown, but I th=
ink
I've "earned" that 1% in the previous patch ("tree-diff: reuse base
str(buf) memory on sub-tree recursion", HEAD~~) so for nparent=3D1 case=
,
net timings stays approximately the same.

The output also stayed the same.

(*) If we revert 1)-4) to more usual techniques, for nparent=3D1 case,
    we'll get ~2-2.5% of additional slowdown, which I've tried to avoid=
, as
   "do no harm for nparent=3D1 case" rule.

=46or linux.git, combined diff will run an order of magnitude faster an=
d
appropriate timings will be provided in the next commit, as we'll be
taking advantage of the new diff tree-walker for combined-diff
generation there.

P.S. and combined diff is not some exotic/for-play-only stuff - for
example for a program I write to represent Git archives as readonly
filesystem, there is initial scan with

    `git log --reverse --raw --no-abbrev --no-renames -c`

to extract log of what was created/changed when, as a result building a
map

    {}  sha1    ->  in which commit (and date) a content was added

that `-c` means also show combined diff for merges, and without them, i=
f
a merge is non-trivial (merges changes from two parents with both havin=
g
separate changes to a file), or an evil one, the map will not be full,
i.e. some valid sha1 would be absent from it.

That case was my initial motivation for combined diffs speedup.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 cache.h     |  15 ++
 diff.c      |   1 +
 diff.h      |   9 ++
 tree-diff.c | 504 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
--------
 4 files changed, 465 insertions(+), 64 deletions(-)

diff --git a/cache.h b/cache.h
index dc040fb..e7f5a0c 100644
--- a/cache.h
+++ b/cache.h
@@ -75,6 +75,21 @@ unsigned long git_deflate_bound(git_zstream *, unsig=
ned long);
 #define S_ISGITLINK(m)	(((m) & S_IFMT) =3D=3D S_IFGITLINK)
=20
 /*
+ * Some mode bits are also used internally for computations.
+ *
+ * They *must* not overlap with any valid modes, and they *must* not b=
e emitted
+ * to outside world - i.e. appear on disk or network. In other words, =
it's just
+ * temporary fields, which we internally use, but they have to stay in=
-house.
+ *
+ * ( such approach is valid, as standard S_IF* fits into 16 bits, and =
in Git
+ *   codebase mode is `unsigned int` which is assumed to be at least 3=
2 bits )
+ */
+
+/* used internally in tree-diff */
+#define S_DIFFTREE_IFXMIN_NEQ	0x80000000
+
+
+/*
  * Intensive research over the course of many years has shown that
  * port 9418 is totally unused by anything else. Or
  *
diff --git a/diff.c b/diff.c
index 8e4a6a9..cda4aa8 100644
--- a/diff.c
+++ b/diff.c
@@ -3216,6 +3216,7 @@ void diff_setup(struct diff_options *options)
 	options->context =3D diff_context_default;
 	DIFF_OPT_SET(options, RENAME_EMPTY);
=20
+	/* pathchange left =3DNULL by default */
 	options->change =3D diff_change;
 	options->add_remove =3D diff_addremove;
 	options->use_color =3D diff_use_color_default;
diff --git a/diff.h b/diff.h
index 5d7b9f7..0abd735 100644
--- a/diff.h
+++ b/diff.h
@@ -15,6 +15,10 @@ struct diff_filespec;
 struct userdiff_driver;
 struct sha1_array;
 struct commit;
+struct combine_diff_path;
+
+typedef int (*pathchange_fn_t)(struct diff_options *options,
+		 struct combine_diff_path *path);
=20
 typedef void (*change_fn_t)(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
@@ -157,6 +161,7 @@ struct diff_options {
 	int close_file;
=20
 	struct pathspec pathspec;
+	pathchange_fn_t pathchange;
 	change_fn_t change;
 	add_remove_fn_t add_remove;
 	diff_format_fn_t format_callback;
@@ -189,6 +194,10 @@ const char *diff_line_prefix(struct diff_options *=
);
=20
 extern const char mime_boundary_leader[];
=20
+extern struct combine_diff_path *diff_tree_paths(
+	struct combine_diff_path *p, const unsigned char *sha1,
+	const unsigned char **parent_sha1, int nparent,
+	struct strbuf *base, struct diff_options *opt);
 extern int diff_tree_sha1(const unsigned char *old, const unsigned cha=
r *new,
 			  const char *base, struct diff_options *opt);
 extern int diff_root_tree_sha1(const unsigned char *new, const char *b=
ase,
diff --git a/tree-diff.c b/tree-diff.c
index 278acc8..e7b378c 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -6,7 +6,19 @@
 #include "diffcore.h"
 #include "tree.h"
=20
+/*
+ * internal mode marker, saying a tree entry !=3D entry of tp[imin]
+ * (see ll_diff_tree_paths for what it means there)
+ *
+ * we will update/use/emit entry for diff only with it unset.
+ */
+#define S_IFXMIN_NEQ	S_DIFFTREE_IFXMIN_NEQ
+
=20
+static struct combine_diff_path *ll_diff_tree_paths(
+	struct combine_diff_path *p, const unsigned char *sha1,
+	const unsigned char **parents_sha1, int nparent,
+	struct strbuf *base, struct diff_options *opt);
 static int ll_diff_tree_sha1(const unsigned char *old, const unsigned =
char *new,
 			     struct strbuf *base, struct diff_options *opt);
=20
@@ -42,71 +54,151 @@ static int tree_entry_pathcmp(struct tree_desc *t1=
, struct tree_desc *t2)
 }
=20
=20
-/* convert path, t1/t2 -> opt->diff_*() callbacks */
-static void emit_diff(struct diff_options *opt, struct strbuf *path,
-		      struct tree_desc *t1, struct tree_desc *t2)
+/*
+ * convert path -> opt->diff_*() callbacks
+ *
+ * emits diff to first parent only, and tells diff tree-walker that we=
 are done
+ * with p and it can be freed.
+ */
+static int emit_diff_first_parent_only(struct diff_options *opt, struc=
t combine_diff_path *p)
 {
-	unsigned int mode1 =3D t1 ? t1->entry.mode : 0;
-	unsigned int mode2 =3D t2 ? t2->entry.mode : 0;
-
-	if (mode1 && mode2) {
-		opt->change(opt, mode1, mode2, t1->entry.sha1, t2->entry.sha1,
-			1, 1, path->buf, 0, 0);
+	struct combine_diff_parent *p0 =3D &p->parent[0];
+	if (p->mode && p0->mode) {
+		opt->change(opt, p0->mode, p->mode, p0->sha1, p->sha1,
+			1, 1, p->path, 0, 0);
 	}
 	else {
 		const unsigned char *sha1;
 		unsigned int mode;
 		int addremove;
=20
-		if (mode2) {
+		if (p->mode) {
 			addremove =3D '+';
-			sha1 =3D t2->entry.sha1;
-			mode =3D mode2;
+			sha1 =3D p->sha1;
+			mode =3D p->mode;
 		} else {
 			addremove =3D '-';
-			sha1 =3D t1->entry.sha1;
-			mode =3D mode1;
+			sha1 =3D p0->sha1;
+			mode =3D p0->mode;
 		}
=20
-		opt->add_remove(opt, addremove, mode, sha1, 1, path->buf, 0);
+		opt->add_remove(opt, addremove, mode, sha1, 1, p->path, 0);
 	}
+
+	return 0;	/* we are done with p */
 }
=20
=20
-/* new path should be added to diff
+/*
+ * Make a new combine_diff_path from path/mode/sha1
+ * and append it to paths list tail.
+ *
+ * Memory for created elements could be reused:
+ *
+ *	- if last->next =3D=3D NULL, the memory is allocated;
+ *
+ *	- if last->next !=3D NULL, it is assumed that p=3Dlast->next was re=
turned
+ *	  earlier by this function, and p->next was *not* modified.
+ *	  The memory is then reused from p.
+ *
+ * so for clients,
+ *
+ * - if you do need to keep the element
+ *
+ *	p =3D path_appendnew(p, ...);
+ *	process(p);
+ *	p->next =3D NULL;
+ *
+ * - if you don't need to keep the element after processing
+ *
+ *	pprev =3D p;
+ *	p =3D path_appendnew(p, ...);
+ *	process(p);
+ *	p =3D pprev;
+ *	; don't forget to free tail->next in the end
+ *
+ * p->parent[] remains uninitialized.
+ */
+static struct combine_diff_path *path_appendnew(struct combine_diff_pa=
th *last,
+	int nparent, const struct strbuf *base, const char *path, int pathlen=
,
+	unsigned mode, const unsigned char *sha1)
+{
+	struct combine_diff_path *p;
+	int len =3D base->len + pathlen;
+	int alloclen =3D combine_diff_path_size(nparent, len);
+
+	/* if last->next is !NULL - it is a pre-allocated memory, we can reus=
e */
+	p =3D last->next;
+	if (p && (alloclen > (intptr_t)p->next)) {
+		free(p);
+		p =3D NULL;
+	}
+
+	if (!p) {
+		p =3D xmalloc(alloclen);
+
+		/*
+		 * until we go to it next round, .next holds how many bytes we
+		 * allocated (for faster realloc - we don't need copying old data).
+		 */
+		p->next =3D (struct combine_diff_path *)(intptr_t)alloclen;
+	}
+
+	last->next =3D p;
+
+	p->path =3D (char *)&(p->parent[nparent]);
+	memcpy(p->path, base->buf, base->len);
+	memcpy(p->path + base->len, path, pathlen);
+	p->path[len] =3D 0;
+	p->mode =3D mode;
+	hashcpy(p->sha1, sha1 ? sha1 : null_sha1);
+
+	return p;
+}
+
+/*
+ * new path should be added to combine diff
  *
  * 3 cases on how/when it should be called and behaves:
  *
- *	!t1,  t2	-> path added, parent lacks it
- *	 t1, !t2	-> path removed from parent
- *	 t1,  t2	-> path modified
+ *	 t, !tp		-> path added, all parents lack it
+ *	!t,  tp		-> path removed from all parents
+ *	 t,  tp		-> path modified/added
+ *			   (M for tp[i]=3Dtp[imin], A otherwise)
  */
-static void show_path(struct strbuf *base, struct diff_options *opt,
-		      struct tree_desc *t1, struct tree_desc *t2)
+static struct combine_diff_path *emit_path(struct combine_diff_path *p=
,
+	struct strbuf *base, struct diff_options *opt, int nparent,
+	struct tree_desc *t, struct tree_desc *tp,
+	int imin)
 {
 	unsigned mode;
 	const char *path;
+	const unsigned char *sha1;
 	int pathlen;
 	int old_baselen =3D base->len;
-	int isdir, recurse =3D 0, emitthis =3D 1;
+	int i, isdir, recurse =3D 0, emitthis =3D 1;
=20
 	/* at least something has to be valid */
-	assert(t1 || t2);
+	assert(t || tp);
=20
-	if (t2) {
+	if (t) {
 		/* path present in resulting tree */
-		tree_entry_extract(t2, &path, &mode);
-		pathlen =3D tree_entry_len(&t2->entry);
+		sha1 =3D tree_entry_extract(t, &path, &mode);
+		pathlen =3D tree_entry_len(&t->entry);
 		isdir =3D S_ISDIR(mode);
 	} else {
 		/*
-		 * a path was removed - take path from parent. Also take
-		 * mode from parent, to decide on recursion.
+		 * a path was removed - take path from imin parent. Also take
+		 * mode from that parent, to decide on recursion(1).
+		 *
+		 * 1) all modes for tp[i]=3Dtp[imin] should be the same wrt
+		 *    S_ISDIR, thanks to base_name_compare().
 		 */
-		tree_entry_extract(t1, &path, &mode);
-		pathlen =3D tree_entry_len(&t1->entry);
+		tree_entry_extract(&tp[imin], &path, &mode);
+		pathlen =3D tree_entry_len(&tp[imin].entry);
=20
 		isdir =3D S_ISDIR(mode);
+		sha1 =3D NULL;
 		mode =3D 0;
 	}
=20
@@ -115,18 +207,81 @@ static void show_path(struct strbuf *base, struct=
 diff_options *opt,
 		emitthis =3D DIFF_OPT_TST(opt, TREE_IN_RECURSIVE);
 	}
=20
-	strbuf_add(base, path, pathlen);
+	if (emitthis) {
+		int keep;
+		struct combine_diff_path *pprev =3D p;
+		p =3D path_appendnew(p, nparent, base, path, pathlen, mode, sha1);
+
+		for (i =3D 0; i < nparent; ++i) {
+			/*
+			 * tp[i] is valid, if present and if tp[i]=3D=3Dtp[imin] -
+			 * otherwise, we should ignore it.
+			 */
+			int tpi_valid =3D tp && !(tp[i].entry.mode & S_IFXMIN_NEQ);
+
+			const unsigned char *sha1_i;
+			unsigned mode_i;
+
+			p->parent[i].status =3D
+				!t ? DIFF_STATUS_DELETED :
+					tpi_valid ?
+						DIFF_STATUS_MODIFIED :
+						DIFF_STATUS_ADDED;
+
+			if (tpi_valid) {
+				sha1_i =3D tp[i].entry.sha1;
+				mode_i =3D tp[i].entry.mode;
+			}
+			else {
+				sha1_i =3D NULL;
+				mode_i =3D 0;
+			}
+
+			p->parent[i].mode =3D mode_i;
+			hashcpy(p->parent[i].sha1, sha1_i ? sha1_i : null_sha1);
+		}
=20
-	if (emitthis)
-		emit_diff(opt, base, t1, t2);
+		keep =3D 1;
+		if (opt->pathchange)
+			keep =3D opt->pathchange(opt, p);
+
+		/*
+		 * If a path was filtered or consumed - we don't need to add it
+		 * to the list and can reuse its memory, leaving it as
+		 * pre-allocated element on the tail.
+		 *
+		 * On the other hand, if path needs to be kept, we need to
+		 * correct its .next to NULL, as it was pre-initialized to how
+		 * much memory was allocated.
+		 *
+		 * see path_appendnew() for details.
+		 */
+		if (!keep)
+			p =3D pprev;
+		else
+			p->next =3D NULL;
+	}
=20
 	if (recurse) {
+		const unsigned char **parents_sha1;
+
+		parents_sha1 =3D xalloca(nparent * sizeof(parents_sha1[0]));
+		for (i =3D 0; i < nparent; ++i) {
+			/* same rule as in emitthis */
+			int tpi_valid =3D tp && !(tp[i].entry.mode & S_IFXMIN_NEQ);
+
+			parents_sha1[i] =3D tpi_valid ? tp[i].entry.sha1
+						    : NULL;
+		}
+
+		strbuf_add(base, path, pathlen);
 		strbuf_addch(base, '/');
-		ll_diff_tree_sha1(t1 ? t1->entry.sha1 : NULL,
-				  t2 ? t2->entry.sha1 : NULL, base, opt);
+		p =3D ll_diff_tree_paths(p, sha1, parents_sha1, nparent, base, opt);
+		xalloca_free(parents_sha1);
 	}
=20
 	strbuf_setlen(base, old_baselen);
+	return p;
 }
=20
 static void skip_uninteresting(struct tree_desc *t, struct strbuf *bas=
e,
@@ -145,59 +300,260 @@ static void skip_uninteresting(struct tree_desc =
*t, struct strbuf *base,
 	}
 }
=20
-static int ll_diff_tree_sha1(const unsigned char *old, const unsigned =
char *new,
-			     struct strbuf *base, struct diff_options *opt)
+
+/*
+ * generate paths for combined diff D(sha1,parents_sha1[])
+ *
+ * Resulting paths are appended to combine_diff_path linked list, and =
also, are
+ * emitted on the go via opt->pathchange() callback, so it is possible=
 to
+ * process the result as batch or incrementally.
+ *
+ * The paths are generated scanning new tree and all parents trees
+ * simultaneously, similarly to what diff_tree() was doing for 2 trees=
=2E
+ * The theory behind such scan is as follows:
+ *
+ *
+ * D(T,P1...Pn) calculation scheme
+ * -------------------------------
+ *
+ * D(T,P1...Pn) =3D D(T,P1) ^ ... ^ D(T,Pn)	(regarding resulting paths=
 set)
+ *
+ *	D(T,Pj)		- diff between T..Pj
+ *	D(T,P1...Pn)	- combined diff from T to parents P1,...,Pn
+ *
+ *
+ * We start from all trees, which are sorted, and compare their entrie=
s in
+ * lock-step:
+ *
+ *	 T     P1       Pn
+ *	 -     -        -
+ *	|t|   |p1|     |pn|
+ *	|-|   |--| ... |--|      imin =3D argmin(p1...pn)
+ *	| |   |  |     |  |
+ *	|-|   |--|     |--|
+ *	|.|   |. |     |. |
+ *	 .     .        .
+ *	 .     .        .
+ *
+ * at any time there could be 3 cases:
+ *
+ *	1)  t < p[imin];
+ *	2)  t > p[imin];
+ *	3)  t =3D p[imin].
+ *
+ * Schematic deduction of what every case means, and what to do, follo=
ws:
+ *
+ * 1)  t < p[imin]  ->  =E2=88=80j t =E2=88=89 Pj  ->  "+t" =E2=88=88 =
D(T,Pj)  ->  D +=3D "+t";  t=E2=86=93
+ *
+ * 2)  t > p[imin]
+ *
+ *     2.1) =E2=88=83j: pj > p[imin]  ->  "-p[imin]" =E2=88=89 D(T,Pj)=
  ->  D +=3D =C3=B8;  =E2=88=80 pi=3Dp[imin]  pi=E2=86=93
+ *     2.2) =E2=88=80i  pi =3D p[imin]  ->  pi =E2=88=89 T  ->  "-pi" =
=E2=88=88 D(T,Pi)  ->  D +=3D "-p[imin]";  =E2=88=80i pi=E2=86=93
+ *
+ * 3)  t =3D p[imin]
+ *
+ *     3.1) =E2=88=83j: pj > p[imin]  ->  "+t" =E2=88=88 D(T,Pj)  ->  =
only pi=3Dp[imin] remains to investigate
+ *     3.2) pi =3D p[imin]  ->  investigate =CE=B4(t,pi)
+ *      |
+ *      |
+ *      v
+ *
+ *     3.1+3.2) looking at =CE=B4(t,pi) =E2=88=80i: pi=3Dp[imin] - if =
all !=3D =C3=B8  ->
+ *
+ *                       =E2=8E=A7=CE=B4(t,pi)  - if pi=3Dp[imin]
+ *              ->  D +=3D =E2=8E=A8
+ *                       =E2=8E=A9"+t"     - if pi>p[imin]
+ *
+ *
+ *     in any case t=E2=86=93  =E2=88=80 pi=3Dp[imin]  pi=E2=86=93
+ *
+ *
+ * ~~~~~~~~
+ *
+ * NOTE
+ *
+ *	Usual diff D(A,B) is by definition the same as combined diff D(A,[B=
]),
+ *	so this diff paths generator can, and is used, for plain diffs
+ *	generation too.
+ *
+ *	Please keep attention to the common D(A,[B]) case when working on t=
he
+ *	code, in order not to slow it down.
+ *
+ * NOTE
+ *	nparent must be > 0.
+ */
+
+
+/* =E2=88=80 pi=3Dp[imin]  pi=E2=86=93 */
+static inline void update_tp_entries(struct tree_desc *tp, int nparent=
)
 {
-	struct tree_desc t1, t2;
-	void *t1tree, *t2tree;
+	int i;
+	for (i =3D 0; i < nparent; ++i)
+		if (!(tp[i].entry.mode & S_IFXMIN_NEQ))
+			update_tree_entry(&tp[i]);
+}
=20
-	t1tree =3D fill_tree_descriptor(&t1, old);
-	t2tree =3D fill_tree_descriptor(&t2, new);
+static struct combine_diff_path *ll_diff_tree_paths(
+	struct combine_diff_path *p, const unsigned char *sha1,
+	const unsigned char **parents_sha1, int nparent,
+	struct strbuf *base, struct diff_options *opt)
+{
+	struct tree_desc t, *tp;
+	void *ttree, **tptree;
+	int i;
+
+	tp     =3D xalloca(nparent * sizeof(tp[0]));
+	tptree =3D xalloca(nparent * sizeof(tptree[0]));
+
+	/*
+	 * load parents first, as they are probably already cached.
+	 *
+	 * ( log_tree_diff() parses commit->parent before calling here via
+	 *   diff_tree_sha1(parent, commit) )
+	 */
+	for (i =3D 0; i < nparent; ++i)
+		tptree[i] =3D fill_tree_descriptor(&tp[i], parents_sha1[i]);
+	ttree =3D fill_tree_descriptor(&t, sha1);
=20
 	/* Enable recursion indefinitely */
 	opt->pathspec.recursive =3D DIFF_OPT_TST(opt, RECURSIVE);
=20
 	for (;;) {
-		int cmp;
+		int imin, cmp;
=20
 		if (diff_can_quit_early(opt))
 			break;
+
 		if (opt->pathspec.nr) {
-			skip_uninteresting(&t1, base, opt);
-			skip_uninteresting(&t2, base, opt);
+			skip_uninteresting(&t, base, opt);
+			for (i =3D 0; i < nparent; i++)
+				skip_uninteresting(&tp[i], base, opt);
+		}
+
+		/* comparing is finished when all trees are done */
+		if (!t.size) {
+			int done =3D 1;
+			for (i =3D 0; i < nparent; ++i)
+				if (tp[i].size) {
+					done =3D 0;
+					break;
+				}
+			if (done)
+				break;
+		}
+
+		/*
+		 * lookup imin =3D argmin(p1...pn),
+		 * mark entries whether they =3Dp[imin] along the way
+		 */
+		imin =3D 0;
+		tp[0].entry.mode &=3D ~S_IFXMIN_NEQ;
+
+		for (i =3D 1; i < nparent; ++i) {
+			cmp =3D tree_entry_pathcmp(&tp[i], &tp[imin]);
+			if (cmp < 0) {
+				imin =3D i;
+				tp[i].entry.mode &=3D ~S_IFXMIN_NEQ;
+			}
+			else if (cmp =3D=3D 0) {
+				tp[i].entry.mode &=3D ~S_IFXMIN_NEQ;
+			}
+			else {
+				tp[i].entry.mode |=3D S_IFXMIN_NEQ;
+			}
 		}
-		if (!t1.size && !t2.size)
-			break;
=20
-		cmp =3D tree_entry_pathcmp(&t1, &t2);
+		/* fixup markings for entries before imin */
+		for (i =3D 0; i < imin; ++i)
+			tp[i].entry.mode |=3D S_IFXMIN_NEQ;	/* pi > p[imin] */
=20
-		/* t1 =3D t2 */
-		if (cmp =3D=3D 0) {
-			if (DIFF_OPT_TST(opt, FIND_COPIES_HARDER) ||
-			    hashcmp(t1.entry.sha1, t2.entry.sha1) ||
-			    (t1.entry.mode !=3D t2.entry.mode))
-				show_path(base, opt, &t1, &t2);
=20
-			update_tree_entry(&t1);
-			update_tree_entry(&t2);
+
+		/* compare t vs p[imin] */
+		cmp =3D tree_entry_pathcmp(&t, &tp[imin]);
+
+		/* t =3D p[imin] */
+		if (cmp =3D=3D 0) {
+			/* are either pi > p[imin] or diff(t,pi) !=3D =C3=B8 ? */
+			if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER)) {
+				for (i =3D 0; i < nparent; ++i) {
+					/* p[i] > p[imin] */
+					if (tp[i].entry.mode & S_IFXMIN_NEQ)
+						continue;
+
+					/* diff(t,pi) !=3D =C3=B8 */
+					if (hashcmp(t.entry.sha1, tp[i].entry.sha1) ||
+					    (t.entry.mode !=3D tp[i].entry.mode))
+						continue;
+
+					goto skip_emit_t_tp;
+				}
+			}
+
+			/* D +=3D {=CE=B4(t,pi) if pi=3Dp[imin];  "+a" if pi > p[imin]} */
+			p =3D emit_path(p, base, opt, nparent,
+					&t, tp, imin);
+
+		skip_emit_t_tp:
+			/* t=E2=86=93,  =E2=88=80 pi=3Dp[imin]  pi=E2=86=93 */
+			update_tree_entry(&t);
+			update_tp_entries(tp, nparent);
 		}
=20
-		/* t1 < t2 */
+		/* t < p[imin] */
 		else if (cmp < 0) {
-			show_path(base, opt, &t1, /*t2=3D*/NULL);
-			update_tree_entry(&t1);
+			/* D +=3D "+t" */
+			p =3D emit_path(p, base, opt, nparent,
+					&t, /*tp=3D*/NULL, -1);
+
+			/* t=E2=86=93 */
+			update_tree_entry(&t);
 		}
=20
-		/* t1 > t2 */
+		/* t > p[imin] */
 		else {
-			show_path(base, opt, /*t1=3D*/NULL, &t2);
-			update_tree_entry(&t2);
+			/* =E2=88=80i pi=3Dp[imin] -> D +=3D "-p[imin]" */
+			if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER)) {
+				for (i =3D 0; i < nparent; ++i)
+					if (tp[i].entry.mode & S_IFXMIN_NEQ)
+						goto skip_emit_tp;
+			}
+
+			p =3D emit_path(p, base, opt, nparent,
+					/*t=3D*/NULL, tp, imin);
+
+		skip_emit_tp:
+			/* =E2=88=80 pi=3Dp[imin]  pi=E2=86=93 */
+			update_tp_entries(tp, nparent);
 		}
 	}
=20
-	free(t2tree);
-	free(t1tree);
-	return 0;
+	free(ttree);
+	for (i =3D nparent-1; i >=3D 0; i--)
+		free(tptree[i]);
+	xalloca_free(tptree);
+	xalloca_free(tp);
+
+	return p;
+}
+
+struct combine_diff_path *diff_tree_paths(
+	struct combine_diff_path *p, const unsigned char *sha1,
+	const unsigned char **parents_sha1, int nparent,
+	struct strbuf *base, struct diff_options *opt)
+{
+	p =3D ll_diff_tree_paths(p, sha1, parents_sha1, nparent, base, opt);
+
+	/*
+	 * free pre-allocated last element, if any
+	 * (see path_appendnew() for details about why)
+	 */
+	if (p->next) {
+		free(p->next);
+		p->next =3D NULL;
+	}
+
+	return p;
 }
=20
 /*
@@ -308,6 +664,26 @@ static void try_to_follow_renames(const unsigned c=
har *old, const unsigned char
 	q->nr =3D 1;
 }
=20
+static int ll_diff_tree_sha1(const unsigned char *old, const unsigned =
char *new,
+			     struct strbuf *base, struct diff_options *opt)
+{
+	struct combine_diff_path phead, *p;
+	pathchange_fn_t pathchange_old =3D opt->pathchange;
+
+	phead.next =3D NULL;
+	opt->pathchange =3D emit_diff_first_parent_only;
+	diff_tree_paths(&phead, new, &old, 1, base, opt);
+
+	for (p =3D phead.next; p;) {
+		struct combine_diff_path *pprev =3D p;
+		p =3D p->next;
+		free(pprev);
+	}
+
+	opt->pathchange =3D pathchange_old;
+	return 0;
+}
+
 int diff_tree_sha1(const unsigned char *old, const unsigned char *new,=
 const char *base_str, struct diff_options *opt)
 {
 	struct strbuf base;
--=20
1.9.rc0.143.g6fd479e
