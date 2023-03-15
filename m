Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08776C6FD1D
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 18:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjCOSGi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 14:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjCOSGh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 14:06:37 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4292814201
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 11:06:36 -0700 (PDT)
Received: (qmail 18810 invoked by uid 109); 15 Mar 2023 18:06:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Mar 2023 18:06:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2902 invoked by uid 111); 15 Mar 2023 18:06:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Mar 2023 14:06:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Mar 2023 14:06:34 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com, Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 1/8] for-each-ref: add --stdin option
Message-ID: <ZBIJKrgI0+Qxd3pG@coredump.intra.peff.net>
References: <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
 <pull.1489.v3.git.1678902343.gitgitgadget@gmail.com>
 <f9e80e233f1ca26f07f9db49261e54b7deaf83b8.1678902343.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f9e80e233f1ca26f07f9db49261e54b7deaf83b8.1678902343.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 15, 2023 at 05:45:36PM +0000, Derrick Stolee via GitGitGadget wrote:

> @@ -75,7 +79,21 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>  	ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
>  	filter.ignore_case = icase;
>  
> -	filter.name_patterns = argv;
> +	if (from_stdin) {
> +		struct strbuf line = STRBUF_INIT;
> +
> +		if (argv[0])
> +			die(_("unknown arguments supplied with --stdin"));
> +
> +		while (strbuf_getline(&line, stdin) != EOF)
> +			strvec_push(&vec, line.buf);
> +
> +		/* vec.v is NULL-terminated, just like 'argv'. */
> +		filter.name_patterns = vec.v;
> +	} else {
> +		filter.name_patterns = argv;
> +	}

Now that you aren't detaching the "line" strbuf in each iteration of the
loop, it needs to eventually be cleaned up. strbuf_getline() will
_reset() it, which is good, but at the end we'd need a strbuf_release()
or it will leak.

-Peff
