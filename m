Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25773C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 14:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbiGRO5M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 10:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbiGRO5K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 10:57:10 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B76024BDD
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 07:57:09 -0700 (PDT)
Received: (qmail 32210 invoked by uid 109); 18 Jul 2022 14:57:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Jul 2022 14:57:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9879 invoked by uid 111); 18 Jul 2022 14:57:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Jul 2022 10:57:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 Jul 2022 10:57:08 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] log: fix common "rev.pending" memory leak in "git
 show"
Message-ID: <YtV0xB9d6g/XwkLk@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
 <patch-4.6-9bff7b10197-20220713T130511Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-4.6-9bff7b10197-20220713T130511Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 13, 2022 at 03:10:33PM +0200, Ævar Arnfjörð Bjarmason wrote:

> diff --git a/builtin/log.c b/builtin/log.c
> index e0f40798d45..77ec256a8ae 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -747,6 +747,8 @@ int cmd_show(int argc, const char **argv, const char *prefix)
>  			memcpy(&rev.pending, &blank, sizeof(rev.pending));
>  			add_object_array(o, name, &rev.pending);
>  			ret = cmd_log_walk_no_free(&rev);
> +			object_array_clear(&rev.pending);
> +			memcpy(&rev.pending, &cp, sizeof(rev.pending));
>  			break;

OK, so we clear the fake one-entry pending array we just created. That
make sense.

And then we have to restore rev.pending, because we don't otherwise
clean up cp. That makes sense in the context of your previous patch, but
if you take my suggestion there to separate "cp" from rev.pending
entirely, and clean it up explicitly, then this second memcpy() goes
away. IMHO that leaves the resulting code much easier to follow, as the
lifetimes are clearly distinct.

Two alternatives I briefly considered that don't work:

  - you can't just leave the one-item rev.pending in place to get
    cleaned up by release_revisions(), because we may show multiple
    commits. We have to clean each one as we go.

  - you can't just object_array_clear(&rev.pending) _before_ clearing
    it, because in the initial state it's still a copy of "cp", and thus
    would hose the array we're iterating over.

This whole "reuse rev, but tweak its pending array" feels a bit sketchy
to me in general. But it has been this way since 2006, and anyway is
completely out of scope for your series, so let's hold our nose and
continue. ;)

> diff --git a/t/t7007-show.sh b/t/t7007-show.sh
> index d6cc69e0f2c..f908a4d1abc 100755
> --- a/t/t7007-show.sh
> +++ b/t/t7007-show.sh
> @@ -2,6 +2,7 @@
>  
>  test_description='git show'
>  
> +TEST_PASSES_SANITIZE_LEAK=true
>  . ./test-lib.sh

Lots of stuff now passes, which is good, but....

> diff --git a/t/t9122-git-svn-author.sh b/t/t9122-git-svn-author.sh
> index 527ba3d2932..0fc289ae0f0 100755
> --- a/t/t9122-git-svn-author.sh
> +++ b/t/t9122-git-svn-author.sh
> @@ -2,7 +2,6 @@
>  
>  test_description='git svn authorship'
>  
> -TEST_FAILS_SANITIZE_LEAK=true
>  . ./lib-git-svn.sh

...this one (and t9162) don't anymore? Are these hunks a mistake? If
not, this feels like something that needs to go into the commit message.

-Peff
