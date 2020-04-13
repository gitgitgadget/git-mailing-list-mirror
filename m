Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D6EC2BBC7
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 21:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6592920644
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 21:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389317AbgDMVxD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 17:53:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:52470 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2389293AbgDMVw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 17:52:59 -0400
Received: (qmail 379 invoked by uid 109); 13 Apr 2020 21:52:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 13 Apr 2020 21:52:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21894 invoked by uid 111); 13 Apr 2020 22:03:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Apr 2020 18:03:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 13 Apr 2020 17:52:56 -0400
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>, git@vger.kernel.org
Subject: Re: [TOPIC 2/17] Hooks in the future
Message-ID: <20200413215256.GA18990@coredump.intra.peff.net>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
 <0D7F1872-7614-46D6-BB55-6FEAA79F1FE6@jramsay.com.au>
 <20200312141628.GL212281@google.com>
 <xmqqeetwcf4k.fsf@gitster.c.googlers.com>
 <20200407230132.GD137962@google.com>
 <20200407235116.GE137962@google.com>
 <20200410213146.GA2075494@coredump.intra.peff.net>
 <20200413191515.GA5478@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200413191515.GA5478@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 13, 2020 at 12:15:15PM -0700, Emily Shaffer wrote:

> > Yeah, giving each block a unique name lets you give them each an order.
> > It seems kind of weird to me that you'd define multiple hook types for a
> > given name.
> 
> Not so odd - git-secrets configures itself for pre-commit,
> prepare-commit-msg, and commit-msg-hook. The invocation is slightly
> different ('git-secrets pre-commit', 'git-secrets prepare-commit-msg',
> etc) but to me it still makes some sense to treat it as a single logical
> unit.

Yeah, I do see how that use case makes sense. I wonder how common it is
versus having separate one-off hooks. And whether setting the order
priority for all hooks at once is that useful (e.g., I can easily
imagine a case where the pre-commit hook for program A must go before B,
but it's the other way around for another hook).

I'm just speculating, but my instinct is that it's worth trying to make
the simple things as simple as possible, while still allowing the more
complex things.

> > And it doesn't leave a lot of room for defining
> > per-hook-type options; you have to make new keys like pre-push-order
> > (though that does work because the hook names are a finite set that
> > conforms to our config key names).
> 
> Oh, interesting. I think you're saying "what if option 'frotz' only
> makes sense for prepare-commit-msg; then there's no reason to allow
> 'frotz' and 'prepare-commit-msg-frotz' and 'post-commit-frotz' and so
> on?

No, what I meant was just that if we had a hook "foo/bar", then the
natural option to control its hook-specific order would be:

  [hook "whatever"]
  order-foo/bar = 123

which isn't allowed ("/" is not valid in a key name). But that should be
OK since we control the names of hooks and can decide not to make one
with an invalid character in it. We might also support hooks for
third-party programs (e.g., if a porcelain wrapper wanted to have its
own "pre-switch-branches" hook or something), but it's not too much of
an imposition to say that the hook name should be a valid config key.

> I think I didn't do a great job explaining myself in that mail, but
> my idea was to let an unqualified option name in a hook block set the
> default, and then allow it to be overridden by qualifying it with the
> name of the hook in question:
> 
> [hook "unique-name"]
>   option = "some default"
>   post-commit-option = "post-commit specific version"
>   pre-push = ~/foo.sh pre-push
>   post-commit = ~/foo.sh post-commit

Yeah, that overriding system makes sense to me. Any other option "frotz"
would have the same constraint, though I don't think that's too big a
deal.

> Then when post-commit is invoked, option = "post-commit specific
> version"; when pre-push is invoked, option = "some default". My
> intention was to generate the hook-specific option key on the fly during
> setup.

Right that makes sense to me.

> >   [hook "pre-receive"]
> >   # put any pre-receive related options here; e.g., a rule for what to
> >   # do with hook exit codes (e.g., stop running, run all but return exit
> >   # code, ignore failures, etc)
> >   fail = stop
> 
> Interesting - so this is a default for all pre-receive hooks, that I can
> set at whichever scope I wish.

Yes. Though I had imagined "fail" as semantics for operating on the
whole list of "pre-receive" hooks, you could define it in a per-command
way, too. I was thinking of it as "this is the strategy when a command
fails". But you could also think of it as "what to do when this
particular command fails".

> >   [hookcmd "foo"]
> >   # the actual hook command to run
> >   command = /path/to/another-hook
> >   # other hook options, like order priority
> >   order = 123
> 
> Looks familiar enough. Now I worry - what if I specify 'fail' here too?

If there's a per-command version of "fail", then presumably it would
override any per-hook. I.e., I'd expect code to resolve this at
run-time, like:

  struct hook *hook = get_hook("pre-receive");
  for (i = 0; i < hook->nr; i++) {
          struct hookcmd *cmd = hook->cmds[i];

          if (run_hook(cmd->prog) != 0) {
                  enum failure_strategy f = cmd->failure_strategy;
                  if (f == FAILURE_STRATEGY_UNSET)
                          f = hook->failure_strategy;
                  switch (f) {
                  ...do whatever...
                  }
          }
  }

> It seems like I may be saying "let's set a default per hookcmd" and you
> may be saying "let's set a default per hook". Maybe you're saying "some
> options are hook-specific and some options are command-specific."

Yeah, the latter. Or it might even be that an option is sometimes
hook-specific and sometimes command-specific.

> You
> might be saying "we shouldn't need to set multiple option values for a
> single command," and I think I disagree with that based on the
> git-secrets value alone; if I'm getting ready to commit, I want
> git-secrets to run last so it can look at changes other hooks made to my
> commit, but if I'm getting ready to push, I want git-secrets to run
> first so I don't wait around for a test suite just to find that my
> commit is invalid anyways. Although, I guess with your schema the former
> would be in [hookcmd "git-secrets-committing"] and the latter
> would be in [hookcmd "git-secrets-pushing"], so I can set the ordering
> how I wish.

I think all of this is _possible_ in either scheme. We're encoding
potentially tabular data into a hierarchical config structure. In either
case I can set hook->cmd->option or cmd->hook->option. The question is
just which arrangement makes it simplest to do the most common things.

> Yeah, I see what you mean, and again I really like that. That lets us
> run multiples in config order easily:
> 
> [hook "pre-receive"]
>   command = /some/script
>   command = /some/other-script
>   command = some-hookcmd-header

Yep, config order makes sense as a default (though I think you could
make an argument for lexical order by command-name, which allows naming
things "000foo" if the user really wants to).

> If we add a little repeated-name detection then we can also reorder
> easily this way if that's the direction we want for ordering:
> 
> {global}
> hook.pre-receive.command = a.sh
> hook.pre-receive.command = b.sh
> 
> {local}
> hook.pre-receive.command = c.sh
> hook.pre-receive.command = a.sh
> 
> for a final order of {b.sh, c.sh, a.sh}.

I'm not sure what I'd expect a repeated mention of "a.sh" to do, but as
long as it's well-defined I don't really care. :)

> I wonder - I think even something like this would work:
> 
> {global}
> [hook "pre-receive"]
>   command = no-hookcmd-entry.sh
> 
> {local for repo "zork"}
> [hookcmd "no-hookcmd-entry.sh"]
>   skip = true
>
> For most repos, now I simply invoke no-hookcmd-entry.sh on pre-receive,
> but when I'm parsing the config in "zork", now I see a populated hookcmd
> entry, and when I look it up with the key I found in the global config,
> I see that it's supposed to be skipped.

Yes, exactly. The config parsing procedure is really just filling in a
"struct hookcmd" as it goes, so we don't care that they're in two
separate files.

> Although I might need to do something hacky if I have multiple hooks
> pointing to the same simple invocation:
> 
> {global}
> [hook "pre-receive"]
>   command = no-hookcmd-entry.sh
> 
> [hook "post-commit"]
>   command = no-hookcmd-entry.sh

I think your commands would be:

  command = "no-hookcmd-entry.sh pre-receive"

etc in that case, so they'd have different hookcmd blocks. You
_wouldn't_ be able to just turn off all of them with one config command,
though.

> I wonder if I'm getting buried in the weeds of stuff we won't ever have
> to worry about ;)

Yeah. I don't mind a little over-engineering as long as the easy things
remain simple, and the hard things remain possible. But that also means
we might be able to grow the hard things later (or never) as long as we
have a reasonable plan for them.

-Peff
