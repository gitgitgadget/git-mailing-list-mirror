Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7783D20986
	for <e@80x24.org>; Tue, 27 Sep 2016 19:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934084AbcI0TO5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 15:14:57 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42121 "EHLO mx2.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753269AbcI0TOz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 15:14:55 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u8RJEi0j019950
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Tue, 27 Sep 2016 21:14:44 +0200
Received: from z8-mb-verimag.imag.fr (z8-mb-verimag.imag.fr [129.88.4.38])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u8RJEkZC031977;
        Tue, 27 Sep 2016 21:14:46 +0200
Date:   Tue, 27 Sep 2016 21:14:45 +0200 (CEST)
From:   Gustavo Grieco <gustavo.grieco@imag.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Message-ID: <1528663490.8544563.1475003685969.JavaMail.zimbra@imag.fr>
In-Reply-To: <xmqqponpqqri.fsf@gitster.mtv.corp.google.com>
References: <1825523389.8224664.1474812766424.JavaMail.zimbra@imag.fr> <381383122.8376940.1474943423005.JavaMail.zimbra@imag.fr> <20160927080755.evlq3sfkyoolixop@sigill.intra.peff.net> <xmqqponpqqri.fsf@gitster.mtv.corp.google.com>
Subject: Re: Possible integer overflow parsing malformed objects in git
 2.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [129.88.6.115]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF43 (Linux)/8.0.9_GA_6191)
Thread-Topic: Possible integer overflow parsing malformed objects in git 2.10.0
Thread-Index: fb5roBZ//5DfYKSnonovaaN/GzG4KQ==
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Tue, 27 Sep 2016 21:14:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u8RJEi0j019950
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: gustavo.grieco@imag.fr
MailScanner-NULL-Check: 1475608485.30725@M0GdcvXGD2sbGBB7t0Xk/A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

----- Original Message -----
> Jeff King <peff@peff.net> writes:
> 
> > That being said, the parse_sha1_header() function clearly does not
> > detect overflow at all when parsing the size. So on a 32-bit system, you
> > end up with:
> >
> >   $ git fsck
> >   fatal: Out of memory, malloc failed (tried to allocate 4294967141 bytes)
> >
> > which is not correct, but I'm not sure it's a security problem.  Integer
> > overflows are an issue if they cause us to under-allocate, and then to
> > write more bytes than we allocated. In this case, I would expect
> > unpack_sha1_rest() to never write more bytes than the "size" we parsed
> > and allocated (and to complain if the number of bytes we get from the
> > zlib sequence do not exactly match the claimed size).
> >
> > So a more interesting example is more like "ULONG_MAX + 5", where we
> > would overflow to 5 bytes. And we'd hope that unpack_sha1_rest does not
> > ever write more than 5 bytes. From my reading and a few tests with gdb,
> > it does not. However, it also does not notice that there were more bytes
> > that we didn't use.
> >
> > So I think there's room for improved diagnosis of bogus situations
> > (including integer overflows), but I don't see any actual security bugs.

Great, it is exactly the type of analysis i was expecting. 

> 
> I agree with the overall conclusion.  This does look like an attempt
> to throw random fuzz at Git and see if and how it breaks, and in this
> particular one Git is simply doing the right thing (and the fault lies
> in the way how ASAN is used and how its result was interpreted).
> 
> Throwing random fuzz to see what breaks is not a bad thing to do
> per-se, but anybody who does so without wearing a black hat needs to
> keep two things in mind:
> 
>  * When a random fuzz attempt does uncover a security issue,
>    reporting it here on this list is a grossly irresponsible way to
>    disclose the issue.  We have the git-security list for that.

That is reasonable, indeed. As we discussed, this type of issues are very unlikely to be easily exploited (or even possible), so i did not think that it could be irresponsible to post this issue here. I will be happy to post only in git-security if you think my reports can uncover security issues (but so far, it was not the case). It is also interesting to mention that git-security is not linked anywhere in the official website (git-scm.com) or the github repository (github.com/git/git).

> 
>  * A random fuzz may stop Git and that may be perfectly legit thing
>    to happen, e.g. the data may request a large but still valid
>    amount of memory to be allocated that happens not to fit in the
>    hardware the fuzz attempt is being run, and xmalloc() may detect
>    the situation and die, like the above example.  False positives
>    are expected and you want to make sure you cull them before
>    making your reports.  Otherwise, they will unnecessary burden
>    people who are doing real work, i.e. reproduce and correct
>    problems that may be security related that are irresponsibly
>    disclosed here quickly enough to minimize damage.

I try to discard false positives as much as possible. Despite we just started adding the git generation module to our tool, we got hundreds of aborts caused by the allocation limits of AddressSanitizer: I only reported the one which specifically contains a size that could be interpreted as negative number (in fact, valgrind will also report this issue a 'fishy size' for malloc).
Also, I think my reports should are clear enough to reproduce any issue and i carefully check every test case for reproducibility, still i am open to suggestion on how to improve my bug reports! 

> 
> Thanks.
> 
> 
