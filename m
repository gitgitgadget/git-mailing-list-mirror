Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E673720282
	for <e@80x24.org>; Thu, 15 Jun 2017 06:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbdFOGBe (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 02:01:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:40440 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750774AbdFOGBd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 02:01:33 -0400
Received: (qmail 26127 invoked by uid 109); 15 Jun 2017 06:01:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jun 2017 06:01:33 +0000
Received: (qmail 19776 invoked by uid 111); 15 Jun 2017 06:01:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jun 2017 02:01:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Jun 2017 02:01:31 -0400
Date:   Thu, 15 Jun 2017 02:01:31 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] add: warn when adding an embedded repository
Message-ID: <20170615060131.cntluubjgkfsiehh@sigill.intra.peff.net>
References: <20170613091452.ew2rwx5r6axxo65p@sigill.intra.peff.net>
 <20170613092408.db22ygki6wg2t23d@sigill.intra.peff.net>
 <CAGZ79kbbTwQicVkRs51fV91R_7ZhDtC+FR8Z-SQzRpF2cjFfag@mail.gmail.com>
 <20170614063614.a34ovimjpz2g24qe@sigill.intra.peff.net>
 <CAGZ79kaN=XVe3OWE5DHsMfbzW_rZOdRurgSfpz52dSZDA_V6fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kaN=XVe3OWE5DHsMfbzW_rZOdRurgSfpz52dSZDA_V6fg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 14, 2017 at 10:53:12AM -0700, Stefan Beller wrote:

> >> In my ideal dream world of submodules we would have the following:
> >>
> >>   $ cat .gitmodules
> >>   [submodule "sub42"]
> >>     path = foo
> >>   # path only in tree!
> >
> > TBH, I am not sure why we need "path"; couldn't we just use the
> > subsection name as an implicit path?
> 
> That is what was done back in the time. But then people wanted to rename
> submodules (i.e. move them around in the worktree), so the path is not
> constant, so either we'd have to move around the git dir whenever the
> submodule is renamed (bad idea IMO), or instead introduce a mapping
> between (constant name <-> variable path). So that was done.

Ah, right. That makes sense. I forgot that in addition to the in-tree
path, we have to store the submodule repository itself as some name. The
extra level of indirection there isn't strictly necessary, but it lets
the "name" act as a unique id.

> Historically (IIUC) we had submodule.path.url which then was changed
> to submodule.name.url + name->path resolution. And as a hack(?) or
> easy way out of a problem then, the name is often the same as the path
> hence confusing people, when they see:
> 
>     [submodule "foo"]
>         path = foo
>         url = dadada/foo
> 
> What foo means what now? ;)

Right, I am such a person that has been confused. ;)

Thanks for explaining.

> Talking about another tangent:
> 
>   For files there is a rename detection available. For submodules
>   It is hard to imagine that there ever will be such a rename detection
>   as files have because of the explciit name<->path mapping.
> 
>   We *know* when a submodule was moved. So why even try
>   to do rename detection? As we record only sha1s for a submodule
>   you could swap two submodule object names by accident.
>   Consider a superproject that contains different kernels, such as
>   a kernel for your phone/embedded device and then a kernel for
>   your workstation or other device. And these two kernels are different
>   for technical reasons but share the same history.

Do you mean during the rename detection phase of a diff, check to see if
.gitmodules registered a change in path for a particular module (by
finding its entry in the diff and looking at both sides), and if so then
mark that as a rename for the submodule paths?

From a cursory glance, that sounds like an interesting approach.

-Peff
