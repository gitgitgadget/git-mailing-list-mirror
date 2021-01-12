Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A603EC433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 18:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 629E02311D
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 18:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390336AbhALSSG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 13:18:06 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:33748 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389601AbhALSSG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 13:18:06 -0500
X-Greylist: delayed 1862 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Jan 2021 13:18:05 EST
Received: from c-76-24-253-1.hsd1.nh.comcast.net ([76.24.253.1] helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <yoh@onerussian.com>)
        id 1kzNkM-0006Ra-JL
        for git@vger.kernel.org; Tue, 12 Jan 2021 12:46:22 -0500
Date:   Tue, 12 Jan 2021 12:46:22 -0500
From:   yoh@onerussian.com
To:     git@vger.kernel.org
Message-ID: <X/3gbjQs7+wHoJpb@lena.dartmouth.edu>
References: <fe9babc8-a3ee-6be4-e4f8-9690cb7c79bd@fz-juelich.de>
 <e7301aaf-b341-ec0b-9e2d-ab7f60ac58da@fz-juelich.de>
 <X/ipCPFyW3gAWrHo@nand.local>
 <xmqq35z9g3pw.fsf@gitster.c.googlers.com>
 <X/ymFuUPn2POWA/p@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X/ymFuUPn2POWA/p@nand.local>
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
X-SA-Exim-Connect-IP: 76.24.253.1
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: Re: suspected race between packing and fetch (single case study)
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, 11 Jan 2021, Taylor Blau wrote:
> ++
> +*NOTE*: this operation can race with concurrent modification to the
> +source repository, similar to running `cp -r src dst` while modifying
> +`src`.

Couldn't `gc` be triggered by git in seemingly read-only operations,
thus possibly ruining the analogy with `cp` while doing `rm` (explicit
intent to modify)?

Moreover, situation is also a bit different since a sane user script
would not place `rm` into background to keep operating on original
source right before doing `cp` -- and that is what is happening here:

`git` operation is presumably complete (but leaves `gc` running in the
background) and script advances to the next step only to run into a race
condition with that preceding `git` command which apparently triggered
`gc`.  Should then any script which operates on local `git` repositories
not to forget to add   -c gc.autodetach=0  for every git
invocation which might be potentially effected?

Cheers,
-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
WWW:   http://www.linkedin.com/in/yarik        

