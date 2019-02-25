Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0160420248
	for <e@80x24.org>; Mon, 25 Feb 2019 17:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbfBYRSY (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 12:18:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:56958 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728639AbfBYRSY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 12:18:24 -0500
Received: (qmail 14437 invoked by uid 109); 25 Feb 2019 17:18:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Feb 2019 17:18:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18608 invoked by uid 111); 25 Feb 2019 17:18:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 25 Feb 2019 12:18:33 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Feb 2019 12:18:17 -0500
Date:   Mon, 25 Feb 2019 12:18:17 -0500
From:   Jeff King <peff@peff.net>
To:     Matthew Booth <mbooth@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] git log -L ... -s does not suppress diff output
Message-ID: <20190225171817.GA17524@sigill.intra.peff.net>
References: <CAEkQehdFu5zM4AY3ihN0pn1aCNEomY0WV07pryfAB45JN-tDDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEkQehdFu5zM4AY3ihN0pn1aCNEomY0WV07pryfAB45JN-tDDA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 25, 2019 at 05:03:50PM +0000, Matthew Booth wrote:

> Example output:
> 
> =========
> $ git --version
> git version 2.20.1
> 
> $ git log -L 2957,3107:nova/compute/manager.py -s
> commit 35ce77835bb271bad3c18eaf22146edac3a42ea0
> <snip>
> 
> diff --git a/nova/compute/manager.py b/nova/compute/manager.py
> --- a/nova/compute/manager.py
> +++ b/nova/compute/manager.py
> @@ -2937,152 +2921,151 @@
>      def rebuild_instance(self, context, instance, orig_image_ref, image_ref,
>                           injected_files, new_pass, orig_sys_metadata,
> <snip>
> =========

At first I wondered why you would want to do this, since the point of -L
is to walk through that diff. But I suppose you might want to see just
the commits, without the actual patch, and that's what "-s" ought to do.

> git log docs suggest it should not do this:
> 
>        -s, --no-patch
>            Suppress diff output. Useful for commands like git show
> that show the patch by default, or to cancel
>            the effect of --patch.
> 
> Couldn't find anything in a search of the archives of this mailing
> list, although that's obviously far from conclusive. Seems to be
> longstanding, as it was mentioned on StackOverflow back in 2015:

I think the issue is just that "-L" follows a very different code path
than the normal diff generator. Perhaps something like this helps?

diff --git a/line-log.c b/line-log.c
index 63df51a08f..ed46a3a493 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1106,7 +1106,8 @@ int line_log_print(struct rev_info *rev, struct commit *commit)
 	struct line_log_data *range = lookup_line_range(rev, commit);
 
 	show_log(rev);
-	dump_diff_hacky(rev, range);
+	if (!(rev->diffopt.output_format & DIFF_FORMAT_NO_OUTPUT))
+		dump_diff_hacky(rev, range);
 	return 1;
 }
 

-Peff
