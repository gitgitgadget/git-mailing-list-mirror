Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D1E320281
	for <e@80x24.org>; Tue, 23 May 2017 13:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763395AbdEWNMh (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 09:12:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:56687 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752455AbdEWNMf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 09:12:35 -0400
Received: (qmail 9053 invoked by uid 109); 23 May 2017 13:12:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 May 2017 13:12:33 +0000
Received: (qmail 31900 invoked by uid 111); 23 May 2017 13:13:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 May 2017 09:13:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 May 2017 09:12:31 -0400
Date:   Tue, 23 May 2017 09:12:31 -0400
From:   Jeff King <peff@peff.net>
To:     Tyler Brazier <tylerbrazier@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: `pull --rebase --autostash` fails when fast forward in dirty repo
Message-ID: <20170523131231.zqjkymypbilv6tyf@sigill.intra.peff.net>
References: <CAAZatrCaoB7EXVrCvC9RKmO02G5xcp8GPBaJefHfv7zAXVpL3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAZatrCaoB7EXVrCvC9RKmO02G5xcp8GPBaJefHfv7zAXVpL3Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[+cc Junio, whose code this is touching]

On Sun, May 21, 2017 at 12:17:06AM -0500, Tyler Brazier wrote:

> This script explains and tests what's going on:
> https://gist.github.com/tylerbrazier/4478e76fe44bf6657d4d3da6c789531d
> 
> pull is failing because it shortcuts to --ff-only then calls
> run_merge(), which does not know how to autostash. Removing the
> shortcut fixes the problem:

So I guess the ideal solution would be for us to do the autostash
ourselves, run the fast-forward merge, and then pop the stash. In theory
that's just "git stash push" followed by "git stash pop", but looking at
the implementation in git-rebase.sh, it looks like it's a little more
complicated than that.

Disabling the optimization sounds like a reasonable interim workaround,
but...

> diff --git a/builtin/pull.c b/builtin/pull.c
> index dd1a4a94e..225a59f5f 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -868,11 +868,6 @@ int cmd_pull(int argc, const char **argv, const
> char *prefix)
>       head = lookup_commit_reference(orig_head.hash);
>       commit_list_insert(head, &list);
>       merge_head = lookup_commit_reference(merge_heads.oid[0].hash);
> -     if (is_descendant_of(merge_head, list)) {
> -         /* we can fast-forward this without invoking rebase */
> -         opt_ff = "--ff-only";
> -         return run_merge();
> -     }

...we can probably restrict it to when autostash is in use, like:

  /*
   * If this is a fast-forward, we can skip calling rebase and
   * just do the merge ourselves. But we don't know about
   * autostash, so use the real rebase command when it's in effect.
   */
  if (!autostash && is_descendant_of(merge_head, list)) {
	opt_ff = "--ff-only";
	return run_merge();
  }

AFAICT from the commit introducing this code (33b842a1e9), and the
surrounding discussion:

  http://public-inbox.org/git/OF95D98CB6.47969C1C-ONC1257FE1.0058D980-C1257FE1.0059986D@dakosy.de/T/#u

this is purely an optimization to avoid invoking rebase, so it's OK to
skip (and interestingly, the autostash question was raised in that
thread but not resolved).

But I notice on the run_merge() code path that we do still invoke
git-merge. And rebase has been getting faster as it is moved to C code
itself. So is this optimization even worth doing anymore?

-Peff
