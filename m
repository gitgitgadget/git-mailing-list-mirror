From: Kirill Smelkov <kirr@navytux.spb.ru>
Subject: Re: [PATCH 1/2] tree-diff: rework diff_tree() to generate diffs for
 multiparent cases as well
Date: Sun, 16 Feb 2014 12:08:29 +0400
Organization: NAVYTUX.SPB.RU
Message-ID: <20140216080829.GA3820@mini.zxlink>
References: <cover.1392299516.git.kirr@mns.spb.ru>
 <1dd9ca564e00ef235875aae4944675f53dcd25a3.1392299516.git.kirr@mns.spb.ru>
 <xmqqbnyalrk8.fsf@gitster.dls.corp.google.com>
 <20140214121529.GB3416@tugrik.mns.mnsspb.ru>
 <xmqqppmpiojn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kirr@mns.spb.ru, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 16 09:06:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEwjh-0007BM-NM
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 09:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbaBPIF5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Feb 2014 03:05:57 -0500
Received: from forward1h.mail.yandex.net ([84.201.187.146]:47632 "EHLO
	forward1h.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbaBPIF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Feb 2014 03:05:56 -0500
Received: from smtp3h.mail.yandex.net (smtp3h.mail.yandex.net [84.201.186.20])
	by forward1h.mail.yandex.net (Yandex) with ESMTP id D33F09E1CB2;
	Sun, 16 Feb 2014 12:05:52 +0400 (MSK)
Received: from smtp3h.mail.yandex.net (localhost [127.0.0.1])
	by smtp3h.mail.yandex.net (Yandex) with ESMTP id 34DDA1B42668;
	Sun, 16 Feb 2014 12:05:52 +0400 (MSK)
Received: from unknown (unknown [78.25.121.133])
	by smtp3h.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id pmY8y6QZLS-5mc4twU3;
	Sun, 16 Feb 2014 12:05:49 +0400
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: d1eac52a-67dc-4bdd-bfc4-00f8bcfd824e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navytux.spb.ru; s=mail;
	t=1392537951; bh=qDezozgd1mWvHnogePeVNTwg6nQMYuzTrAhnxUsq9mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:Organization:User-Agent;
	b=b1uVdTjOdlBlCeI78aBC3YkDUWQYuiqXtxLzpZyWFB26kbktK8EYtlMFg+3967yjg
	 9fUHXOhnVNn+kGFJrnRGumpYtr+bSNp/THIiqIea51UdJyZpX3yqu/Hn6JPrutcnbx
	 cBMBHQGQJooRj2hHyP3ngIq05ReK9LAigNu7imFo=
Authentication-Results: smtp3h.mail.yandex.net; dkim=pass header.i=@navytux.spb.ru
Received: from kirr by mini.zxlink with local (Exim 4.82)
	(envelope-from <kirr@mini.zxlink>)
	id 1WEwm5-0002iL-SY; Sun, 16 Feb 2014 12:08:29 +0400
Content-Disposition: inline
In-Reply-To: <xmqqppmpiojn.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242217>

On Fri, Feb 14, 2014 at 09:37:00AM -0800, Junio C Hamano wrote:
> Kirill Smelkov <kirr@mns.spb.ru> writes:
>=20
> > Previously diff_tree(), which is now named __diff_tree_sha1(), was
>=20
> That name with two leading underscores is a rather unfortunate,
> especially for a function that is not a file scope static.  No way
> to rename this to something more sensible?

I agree. In preparatory patches I thought this will go away, but it
stayed. I'll try to come up with something reasonable.


> > That impedance mismatch *hurts* *performance* *badly* for generatin=
g
> > combined diffs - in c839f1bd (combine-diff: optimize combine_diff_p=
ath
>=20
> Please avoid referring to a commit that is not in 'master' by its
> object name.  It can be reworked later and get a different name.

I agree, this makes sense. Is it ok to refer to nearby commits, by say
HEAD~3, if we know we are referring to 3-times previous commit?


> > That slowness comes from the fact that currently, while generating
> > combined diff, a lot of time is spent computing diff(commit,commit^=
2)
> > just to only then intersect that huge diff to almost small set of f=
iles
> > from diff(commit,commit^1).
>=20
> Good observation.
>=20
> >    |a|   |b|    a < b   ->  a =E2=88=89 B   ->   D(A,B) +=3D  +a   =
 a=E2=86=93
> >    |-|   |-|    a > b   ->  b =E2=88=89 A   ->   D(A,B) +=3D  -b   =
 b=E2=86=93
> >    | |   | |    a =3D b   ->  investigate =CE=B4(a,b)            a=E2=
=86=93 b=E2=86=93
>=20
> In both the "n-parallel" and "diff-tree", when an entry 'a' is a
> tree, I take this "D(A,B) +=3D +a" to mean (recursively) adding all
> the paths within 'a' to the result as addition.  Sounds sensible.

Correct.


> > D(A,B)
> >
> > is by definition the same as combined diff
> >
> > D(A,[B]),
> >
> > so if we could rework the code for common case and make it be not s=
lower
> > for nparent=3D1 case, usual diff(t1,t2) generation will not be slow=
er, and
> > multiparent diff tree-walker would greatly benefit generating
> > combine-diff.
>=20
> OK.

Thanks. My first goal was to demonstrate it is doable - i.e. we could
join two diff tree-walkers into generalized one, and that approach woul=
d
be sound and have chances to be accepted.


> > What we do is as follows:
> >
> > 1) diff tree-walker __diff_tree_sha1() is internally reworked to be
> >    a paths generator (new name diff_tree_paths()), with each genera=
ted path
> >    being `struct combine_diff_path` with info for path, new sha1,mo=
de and for
> >    every parent which sha1,mode it was in it.
> >
> > 2) From that info, we can still generate usual diff queue with
> >    struct diff_filepairs, via "exporting" generated
> >    combine_diff_path, if we know we run for nparent=3D1 case.
> >    (see emit_diff() which is now named emit_diff_p0only())
>=20
> s/p0/first_parent_/; perhaps?

Ok.


> > 3) In order for diff_can_quit_early(), which checks
> >
> >        DIFF_OPT_TST(opt, HAS_CHANGES))
> >
> >    to work, that exporting have to be happening not in bulk, but
> >    incrementally, one diff path at a time.
>=20
> Good thinking.

Yes. This requirement made the diff-paths producer be real generator,
which emits paths incrementally, which is imho, could be a good design
for making the component more reusable.


> > Some notes(*):
> >
> > 1) For loops,
> >
> >  i =3D 0; do { ... } while (++i < nparent);
> >
> > is used instead of
> >
> >  for (i =3D 0; i < nparent; ++i)
> >      ...
> >
> > because for the former case, the compiler have to emit additional
> > prologue code which checks for i >=3D nparent case before entering =
the
> > loop.
> >
> > As we require nparent must be >0, that additional overhead
> > conflicts with the "runs not slower for nparent=3D1 case than befor=
e"
> > goal.
>=20
> Unfortunate.  I'd rather see us stick to more readable and familiar
> form for maintainability if this were not measurable.

The most effect on performance were avoiding mallocs and reduce registe=
r
pressure. This too, was measurable, but of lower impact. If giving away
some part of percent for nparent=3D1 case is ok, this could be back to
usual for loops.

By the way, I find it a bit unfortunate, we don't have some for-loop
form with post-conditions in C, only do-while. Another observation, is
that it would be good to say to compiler e.g.

    assume nparent > 0;

and then in e.g.

    for (i =3D 0; i < nparent; i++)
        ...

the compiler could know it should not do pre-conditions checks before
entering the loop.

I've verified, that such behaviour, at least with gcc, could be achieve=
d
with

    if (nparent <=3D 0)
        return;

in function prologue - then the compiler deduces, at least with O2, tha=
t
after return point, nparent is >0, but this adds slight overhead on eac=
h
entry to function, and we have as many calls as there would be
recursions.

To me, the do-while is still readable, but if fors are preferred, I'll
re-measure what it costs and come back.


> > 2) alloca(), for small arrays, is used for the same reason - if we =
change
> > it to xmalloc()/free() the timings get worse
>=20
> Do you see any use of it outside compat/?
>=20
> I thought we specifically avoid alloca() for portability.  Also we
> do not use variable-length-arrays on the stack either, I think.

No, no usage outside compat/ and I knew alloca and VLAs are not used in
Git codebase for portability, and I understand alloca will be
criticized, but wanted to start the discussion rolling.

I've actually started without alloca, and used xmalloc/free for
[nparent] vectors, but the impact was measurable, so it just had to be
changed to something more optimal.

=46or me, personally, alloca is ok, but I understand there could be
portability issues (by the way, what compiler/system Git cares about
does not have working alloca?). Thats why I propose we do the following


1. at configure time, determine, do we have working alloca, and define

    #define HAVE_ALLOCA

   if yes.

2. in code

    #ifdef HAVE_ALLOCA
    # define xalloca(size)      (alloca(size))
    # define xalloca_free(p)    do {} while(0)
    #else
    # define xalloca(size)      (xmalloc(size))
    # define xalloca_free(p)    (free(p))
    #endif

   and use it like

   func() {
       p =3D xalloca(size);
       ...

       xalloca_free(p);
   }

This way, for systems, where alloca is available, we'll have optimal
on-stack allocations with fast executions. On the other hand, on
systems, where alloca is not available, this gracefully fallbacks to
xmalloc/free.

Please tell me what you think.

> > 3) For every parent tree, we need to keep a tag, whether entry from=
 that
> > parent equals to entry from minimal parent. For performance reasons=
 I'm
> > keeping that tag in entry's mode field in unused bit - see S_IFXMIN=
_NEQ.
>=20
> Unfortunate, but I do not see another place to keep this
> information offhand (nor implement this approach without keeping
> that piece of information).

Me neither. I've actually started with separate on-stack (via alloca)
[nparent] vector for such tags, and removing it was measurable.


> > P.S. and combined diff is not some exotic/for-play-only stuff - for
>=20
> No need to convince us about that ;-)

Thanks ;) May I ask to please keep my "motivation" part in the commit
log for historical reasons?


> > example for a program I write to represent Git archives as readonly
> > filesystem, there is initial scan with
> >
> >     `git log --reverse --raw --no-abbrev --no-renames -c`
> >
> > to extract log of what was created/changed when, as a result buildi=
ng a
> > map
> >
> >     {}  sha1    ->  in which commit (and date) a content was added
> >
> > that `-c` means also show combined diff for merges, and without the=
m, if
> > a merge is non-trivial (merges changes from two parents with both h=
aving
> > separate changes to a file), or an evil one, the map will not be fu=
ll,
> > i.e. some valid sha1 would be absent from it.
> >
> > That case was my initial motivation for combined diffs speedup.
>=20
> I wonder if this machinery can be reused for "log -m" as well (or
> perhaps you do that already?).  After all, by performing a single
> parallel scan, you are gathering all the necessary information to
> let you pretend that you did N pairwise diff-tree.

Unfortunately, as it is now, no, and let me explain why:

The reason that is not true, is that we omit recursing into directories=
,
if we know D(A,some-parent) for that path is empty. That means we don't
calculate D(A,any-other-parents) for that path and subpaths.

More structured description is that combined diff and "log -m", which
could be though as all diffs D(A,Pi) are different things:

    - the combined diff is D(A,B) generalization based on "^" (sets
      intersection) operator, and

    - log -m, aka "all diffs" is D(A,B) generalization based on "v"
      (sets union) operator.

Intersection means, we can omit calculating parts from other sets, if w=
e
know some set does not have an element (remember "don't recurse into
subdirectories"?), and unioning does not have this property.

It does so happen, that "^" case (combine-diff) is more interesting,
because in the end it allows to see new information - the diff a merge
itself introduces. "log -m" does not have this property and is no more
interesting to what plain diff(HEAD,HEAD^n) can provide - in other word=
s
it's just a convenience.

Now, the diff tree-walker could be generalized once more, to allow
clients specify, which diffs combination operator to use - intersection
or unioning, but I doubt that for unioning case that would add
significant speedup - we can't reduce any diff generation based on
another diff and the only saving is that we traverse resulting commit
tree once, but for some cases that could be maybe slower, say if result
and some parents don't have a path and some parent does, we'll be
recursing into that path and do more work compared to plain D(A,Pi) for
Pi that lacks the path.

In short: it could be generalized more, if needed, but I propose we
first establish the ground with generalizing to just combine-diff.


> > diff --git a/tree-diff.c b/tree-diff.c
> > index ab61a0a..2b7c991 100644
> > --- a/tree-diff.c
> > +++ b/tree-diff.c
> > @@ -7,6 +7,25 @@
> >  #include "tree.h"
> > =20
> >  /*
> > + * internal mode marker, saying a tree entry !=3D entry of tp[imin=
]
> > + * (see __diff_tree_paths for what it means there)
> > + *
> > + * it *must* not overlap with any valid modes, and we will update/=
use/emit
> > + * entry for diff only with it unset. Only non-overlapping to vali=
d modes is
> > + * required, because mode in tree_desc, comes here canonicalized v=
ia
> > + * canon_mode().
> > + *
> > + * the definition assumes unsigned is at least 32 bits.
> > + */
> > +#define S_IFXMIN_NEQ	0x80000000
>=20
> To allow better coordination across multiple codepaths that deal
> with modes, I am wondering if this should be defined in cache.h
> where made-up S_FIGITLINK and S_IFINVALID are defined (note the
> comment that is there, as well).

I knew about S_IFGITLINK and S_IFINVALID being located in cache.h with
comments.

The reason I decided to place S_IFXMIN_NEQ here, is that it is local ta=
g
- it is used locally in diff-tree, and neither is coming in, nor
coming out of it in set state.

So putting it in cache.h would mean we'll reserve the bit for something
which is used only temporarily and that bit would be not available for
other temporary uses.

On the other hand, it would be better, to mark in cache.h that some bit=
s
could be used temporarily for application specific things. Maybe provid=
e
a mask there or something similar to S_IFUSR1, S_IFUSR2 :)

S_IFXMIN_NEQ is just has no meaning for code outside of tree-diff.c ...

What do you think?


> > +static struct combine_diff_path *__diff_tree_paths(
> > +	struct combine_diff_path *p, const unsigned char *sha1,
> > +	const unsigned char **parents_sha1, int nparent,
> > +	struct strbuf *base, struct diff_options *opt);
>=20
> Most of our code do not name private helper functions with leading
> underscores.

What would be a good name here? In contrast to __diff_tree_sha1, it is
static, and adding some prefix/suffix to the name is maybe adding more
noise than value? We have diff_tree_paths() which does the setup and
cleanup and this worker __diff_tree_paths... Some names come to me as
diff_tree_paths_raw, or diff_tree_paths_worker, but having Linux
heritage, I like __diff_tree_paths more.

What would be a good approach for Git style here?


> I do like the direction this is going, but it looks to me that
> "struct combine_diff" is now misnamed, because it no longer is about
> combined diff.  You are introducing a good framework for n-way diff,
> and producing combined diff (i.e. -c or --cc) is now merely one way
> to use that framework.  We may want to clean these names up after
> this series settles---perhaps "struct nway_diff" or something.

Thanks. It was my main question whether this reworking will be a
good/accepted idea or not. I agree about `struct combine_diff_path`
name and that it should be changed afterwards (my idea was `struct
diff_path` for it).

Given that we had diff_filepair for n=3D2 diffs, it would logical to ca=
ll
it as maybe

    diff_nway,
    diff_filevector,
    or something else

but maybe emphasizing n/vector/... in the name is not so good in the
long run, and using, for generalized diff just

    diff_file, or
    diff_path

is better.


Naming is important and I don't settled on it however, yet...


> > +
> > +/*
> >   * Compare two tree entries, taking into account only path/S_ISDIR=
(mode),
> >   * but not their sha1's.
> >   *
> > @@ -33,72 +52,152 @@ static int tree_entry_pathcmp(struct tree_desc=
 *t1, struct tree_desc *t2)
> >  }
> > =20
> > =20
> > -/* convert path, t1/t2 -> opt->diff_*() callbacks */
> > -static void emit_diff(struct diff_options *opt, struct strbuf *pat=
h,
> > -		      struct tree_desc *t1, struct tree_desc *t2)
> > +/*
> > + * convert path -> opt->diff_*() callbacks
> > + *
> > + * emits diff to parent0 only.
>=20
> Please call that "first parent".

Ok.


> > + */
>=20
> "Returns 0 to tell the caller that we are done with p and it can be
> freed" or something?
>=20
> > +static int emit_diff_p0only(struct diff_options *opt, struct combi=
ne_diff_path *p)
> >  {
> > ...
> > +
> > +	return 0;	/* =3D no need to keep allocated combine_diff_path */
>=20
> Curious; what is that equal sign in the comment?

It stands for "that means", "i.e." or something similar. In other words
it is semantically equal to your comment from the above.

I'm open to reworking the commenting style for it to reads more well.
Should I?

~~~~

Thanks again for reviewing this and for generally accepting the
approach.  Please tell me your thoughts. Based on your input, I'll try
to come up with something improved on monday.

Thanks,
Kirill
