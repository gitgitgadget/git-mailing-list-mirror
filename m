Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0F82209FA
	for <e@80x24.org>; Wed, 12 Apr 2017 03:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752057AbdDLDML (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 23:12:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52979 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751686AbdDLDMK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 23:12:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26E3B71683;
        Tue, 11 Apr 2017 23:12:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7pKLDYs+XpMZHw46rAhqKedkfiA=; b=GNsAgQ
        BvmphVyYmvacS/UXQczZYUG+TTBARgDHXRfOyiqI+mKCqA9G7E+YJ00gHLJmAOqr
        vkX/r/FX8YC1lg6JvMJGXB9veWMqi818Mg6f+g1ENv1qc09qwBbz9XYPeVOuvBWe
        d+PkQGiPThsgu/DaVxwC7N45RTM8Q2JmAkGoc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k2LKnhNLN5vQzg2duyOwCOi6UOD2Yf/u
        B4XsqmvkrLn27iLkJjYfRKLgi2NCgbmWA+U3Djm786ploRC5iZe5RWEH4dHOBPag
        lE0uczdQDkJkl08LkyQas6A40xedVDxkX6xkfOBDLpv+zGv/4XSwRc8Qfba7qjwj
        LYdv4secJ8o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1EF8571682;
        Tue, 11 Apr 2017 23:12:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8681B71680;
        Tue, 11 Apr 2017 23:12:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v9 3/3] read-cache: speed up add_index_entry during checkout
References: <20170411191702.20134-1-git@jeffhostetler.com>
        <20170411191702.20134-4-git@jeffhostetler.com>
Date:   Tue, 11 Apr 2017 20:12:07 -0700
In-Reply-To: <20170411191702.20134-4-git@jeffhostetler.com>
        (git@jeffhostetler.com's message of "Tue, 11 Apr 2017 19:17:02 +0000")
Message-ID: <xmqq37deqpyw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D03B7990-1F2D-11E7-9336-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git@jeffhostetler.com writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Teach add_index_entry_with_check() and has_dir_name()
> to see if the path of the new item is greater than the
> last path in the index array before attempting to search
> for it.
>
> During checkout, merge_working_tree() populates the new
> index in sorted order, so this change will save at least 2
> binary lookups per file.

Smart and simple.

> diff --git a/read-cache.c b/read-cache.c
> index 97f13a1..a8ef823 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -918,9 +918,24 @@ static int has_dir_name(struct index_state *istate,
>  	int stage = ce_stage(ce);
>  	const char *name = ce->name;
>  	const char *slash = name + ce_namelen(ce);
> +	size_t len_eq_last;
> +	int cmp_last = 0;
> +
> +	if (istate->cache_nr > 0) {
> +		/*
> +		 * Compare the entry's full path with the last path in the index.
> +		 * If it sorts AFTER the last entry in the index and they have no
> +		 * common prefix, then there cannot be any F/D name conflicts.
> +		 */
> +		cmp_last = strcmp_offset(name,
> +			istate->cache[istate->cache_nr-1]->name,

Style?  "istate->cache[istate->cache_nr - 1]->name"

> +			&len_eq_last);
> +		if (cmp_last > 0 && len_eq_last == 0)
> +			return retval;
> +	}

Let me follow the logic aloud.  Say the last entry in the cache is
"x/y".  If we came here with ce->name == "x", we need to worry about
nuking the existing entry "x/y".  But if we have "zoo", that cannot
possibly overlap and we can safely return 0.

That sounds correct, except that it might be playing overly safe.
If we came here with "xx", we still are safe, but len_eq_last would
be non-zero.  Probably it is not worth the extra complexity to catch
it here (rather than letting the loop below to handle it).

>  	for (;;) {
> -		int len;
> +		size_t len;
>  
>  		for (;;) {
>  			if (*--slash == '/')
> @@ -930,6 +945,24 @@ static int has_dir_name(struct index_state *istate,
>  		}
>  		len = slash - name;

Mental note: cmp_last may be 0, >0 or <0 at this point in the very
first iteration of the loop.  It is not updated in the loop.  The
variable len_eq_last are used to carry the information about the
last entry we learned at the beginning of this function---the new
special case happens only when the path we are adding sorts later
than the last existing entry (i.e. cmp_last > 0).

> +		if (cmp_last > 0) {
> +			/*
> +			 * If this part of the directory prefix (including the trailing
> +			 * slash) already appears in the path of the last entry in the
> +			 * index, then we cannot also have a file with this prefix (or
> +			 * any parent directory prefix).
> +			 */
> +			if (len+1 <= len_eq_last)

Style?  "len + 1".

> +				return retval;
> +			/*
> +			 * If this part of the directory prefix (excluding the trailing
> +			 * slash) is longer than the known equal portions, then this part
> +			 * of the prefix cannot collide with a file.  Go on to the parent.
> +			 */
> +			if (len > len_eq_last)
> +				continue;

Hmph, is the reasoning used in the two conditionals above sound?
Does this work correctly even when the last existing entry in the
cache is marked with CE_REMOVE?

> +		}
> +
>  		pos = index_name_stage_pos(istate, name, len, stage);
>  		if (pos >= 0) {
>  			/*
> @@ -1021,7 +1054,16 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
>  
>  	if (!(option & ADD_CACHE_KEEP_CACHE_TREE))
>  		cache_tree_invalidate_path(istate, ce->name);
> -	pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce));
> +
> +	/*
> +	 * If this entry's path sorts after the last entry in the index,
> +	 * we can avoid searching for it.
> +	 */
> +	if (istate->cache_nr > 0 &&
> +		strcmp(ce->name, istate->cache[istate->cache_nr - 1]->name) > 0)
> +		pos = -istate->cache_nr - 1;
> +	else
> +		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce));

This one (unlike the change to has_dir_name()) is trivially and
obviously correct.

>  	/* existing match? Just replace it. */
>  	if (pos >= 0) {
