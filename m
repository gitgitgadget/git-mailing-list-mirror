Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24BEC433DB
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 18:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B574461A16
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 18:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237624AbhCXSkh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 14:40:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:47720 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237896AbhCXSjz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 14:39:55 -0400
Received: (qmail 14147 invoked by uid 109); 24 Mar 2021 18:39:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Mar 2021 18:39:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20626 invoked by uid 111); 24 Mar 2021 18:39:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Mar 2021 14:39:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 24 Mar 2021 14:39:51 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Git mailing list <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: Pass or not to pass config environment down...
Message-ID: <YFuHd1MMlJAvtdzb@coredump.intra.peff.net>
References: <xmqqk0px3dfu.fsf@gitster.g>
 <CA+P7+xokjz-2nC5+F9HG0tBqS948uZcuq-1eY9uGuNyzbFGbZQ@mail.gmail.com>
 <xmqqmtut1qyj.fsf@gitster.g>
 <CA+P7+xo9rUYWzCT0YZFU5Nz1ojP1qRt8VfGtK08-LmYV9KK0hw@mail.gmail.com>
 <xmqqim5h1otg.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqim5h1otg.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 23, 2021 at 03:35:07PM -0700, Junio C Hamano wrote:

> > So, I think this direction is good. I imagine a full patch would
> > include also dropping the specialized helper function that is no
> > longer needed, and possibly adding new tests for the behavior of
> > GIT_CONFIG_COUNT?
> 
> Yeah, coding that is the easiest part.  Thinking through
> ramifications of making (or not making) such a change is much
> harder.
> 
> I said "assuming" number of times, because I am not so sure if the
> subprocesses spawned from other codepaths do or do not want to see
> the one-shot custom configuration settings.  If that assumption
> turns out to be wrong and the processes spawned using the helper in
> various helper functions in submodule.c are the oddball cases that
> want to see the custom configuration, then such a change would break
> existing users.

I think it really depends on the command being spawned. But keep in mind
that the local_repo_env list is not limited just to callers inside of
Git. We expose it to the user via rev-parse, so scripts can do:

  unset $(git rev-parse --local-env-vars)
  cd /some/other/repo

I'm hesitant to change the output there, since we don't know exactly how
it's used in the wild[1]. Changing what our internal callers do is less
risky, though I'd generally avoid doing so unless there is a known
benefit. And I'm sure what the benefit is; I think this came up mostly
because you were looking at harmonizing the behavior of the two config
systems (and I think that _is_ worth doing, but I'd probably choose the
historical behavior for the new system).

I also think it really depends on the specific config the user is
expecting to get passed. Remember we used to have a whitelist for "this
config is OK to pass to submodules", but it was such a mess that we did
away with it in 89044baa8b (submodule: stop sanitizing config options,
2016-05-04).

> I _think_ the one in connect.c, which runs either the ssh transport
> (for which the processes that run on the other side in the other
> repository won't be affected by our environment anyway) or the file
> transport that runs another process and talks with it over a pipe is
> probably OK if the configuration on the "client" side leaks through
> to the "server" side, e.g.
> 
>     $ git -c advice.ignoredHook=false clone file:///the/repo.git/ here
> 
> would probably want the other end (i.e. the one that runs upload-pack
> in /the/repo.git/ directory) to see the one-shot configuration, too.

That example is one of the reasons I prefer _not_ to pass config here.
It only works over local-process invocations! Not over ssh://, nor
git://, nor https://. Even though it will do what you want in this case,
the overall behavior is more confusing.

The more-consistent (or less inconsistent, perhaps) way is:

  git clone -u 'git -c advice.ignoredHook=false upload-pack' \
    file:///the/repo.git

which also works with ssh. It of course _doesn't_ work with other
protocols, but I think the technique at least makes it more clear why
that is the case (you do not get to specify arbitrary shell commands to
https servers).

> I do not think it makes much difference to the use of local_repo_env
> in object-file.c::for_each_alternate_ref() either way; it could be
> used (via core.alternateRefsCommand) an arbitrary command in each
> alternate repository, but by default it runs for-each-ref in them,
> and I do not think of any configuration variables that would be
> useful on "the other side".
> 
> And I suspect that trailers.c::apply_command() excludes these
> environment variables just out of habit without much deep thinking.
> It is not going in a different repository to run the command, and
> santitizing the environment that pertains to this repository should
> not have any meaningful effect [*].
> 
> So, I would not be surprised if it were a totally safe change, but I
> am not yet sure.

My suspicion is that for most cases, nobody cares that much either way
(which is why we have not seen people ask "hey, why is my config not
passed down" in any context _except_ submodules).

-Peff

[1] The one place I have used "rev-parse --local-env-vars" is in scripts
    to handle alternates storage. When we "sync" from a fork to the
    shared-object repo, there are some Git commands that must run in
    one, and some in the other. Likewise, there is "do maintenance"
    script which can be triggered from a fork, but then moves into the
    shared repo. Some of those sites explicitly allow config by doing:

      unset $(git rev-parse --local-env-vars | grep -v '^GIT_CONFIG')

    because we want "git -c pack.threads=17 do-the-maintenance" to
    respect that config after moving into the shared repo to do the
    repack. But others don't. _Probably_ nothing would go too wrong if
    we retained config, but I'd want to look at each. Which makes me
    concerned that other scripts in the wild would likewise be
    potentially surprised by this.
