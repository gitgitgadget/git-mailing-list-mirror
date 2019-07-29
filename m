Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DF5F1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 19:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390629AbfG2TuE (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 15:50:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:54472 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2390625AbfG2TuD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 15:50:03 -0400
Received: (qmail 27899 invoked by uid 109); 29 Jul 2019 19:50:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 29 Jul 2019 19:50:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32289 invoked by uid 111); 29 Jul 2019 19:51:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Jul 2019 15:51:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 29 Jul 2019 15:50:02 -0400
From:   Jeff King <peff@peff.net>
To:     Tamas Papp <tamas.papp@rtfm.co.hu>
Cc:     git@vger.kernel.org
Subject: Re: git name-rev segfault
Message-ID: <20190729195001.GE14943@sigill.intra.peff.net>
References: <799a4ba4-a2ae-7ce3-a6e4-acd329d062da@rtfm.co.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <799a4ba4-a2ae-7ce3-a6e4-acd329d062da@rtfm.co.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 29, 2019 at 04:19:47PM +0200, Tamas Papp wrote:

> Generate 100k file into a repository:
> 
> #!/bin/bash
> 
> rm -rf .git test.file
> git init
> git config user.email a@b
> git config user.name c
> 
> time for i in {1..100000}
> do
>   [ $((i % 2)) -eq 1 ] && echo $i>test.file || echo 0 >test.file
>   git add test.file
> 
>   git commit -m "$i committed"
> 
> done

I lost patience kicking off two hundred thousand processes. Try this:

  for i in {1..100000}
  do
    echo "commit HEAD"
    echo "committer c <a@b> $i +0000"
    echo "data <<EOF"
    echo "$i committed"
    echo "EOF"
    echo
  done | git fast-import

which runs much faster. This doesn't change any files in each commit,
but I don't think it's necessary for what you're showing (name-rev
wouldn't ever look at the trees).

> Run git on it:
> 
> $ git name-rev a20f6989b75fa63ec6259a988e38714e1f5328a0

Anybody who runs your script will get a different sha1 because of the
change in timestamps. I guess this is HEAD, though. I also needed to
have an actual tag to find. So:

  git tag old-tag HEAD~99999
  git name-rev HEAD

segfaults for me.

> Could you coment on it?

This is a known issue. The algorithm used by name-rev is recursive, and
you can run out of stack space in some deep cases. There's more
discussion this thread:

  https://public-inbox.org/git/6a4cbbee-ffc6-739b-d649-079ba01439ca@grubix.eu/

including some patches that document the problem with an expected
failure in our test suite. Nobody has actually rewritten the C code yet,
though.

-Peff
