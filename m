Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D232202C1
	for <e@80x24.org>; Mon, 13 Mar 2017 02:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755804AbdCMCnr (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Mar 2017 22:43:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58849 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755703AbdCMCnp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2017 22:43:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B332E6F49B;
        Sun, 12 Mar 2017 22:43:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9JWNH3yRd/JpSJRJOGOTJjPLIBg=; b=HugC/8
        afXAGo01wC2FKtPsHEBmJNItm0VELhUXD++Sws3F8zjADMh8kJTrqmXLqJnotiHo
        Rr8TWLWkEVQ4onrqvTQjimfkc2fN3xFgwu+YgUlmBHotfGodp5Rj+YExu9iH/Ih/
        JBoY0Nqx8eZErXrekLaQEV432FvTdajl9S7iM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m3qQ9f4DX9S9oMKdntcYIyDg7pYTUKJv
        xmF79csEnozMjHCd1bF87raXFdlUqx4EbVNWqU99WQg5hFhxuFqESZ46gw/H/2G/
        amT7o1d/LpyayhljRdpsczDxHlEJUMjq0PHju6Y37zMUiFU9pe4swpPjXUPuwIyN
        5cqe7rLYogc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC8986F49A;
        Sun, 12 Mar 2017 22:43:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 264966F499;
        Sun, 12 Mar 2017 22:43:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com
Subject: Re: [PATCH 1/2] pathspec: allow querying for attributes
References: <20170309210756.105566-1-bmwill@google.com>
        <20170309210756.105566-2-bmwill@google.com>
Date:   Sun, 12 Mar 2017 19:43:41 -0700
In-Reply-To: <20170309210756.105566-2-bmwill@google.com> (Brandon Williams's
        message of "Thu, 9 Mar 2017 13:07:55 -0800")
Message-ID: <xmqqo9x5uc9u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF582E54-0796-11E7-8701-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> +struct attr_check *attr_check_dup(const struct attr_check *check)
> +{
> +	struct attr_check *ret;
> +
> +	if (!check)
> +		return NULL;
> +
> +	ret = attr_check_alloc();
> +
> +	ret->nr = check->nr;
> +	ret->alloc = check->alloc;
> +	ALLOC_ARRAY(ret->items, ret->nr);
> +	COPY_ARRAY(ret->items, check->items, ret->nr);
> +
> +	return ret;
> +}

Because an attr_check instance cannot be shared and used by multiple
threads, we expect that the callers that go multi-thread to copy
pathspec to each worker, and preload_index(), which is an existing
example of such a caller, already does so with copy_pathspec().

Makes sense.

> @@ -565,26 +653,47 @@ void parse_pathspec(struct pathspec *pathspec,
>  
>  void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
>  {
> -	int i;
> +	int i, j;
>  
>  	*dst = *src;
>  	ALLOC_ARRAY(dst->items, dst->nr);
>  	COPY_ARRAY(dst->items, src->items, dst->nr);
>  
>  	for (i = 0; i < dst->nr; i++) {
> -		dst->items[i].match = xstrdup(src->items[i].match);
> -		dst->items[i].original = xstrdup(src->items[i].original);
> +		struct pathspec_item *d = &dst->items[i];
> +		struct pathspec_item *s = &src->items[i];
> +
> +		d->match = xstrdup(s->match);
> +		d->original = xstrdup(s->original);
> +
> +		ALLOC_ARRAY(d->attr_match, d->attr_match_nr);
> +		COPY_ARRAY(d->attr_match, s->attr_match, d->attr_match_nr);
> +		for (j = 0; j < d->attr_match_nr; j++) {
> +			const char *value = s->attr_match[j].value;
> +			if (value)
> +				d->attr_match[j].value = xstrdup(value);

We have xstrdup_or_null(), which may help here.

> +		}
> +
> +		d->attr_check = attr_check_dup(s->attr_check);
>  	}
>  }
>  
>  void clear_pathspec(struct pathspec *pathspec)
>  {
> -	int i;
> +	int i, j;
>  
>  	for (i = 0; i < pathspec->nr; i++) {
>  		free(pathspec->items[i].match);
>  		free(pathspec->items[i].original);
> +
> +		for (j = 0; j < pathspec->items[j].attr_match_nr; j++)
> +			free(pathspec->items[i].attr_match[j].value);
> +		free(pathspec->items[i].attr_match);
> +
> +		if (pathspec->items[i].attr_check)
> +			attr_check_free(pathspec->items[i].attr_check);
>  	}
> +
>  	free(pathspec->items);
>  	pathspec->items = NULL;
>  	pathspec->nr = 0;

OK, makes sense.

> diff --git a/t/t6135-pathspec-with-attrs.sh b/t/t6135-pathspec-with-attrs.sh
> new file mode 100755
> index 000000000..b5e5a0607
> --- /dev/null
> +++ b/t/t6135-pathspec-with-attrs.sh
> @@ -0,0 +1,181 @@
> +#!/bin/sh
> +
> +test_description='test labels in pathspecs'
> +. ./test-lib.sh
> +
> +test_expect_success 'setup a tree' '
> +	cat <<-EOF >expect &&

Minor style nit. Quote the 'EOF' marker and you signal to readers
that what they'll see are literally the values, and they do not have
to worry about $variable_interpolation.  I.e.

	cat <<-\EOF >expect &&

> +test_expect_success 'fail if attr magic is used places not implemented' '
> +	# The main purpose of this test is to check that we actually fail
> +	# when you attempt to use attr magic in commands that do not implement
> +	# attr magic. This test does not advocate git-add to stay that way,
> +	# though, but git-add is convenient as it has its own internal pathspec
> +	# parsing.

That's thought-provoking ;-) Would it help to add a test-pathspec
helper, similar to test-config helper, that serves as a vehicle to
test this?

> +	test_must_fail git add ":(attr:labelB)" 2>actual &&
> +	test_i18ngrep "unsupported magic" actual
> +'

Thanks.
