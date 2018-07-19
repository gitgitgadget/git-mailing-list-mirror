Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6909F1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 05:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbeGSGPT (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 02:15:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:52178 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725934AbeGSGPT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 02:15:19 -0400
Received: (qmail 9128 invoked by uid 109); 19 Jul 2018 05:34:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Jul 2018 05:34:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7413 invoked by uid 111); 19 Jul 2018 05:34:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 19 Jul 2018 01:34:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jul 2018 01:33:58 -0400
Date:   Thu, 19 Jul 2018 01:33:58 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scheibe <rene.scheibe@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: How to speedup git clone for big binary files (disable delta
 compression)
Message-ID: <20180719053357.GA23884@sigill.intra.peff.net>
References: <43b401ec-31fc-59dc-17c0-8dd7359726da@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43b401ec-31fc-59dc-17c0-8dd7359726da@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 12:05:00AM +0200, René Scheibe wrote:

> Code:
> ---------------------------------------------------------------------
> #!/bin/bash
> 
> # setup repository
> git init --quiet repo
> cd repo
> 
> echo '*.bin binary -delta' > .gitattributes
> git add .gitattributes
> git commit --quiet -m 'attributes'
> 
> for i in $(seq 10); do
>     dd if=/dev/urandom of=data.bin bs=1MB count=10 status=none
>     git add data.bin
>     git commit --quiet -m "data $i"
> done
> cd ..
> 
> # create clone repository
> time git clone --no-local repo clone

This clone won't respect those attributes, because we don't dig into
in-repo attributes. There's actually some inconsistency in how Git
handles attribute locations. Usually they're just read from the top of
the working tree, but in some instances we read them from the tree
itself (e.g., git-archive respects some attributes from the tree it's
archiving).

If you do:

  echo "*.bin binary -delta" >repo/.git/info/attributes

then that does work (we always respect repo-level attributes like that).

> # repack original repository
> cd repo
> time git repack -a -d

In this case we're reading the attributes from the working tree, and it
does work. In theory the clone case could do so, too, but git-upload-pack,
the server side of the clone, avoids looking at the working tree at all.
That's something we _could_ address, but it doesn't really fix the
general case, since most clones will be from a bare repository anyway.

So in summary:

  1. Depending on what you're trying to do, the .git/info/attributes
     trick might be enough for you.

  2. I do think it would be nice for more places to respect attributes
     from in trees. There's a question of which tree, but I think in
     general reading them from HEAD in a bare repository would do what
     people want (it's a little funny if you're fetching branch "foo",
     but HEAD points to "bar", but it's at least consistent with the
     non-bare case). There's some prior art in the way we treat mailmaps
     (in a bare repo, we read HEAD:.mailmap).

     I suspect the patch may not be trivial, as I don't know how ready
     the attributes code is to handle in-tree lookups (remember that it
     is not just HEAD:.gitattributes we must care about, but other files
     sprinkled through the repository, like "HEAD:subdir/.gitattributes".

-Peff
