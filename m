Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68ACE208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 19:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753165AbdHJTor (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 15:44:47 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:40702 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752889AbdHJToq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 15:44:46 -0400
Received: from [129.170.31.166] (helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <yoh@onerussian.com>)
        id 1dftNs-0007C4-6G
        for git@vger.kernel.org; Thu, 10 Aug 2017 15:44:45 -0400
Date:   Thu, 10 Aug 2017 15:44:38 -0400
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <20170810194438.n6cmljlorind2enu@hopa.kiewit.dartmouth.edu>
References: <20170809173928.h2ylvg5tp2p5inem@hopa.kiewit.dartmouth.edu>
 <8e307474-d180-6d98-2c6b-062f2181bd14@web.de>
 <xmqqzib72qvs.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzib72qvs.fsf@gitster.mtv.corp.google.com>
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 129.170.31.166
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: Re: fatal: Out of memory, getdelim failed under NFS mounts
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you Junio

On Thu, 10 Aug 2017, Junio C Hamano wrote:
> There is only one getdelim() call, which was introduced in v2.5.0
> timeframe, and it is used like this:

> 	r = getdelim(&sb->buf, &sb->alloc, term, fp);

> 	if (r > 0) {
> 		sb->len = r;
> 		return 0;
> 	}
> 	assert(r == -1);

> 	/*
> 	 * Normally we would have called xrealloc, which will try to free
> 	 * memory and recover. But we have no way to tell getdelim() to do so.
> 	 * Worse, we cannot try to recover ENOMEM ourselves, because we have
> 	 * no idea how many bytes were read by getdelim.
> 	 *
> 	 * Dying here is reasonable. It mirrors what xrealloc would do on
> 	 * catastrophic memory failure. We skip the opportunity to free pack
> 	 * memory and retry, but that's unlikely to help for a malloc small
> 	 * enough to hold a single line of input, anyway.
> 	 */
> 	if (errno == ENOMEM)
> 		die("Out of memory, getdelim failed");

> So the function is returning -1 and leaving ENOMEM in errno on
> Yaroslav's system.  

> I wonder if we are truly hitting out of memory, though.  The same
> symptom could bee seen if getdelim() does not touch errno when it
> returns -1, but some other system call earlier set it to ENOMEM,
> for example.

> If the same version of Git is recompiled there without HAVE_GETDELIM
> defined, would it still die with out of memory (presumably inside
> the call to strbuf_grow() in the strbuf_getwholeline() function)?

will check now...  for my own education (rotten by Python) -- how
do you know which syscall set errno to be analyzed at this specific
point?  may be it was already set to ENOMEM before entry to this
function?

-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
