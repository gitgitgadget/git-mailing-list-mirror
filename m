Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4167A1F516
	for <e@80x24.org>; Thu, 21 Jun 2018 18:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754251AbeFUSJs (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 14:09:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34292 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754177AbeFUSJr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 14:09:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ECA5FF68B6;
        Thu, 21 Jun 2018 18:09:46 +0000 (UTC)
Received: from redhat.com (unknown [10.40.205.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 782F42026D6B;
        Thu, 21 Jun 2018 18:09:45 +0000 (UTC)
Date:   Thu, 21 Jun 2018 20:09:43 +0200
From:   Pavel Cahyna <pcahyna@redhat.com>
To:     Jeff King <peff@peff.net>
Cc:     Sebastian Kisela <skisela@redhat.com>, git@vger.kernel.org,
        nico@fluxnic.net, larsxschneider@gmail.com, lfleischer@lfos.de
Subject: Re: [PATCH] Sanitize escape char sequences coming from server
Message-ID: <20180621180942.GA32506@redhat.com>
Mail-Followup-To: Jeff King <peff@peff.net>,
        Sebastian Kisela <skisela@redhat.com>, git@vger.kernel.org,
        nico@fluxnic.net, larsxschneider@gmail.com, lfleischer@lfos.de
References: <20180621121030.1721-1-sebastian.kisela@gmail.com>
 <20180621174122.GA30249@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621174122.GA30249@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 21 Jun 2018 18:09:47 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 21 Jun 2018 18:09:47 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'pcahyna@redhat.com' RCPT:''
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Thu, Jun 21, 2018 at 01:41:22PM -0400, Jeff King wrote:
> On Thu, Jun 21, 2018 at 02:10:30PM +0200, Sebastian Kisela wrote:
> 
> > From: Sebastian Kisela <skisela@redhat.com>
> > +	int len = mbstowcs(wcstring, outbuf->buf, outbuf->len);
> 
> I don't think mbstowcs() is always going to do the right thing there.
> We're looking at a string that was sent from the remote server. What
> encoding is it in? Using mbstowcs() is going to use whatever is in
> LC_CTYPE on the local machine.

Exactly. The point is, everything should continue to work if the local
machine and the server agreed on the encoding. Imagine a
non-English-speaking site where the administrators configured the Git
server to output non-ASCII messages and the clients are configured with
a matching locale which allows the users to see them. We should ensure
everything keeps working in this case.

> > +	for(int i = 0; i <= len; i++)
> > +		if(!isprint(wcstring[i]) && !isspace(wcstring[i]) )
> > +			wcstring[i] = '?';
> > +		if (wcstombs(outbuf->buf, wcstring, outbuf->len) == -1)
> > +			return 1;
> 
> Funny indentation. I think the second line is supposed to _not_ be in
> the loop, so this is just funny indentation and not wrong code.
> 
> Using isprint() here probably doesn't do what you expect, because Git
> uses its own locale-agnostic ctype replacements. I didn't check, but I
> suspect any non-ascii characters will be marked as non-printable, making
> the whole wchar thing pointless.

isw*() was probably intended instead of is*()

> Your replacement allows existing spaces, which is good; many servers
> send carriage-returns as part of progress output (and recv_sideband
> detects these and makes sure the line remains prefixed with "remote:").
> 
> > @@ -74,6 +89,9 @@ int recv_sideband(const char *me, int in_stream, int out)
> >  				} else {
> >  					strbuf_addch(&outbuf, *brk);
> >  				}
> > +
> > +				if (sanitize_server_message(&outbuf))
> > +					retval = SIDEBAND_REMOTE_ERROR;
> 
> "outbuf" may contain partially-received lines at various points, meaning
> multi-byte characters could be cut off. I _think_ it's OK to look at it
> here, as we'd always be breaking on a "\r" or "\n" at this point.

Maybe sanitize_server_message should return a mbstate_t to keep state
between invocations?

Thanks, Pavel
