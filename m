Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED0472023D
	for <e@80x24.org>; Mon, 22 May 2017 20:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762117AbdEVUMQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 16:12:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:56234 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762038AbdEVUMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 16:12:16 -0400
Received: (qmail 22562 invoked by uid 109); 22 May 2017 20:12:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 May 2017 20:12:14 +0000
Received: (qmail 24349 invoked by uid 111); 22 May 2017 20:12:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 May 2017 16:12:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 May 2017 16:12:12 -0400
Date:   Mon, 22 May 2017 16:12:12 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     DOAN Tran Cong Danh <congdanhqx@gmail.com>, git@vger.kernel.org,
        animi.vulpis@gmail.com, j6t@kdbg.org,
        Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] ref-filter: treat CRLF as same as LF in find_subpos
Message-ID: <20170522201212.uuas26n6npdebsxg@sigill.intra.peff.net>
References: <CA+izobvwRCwGEtpCbey=gFbCh9sHBb5xB1i1LpMG0JCUy0O2mQ@mail.gmail.com>
 <20170521134209.25659-1-congdanhqx@gmail.com>
 <xmqqy3tppu13.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy3tppu13.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 22, 2017 at 10:19:52AM +0900, Junio C Hamano wrote:

> However.
> 
> If you look at how `git branch -v` before that problematic change
> removed the extra CR, you would notice that pretty_print_commit()
> was used for that, which eventually called format_subject() with
> "one\r\n\r\nline3...", got one line "one\r\n" by calling
> get_one_line(), adjusted the line length from 5 to 3 by calling
> is_blank_line() which as a side effect trims all whitespaces (not
> just LF and CR), and emitted "one".  The reason why the next \r\n
> was not mistaken as a non-empty line is the same---is_blank_line()
> call onthe next line said that "\r\n" is an all-white space line.

I noticed a similar thing regarding pretty_print_commit(). Which really
made me wonder whether the right solution is to drop the custom parsing
code in ref-filter.c and use the bits from pretty.c. Then we'd have only
one parser. That's less code, but more importantly, there can't be
inconsistencies between the two (we're fixing one now, but we have no
idea if there are others).

I suspect that's more work because we'd need to refactor pretty.c a bit
to make the right functionality available. But the end result would be
much more maintainable.

-Peff

PS I'm also a bit curious how a CRLF got into a commit message in the
   first place. Stripspace should be removing that for normal "git
   commit" runs. I don't know that we've ever said it explicitly, but I
   think we'd consider the canonical in-repo object representation to be
   LF-only (just like we do for smudge/clean filters). Which means that
   whatever is generating these commit objects is arguably buggy.
