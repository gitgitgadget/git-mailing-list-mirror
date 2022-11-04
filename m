Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F7DC43217
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 13:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiKDNQ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 09:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiKDNQz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 09:16:55 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CB412AF1
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 06:16:53 -0700 (PDT)
Received: (qmail 18958 invoked by uid 109); 4 Nov 2022 13:16:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Nov 2022 13:16:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29993 invoked by uid 111); 4 Nov 2022 13:16:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Nov 2022 09:16:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 4 Nov 2022 09:16:52 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC PATCH] fetch: stop emitting duplicate
 transfer.credentialsInUrl=warn warnings
Message-ID: <Y2UQxGqE9wXYVrTs@coredump.intra.peff.net>
References: <pull.1399.git.1667245638.gitgitgadget@gmail.com>
 <RFC-patch-1.1-0266485bc6c-20221031T204149Z-avarab@gmail.com>
 <Y2CFRJLFRXvGwFBC@coredump.intra.peff.net>
 <Y2Doe0ZGb3Zmmmen@coredump.intra.peff.net>
 <221101.86o7tq4vsn.gmgdl@evledraar.gmail.com>
 <Y2GI0R6pJmdZNgHn@nand.local>
 <221101.8635b24959.gmgdl@evledraar.gmail.com>
 <Y2IoEN6NHqj2Qisa@coredump.intra.peff.net>
 <221104.8635azysw7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221104.8635azysw7.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2022 at 10:01:00AM +0100, Ævar Arnfjörð Bjarmason wrote:

> > But you mentioned submodules in your other mail. And you're right that
> > the patch I showed doesn't handle that (it would need to add the new
> > variable to local_repo_env). It seems like yours should work because
> > CONFIG_DATA_ENVIRONMENT as part of local_repo_env. But I don't think it
> > actually does; in prepare_other_repo_env(), we retain the variables for
> > config in the environment, so that:
> >
> >   git -c foo.bar=whatever fetch
> >
> > will override variables in both the superproject and in submodules.
> 
> Replying to your main point below, just an aside on this:
> 
> To be clear I'm not saying it would handle it sensibly now, but just
> that if we're using env vars to communicate to sub-processes then using
> CONFIG_DATA_ENVIRONMENT seems better to me.
> 
> Because even if we're getting it wrong now, then surely that's something
> we're probably getting wrong in more than one place.
> 
> So e.g. if we set an env var "for ourselves", i.e. "pull->fetch" then we
> could detect that condition in run_command(), and if we then spot that
> we're carrying an env variable we set earlier up the chain reset it
> before we spawn a submodule.
> 
> Whereas if it's all custom env variables here & there we'll need to add
> all that special-casing in.

The idea is that local_repo_env carries that information, and everybody
uses it. So yes, it would have to know about the custom env variables,
but then any place which enters another repo learns about it "for free".
But using CONFIG_DATA_ENVIRONMENT for this doesn't work, because we
don't actually clear it when moving between repositories.

And in the example I showed, I used a config variable that was specific
to this particular problem. But if there were a lot of these, it really
could be:

  GIT_CHECKED_AND_WARNED='remotes some-other-subsytem etc'

so that all of them were shoved into one variable, and parsed. But we
can do the simplest dumb thing for now, because none of this is a public
interface we need to support across versions. We could move from one to
the other later.

> But, and maybe I'm still not getting it, but the "use a different env
> var" isn't actually the important part, i.e. these would behave the
> same after the initial "warn":
> 
> 	-c transfer.credentialsInUrlWarnedAlready=true
> 
> And:
> 
> 	GIT_CHECKED_AND_WARNED_ALREADY=1
> 
> But not what I was suggesting:
> 
> 	# conflated with a later "die"
> 	-c transfer.credentialsInUrl=allow

Right. The important thing is not that it's in a different env variable
in particular, but that it _isn't_ using the same config variable that
the user would set.

But once you are not using that same config variable, the question is:
do you want it put in with the config data or not? And I think we have
seen that putting it with the config data is not going to work. We don't
clear those environment variables when moving between repositories.

Now obviously if the env-clearing code knew which config variables were
to be cleared and which not, it could do so. But why introduce that
complexity, when you can just stick all the stuff that should be cleared
into a new variable (and again, that can be _one_ variable for all of
this stuff).

> But all suggested variants of this (mine and yours) are going to get
> e.g. the case where the submodule also wants "warn". I.e. it's not
> enough that we're saying "warned already".
> 
> That gets us past conflating an existing "warn" with a "die", but now we
> can't tell a submodule "warn" from a superproject "warn".
> 
> For that we'd basically need to do:
> 
> 	-c transfer.$(<make path to .git, or other "unique repo id>).credentialsInUrl=allow
> 
> Or another similar mechanism, of course the most sane one to be to not
> be playing this game at all, but to just ferry this state e.g. with
> "--do-not-warn-about-this-repo" to our own children, which we'd not add
> to the command-lines when we know we're spawning a hook, or doing the
> submodule "pull/fetch".
> 
> Does that all seem right?

That seems much more complicated. Again, why bother stuffing this extra
context information into a config variable, just to work around the fact
that config isn't cleared between repositories, when there is already a
simple mechanism for clearing state when switching repositories?

All that said, the implementation of this whole warning seems really
weird to me. If we want to warn about using such a URL, then we should
do it at the point of use. From the original commit message, the only
reason it was put where it is was to avoid sigpipe when the remote
helper dies. The solution there seems to be "have the helper die in a
less abrupt way".

And TBH, I'm skeptical of the whole feature. I don't see the point in
even warning somebody about:

  git fetch https://username:password@example.com

Maybe it's bad practice (though with password stand-ins like
restricted-access tokens, it isn't always), but at the point the user
has invoked git, there's nothing else bad that happens by doing what
they asked for.

What _is_ potentially bad is using that URL for cloning, because we then
write the credential in plaintext to the config file. And a better
solution there is probably to issue a warning, clone anyway, and then
omit the password from what we write into config. A follow-on fetch
would fail, but that is not any worse than the "die" mode of this
current config option.

There were even patches we discussed a few years ago:

  https://lore.kernel.org/git/20190517222031.GA17966@sigill.intra.peff.net/

I think the only really contentious part was the third one, which tried
to do so automagic with credential helpers. If we skipped that, then the
mode given by patches 1+2 seems strictly better than anything this
transfer.credentialsInUrl option provides.

-Peff
