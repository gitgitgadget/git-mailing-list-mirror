Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E529C433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78ABA20774
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732987AbgFWPYh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:24:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:40098 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732885AbgFWPYh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 11:24:37 -0400
Received: (qmail 11768 invoked by uid 109); 23 Jun 2020 15:24:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Jun 2020 15:24:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16863 invoked by uid 111); 23 Jun 2020 15:24:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Jun 2020 11:24:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Jun 2020 11:24:36 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [alternative 0/10] fast-export: allow seeding the anonymized mapping
Message-ID: <20200623152436.GA50925@coredump.intra.peff.net>
References: <20200619132304.GA2540657@coredump.intra.peff.net>
 <20200622214745.GA3302779@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200622214745.GA3302779@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 22, 2020 at 05:47:46PM -0400, Jeff King wrote:

> Here's a v2 which I think addresses all of the comments. I have to admit
> that after writing my last email to Junio, I am wondering whether it
> would be sufficient and simpler to let the user specify a static mapping
> of tokens (that could just be applied anywhere).
> 
> I'll take a look at that, but since I worked up this version, here it is
> in the meantime.

So here's that alternative. I think the result is actually a bit nicer
to work with, _and_ it's a lot less code. Don't let the number of
patches fool you. Most of it is cleanup that would be worth doing even
without the final patches.

Both of these techniques _could_ live side-by-side within fast-export,
as they have slightly different strengths and weaknesses. But I'd prefer
to just go with one (this one) in the name of simplicity, and I strongly
suspect nobody will ever ask for the other.

  [01/10]: t9351: derive anonymized tree checks from original repo
  [02/10]: fast-export: use xmemdupz() for anonymizing oids

    These first two are actually a bug-fix that I noticed while writing
    it.

  [03/10]: fast-export: store anonymized oids as hex strings
  [04/10]: fast-export: tighten anonymize_mem() interface to handle only strings
  [05/10]: fast-export: stop storing lengths in anonymized hashmaps
  [06/10]: fast-export: use a flex array to store anonymized entries
  [07/10]: fast-export: move global "idents" anonymize hashmap into function
  [08/10]: fast-export: add a "data" callback parameter to anonymize_str()

    This is all cleanup and prep. More than is strictly necessary for
    this series, but it does simplify things and reduce the memory
    footprint (only a few megabytes in git.git, but more in larger
    repos).

  [09/10]: fast-export: allow seeding the anonymized mapping

    And then this is the actual feature...

  [10/10]: fast-export: anonymize "master" refname

    ...which finally lets us drop the special name rule.

 Documentation/git-fast-export.txt |  24 +++++
 builtin/fast-export.c             | 161 +++++++++++++++++++-----------
 t/t9351-fast-export-anonymize.sh  |  54 +++++++---
 3 files changed, 167 insertions(+), 72 deletions(-)

