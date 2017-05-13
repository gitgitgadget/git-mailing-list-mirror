Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19C75201A4
	for <e@80x24.org>; Sat, 13 May 2017 08:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752079AbdEMIaS (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 04:30:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:50739 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751843AbdEMIaS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 04:30:18 -0400
Received: (qmail 25826 invoked by uid 109); 13 May 2017 08:30:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 May 2017 08:30:14 +0000
Received: (qmail 30456 invoked by uid 111); 13 May 2017 08:30:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 May 2017 04:30:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 May 2017 04:30:12 -0400
Date:   Sat, 13 May 2017 04:30:12 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v5] fetch-pack: always allow fetching of literal SHA1s
Message-ID: <20170513083012.lcs47tz3xb7avl45@sigill.intra.peff.net>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <20170511223054.25239-1-jonathantanmy@google.com>
 <20170511224639.GC21723@aiede.svl.corp.google.com>
 <xmqq37ca7gw0.fsf@gitster.mtv.corp.google.com>
 <20170512075931.umunxd72nj53snds@sigill.intra.peff.net>
 <20170512081417.w537fmd4o5rl4kja@sigill.intra.peff.net>
 <CAGf8dgLcCeMYGPF1PSPy5M5zLvj2hb_EfpDBPbcNe+96c9YpRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGf8dgLcCeMYGPF1PSPy5M5zLvj2hb_EfpDBPbcNe+96c9YpRA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2017 at 11:00:36AM -0700, Jonathan Tan wrote:

> > @@ -617,7 +632,8 @@ static void filter_refs(struct fetch_pack_args *args,
> >                                 else if (cmp == 0) {
> >                                         keep = 1; /* definitely have it */
> >                                         sought[i]->match_status = REF_MATCHED;
> > -                               }
> > +                               } else if (is_literal_sha1(sought[i]))
> > +                                       seeking_raw_oid = 1;
> 
> As far as I can tell, this seems to coincidentally work because SHA-1s
> as strings compare less than any ref name (HEAD or refs/...) - if this
> weren't the case, the "break" statement above might cause this line to
> never be executed. I'm not sure if we want to rely on that.

Right, I was thinking we'd hit all of the sought refs in this loop, but
we don't necessarily (if we run out of remote refs to compare to).
Finishing it off with:

  /* scan the remainder of the requests */
  for (; i < nr_sought; i++)
	if (is_literal_sha1(...))

though it would probably be less confusing to just do a separate loop
after the original is done.

Anyway, it looks like your v6 just keeps the lazy approach, so this is
all moot.

-Peff
