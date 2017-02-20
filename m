Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E925201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 20:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750835AbdBTUwq (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 15:52:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:58920 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750827AbdBTUwq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 15:52:46 -0500
Received: (qmail 2914 invoked by uid 109); 20 Feb 2017 20:52:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Feb 2017 20:52:45 +0000
Received: (qmail 30813 invoked by uid 111); 20 Feb 2017 20:52:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Feb 2017 15:52:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Feb 2017 15:52:43 -0500
Date:   Mon, 20 Feb 2017 15:52:43 -0500
From:   Jeff King <peff@peff.net>
To:     Toolforger <toolforger@durchholz.org>
Cc:     git@vger.kernel.org
Subject: Re: url.<base>.insteadOf vs. submodules
Message-ID: <20170220205243.lynnmxouwq7jelld@sigill.intra.peff.net>
References: <84fcb0bd-85dc-0142-dd58-47a04eaa7c2b@durchholz.org>
 <20170220090115.6kfzwl62opj4q7k7@sigill.intra.peff.net>
 <404d109f-e5a7-85a3-e64c-ab1b21c3045d@durchholz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <404d109f-e5a7-85a3-e64c-ab1b21c3045d@durchholz.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 20, 2017 at 09:31:40PM +0100, Toolforger wrote:

> > The submodule operations happen in their own processes, and do not look
> > at the config of the parent repo.
> 
> Ah, then we have a docbug.
> git help config has this to say:
> 
> url.<base>.insteadOf
>     Any URL that starts with this value will be rewritten to start,
>     instead, with <base>.
> 
> The "Any" here is wrong, it would be "any except submodule" (possibly other
> exceptions).

I'm not sure that "any" is wrong here. Repository-specific config does
not cross repository boundaries. That applies to this config value, and
to all the others, too (e.g., if you set "diff.renames" in the
super-project, it would not have an effect in the submodule).

I think if there is a doc bug, it is that the repo boundary between the
submodule and the super-project is not made more clear.

That said, I do think it would be a useful feature for the super-project
to rewrite URLs before handing them off to the submodule. But I do not
really work on submodules nor use them myself, so there may be
complications.

I suppose you could argue that failing to rewrite violates the "any" in
the quoted text. It doesn't say when the rewriting occurs, but it is
essentially "when the URL is accessed". So the super-project feeds the
raw URL to the submodule `git clone`, which then applies any URL
rewriting.

> > but one workaround is to set the config in ~/.gitconfig.
> 
> No can do - that's under version control.
> My personal setup does not belong there I think ;-)

I'm not sure I understand. You have a project policy to use certain
URLs. But you, the user, want to override that. Why isn't the
user-specific config file the right place to put that?

(I think there _is_ a mismatch, in that the change is specific not just
to your user, but to the repo. So you would not want to rewrite other
references to the same URL in other repos. But that does not seem to be
your objection).

-Peff
