Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A4EC433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 18:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A25E21973
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 18:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgIQSPc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 14:15:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:60386 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbgIQSNT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 14:13:19 -0400
Received: (qmail 2462 invoked by uid 109); 17 Sep 2020 18:13:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Sep 2020 18:13:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11622 invoked by uid 111); 17 Sep 2020 18:13:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Sep 2020 14:13:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Sep 2020 14:13:03 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 08/10] builtin/diff-index: learn --merge-base
Message-ID: <20200917181303.GA108156@coredump.intra.peff.net>
References: <cover.1599723087.git.liu.denton@gmail.com>
 <cover.1600328335.git.liu.denton@gmail.com>
 <1e4f805e570b8caad26c43b4c8293413e9128d5f.1600328335.git.liu.denton@gmail.com>
 <xmqq8sd8s46i.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8sd8s46i.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 17, 2020 at 10:28:53AM -0700, Junio C Hamano wrote:

> > -	if (diff_cache(revs, &ent->item->oid, ent->name, !!(option & DIFF_INDEX_CACHED)))
> > +
> > +	if (option & DIFF_INDEX_MERGE_BASE) {
> > +		diff_get_merge_base(revs, &oid);
> > +		name = xstrdup(oid_to_hex(&oid));
> 
> Leak?

Using oid_to_hex_r() avoids an extra copy, and the leak goes away too:

  char merge_base_hex[GIT_MAX_HEXSZ + 1];
  ...
  name = oid_to_hex_r(merge_base_hex, &oid);

-Peff
