Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40D601FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 17:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752343AbcLHR1M (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 12:27:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:53722 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751829AbcLHR1L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 12:27:11 -0500
Received: (qmail 20660 invoked by uid 109); 8 Dec 2016 17:26:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Dec 2016 17:26:26 +0000
Received: (qmail 11203 invoked by uid 111); 8 Dec 2016 17:27:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Dec 2016 12:27:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Dec 2016 12:26:26 -0500
Date:   Thu, 8 Dec 2016 12:26:26 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/7] Pie-in-the-sky attempt to fix the early config
Message-ID: <20161208172626.3ee2nmgsxsh2vovf@sigill.intra.peff.net>
References: <cover.1481211338.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1481211338.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 08, 2016 at 04:35:56PM +0100, Johannes Schindelin wrote:

> The idea here is to discover the .git/ directory gently (i.e. without
> changing the current working directory), and to use it to read the
> .git/config file early, before we actually called setup_git_directory()
> (if we ever do that).

Great. Thanks for taking a stab at this.

> Notes:
> 
> - I find the diff pretty ugly: I wish there was a more elegant way to
>   *disable* discovery of .git/ *just* for `init` and `clone`. I
>   considered a function `about_to_create_git_dir()` that is called in a
>   hard-coded manner *only* for `init` and `clone`, but that would
>   introduce another magic side effect, when all I want is to reduce those.

It looks like a lot of that ugliness comes from passing around the "are
we OK to peek at git-dir config" flag through the various pager-related
calls.  I don't think it would be bad to use a global for "we do not
want a repo".  After all, it's just modifying the _existing_ global for
"are we in a repo". And I do not see that global going away anytime
soon. Sometimes it's good to make incremental steps towards an end goal,
but in this case it seems like we just pay the cost of the step without
any real plan for reaping the benefit in the long term.

As an alternative, I also think it would be OK to just always have the
pager config read from local repo, even for init/clone. In other words,
to loosen the idea that git-init can _never_ look in the current
git-dir, and declare that there is a stage before the command is
initiated, and during which git may read local-repo config. Aliases
would fall into this, too, so:

  git config --local alias.foo init
  git foo /some/other/dir

would work (as it must, because we cannot know that "foo" is "init"
until we read the config!).

I have a feeling you may declare that too magical, but I think it's
consistent and practical.

> - For the moment, I do not handle dashed invocations of `init` and
>   `clone` correctly. The real problem is the continued existence of
>   the dashed git-init and git-clone, of course.

I assume you mean setting the CREATES_GIT_DIR flag here? I think it
would apply to the dashed invocations, too. They strip off the "git-"
and end up in handle_builtin() just like "git clone" does. I didn't test
it, though.

> - There is still duplicated code. For the sake of this RFC, I did not
>   address that yet.

Yeah, I did not read your discover function very carefully. Because I
think the one thing we really don't want to do here is introduce a
separate lookup process that is not shared by setup_git_directory(). The
only sane path, I think, is to refactor setup_git_directory() to build
on top of discover_git_directory(), which implies that the latter
handles all of the cases.

> - The read_early_config() function is called multiple times, re-reading
>   all the config files and re-discovering the .git/ directory multiple
>   times, which is quite wasteful. For the sake of this RFC, I did not
>   address that yet.

We already have a config-caching system. If we went with a global
"config_discover_refs", then I think the sequence for something like
git-init would become:

  1. When git.c starts, config_discover_refs is set to "true". Pager and
     alias lookup may look in .git/config if it's available, even if
     they go through the configset cache.

  2. As soon as git-init starts, it disables config_discover_refs, and
     it flushes the config cache. Any configset lookups will now examine
     the reduced config.

  3. When git-init has set up the real repo it is operating on, it can
     reenable config_discover_refs (though it may not even need to; that
     flag probably wouldn't have any effect once we've entered the
     repository and have_git_dir() returns true).

> - t7006 fails and the error message is a bit cryptic (not to mention the
>   involved function trace, which is mind-boggling for what is supposed
>   to be a simply, shell script-based test suite). I did not have time to
>   look into that yet.

Running t7006 I see a lot of old failures turned into successes, which
is good (because running from a subdirectory now actually respects local
pager config). The one failure looks like it is testing the wrong thing.

It is checking that we _don't_ respect a local core.pager in some cases,
as a proxy for whether or not we are breaking things by doing setup too
early. But the whole point of your series is to fix that, and respect
the config without causing the setup breakage. After your patches, the
proxy behavior and the failure case are disconnected. The test should be
flipped, and ideally another one added that confirms we didn't actually
run setup_git_directory(), but I'm not sure how to test that directly.

> - after discover_git_directory_gently() did its work, the code happily
>   uses its result *only* for the current read_early_config() run, and
>   lets setup_git_dir_gently() do the whole work *again*. For the sake of
>   this RFC, I did not address that yet.

If caching happens at the config layer, then we'd probably only call
this once anyway (or if we did call it again after a config flush, it
would be a good sign that we should compute its value again).

-Peff
