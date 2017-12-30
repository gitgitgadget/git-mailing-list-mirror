Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 729A01F428
	for <e@80x24.org>; Sat, 30 Dec 2017 14:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750962AbdL3OpI (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Dec 2017 09:45:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:49596 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750946AbdL3OpH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Dec 2017 09:45:07 -0500
Received: (qmail 28606 invoked by uid 109); 30 Dec 2017 14:45:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 30 Dec 2017 14:45:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4074 invoked by uid 111); 30 Dec 2017 14:45:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sat, 30 Dec 2017 09:45:36 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 30 Dec 2017 09:45:05 -0500
Date:   Sat, 30 Dec 2017 09:45:05 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>, Zefram <zefram@fysh.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] diff-tree: obey the color.ui configuration
Message-ID: <20171230144505.GA29252@sigill.intra.peff.net>
References: <87zi616vgf.fsf@evledraar.gmail.com>
 <20171229225121.13805-1-avarab@gmail.com>
 <20171229231631.GS3693@zaya.teonanacatl.net>
 <20171230015533.GA27130@sigill.intra.peff.net>
 <87tvw875vh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tvw875vh.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 30, 2017 at 01:33:06PM +0100, Ævar Arnfjörð Bjarmason wrote:

> >   - we ended up with 33c643bb08 (Revert "color: check color.ui in
> >     git_default_config()", 2017-10-13), which just reverts the whole
> >     mess back to the pre-v2.14 state. This shipped in v2.15.
> 
> Thanks. What a mess.
> 
> I haven't tried that add-interactive case you mentioned, an earlier
> version of this patch where I tried adding the color detection in
> git_diff_basic_config() did break one of its tests, but not my ptch, but
> it's probably still broken with =always (haven't tested.

It should break a test, since I added one in 33c643bb083. :)

That covers "add -p", though, which only does diff-files under the hood.
You can convince it to run "diff-index", too, but I don't think
diff-tree. So technically your patch doesn't break add--interactive, but
probably does break some other script we don't know about. ;)

> > So I don't think we want to go down that road again. If anything, we
> > want to either fix the original sin from 4c7f1819b3, or we want to do
> > the "respect only never" hack.
> 
> Getting back to the bug report that prompted this whole thing, wouldn't
> the easiest solution just to run "git show --stat $commit" instead of
> "git diff-tree --pretty $commit" when bisect wants to report the commit
> it found?
> 
> I've always thought the output was a bit ugly, it's plumbing command, so
> why wouldn't we just show the commit as the user usually prefers to see
> commits?

I like that solution. I've often found the output ugly, too. And in
particular, it doesn't show any output at all for merge commits. Doing
"diff-tree --cc --stat" would be the minimal output improvement there.

I do like the idea of using "show", though. We know the point is to show
the output to the user, so we don't mind at all if the behavior or
output of show changes in future versions (unless we consider the final
output of bisect to be machine-readable, but I certainly don't).

-Peff
