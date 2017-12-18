Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D5481F424
	for <e@80x24.org>; Mon, 18 Dec 2017 13:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755725AbdLRNMw (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 08:12:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:42082 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750733AbdLRNMv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 08:12:51 -0500
Received: (qmail 1880 invoked by uid 109); 18 Dec 2017 13:12:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 Dec 2017 13:12:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25699 invoked by uid 111); 18 Dec 2017 13:13:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 18 Dec 2017 08:13:16 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Dec 2017 08:12:49 -0500
Date:   Mon, 18 Dec 2017 08:12:49 -0500
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Johannes Sixt <j6t@kdbg.org>, lars.schneider@autodesk.com,
        git@vger.kernel.org, gitster@pobox.com, patrick@luehne.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1] convert: add support for 'encoding' attribute
Message-ID: <20171218131249.GB4665@sigill.intra.peff.net>
References: <20171211155023.1405-1-lars.schneider@autodesk.com>
 <a07a0b5c-453a-f644-d5e5-7d185a943088@kdbg.org>
 <20171218101334.GA20685@tor.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171218101334.GA20685@tor.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 18, 2017 at 11:13:34AM +0100, Torsten Bögershausen wrote:

> Just to confirm my missing knowledge here:
> Does this mean, that git-gui and gitk can decode/reencode
> the content of a file/blob, when the .gitattributes say so ?

That's my impression, yes.

> If yes, would it make sense to enhance the "git diff" instead ?
> "git diff --encoding" will pick up the commited encoding from
> .attributes, convert it into UTF-8, and run the diff ?

You can do something like this already:

  git config diff.utf16.textconv 'iconv -f utf16 -t utf8'
  echo file diff=utf16 >.gitattributes

I have no objection to teaching it that "encoding" means roughly the
same thing, which would have two advantages:

 - we could do it in-process, which would be much faster

 - we could skip the extra config step, which is a blocker for
   server-side diffs on sites like GitHub

I don't think you'd really need "--encoding". This could just be
triggered by the normal "--textconv" rules (i.e., just treat this "as
if" the textconv above was configured when we see an encoding
attribute).

> We actually could enhance the "git diff" output with a single
> line saying
> "Git index-encoding=cp1251"
> or so, which can be picked up by "git apply".

That extends it beyond what textconv can do (we assume that textconv
patches are _just_ for human consumption, and can't be applied). And it
would mean you'd potentially want to trigger it in more places. On the
other hand, I don't know that we're guaranteed that a round-trip
between encodings will produce a byte-wise identical result. The nice
thing about piggy-backing on textconv is that it's already dealt with
that problem.

-Peff
