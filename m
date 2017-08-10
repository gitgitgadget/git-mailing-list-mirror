Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D373208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 20:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753169AbdHJU3u (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 16:29:50 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:41312 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753089AbdHJU3t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 16:29:49 -0400
Received: from hopa.kiewit.dartmouth.edu ([129.170.31.166] helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <yoh@onerussian.com>)
        id 1dfu5U-0001VO-0y
        for git@vger.kernel.org; Thu, 10 Aug 2017 16:29:48 -0400
Date:   Thu, 10 Aug 2017 16:29:42 -0400
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <20170810202942.s232yr5stjxmmz4t@hopa.kiewit.dartmouth.edu>
References: <20170809173928.h2ylvg5tp2p5inem@hopa.kiewit.dartmouth.edu>
 <8e307474-d180-6d98-2c6b-062f2181bd14@web.de>
 <xmqqzib72qvs.fsf@gitster.mtv.corp.google.com>
 <6d7b0d30-48ea-f79f-78cd-088557ea06ac@web.de>
 <20170810200502.rutab4z3ft7gcpjz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170810200502.rutab4z3ft7gcpjz@sigill.intra.peff.net>
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


On Thu, 10 Aug 2017, Jeff King wrote:

> On Thu, Aug 10, 2017 at 09:58:37PM +0200, René Scharfe wrote:

> > > So the function is returning -1 and leaving ENOMEM in errno on
> > > Yaroslav's system.

> > > I wonder if we are truly hitting out of memory, though.  The same
> > > symptom could bee seen if getdelim() does not touch errno when it
> > > returns -1, but some other system call earlier set it to ENOMEM,
> > > for example.

> > That can happen when the end of a file is reached; getdelim() returns
> > -1 and leaves errno unchanged.  So we need to set errno to 0 just
> > before that call.

> Good catch. That's a bug in my original conversoin of
> strbuf_getwholeline().

I think this did it!  at least on this simple test... yet to test a bit
more in those scenarios we ran into it before while testing git-annex.

commit 36ef5e3ad2c187d3be664c33dbc8c06e59bceaf4 (HEAD -> bf-seterrno0)
Author: Yaroslav O. Halchenko <yhalchen@smaug.cns.dartmouth.edu>
Date:   Thu Aug 10 20:26:47 2017 +0000

    BF: set errno to 0 before getdelim call to get unbiased assesment later

diff --git a/strbuf.c b/strbuf.c
index 89d22e3b0..323c49ceb 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -476,6 +476,7 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
        /* Translate slopbuf to NULL, as we cannot call realloc on it */
        if (!sb->alloc)
                sb->buf = NULL;
+       errno = 0;
        r = getdelim(&sb->buf, &sb->alloc, term, fp);
 
        if (r > 0) {

-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
