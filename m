Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3494E209B8
	for <e@80x24.org>; Mon, 11 Sep 2017 18:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbdIKSld (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Sep 2017 14:41:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:34712 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751125AbdIKSlc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2017 14:41:32 -0400
Received: (qmail 24735 invoked by uid 109); 11 Sep 2017 18:41:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Sep 2017 18:41:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30089 invoked by uid 111); 11 Sep 2017 18:42:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Sep 2017 14:42:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Sep 2017 14:41:30 -0400
Date:   Mon, 11 Sep 2017 14:41:30 -0400
From:   Jeff King <peff@peff.net>
To:     Pavel Kretov <firegurafiku@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [idea] File history tracking hints
Message-ID: <20170911184130.4jm7zxinccwcuhgh@sigill.intra.peff.net>
References: <CAOZF3=Ouvk8ccME+fXr_T=GL1j4Gx3Hgj3ao_-GQng-noeOubg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOZF3=Ouvk8ccME+fXr_T=GL1j4Gx3Hgj3ao_-GQng-noeOubg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 11, 2017 at 10:11:31AM +0300, Pavel Kretov wrote:

> Unfortunately, the heuristic can only deal with simple file renames with
> no substantial content changes; it's helpless when you:
> 
>  - rename file and change it's content significantly;
>  - split single file into several files;
>  - merge several files into another;
>  - copy entire file from another commit, and do other things like these.
> 
> However, if we're able to preserve this information, it's possible
> not only to do more accurate 'git blame', but also merge revisions with
> fewer conflicts.

This is definitely something that's been discussed before on the list
(though I'm not sure of the best keywords to dig for; Stefan found one
thread but I know there have been others).

And I don't think it's a totally unreasonable idea, but there are some
complications. The biggest one is that renames are really part of a
_diff_ between two endpoints. We think of them as attached to a commit
because we tend to talk about commits as a diff from state A to state B.

So obviously in the diff HEAD^ versus HEAD, we can look at the hints for
HEAD. But what about "git diff v1.0 v1.1", that may cover multiple
commits? Right now Git doesn't look at the intermediate commits at all.
And in fact we may not even know what they are, if the command is fed
two trees. Or the two endpoints may not have a sensible history (e.g.,
consider diffing between two branches, one of which has been rebased).

But even if we had a sensible set of commits to pull hints from (e.g.,
if v1.0 and v1.1 were in a linear relationship), it's not clear to me
how you would want to apply them to an end-to-end diff.

So I don't think that these kind of tracking hints make sense for a lot
of diffs (including merges, which use diffs between the endpoints and
the merge base).

Which isn't to say that they're useless. I agree that something like
"--follow" could benefit from an annotation that tells us when and how
to pick up the next step in the traversal. But of course somebody has to
make those annotations. If we had a tool to do it automatically, then we
could apply the same tool at run-time later.

But maybe if it were an optional annotation, people would want to use it
when the normal rename logic doesn't kick in. So perhaps a baby step in
this direction would be to teach something like "--follow" to "jump"
across a non-rename when it sees a special marking in the commit
message.

-Peff
