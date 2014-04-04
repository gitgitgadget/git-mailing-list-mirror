From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 18/19] tree-diff: rework diff_tree() to generate diffs for multiparent cases as well
Date: Fri, 04 Apr 2014 11:42:39 -0700
Message-ID: <xmqqppkxos0w.fsf@gitster.dls.corp.google.com>
References: <cover.1393257006.git.kirr@mns.spb.ru>
	<7b307610fe214f47643a46b3e815487558db244e.1393257006.git.kirr@mns.spb.ru>
	<20140327142354.GD17333@mini.zxlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kirr@mns.spb.ru, git@vger.kernel.org
To: Kirill Smelkov <kirr@navytux.spb.ru>
X-From: git-owner@vger.kernel.org Fri Apr 04 20:42:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WW94j-0006pe-3y
	for gcvg-git-2@plane.gmane.org; Fri, 04 Apr 2014 20:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909AbaDDSmp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Apr 2014 14:42:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50778 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753839AbaDDSmn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Apr 2014 14:42:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 668C07921C;
	Fri,  4 Apr 2014 14:42:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bSopT0pPEM6l
	1pjdmK/nWWUEvlY=; b=gvSmzAc3m8+KesLnZ7lBFQW9aexaeZc4IHVcOmgnC9a5
	PT7RXJN8HlVplPrFEieGeEtlGzWny0MK7xlkWg/qZeNr7B5a20eO4PkA9WBjknDo
	S7IU01dMjOvcrqcf6q5RONT6upvyqy/AAEyDkVC2DKg9Fq6UrIxmFzABF26CEK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WKeUZx
	Us70qCohrZfr6imFdDOsxtFODEAy/Iw4oBZKSoFeZJx1zPsB3YZZVH6ion70MSo3
	fPBBBjQaehJYXbJSRqXHcZ0g3FmwleyVpkNg0eR5r4TAc3tDVHYQgsNpIpfZpaGO
	wCMUtnmdTddhrRK86ds/0/M9p2/wEulndUH7w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53CCD7921B;
	Fri,  4 Apr 2014 14:42:42 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 474B879218;
	Fri,  4 Apr 2014 14:42:41 -0400 (EDT)
In-Reply-To: <20140327142354.GD17333@mini.zxlink> (Kirill Smelkov's message of
	"Thu, 27 Mar 2014 18:23:54 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E717D21E-BC28-11E3-9015-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245768>

Kirill Smelkov <kirr@navytux.spb.ru> writes:

> +extern
> +struct combine_diff_path *diff_tree_paths(

These two on the same line, please.

> +	struct combine_diff_path *p, const unsigned char *sha1,
> +	const unsigned char **parent_sha1, int nparent,
> +	struct strbuf *base, struct diff_options *opt);
>  extern int diff_tree_sha1(const unsigned char *old, const unsigned c=
har *new,
>  			  const char *base, struct diff_options *opt);
> ...
> +/*
> + * convert path -> opt->diff_*() callbacks
> + *
> + * emits diff to first parent only, and tells diff tree-walker that =
we are done
> + * with p and it can be freed.
> + */
> +static int emit_diff_first_parent_only(struct diff_options *opt, str=
uct combine_diff_path *p)
>  {

Very straight-forward; good.

> +static struct combine_diff_path *path_appendnew(struct combine_diff_=
path *last,
> +	int nparent, const struct strbuf *base, const char *path, int pathl=
en,
> +	unsigned mode, const unsigned char *sha1)
> +{
> +	struct combine_diff_path *p;
> +	int len =3D base->len + pathlen;
> +	int alloclen =3D combine_diff_path_size(nparent, len);
> +
> +	/* if last->next is !NULL - it is a pre-allocated memory, we can re=
use */
> +	p =3D last->next;
> +	if (p && (alloclen > (intptr_t)p->next)) {
> +		free(p);
> +		p =3D NULL;
> +	}
> +
> +	if (!p) {
> +		p =3D xmalloc(alloclen);
> +
> +		/*
> +		 * until we go to it next round, .next holds how many bytes we
> +		 * allocated (for faster realloc - we don't need copying old data)=
=2E
> +		 */
> +		p->next =3D (struct combine_diff_path *)(intptr_t)alloclen;

This reuse of the .next field is somewhat yucky, but it is very
localized inside a function that has a single callsite to this
function, so let's let it pass.

> +static struct combine_diff_path *emit_path(struct combine_diff_path =
*p,
> +	struct strbuf *base, struct diff_options *opt, int nparent,
> +	struct tree_desc *t, struct tree_desc *tp,
> +	int imin)
>  {

Again, fairly straight-forward and good.

> +/*
> + * generate paths for combined diff D(sha1,parents_sha1[])
> + ...
> +static struct combine_diff_path *ll_diff_tree_paths(
> +	struct combine_diff_path *p, const unsigned char *sha1,
> +	const unsigned char **parents_sha1, int nparent,
> +	struct strbuf *base, struct diff_options *opt)
> +{
> +	struct tree_desc t, *tp;
> +	void *ttree, **tptree;
> +	int i;
> +
> +	tp     =3D xalloca(nparent * sizeof(tp[0]));
> +	tptree =3D xalloca(nparent * sizeof(tptree[0]));
> +
> +	/*
> +	 * load parents first, as they are probably already cached.
> +	 *
> +	 * ( log_tree_diff() parses commit->parent before calling here via
> +	 *   diff_tree_sha1(parent, commit) )
> +	 */
> +	for (i =3D 0; i < nparent; ++i)
> +		tptree[i] =3D fill_tree_descriptor(&tp[i], parents_sha1[i]);
> +	ttree =3D fill_tree_descriptor(&t, sha1);
> =20
>  	/* Enable recursion indefinitely */
>  	opt->pathspec.recursive =3D DIFF_OPT_TST(opt, RECURSIVE);
> =20
>  	for (;;) {
> -		int cmp;
> +		int imin, cmp;
> =20
>  		if (diff_can_quit_early(opt))
>  			break;
> +
>  		if (opt->pathspec.nr) {
> -			skip_uninteresting(&t1, base, opt);
> -			skip_uninteresting(&t2, base, opt);
> +			skip_uninteresting(&t, base, opt);
> +			for (i =3D 0; i < nparent; i++)
> +				skip_uninteresting(&tp[i], base, opt);
>  		}
> -		if (!t1.size && !t2.size)
> -			break;
> =20
> -		cmp =3D tree_entry_pathcmp(&t1, &t2);
> +		/* comparing is finished when all trees are done */
> +		if (!t.size) {
> +			int done =3D 1;
> +			for (i =3D 0; i < nparent; ++i)
> +				if (tp[i].size) {
> +					done =3D 0;
> +					break;
> +				}
> +			if (done)
> +				break;
> +		}
> +
> +		/*
> +		 * lookup imin =3D argmin(x1...xn),
> +		 * mark entries whether they =3Dtp[imin] along the way
> +		 */
> +		imin =3D 0;
> +		tp[0].entry.mode &=3D ~S_IFXMIN_NEQ;
> +
> +		for (i =3D 1; i < nparent; ++i) {
> +			cmp =3D tree_entry_pathcmp(&tp[i], &tp[imin]);
> +			if (cmp < 0) {
> +				imin =3D i;
> +				tp[i].entry.mode &=3D ~S_IFXMIN_NEQ;
> +			}
> +			else if (cmp =3D=3D 0) {
> +				tp[i].entry.mode &=3D ~S_IFXMIN_NEQ;
> +			}
> +			else {
> +				tp[i].entry.mode |=3D S_IFXMIN_NEQ;
> +			}
> +		}
> +
> +		/* fixup markings for entries before imin */
> +		for (i =3D 0; i < imin; ++i)
> +			tp[i].entry.mode |=3D S_IFXMIN_NEQ;	/* x[i] > x[imin] */
> +

These two loop made my reading hiccup for a while.  With these you
are scanning the tp[] array 1.5 times (and doing the bitwise
assignment to entry.mode 1.5 * nparent times), but I suspect it may
have been a lot easier to read if the first loop only identified the
imin, and the second loop only did the entry.mode for _all_ nparents.

> +		/* compare a vs x[imin] */
> +		cmp =3D tree_entry_pathcmp(&t, &tp[imin]);
> +
> +		/* a =3D xi */
> +		if (cmp =3D=3D 0) {
> +			/* are either xk > xi or diff(a,xk) !=3D =C3=B8 ? */
> +			if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER)) {
> +				for (i =3D 0; i < nparent; ++i) {
> +					/* x[i] > x[imin] */
> +					if (tp[i].entry.mode & S_IFXMIN_NEQ)
> +						continue;
> +
> +					/* diff(a,xk) !=3D =C3=B8 */
> +					if (hashcmp(t.entry.sha1, tp[i].entry.sha1) ||
> +					    (t.entry.mode !=3D tp[i].entry.mode))
> +						continue;
> +
> +					goto skip_emit_t_tp;
> +				}
> +			}

Please bear with me.  The notation scares me as I am not good at math.

In short, the above loop is about:

    We are looking at path in 't' and some parents have the same
    path.  If any of these parents have that path with the contents
    identical to 't', then do not emit this path.

which makes sense to me, but these notation also made my reading
hiccup, especially because it is hard to guess what "xk" refers to
(e.g. "any k where 0 <=3D k < nparent && i !=3D k"? "all such k"?).  I
still haven't figured out what you meant to say with "xk", but I
think I got what the code wants to do.

How does the "the (virtual) path from a tree that has ran out of
entries sorts later than anything else" comparison rule influence
the picture?  A parent that has ran out would have _NEQ bit set and
would not count as having the same contents as the path from 't'.
If 't' has ran out, the only way t and tp[imin] could compare equal
is when tp[imin] has also ran out, but that can happen only when all
the parents are done with, so we would have broken out of the loop
even before we try to figure out imin.  So there is no funnies
there, which is good.

> +			/* D +=3D {=CE=B4(a,xk) if xk=3Dxi;  "+a" if xk > xi} */
> +			p =3D emit_path(p, base, opt, nparent,
> +					&t, tp, imin);
> +
> +		skip_emit_t_tp:
> +			/* a=E2=86=93,  =E2=88=80 xk=3Dximin  xk=E2=86=93 */
> +			update_tree_entry(&t);
> +			update_tp_entries(tp, nparent);
>  		}
> =20
> -		/* t1 < t2 */
> +		/* a < xi */
>  		else if (cmp < 0) {
> -			show_path(base, opt, &t1, /*t2=3D*/NULL);
> -			update_tree_entry(&t1);
> +			/* D +=3D "+a" */
> +			p =3D emit_path(p, base, opt, nparent,
> +					&t, /*tp=3D*/NULL, -1);
> +
> +			/* a=E2=86=93 */
> +			update_tree_entry(&t);

This is straight-forward.  No parent has path 't' has, so only the
entry from 't' is given, and we deal with the next entry in 't'
without touching any of the parents in the next iteration.  Good.

>  		}
> =20
> -		/* t1 > t2 */
> +		/* a > xi */
>  		else {
> -			show_path(base, opt, /*t1=3D*/NULL, &t2);
> -			update_tree_entry(&t2);
> +			/* =E2=88=80j xj=3Dximin -> D +=3D "-xi" */

Did you mean "-xj"?

> +			if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER)) {
> +				for (i =3D 0; i < nparent; ++i)
> +					if (tp[i].entry.mode & S_IFXMIN_NEQ)
> +						goto skip_emit_tp;
> +			}
> +
> +			p =3D emit_path(p, base, opt, nparent,
> +					/*t=3D*/NULL, tp, imin);
> +
> +		skip_emit_tp:
> +			/* =E2=88=80 xk=3Dximin  xk=E2=86=93 */
> +			update_tp_entries(tp, nparent);

There are parents whose path sort earlier than what is in 't'
(i.e. they were lost in the result---we would want to show
removal).  What makes us jump to the skip label?

    We are looking at path in 't', and some parents have paths that
    sort earlier than that path.  We will not go to skip label if
    any one of the parent's entry sorts after some other parent (or
    the parent in question has ran out its entries), which means we
    show the entry from the parents only when all the parents have
    that same path, which is missing from 't'.

I am not sure if I am reading this correctly, though.

=46or the two-way diff, the above degenerates to "show all parent
entries that come before the first entry in 't'", which is correct.
=46or the combined diff, the current intersect_paths() makes sure that
each path appears in all the pair-wise diff between t and tp[],
which again means that the above logic match the current behaviour.


> +struct combine_diff_path *diff_tree_paths(
> +	struct combine_diff_path *p, const unsigned char *sha1,
> +	const unsigned char **parents_sha1, int nparent,
> +	struct strbuf *base, struct diff_options *opt)
> +{
> +	p =3D ll_diff_tree_paths(p, sha1, parents_sha1, nparent, base, opt)=
;
> +
> +	/*
> +	 * free pre-allocated last element, if any
> +	 * (see path_appendnew() for details about why)
> +	 */
> +	if (p->next) {
> +		free(p->next);
> +		p->next =3D NULL;
> +	}
> +
> +	return p;
>  }
> =20
>  /*
> @@ -308,6 +664,27 @@ static void try_to_follow_renames(const unsigned=
 char *old, const unsigned char
>  	q->nr =3D 1;
>  }
> =20
> +static int ll_diff_tree_sha1(const unsigned char *old, const unsigne=
d char *new,
> +			     struct strbuf *base, struct diff_options *opt)
> +{
> +	struct combine_diff_path phead, *p;
> +	const unsigned char *parents_sha1[1] =3D {old};
> +	pathchange_fn_t pathchange_old =3D opt->pathchange;
> +
> +	phead.next =3D NULL;
> +	opt->pathchange =3D emit_diff_first_parent_only;
> +	diff_tree_paths(&phead, new, parents_sha1, 1, base, opt);

Hmph.  I would have expected

	const unsigned char **parents_sha1 =3D &old;

or even

	diff_tree_paths(&phead, new, &old, 1, base, opt);

here.


Thanks.
