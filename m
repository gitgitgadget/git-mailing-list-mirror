Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 879F220437
	for <e@80x24.org>; Fri, 13 Oct 2017 13:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758205AbdJMNvB (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 09:51:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:52082 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753258AbdJMNvA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 09:51:00 -0400
Received: (qmail 21862 invoked by uid 109); 13 Oct 2017 13:51:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 13:51:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25461 invoked by uid 111); 13 Oct 2017 13:51:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 09:51:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Oct 2017 09:50:58 -0400
Date:   Fri, 13 Oct 2017 09:50:58 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Constantine <hi-angel@yandex.ru>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Mike Hommey <mh@glandium.org>, git <git@vger.kernel.org>
Subject: Re: git-clone causes out of memory
Message-ID: <20171013135058.q7vhufdtin42ddic@sigill.intra.peff.net>
References: <515b1400-4053-70b0-18e2-1f61ebc3b2d7@yandex.ru>
 <20171013100603.5eed26sjjigph2il@glandium.org>
 <CAP8UFD1KuBdUCo=x_q4__s1kW15CWMH1jJkKzXqmf3=T3jcrng@mail.gmail.com>
 <20171013103722.rvr7536mu2hoo4wb@glandium.org>
 <CAP8UFD3vniWZQ9Wb1oMo-bbj8n7CTjTHUNhBRwg6jN9x0+ApAQ@mail.gmail.com>
 <xmqqr2u7uuc8.fsf@gitster.mtv.corp.google.com>
 <2f9b8856-dacc-768d-32c2-985f5f145ba7@yandex.ru>
 <20171013124456.qsbaol7txdgdb6wq@sigill.intra.peff.net>
 <f35d03b5-a525-87b3-a426-bd892edf0c36@gmail.com>
 <a4ebf552-35d4-d55f-6f08-731afa2cd2de@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4ebf552-35d4-d55f-6f08-731afa2cd2de@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 13, 2017 at 09:39:14AM -0400, Derrick Stolee wrote:

> Since I don't understand enough about the consumers to diff_tree_oid() (and
> the fact that the recursive behavior may be wanted in some cases), I think
> we can fix this in builtin/rev-list.c with this simple diff:
> 
> ---
> 
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index ded1577424..b2e8e02cc8 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -285,6 +285,9 @@ int cmd_rev_list(int argc, const char **argv, const char
> *prefix)
> 
>         git_config(git_default_config, NULL);
>         init_revisions(&revs, prefix);
> +
> +       revs.pruning.flags = revs.pruning.flags & ~DIFF_OPT_RECURSIVE;
> +

Hmm, this feels wrong, because we _do_ want to recurse down and follow
the pathspec to see if there are real changes.

We should be comparing an empty tree and d0/d0/d0/d0 (or however deep
your pathspec goes). We should be able to see immediately that the entry
is not present between the two and not bother descending. After all,
we've set the QUICK flag in init_revisions(). So the real question is
why QUICK is not kicking in.

-Peff
