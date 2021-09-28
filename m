Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C3CC433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 22:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A987761391
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 22:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243113AbhI1Wa7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 18:30:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:57164 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243072AbhI1Wa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 18:30:59 -0400
Received: (qmail 11511 invoked by uid 109); 28 Sep 2021 22:29:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Sep 2021 22:29:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5258 invoked by uid 111); 28 Sep 2021 22:29:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Sep 2021 18:29:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Sep 2021 18:29:17 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/7] merge-ort: add ability to record conflict messages
 in a file
Message-ID: <YVOXPTjsp9lrxmS6@coredump.intra.peff.net>
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <ed71913886e19ccc276b382de707b4bab7834d12.1630376800.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ed71913886e19ccc276b382de707b4bab7834d12.1630376800.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 02:26:35AM +0000, Elijah Newren via GitGitGadget wrote:

> There are several considerations here:
>   * We have to pick file(s) where we write these conflict messages too
>   * We want to make it as clear as possible that it's not a real file
>     but a set of messages about another file
>   * We want conflict messages about a file to appear near the file in
>     question in a diff, preferably immediately preceding the file in
>     question
>   * Related to the above, per-file conflict messages are preferred
>     over lumping all conflict messages into one big file
> 
> To achive the above:
>   * We put the conflict messages for $filename in
>       $filename[0:-1] + " " + $filename[-1] + ".conflict_msg"
>     or, in words, we insert a space before the final character of
>     the filename and then also add ".conflict_msg" at the end.

It took me a minute to understand the space thing. I thought at first it
was about avoiding conflicts with existing names (and while it might
help in practice, it's not a guarantee). But I think it's about the
"appear preceding the file" goal. The space sorts before any other
printable character in the final position.

That's...simultaneously clever and gross. My biggest complaint is that
the space looks like a bug in the output.

Using another character like "." might not be too bad, as it's also
fairly early in the ascii table. But it's really this "do it before the
last character" thing that is key to getting the ordering right.

Just brainstorming some alternatives:

 - we have diff.orderFile, etc. Could we stuff this data into a less
   confusing name (even just "$filename.conflict_msg"), and then provide
   a custom ordering to the diff code? I think it could be done by
   generating a static ordering ahead of time, but it might even just be
   possible to tell diffcore_order() to take the ".conflict_msg"
   extension into account in its comparison function.

 - there can be other non-diff data between the individual segments. For
   example, "patch" will skip over non-diff lines. And certainly in Git
   we have our own custom headers. I'm wondering if we could attach
   these annotations to the diff-pair somehow, and then show something
   like:

     diff --git a/foo.c b/foo.c
     index 1234abcd..5678cdef 100644
     conflict modify/delete foo.c
     --- a/foo.c
     +++ b/foo.c
     @@ some actual diff starts here @@

Obviously such a thing can't really be applied. But then you wouldn't
want to apply the addition of "my.file e.conflict_msg" either.

I dunno. The latter especially is definitely more work, and requires a
bit more cooperation between the merge and diff code. In particular, you
can't just feed a straight tree to the diff anymore. We have to hold
back the annotations, and then apply them to the resulting diff. But I
think the output is much more pleasing to the eye.

-Peff
