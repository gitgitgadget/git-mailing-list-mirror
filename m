Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1525C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 18:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F8F560ED4
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 18:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238431AbhH3SOr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 14:14:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:34040 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238150AbhH3SOr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 14:14:47 -0400
Received: (qmail 474 invoked by uid 109); 30 Aug 2021 18:13:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 30 Aug 2021 18:13:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8877 invoked by uid 111); 30 Aug 2021 18:13:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Aug 2021 14:13:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 30 Aug 2021 14:13:51 -0400
From:   Jeff King <peff@peff.net>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>
Subject: Re: diff-index --cc no longer permitted, gitk is now broken
 (slightly)
Message-ID: <YS0f37xPKOHCDHr1@coredump.intra.peff.net>
References: <e6bd4cf7-ec8b-5d22-70f6-07089794df0c@kdbg.org>
 <875yvn9j69.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875yvn9j69.fsf@osv.gnss.ru>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 04:05:50PM +0300, Sergey Organov wrote:

> > Is gitk wrong to add --cc unconditionally? Should it do so only when
> > there are conflicts? Or not at all?
> 
> As far as I can tell, --cc had no effect on diff-index, it was just
> silently consumed. If I'm right, this line in gitk never needed --cc.
> Then either gitk is to be fixed, or we can "fix" diff-index to silently
> consume --cc/-c again, for backward compatibility.

I think it does have an effect. Try this to generate a simple merge
conflict:

  git init repo
  cd repo

  echo base >file
  git add file
  git commit -m base

  echo main >file
  git commit -am main

  git checkout -b side HEAD^
  echo side >file
  git commit -am side

  git merge main ;# maybe master here depending on your config

And then with pre-v2.33 Git, --cc does a combined diff:

  $ git.v2.32.0 diff-index -p  HEAD
  diff --git a/file b/file
  index 2299c37..81768df 100644
  --- a/file
  +++ b/file
  @@ -1 +1,5 @@
  +<<<<<<< HEAD
   side
  +=======
  +main
  +>>>>>>> main

  $ git.v2.32.0 diff-index --cc HEAD
  diff --cc file
  index df967b9,2299c37..0000000
  --- a/file
  +++ b/file
  @@@ -1,1 -1,1 +1,5 @@@
  - base
  ++<<<<<<< HEAD
  + side
  ++=======
  ++main
  ++>>>>>>> main

Likewise, --raw will show a combined diff, though it's a bit less useful
because the unmerged entry has a null sha1:

  $ git.v2.32.0 diff-index HEAD
  :100644 100644 2299c37978265a95cbe835a4b0f0bbf15aad5549 0000000000000000000000000000000000000000 M	file

  $ git.v2.32.0 diff-index --cc --raw HEAD
  ::100644 100644 100644 df967b96a579e45a18b8251732d16804b2e56a55 2299c37978265a95cbe835a4b0f0bbf15aad5549 0000000000000000000000000000000000000000 MM	file

-Peff
