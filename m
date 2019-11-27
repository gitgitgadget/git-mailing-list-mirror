Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701C5C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 11:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469B020684
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 11:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfK0LaI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 06:30:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:33726 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726204AbfK0LaI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 06:30:08 -0500
Received: (qmail 10517 invoked by uid 109); 27 Nov 2019 11:30:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Nov 2019 11:30:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9172 invoked by uid 111); 27 Nov 2019 11:34:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Nov 2019 06:34:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 Nov 2019 06:30:07 -0500
From:   Jeff King <peff@peff.net>
To:     chen bin <chenbin.sh@gmail.com>
Cc:     Git ML <git@vger.kernel.org>
Subject: Re: A new idea to extend git-blame
Message-ID: <20191127113007.GB22221@sigill.intra.peff.net>
References: <87o8x06sbw.fsf@sydneypc>
 <20191125141635.GD494@sigill.intra.peff.net>
 <CAAE-R+8betprfFOH+m_mMATX2mODHQ8pFUpLo4tyLVBVAVtySg@mail.gmail.com>
 <CAAE-R+8dqbxWr9an63OGCL2g1sm1h-ds3yKrzz7Shwq3UyfWxQ@mail.gmail.com>
 <CAAE-R+8yZOchnsa-au+w4JveCQffw9bpGZ54oL+DApa8Y094=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAE-R+8yZOchnsa-au+w4JveCQffw9bpGZ54oL+DApa8Y094=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 27, 2019 at 06:32:37PM +1100, chen bin wrote:

> Just double checking, the feature I suggested is fine, right? I will
> send the patch asap. It may take 2 weeks to implement.

To be clear, I can't say whether a patch is fine or not without seeing
the patch. :)

I'm not entirely sure I understand what you're proposing to implement.
But if it's of interest to you, maybe it makes sense to see if you can
make it work to your satisfaction, and then we can all look at the patch
and what it does to see if it makes sense to include in Git?

> > > I re-tested `git log -L20,20:README.md` in git's own repo with HEAD
> > > d01d26f2df. Looks git log is not what I expected. The output contains
> > > many unrelated commits. So it will be slow in real project.

Looking at the output from that command, the issue is that it's
imperfect to decide which lines in the pre- and post-image correspond to
each other. The first commit is:

  diff --git a/README.md b/README.md
  --- a/README.md
  +++ b/README.md
  @@ -26,3 +26,1 @@
  -See Documentation/gittutorial.txt to get started, then see
  -Documentation/giteveryday.txt for a useful minimum set of commands, and
  -Documentation/git-commandname.txt for documentation of each command.
  +See [Documentation/gittutorial.txt][] to get started, then see

at which point we consider all three of the pre-image lines to be
potentially interestnig. And then the next commit:

  diff --git a/README b/README
  --- a/README
  +++ b/README
  @@ -29,3 +29,3 @@
   See Documentation/gittutorial.txt to get started, then see
  -Documentation/everyday.txt for a useful minimum set of commands, and
  +Documentation/giteveryday.txt for a useful minimum set of commands, and
   Documentation/git-commandname.txt for documentation of each command.

touches one of those lines, and so forth. A human might see that in the
first hunk, it was probably the first line of the hunk that was
interesting to keep following backwards. But I don't think it can be
done automatically (which is why manual "reblame from parent" is still a
useful technique).

It sounds like your suggestion is to take some anchor text on the line
to decide which lines to keep following. But then it sounds a lot more
like a "log -L" feature than a git-blame feature.

-Peff
