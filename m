Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5570F203C1
	for <e@80x24.org>; Mon, 12 Dec 2016 19:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752456AbcLLTte (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 14:49:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:55311 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750712AbcLLTtd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 14:49:33 -0500
Received: (qmail 1472 invoked by uid 109); 12 Dec 2016 19:49:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Dec 2016 19:49:33 +0000
Received: (qmail 8767 invoked by uid 111); 12 Dec 2016 19:50:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Dec 2016 14:50:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Dec 2016 14:49:29 -0500
Date:   Mon, 12 Dec 2016 14:49:29 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Klaus Ethgen <Klaus@Ethgen.ch>,
        git@vger.kernel.org
Subject: [PATCH 0/2] handling alternates paths with colons
Message-ID: <20161212194929.bdcihf7orjabzb2h@sigill.intra.peff.net>
References: <20161209140215.qlam6bexm5irpro2@ikki.ethgen.ch>
 <20161209152219.ehfk475vdg4levop@sigill.intra.peff.net>
 <xmqqwpf8rkeq.fsf@gitster.mtv.corp.google.com>
 <20161210085133.2pnkz6eqlxoxdckg@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161210085133.2pnkz6eqlxoxdckg@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 10, 2016 at 03:51:33AM -0500, Jeff King wrote:

> So here's the array of options, as I see it:
> 
>   1. Disable quarantine by default; only turn it on if you don't have
>      any of the funny corner cases.
> 
>   2. Introduce an extra single-item environment variable that gets
>      appended to the list of alternates, and side-steps quoting issues.
> 
>   3. Introduce a new variable that can hold an alternate list, and
>      either teach it reasonable quoting semantics, or give it a
>      less-common separator.
> 
>   4. Introduce quoting to the existing variable, but make the quoting
>      character sufficiently obscure that nobody cares about the lack of
>      backwards compatibility.

So I started on (4), but writing the user-facing documentation made me
throw up in my mouth a little. Fortunately that inspired me to come up
with a fifth option: introduce a quoting mechanism that needs a more
obscure signature to kick in, but once kicked-in, uses a less obscure
syntax.

So here are patches that do that. It kicks in only when the first
character of a path is a double-quote, and then expects the usual
C-style quoting. My reasoning is that we wouldn't want to sacrifice
'"' for ':', but it's probably OK if we only care about '"' at the very
beginning of a path. And it's consistent with many other parts of git
which allow optional quoting.

Thoughts?

  [1/2]: alternates: accept double-quoted paths
  [2/2]: tmp-objdir: quote paths we add to alternates

 Documentation/git.txt      |  6 ++++++
 sha1_file.c                | 47 +++++++++++++++++++++++++++++++++++-----------
 t/t5547-push-quarantine.sh | 19 +++++++++++++++++++
 t/t5615-alternate-env.sh   | 18 ++++++++++++++++++
 tmp-objdir.c               | 18 +++++++++++++++++-
 5 files changed, 96 insertions(+), 12 deletions(-)

-Peff
