Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E8701F462
	for <e@80x24.org>; Fri, 26 Jul 2019 19:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfGZTrq (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 15:47:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:52754 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727645AbfGZTrq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 15:47:46 -0400
Received: (qmail 16542 invoked by uid 109); 26 Jul 2019 19:47:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 26 Jul 2019 19:47:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10521 invoked by uid 111); 26 Jul 2019 19:49:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Jul 2019 15:49:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Jul 2019 15:47:45 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] Honor core.precomposeUnicode in more places
Message-ID: <20190726194745.GA8076@sigill.intra.peff.net>
References: <20190423173056.28523-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190423173056.28523-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 23, 2019 at 10:30:56AM -0700, Elijah Newren wrote:

> diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
> index f3353564f9..cfbd5c36c7 100644
> --- a/builtin/pack-refs.c
> +++ b/builtin/pack-refs.c
> @@ -1,4 +1,5 @@
>  #include "builtin.h"
> +#include "config.h"
>  #include "parse-options.h"
>  #include "refs.h"
>  #include "repository.h"
> @@ -16,6 +17,7 @@ int cmd_pack_refs(int argc, const char **argv, const char *prefix)
>  		OPT_BIT(0, "prune", &flags, N_("prune loose refs (default)"), PACK_REFS_PRUNE),
>  		OPT_END(),
>  	};
> +	git_config(git_default_config, NULL);
>  	if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
>  		usage_with_options(pack_refs_usage, opts);
>  	return refs_pack_refs(get_main_ref_store(the_repository), flags);

I coincidentally just wrote the same patch (working off a branch of
v2.21, so I didn't yet have your fix here). Just for the record, this
fixes other bugs, too!

Mine was:

diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 9ea5fa4fd2..07d09ac67a 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -253,4 +253,13 @@ test_expect_success SYMLINKS 'pack symlinked packed-refs' '
 	test "$(readlink .git/packed-refs)" = "my-deviant-packed-refs"
 '
 
+test_expect_success 'pack-refs respects core.useReplaceRefs' '
+	# this is broken because the object refers to itself
+	commit=$(git rev-parse HEAD) &&
+	test_when_finished "git update-ref -d refs/replace/$commit" &&
+	git update-ref refs/replace/$commit $commit &&
+	test_must_fail git pack-refs --all &&
+	git -c core.useReplaceRefs=false pack-refs --all
+'
+
 test_done

It's probably not worth adding the test independently, but I thought I'd
throw it out here for the benefit of the list archive.

-Peff
