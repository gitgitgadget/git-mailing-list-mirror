Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2854D1FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 21:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752837AbcKRVsp (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 16:48:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60878 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752805AbcKRVsn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 16:48:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 56EB750759;
        Fri, 18 Nov 2016 16:48:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EQivJvdWP7at/HaR+LZzXu3WDQo=; b=ZRfFFt
        rPlmPa9aZ5PIuVcJCs4NcAd/RhSc3uRkGA0ddTuBq0bp4c1fiiDw2RVdigNmvrqm
        q7RSWQOuXKvssQJiKCBS0MIo9y8r+K//L+okxW/c6H5PkKFgYJkzEAkf7NiFeU5g
        JUhEDsjy45XRkuQGnsHYn+9sRMkQ8TmD13FHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ju5LyDprbTJw+XDn2EaT10xo9yJxF18P
        6hBu9x6L6xpkHPZmMX0lDW6Kipr0YPDJL7/L609rA1D39XU4b0HI6UEFYjhywEU2
        ujHc5AHCaaZVSMmZFLjZI7WGL+X2jMA1bpANEBCokgJEfajio5eIgFPTSIwI65Y3
        aiZON5Ivtfs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4DF0F50758;
        Fri, 18 Nov 2016 16:48:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B876C50757;
        Fri, 18 Nov 2016 16:48:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jonathantanmy@google.com
Subject: Re: [PATCH v4 4/6] grep: optionally recurse into submodules
References: <1478908273-190166-1-git-send-email-bmwill@google.com>
        <1479499135-64269-1-git-send-email-bmwill@google.com>
        <1479499135-64269-5-git-send-email-bmwill@google.com>
Date:   Fri, 18 Nov 2016 13:48:40 -0800
In-Reply-To: <1479499135-64269-5-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Fri, 18 Nov 2016 11:58:53 -0800")
Message-ID: <xmqq1sy8mpc7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C565FEEE-ADD8-11E6-82E3-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> +static void compile_submodule_options(const struct grep_opt *opt,
> +				      const struct pathspec *pathspec,
> +				      int cached, int untracked,
> +				      int opt_exclude, int use_index,
> +				      int pattern_type_arg)
> +{
> +	struct grep_pat *pattern;
> +	int i;
> +
> +	if (recurse_submodules)
> +		argv_array_push(&submodule_options, "--recurse-submodules");
> +
> +	if (cached)
> +		argv_array_push(&submodule_options, "--cached");
> +...
> +
> +	/* Add Pathspecs */
> +	argv_array_push(&submodule_options, "--");
> +	for (i = 0; i < pathspec->nr; i++)
> +		argv_array_push(&submodule_options,
> +				pathspec->items[i].original);
> +}

When I do

    $ git grep --recurse-submodules pattern submodules/ lib/

where I have bunch of submodules in "submodules/" directory in the
top-level project, the top-level grep would try to find the pattern
in its own files in its "lib/" directory and then invoke sub-greps
in the submodule/a, submodule/b, etc. working trees.  

This passes the "submodules/" and "lib/" pathspec down to these
sub-greps.   These sub-greps in turn learn via --super-prefix where
they are in the super-project's context (e.g. "submodules/a/") to
adjust the given pathspec patterns, so everything cancels out
(e.g. they know "lib/" is totally outside of their area and their
files do not match with the pathspec element "lib/" at all).

Looking good.




