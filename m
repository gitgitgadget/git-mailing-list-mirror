From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH 3/7] replace_object: add mechanism to replace objects found in "refs/replace/"
Date: Thu, 15 Jan 2009 10:44:45 +0100
Message-ID: <200901151044.45967.chriscool@tuxfamily.org>
References: <20090112184403.ebb99b75.chriscool@tuxfamily.org> <7vd4esf0tv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 10:45:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNOnD-0005Fw-V3
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 10:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754367AbZAOJoP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jan 2009 04:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbZAOJoO
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 04:44:14 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:48453 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754076AbZAOJoK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jan 2009 04:44:10 -0500
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 7D3279400D3;
	Thu, 15 Jan 2009 10:44:01 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 82F58940150;
	Thu, 15 Jan 2009 10:43:59 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7vd4esf0tv.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105775>

Le mardi 13 janvier 2009, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > diff --git a/replace_object.c b/replace_object.c
> > new file mode 100644
> > index 0000000..25b3ef3
> > --- /dev/null
> > +++ b/replace_object.c
> > @@ -0,0 +1,116 @@
> > +#include "cache.h"
> > +#include "refs.h"
> > +
> > +static struct replace_object {
> > +	unsigned char sha1[2][20];
> > +} **replace_object;
> > +
> > +static int replace_object_alloc, replace_object_nr;
> > +
> > +static int replace_object_pos(const unsigned char *sha1)
> > +{
> > +	int lo, hi;
> > +	lo =3D 0;
> > +	hi =3D replace_object_nr;
> > +	while (lo < hi) {
> > +		int mi =3D (lo + hi) / 2;
> > +		struct replace_object *rep =3D replace_object[mi];
> > +		int cmp =3D hashcmp(sha1, rep->sha1[0]);
> > +		if (!cmp)
> > +			return mi;
> > +		if (cmp < 0)
> > +			hi =3D mi;
> > +		else
> > +			lo =3D mi + 1;
> > +	}
> > +	return -lo - 1;
> > +}
>
> Hmm, this is a tangent of this topic, but I wonder if we can do somet=
hing
> more generic to factor out many binary search like this we have
> throughout the code.  Also I wonder if they can be made more efficien=
t by
> taking advantage of the fact that our hash is expected to produce a g=
ood
> uniform distribution, similar to the way patch-ids.c::patch_pos() doe=
s
> this.
>
> I guess the performance should not matter much for this table, as we
> expect there won't be massive object replacements.
>
> Also I recall Dscho muttered something about hashmap I didn't quite
> understand.

Yeah, maybe it's possible to get faster code and to refactor the=20
many binary search we have, but I will leave that for latter or for oth=
er=20
people interested in these topics, if you let me.

> > +static int register_replace_ref(const char *refname,
> > +				const unsigned char *sha1,
> > +				int flag, void *cb_data)
> > +{
> > +	/* Get sha1 from refname */
> > +	const char *slash =3D strrchr(refname, '/');
> > +	const char *hash =3D slash ? slash + 1 : refname;
> > +	struct replace_object * repl_obj =3D xmalloc(sizeof(*repl_obj));
>
> 	struct replace_object *repl_obj =3D ...

Ok.

> > +	if (strlen(hash) !=3D 40 || get_sha1_hex(hash, repl_obj->sha1[0])=
) {
> > +		free(repl_obj);
> > +		warning("bad replace ref name: %s", refname);
> > +	}
> > +
> > +	/* Copy sha1 from the read ref */
> > +	hashcpy(repl_obj->sha1[1], sha1);
>
> Upon an error, you free and warn and then still copy into it?

Ooops, I forgot a "return 0;" statement after the warning.

> > +	/* Register new object */
> > +	if (register_replace_object(repl_obj, 1))
> > +		warning("duplicate replace ref: %s", refname);
>
> I'd say this is a grave error and should be reported as a repository
> corruption.

If we let people have a set of replace refs in "refs/replace/" and anot=
her=20
one in "refs/replace/bisect/", and the latter one is used only when=20
bisecting, then it may happen that the same commit has one ref=20
in "refs/replace/" and another one in "refs/replace/bisect/". In this c=
ase=20
it should probably be considered as something we should not even warn o=
n,=20
and the replace ref in "refs/replace/bisect/" should be used when=20
bisecting.

But, as we don't have a mechanism to do that yet, you are right, we sho=
uld=20
probably "die" for now here.

> > +static void prepare_replace_object(void)
> > +{
> > +	static int replace_object_prepared;
> > +
> > +	if (replace_object_prepared)
> > +		return;
> > +
> > +	for_each_replace_ref(register_replace_ref, NULL);
> > +	replace_object_prepared =3D 1;
> > +}
> > +
> > +/* We allow "recursive" replacement. Only within reason, though */
> > +#define MAXREPLACEDEPTH 5
> > +
> > +const unsigned char *lookup_replace_object(const unsigned char *sh=
a1)
> > +{
> > +	int pos, depth =3D MAXREPLACEDEPTH;
> > +	const unsigned char *cur =3D sha1;
> > +
> > +	prepare_replace_object();
> > +
> > +	/* Try to recursively replace the object */
> > +	do {
> > +		if (--depth < 0)
> > +			die("replace depth too high for object %s",
> > +			    sha1_to_hex(sha1));
> > +
> > +		pos =3D replace_object_pos(cur);
> > +		if (0 <=3D pos)
> > +			cur =3D replace_object[pos]->sha1[1];
> > +	} while (0 <=3D pos);
> > +
> > +	return cur;
> > +}
>
> Since your paradigm is prepare replacement once at the beginning, nev=
er
> allowing to update it, I think you can update the table while you loo=
k it
> up.  E.g. if A->B and B->C exists, and A is asked for, you find A->B =
(to
> tentatively make cur to point at B) and then you find B->C, and befor=
e
> returning you can rewrite the first mapping to A->C.  Later look-up w=
on't
> need to dereference the table twice that way.
>
> This assumes that there will be small number of replacements, but the
> same object can be asked for more than once during the process.

If we allow different sets of replace refs, for example A->B=20
in "refs/replace/" and B->C in "refs/replace/bisect/", then we cannot=20
rewrite as you suggest. We could add A->C in "refs/replace/bisect/", so=
=20
that it overcomes A->B and B->C when we bisect, but we would not gain m=
uch.

So I prefer not to do that right now. Maybe later if we decide we reall=
y=20
don't want to allow different sets of replace refs, we can do what you=20
suggest.=20

> > diff --git a/sha1_file.c b/sha1_file.c
> > index f08493f..4f2fd10 100644
> > --- a/sha1_file.c
> > +++ b/sha1_file.c
> > @@ -2163,10 +2163,18 @@ static void *read_object(const unsigned cha=
r
> > *sha1, enum object_type *type, void *read_sha1_file(const unsigned =
char
> > *sha1, enum object_type *type, unsigned long *size)
> >  {
> > -	void *data =3D read_object(sha1, type, size);
> > +	const unsigned char *repl =3D lookup_replace_object(sha1);
> > +	void *data =3D read_object(repl, type, size);
> > +
> > +	/* die if we replaced an object with one that does not exist */
> > +	if (!data && repl !=3D sha1)
> > +		die("replacement %s not found for %s",
> > +		    sha1_to_hex(repl), sha1_to_hex(sha1));
> > +
> >  	/* legacy behavior is to die on corrupted objects */
> > -	if (!data && (has_loose_object(sha1) || has_packed_and_bad(sha1))=
)
> > -		die("object %s is corrupted", sha1_to_hex(sha1));
> > +	if (!data && (has_loose_object(repl) || has_packed_and_bad(repl))=
)
> > +		die("object %s is corrupted", sha1_to_hex(repl));
> > +
> >  	return data;
> >  }
>
> Later we'd need a global switch to forbid the replacement for
> connectivity walkers,=20

Yeah, I am slowly working on it. My next series (hopefully in a few day=
s)=20
where the above errors are fixed will include it.

> but other than that I think this is sane.=20
>
> I also looked at 1/ and 2/ which looked Ok.

Thanks,
Christian.
