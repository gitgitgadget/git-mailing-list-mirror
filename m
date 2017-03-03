Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BE032023D
	for <e@80x24.org>; Fri,  3 Mar 2017 10:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752033AbdCCKPJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 05:15:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:37854 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751872AbdCCKPG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 05:15:06 -0500
Received: (qmail 27402 invoked by uid 109); 3 Mar 2017 10:15:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 10:15:05 +0000
Received: (qmail 26521 invoked by uid 111); 3 Mar 2017 10:15:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 05:15:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Mar 2017 05:15:03 -0500
Date:   Fri, 3 Mar 2017 05:15:03 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] config: check if config path is a file before
 parsing it
Message-ID: <20170303101503.lf2ub2c7i6w7kg3t@sigill.intra.peff.net>
References: <20170303094252.11706-1-pclouds@gmail.com>
 <20170303094252.11706-2-pclouds@gmail.com>
 <20170303095351.rgifjpfuvafx33jy@sigill.intra.peff.net>
 <CACsJy8DU7-o06mfuw1L02CFFR2wmoNa0MQJ8KqsV79ULzjRaRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8DU7-o06mfuw1L02CFFR2wmoNa0MQJ8KqsV79ULzjRaRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2017 at 05:06:57PM +0700, Duy Nguyen wrote:

> > But if we do, I think we'd either want to:
> >
> >        a. actually check ferror() after getting EOF and report the read
> >           error. That catches EISDIR, along with any other unexpected
> >           errors.
> >
> >        b. use an fopen wrapper that checks fstat(fileno(fh)) after the
> >           open, and turns fopen(some_dir) into an error.
> 
> If you don't like extra check, I guess you're negative on b as well
> since it is an extra check on Windows. That leaves us with option a.

I don't mind _doing_ the extra check that much. I don't think we fopen
so many files that an extra fstat on each would kill us. I mostly just
don't like having to sprinkle the explicit call to it everywhere. I'd be
OK with:

  FILE *xfopen(const char *path, const char *mode)
  {
	FILE *ret = fopen(path, mode);
  #ifdef FOPEN_OPENS_DIRECTORIES
	if (ret) {
		struct stat st;
		if (!fstat(fileno(ret), &st) && S_ISDIR(st.st_mode)) {
			fclose(ret);
			ret = NULL;
		}
	}
  #endif
	return ret;
  }

But I do think option (a) is cleaner. The only trick is that for errno
to be valid, we need to make sure we check ferror() soon after seeing
the EOF return value. I suspect it would work OK in practice for the
git_config_from_file() case.

-Peff
