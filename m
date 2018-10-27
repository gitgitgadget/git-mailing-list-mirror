Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F00A21F453
	for <e@80x24.org>; Sat, 27 Oct 2018 08:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbeJ0Qxj (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 12:53:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:57112 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728020AbeJ0Qxj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 12:53:39 -0400
Received: (qmail 27595 invoked by uid 109); 27 Oct 2018 08:13:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 27 Oct 2018 08:13:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4865 invoked by uid 111); 27 Oct 2018 08:12:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 27 Oct 2018 04:12:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Oct 2018 04:13:28 -0400
Date:   Sat, 27 Oct 2018 04:13:28 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 00/10] Reduce #ifdef NO_PTHREADS
Message-ID: <20181027081328.GF26685@sigill.intra.peff.net>
References: <20181027071003.1347-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181027071003.1347-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 27, 2018 at 09:09:53AM +0200, Nguyễn Thái Ngọc Duy wrote:

> People seemed to support the idea of removing these #ifdef NO_PTHREADS [1]
> so this is a complete series. I left the #ifdef in run-command.c and
> transport-helper.c because those code looked complicated so perhaps we
> could clean them up later. Even these updated files could be updated
> more, I think, to reduce some code duplication, but I tried to keep
> the change here minimal.
> 
> [1] https://public-inbox.org/git/20181018180522.17642-1-pclouds@gmail.com/
> 
> Nguyễn Thái Ngọc Duy (10):
>   thread-utils: macros to unconditionally compile pthreads API
>   index-pack: remove #ifdef NO_PTHREADS
>   name-hash.c: remove #ifdef NO_PTHREADS
>   attr.c: remove #ifdef NO_PTHREADS
>   send-pack.c: remove #ifdef NO_PTHREADS
>   grep: remove #ifdef NO_PTHREADS
>   preload-index.c: remove #ifdef NO_PTHREADS
>   pack-objects: remove #ifdef NO_PTHREADS
>   read-cache.c: remove #ifdef NO_PTHREADS
>   Clean up pthread_create() error handling

Compiling with NO_PTHREADS=1, I get (with gcc 8.2.0):

read-cache.c: In function ‘do_read_index’:
read-cache.c:1820:4: error: ‘copy_len’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
    memcpy(ce->name, previous_ce->name, copy_len);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
read-cache.c:1749:9: note: ‘copy_len’ was declared here
  size_t copy_len;

which seems wrong to me. It's always tied to expand_name_field being
true. And curiously an earlier use doesn't trigger the warning. I wonder
if some kind of tricky pointer aliasing in the intervening code makes it
think that expand_name_field could change, but I sure don't see it.

I ran the tests under ASan/UBSan, since this series seems like it has a
good chance of accidentally causing issues there, but didn't come up
with any problems (except for the ones already fixed on pu by 8628ace269
(commit-reach: fix cast in compare_commits_by_gen(), 2018-10-01)).

-Peff
