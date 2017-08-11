Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96BD1208C4
	for <e@80x24.org>; Fri, 11 Aug 2017 07:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752457AbdHKH4K (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 03:56:10 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:47319 "EHLO
        zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751618AbdHKH4J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 03:56:09 -0400
X-Greylist: delayed 308 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Aug 2017 03:56:09 EDT
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Fri, 11 Aug 2017 09:51:00 +0200
  id 000000000000001F.00000000598D61E4.00004E67
Date:   Fri, 11 Aug 2017 09:50:59 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Yaroslav Halchenko <yoh@onerussian.com>
Subject: Re: [PATCH] strbuf: clear errno before calling getdelim(3)
Message-ID: <20170811075059.nn6lru7uy6s6vpza@ruderich.org>
References: <20170809173928.h2ylvg5tp2p5inem@hopa.kiewit.dartmouth.edu>
 <8e307474-d180-6d98-2c6b-062f2181bd14@web.de>
 <xmqqzib72qvs.fsf@gitster.mtv.corp.google.com>
 <6d7b0d30-48ea-f79f-78cd-088557ea06ac@web.de>
 <20170810200502.rutab4z3ft7gcpjz@sigill.intra.peff.net>
 <cd49ce13-db87-89c1-77e7-998fdb9442c3@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd49ce13-db87-89c1-77e7-998fdb9442c3@web.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 10:56:40PM +0200, René Scharfe wrote:
> getdelim(3) returns -1 at the end of the file and if it encounters an
> error, but sets errno only in the latter case.  Set errno to zero before
> calling it to avoid misdiagnosing an out-of-memory condition due to a
> left-over value from some other function call.

getdelim(3p) doesn't explicitly forbid changing the errno on EOF:

    If no characters were read, and the end-of-file indicator for
    the stream is set, or if the stream is at end-of-file, the
    end-of-file indicator for the stream shall be set and the
    function shall return −1. If an error occurs, the error
    indicator for the stream shall be set, and the function shall
    return −1 and set errno to indicate the error.

So a valid implementation could still set errno on EOF and also
on another error (where it's required to set errno).

I don't think that it matters in practice, but the "most" correct
way to handle this would be to check if feof(3) is true to check
for the non-errno case.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
