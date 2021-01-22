Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31549C433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 01:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8D5520799
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 01:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbhAVBJw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 20:09:52 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:45328 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbhAVBJt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 20:09:49 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1l2kwl-00BaPG-5v; Thu, 21 Jan 2021 18:09:07 -0700
Received: from mta4.zcs.xmission.com ([166.70.13.68])
        by in02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1l2kwk-004GXe-8p; Thu, 21 Jan 2021 18:09:06 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta4.zcs.xmission.com (Postfix) with ESMTP id 16CC150118C;
        Thu, 21 Jan 2021 18:09:06 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta4.zcs.xmission.com
Received: from mta4.zcs.xmission.com ([127.0.0.1])
        by localhost (mta4.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id O3B84KUDk-Se; Thu, 21 Jan 2021 18:09:05 -0700 (MST)
Received: from ellen (unknown [139.60.10.209])
        by mta4.zcs.xmission.com (Postfix) with ESMTPSA id 60B9F500BE9;
        Thu, 21 Jan 2021 18:09:05 -0700 (MST)
Date:   Thu, 21 Jan 2021 18:09:02 -0700
From:   Seth House <seth@eseth.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Aguilar <davvid@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Message-ID: <20210122010902.GA48178@ellen>
References: <X/onP6vFAHH8SUBo@camp.crustytoothpaste.net>
 <20210109224236.50363-1-davvid@gmail.com>
 <20210109225400.GA156779@ellen>
 <xmqqmtxhd1zx.fsf@gitster.c.googlers.com>
 <xmqqa6thcn1n.fsf_-_@gitster.c.googlers.com>
 <20210110072902.GA247325@ellen>
 <xmqqh7np9gqn.fsf@gitster.c.googlers.com>
 <20210116042454.GA4913@ellen>
 <20210120232447.GA35105@ellen>
 <xmqqk0s5c3bv.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0s5c3bv.fsf@gitster.c.googlers.com>
X-XM-SPF: eid=1l2kwk-004GXe-8p;;;mid=<20210122010902.GA48178@ellen>;;;hst=in02.mta.xmission.com;;;ip=166.70.13.68;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.68
X-SA-Exim-Mail-From: seth@eseth.com
Subject: Re: automerge implementation ideas for Windows
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 21, 2021 at 02:50:12PM -0800, Junio C Hamano wrote:
> I'd rather not to see us do "text processing" in shell

Agreed. What are your thoughts on the #2 approach?

I noticed the comment in `git/xdiff-interface.h` about xdiff's gigabyte
limit so I created a 973 MB text file with a conflict and ran #2 through
a few mergetools to see how it went. I put /usr/bin/time in front of the
two `git merge-file` invocations. I know one person's machine is not
a benchmark but perhaps it's a discussion point?

Each `git merge-file` call took ~11 seconds on my middle-tier laptop and
did not use enough RAM to hit swap.

Writing the near-gigabyte LOCAL, BASE, REMOTE, & BACKUP files went
pretty quick. The mergetools themselves had mixed results:

- vimdiff took several minutes (and a lot of swap) to open all four
  files but did eventually work.
- tkdiff crashed.
- Meld spun for ~10 minutes and never opened.

My takeaway: when trying to use a mergetool on a very large file, the
two `git merge-file` invocations are not likely to be where the
performance concern is. #2 is my preferred approach so far.

