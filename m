Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AEC31FAFB
	for <e@80x24.org>; Sat,  8 Apr 2017 09:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752013AbdDHJ3Q (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 05:29:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:58431 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751968AbdDHJ3P (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 05:29:15 -0400
Received: (qmail 32000 invoked by uid 109); 8 Apr 2017 09:29:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Apr 2017 09:29:12 +0000
Received: (qmail 10327 invoked by uid 111); 8 Apr 2017 09:29:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Apr 2017 05:29:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Apr 2017 05:29:10 -0400
Date:   Sat, 8 Apr 2017 05:29:10 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Matt McCutchen <matt@mattmccutchen.net>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Tools that do an automatic fetch defeat "git push
 --force-with-lease"
Message-ID: <20170408092910.g5wl2ew4cfu7wzft@sigill.intra.peff.net>
References: <1491617750.2149.10.camel@mattmccutchen.net>
 <CACBZZX7MeX-6RHgh2Fa9+YL03mjxs8xmyE86HnVxBxjMYizcig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX7MeX-6RHgh2Fa9+YL03mjxs8xmyE86HnVxBxjMYizcig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 08, 2017 at 09:35:04AM +0200, Ævar Arnfjörð Bjarmason wrote:

> Is it correct that you'd essentially want something that works like:
> 
>     git push --force-with-lease=master:master origin master:master

I don't think that would do anything useful. It would reject any push
where the remote "master" is not the same as your own master. And of
course if they _are_ the same, then the push is a noop.

> I haven't used this feature but I'm surprised it works the way it
> does, as you point out just having your remote refs updated isn't a
> strong signal for wanting to clobber whatever that ref points to.

The point of the --force-with-lease feature is that you would mark a
point in time where you started some rewind-y operation (like a rebase),
and at the end you would want to make sure nobody had moved the remote
ref when you push over it (which needs to be a force because of the
rewind).

So the best way to use it is something like:

  git fetch              ;# update 'master' from remote
  git tag base master    ;# mark our base point
  git rebase -i master   ;# rewrite some commits
  git push --force-with-lease=master:base master:master

That final operation will fail if somebody else pushed in the meantime.
But obviously this workflow is a pain, because you have to manually mark
the start of the unsafe operation with a tag.

If you haven't fetched in the meantime, then origin/master is a good
approximation of "base". But if you have fetched, then it is worthless.

It would be nice if we could automatically deduce the real value of
base. I don't think we could do it in a foolproof way, but I wonder if
we could come close in some common circumstances. For instance, imagine
that unsafe operations like rebase would note that "master" has an
upstream of "origin/master", and would record a note saying "we took a
lease for origin/master at sha1 X".

One trouble with that is that you may perform several unsafe operations.
For example, imagine it takes you multiple rebases to achieve your final
state:

  git fetch
  git rebase -i master
  git rebase -i master
  git push --force-with-lease=master

and that --force-with-lease now defaults to whatever lease-marker is
left by rebase. Which marker should it respect? If the second one, then
it's unsafe. But if the first one, then how do we deal with stale
markers?

Perhaps it would be enough to reset the markers whenever the ref is
pushed. I haven't thought it through well enough to know whether that
just hits more corner cases.

-Peff
