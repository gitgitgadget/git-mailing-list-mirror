From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's the difference between `git show branch:file | diff -u -
 file` vs `git diff branch file`?
Date: Mon, 29 Aug 2011 13:50:58 -0700
Message-ID: <7vliuc54ct.fsf@alter.siamese.dyndns.org>
References: <loom.20110823T091132-107@post.gmane.org>
 <CACsJy8DMqjMfb5wVMnsrZhP8yv2rF1wyQ6LM6b-PVcYY1SXkcQ@mail.gmail.com>
 <loom.20110829T155805-331@post.gmane.org>
 <CACsJy8Dar5i3Fn+rhOq78vdsqRL4D+RNUc5G64BM-6DvKC=L5w@mail.gmail.com>
 <7v1uw46srf.fsf@alter.siamese.dyndns.org>
 <7vty9054qr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 29 22:51:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy8nT-0005x0-KQ
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 22:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754816Ab1H2UvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 16:51:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55971 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754722Ab1H2UvB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 16:51:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A6E14FC6;
	Mon, 29 Aug 2011 16:51:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Amc1G5L38NgK5A14qG9JswFHYsE=; b=Myl7PO
	oh2Bj3PPN/xdUaj+dc9erFEineIBXF2SLhfBhRJ7PPqavpCSxLSvspJQoxVoKFr0
	VNNZDRDMfDqPq2CM6Q6uEyQh+f+iEwEfQFKoYS067NU2AEGQp0EaGrEsIBBGXWT1
	Dcxbo6e+wRwn1MGKqvLG1kuLHj53WmlJbc9ic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ijxODF+lYbf4qYzYl5ih6a10Y3z32hgx
	itD5i242IyPCRKQYvlwJoy1tcD7MP/ixKUXKs/ex6aHpUMAWlckeIcBkW6NypWCu
	0HZaPDvTuqJtSn7mY0bSR8QQldWIB0aHh1tILEj28mhCizF4G8bKOu+Imm1TEtwG
	x1mB7SfNgK0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6853A4FC5;
	Mon, 29 Aug 2011 16:51:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA9384FC4; Mon, 29 Aug 2011
 16:50:59 -0400 (EDT)
In-Reply-To: <7vty9054qr.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 29 Aug 2011 13:42:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 99AE33B8-D280-11E0-844E-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180349>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Of course the merge machinery does not know anything about pruning with
>> pathspec, so it is understandable (not justifiable) it would walk the full
>> tree.
>>
>> Will try to find time this week to cook up something.
>
> This is still rough, but seems to pass the test suite, and gives me some
> performance boost when applied to the kernel tree:

Ehh, no, the patch does not apply to the kernel tree, but I meant "when
used on the kernel tree".

>     (without patch)
>     $ time git diff --raw --cached v2.6.30 -- virt/kvm
>     real    0m0.114s
>     user    0m0.088s
>     sys     0m0.028s
>
>     (with patch)
>     $ time ./git diff --raw --cached v2.6.30 -- virt/kvm
>     real    0m0.075s
>     user    0m0.068s
>     sys     0m0.008s
>
> What I do not like about it most is that we have an infrastructure that
> links traverse_info across stackframes to store the paths unexpanded and
> without extra linear allocation, but tree_entry_interesting() wants the
> path as a single string. Hence unpack_trees() carries an extra baggage
> "base" string, even though the general callback in tree-walk machinery
> does not need it.
>
> I think this can be trivially optimized to keep a pointer to a single
> strbuf in the traverse_info (initialize it at the same points as this
> patch sets info.pathspec), extending it as it digs deeper (copy the same
> pointer to the strbuf to a child traverse_info and tuck the name of the
> directory it descends into it, at the same points as this patch copies
> info->pathspec from the parent), and resetting the length back when the
> traversal into a subdirectory comes back.
>
>
>
>  diff-lib.c     |    1 +
>  tree-walk.c    |   39 +++++++++++++++++++++++++++++++++------
>  tree-walk.h    |    1 +
>  unpack-trees.c |    2 ++
>  unpack-trees.h |    1 +
>  5 files changed, 38 insertions(+), 6 deletions(-)
>
> diff --git a/diff-lib.c b/diff-lib.c
> index f8454dd..ebe751e 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -468,6 +468,7 @@ static int diff_cache(struct rev_info *revs,
>  	opts.unpack_data = revs;
>  	opts.src_index = &the_index;
>  	opts.dst_index = NULL;
> +	opts.pathspec = &revs->diffopt.pathspec;
>  
>  	init_tree_desc(&t, tree->buffer, tree->size);
>  	return unpack_trees(1, &t, &opts);
> diff --git a/tree-walk.c b/tree-walk.c
> index 33f749e..808bb55 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -309,6 +309,18 @@ static void free_extended_entry(struct tree_desc_x *t)
>  	}
>  }
>  
> +static inline int prune_traversal(struct name_entry *e,
> +				  struct traverse_info *info,
> +				  struct strbuf *base,
> +				  int still_interesting)
> +{
> +	if (!info->pathspec || still_interesting == 2)
> +		return 2;
> +	if (still_interesting < 0)
> +		return still_interesting;
> +	return tree_entry_interesting(e, base, 0, info->pathspec);
> +}
> +
>  int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
>  {
>  	int ret = 0;
> @@ -316,10 +328,18 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
>  	struct name_entry *entry = xmalloc(n*sizeof(*entry));
>  	int i;
>  	struct tree_desc_x *tx = xcalloc(n, sizeof(*tx));
> +	struct strbuf base = STRBUF_INIT;
> +	int interesting = 1;
>  
>  	for (i = 0; i < n; i++)
>  		tx[i].d = t[i];
>  
> +	if (info->prev) {
> +		strbuf_grow(&base, info->pathlen);
> +		make_traverse_path(base.buf, info->prev, &info->name);
> +		base.buf[info->pathlen-1] = '/';
> +		strbuf_setlen(&base, info->pathlen);
> +	}
>  	for (;;) {
>  		unsigned long mask, dirmask;
>  		const char *first = NULL;
> @@ -376,16 +396,22 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
>  			mask |= 1ul << i;
>  			if (S_ISDIR(entry[i].mode))
>  				dirmask |= 1ul << i;
> +			e = &entry[i];
>  		}
>  		if (!mask)
>  			break;
> -		ret = info->fn(n, mask, dirmask, entry, info);
> -		if (ret < 0) {
> -			error = ret;
> -			if (!info->show_all_errors)
> -				break;
> +		interesting = prune_traversal(e, info, &base, interesting);
> +		if (interesting < 0)
> +			break;
> +		if (interesting) {
> +			ret = info->fn(n, mask, dirmask, entry, info);
> +			if (ret < 0) {
> +				error = ret;
> +				if (!info->show_all_errors)
> +					break;
> +			}
> +			mask &= ret;
>  		}
> -		mask &= ret;
>  		ret = 0;
>  		for (i = 0; i < n; i++)
>  			if (mask & (1ul << i))
> @@ -395,6 +421,7 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
>  	for (i = 0; i < n; i++)
>  		free_extended_entry(tx + i);
>  	free(tx);
> +	strbuf_release(&base);
>  	return error;
>  }
>  
> diff --git a/tree-walk.h b/tree-walk.h
> index 39524b7..0089581 100644
> --- a/tree-walk.h
> +++ b/tree-walk.h
> @@ -44,6 +44,7 @@ struct traverse_info {
>  	struct traverse_info *prev;
>  	struct name_entry name;
>  	int pathlen;
> +	struct pathspec *pathspec;
>  
>  	unsigned long conflicts;
>  	traverse_callback_t fn;
> diff --git a/unpack-trees.c b/unpack-trees.c
> index cc616c3..670b464 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -444,6 +444,7 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
>  
>  	newinfo = *info;
>  	newinfo.prev = info;
> +	newinfo.pathspec = info->pathspec;
>  	newinfo.name = *p;
>  	newinfo.pathlen += tree_entry_len(p->path, p->sha1) + 1;
>  	newinfo.conflicts |= df_conflicts;
> @@ -1040,6 +1041,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>  		info.fn = unpack_callback;
>  		info.data = o;
>  		info.show_all_errors = o->show_all_errors;
> +		info.pathspec = o->pathspec;
>  
>  		if (o->prefix) {
>  			/*
> diff --git a/unpack-trees.h b/unpack-trees.h
> index 7998948..5e432f5 100644
> --- a/unpack-trees.h
> +++ b/unpack-trees.h
> @@ -52,6 +52,7 @@ struct unpack_trees_options {
>  	const char *prefix;
>  	int cache_bottom;
>  	struct dir_struct *dir;
> +	struct pathspec *pathspec;
>  	merge_fn_t fn;
>  	const char *msgs[NB_UNPACK_TREES_ERROR_TYPES];
>  	/*
