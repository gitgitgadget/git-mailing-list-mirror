Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A7E3202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 21:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753957AbdJSVkB (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 17:40:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:58418 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751524AbdJSVkA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 17:40:00 -0400
Received: (qmail 5695 invoked by uid 109); 19 Oct 2017 21:40:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 21:40:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12957 invoked by uid 111); 19 Oct 2017 21:40:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 17:40:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Oct 2017 17:39:58 -0400
Date:   Thu, 19 Oct 2017 17:39:58 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH 5/5] diff: handle NULs in get_string_hash()
Message-ID: <20171019213958.d6rp2upiga5tsvys@sigill.intra.peff.net>
References: <20171019202326.grovyfsragl2d7xx@sigill.intra.peff.net>
 <20171019203119.d2xbryov2y5t2aig@sigill.intra.peff.net>
 <CAGZ79kY3jVgBRCKkswHV7xbjiiNgvsbVsgq_9PpVwa-zTt4q0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kY3jVgBRCKkswHV7xbjiiNgvsbVsgq_9PpVwa-zTt4q0Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 02:31:20PM -0700, Stefan Beller wrote:

> > This is unlikely to ever come up in practice since our line
> > boundaries generally come from calling strlen() in the first
> > place.
> 
> get_string_hash is called from
>  prepare_entry, which in turn is called from
>   add_lines_to_move_detection or mark_color_as_moved
>    diff_flush_patch_all_file_pairs
> 
> that constructs the arguments in
> diff_flush_patch
>  run_diff
>   run_diff_cmd
>    builtin_diff (part "/* Crazy xdl interfaces.. */")
>     xdi_diff_outf( fn_out_consume as arg!)
>      xdi_diff
>       xdl_diff
>        xdl_call_hunk_func
>         -> fn_out_consume(cb, line, len)
> 
> xdl_call_hunk_func however uses pointer arithmetic instead
> of strlen. So I think this sentence is not a good idea to put in
> the commit message.
> 
> It may not occur in practice, due to binary files detection using
> NUL as a signal, but conceptually our move-colored(!) diffs
> should be compatible with NULs with this patch now.

Good catch. I just skimmed over all the diff_emit_* functions, which use
strlen(). But at the bottom is emit_add_line(), which has a real length
marker from xdiff.

I agree we wouldn't see NULs in general, but this is maybe fixing "diff
--color-moved -a". I dunno. It's probably not worth digging too much,
since it seems like the right thing to do regardless.

-Peff
