Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D06361F463
	for <e@80x24.org>; Tue, 24 Sep 2019 21:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfIXVeJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 17:34:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:58934 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727890AbfIXVeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 17:34:09 -0400
Received: (qmail 11463 invoked by uid 109); 24 Sep 2019 21:34:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Sep 2019 21:34:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12823 invoked by uid 111); 24 Sep 2019 21:36:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2019 17:36:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 24 Sep 2019 17:34:08 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/3] pack-bitmap.h: fix unused variable warning
Message-ID: <20190924213408.GD20858@sigill.intra.peff.net>
References: <cover.1569263631.git.liu.denton@gmail.com>
 <a3a3357925cb144deb35b298cbe2796934fa0673.1569315905.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3a3357925cb144deb35b298cbe2796934fa0673.1569315905.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 24, 2019 at 02:08:53AM -0700, Denton Liu wrote:

> When we ran `make hdr-check`, we got the following warning on Arch Linux:
> 
> 	pack-bitmap.h:20:19: error: ‘BITMAP_IDX_SIGNATURE’ defined but not used [-Werror=unused-const-variable=]
> 	   20 | static const char BITMAP_IDX_SIGNATURE[] = {'B', 'I', 'T', 'M'};
> 	      |                   ^~~~~~~~~~~~~~~~~~~~
> 	cc1: all warnings being treated as errors
> 
> "Use" the BITMAP_IDX_SIGNATURE variable by making the size of
> bitmap_disk_header.magic equal to the size of BITMAP_IDX_SIGNATURE. An
> alternative was to simply add MAYBE_UNUSED. However, this design was
> chosen because we eliminate the magic number (4) in the process.

Yeah, I think this is a fine fix. Since it's needed in only a few files,
the more usual fix would be to not define it in the header in the first
place. Something like:

  extern const char BITMAP_IDX_SIGNATURE[4];

or whatever. But I think it's nice to keep it all together.

> I'm tacking this patch on since this warning didn't show up until I
> compiled it on gcc 9.1.0.

Curiously, I _don't_ see the warning with gcc 9.2.1. By my reading of
the manpage, this should be triggered by -Wunused-const-variable=2, but
not by "1" (the difference being whether it triggers for stuff in header
files). And only the latter is triggered by -Wall or -Wextra.

But another weirdness is that hdr-check is directly compiling the header
files. So I guess that fools it. But we don't pass any of the extra
diagnostic options there.  Have you put "-Wall" into your $(CC)?

Perhaps a more realistic hdr-check would be:

  {
    echo '#include "git-compat-util.h"'
    echo '#include "$<"'
  } >$*.hcc
  $(QUIET_HDR)$(CC) $(ALL_CFLAGS) -o /dev/null -c -xc $*.hcc

-Peff
