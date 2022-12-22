Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A490C4167B
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 17:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiLVRkS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 12:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiLVRkO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 12:40:14 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89E113D71
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 09:40:13 -0800 (PST)
Received: (qmail 11167 invoked by uid 109); 22 Dec 2022 17:40:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 Dec 2022 17:40:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13658 invoked by uid 111); 22 Dec 2022 17:40:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 Dec 2022 12:40:14 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 22 Dec 2022 12:40:12 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric DeCosta <edecosta@mathworks.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2022, #03; Mon, 10)
Message-ID: <Y6SWfOQrvOkLM67P@coredump.intra.peff.net>
References: <xmqqlepnz1vu.fsf@gitster.g>
 <Y0S7/jA5tNeoQ2Hm@coredump.intra.peff.net>
 <xmqqczazx7dn.fsf@gitster.g>
 <Y0Vq3iGifYeBxPbn@coredump.intra.peff.net>
 <92cc457a-d267-d20f-b516-295646b989ca@gmx.de>
 <Y6OTR2iwcORPsTxz@coredump.intra.peff.net>
 <221222.867cyjx0d3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221222.867cyjx0d3.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 22, 2022 at 09:58:01AM +0100, Ævar Arnfjörð Bjarmason wrote:

> > I do think it would be less noisy if we could somehow convince Coverity
> > that yes, strbuf really does NUL-terminate the result. But I haven't
> > wanted to sink time into figuring out how to annotate it.
> 
> I don't have Coverity set up, but perhaps it's satisfied by the same
> thing that placeted GCC's -fanalyzers in strbuf.c:
> 
> 	https://lore.kernel.org/git/RFC-patch-07.15-cf1a5f3ed0f-20220603T183608Z-avarab@gmail.com/
> 
> I run my local build with a version of that branch, I'd still like to
> follow-up on it (and as that RFC thread shows others had some alternate
> suggestions, e.g. for this strbuf case).

I don't think that will help. The most common strbuf problem in Coverity
is "this string isn't NUL terminated". And having walked through their
step-by-step analysis, I think what is going on is that it sees that:

  strbuf_addstr(&sb, "foo");

is doing:

  memcpy(sb->buf, "foo", strlen(foo));

under the hood, and it says "aha, this is an anti-pattern where you
forgot to copy the NUL byte!" and creates a warning. And it ignores
completely the fact that the next line is calling strbuf_setlen() and
adding the NUL byte.

Now there may be other false positives around strbufs (like not
realizing the buffer grows), but this is the one I feel like I've seen
the most.

> I don't think it's true that a strbuf "really does NUL-terminate the
> result" the way an analyzer like -fanalyzer sees it. I.e. if you do:
> 
> 	struct strbuf sb = { .alloc = 123 };
> 	strbuf_addstr(&sb, "blah");
> 
> You'll segfault because the sb->buf isn't the slopbuf, nor
> '\0'-terminated, it's just NULL.

Yeah, I didn't mean to say that there can't be real problems with
strbufs. I just meant that there are many false positives where the code
is correct, but the tool doesn't realize it.

-Peff
