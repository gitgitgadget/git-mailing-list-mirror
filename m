Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E0EC00A89
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 21:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF93420731
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 21:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ew32SOfP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgJ3V6e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 17:58:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59792 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgJ3V6e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 17:58:34 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8E1E0EDE78;
        Fri, 30 Oct 2020 17:58:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XP/XF25qTDj5EuOjRMkBkhr2TfA=; b=ew32SO
        fPimobC4C0TaBPY1E0/jys6zzvXvsPkseM8paWProcO/68pBqmebpCEdxyDcaf6s
        BQeILR3yw3y++5Foi1MTdKasI2LdKvyUS5FmX60z1b3g4CR9AhtYky11r+sl2Rh7
        PlFhnza7va0o1DCgu7hkSVa9pbMOgZ4TjijAA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PrCwOSXuiIN65PlBiuTCHd6Zcc2c0lBE
        o50iuJGxkV1XFTVy+5J3AGlBHvXhSDJmN2syQU3ZXM48VGvBKlfYs9yYzBxusXta
        4TdfD2+oThRDFpWsic5DsOzdSObuP19ZhTrjffd2QTJ8N6ywgjupnu2oxQgHLzD4
        9YGwaCPZH5I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 867D0EDE77;
        Fri, 30 Oct 2020 17:58:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C66ECEDE71;
        Fri, 30 Oct 2020 17:58:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, git@jeffhostetler.com,
        chriscool@tuxfamily.org, peff@peff.net, newren@gmail.com,
        jrnieder@gmail.com, martin.agren@gmail.com
Subject: Re: [PATCH v3 08/19] entry: move conv_attrs lookup up to
 checkout_entry()
References: <cover.1603937110.git.matheus.bernardino@usp.br>
        <81e03baab1dd7e28262e1d721eac1646c5908b5a.1603937110.git.matheus.bernardino@usp.br>
Date:   Fri, 30 Oct 2020 14:58:28 -0700
In-Reply-To: <81e03baab1dd7e28262e1d721eac1646c5908b5a.1603937110.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Wed, 28 Oct 2020 23:14:45 -0300")
Message-ID: <xmqqft5v5qbf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B93FDC4-1AFB-11EB-9E28-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> +/* Note: ca is used (and required) iff the entry refers to a regular file. */

This reflects how the current code happens to work, and it is
unlikely to change (in other words, I offhand do not think of a
reason why attributes may affect checking out a symlink or a
submodule), so that's probably OK.  I mention this specifically
because ...

> +static int write_entry(struct cache_entry *ce, char *path, struct conv_attrs *ca,
> +		       const struct checkout *state, int to_tempfile)
>  {
>  	unsigned int ce_mode_s_ifmt = ce->ce_mode & S_IFMT;
>  	struct delayed_checkout *dco = state->delayed_checkout;
> @@ -281,8 +282,7 @@ static int write_entry(struct cache_entry *ce,
>  	clone_checkout_metadata(&meta, &state->meta, &ce->oid);
>  
>  	if (ce_mode_s_ifmt == S_IFREG) {
> -		struct stream_filter *filter = get_stream_filter(state->istate, ce->name,
> -								 &ce->oid);
> +		struct stream_filter *filter = get_stream_filter_ca(ca, &ce->oid);
>  		if (filter &&
>  		    !streaming_write_entry(ce, path, filter,
>  					   state, to_tempfile,
> @@ -329,14 +329,17 @@ static int write_entry(struct cache_entry *ce,
>  		 * Convert from git internal format to working tree format
>  		 */
>  		if (dco && dco->state != CE_NO_DELAY) {
> -			ret = async_convert_to_working_tree(state->istate, ce->name, new_blob,
> -							    size, &buf, &meta, dco);
> +			ret = async_convert_to_working_tree_ca(ca, ce->name,
> +							       new_blob, size,
> +							       &buf, &meta, dco);
>  			if (ret && string_list_has_string(&dco->paths, ce->name)) {
>  				free(new_blob);
>  				goto delayed;
>  			}
> -		} else
> -			ret = convert_to_working_tree(state->istate, ce->name, new_blob, size, &buf, &meta);
> +		} else {
> +			ret = convert_to_working_tree_ca(ca, ce->name, new_blob,
> +							 size, &buf, &meta);
> +		}
>  
>  		if (ret) {
>  			free(new_blob);
> @@ -442,6 +445,7 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state,
>  {
>  	static struct strbuf path = STRBUF_INIT;
>  	struct stat st;
> +	struct conv_attrs ca;
>  
>  	if (ce->ce_flags & CE_WT_REMOVE) {
>  		if (topath)
> @@ -454,8 +458,13 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state,
>  		return 0;
>  	}
>  
> -	if (topath)
> -		return write_entry(ce, topath, state, 1);
> +	if (topath) {
> +		if (S_ISREG(ce->ce_mode)) {
> +			convert_attrs(state->istate, &ca, ce->name);
> +			return write_entry(ce, topath, &ca, state, 1);
> +		}
> +		return write_entry(ce, topath, NULL, state, 1);
> +	}

... it looked somewhat upside-down at the first glance that we
decide if lower level routines are allowed to use the ca at this
high level in the callchain.  But it is the point of this change
to lift the point to make the decision to use attributes higher in
the callchain, so it would be OK (or "unavoidable").

I wonder if it is worth to avoid early return from the inner block,
like this:

	struct conv_attrs *use_ca = NULL;
	...
	if (topath) {
		struct conv_attrs ca;
		if (S_ISREG(...)) {
			convert_attrs(... &ca ...);
			use_ca = &ca;
 		}
		return write_entry(ce, topath, use_ca, state, 1);
	}

which would make it easier to further add code that is common to
both regular file and other things before we call write_entry().

The same comment applies to the codepath where a new file gets
created in the next hunk.

> @@ -517,9 +526,16 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state,
>  		return 0;
>  
>  	create_directories(path.buf, path.len, state);
> +
>  	if (nr_checkouts)
>  		(*nr_checkouts)++;
> -	return write_entry(ce, path.buf, state, 0);
> +
> +	if (S_ISREG(ce->ce_mode)) {
> +		convert_attrs(state->istate, &ca, ce->name);
> +		return write_entry(ce, path.buf, &ca, state, 0);
> +	}
> +
> +	return write_entry(ce, path.buf, NULL, state, 0);
>  }
>  
>  void unlink_entry(const struct cache_entry *ce)
