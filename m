Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 407711F461
	for <e@80x24.org>; Thu, 16 May 2019 04:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfEPE1m (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 00:27:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:58998 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725975AbfEPE1l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 00:27:41 -0400
Received: (qmail 5006 invoked by uid 109); 16 May 2019 04:27:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 May 2019 04:27:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27183 invoked by uid 111); 16 May 2019 04:28:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 16 May 2019 00:28:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 May 2019 00:27:39 -0400
Date:   Thu, 16 May 2019 00:27:39 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Git ransom campaign incident report - May 2019
Message-ID: <20190516042739.GH4596@sigill.intra.peff.net>
References: <CACPiFCJdXsrywra8qPU3ebiiGQP3YPC6g-_Eohbfwu_bQgfyVg@mail.gmail.com>
 <8736lfwnks.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8736lfwnks.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 15, 2019 at 08:59:47PM +0200, Ævar Arnfjörð Bjarmason wrote:

> 
> On Wed, May 15 2019, Martin Langhoff wrote:
> 
> > Spotted this on the internet...
> >
> > https://github.blog/2019-05-14-git-ransom-campaign-incident-report/
> >
> > Haven't hacked on git for a while, and I am not affiliated with any of
> > the stakeholders. However, reading it, I wanted to slam my head on the
> > desk.
> >
> > IIRC, git will sanely store a password elsewhere if it gets to prompt
> > for it. Should we be trying to unpack usernames/passwords from HTTP
> > urls, and DTRT with them?
> >
> > Are there other ways this could be made better?
> 
> I think we should do nothing.

I think so, too.

But just brainstorming, one thing we _could_ do is issue a warning when
we see a password in a URL and say "hey, what you're doing isn't
fantastic; considering using a credential helper".

Of course I suspect there are many cases where people _do_ need to store
the password in plaintext, because an automated system needs to fetch
with it. They can use the plaintext git-credential-store, but it's
slightly more hassle. And it doesn't really _solve_ the problem (though
perhaps it would be harder to accidentally expose it with your web
server!).

> Or, for GitLab/GitHub etc. to discourage use of https API tokens in
> favor of SSH deploy keys. OpenSSH goes out of its way to not allow you
> to provide paswords in URLs, on the command-line etc. in anticipation of
> exactly this sort of scenario. Even then I've seen users write say
> docker images where they manage to hardcode an SSH private key in a
> public image out of convenience or lazyness (say needing "git clone"
> something during the image build).

You can have limited-access https tokens, too. But I don't think those
or deploy keys fix the fundamental problem, because that read access is
sufficient. The ransom is not "give us bitcoin or we will delete your
code, lock you out of your account, etc". Those things can easily be
fixed by complaining to the service provider, who has backups. The
ransom is "give me bitcoin or I will share your code with the world".
So whatever token the server has to do a fetch is enough to steal the
code (though I think deploy keys can be repo-specific, and I'm not sure
if http tokens are; that expands the attack to _all_ of the user's
repos, not just the one the server cares about).

I don't know how many people who git by this actually even want to fetch
to the server, though. They might just have blindly rsync'd up their
local checkout, and the deploy server actually never needed to know
about git in the first place.

-Peff
