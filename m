Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B0001F454
	for <e@80x24.org>; Mon, 11 Nov 2019 04:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfKKEVv (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 23:21:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:44144 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726754AbfKKEVv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 23:21:51 -0500
Received: (qmail 15007 invoked by uid 109); 11 Nov 2019 04:21:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Nov 2019 04:21:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1648 invoked by uid 111); 11 Nov 2019 04:25:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 10 Nov 2019 23:25:19 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 10 Nov 2019 23:21:49 -0500
From:   Jeff King <peff@peff.net>
To:     Sebastiaan Dammann <triadsebas@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: git name-rev looks at refs/notes, refs/svn/map: stack overflow
Message-ID: <20191111042149.GE6379@sigill.intra.peff.net>
References: <CAE7Eq9jJzftkP9JWFpstS96SiCd+jO_adSQ-HruyYYNi3gWe7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE7Eq9jJzftkP9JWFpstS96SiCd+jO_adSQ-HruyYYNi3gWe7w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 09, 2019 at 12:31:31PM +0100, Sebastiaan Dammann wrote:

> The destructive workaround at the moment is to delete the refs, then
> run an aggressive gc:
> git update-ref -d refs/notes/commits
> git update-ref -d refs/svn/map
> git gc --prune=all --aggressive

If the issue is just traversing from those refs, you shouldn't need to
do a "gc". In fact, you should be able to use the "--refs" option to
name-rev to avoid them without deleting them.

All of that's obviously a workaround, though. The real issue is the
stack exhaustion.

> I hope to hear your view on this. Is this an (confirmed) issue with
> git? Are there beside the workaround I mentioned, any other
> workarounds?

Yes, this is well known. It's covered in the test suite (unfortunately
still failing, of course) since 31625b34c0 (t6120: test describe and
name-rev with deep repos, 2017-09-07).

There was a proposed fix recently in:

  https://public-inbox.org/git/20190919214712.7348-1-szeder.dev@gmail.com/

but it doesn't seem to have been picked up. I'm not sure what the
current status is.

-Peff
