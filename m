Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0704D1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 22:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbdAYWWh (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 17:22:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:44907 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751482AbdAYWWg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 17:22:36 -0500
Received: (qmail 7954 invoked by uid 109); 25 Jan 2017 22:22:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 22:22:36 +0000
Received: (qmail 17172 invoked by uid 111); 25 Jan 2017 22:22:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 17:22:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jan 2017 17:22:34 -0500
Date:   Wed, 25 Jan 2017 17:22:34 -0500
From:   Jeff King <peff@peff.net>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     git@vger.kernel.org, apelisse@gmail.com, kevin@sb.org,
        gitster@pobox.com
Subject: Re: [PATCH v1 1/3] blame: add --aggregate option
Message-ID: <20170125222233.rckzhn7lpk63yppq@sigill.intra.peff.net>
References: <20170125052734.17550-1-eantoranz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170125052734.17550-1-eantoranz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 24, 2017 at 11:27:32PM -0600, Edmundo Carmona Antoranz wrote:

> To avoid taking up so much space on normal output printing duplicate
> information on consecutive lines that "belong" to the same revision,
> this option allows to print a single line with the information about
> the revision before the lines of content themselves.

I admit I have not followed the preceding discussion closely, so ignore
me if my suggestion is way off base.

But it really seems like the various outputs you are looking for are
really all about customizing git-blame's human-readable output.

Would it be more productive to move towards a "--format" option that
shows custom items for each line? It could build on the custom formats
in the pretty-print code (though I think you would want to add some
custom ones, like filename, line number, line content, etc).

I know that only does half of what you want, which is making some output
not just per-line, but per-block. But that can come easily on top, if we
allow separate per-line and per-block formats (which would default to
the current output and the empty string, respectively).

Then you could do something like:

  git blame --format-block='%h %an <%ae>%n  %s' \
            --format-line='\t%(filename):%(linenumber) %(linecontent)'

and get something like:

    1234abcd A U Thor <author@example.com>
      initial commit
            foo.c:1 #include <foo.h>
            foo.c:2 #include <bar.h>
    5678abcd A U Thor <author@example.com>
      add third include
            foo.c:3 #include <third.h>

and so on. But people can mix and match what they want to see on each
line, and what they'd rather push to other lines.

I don't have a huge interest in the feature myself. I switched to "tig
blame" years ago and never looked back. But it just seems like your
options touch no this kind of flexibility, but will limit somebody as
soon as they want to switch around which information goes where.

-Peff
