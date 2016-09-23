Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 708F4207EC
	for <e@80x24.org>; Fri, 23 Sep 2016 18:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1035000AbcIWSsX (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 14:48:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58337 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1034692AbcIWSsW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 14:48:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BC8053F485;
        Fri, 23 Sep 2016 14:48:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/eAaiJ8DWN175yjMzmfplGXVVVc=; b=fcZCrv
        NcW8cHAimc9ZSWYIQthtCxK+GNuPYOSDNOHlFvieyy2MRJowaOqKoLVOtX36jfzc
        HT8biBQMEwchjqeDJEeqUDo744IU8Ctgsa/ZyB74oWeehU/m5VW494sKEn3s8hgy
        XIpAI63RHk/B+fiLPfUfBs5DatUhDIYIr/lRU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=akW/qZ9bCsMjfY3VcGi2N1MGee/XjYPG
        xdY8MPdvEPh19DYwJbzEnvvt6Z8LybD0MzGrz7gyMyevgn2d9XUoXwM2FKf4yzIv
        be4rBx788xKM0eJSOvn+xQZyOq4iL2xnu/mu0csAIq4kWlpF8L+eUJqRFOl1zmVt
        Zb2MMApY6zw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B49D33F484;
        Fri, 23 Sep 2016 14:48:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3AD443F483;
        Fri, 23 Sep 2016 14:48:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2 v2] ls-files: add pathspec matching for submodules
References: <CAKoko1oacXxrSMZBvfM9X6iGDq+KcUUZnUrD2qD3X8+ze8vUXg@mail.gmail.com>
        <1474500486-101640-1-git-send-email-bmwill@google.com>
Date:   Fri, 23 Sep 2016 11:48:18 -0700
In-Reply-To: <1474500486-101640-1-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Wed, 21 Sep 2016 16:28:06 -0700")
Message-ID: <xmqqfuoq1mh9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C243122-81BE-11E6-BF23-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> -	/* Find common prefix for all pathspec's */
> -	max_prefix = common_prefix(&pathspec);
> +	/*
> +	 * Find common prefix for all pathspec's
> +	 * This is used as a performance optimization which unfortunately cannot
> +	 * be done when recursing into submodules
> +	 */
> +	if (recurse_submodules)
> +		max_prefix = NULL;
> +	else
> +		max_prefix = common_prefix(&pathspec);
>  	max_prefix_len = max_prefix ? strlen(max_prefix) : 0;

This is OK for now, but for a future enhancement, I think we could
do better than this.  In a superproject with a submodule at "sub/",
the current implementation of the common_prefix() helper would yield
"sub/a/" when given "sub/a/x" and "sub/a/y" (a pathspec with two
elements), which we want to avoid.

But somebody should be able to notice, before "sub/a/" is given to
max_prefix here, that "sub/" is the leaf level in our repository and
reduce the max_prefix to it.  dir.c::common_prefix_len() might be 
a place we could do so, but I didn't think about the ramifications
of doing so for other callers of common_prefix() or when we are not
recursing into submodules.  Doing it in the caller here, i.e.

	max_prefix = common_prefix(&pathspec);
        if (recurse_submodules)
        	max_prefix = chomp_at_submodule_boundary(max_prefix);

is certainly safer.

If the superproject has submodules at "a/b/{sub1,sub2,...}", this
matters more.  We do want to notice that we won't have to scan
outside "a/b/" of the index given "a/b/sub1" and "a/b/sub2" as a
pathspec.

The common_prefix_len() function also looks beyond symbolic links,
which is another thing that we may want to think about.  In a
repository with a symbolic link "link" pointing somewhere else, when
you give "link/a/x" and "link/a/y" (a pathspec with two elements),
we would get "link/a/" as a common prefix, but we won't find
anything underneath "link" in our index.  In such a case, leaving
the common prefix to "link/a/" _might_ allow us to notice that no
pathspec elements can ever match, so not noticing that the common
prefix points beyond a symbolic link might be a feature.  I dunno.
