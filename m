Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5206E1F51C
	for <e@80x24.org>; Wed, 23 May 2018 04:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751193AbeEWE5S (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 00:57:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:49912 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750744AbeEWE5R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 00:57:17 -0400
Received: (qmail 15829 invoked by uid 109); 23 May 2018 04:57:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 23 May 2018 04:57:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12201 invoked by uid 111); 23 May 2018 04:57:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 23 May 2018 00:57:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 May 2018 00:57:15 -0400
Date:   Wed, 23 May 2018 00:57:15 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Pedro Alvarez <pedro.alvarez@codethink.co.uk>, git@vger.kernel.org,
        Pedro Alvarez Piedehierro <palvarez89@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add initial support for pax extended attributes
Message-ID: <20180523045714.GA5567@sigill.intra.peff.net>
References: <20180522100548.29881-1-pedro.alvarez@codethink.co.uk>
 <xmqqd0xnw14j.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd0xnw14j.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 23, 2018 at 11:34:52AM +0900, Junio C Hamano wrote:

> > @@ -90,13 +99,32 @@ foreach my $tar_file (@ARGV)
> >  			Z8 Z1 Z100 Z6
> >  			Z2 Z32 Z32 Z8 Z8 Z*', $_;
> >  		}
> > -		next if $name =~ m{/\z};
> >  		$mode = oct $mode;
> >  		$size = oct $size;
> >  		$mtime = oct $mtime;
> >  		next if $typeflag == 5; # directory
> >  
> > -		if ($typeflag != 1) { # handle hard links later
> > +		if ($typeflag eq 'x') { # extended header
> > +			# If extended header, check for path
> > +			my $pax_header = '';
> > +			while ($size > 0 && read(I, $_, 512) == 512) {
> 
> Would we ever get a short-read (i.e. we ask to read 512 bytes,
> syscall returns after reading only 256 bytes, even though next call
> to read would give the remaining 256 bytes and later ones)?

No, because perl's read() is buffered (you need sysread() to get a real
syscall read). We might read fewer than 512 if we hit EOF, but I think
that would be a truncated input, then, since ustar does everything in
512-byte records.

I do think we'd fail to notice the truncation, which isn't ideal. But it
looks like the rest of the script suffers from the same issue.

If anybody cares, it might not be too hard to wrap all of the 512-byte
read calls into a helper that dies on bogus input. I sort of assumed
this was mostly a proof of concept script and nobody used it, though. :)

It makes me wonder if there is a better-tested tar-reading module in
CPAN that could be used (though at the expense of requiring an extra
dependency).

-Peff
