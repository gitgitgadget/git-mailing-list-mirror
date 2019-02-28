Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C68220248
	for <e@80x24.org>; Thu, 28 Feb 2019 11:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731099AbfB1L0K (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 06:26:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:60926 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726027AbfB1L0K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 06:26:10 -0500
Received: (qmail 25766 invoked by uid 109); 28 Feb 2019 11:26:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Feb 2019 11:26:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13190 invoked by uid 111); 28 Feb 2019 11:26:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Feb 2019 06:26:25 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Feb 2019 06:26:08 -0500
Date:   Thu, 28 Feb 2019 06:26:08 -0500
From:   Jeff King <peff@peff.net>
To:     Max Filenko <contact@filenko.ms>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] git-am: all colons in the beginning of a subject are lost
Message-ID: <20190228112608.GA25552@sigill.intra.peff.net>
References: <m2wolk6xjw.fsf@filenko.ms>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <m2wolk6xjw.fsf@filenko.ms>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 28, 2019 at 11:02:11AM +0100, Max Filenko wrote:

>     Subject: [PATCH] :::: four colons prepended
> [...]
> There will be no colons in the beginning of a commit message if I apply
> this patch:
> 
>     $ git am 0001-four-colons-prepended.patch
>     Applying: four colons prepended

I suspect this has to do with the sanitization that happens as part of
removing "[PATCH]". Note that if you use "-k" (to preserve the subject)
it doesn't happen, though of course you also get "[PATCH]" then.

If you want to pass the subject lines through verbatim, use "-k" with
both format-patch and git-am.

> I was able to trace this down to <builtin/am.c>. It seems like there are
> no colons already in the `state->msg' which to my understanding is being
> filled by `read_commit_msg()' function. I would really appreciate a hand
> on debugging it further.

It's probably easier to debug with git-mailinfo, which has the same
behavior:

  $ git mailinfo msg patch <0001-four-colons-prepended.patch
  Author: Jeff King
  Email: peff@peff.net
  Subject: four colons prepended
  Date: Thu, 28 Feb 2019 06:12:50 -0500

and is based on the same routines.

The contents are preserved until we end up in mailinfo.c's
cleanup_subject(). And there leading colons are explicitly removed:

       case ' ': case '\t': case ':':
               strbuf_remove(subject, at, 1);
               continue;

That behavior goes all the way back to 2744b2344d (Start of early patch
applicator tools for git., 2005-04-11), when Git was only 4 days old.

Since it also handles cruft like "Re:", I suspect the goal there was I
suspect the goal there was to remove cruft like "Re::::" or "Re: :"
which sometimes happens. I don't know if anybody would complain if we
were more careful about leaving lone colons that weren't part of a "Re"
chain.

-Peff
