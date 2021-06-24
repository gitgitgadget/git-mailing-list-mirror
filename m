Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67A4C49EA5
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 16:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B4A1613CC
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 16:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhFXQ4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 12:56:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:59632 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhFXQ4o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 12:56:44 -0400
Received: (qmail 12430 invoked by uid 109); 24 Jun 2021 16:54:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Jun 2021 16:54:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14026 invoked by uid 111); 24 Jun 2021 16:54:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Jun 2021 12:54:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Jun 2021 12:54:24 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v2 1/3] bundle cmd: stop leaking memory from
 parse_options_cmd_bundle()
Message-ID: <YNS4wCjkp4yiLLBQ@coredump.intra.peff.net>
References: <cover-0.3-0000000000-20210617T111934Z-avarab@gmail.com>
 <cover-0.3-00000000000-20210621T151357Z-avarab@gmail.com>
 <patch-1.3-932c0883ce0-20210621T151357Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.3-932c0883ce0-20210621T151357Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 21, 2021 at 05:16:12PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Fix a memory leak from the prefix_filename() function introduced with
> its use in 3b754eedd5 (bundle: use prefix_filename with bundle path,
> 2017-03-20).
> 
> As noted in that commit the leak was intentional as a part of being
> sloppy about freeing resources just before we exit, I'm changing this
> because I'll be fixing other memory leaks in the bundle API (including
> the library version) in subsequent commits. It's easier to reason
> about those fixes if valgrind runs cleanly at the end without any
> leaks whatsoever.

Looking at that old commit, it seems like this is a good candidate for
just inserting a single UNLEAK(bundle_file) into cmd_bundle(). But it
looks like the allocation has now migrated into all of the individual
sub-command functions, so we have to deal with it multiple times. They
could still use UNLEAK() if you want to avoid the "ret = foo(); free();
return ret" dance in each one, though.

We should avoid UNLEAK() in library-ish functions, but sub-commands that
are just one step away from cmd_bundle() returning are OK uses, IMHO.

> @@ -92,77 +93,107 @@ static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
>  	if (progress && all_progress_implied)
>  		strvec_push(&pack_opts, "--all-progress-implied");
>  
> -	if (!startup_info->have_repository)
> +	if (!startup_info->have_repository) {
> +		die_no_repo = 1;
> +		goto cleanup;
> +	}
> +	ret = !!create_bundle(the_repository, bundle_file, argc, argv, &pack_opts, version);
> +cleanup:
> +	free(bundle_file);
> +	if (die_no_repo)
>  		die(_("Need a repository to create a bundle."));
> -	return !!create_bundle(the_repository, bundle_file, argc, argv, &pack_opts, version);
> +	return ret;
>  }

This die_no_repo stuff confused me at first. But I think you are trying
to make sure we call free(bundle_file) before die? There is no point in
spending any effort on that, I think. When we exit() via die(), the
variable is still on the stack, and hence not leaked. And there are
probably a zillion other places we can hit a die() inside
create_bundle() anyway, which would produce the same effect. There's not
much point treating this one specially.

-Peff
