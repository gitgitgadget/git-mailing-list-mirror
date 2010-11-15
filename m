From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 02/10] unpack-trees: move all skip-worktree check back to
 unpack_trees()
Date: Mon, 15 Nov 2010 10:01:35 -0600
Message-ID: <20101115160135.GA16385@burratino>
References: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
 <1289817410-32470-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 15 17:02:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI1Vh-0006EK-8N
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 17:02:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757903Ab0KOQCR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 11:02:17 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:49946 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757900Ab0KOQCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 11:02:16 -0500
Received: by qyk12 with SMTP id 12so3860409qyk.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 08:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=9KMi9F3j+bI1VlQtZXUZbRW1BurM3QOIclffDFDQs3I=;
        b=b+5pw1HGMbNtzZFHANG6WAYMrmt5FBubQ47XBHmjsKPHqYy8toPUH2Ujtv46wqj6hn
         IWWI8yuVx5aPU7IwkpsE9fHCLcXnHTi9ZgIlLTEcmxa6TGGycIOgrm8WXruas9aaLz3s
         BjEWuleUnWqZW9Wmd80Xs4nWXnDb011bJD9zw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=dzV6yAcicxzOgF8EB9kuZJg0R8xyWCVrQYoQsRU3VRM0ZgEps9ADOLmm5No0ukmOQc
         u+ZgbRu43G+RcYKATrGsFcdQ7A3jBTK4hWfBrhpw5AT6ckYPYinLE6S0009rJDag8gSD
         6KedReoA0Ke9rEMK4kK5bb8HEOwkA6/iP58Zg=
Received: by 10.224.89.4 with SMTP id c4mr5391438qam.69.1289836935761;
        Mon, 15 Nov 2010 08:02:15 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id n7sm66760qcu.16.2010.11.15.08.02.12
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 08:02:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1289817410-32470-3-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161491>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Earlier, the will_have_skip_worktree() checks are done in various pla=
ces:
>=20
> 1. in verify_* functions to prevent absent/uptodate checks outside
>    worktree
> 2. in merged_entry for new index entries
> 3. in apply_sparse_checkout() for all entries
>=20
> In case all entries are added new ($GIT_DIR/index is missing) all the
> above checks will be done for all entries, which in the worst case ca=
n
> become cache_nr*el->nr*3 fnmatch() calls. Quite expensive.

Does this mean something like:

	Handling of sparse checkouts is slow.

	[timings]

	To fix this, we will do such-and-such.  As a first step,
	we'll do such-and-such which does not change semantics
	and at least does not make it any slower.

?

In other words, any commit message should make clear

 1. The purpose.
 2. The baseline of (sane or insane) behavior that is affected.
 3. The intended resulting functionality.

How the patch works and why it succeeds are just optional extras
(nice, certainly, but in 90% of cases it is obvious from the code once
you know (1), (2), and (3) anyway).

> --- a/cache.h
> +++ b/cache.h
> @@ -182,6 +182,7 @@ struct cache_entry {
>  #define CE_WT_REMOVE (0x400000) /* remove in work directory */
> =20
>  #define CE_UNPACKED  (0x1000000)
> +#define CE_NEW_SKIP_WORKTREE (0x2000000)

Semantics?

> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -258,7 +258,7 @@ static int apply_sparse_checkout(struct cache_ent=
ry *ce, struct unpack_trees_opt
>  {
>  	int was_skip_worktree =3D ce_skip_worktree(ce);
> =20
> -	if (!ce_stage(ce) && will_have_skip_worktree(ce, o))
> +	if (ce->ce_flags & CE_NEW_SKIP_WORKTREE)
>  		ce->ce_flags |=3D CE_SKIP_WORKTREE;

So CE_NEW_SKIP_WORKTREE roughly means "stage-0 entry outside the sparse=
 checkout area"?

>  	else
>  		ce->ce_flags &=3D ~CE_SKIP_WORKTREE;

In particular, I guess the NEW part refers to the sparse checkout
area, not the entry, since existing index entries with SKIP_WORKTREE
bits need to keep that bit.

> @@ -834,6 +834,49 @@ static int unpack_callback(int n, unsigned long =
mask, unsigned long dirmask, str
>  	return mask;
>  }
> =20
> +static void set_new_skip_worktree_1(struct unpack_trees_options *o)
> +{

Will comment on name once we get to the call site.

> +	int i;
> +
> +	for (i =3D 0;i < o->src_index->cache_nr;i++) {
> +		struct cache_entry *ce =3D o->src_index->cache[i];
> +		ce->ce_flags &=3D ~CE_ADDED;
> +		if (!ce_stage(ce) && will_have_skip_worktree(ce, o))
> +			ce->ce_flags |=3D CE_NEW_SKIP_WORKTREE;
> +		else
> +			ce->ce_flags &=3D ~CE_NEW_SKIP_WORKTREE;
> +	}
> +}

Populating the CE_NEW_SKIP_WORKTREE flags based on the new
worktree area.

> +
> +static int verify_absent(struct cache_entry *, enum unpack_trees_err=
or_types, struct unpack_trees_options *);
> +static int set_new_skip_worktree_2(struct unpack_trees_options *o)
> +{
> +	int i;
> +
> +	/*
> +	 * CE_ADDED marks new index entries. These have not been processed
> +	 * by set_new_skip_worktree_1() so we do it here.
> +	 */

Probably this comment belongs at the call site instead, to avoid some
chasing.

> +	for (i =3D 0;i < o->result.cache_nr;i++) {
> +		struct cache_entry *ce =3D o->result.cache[i];
> +
> +		if (!(ce->ce_flags & CE_ADDED))
> +			continue;
> +
> +		ce->ce_flags &=3D ~CE_ADDED;
> +		if (!ce_stage(ce) && will_have_skip_worktree(ce, o))
> +			ce->ce_flags |=3D CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTREE;
> +		else
> +			ce->ce_flags &=3D ~(CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTREE);

CE_ADDED is private to the add_file_to_index() code path shared
between add and rerere builtins.  rerere is libified and used e.g. by
cherry-pick foo..bar.  Can it get us in trouble or do we have clear
the flags before using them here?  I think it would be worth a note in
api-in-core-index.txt to warn future refactorers.

> +
> +		/* Left-over checks from merged_entry when old =3D=3D NULL */

Huh?  (That is completely cryptic outside the context of the patch.)

> +		if (verify_absent(ce, ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o))
> +			return -1;
> +	}
[...]
> @@ -862,6 +905,9 @@ int unpack_trees(unsigned len, struct tree_desc *=
t, struct unpack_trees_options
>  			o->el =3D &el;
>  	}
> =20
> +	if (!o->skip_sparse_checkout)
> +		set_new_skip_worktree_1(o);
> +

Why is this not folded into the above if ()?

This populates the NEW_SKIP_WORKTREE (=3D future SKIP_WORKTREE?) bit
in the index that represents the preimage for a reset or merge.

Perhaps call it:

		set_new_skip_worktree(o->src_index, 0);

and mark that function __attribute__((always_inline)) if the
optimizer doesn't want to cooperate?

Or:

		set_src_skip_worktree(o);

>  	memset(&o->result, 0, sizeof(o->result));
>  	o->result.initialized =3D 1;
>  	o->result.timestamp.sec =3D o->src_index->timestamp.sec;
> @@ -922,6 +968,10 @@ int unpack_trees(unsigned len, struct tree_desc =
*t, struct unpack_trees_options
> =20
>  	if (!o->skip_sparse_checkout) {
>  		int empty_worktree =3D 1;
> +
> +		if (set_new_skip_worktree_2(o))
> +			goto return_failed;
> +

Trivial part of the merge is over.  So now we can check the new
index entries against the sparse worktree patterns.  They were added in
that trivial part using add_entry() and will have the CE_ADDED flag.

So this might be:

		set_new_skip_worktree(&o->result, CE_ADDED);

or

		set_result_skip_worktree(o);

The CE_ADDED flag was set in merged_entry, called by the merge_fn_t
implementations.  If there were an api-traverse-trees.txt explaining
the API, it would be worth a note there; for now it should suffice
to add a note to future merge_fn_t implementors in the commit
message ("each unpack-trees merge function arranges for
CE_SKIP_WORKTREE and CE_SKIP_NEW_WORKTREE to be propagated and for the
CE_ADDED flag to be set on entries of new paths").

>  		for (i =3D 0;i < o->result.cache_nr;i++) {
>  			struct cache_entry *ce =3D o->result.cache[i];
> =20
> @@ -1017,7 +1067,7 @@ static int verify_uptodate_1(struct cache_entry=
 *ce,
>  static int verify_uptodate(struct cache_entry *ce,
>  			   struct unpack_trees_options *o)
>  {
> -	if (!o->skip_sparse_checkout && will_have_skip_worktree(ce, o))
> +	if (!o->skip_sparse_checkout && (ce->ce_flags & CE_NEW_SKIP_WORKTRE=
E))
[...]
> @@ -1204,7 +1254,7 @@ static int verify_absent(struct cache_entry *ce=
,
>  			 enum unpack_trees_error_types error_type,
>  			 struct unpack_trees_options *o)
>  {
> -	if (!o->skip_sparse_checkout && will_have_skip_worktree(ce, o))
> +	if (!o->skip_sparse_checkout && (ce->ce_flags & CE_NEW_SKIP_WORKTRE=
E))

The point, I hope.  Currently we alternate between finding entries to
remove and deciding whether if lie in the worktree.  After this patch,
whether they lie in the worktree is precomputed.

> @@ -1226,10 +1276,15 @@ static int merged_entry(struct cache_entry *m=
erge, struct cache_entry *old,
>  	int update =3D CE_UPDATE;
> =20
>  	if (!old) {
> +		/*
> +		 * Set CE_NEW_SKIP_WORKTREE on "merge" to make
> +		 * verify_absent() no-op. The true check will be done
> +		 * later on in unpack_trees().
> +		 */
> +		merge->ce_flags |=3D CE_NEW_SKIP_WORKTREE;

Mm?  Since verify_absent() is a no-op, why call it?  This looks like a
placeholder for code that calls verify_absent later, when we know if
it lies in the worktree.

>  		if (verify_absent(merge, ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o=
))
>  			return -1;
> -		if (!o->skip_sparse_checkout && will_have_skip_worktree(merge, o))
> -			update |=3D CE_SKIP_WORKTREE;
> +		update |=3D CE_ADDED;

More of the main act.  Currently we alternate between finding entries
to add and deciding if they are in the worktree.  After the patch,
they are piled up for addition first, then checked against the
worktree in one batch.

>  		invalidate_ce_path(merge, o);
>  	} else if (!(old->ce_flags & CE_CONFLICTED)) {
>  		/*
> @@ -1245,8 +1300,8 @@ static int merged_entry(struct cache_entry *mer=
ge, struct cache_entry *old,
>  		} else {
>  			if (verify_uptodate(old, o))
>  				return -1;
> -			if (ce_skip_worktree(old))
> -				update |=3D CE_SKIP_WORKTREE;
> +			/* Migrate old bits over */
> +			update |=3D old->ce_flags & (CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKT=
REE);

Thanks, this looks promising.
Jonathan
