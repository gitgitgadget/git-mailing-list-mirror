Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82901C33CB2
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 09:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D3F520705
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 09:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgAaJ3i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 04:29:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:49370 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728213AbgAaJ3i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 04:29:38 -0500
Received: (qmail 13222 invoked by uid 109); 31 Jan 2020 09:29:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 31 Jan 2020 09:29:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30507 invoked by uid 111); 31 Jan 2020 09:37:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 Jan 2020 04:37:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 31 Jan 2020 04:29:36 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] traverse_trees(): use stack array for name entries
Message-ID: <20200131092936.GA2916051@coredump.intra.peff.net>
References: <20200130095155.GA839988@coredump.intra.peff.net>
 <20200130095338.GC840531@coredump.intra.peff.net>
 <CABPp-BE7E--8Yz3PAcjPQX2RCsbq0Q0gURi3RJuE64KM0eo6mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BE7E--8Yz3PAcjPQX2RCsbq0Q0gURi3RJuE64KM0eo6mA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 30, 2020 at 06:57:26AM -0800, Elijah Newren wrote:

> > This does increase the coupling between tree-walk and unpack-trees a
> > bit. I'd be OK just switching to ALLOC_ARRAY(), too. I doubt the
> > performance improvement is measurable, and the cleanup free() calls are
> > already there.
> 
> Could we undo this cyclic dependency between tree-walk and
> unpack-trees by defining MAX_TRAVERSE_TREES in tree-walk.h, making
> MAX_UNPACK_TREES in unpack-trees.h be defined to MAX_TRAVERSE_TREES,
> and remove the include of unpack-trees.h in tree-walk.c?

I don't mind doing that, but I had a hard time trying to write a commit
message. I.e., I can explain the current use of MAX_UNPACK_TREES here,
or defining MAX_TRAVERSE_TREES as MAX_UNPACK_TREES by saying "this is an
arbitrary limit, but it's the highest value any caller would use with
us".

But to define MAX_UNPACK_TREES in terms of MAX_TRAVERSE_TREES, I feel
we've created a circular reasoning in the justification.

I'm not even sure whether the current value of 8 is meaningful. It comes
from this commit:

  commit ca885a4fe6444bed840295378848904106c87c85
  Author: Junio C Hamano <gitster@pobox.com>
  Date:   Thu Mar 13 22:07:18 2008 -0700
  
      read-tree() and unpack_trees(): use consistent limit
      
      read-tree -m can read up to MAX_TREES, which was arbitrarily set to 8 since
      August 2007 (4 is needed to deal with 2 merge-base case).
      
      However, the updated unpack_trees() code had an advertised limit of 4
      (which it enforced).  In reality the code was prepared to take only 3
      trees and giving 4 caused it to stomp on its stack.  Rename the MAX_TREES
      constant to MAX_UNPACK_TREES, move it to the unpack-trees.h common header
      file, and use it from both places to avoid future confusion.

which kind of makes me wonder if we should just go back to calling it
MAX_TREES. I guess that's too vague, though.

So I dunno. It would be easy to do as you asked, but I'm not convinced
it actually untangles anything meaningful.

-Peff
