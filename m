Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC5711F437
	for <e@80x24.org>; Sat, 28 Jan 2017 03:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750865AbdA1DyA (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 22:54:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:46249 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750789AbdA1Dx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 22:53:58 -0500
Received: (qmail 25179 invoked by uid 109); 28 Jan 2017 03:53:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 28 Jan 2017 03:53:24 +0000
Received: (qmail 11717 invoked by uid 111); 28 Jan 2017 03:53:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 Jan 2017 22:53:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Jan 2017 22:53:21 -0500
Date:   Fri, 27 Jan 2017 22:53:21 -0500
From:   Jeff King <peff@peff.net>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: difflame
Message-ID: <20170128035321.yrcqwkg2fiwadxj4@sigill.intra.peff.net>
References: <CAOc6etaCk=OEyarMNhorM94MBnYRscCkJBM-K08snv1ecmOaPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOc6etaCk=OEyarMNhorM94MBnYRscCkJBM-K08snv1ecmOaPQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 17, 2017 at 11:24:02PM -0600, Edmundo Carmona Antoranz wrote:

> For a very long time I had wanted to get the output of diff to include
> blame information as well (to see when something was added/removed).

This is something I've wanted, too. The trickiest part, though, is
blaming deletions, because git-blame only tracks the origin of content,
not the origin of a change.

For example, try this case:

  git init
  for i in $(seq 1 10); do
    echo $i >>file
    git add file
    git commit -m "add $i"
  done
  sed 4d <file >tmp && mv tmp file
  git commit -am "drop 4"

Running "difflame HEAD~5 HEAD" produces this output:

  diff --git a/file b/file
  index b414108..051c298 100644
  --- a/file
  +++ b/file
  @@ -1,6 +1,9 @@
   ^2b028ff (Jeff King 2017-01-27 22:44:10 -0500 1) 1
   ed056366 (Jeff King 2017-01-27 22:44:10 -0500 2) 2
   771030d8 (Jeff King 2017-01-27 22:44:10 -0500 3) 3
  -89c09c82 (Jeff King 2017-01-27 22:44:10 -0500 4) 4
   b619039c (Jeff King 2017-01-27 22:44:10 -0500 4) 5
   6a7aa0e5 (Jeff King 2017-01-27 22:44:10 -0500 5) 6
  +39bc9dc4 (Jeff King 2017-01-27 22:44:10 -0500 6) 7
  +f253cc8f (Jeff King 2017-01-27 22:44:10 -0500 7) 8
  +85c10f46 (Jeff King 2017-01-27 22:44:10 -0500 8) 9
  +89c09c82 (Jeff King 2017-01-27 22:44:10 -0500 9) 10

The last 4 lines are right; they correspond to the addition commits. But
the line taking away 4 is wrong. You can see even without looking at its
patch, because it is blamed to the same commit that added "10", which
is wrong.

Sorry I don't have a solution. I think it's an open problem with
git-blame, though you could probably script something around "git blame
--reverse". See the commit message of 85af7929e (git-blame --reverse,
2008-04-02) for some discussion.

-Peff
