Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C301A209FD
	for <e@80x24.org>; Thu, 25 May 2017 19:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939187AbdEYTLS (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 15:11:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:58046 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935251AbdEYTLR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 15:11:17 -0400
Received: (qmail 23973 invoked by uid 109); 25 May 2017 19:11:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 May 2017 19:11:17 +0000
Received: (qmail 22823 invoked by uid 111); 25 May 2017 19:11:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 May 2017 15:11:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 May 2017 15:11:15 -0400
Date:   Thu, 25 May 2017 15:11:15 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        =?utf-8?B?RsOpbGl4?= Saparelli <felix@passcod.name>,
        git@vger.kernel.org
Subject: Re: [Non-Bug] cloning a repository with a default MASTER branch
 tries to check out the master branch
Message-ID: <20170525191115.tqd6zlj5mxqls4wp@sigill.intra.peff.net>
References: <CACQm2Y1QtKD3M6weNhGrAQSLV8hLF4pKcpHDD7iUc78aWrt6Cw@mail.gmail.com>
 <xmqqa864mea3.fsf@gitster.mtv.corp.google.com>
 <76BD8B6A1511438B8CCB79C616F3BC5B@PhilipOakley>
 <20170524141947.2gguzcvyu6lch373@sigill.intra.peff.net>
 <xmqqshjtg1kh.fsf@gitster.mtv.corp.google.com>
 <xmqqa861fx34.fsf@gitster.mtv.corp.google.com>
 <20170525155924.hk5jskennph6tta3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170525155924.hk5jskennph6tta3@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 25, 2017 at 11:59:24AM -0400, Jeff King wrote:

> The just-HEAD case could look like:

This patch does work, in the sense that upload-pack advertises the
unborn HEAD symref. But the client doesn't actually do anything with it.
The capability parsing happens in get_remote_heads(), which passes the
data out by adding an annotation to the "struct ref" list. But of course
we have no HEAD ref to annotate.

So either get_remote_heads() would have to start returning a bogus HEAD
ref (with a null sha1, I guess, which all callers would have to
recognize). Or clone (and probably "remote set-head -a") would have to
start reaching across the transport-module boundary and asking for any
symref values for "HEAD". I'm not excited about more special-casing of
"HEAD", though. In theory we'd want this for other symrefs in the long
run, and it would be nice if clients were ready to handle that (even if
the protocol isn't quite there).

I dunno. I was thinking there might be a quick tweak, but I'm wondering
if this arcane case is worth the restructuring we'd have to do to
support it. It only comes up when you've moved the server repo's HEAD to
an unborn branch _and_ you have other refs (since otherwise we don't
even send capabilities at all!).

-Peff
