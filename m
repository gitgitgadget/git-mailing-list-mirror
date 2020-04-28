Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CC6C83004
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 05:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFEFD206B8
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 05:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgD1Fl4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 01:41:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:41872 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726042AbgD1Fl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 01:41:56 -0400
Received: (qmail 18312 invoked by uid 109); 28 Apr 2020 05:41:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 Apr 2020 05:41:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31534 invoked by uid 111); 28 Apr 2020 05:53:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Apr 2020 01:53:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Apr 2020 01:41:55 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com,
        Stefan Tauner <stefan.tauner@gmx.at>
Subject: Re: [PATCH v3] git-credential-store: skip empty lines and comments
 from store
Message-ID: <20200428054155.GB2376380@coredump.intra.peff.net>
References: <20200427084235.60798-1-carenas@gmail.com>
 <20200427125915.88667-1-carenas@gmail.com>
 <xmqqftco94wx.fsf@gitster.c.googlers.com>
 <20200427191858.GB1728884@coredump.intra.peff.net>
 <xmqqv9lk7j7p.fsf@gitster.c.googlers.com>
 <20200428052510.GA201501@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200428052510.GA201501@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 27, 2020 at 10:25:10PM -0700, Jonathan Nieder wrote:

> I wonder if in addition to the above documentation change we may want
> something guaranteed to catch all cases where people would have
> experienced a regression, like
> 
> diff --git i/credential-store.c w/credential-store.c
> index c010497cb21..294e7716815 100644
> --- i/credential-store.c
> +++ w/credential-store.c
> @@ -24,8 +24,8 @@ static int parse_credential_file(const char *fn,
>  	}
>  
>  	while (strbuf_getline_lf(&line, fh) != EOF) {
> -		credential_from_url(&entry, line.buf);
> -		if (entry.username && entry.password &&
> +		if (!credential_from_url_gently(&entry, line.buf, 1) &&
> +		    entry.username && entry.password &&
>  		    credential_match(c, &entry)) {
>  			found_credential = 1;
>  			if (match_cb) {
> 
> And then we can tighten the handling of unrecognized lines to first
> warn and then error out, as a controlled change that doesn't lead
> people to regret updating git.

I like that solution, as it mostly brings us back to the original
behavior, as weird or unexpected as it was.

The only I think would be different is:

  ://user:pass@example.com

which I think the old code would have treated as matching any protocol
(and the new code will reject as a bogus URL).

I wondered if you'd need to free the partially-parsed struct fields on
failure, but the answer is no; we'd clear it the next time through the
loop, or at the very end of the function.

-Peff
