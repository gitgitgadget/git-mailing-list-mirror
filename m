From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] merge: fix cache_entry use-after-free
Date: Thu, 08 Oct 2015 13:00:53 -0700
Message-ID: <xmqqmvvtqgei.fsf@gitster.mtv.corp.google.com>
References: <1444330071-8909-1-git-send-email-dturner@twitter.com>
	<1444330071-8909-2-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Keith McGuigan <kmcguigan@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 22:09:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkHNP-00071n-Er
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 22:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755894AbbJHUA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 16:00:56 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34577 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653AbbJHUAz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 16:00:55 -0400
Received: by padhy16 with SMTP id hy16so63457271pad.1
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 13:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=XiRGXZrVVdlWy1V1fflh7C6V7J3jPOO4jVfxdy0q0ks=;
        b=TrsjTi67GfBopwZLLSv7XimWw+NrmKeO9guGSyM0PK085fW/YCLI3R2SfN+IyJWJ+/
         VHpjsV8isrnxROC+4zqqaXbMDNPzeO6FIrwRzDvXEHzqsFYO8Ym7TV3MEcwtdJL3EWHR
         h7n7t31bes3uqPu34/X4ncjt38/kxh3f6VpyitxLr4ag4os+kLHrckf1g6dySs3EXti6
         3688HnLRz5TKi6EjUdZnpgOQISKog6sUhGv35sZGnnqgKwHKRDMSSLVxjrUerF5/6XzS
         rgflkExjLJS9SljbW/bGmwtqOS0H3VLJC0eawxLYDl8BE3wTCZYN1IS+jTZMk2GGlb7x
         CoDA==
X-Received: by 10.66.142.202 with SMTP id ry10mr10315167pab.86.1444334454738;
        Thu, 08 Oct 2015 13:00:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:8f0:649c:42a6:426d])
        by smtp.gmail.com with ESMTPSA id lo9sm17789099pab.19.2015.10.08.13.00.53
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 08 Oct 2015 13:00:54 -0700 (PDT)
In-Reply-To: <1444330071-8909-2-git-send-email-dturner@twitter.com> (David
	Turner's message of "Thu, 8 Oct 2015 14:47:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279272>

David Turner <dturner@twopensource.com> writes:

> From: Keith McGuigan <kmcguigan@twitter.com>
>
> During merges, we would previously free entries that we no longer need
> in the destination index.  But those entries might also be stored in
> the dir_entry cache, and when a later call to add_to_index found them,
> they would be used after being freed.
>
> To prevent this, add a ref count for struct cache_entry.  Whenever
> a cache entry is added to a data structure, the ref count is incremented;
> when it is removed from the data structure, it is decremented.  When
> it hits zero, the cache_entry is freed.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> Signed-off-by: Keith McGuigan <kmcguigan@twitter.com>
> ---

Thanks.

> @@ -213,6 +214,32 @@ struct cache_entry {
>  struct pathspec;
>  
>  /*
> + * Increment the cache_entry reference count.  Should be called
> + * whenever a pointer to a cache_entry is retained in a data structure,
> + * thus marking it as alive.
> + */
> +static inline void add_ce_ref(struct cache_entry *ce)
> +{
> +	assert(ce != NULL && ce->ref_count >= 0);
> +	++ce->ref_count;
> +}

We tend to prefer post-increment when the distinction between pre-
or post- does not make any difference, which is the case here.

> diff --git a/name-hash.c b/name-hash.c
> index 702cd05..f12c919 100644
> --- a/name-hash.c
> +++ b/name-hash.c
> @@ -92,7 +93,9 @@ static void remove_dir_entry(struct index_state *istate, struct cache_entry *ce)
>  	struct dir_entry *dir = hash_dir_entry(istate, ce, ce_namelen(ce));
>  	while (dir && !(--dir->nr)) {
>  		struct dir_entry *parent = dir->parent;
> -		hashmap_remove(&istate->dir_hash, dir, NULL);
> +		struct dir_entry *removed = hashmap_remove(&istate->dir_hash, dir, NULL);
> +		assert(removed == dir);
> +		drop_ce_ref(dir->ce);

This is curious.  In remove_name_hash() you do not have the
corresponding assert.  Why is it necessary here (or is it
unnecessary over there)?

> @@ -147,6 +151,7 @@ void remove_name_hash(struct index_state *istate, struct cache_entry *ce)
>  		return;
>  	ce->ce_flags &= ~CE_HASHED;
>  	hashmap_remove(&istate->name_hash, ce, ce);
> +	drop_ce_ref(ce);
>  
>  	if (ignore_case)
>  		remove_dir_entry(istate, ce);
> diff --git a/read-cache.c b/read-cache.c
> index 87204a5..442de34 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -53,6 +53,7 @@ static const char *alternate_index_output;
>  static void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
>  {
>  	istate->cache[nr] = ce;
> +	add_ce_ref(ce);
>  	add_name_hash(istate, ce);
>  }

What happens to the existing entry that used to be istate->cache[nr],
which may or may not be 'ce' that is replacing it?

It turns out that all three calling sites are safe, but it is not
immediately obvious why.  Perhaps some comment in front of the
function is in order, to warn those who may have to add a new caller
or restructure the existing calling chain, that istate->cache[nr] is
expected not to hold a live reference when the function is called,
or something?

> @@ -314,8 +314,10 @@ void replace_index_entry_in_base(struct index_state *istate,
>  	    istate->split_index->base &&
>  	    old->index <= istate->split_index->base->cache_nr) {
>  		new->index = old->index;
> -		if (old != istate->split_index->base->cache[new->index - 1])
> -			free(istate->split_index->base->cache[new->index - 1]);
> +		if (old != istate->split_index->base->cache[new->index - 1]) {
> +			struct cache_entry *ce = istate->split_index->base->cache[new->index - 1];
> +			drop_ce_ref(ce);
> +		}
>  		istate->split_index->base->cache[new->index - 1] = new;

Does 'new' already have the right refcount at this point?
