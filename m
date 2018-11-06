Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE56A1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 06:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbeKFPcz (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 10:32:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:41742 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729342AbeKFPcz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 10:32:55 -0500
Received: (qmail 13374 invoked by uid 109); 6 Nov 2018 06:09:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Nov 2018 06:09:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28334 invoked by uid 111); 6 Nov 2018 06:08:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 06 Nov 2018 01:08:39 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Nov 2018 01:09:19 -0500
Date:   Tue, 6 Nov 2018 01:09:19 -0500
From:   Jeff King <peff@peff.net>
To:     Farhan Khan <khanzf@gmail.com>
Cc:     pclouds@gmail.com, gitster@pobox.com, git@vger.kernel.org
Subject: Re: Understanding pack format
Message-ID: <20181106060919.GA17521@sigill.intra.peff.net>
References: <CAFd4kYBDWMvVgDmNTzwOK9Q7n_Fb0NrvNAFgHtKvkLkRFWqUKw@mail.gmail.com>
 <xmqqlg6covi6.fsf@gitster-ct.c.googlers.com>
 <CACsJy8DFUeEddSa2z4VTSqhaUBJ4+SUf8xvjh6iWY2Phhh96iQ@mail.gmail.com>
 <CAFd4kYDcX2BOYvMg1X9zO68EfYYE6Zke_-9CGY-Yi01jCc3EPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFd4kYDcX2BOYvMg1X9zO68EfYYE6Zke_-9CGY-Yi01jCc3EPA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 05, 2018 at 09:23:45PM -0500, Farhan Khan wrote:

> I am trying to identify where the content from a pack comes from. I
> traced it back to sha1-file.c:read_object(), which will return the
> 'content'. I want to know where the 'content' comes from, which seems
> to come from sha1-file.c:oid_object_info_extended. This goes into
> packfile.c:find_pack_entry(), but from here I get lost. I do not
> understand what is happening.
> 
> How does it retrieve the pack content? I am lost here. Please assist.
> This is in the technical git documentation, but it was not clear.

After find_pack_entry() tells us the object is in a pack, we end up in
packed_object_info(). Depending what the caller is asking for, there are
a couple different strategies (because we try to avoid loading the whole
object if we don't need it).

Probably the one you're interested in is just grabbing the content,
which happens via cache_or_unpack_entry(). The cached case is less
interesting, so try unpack_entry(), which is what actually reads the
bytes out of the packfile.

-Peff
