Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FF201F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 11:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbeKOVMT (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 16:12:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:40364 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728984AbeKOVMT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 16:12:19 -0500
Received: (qmail 16944 invoked by uid 109); 15 Nov 2018 11:04:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Nov 2018 11:04:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14230 invoked by uid 111); 15 Nov 2018 11:04:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Nov 2018 06:04:17 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Nov 2018 06:04:55 -0500
Date:   Thu, 15 Nov 2018 06:04:55 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/3] clone: respect additional configured fetch refspecs
 during initial fetch
Message-ID: <20181115110455.GB19032@sigill.intra.peff.net>
References: <20181114104620.32478-1-szeder.dev@gmail.com>
 <20181114104620.32478-3-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181114104620.32478-3-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 14, 2018 at 11:46:19AM +0100, SZEDER Gábor wrote:

> The initial fetch during a clone doesn't transfer refs matching
> additional fetch refspecs given on the command line as configuration
> variables, e.g. '-c remote.origin.fetch=<refspec>'.  This contradicts
> the documentation stating that configuration variables specified via
> 'git clone -c <key>=<value> ...' "take effect immediately after the
> repository is initialized, but before the remote history is fetched"
> and the given example specifically mentions "adding additional fetch
> refspecs to the origin remote".  Furthermore, one-shot configuration
> variables specified via 'git -c <key>=<value> clone ...', though not
> written to the newly created repository's config file, live during the
> lifetime of the 'clone' command, including the initial fetch.  All
> this implies that any fetch refspecs specified this way should already
> be taken into account during the initial fetch.
> 
> The reason for this is that the initial fetch is not a fully fledged
> 'git fetch' but a bunch of direct calls into the fetch/transport
> machinery with clone's own refs-to-refspec matching logic, which
> bypasses parts of 'git fetch' processing configured fetch refspecs.
> This logic only considers a single default refspec, potentially
> influenced by options like '--single-branch' and '--mirror'.  The
> configured refspecs are, however, already read and parsed properly
> when clone calls remote.c:remote_get(), but it never looks at the
> parsed refspecs in the resulting 'struct remote'.
> 
> Modify clone to take the remote's configured fetch refspecs into
> account to retrieve all matching refs during the initial fetch.  Note
> that we have to explicitly add the default fetch refspec to the
> remote's refspecs, because at that point the remote only includes the
> fetch refspecs specified on the command line.

Nicely explained.

> Add tests to check that refspecs given both via 'git clone -c ...' and
> 'git -c ... clone' retrieve all refs matching either the default or
> the additional refspecs, and that it works even when the user
> specifies an alternative remote name via '--origin=<name>'.

Good. This is all sufficiently subtle that we definitely want to check
the related cases.

> @@ -1081,11 +1086,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	if (option_required_reference.nr || option_optional_reference.nr)
>  		setup_reference();
>  
> +	remote = remote_get(option_origin);
> +
>  	strbuf_addf(&default_refspec, "+%s*:%s*", src_ref_prefix,
>  		    branch_top.buf);
> -	refspec_append(&rs, default_refspec.buf);
> +	refspec_append(&remote->fetch, default_refspec.buf);

Wow, this is so much nicer than the older versions. :)

I wondered briefly whether this ought to only kick in when the user
didn't specify any refspecs. I.e., there is no way with this to say
"don't fetch refs/heads/*, but this other thing instead". But the way
the existing documentation is written, it's pretty clear that it's about
adding to the list of refspecs. We can always something like
"--no-default-refspec" later if somebody wants it.

> [...]

Most of the rest of the patch is just swapping out "rs" for
"remote->fetch", which makes sense. So the implementation looks good to
me.

> diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
> index 39329eb7a8..60c1ba951b 100755
> --- a/t/t5611-clone-config.sh
> +++ b/t/t5611-clone-config.sh
> @@ -45,6 +45,53 @@ test_expect_success 'clone -c config is available during clone' '
>  	test_cmp expect child/file
>  '
>  
> +test_expect_success 'clone -c remote.origin.fetch=<refspec> works' '
> +	rm -rf child &&
> +	git update-ref refs/grab/it refs/heads/master &&
> +	git update-ref refs/leave/out refs/heads/master &&

Checking one in and one out; nice.

> +	git clone -c "remote.origin.fetch=+refs/grab/*:refs/grab/*" . child &&
> +	git -C child for-each-ref --format="%(refname)" >actual &&
> +
> +	cat >expect <<-\EOF &&
> +	refs/grab/it
> +	refs/heads/master
> +	refs/remotes/origin/HEAD
> +	refs/remotes/origin/master
> +	EOF
> +	test_cmp expect actual
> +'

Makes sense.

> +test_expect_success 'git -c remote.origin.fetch=<refspec> clone works' '
> +	rm -rf child &&
> +	git -c "remote.origin.fetch=+refs/grab/*:refs/grab/*" clone . child &&
> +	git -C child for-each-ref --format="%(refname)" >actual &&
> +
> +	cat >expect <<-\EOF &&
> +	refs/grab/it
> +	refs/heads/master
> +	refs/remotes/origin/HEAD
> +	refs/remotes/origin/master
> +	EOF
> +	test_cmp expect actual
> +'

This relies on establishing grab/it in the previous test. A minor nit,
but we could break that more clear by breaking it out into its own
"set up refs for extra refspec tests" block.

> +test_expect_success 'clone -c remote.<remote>.fetch=<refspec> --origin=<name>' '
> +	rm -rf child &&
> +	git clone --origin=upstream \
> +		  -c "remote.upstream.fetch=+refs/grab/*:refs/grab/*" \
> +		  -c "remote.origin.fetch=+refs/leave/*:refs/leave/*" \
> +		  . child &&

Nice.

The whole thing looks very cleanly done.

-Peff
