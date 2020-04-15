Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8807C3815B
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 16:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB3402166E
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 16:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410180AbgDOQEf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:04:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:54636 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2406243AbgDOQEa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 12:04:30 -0400
Received: (qmail 12774 invoked by uid 109); 15 Apr 2020 16:04:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 15 Apr 2020 16:04:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4630 invoked by uid 111); 15 Apr 2020 16:15:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Apr 2020 12:15:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Apr 2020 12:04:27 -0400
From:   Jeff King <peff@peff.net>
To:     Keegan Carruthers-Smith <keegan.csmith@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git ls-remote and protocolv2
Message-ID: <20200415160427.GE2464307@coredump.intra.peff.net>
References: <m2k12g7v5u.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <m2k12g7v5u.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 15, 2020 at 03:09:17PM +0200, Keegan Carruthers-Smith wrote:

> I would like to take advantage of protocol v2 in "git
> ls-remote". However, it can't reasonably use it because the patterns for
> ls-remote aren't prefix based patterns. See
> https://public-inbox.org/git/20181031042405.GA5503@sigill.intra.peff.net/

Yep. It's rather unfortunate, because I suspect most people would be
just as happy to have the patterns match prefixes anyway.

The fix you linked was just making sure the existing patterns continued
to work and maintained backwards-compatibility. But an option to tell
ls-remote "my patterns are prefixes" would be perfectly fine to add.

> This is behaviour I would like to implement. At Sourcegraph (were I
> work) we use "git ls-remote HEAD" to test if a remote is reachable and a
> valid git remote. Additionally we use it to get the symref for the
> default branch.

Those both seem like sensible use cases for ls-remote. And while we have
--heads which can take advantage of the v2 filtering, I don't think
there's a way to do the same for HEAD. One simple fix would be to add a
"--head" option, though the name is confusingly similar to --heads. :)

> There may be a better way to do this, but so far it seems ls-remote is
> the most reliable. However, we don't get to take advantage of protocol
> v2. A simple hack I did gives much better perf for our use case:
> 
>   diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
>   index 6ef519514b..12d3af177a 100644
>   --- a/builtin/ls-remote.c
>   +++ b/builtin/ls-remote.c
>   @@ -91,6 +91,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>    		}
>    	}
>    
>   +	argv_array_push(&ref_prefixes, "HEAD");
>   +

..and then this would basically just become:

  if (flags & REF_HEAD)
	argv_array_push(&ref_prefixes, "HEAD");

That said, I think I prefer one of the more general solutions below.

> What are the options to allow the use of protocol v2? The ideas I have
> in mind are the following.
> 
> "--ref-prefixes" flag. This changes the behaviour of the patterns to
> instead be ref prefixes so we can pass them as ref prefixes.

This seems like a good addition for other reasons (because people saying
"refs/heads/foo" probably _didn't_ mean to match "refs/bar/refs/heads/foo"),
and probably not significant work to implement. I'd have probably used
the word "pattern" in the option name, but looking at the manpage for
ls-remote, it calls the pattern arguments "<refs>". ;)

Probably as part of this patch, it would make sense to clarify the
current pattern scheme (in addition to documenting the new rules).

I suspect that --heads and --tags could be reimplemented in terms of
this option (and described as such in the documentation).

> "--ref-prefix=PREFIX" flag. Can be passed in multiple times. Each PREFIX
> is set as a ref prefix.

This could be useful independent of --ref-prefixes, if you really like
the current pattern matching but want to restrict the output. E.g.:

  git ls-remote --ref-prefix=refs/notes/ amlog

would show refs/notes/amlog.

So I think you could do this in addition to the suggestion above. But as
the first one would solve your problem, and nobody has asked for the use
case I gave above, I would be fine to leave it until somebody does.

> "refs/" prefix in pattern. If all patterns have a prefix of "refs/" pass
> in the relevant prefixes to remote refs. This would be a breaking change
> for the rare case of refs named like "refs/heads/refs/foo". You also
> wouldn't be able to pass in the symref "HEAD" which is what I want for
> my usecase.

I agree this would _probably_ do what people expect and help more than
hurt, but I'd prefer not to go this direction. It breaks
backwards-compatibility, and it introduces a subtle behavior rule.
Having an obvious and explicit like --ref-prefixes solves both of those.

-Peff
