Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7C8C4338F
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 02:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 616AC60F59
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 02:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhHHCD6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 22:03:58 -0400
Received: from a.mx.sigpipe.cz ([37.221.242.114]:4060 "EHLO a.mx.sigpipe.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229882AbhHHCD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 22:03:58 -0400
Received: by a.mx.sigpipe.cz (Postfix, from userid 1001)
        id 5997C15550366A; Sun,  8 Aug 2021 04:03:36 +0200 (CEST)
Date:   Sun, 8 Aug 2021 04:03:36 +0200
From:   Roman Neuhauser <rn+git@sigpipe.cz>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=D8ystein?= Walle <oystwa@gmail.com>,
        git@vger.kernel.org
Subject: Re: Re* [PATCH v2] clone: Allow combining --bare and --origin
Message-ID: <YQ87eMDaZmeUTmyN@isis.sigpipe.cz>
References: <xmqqv94mtdyj.fsf@gitster.g>
 <20210804133010.25855-1-oystwa@gmail.com>
 <xmqqbl6dqgvc.fsf@gitster.g>
 <xmqq4kc0j4cd.fsf_-_@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4kc0j4cd.fsf_-_@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

# gitster@pobox.com / 2021-08-07 15:08:02 -0700:
> Subject: [PATCH] remote: fall back on the sole remote when unspecified
> 
> Historically, we used hardcoded "origin" as the fallback default for
> commands that take a remote (e.g. "git fetch") when the user did not
> tell us otherwise.  Since the "--origin=name" option was taught to
> "git clone", however, we may not have a remote whose name is
> "origin" at all.
> 
> Which means that the name given to "git clone --origin" does not
> truly replace the hardcoded "origin". An example of such limitation
> is that "git fetch" (no other parameters) would fetch happily from
> the "origin" repository, but in a repository cloned with the custom
> name using "--origin=name", "git fetch" would not fetch from anywhere
> and instead fail.

hey, i'm all for all this pre-existing lossage getting fixed if you
can do it.  all i'm saying is that since this combination of options
wasn't possible before there won't be any pre-existing uses of git
suddenly breaking.

> This matters for automation for those who want to use --origin
> option.  Imagine you have multiple bare clones and you wanted to use
> custom names for 'origin'.  And you want a cron job that goes over
> these repositories and run "git fetch" from their upstream before
> you come in for work, so that these bare clones can be used as
> close-by mirrors of their upstream projects.

imagine that you wanted to use git clone --bare --origin with
any git version released so far.  this is not snark, i'm pointing
out that git git has a history of things not working where one
would expect them to.
 
> Unfortunately, that would not work.  If these repositories use
> their own nicknames for their upstream that are not "origin",
> 
> 	for repo in a b c
> 	do
> 		git -C $repo fetch
> 	done

  for repo in a b c; do
    git -C $repo fetch --all # or git -C remote update
  done

all it takes to mitigate this is to point this out in the release
notes and man page.  what you sketched out above is analogous to my
initial encounter with git clone --bare --origin not working:
where were you when the half-assed implementation was landing?  :)
why was there no one to champion for people who'd want to use those
two together? :)) (j/k)
 
> would just fail.  Of course, you can somehow out-of-band know the
> origin's name for each repo, e.g.

even if i accept the premise that git fetch --all can't be used
and the explicit name is necessary, isn't that magical out-of-band
wand called git-config?

  origin=$(
    git config --file $repo \
    --name-only --get-regexp \
    '^remote\.[^.]*.url' |
    sed -E 's/^remote\.([^.]+).url$/\1/'
  )
  git -C $repo fetch $origin
 
i'm not skilled enough in git-config to simplify that.


i think it'd be prudent to pause this thread for now because it's
only distracting you from fixing the --origin fallout, and as long
as you talk about how it *should* be while i bring up available
workarounds, it's just noise.

> but that is solving a problem that arises only because we are not
> treating the name given to "git clone --origin=name" as a true
> replacement for the default "origin".

and i'm really grateful that you're tying the loose ends, as long
as this whole thing doesn't fizzle out on account of being too much,
and the partial improvement doesn't get swept with it!
 
i think i said in earlier that i'm a big fan of stripping "origin"
of its special standing.  huge kudos if you can see this through.

-- 
roman
