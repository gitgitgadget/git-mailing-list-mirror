Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7080AC433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 11:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57A8560F9D
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 11:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241607AbhJ0LQj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 07:16:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:47902 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239601AbhJ0LQj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 07:16:39 -0400
Received: (qmail 13108 invoked by uid 109); 27 Oct 2021 11:14:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Oct 2021 11:14:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21564 invoked by uid 111); 27 Oct 2021 11:14:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Oct 2021 07:14:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 Oct 2021 07:14:12 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: pre-v2.34.0-rc0 regressions: 'git log' has a noisy iconv()
 warning (was: What's cooking in git.git (Oct 2021, #06; Mon, 25))
Message-ID: <YXk0hAgaSJbLUgeB@coredump.intra.peff.net>
References: <xmqq5ytkzbt7.fsf@gitster.g>
 <211026.86y26gyqui.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211026.86y26gyqui.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 26, 2021 at 01:15:00PM +0200, Ævar Arnfjörð Bjarmason wrote:

> 
> On Mon, Oct 25 2021, Junio C Hamano wrote:
> 
> > The fifteenth batch of topics are in 'master'.  I expect that this
> > is more-or-less what we can expect in the -rc0, unless there is a
> > hotfix to what's already merged.
> 
> I suggested a way forward for these iconv warnings that will be new in
> 2.34.0 at [1], poked'd a few days ago at [2].

Sorry to let this go for so long.

I do agree with your line of reasoning that it would be nice to
sanity-check the incoming encoding once, but I think the details of
doing so make things to tricky (to the point that it isn't worth doing;
see my response just now in that thread).

> Jeff: What do you think? Per [1] I think it's best to drop it entirely
> for now, or split out just the "completely unknown encoding" problem
> from "can't decode this particular thing".
> 
> You also had a patch in [3] that wasn't picked up, which would warn
> about this once.
> 
> If we *are* going to warn that seems like the worst of both in some
> sense, i.e. we'll no longer give users anything like "in this huge
> commit stream, we couldn't search in commit XYZ", instead we just warn
> on whatever happens to be the first commit, and you'll have no idea if
> subsequent matches were completed or not.

Yeah. I pretty much hate all of the options here. ;)

The firehose of warnings for "git log --encoding=nonsense" was known and
discussed in fd680bc558 (logmsg_reencode(): warn when iconv() fails,
2021-08-27). It's ugly for sure, but I'm still OK with it for the
reasoning there: your next step is to fix the --encoding argument you
gave. Whether you saw one line of warning or many is not that important,
IMHO. Giving a single more sensible warning ("your encoding 'nonsense'
isn't valid") would be better, but I think it's hard to do without
creating other problems.

But the most compelling argument against warning at all is the case you
gave earlier: that there may be historical garbage commits, and you
can't get rid of them, so being warned constantly that we're not going
to show or grep them correctly is just annoying. And that is true
whether the user sees one warning or a hundred.

So while I do hate to have Git just silently ignore errors, probably the
original behavior is the least-bad thing, and we should just revert
fd680bc558 (logmsg_reencode(): warn when iconv() fails, 2021-08-27). We
probably want to salvage the documentation change (minus the "along with
a warning") part.

Do you want to do the honors?

-Peff
