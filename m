Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B8F0201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 23:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753265AbdBUXkm (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 18:40:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:59595 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753112AbdBUXkk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 18:40:40 -0500
Received: (qmail 10078 invoked by uid 109); 21 Feb 2017 23:40:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Feb 2017 23:40:40 +0000
Received: (qmail 17448 invoked by uid 111); 21 Feb 2017 23:40:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Feb 2017 18:40:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Feb 2017 18:40:37 -0500
Date:   Tue, 21 Feb 2017 18:40:37 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Toolforger <toolforger@durchholz.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: url.<base>.insteadOf vs. submodules
Message-ID: <20170221234037.ga44u3birwd5whab@sigill.intra.peff.net>
References: <84fcb0bd-85dc-0142-dd58-47a04eaa7c2b@durchholz.org>
 <20170220090115.6kfzwl62opj4q7k7@sigill.intra.peff.net>
 <404d109f-e5a7-85a3-e64c-ab1b21c3045d@durchholz.org>
 <20170220205243.lynnmxouwq7jelld@sigill.intra.peff.net>
 <28fb85d4-89cd-1f32-3063-2f48d8b935be@durchholz.org>
 <20170221070653.65ho2anbp55uzjeu@sigill.intra.peff.net>
 <CAGZ79kZgMbEZy7hoA+VxsKdKBavt59SmC1c6FpDdgrW2GKMHvQ@mail.gmail.com>
 <20170221230029.cs36tjwpsw2opuwp@sigill.intra.peff.net>
 <CAGZ79kby-UhUqci9Mgdhw+wvS5Y39=Q7AmCrWaTMWbcZPNT6Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kby-UhUqci9Mgdhw+wvS5Y39=Q7AmCrWaTMWbcZPNT6Dw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2017 at 03:16:27PM -0800, Stefan Beller wrote:

> > I guess one answer is that this is the wrong approach entirely, and the
> > right one is something like: submodules should understand that they are
> > part of a superproject, and respect some whitelisted set of config from
> > the superproject .git/config file.
> 
> This would break one of the core assumptions that submodules
> are "independent" repos.

Yeah, that was the "first half" that I said was hard. :)

You could rationalize it under the fact that they _are_ independent
repos; we're just adding a new config source.  Arguably it could be a
feature for any repository embedded inside the working tree of another,
submodule or not, to consider the outer repository as a (limited) source
of config.

But there are probably a lot of irritating corner cases with the whole
concept unless we apply a strict whitelist of keys (e.g., you probably
don't want remote.* to be propagated). And as the recent
GIT_CONFIG_PARAMETERS whitelist showed, that approach ended up confusing
and annoying.

So maybe the whole thing is insane, and the right answer is that config
values should go into ~/.gitconfig. And we may need better tools there
for limiting that global config to certain parts of the tree (like Duy's
conditional include thing).

> Though I do not know if this is actually a good assumption.
> e.g. "[PATCH v2] git-prompt.sh: add submodule indicator"
> https://public-inbox.org/git/1486075892-20676-2-git-send-email-email@benjaminfuchs.de/
> really had trouble in the first version to nail down how to tell you are in
> a submodule, but people want to know that.

Right, I think it's an interesting thing to know, but I agree there are
probably a lot of corner cases.

> Maybe we need to change that fundamental assumption.
> So a more sophisticated way (thinking long term here) would be
> to include the superprojects config file (with exceptions), and that
> config file has more priority than e.g. the ~/.gitconfig file, but less
> than the submodules own $GIT_DIR/config file.

Yeah, that priority matches what I had been thinking.

> > One other caveat: I'm not sure if we do insteadOf recursively, but it
> > may be surprising to the child "git clone" that we've already applied
> > the insteadOf rewriting (especially if the rules are coming from
> > ~/.gitconfig and may be applied twice).
> 
> When a rule is having effect twice the rule sounds broken. (the outcome
> ought to be sufficiently different from the original?)

If you have:

  url.bar.insteadOf=foo
  url.baz.insteadOf=bar

do we convert "foo" to "baz"? If so, then I think applying the rules
again shouldn't matter. But if we don't, and only do a single level,
then having the caller rewrite the URL before it hands it to "git clone"
means we may end up unexpectedly doing two levels of rewriting.

-Peff
