Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 285C31FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 17:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752512AbcLIRzL (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 12:55:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:54279 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752508AbcLIRzL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 12:55:11 -0500
Received: (qmail 12123 invoked by uid 109); 9 Dec 2016 17:55:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Dec 2016 17:55:10 +0000
Received: (qmail 20213 invoked by uid 111); 9 Dec 2016 17:55:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Dec 2016 12:55:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Dec 2016 12:55:08 -0500
Date:   Fri, 9 Dec 2016 12:55:08 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/7] Pie-in-the-sky attempt to fix the early config
Message-ID: <20161209175507.3ap73ew4fkflkhy6@sigill.intra.peff.net>
References: <cover.1481211338.git.johannes.schindelin@gmx.de>
 <20161208172626.3ee2nmgsxsh2vovf@sigill.intra.peff.net>
 <alpine.DEB.2.20.1612091810500.23160@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1612091810500.23160@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 09, 2016 at 06:28:10PM +0100, Johannes Schindelin wrote:

> > Great. Thanks for taking a stab at this.
> 
> Well, I figured that I can go through you to get this integrated into
> git.git.

I am not sure what you mean here, but it _sounds_ like you are
continuing to be negative about the chances of fixes going into git.git
here. I really don't think that negativity is merited, but even if it
is, making snide comments does not help and mostly just makes the
conversation less pleasant.

> > I don't think it would be bad to use a global for "we do not want a
> > repo".
> 
> I would think it would be bad, as the entire reason for this patch series
> is that we have global state that gets messed up too early (I am speaking
> from the point of view of somebody who patched Git locally so that it does
> read config variables *before* launching builtins).

I think those are two different things. One is global state that is
munged as a side effect of setup_git_directory(). The other is global
state that the process sets to say "this is an invariant" so it does not
have to deal with passing it through a huge call chain.

> > After all, it's just modifying the _existing_ global for "are we in a
> > repo".
> 
> No it does not.

Perhaps I wasn't clear on my "it" here. I mean that we will continue to
have startup_info->have_repository as a global (and if not that, then
certainly the environment variable GIT_DIR and the cwd are process
globals). I'm proposing a global flag to modify how to interpret those
globals. I don't think that really makes anything worse.

> The read_early_config() function specifically does not leave any traces in
> the global namespace. It calls the git_config_with_options() function
> without touching the_config_set.

I'm not talking about read_early_config() modifying the global state.
I'm talking about main() modifying it so that lower-level functions like
read_early_config() can make use of it.

> I would look more favorably on this idea if we were to teach
> the_config_set to record a little bit more about the state from which it
> was constructed, and to auto-flush-and-re-read when it detects that, say,
> git_dir was changed in the meantime.

I considered that when fixing some bugs in git-init a few months ago,
but I think the cure becomes worse than the problem. Automatic cache
invalidation can have some tricky corner cases, and there really
_aren't_ that many places where we need to do it. Just dropping
git_config_clear() in those places is ugly, but practical.

> > And I do not see that global going away anytime soon.
> 
> And that is really, really sad.

I think we differ on that.

> > As an alternative, I also think it would be OK to just always have the
> > pager config read from local repo, even for init/clone.
> 
> For the purpose of this current discussion, I am utterly uninterested in
> the pager config. What I want to use the early config for is substantially
> different and more relevant: I need to configure some command to run
> before, and after, every single Git command here. And this configuration
> needs to be per-repository. And no, I do not want to hardcode anything.

I do not see how that changes things. If there is the concept of a
"before the command is run" phase during which we would read from the
current-directory config even for git-init, it seems to me that applies
logically to pagers, aliases, _and_ whatever pre-command magic you are
interested in adding.

> > In other words, to loosen the idea that git-init can _never_ look in the
> > current git-dir, and declare that there is a stage before the command is
> > initiated, and during which git may read local-repo config. Aliases
> > would fall into this, too, so:
> > 
> >   git config --local alias.foo init
> >   git foo /some/other/dir
> > 
> > would work (as it must, because we cannot know that "foo" is "init"
> > until we read the config!).
> 
> True.
> 
> But is this a good excuse to just shrug our shoulders and let git-init
> (which we do know very well) fall into the same trap?

I'm not sure I agree it is a trap. There is a consistent and reasonable
mental model where it is the natural thing. I understand that's not the
one you prefer, but it seems like a practical one to me.

> > We already have a config-caching system. If we went with a global
> > "config_discover_refs",
> 
> Why "_refs"?

Er, sorry, slip of the tongue. I think I meant config_discover_git, and
for some reason managed to repeat it over and over. Hopefully you
figured out what I meant.

> > then I think the sequence for something like git-init would become:
> > 
> >   1. When git.c starts, config_discover_refs is set to "true". Pager and
> >      alias lookup may look in .git/config if it's available, even if
> >      they go through the configset cache.
> > 
> >   2. As soon as git-init starts, it disables config_discover_refs, and
> >      it flushes the config cache. Any configset lookups will now examine
> >      the reduced config.
> > 
> >   3. When git-init has set up the real repo it is operating on, it can
> >      reenable config_discover_refs (though it may not even need to; that
> >      flag probably wouldn't have any effect once we've entered the
> >      repository and have_git_dir() returns true).
> 
> That is a bit fiddly, don't you think? The callers have to have very
> intimate knowledge of the config reading to remember to set, and re-set,
> that global. And to flush when appropriate.

Sure, but I think there are literally 2 callers who care about this.

> How much nicer would the code be if the call to git_config() would realize
> what needs to be done, don't you agree?

No, I wouldn't agree until I had seen a very elegant patch that
implements this and handles any corner cases. I looked into making a
patch before and found that it got a bit ugly (sorry, I don't really
remember the details). I am happy to have you show me that patch, but
pardon me if I remain skeptical until I see it. ;)

> > Running t7006 I see a lot of old failures turned into successes, which
> > is good (because running from a subdirectory now actually respects local
> > pager config). The one failure looks like it is testing the wrong thing.
> 
> Yeah, but due to the redirections I was not able to figure out what to
> change to "fix" this.

I think test_local_config_ignored would go away, and its callers become
test_core_pager_overrides. More or less a revert of 73e25e7cc (git
--paginate: do not commit pager choice too early, 2010-06-26).

> > proxy behavior and the failure case are disconnected. The test should be
> > flipped, and ideally another one added that confirms we didn't actually
> > run setup_git_directory(), but I'm not sure how to test that directly.
> 
> Some dirty tricks come to mind, but I am not even sure that I want to test
> for this. Why exactly do we need to avoid calling setup_git_directory() in
> that case?

I imagine that "git -p init /path/to/new/repo" would start from the
wrong directory, for instance (or any other builtin which does not have
RUN_SETUP would probably get confused).

> > > - after discover_git_directory_gently() did its work, the code happily
> > >   uses its result *only* for the current read_early_config() run, and
> > >   lets setup_git_dir_gently() do the whole work *again*. For the sake of
> > >   this RFC, I did not address that yet.
> > 
> > If caching happens at the config layer, then we'd probably only call
> > this once anyway (or if we did call it again after a config flush, it
> > would be a good sign that we should compute its value again).
> 
> I meant the git_dir, not the config... The git_dir is discovered, but a
> subsequent setup_git_dir_gently() discovers it *again*, in a different
> way.

I don't think it's such a huge amount of work that it really matters
from an optimization standpoint. The really ugly thing to me is if it
returns a different answer. And I think the best way to deal with that
is to literally use the same code (and then if you want to cache the
result and not do the work again, it's pretty easy).

-Peff
