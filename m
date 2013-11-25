From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 08/28] shallow.c: add mark_new_shallow_refs()
Date: Mon, 25 Nov 2013 14:20:58 -0800
Message-ID: <xmqqli0cw2b9.fsf@gitster.dls.corp.google.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
	<1385351754-9954-9-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 25 23:21:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl4Wk-00009D-4V
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 23:21:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625Ab3KYWVH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Nov 2013 17:21:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55570 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910Ab3KYWVC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Nov 2013 17:21:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02C3153235;
	Mon, 25 Nov 2013 17:21:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=dz8Na0VKWLuV
	5eTT2TSPiUt2QIc=; b=NN3nE6KnezpWSqhlrt1Wdit4HvJbTPYWOb907cP+yYQa
	Xn3WavAOJy5nm3vi8xV1FoNaZaVD5PxawDZyxdoYjCHeDKS82s73MA4vSiM6dB4M
	INbPsbbpGrh89dCwVesDa8sR7XKpLJioeDUKBLvvSM/dp6gltqwSnr+KVJI8Lrw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=aKwVEN
	svkhGeWiujfiwD85puUr7tSX/p0F0yx2PiT/A8xY6Rz8CDjGz/508Y1aQeMyjmuD
	NX+lhb4aj76Ythu9mdDMp6Iw9OeT1Syy6UogRKxfZ2LUl2aTFXriPfekQ2Jll5FP
	vcmWv8a3clFVYKRKqB/A5VGrCFr0/FuHOcAxs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE28E53231;
	Mon, 25 Nov 2013 17:21:01 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA60C53230;
	Mon, 25 Nov 2013 17:21:00 -0500 (EST)
In-Reply-To: <1385351754-9954-9-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 25
 Nov 2013 10:55:34 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DD667BCC-561F-11E3-B999-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238361>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> When we receive a pack and the shallow points from another repository=
,
> we may need to add more shallow points to current repo to make sure n=
o
> commits point to nowhere. But usually we don't want to do so because
> (in future) new shallow points invalidate pack bitmaps and we need to
> rebuild them again, which is not cheap.
>
> So the default way is we allow ref updates that do not introduce new
> shallow points and mark the others. If the user is fine with new
> shallow point addition, we accept the marked refs.
>
> But even so we do not blindly accept all shallow points provided. Som=
e
> of them might not point to any commits in the new pack. Some might
> even do, but those might be unreachable object islands. Only shallow
> points that are reachable from old and new refs can stay.
>
> The way it's implemented is paint down from each ref, attach a bitmap
> to each commit where one bit represents one ref. In order to avoid
> allocating new bitmap for every commit, we try to reuse the same
> bitmap for parent commits if possible. This reduces allocation and
> leaks deliberately because it's hard to keep/time consuming track how
> many pointers to the same buffer.
>
> In a typical push or fetch, the new pack should not carry new shallow
> roots. If the current repo does not have any commit islands refered b=
y
> the sender's shallow roots either, this function is just a few
> has_sha1_file(). So quite cheap.
>
> Once the sender diverts from that path (or the receiver detects
> shallow roots attached to commit islands from remove_reachable_shallo=
w_points),
> it'll be a lot more expensive. Pack bitmaps won't help this kind of
> commit traversal, but commit cache might.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  commit.h  |   4 ++
>  shallow.c | 219 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>  2 files changed, 223 insertions(+)

Hmph.  the use of ->util field in this patch feels that it was
something commit-slab data structure was invented to solve.


> diff --git a/shallow.c b/shallow.c
> index a974d2d..c92a1dc 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -4,6 +4,8 @@
>  #include "pkt-line.h"
>  #include "remote.h"
>  #include "refs.h"
> +#include "diff.h"
> +#include "revision.h"
> =20
>  static int is_shallow =3D -1;
>  static struct stat shallow_stat;
> @@ -280,3 +282,220 @@ void remove_reachable_shallow_points(struct ext=
ra_have_objects *out,
>  	}
>  	free(ca.commits);
>  }
> +
> +static int paint_down(const unsigned char *sha1, int id, int nr_bits=
, int quick)
> +{
> +	int hit_bottom =3D 0;
> +	unsigned int i, nr;
> +	struct commit_list *head =3D NULL;
> +	int bitmap_nr =3D (nr_bits + 31) / 32;
> +	int bitmap_size =3D bitmap_nr * sizeof(uint32_t);
> +	uint32_t *tmp =3D xmalloc(bitmap_size);
> +	uint32_t *bitmap =3D xcalloc(bitmap_size, sizeof(uint32_t));
> +	bitmap[id / 32] |=3D (1 << (id % 32));
> +	commit_list_insert(lookup_commit(sha1), &head);
> +	while (head) {
> +		struct commit_list *p;
> +		struct commit *c =3D head->item;
> +		uint32_t *c_util =3D c->util;
> +
> +		p =3D head;
> +		head =3D head->next;
> +		free(p);
> +
> +		if (c->object.flags & (SEEN | UNINTERESTING))
> +			continue;
> +		else
> +			c->object.flags |=3D SEEN;
> +
> +		if (c->util =3D=3D NULL)
> +			c->util =3D bitmap;
> +		else {
> +			/*
> +			 * Deliberately leak a lot in commit->util
> +			 * because there can be many pointers to the
> +			 * same bitmap. Probably should allocate in a
> +			 * pool and free the whole pool at the end.
> +			 */

=2E.. or perhaps make the bitmap into

	struct {
	        int refcnt;
        	uint32_t bits[FLEX_ARRAY];
	}

and refcnt them?


> +			memcpy(tmp, c_util, bitmap_size);
> +			for (i =3D 0; i < bitmap_nr; i++)
> +				tmp[i] |=3D bitmap[i];
> +			if (memcmp(tmp, c_util, bitmap_size)) {
> +				c->util =3D xmalloc(bitmap_size);
> +				memcpy(c->util, tmp, bitmap_size);
> +			}
> +		}
> +
> +		if (c->object.flags & BOTTOM) {
> +			hit_bottom =3D 1;
> +			if (quick) {
> +				free_commit_list(head);
> +				break;
> +			} else
> +				continue;
> +		}
> +
> +		if (parse_commit(c))
> +			die("unable to parse commit %s",
> +			    sha1_to_hex(c->object.sha1));
> +
> +		for (p =3D c->parents; p; p =3D p->next) {
> +			if (p->item->object.flags & SEEN)
> +				continue;
> +			if (p->item->util =3D=3D NULL || p->item->util =3D=3D c_util)
> +				p->item->util =3D c->util;
> +			commit_list_insert(p->item, &head);
> +		}
> +	}
> +
> +	nr =3D get_max_object_index();
> +	for (i =3D 0; i < nr; i++) {
> +		struct object *o =3D get_indexed_object(i);
> +		if (o && o->type =3D=3D OBJ_COMMIT) {
> +			o->flags &=3D ~SEEN;
> +		}
> +	}
> +
> +	free(tmp);
> +	return hit_bottom;
> +}
> +
> +static int mark_uninteresting(const char *refname,
> +			      const unsigned char *sha1,
> +			      int flags, void *cb_data)
> +{
> +	struct commit *commit =3D lookup_commit(sha1);
> +	commit->object.flags |=3D UNINTERESTING;
> +	mark_parents_uninteresting(commit);
> +	return 0;
> +}
> +
> +struct saved_util {
> +	unsigned char sha1[20];
> +	void *util;
> +};
> +
> +/*
> + * Given a set of refs and shallow roots, find out what ref can reac=
h
> + * any of the given roots. If so mark that ref "reject_flag". If
> + * "used" is not NULL, mark all reachable roots. Return how many ref=
s
> + * that need new shallow points.
> + */
> +int mark_new_shallow_refs(const struct extra_have_objects *ref,
> +			  int *ref_status, uint32_t **used,
> +			  const struct extra_have_objects *shallow)
> +{
> +	struct saved_util *util =3D NULL;
> +	unsigned int i, nr, ret =3D 0, nr_util =3D 0, alloc_util =3D 0;
> +
> +	/*
> +	 * Quick check to see if we may need to add new shallow
> +	 * roots. Go through the list of root candidates and check if
> +	 * they exist (either in current repo, or in the new pack, we
> +	 * can't distinguish).
> +	 *
> +	 * 1) If none of the new roots exist, the pack must connect to
> +	 *    the main object graph, which is already guarded by
> +	 *    current repo's shallow roots and we will not need to
> +	 *    consider adding new shallow roots, so we can exit early.
> +	 *
> +	 * 2) The pack may connect to some existing object islands in
> +	 *    current repo then add shallow roots to plug loose ends
> +	 *    from those islands. In that case, new shallow roots must
> +	 *    also exist in the repo as this stage (old objects plus
> +	 *    the new pack).
> +	 *
> +	 * 3) The last, easiest case, is the pack contains some
> +	 *    shallow roots, which may be used to tie up loose ends of
> +	 *    some new refs, or redundanty (tying up loose ends of new
> +	 *    object islands)
> +	 */
> +	for (i =3D 0;i < shallow->nr; i++)
> +		if (has_sha1_file(shallow->array[i]))
> +			break;
> +	if (i =3D=3D shallow->nr)
> +		/*
> +		 * this is the first and also the common case, where
> +		 * the new pack does not carry any new shallow
> +		 * points. No need to to the expensive commit traverse
> +		 * dance below.
> +		 */
> +		return 0;

I am Confused.

The loop only made sure that all the elements in the array[] is
still missing (or, ... is this function supposed to be called before
installing a new pack???  It is unclear.  But if new objects were
unpacked while receiving, then there is no "not install the new
objects and check" possible, so I'd assume this is called after
receiving and registering a new pack to the object store).

But then, can it be that you had N-1 "shallow points" originally,
the pack has a reference to a new missing commit, and the array has
N "shallow points" in total?  Or is the caller expected to call this
function with shallow pointing at a pre-transfer shallow points?

> +	/*
> +	 * Prepare the commit graph to track what refs can reach what
> +	 * (new) shallow points.
> +	 */
> +	nr =3D get_max_object_index();

Hmph. At this point (again, there is no description on where in the
overall sequence of events this function is designed to be called,
so it is impossible to review the logic), is it expected that we
have seen all the objects under the sun and marked them in a
specific way?

> +	for (i =3D 0; i < nr; i++) {
> +		struct object *o =3D get_indexed_object(i);
> +		struct commit *c =3D (struct commit *)o;
> +		if (!o || o->type !=3D OBJ_COMMIT)
> +			continue;
> +
> +		o->flags &=3D ~(UNINTERESTING | BOTTOM | SEEN);
> +		/*
> +		 * git-fetch makes use of "util" field. Save it and
> +		 * restore later. For fetch/clone/push, "nr" should be
> +		 * small because rev-list is delayed to pack-objects.
> +		 */
> +		if (c->util) {
> +			ALLOC_GROW(util, nr_util+1, alloc_util);
> +			hashcpy(util[nr_util].sha1, o->sha1);
> +			util[nr_util].util =3D c->util;
> +			nr_util++;
> +			c->util =3D NULL;
> +		}
> +	}
> +
> +	/*
> +	 * "--not --all" to cut short the traversal if new refs
> +	 * connect to old refs. If not (e.g. force ref updates) it'll
> +	 * have to go down to the current shallow roots.
> +	 *
> +	 * We could detect that a new commit is connected to an
> +	 * existing commit by keeping new objects in a pack (i.e. the
> +	 * index-pack code path) then check commit origin. If so stop
> +	 * short, so we don't need to get to the bottom. But then it
> +	 * will not work for case #2 because we need to go through
> +	 * some of our commits before reaching new shallow roots.
> +	 */
> +	head_ref(mark_uninteresting, NULL);
> +	for_each_ref(mark_uninteresting, NULL);
> +
> +	for (i =3D 0; i < shallow->nr; i++)
> +		if (has_sha1_file(shallow->array[i])) {
> +			struct commit *c =3D lookup_commit(shallow->array[i]);
> +			c->object.flags |=3D BOTTOM;
> +		}
> +
> +	for (i =3D 0; i < ref->nr; i++)
> +		if (paint_down(ref->array[i], i, ref->nr, used =3D=3D NULL)) {
> +			if (ref_status)
> +				ref_status[i] =3D 1;
> +			ret++;
> +		}
> +
> +	if (used) {
> +		for (i =3D 0; i < shallow->nr; i++) {
> +			struct commit *c =3D lookup_commit(shallow->array[i]);
> +			used[i] =3D c->util;
> +		}
> +	}
> +
> +	if (nr_util) {
> +		nr =3D get_max_object_index();
> +		for (i =3D 0; i < nr; i++) {
> +			struct object *o =3D get_indexed_object(i);
> +			if (o && o->type =3D=3D OBJ_COMMIT)
> +				((struct commit *)o)->util =3D NULL;
> +		}
> +		for (i =3D 0; i < nr_util; i++) {
> +			struct commit *c =3D lookup_commit(util[i].sha1);
> +			c->util =3D util[i].util;
> +		}
> +		free(util);
> +	}
> +
> +	return ret;
> +}
