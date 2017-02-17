Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78F57201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 20:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935012AbdBQUmc (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 15:42:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:57404 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932303AbdBQUma (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 15:42:30 -0500
Received: (qmail 20031 invoked by uid 109); 17 Feb 2017 20:42:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 20:42:29 +0000
Received: (qmail 5791 invoked by uid 111); 17 Feb 2017 20:42:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 15:42:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Feb 2017 15:42:27 -0500
Date:   Fri, 17 Feb 2017 15:42:27 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     hIpPy <hippy2981@gmail.com>, Git Mailing List <git@vger.kernel.org>
Subject: Re: git alias for options
Message-ID: <20170217204227.kreormjoo5lr6zu4@sigill.intra.peff.net>
References: <CAM_JFCz+9mxp37BTT7XPJ0fMd41DdbAxnvQF7id9msH+SDe6_Q@mail.gmail.com>
 <CACBZZX4Zmwb8ZHGBXCpm6=yH_uxc-K1X1vv1jQ+wwnUPneqM4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX4Zmwb8ZHGBXCpm6=yH_uxc-K1X1vv1jQ+wwnUPneqM4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2017 at 02:50:23PM +0100, Ævar Arnfjörð Bjarmason wrote:

> On Fri, Feb 17, 2017 at 9:23 AM, hIpPy <hippy2981@gmail.com> wrote:
> > Git has aliases for git commands. Is there a (an inbuilt) way to alias
> > options? If not, what is the reason?
> 
> This has long been on my  wishlist, because there's a lot of
> copy/pasted logic all over Git to make git foo --whatever aliased to
> foo.whatever in the config, but only for some options.
> 
> It should ideally be part of something every option just supports, via
> the getopts struct.
> 
> However, it can't allow you to modify whatever option you want,
> because some things like git-commit-tree should not be customized
> based on config, it would break things that rely on the plumbing
> commands.
> 
> So it would have to be a whitelist for each option we allow to be
> configured like this via the getopts struct.
> 
> Also there are surely other edge cases, like maybe the config option
> now doesn't 1=1 map to the name for the option in some cases, or the
> flag should be config-able but is has no long form (which we'd like
> for the config), then we'd want to add that etc.

I think your idea is roughly equivalent in functionality to just
allowing aliases to override command names. E.g., anything you could do
with:

  [log]
  follow = true
  decorate = false

could be done with:

  [alias]
  log = "log --follow --no-decorate"

The reason we have historically not allowed that is for the
"commit-tree" plumbing reason you gave above. One option would be to
relax it for a whitelist of porcelain commands. Then your whitelist at
least only has to cover commands, and not each individual option.

I think there are a lot of corner cases in that whitelist, though. A lot
of commands serve dual porcelain/plumbing purposes. E.g., "log" and
"tag" are commonly used by both humans and by scripts.

A first step in that direction would probably be an environment variable
to tell Git to suppress command-aliases. Scripts would set that to
ensure a more vanilla experience. It doesn't fix _existing_ scripts, but
if that option were introduced, then over time scripts would start to
use it. Then eventually it would be safe(r) to introduce something like
command aliases.

But nobody has ever taken that first step, so here we are.

-Peff
