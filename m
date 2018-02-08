Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 612331F404
	for <e@80x24.org>; Thu,  8 Feb 2018 22:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbeBHWS6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 17:18:58 -0500
Received: from grym.ekleog.org ([94.23.42.210]:53794 "EHLO smtp.gaspard.ninja"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751094AbeBHWS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 17:18:57 -0500
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTP id 3baa1356;
        Thu, 8 Feb 2018 22:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=gaspard.io; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=
        grym-20170528; bh=YMgwo/eI9czS8H+SO8DBG1LVe20=; b=LXwhWFPOWltwzd
        6KY7dltnfGaTLeKOr22YiPbfGOShmqnd0fWEpWAYM+SVuS07Zee+7FrnrD4AKLu4
        LK/zO3xDFv5aGrPpsAe9kk2runwfR8aALwPNRrAb1LELqD2u4mhHnSJ+SW569sZ6
        8wm0Y4RpI9PrmcEBLNsSvT1+Q1IeI=
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTPSA id 89778a41 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Thu, 8 Feb 2018 22:18:55 +0000 (UTC)
Subject: Re: Fetch-hooks
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Joey Hess <id@joeyh.name>, git@vger.kernel.org
References: <5898be69-4211-d441-494d-93477179cf0e@gaspard.io>
 <87inb8mn0w.fsf@evledraar.gmail.com>
 <c8d1eb4d-c3d2-5834-a46b-931e825315aa@gaspard.io>
 <20180208153040.GA5180@kitenet.net>
 <871af155-a159-2a29-2e48-74e7a98b60d4@gaspard.io>
 <87bmgzmbsk.fsf@evledraar.gmail.com>
From:   Leo Gaspard <leo@gaspard.io>
Message-ID: <fa470be4-75fb-76ed-ed93-5c10fcfb8842@gaspard.io>
Date:   Thu, 8 Feb 2018 23:18:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87bmgzmbsk.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/08/2018 10:06 PM, Ævar Arnfjörð Bjarmason wrote:>> Hmm, OK, so I
guess I'll try to update the patch when I get some time to
>> delve into git's internals, as my use case (forbidding some fetches)
>> couldn't afaik be covered by a wrapper hook.
> 
> Per my reading of
> https://public-inbox.org/git/20111224234212.GA21533@gnu.kitenet.net/
> what Joey implemented is not what you described in your initial mail.
> 
> His is a *post*-fetch hook, we've already done the fetch and are just
> telling you as a courtesy what refs changed. You could also implement
> this as some cronjob that polls git for-each-ref but it's easier as a
> hook, fine.

I was thinking along the lines of
    https://marc.info/?l=git&m=132486687023893&w=2
with high-level description at
    https://marc.info/?l=git&m=132480559712592&w=2

With the high-level description given here, I'm pretty sure I can hack a
hook together to make things work as I want them to.

> What you're describing is something like a pre-fetch hook analogous to
> the pre-receive hooks, where you're fed refs updated on the remote on
> stdin, and can say you don't want some of those to be updated.
> 
> This may just be a lack of imagination on my part, but I don't see how
> that's sensible at all.
> 
> The refs we fetch are our *copy* of the remote refs, why would you not
> want to track the upstream remote. You're going to refuse some branches
> and what? Be further behind until some point in the future where the tip
> is GPG-signed and you accept it, at which poich you'll need to do more
> work than if you were up-to-date with the almost-GPG-signed version?

That's about it. I want all fetching to be blocked in case of the tip
not being signed. As there is a pre-push hook ensuring committers don't
forget to sign before pushing, the only case the tip could not be signed
is in case of an attack, which means it's better to just force-push
master because any git repo that fetched it is doomed anyway. Definitely
would not want to allow an untrusted revision get into anything that
could even remotely be taken as “endorsed” by the user.

(BTW, in order to avoid the case of someone forgetting to sign the
commit and not having installed the pre-push hook, there can be holes in
the commit-signing chain, the drawback being that the committer pushing
a signed commit takes responsibility for all unsigned commits directly
preceding his -- allowing them to recover in case of a mistaken push)

> I think you're confusing two things here. One is the reasonable concern
> of wanting to not have your local copy of remote refs have undesirable
> content, but a pre-fetch hook is not the way to accomplish that.

Well, a pre-fetch hook is a possible way of accomplishing that, and I
don't know of any better one?

> The other is e.g. to ensure that you never locally check out some "bad"
> ref, we don't have hook support for that, but could add it,
> e.g. git-checkout and git reset --hard could be taught about some
> pre-checkout hook.

Issue is, once we have to fix checkout and reset, all other commands
that potentially touch the worktree also have to be fixed (eg. I don't
know whether worktree add triggers pre-checkout?)

Also, this requires the hook to store a database of all the paths that
have been checked, because there is no logic in how one may choose to
checkout the repo. While having a tweak-fetch hook would make the
implementation straightforward, because at the time of invoking the hook
the “refname at remote” commit is already trusted, and the “object name”
is the commit whose validity we want to check, so we just have to check
the path between those two. (I don't know if you checked my current
scripts, but basically as the set of allowed PGP keys can change at any
commit, it's only possible to check a commit path, not a single commit
out-of-nowhere)

The only issue that could arise with a tweak-fetch hook is in case of a
force-fetch (and even maybe it's not even an actual issue, I haven't
given it real thought yet), but this can reasonably be banned, as once a
commit is signed it enters the “real” master branch, that should never
be moved backward, as it can't be the sign of an attack.

> You could also have some intermediate step between these two, where
> e.g. your refspec for "origin" is
> "+refs/heads/*:refs/remotes/origin-untrusted/*" instead of the default
> "+refs/heads/*:refs/remotes/origin/*", you fetch all refs to that
> location, then you move them (with some alias/hook) to
> "refs/remotes/origin/*" once they're seen to be "OK".

That is indeed another possibility, but then the idea is to make things
as transparent as possible for the end-user, not to completely change
their git workflow. As such, considering only signed commits to be part
of the upstream seems to make sense to me?

Cheers,
Leo
