Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AAA41F404
	for <e@80x24.org>; Fri, 16 Feb 2018 18:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751259AbeBPSpg (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 13:45:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:55380 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751501AbeBPSpd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 13:45:33 -0500
Received: (qmail 15882 invoked by uid 109); 16 Feb 2018 18:45:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 16 Feb 2018 18:45:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20812 invoked by uid 111); 16 Feb 2018 18:46:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 16 Feb 2018 13:46:17 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Feb 2018 13:45:29 -0500
Date:   Fri, 16 Feb 2018 13:45:29 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     lars.schneider@autodesk.com,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v7 1/7] strbuf: remove unnecessary NUL assignment in
 xstrdup_tolower()
Message-ID: <20180216184529.GA22189@sigill.intra.peff.net>
References: <20180215152711.158-1-lars.schneider@autodesk.com>
 <20180215152711.158-2-lars.schneider@autodesk.com>
 <CACBZZX7mh6TpbaKUYQkCgL0j0waO4=RhR55GuawrzLSBnqDmXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX7mh6TpbaKUYQkCgL0j0waO4=RhR55GuawrzLSBnqDmXA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 16, 2018 at 01:55:02PM +0100, Ævar Arnfjörð Bjarmason wrote:

> On Thu, Feb 15, 2018 at 4:27 PM,  <lars.schneider@autodesk.com> wrote:
> > Since 3733e69464 (use xmallocz to avoid size arithmetic, 2016-02-22) we
> > allocate the buffer for the lower case string with xmallocz(). This
> > already ensures a NUL at the end of the allocated buffer.
> >
> > Remove the unnecessary assignment.
> > [...]
> >         for (i = 0; i < len; i++)
> >                 result[i] = tolower(string[i]);
> > -       result[i] = '\0';
> >         return result;
> >  }
> 
> I agree with this approach, but it's worth noting for other reviewers
> that there's been some disagreement here on-list (between Eric & I)
> about whether these sorts of patterns should be removed or kept
> (although the calloc() case is slightly different from mallocz()),
> see: https://public-inbox.org/git/871shum182.fsf@evledraar.gmail.com/

Hmm. I do think xmallocz is a bit more explicit instruction of "please
NUL-terminate this for me" than xcalloc is. So I don't think it's
inconsistent to say this one is OK, but the trailing-NULL one that you
linked is not.

I'm not sure that I have a strong opinion on either case. But in general
I'd probably err on the side of leaving such lines in, for the sake of
being explicit.

Of course this particular case could just be:

  char *result = xstrdup(string);
  for (i = 0; result[i]; i++)
	result[i] = tolower(result[i]);

I picked the current implementation in 88d5a6f6cd (daemon/config: factor
out duplicate xstrdup_tolower, 2014-05-22) because it might be more
efficient (it avoids an extra copy), but I doubt it matters much in
practice.

-Peff
