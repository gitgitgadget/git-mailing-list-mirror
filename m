Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2B8C201A7
	for <e@80x24.org>; Wed, 17 May 2017 13:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753103AbdEQNR5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 09:17:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:53629 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751936AbdEQNR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 09:17:56 -0400
Received: (qmail 4976 invoked by uid 109); 17 May 2017 13:17:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 May 2017 13:17:56 +0000
Received: (qmail 9440 invoked by uid 111); 17 May 2017 13:18:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 May 2017 09:18:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 May 2017 09:17:53 -0400
Date:   Wed, 17 May 2017 09:17:53 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 10/23] files_ref_store: put the packed files lock
 directly in this struct
Message-ID: <20170517131753.rditx62clmkrdmeq@sigill.intra.peff.net>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
 <dd7637060bac1a27e03563edc82649812dcf897c.1495014840.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd7637060bac1a27e03563edc82649812dcf897c.1495014840.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 02:05:33PM +0200, Michael Haggerty wrote:

> Instead of using a global `lock_file` instance for the main
> "packed-refs" file and using a pointer in `files_ref_store` to keep
> track of whether it is locked, embed the `lock_file` instance directly
> in the `files_ref_store` struct and use the new
> `is_lock_file_locked()` function to keep track of whether it is
> locked. This keeps related data together and makes the main reference
> store less of a special case.

This made me wonder how we handle the locking for ref_stores besides the
main one (e.g., for submodules). The lockfile structs have to remain
valid for the length of the program. Previously those stores could have
xcalloc()'d a lockfile and just leaked it. Now they'll need to xcalloc()
and leak their whole structs.

I suspect the answer is "we don't ever lock anything except the main ref
store because that is the only one we write to", so it doesn't matter
anyway.

-Peff
