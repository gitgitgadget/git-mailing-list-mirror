Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28F0F1F461
	for <e@80x24.org>; Thu,  2 May 2019 08:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfEBIu4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 04:50:56 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53996 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfEBIu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 04:50:56 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id B61091F45F;
        Thu,  2 May 2019 08:50:55 +0000 (UTC)
Date:   Thu, 2 May 2019 08:50:55 +0000
From:   Eric Wong <e@80x24.org>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, meta@public-inbox.org
Subject: Re: "IMAP IDLE"-like long-polling "git fetch"
Message-ID: <20190502085055.34kkll2deowat6il@dcvr>
References: <20181229034342.11543-1-e@80x24.org>
 <20181229035621.cwjpknctq3rjnlhs@dcvr>
 <20181229043858.GA28509@pure.paranoia.local>
 <CAGZ79kb9Tbnxe1mSnxpqT_FO6Gdi6wxd-r2YarHXRF1sVRyxLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kb9Tbnxe1mSnxpqT_FO6Gdi6wxd-r2YarHXRF1sVRyxLA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> wrote:
> IIRC, More than half the bandwidth of Googles git servers are used
> for ls-remote calls (i.e. polling a lot of repos, most of them did *not*
> change, by build bots which are really eager to try again after a minute).

Thinking back at that statement; I think polling can be
optimized in git, at least.

IIRC, your repos have lots of refs; right?
(which is why it's a bandwidth problem)

Since info/refs is a static file (hopefully updated by a
post-update hook), the smart client can make an HTTP request
to check If-Modified-Since: to avoid the big response.

The client would need to cache the mtime of the last requested
refs file; somewhere.

IOW, do refs negotiation the "dumb" way; since it's no better
than the smart way, really.  Keep doing object transfers the
smart way.

During the initial clone, smart servers could probably
have a header informing clients that their info/refs
is up-to-date and clients can do dumb refs negotiation.
