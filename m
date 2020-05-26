Return-Path: <SRS0=GnTn=7I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D518FC433DF
	for <git@archiver.kernel.org>; Tue, 26 May 2020 06:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A430320870
	for <git@archiver.kernel.org>; Tue, 26 May 2020 06:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731245AbgEZGxc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 02:53:32 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:57876 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgEZGxc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 May 2020 02:53:32 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id A2F123C0022;
        Tue, 26 May 2020 08:53:30 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WNAf5URCYaeZ; Tue, 26 May 2020 08:53:25 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id A706F3C057C;
        Tue, 26 May 2020 08:53:25 +0200 (CEST)
Received: from lxhi-065.adit-jv.com (10.72.94.23) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 26 May
 2020 08:53:25 +0200
Date:   Tue, 26 May 2020 08:53:20 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Assessing about commit order in upstream Linux
Message-ID: <20200526065320.GA18107@lxhi-065.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Originating-IP: [10.72.94.23]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git community,

Assessing about the correct order of upstream commits is essential
during the backporting process, since we aim to ensure that the
backporting result can be built and bisected at each commit.

However, there appear to be at least two ways to compute the
relative order of "mainline" commits, specifically based on the:

 * index/position of commit summary line in the output of
   'git log --oneline --topo-order upstream/master'

 * 'git describe --contains --match="v*" <SHA1>' of each commit

I've considered both approaches equivalent, until I ran into [A-B].

Judging by the index in the 'git log' output, commit [B] seems to
(topologically) come first and hence would need to be backported first:

$ git log --reverse --oneline --topo-order v4.14..v4.15 | grep -n "mm: slabinfo: remove CONFIG_SLABINFO" | cut -f1 -d:
7261
$ git log --reverse --oneline --topo-order v4.14..v4.15 | grep -n "RDMA/umem: Avoid partial declaration of non-static function" | cut -f1 -d:
7029

Judging by the version returned by 'git describe --contains', commit [A]
seems to (topologically) come first due to '~93' putting it (mentally)
"earlier" in the topological graph compared to '~73':

$ git describe --contains --match="v*" 5b36577109be
  v4.15-rc1~93^2~117
$ git describe --contains --match="v*" fec99ededf6b
  v4.15-rc1~73^2~56

So, the two approaches lead to different results. If you see any false
assumption or mistaken belief, could you please pinpoint that? TIA.

[A] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5b36577109be
  ("mm: slabinfo: remove CONFIG_SLABINFO")
[B] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fec99ededf6b
  ("RDMA/umem: Avoid partial declaration of non-static function")

-- 
Best regards,
Eugeniu Rosca
