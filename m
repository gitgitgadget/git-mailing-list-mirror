Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 999101FEB3
	for <e@80x24.org>; Wed, 11 Jan 2017 11:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932553AbdAKLhb (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 06:37:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:37933 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760563AbdAKLha (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 06:37:30 -0500
Received: (qmail 25556 invoked by uid 109); 11 Jan 2017 11:37:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 Jan 2017 11:37:29 +0000
Received: (qmail 21267 invoked by uid 111); 11 Jan 2017 11:38:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 Jan 2017 06:38:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jan 2017 06:37:25 -0500
Date:   Wed, 11 Jan 2017 06:37:25 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Michael J Gruber <git@drmicha.warpmail.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH 0/5] Localise error headers
Message-ID: <20170111113725.avl3wetwrfezdni2@sigill.intra.peff.net>
References: <cover.1483354746.git.git@drmicha.warpmail.net>
 <20170104070514.pxdthvilw66ierfz@sigill.intra.peff.net>
 <8d0966d0-1ef1-3d1e-95f5-6e6c1ad50536@drmicha.warpmail.net>
 <20170110090418.4egk4oflblshmjon@sigill.intra.peff.net>
 <CAGZ79kYVc0YQ4okrTHGiYQzPqfiVAm_f7orXdkhwgf5kMPXj-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYVc0YQ4okrTHGiYQzPqfiVAm_f7orXdkhwgf5kMPXj-w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 10, 2017 at 10:28:42AM -0800, Stefan Beller wrote:

> > And then presumably that mix would gradually move to 100% consistency as
> > more messages are translated. But the implicit question is: are there
> > die() messages that should never be translated? I'm not sure.
> 
> I would assume any plumbing command is not localizing?
> Because in plumbing land, (easily scriptable) you may find
> a grep on the output/stderr for a certain condition?

That's the assumption I'm challenging. Certainly the behavior and
certain aspects of the output of a plumbing command should remain the
same over time. But error messages to stderr?

It seems like they should be translated, because plumbing invoked on
behalf of porcelain scripts is going to send its stderr directly to the
user.

> To find a good example, "git grep die" giving me some food of though:
> 
> die_errno(..) should always take a string marked up for translation,
> because the errno string is translated?

Yes, I would think die_errno() is a no-brainer for translation, since
the strerror() will be translated.

>     apply.c:                die(_("internal error"));
> 
> That is funny, too. I think we should substitute that with
> 
>     die("BUG: untranslated, but what went wrong instead")

Yep. We did not consistently use "BUG:" in the early days. I would say
that "BUG" lines do not need to be translated. The point is that nobody
should ever see them, so it seems like there is little point in giving
extra work to translators.

-Peff
