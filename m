Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C687C433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 08:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiKBITe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 04:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKBITa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 04:19:30 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D543317589
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 01:19:29 -0700 (PDT)
Received: (qmail 9415 invoked by uid 109); 2 Nov 2022 08:19:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Nov 2022 08:19:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3340 invoked by uid 111); 2 Nov 2022 08:19:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Nov 2022 04:19:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 2 Nov 2022 04:19:28 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC PATCH] fetch: stop emitting duplicate
 transfer.credentialsInUrl=warn warnings
Message-ID: <Y2IoEN6NHqj2Qisa@coredump.intra.peff.net>
References: <pull.1399.git.1667245638.gitgitgadget@gmail.com>
 <RFC-patch-1.1-0266485bc6c-20221031T204149Z-avarab@gmail.com>
 <Y2CFRJLFRXvGwFBC@coredump.intra.peff.net>
 <Y2Doe0ZGb3Zmmmen@coredump.intra.peff.net>
 <221101.86o7tq4vsn.gmgdl@evledraar.gmail.com>
 <Y2GI0R6pJmdZNgHn@nand.local>
 <221101.8635b24959.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221101.8635b24959.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2022 at 10:57:46PM +0100, Ævar Arnfjörð Bjarmason wrote:

> >> Sure, we can do it with an environment variable, in the end that's all
> >> git_config_push_parameter() is doing too. It's just setting things in
> >> "GIT_CONFIG_PARAMETERS".
> >>
> >> And yes, we can set this in the low-level function instead of with
> >> git_config_push_parameter() in builtin/*.c as I did. I was aiming for
> >> something demonstrably narrow, at the cost of some verbosity.
> >>
> >> But I don't get how other things being equal you think sticking this in
> >> "GIT_CHECKED_CREDENTIALS_IN_URL" instead of "GIT_CONFIG_PARAMETERS"
> >> helps.
> >
> > I vaguely prefer calling this GIT_CHECKED_CREDENTIALS_IN_URL instead of
> > stuffing it in the configuration.[...]
> 
> To be clear, I'm asking if there's cases where we think one method or
> the other produces different results, which I understood Jeff hinting
> at.

What I was hinting before was not that I knew of a particular bug in
your patch, but that I think the technique of munging
GIT_CONFIG_PARAMETERS is fragile in error-prone in the general case,
because the sub-programs can't differentiate between the config the user
asked for, and what was set by the suppression mechanism.

For this variable, there's no need to differentiate between "the user
asked us to be quiet" and "the calling program asked us to be quiet",
but I could imagine cases where there are subtle distinctions. Imagine
if there was a setting for "warn and rewrite the URL". We'd need to
change that to "don't warn, but just rewrite the URL", which otherwise
is a mode that doesn't need to exist.

Keeping it in a separate variable keeps the concerns orthogonal. The
code still gets to see what the user actually wants (via the config),
but has extra information from the calling process about how noisy/quiet
to be.

But you mentioned submodules in your other mail. And you're right that
the patch I showed doesn't handle that (it would need to add the new
variable to local_repo_env). It seems like yours should work because
CONFIG_DATA_ENVIRONMENT as part of local_repo_env. But I don't think it
actually does; in prepare_other_repo_env(), we retain the variables for
config in the environment, so that:

  git -c foo.bar=whatever fetch

will override variables in both the superproject and in submodules.

I didn't try it, but I suspect with your patch that a superproject with
"warn" and a submodule with "die" (both in their on-disk config files)
would misbehave. The superproject process will warn and say "yes, I've
checked everything" by munging the in-environment config to "allow".
Then the submodule process will see that config, and will override the
on-disk setting (in the usual last-one-wins config way). I.e., the
problem is that it cannot tell the difference between "the user asked to
override this" and the suppression mechanism.

-Peff
