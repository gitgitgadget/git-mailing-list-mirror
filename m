Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C190C4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 11:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ADDA60F42
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 11:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhHGLSl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 07:18:41 -0400
Received: from a.mx.sigpipe.cz ([37.221.242.114]:2931 "EHLO a.mx.sigpipe.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231922AbhHGLSk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 07:18:40 -0400
Received: by a.mx.sigpipe.cz (Postfix, from userid 1001)
        id 432BA155503640; Sat,  7 Aug 2021 13:18:22 +0200 (CEST)
Date:   Sat, 7 Aug 2021 13:18:22 +0200
From:   Roman Neuhauser <rn+git@sigpipe.cz>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=D8ystein?= Walle <oystwa@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] clone: Allow combining --bare and --origin
Message-ID: <YQ5r/uE2A8w9BAZz@isis.sigpipe.cz>
References: <xmqqv94mtdyj.fsf@gitster.g>
 <20210804133010.25855-1-oystwa@gmail.com>
 <xmqqbl6dqgvc.fsf@gitster.g>
 <YQ2aXpfzyOOUFhQk@isis.sigpipe.cz>
 <xmqqh7g2gr1s.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh7g2gr1s.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

# gitster@pobox.com / 2021-08-06 15:13:35 -0700:
> Roman Neuhauser <rn+git@sigpipe.cz> writes:
> 
> >> But we'd end up treating them the same.  And something like
> >> remote.originName would help that.  Otherwise, we'd end up sending
> >> this message:
> >> 
> >>     Even if we give "--bare --origin yourfavouritename" to you now,
> >>     unlike how 'origin' is treated in the default case, in the
> >>     resulting repository, 'yourfavouritename' is not special at all.
> >
> > Isn't that the case in non-bare repositories as well?
> 
> You have branches that are checked out.  The first branch that you'd
> presumably be using as the primary (traditionally called 'master')
> knows that the nickname used to call the remote it integrates with
> as the value of branch.master.remote

aha, i see that as a special (heh) case, an exception. :)
i spend most of my time on branches with no upstram.  sure, they're
extensions of master and such, but they have no upstream themselves.
and since there's no "origin" remote in my repos:

  git checkout -b fix-this-or-that master
  # tadaa, git fetch does nothing[1]

git fetch losing the hardcoded "origin" in favor of a configurable
value would be an improvement, yes.

> > Can't they just continue doing what they've been doing so far,
> > that is leave it at "origin"?  I'm not sure this would be my concern
> > as a user of this feature.

hm, that last sentence came out wrong.  i meant to say that as a user
of this feature, i would not mind having to provide and explicit remote.

> That answer can be thrown back at you.  You can leave it at "origin"
> when using "--bare" ;-).

how would that help the people who yearn for clone --bare --origin
but wouldn't use it if it meant fetch with explicit remotes?

> The posted patch is a good first step to allow both options to be
> used at the same time.  Without the first step, these two options
> cannot coexist.

i agree.
 
> But I am also saying that the first step alone is an inadequate
> solution that goes only halfway.  If you can get yourfavouritename,
> while others cannot use their favourite names, that is not a
> satisfying solution.

i don't see how the patch in its current form prevents anyone from
naming --origin whatever they want (within the accepted syntax).

---

i think a step back is in order.  git fetch --all would work,
git remote update would work.  if the issue is the imaginary
guy's ability to update the bare repo without peeking inside
config, either of these commands has him covered.

if the goal is to enable git fetch w/o --all or any other remote
specification then i'd say remote.fetchDefault would be a nice
mirror to remote.pushDefault.  this glaring asymmetry would go away:

  If no remote is configured, or if you are not on any branch,
  it defaults to origin for fetching and remote.pushDefault
  for pushing.

if you want the repo to remember where it was cloned from,
then again, remote.fetchDefault can fill that role.  obviously
mutable, but any setting would be, and i just don't see a problem
with that.

coming back to a question that fell below the radar:

# gitster@pobox.com / 2021-08-04 10:06:31 -0700:
> In other words, if there were two remotes in the configuration file,
> you cannot tell which one was given to --origin when you made the
> repository with "git clone".

when does this matter?

---

looking over the earlier emails, i'd like to reiterate one thing:

> We cannot tell between 'somewhere' and 'elsewhere', which one is
> what those who use the default configuration would refer to
> 'origin'---presumably, 'somewhere' being the --origin's argument
> when "git clone" was run, has some significance over 'elsewhere' in
> the user's mind, even after the latter is added to the repository.

i can't speak for others, but with me, this assumption is flat out
wrong.  half my "working copies" get cloned from upstream sources
and i add a remote to publish my changes from later, while the other
half happens the other way around.  the urls given to git clone
don't mean... much[2].

finally, this notion that --origin in a regular clone works just like
"origin" is generally false.  relevant to bare repos, if you don't
have any branch checked out, it goes to "origin".  iow if symmetry
between regular and bare clones is the goal, then mission accomplished,
they already behave the same.


[1] not only does it do nothing, it does it without a beep, which,
    aside from the runtime, looks just like a successful fetch from
    a remote i'm up-to-date with.

[2] https://www.youtube.com/watch?v=WO2q1iQX2UA

-- 
roman; btw, git-pull is backwards
