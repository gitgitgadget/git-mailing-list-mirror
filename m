Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A76B01F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 21:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752512AbdARVIa (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 16:08:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:41123 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752747AbdARVI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 16:08:29 -0500
Received: (qmail 19904 invoked by uid 109); 18 Jan 2017 21:08:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Jan 2017 21:08:23 +0000
Received: (qmail 31736 invoked by uid 111); 18 Jan 2017 21:09:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Jan 2017 16:09:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jan 2017 16:08:21 -0500
Date:   Wed, 18 Jan 2017 16:08:21 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matt McCutchen <matt@mattmccutchen.net>, git@vger.kernel.org
Subject: Re: "git diff --ignore-space-change --stat" lists files with only
 whitespace differences as "changed"
Message-ID: <20170118210821.xugr6jnvzgoxpynb@sigill.intra.peff.net>
References: <1484704915.2096.16.camel@mattmccutchen.net>
 <20170118111705.6bqzkklluikda3r5@sigill.intra.peff.net>
 <xmqqvatc3x3r.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqvatc3x3r.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2017 at 12:57:12PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So I dunno. A sensible rule to me is "iff -p would show a diff header,
> > then --stat should mention it".
> 
> True but tricky (you need a better definition of "a diff header").
> 
> In addition to a new and deleted file, does a file whose executable
> bit was flipped need mention?  If so, then "diff --git" is the diff
> header in the above.  Otherwise "@@ ... @@", iow, "iff -p would show
> any hunk".
> 
> I think the patch implements the latter, which I think is sensible.

I would think the former is more sensible (and is what my patch is
working towards). Doing:

  >empty
  git add empty
  git diff --cached

shows a "diff --git" header, but no hunk. I think it should show a
diffstat (and does with my patch).

I was thinking the rule should be something like:

  if (p->status == DIFF_STATUS_MODIFIED &&
      !file->added && !file->deleted))

and otherwise include the entry, since it would be an add, delete,
rename, etc, which carries useful information.

Though a pure rename would not hit this code path at all, I would think
(it would not trigger "!same_contents"). And a rename where there was a
whitespace only change probably _should_ be omitted from "-b".

Ditto for a pure mode change, I think. We do not run the contents
through diff at all, so it does not hit this code path.

-Peff
