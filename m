Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A4FD206FB
	for <e@80x24.org>; Fri,  8 Jul 2016 22:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756338AbcGHWfi (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 18:35:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:42179 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756307AbcGHWfg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 18:35:36 -0400
Received: (qmail 7047 invoked by uid 102); 8 Jul 2016 22:35:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 18:35:37 -0400
Received: (qmail 16205 invoked by uid 107); 8 Jul 2016 22:35:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 18:35:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Jul 2016 18:35:33 -0400
Date:	Fri, 8 Jul 2016 18:35:33 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Wong <e@80x24.org>, Dan Wang <dwwang@google.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 2/4] receive-pack: implement advertising and receiving
 push options
Message-ID: <20160708223533.GA11056@sigill.intra.peff.net>
References: <xmqqa8htp4kc.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbkv5P0wP2kKt9gzmZBe1DjLSB8JpZD66DT_Xd4NKqmKQ@mail.gmail.com>
 <xmqqh9c1nlvm.fsf@gitster.mtv.corp.google.com>
 <20160708175821.GA29326@google.com>
 <xmqqshvkkm86.fsf@gitster.mtv.corp.google.com>
 <CAGZ79ka8eHOx28Ja+S6DOGEOrV_ijUvi_NnjprhuzQ+3O9BAoQ@mail.gmail.com>
 <20160708214637.GB9820@sigill.intra.peff.net>
 <CAGZ79kZOdcJwd0ePMquhfJTv=xZGP_+w4BRV=GyTy3ejb79yrQ@mail.gmail.com>
 <20160708222127.GA10756@sigill.intra.peff.net>
 <CAGZ79kbu1ec-8LiFrvnXqFqsjFnEofhjZnxcENa1aA1K56m9Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbu1ec-8LiFrvnXqFqsjFnEofhjZnxcENa1aA1K56m9Fg@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 08, 2016 at 03:29:09PM -0700, Stefan Beller wrote:

> > In the malicious case, the client says "I'll send you 10 push option
> > with an upper bound of 1024K", and then sends gigabytes anyway. Either
> > way the server has to react to what is sent, not what is promised.
> 
> Well that is what the initial patch did via:
> 
> +       for (i = 0; i < max_options; i++) {
> +               char *line;
> +               int len;
> +
> +               line = packet_read_line(0, &len);
> +
> +               if (!line)
> +                       break;
> +
> +               if (len > max_size)
> +                       die("protocol error: server configuration allows push "
> +                           "options of size up to %d bytes", max_size);
> +
> +               len = strcspn(line, "\n");
> +               line[len] = '\0';
> +
> +               string_list_append(ret, line);
> +       }
> +       if (i == max_options)
> +               die("protocol error: server configuration only allows up "
> +                   "to %d push options", max_options);
> 
> I assume the die is an effective way to "stop receiving".
> 
> Thinking further about what you said, I think the initial selections of
> max_size and max_options is sufficient and we only see those bounds in
> the malicious case.
> 
> This discussion rather makes me wonder if we want to stick to the initial design
> as it was easy and not overcomplicating things as we assume the abort case
> doesn't occur often.

Yes. I haven't been following the intermediate discussion and patches,
but I don't see anything wrong with the general design above. I think
you do need to use rp_error() to get the die message to the client for
non-ssh cases, though (that is a problem with other protocol-error
messages, too; I wonder if we should install a custom die handler, or
convert them all to some kind of rp_die()).

-Peff
