Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EBBC433E1
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 07:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A8632074B
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 07:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgGOH12 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 03:27:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:57868 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728888AbgGOH12 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 03:27:28 -0400
Received: (qmail 9652 invoked by uid 109); 15 Jul 2020 07:27:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Jul 2020 07:27:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7268 invoked by uid 111); 15 Jul 2020 07:27:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Jul 2020 03:27:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Jul 2020 03:27:26 -0400
From:   Jeff King <peff@peff.net>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: [BUG?] Fetching a single tag to a local tag requires `--no-tags`
Message-ID: <20200715072726.GA3249056@coredump.intra.peff.net>
References: <12F0A2A4-CC71-4452-B8B8-F540339F8519@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <12F0A2A4-CC71-4452-B8B8-F540339F8519@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 14, 2020 at 10:17:59PM -0400, Philippe Blain wrote:

> If I want to fetch a single tag from a remote repository to a local tag,
> it seems I have to use `--no-tags`, or else all tags on the remote are fetched:
> 
> git remote add ggg https://github.com/gitgitgadget/git
> # this command fetches all tags on Gitgitgadget
> git fetch ggg tag pr-590/phil-blain/doc-log-multiple-ranges-v2
> # this command fetches only the tag listed on the command line
> git fetch ggg tag pr-590/phil-blain/doc-log-multiple-ranges-v2 --no-tags

Hmm, that's not what I see:

  $ git clone -q https://github.com/git/git tmp
  $ cd tmp
  $ git remote add ggg https://github.com/gitgitgadget/git
  $ git fetch ggg tag pr-590/phil-blain/doc-log-multiple-ranges-v2
  remote: Enumerating objects: 11, done.
  remote: Counting objects: 100% (11/11), done.
  remote: Total 18 (delta 10), reused 10 (delta 10), pack-reused 7
  Receiving objects: 100% (18/18), 7.16 KiB | 1.79 MiB/s, done.
  Resolving deltas: 100% (12/12), completed with 3 local objects.
  From https://github.com/gitgitgadget/git
   * [new tag]               pr-590/phil-blain/doc-log-multiple-ranges-v2 -> pr-590/phil-blain/doc-log-multiple-ranges-v2

> Am I reading the documentation correctly ?
> 
> tag <tag> syntax [1]:
> "tag <tag> means the same as refs/tags/<tag>:refs/tags/<tag>; 
> it requests fetching everything up to the given tag."
> 
> --no-tags [2] :
> "By default, tags that point at objects that are downloaded
> from the remote repository are fetched and stored locally.
> This option disables this automatic tag following." 

I think this last one may be an oversimplification. I'm pretty sure that
we'd download a tag that points to any object we already have, even if
it wasn't just fetched.

  [after this, we'll have the object still, but not the tag]
  $ git tag -d pr-590/phil-blain/doc-log-multiple-ranges-v2
  Deleted tag 'pr-590/phil-blain/doc-log-multiple-ranges-v2' (was 3221c3f76f)

  $ git fetch ggg tag pr-590/phil-blain/doc-log-multiple-ranges-v1
  remote: Enumerating objects: 16, done.
  remote: Counting objects: 100% (16/16), done.
  remote: Total 25 (delta 15), reused 15 (delta 15), pack-reused 9
  Receiving objects: 100% (25/25), 8.67 KiB | 2.89 MiB/s, done.
  Resolving deltas: 100% (17/17), completed with 8 local objects.
  From https://github.com/gitgitgadget/git
   * [new tag]               pr-590/phil-blain/doc-log-multiple-ranges-v1 -> pr-590/phil-blain/doc-log-multiple-ranges-v1
   * [new tag]               pr-590/phil-blain/doc-log-multiple-ranges-v2 -> pr-590/phil-blain/doc-log-multiple-ranges-v2

So in the second fetch, we got v1 and v2, because we already had the
history for v2 sitting around. In the example at the beginning of my
email, our git.git clone was pristine. But presumably you ran into this
in a repository where you'd been doing work on that or other ggg-tracked
topics.

-Peff
