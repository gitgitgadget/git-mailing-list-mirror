Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7065C1F453
	for <e@80x24.org>; Mon, 24 Sep 2018 21:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbeIYDeO (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 23:34:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:57920 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728482AbeIYDeO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 23:34:14 -0400
Received: (qmail 12348 invoked by uid 109); 24 Sep 2018 21:30:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Sep 2018 21:30:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31933 invoked by uid 111); 24 Sep 2018 21:29:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 24 Sep 2018 17:29:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Sep 2018 17:30:01 -0400
Date:   Mon, 24 Sep 2018 17:30:01 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, "H . Merijn Brand" <h.m.brand@xs4all.nl>,
        Harald Nordgren <haraldnordgren@gmail.com>,
        Olga Telezhnaia <olyatelezhnaya@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ref-filter: don't look for objects when outside of a
 repository
Message-ID: <20180924213000.GA7047@sigill.intra.peff.net>
References: <20180922124215.0c8172d1@pc09.procura.nl>
 <20180922141145.10558-1-szeder.dev@gmail.com>
 <20180924181722.GA25341@sigill.intra.peff.net>
 <20180924212034.GF27036@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180924212034.GF27036@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 24, 2018 at 11:20:34PM +0200, SZEDER Gábor wrote:

> > Would we perhaps want to give the user a hint that the object is not
> > really missing, but rather that we're not in a repository? E.g.,
> > something like:
> > 
> >   if (!have_git_dir())
> > 	return strbuf_addf_ret(err, -1, "format specifier requires a repository");
> >   if (oid_object_info_extended(...))
> > 	return ...;
> > 
> > ?
> 
> I think it makes sense.
> 
> I wanted to preserve the error message, because the description of
> '--sort=<key>' in 'Documentation/git-ls-remote.txt' explicitly
> mentions it, and I added the condition at this place because I didn't
> want to duplicate the construction of the error message.

Ah, I didn't realize we actually documented that. And perhaps it is more
consistent, too: you'd get different results from running "ls-remote"
outside a repository versus one that just doesn't have the objects from
the other side.

> However, if we go for a more informative error message, then wouldn't
> it be better to add this condition in populate_value() before it even
> calls get_object()?  Then we could also add the problematic format
> specifier to the error message (I think, but didn't actually check),
> just in case someone specified multiple sort keys.

Yeah, that probably would be a better place. Though your response also
has made me think that maybe just sticking with the "missing object"
response is reasonable. I don't have a strong opinion between the two.

-Peff
