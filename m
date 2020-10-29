Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FC2C2D0A3
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 23:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D1E920739
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 23:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iPACBAAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbgJ2Xs1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 19:48:27 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50767 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ2Xs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 19:48:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BB3B4104912;
        Thu, 29 Oct 2020 19:48:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O3OkC0KuYkHw6iwAQ8F/ER0SH70=; b=iPACBA
        ARKgu/i6mK10+VQvKicR47Xj8qwNXfGIP6fmx9kgCnonCSccFaWsby95tlPcpaT/
        DbUVGQs5tHUOqfK0Mccjpql/cPBW9W4r739CDUajdHuXSGibvCgz3JaaMK6ADmJ4
        2SMBOeH2a01Gc7XldDu5VDC1jKf2LTaqjZ80k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A4p/bWV/O9SdgB7Abq12vc3d3ZhuQFCq
        0AXdCHiU4i17fcIlXj9OgU4ddR/xzil3f+1iZhUzFL1iMqfXMhWvr3h7MfKHcQNj
        wFl60bbD3jwplXll5uLMoOGHJ1TkHvVItIM8HLcn0wyHQ0hnvI8vYNOt8LtZBSXg
        jZVapejs8bE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B362E104911;
        Thu, 29 Oct 2020 19:48:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0C4E9104910;
        Thu, 29 Oct 2020 19:48:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, git@jeffhostetler.com,
        chriscool@tuxfamily.org, peff@peff.net, newren@gmail.com,
        jrnieder@gmail.com, martin.agren@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 02/19] convert: add
 [async_]convert_to_working_tree_ca() variants
References: <cover.1603937110.git.matheus.bernardino@usp.br>
        <c5fbd1e16d616a4c238d98a35f3671238300c17f.1603937110.git.matheus.bernardino@usp.br>
Date:   Thu, 29 Oct 2020 16:48:20 -0700
In-Reply-To: <c5fbd1e16d616a4c238d98a35f3671238300c17f.1603937110.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Wed, 28 Oct 2020 23:14:39 -0300")
Message-ID: <xmqqy2jo386z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A7209DE-1A41-11EB-9858-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> -static int convert_to_working_tree_internal(const struct index_state *istate,
> +static int convert_to_working_tree_internal(const struct conv_attrs *ca,

Makes sense.  Once we know conv_attrs, we do not need the istate to
convert the contents.

> @@ -1497,7 +1494,9 @@ int async_convert_to_working_tree(const struct index_state *istate,
>  				  const struct checkout_metadata *meta,
>  				  void *dco)
>  {
> -	return convert_to_working_tree_internal(istate, path, src, len, dst, 0, meta, dco);
> +	struct conv_attrs ca;
> +	convert_attrs(istate, &ca, path);
> +	return convert_to_working_tree_internal(&ca, path, src, len, dst, 0, meta, dco);
>  }
>
> @@ -1505,13 +1504,36 @@ int convert_to_working_tree(const struct index_state *istate,
>  			    size_t len, struct strbuf *dst,
>  			    const struct checkout_metadata *meta)
>  {
> -	return convert_to_working_tree_internal(istate, path, src, len, dst, 0, meta, NULL);
> +	struct conv_attrs ca;
> +	convert_attrs(istate, &ca, path);
> +	return convert_to_working_tree_internal(&ca, path, src, len, dst, 0, meta, NULL);
> +}

OK, these naturally implement "let's lift convert_attrs() out of the
callee and move it to the callers".  However...

> +int async_convert_to_working_tree_ca(const struct conv_attrs *ca,
> +				     const char *path, const char *src,
> +				     size_t len, struct strbuf *dst,
> +				     const struct checkout_metadata *meta,
> +				     void *dco)
> +{
> +	return convert_to_working_tree_internal(ca, path, src, len, dst, 0, meta, dco);
> +}
> +
> +int convert_to_working_tree_ca(const struct conv_attrs *ca,
> +			       const char *path, const char *src,
> +			       size_t len, struct strbuf *dst,
> +			       const struct checkout_metadata *meta)
> +{
> +	return convert_to_working_tree_internal(ca, path, src, len, dst, 0, meta, NULL);
>  }

... shouldn't they be implemented as thin wrappers around these new
*_ca() variants of the API functions?  Otherwise, the *_ca()
variants are not yet used by anybody yet at this step, are they?
