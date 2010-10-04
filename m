From: Yann Dirson <ydirson@free.fr>
Subject: Re: [PATCH v4 1/4] Introduce wholesame directory move detection in
 diffcore.
Date: Mon, 4 Oct 2010 23:13:59 +0200
Message-ID: <20101004211359.GV4983@home.lan>
References: <1286138529-6780-1-git-send-email-ydirson@altern.org>
 <1286138529-6780-2-git-send-email-ydirson@altern.org>
 <20101004072850.GJ24884@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nguy???n Th?i Ng???c Duy <pclouds@gmail.com>,
	Baz <brian.ewins@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 23:04:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2sCw-0004zn-Tj
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 23:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932709Ab0JDVEK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 17:04:10 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:45828 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932299Ab0JDVEI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 17:04:08 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 9622AD480A3;
	Mon,  4 Oct 2010 23:04:00 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P2sMB-0004ID-Q6; Mon, 04 Oct 2010 23:13:59 +0200
Content-Disposition: inline
In-Reply-To: <20101004072850.GJ24884@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158117>

On Mon, Oct 04, 2010 at 02:28:50AM -0500, Jonathan Nieder wrote:
> > of "mv a b" and "mv a/* b/" are displayed as "Rnnn a/ b/", which is
> > probably not what we want.  "Rnnn a/* b/" could be a good choice fo=
r
> > the latter if we want them to be distinguished, and even if we want
> > them to look the same.
>=20
> Example?

It's just that every time we detect a bulk rename (of all files of a
directory) it is currently shown as a directory rename, even if they
all get moved into an existing dir.  Technically, a "directory rename"
(which I'd label "mv a b") is a special case of "bulk rename" (for
which "mv a/* b/" is more correct), where the target directory is
empty.  Currently the distinction between the two is not done, but
everything is incorrectly advertized as a rename.  I shall fix that.


> > Other future developements to be made on top of this include:
> > * extension of unified-diff format to express this
> [...]
> > ---
>=20
> Oh, so this is for diff --raw only.

Right, but that TODO list has not be revised in this iteration.
--detect-dir-renames does not need much to gain unified-diff, it is
mostly --hide-dir-rename-details which needs thougth and work - but as
it is now targetted at humans only, we can start with whatever seems
adequate and rewrite/refine as see fit.


> For the confused: the discussion from v3 perhaps explains why.

Thanks for this work of putting everything into context - I should
have done that myself.


>  $ ./git-diff-tree --abbrev=3D6 ee491 --factorize-renames -r=20
>  [DBG] possible rename from arm/ to bar/
>  [DBG] possible rename from ppc/ to moved/
>  [DBG] discarding dir rename of arm/, mixing moved/ and bar/
>  [DBG] ppc/* -> moved/* makes ppc/sha1ppc.S -> moved/sha1ppc.S uninte=
resting
>  [DBG] ppc/* -> moved/* makes ppc/sha1.c -> moved/sha1.c uninterestin=
g
>  ee491a42190ec6e716f46a55fa0a7f4e307f1629
>  :040000 040000 000000... 000000... R100	ppc/	moved/
>  :100644 100644 9e3ae0... 9e3ae0... R100	arm/sha1.c	bar/sha1.c
>  :100644 100644 395264... 395264... R100	arm/sha1.h	bar/sha1.h
>  :100644 100644 c3c51a... c065ee... R099	ppc/sha1.h	moved/sha1.h
>  :100644 100644 8c1cb9... 8c1cb9... R100	arm/sha1_arm.S	moved/sha1_ar=
m.S
>=20
> Presumably this patch takes care of the first step (grouping potentia=
l
> full-directory moves) and not the second (hiding the redundant file r=
enames).

No, it did hide the two moves labeled as "uninteresting" in the debug
traces above.  The ones left are one which is part of the dif rename
but was also modified, and the other ones (from arm/) are part of a
directory split (see 3rd debug line).

> Na=EFve review:
>=20
> > --- a/diff-lib.c
> > +++ b/diff-lib.c
> > @@ -208,7 +208,8 @@ int run_diff_files(struct rev_info *revs, unsig=
ned int option)
> >  						    ce_option, &dirty_submodule);
> >  		if (!changed && !dirty_submodule) {
> >  			ce_mark_uptodate(ce);
> > -			if (!DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER))
> > +			if (!DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER) &&
> > +			    !DIFF_OPT_TST(&revs->diffopt, DETECT_DIR_RENAMES))
> >  				continue;
>=20
> Hm, why?
> > @@ -338,7 +339,8 @@ static int show_modified(struct rev_info *revs,
> [...]
>=20
> Likewise.

The code below that (calls to diff_change) was previously only used
for FIND_COPIES_HARDER, but we also need to go there for
DETECT_DIR_RENAMES.  Removing those eg. make test "validate the output
for a move without a subdir." fail.  I admit I have not re-analyzed
this part recently, those tests were already parts of the first
iterations.


> [...]
> > --- a/diffcore-rename.c
> > +++ b/diffcore-rename.c
> > @@ -11,6 +11,7 @@
> >  static struct diff_rename_dst {
> >  	struct diff_filespec *two;
> >  	struct diff_filepair *pair;
> > +	int i_am_not_single:1; // does not look for a match, only here to=
 be looked at
> >  } *rename_dst;
>=20
> What does single mean?

"looking for a match" :)

> > @@ -451,13 +656,22 @@ void diffcore_rename(struct diff_options *opt=
ions)
> >  				p->one->rename_used++;
> >  			register_rename_src(p->one, p->score);
> >  		}
> > +		else {
> [...]
> > +			if (DIFF_OPT_TST(options, DETECT_DIR_RENAMES)) {
> > +				/* similarly, rename factorization needs to
> > +				 * see all files from second tree, but we don't
> > +				 * want them to be matched against single sources.
> > +				 */
> > +				locate_rename_dst(p->two, 1)->i_am_not_single =3D 1;
>=20
> Huh?

> > @@ -386,8 +414,11 @@ static int find_exact_renames(void)
> >  	for (i =3D 0; i < rename_src_nr; i++)
> >  		insert_file_table(&file_table, -1, i, rename_src[i].one);
> > =20
> > -	for (i =3D 0; i < rename_dst_nr; i++)
> > +	for (i =3D 0; i < rename_dst_nr; i++) {
> > +		if (rename_dst[i].i_am_not_single)
> > +			continue;
> >  		insert_file_table(&file_table, 1, i, rename_dst[i].two);
> > +	}
>=20
> What is this code path for?  (Sorry for the tedious questions.  My
> thinking is, if I cannot answer them without doing some legwork, how
> could the person about to break your code who is only glancing for
> a moment before plunging forward on an exciting new feature?)

Those are definitely related to the above.  This mimics the
=46IND_COPIES_HARDER behaviour (which is adding untouched files from
*src* tree to the rename_dst list so the -C algorithm works): here we
need to see all files from *dst* tree so we can tell if there was any
file left in a dir after a move.  This has a cost: we must ensure in
other places that codepaths not intended for those extra files are ok.

Hm, thinking quickly about it, maybe we could use a separate list to
store them, and only run through them when explicitely needed, that
would cost less and avoid the polutions you pointed at.  I shall have
a look at that.


> > @@ -49,9 +50,36 @@ static struct diff_rename_dst *locate_rename_dst=
(struct diff_filespec *two,
> [...]
> > =20
> > +static struct diff_rename_dst *locate_rename_dst_dir(struct diff_f=
ilespec *dir)
> > +{
> > +	/* code mostly duplicated from locate_rename_dst - not sure we
> > +	 * could merge them efficiently,though
> > +	 */
> > +	int first, last;
> > +	int prefixlength =3D strlen(dir->path);
> > +
> > +	first =3D 0;
> > +	last =3D rename_dst_nr;
> > +	while (last > first) {
> > +		int next =3D (last + first) >> 1;
> > +		struct diff_rename_dst *dst =3D &(rename_dst[next]);
> > +		int cmp =3D strncmp(dir->path, dst->two->path, prefixlength);
> > +		if (!cmp)
> > +			return dst;
> > +		if (cmp < 0) {
> > +			last =3D next;
> > +			continue;
> > +		}
> > +		first =3D next+1;
> > +	}
> > +	/* not found */
> > +	return NULL;
> > +}
>=20
> Binary search --- this is just a way to index into the sorted list
> of rename_dsts, right?

right.

> At first I thought it was searching for a good rename destination.
> A comment (or overview in the log message) could help clarify.

Ok.  More comments are surely good in this hairy piece of code :)


> > +// FIXME: prevent possible overflow
> > +/*
> > + * Copy dirname of src into dst, suitable to append a filename wit=
hout
> > + * an additional "/".
> > + * Only handles relative paths since there is no absolute path in =
a git repo.
> > + * Writes "" when there is no "/" in src.
> > + * May overwrite more chars than really needed, if src ends with a=
 "/".
> > + */
> > +static const char* copy_dirname(char* dst, const char* src)
> > +{
> > +	char* lastslash =3D strrchr(src, '/');
> > +	if (!lastslash) {
> > +		*dst =3D '\0';
> > +		return dst;
> > +	}
> > +	strncpy(dst, src, lastslash - src + 1);
>=20
> memcpy?

right

> > +	dst[lastslash - src + 1] =3D '\0';
> > +
> > +	// if src ends with a "/" strip the last component
> > +	if (lastslash[1] =3D=3D '\0') {
> > +		lastslash =3D strrchr(dst, '/');
> > +		if (!lastslash)
> > +			return strcpy(dst, ".");
> > +		lastslash[1] =3D '\0';
> > +	}
>=20
> It might be easier to read like this:
>=20
> /* Write name of the parent directory of src to dest. */
> static char *remove_last_component(char *dst, const char *src)
> {
> 	size_t len =3D strlen(src);
> 	const char *slash;
>=20
> 	if (len > 0 && src[len - 1] =3D=3D '/')
> 		/* Trailing slash.  Ignore it. */
> 		len--;
>=20
> 	slash =3D memrchr(src, '/', len);
> 	if (!slash) {
> 		*dst =3D '\0';
> 		return dst;
> 	}
>=20
> 	*mempcpy(dst, src, slash - src) =3D '\0';
> 	return dst;
> }
>=20
> Requires the glibc-specific function memrchr(), but that is easy to
> implement.  Compare strchrnul() [in git-compat-util.h].

Right, that's much more elegant - and should also be more efficient in
the "ends with /" case.

> [...]
> > +static struct diff_dir_rename* factorization_candidates =3D NULL;
> > +static void diffcore_factorize_renames(void)
>=20
> Maybe this could be refactored into multiple functions?
>=20
> > @@ -509,6 +723,8 @@ void diffcore_rename(struct diff_options *optio=
ns)
> > =20
> >  		if (rename_dst[i].pair)
> >  			continue; /* dealt with exact match already. */
> > +		if (rename_dst[i].i_am_not_single)
> > +			continue; /* not looking for a match. */
>=20
> Oh, not single means "not seeking a new relationship".
>=20
> > @@ -569,7 +785,28 @@ void diffcore_rename(struct diff_options *opti=
ons)
> >  	/* At this point, we have found some renames and copies and they
> >  	 * are recorded in rename_dst.  The original list is still in *q.
> >  	 */
> > +
> > +	/* Now possibly factorize those renames and copies. */
> > +	if (DIFF_OPT_TST(options, DETECT_DIR_RENAMES))
> > +		diffcore_factorize_renames();
>=20
> Huh?  Factorize?

"--factorize-renames" was how the single-option was called in the
previous series.  It has still not turned completely false, but sure
using "bulk rename" would be easier to read.


> Looks like I'll need to read diffcore_factorize_renames() after all. =
:(

Hopefully that part is better commented :)


> Sorry, not much to say yet.  Hopefully some of that can be useful
> nonetheless.

Thanks for this review, that work is always useful.
