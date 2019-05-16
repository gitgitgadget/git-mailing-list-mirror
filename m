Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DB5F1F461
	for <e@80x24.org>; Thu, 16 May 2019 04:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfEPEvm (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 00:51:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:59026 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725975AbfEPEvm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 00:51:42 -0400
Received: (qmail 5193 invoked by uid 109); 16 May 2019 04:51:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 May 2019 04:51:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27287 invoked by uid 111); 16 May 2019 04:52:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 16 May 2019 00:52:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 May 2019 00:51:40 -0400
Date:   Thu, 16 May 2019 00:51:40 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 0/7] Multiple hook support
Message-ID: <20190516045140.GA7241@sigill.intra.peff.net>
References: <20190514002332.121089-1-sandals@crustytoothpaste.net>
 <20190514004920.GB136746@google.com>
 <20190514015928.GG7458@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190514015928.GG7458@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 14, 2019 at 01:59:28AM +0000, brian m. carlson wrote:

> There are two aspects here which I think are worth discussing. Let's
> discuss the inheritance issue first.
> 
> Order with multiple hooks matters. The best hook as an example for this
> is prepare-commit-msg. If I have a hook which I want to run on every
> repository, such as a hook that inserts some sort of ID (bug tracker,
> Gerrit, etc.), that hook, due to inheritance, *has* to be first, before
> any other prepare-commit-msg hooks. If I want a hook that runs before
> it, perhaps because a particular repository needs a different
> configuration, I have to wipe the list and insert both hooks. I'm now
> maintaining two separate locations for the command lines instead of just
> inserting a symlink to the global hook and dropping a new hook before
> it.

This part confuses me. In the config based scheme you describe, you have
to mention the original hook again. But isn't that exactly what creating
a symlink in your hooks directory is doing?

And in fact, I think a config based scheme can be a lot more flexible in
the end, simply because the parser _does_ see all of the hooks (whereas
in the hook directory scheme, we only ever look in one directory). So we
can have an option to sort them before running: alphabetically,
system-to-repo order, repo-to-system order, etc.

> The second issue here is that it's surprising. Users don't know how to
> reset a configuration option because we don't have a consistent way to
> do that. Users will not expect for there to be multiple ways to set
> hooks. Users will also not expect that their hooks in their
> configuration aren't run if there are hooks in .git/hooks. Tooling that
> has so far used .git/hooks will compete with users' global configuration
> options, which I guarantee you will be a surprise for users using older
> versions of tools.

I don't agree here. If the rule is "config takes precedence", and "if
config is absent "behave as if .git/hooks/whatever was in the config",
then the transition is easy to explain. And nobody sees any change at
all until they decide to set the config. It would probably also be
prudent to issue a warning if there's config _and_ an on-disk hook file
(or even run them both, though then you open up the question of
ordering).

Which isn't to say it's impossible for a person to get confused (new
tool sets the config, disabling their old hook?). But I think any
transition to multi-hook support (including your directory scheme) is
going to have some possibility that tools automatically setting things
up behind the scenes is going to confuse a user.

> It also provides a convenient place for hooks to live, which a
> config-based option doesn't. We'll need to invoke things using /bin/sh,
> so will they all have to live in PATH? What about one-offs that don't
> really belong in PATH?

Actually, my biggest beef with the current hooks mechanism is that it's
an _inconvenient_ place for them to live.

  - it's not version controlled, and putting a repository inside another
    repository is awkward (though it at least works for the bare case)

  - touching the filesystem is awkward and expensive if you have a large
    number of repositories whose hooks you want to update

  - it requires a manual step to modify the filesystem after a fresh
    clone (as opposed to putting things in ~/.gitconfig). Technically
    one can solve this by modifying .../share/git/templates, but that
    has its own issues.

In my world-view config-based hooks would just be run with SHELL_PATH,
just like our other config options. If you don't want one-offs in your
PATH, then use absolute paths (just like you would have to for
symlinks). If you really don't know where to put one-off hooks, perhaps
we could document a base directory from which the hook script is run,
and you could put it in a directory in .git and use a relative path? You
could even call that directory "hooks", but I suspect that would be too
confusing. :)

-Peff
