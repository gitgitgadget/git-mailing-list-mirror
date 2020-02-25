Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D78C35E01
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 19:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DA22082F
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 19:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbgBYTIV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 14:08:21 -0500
Received: from hermes.apache.org ([207.244.88.153]:59352 "HELO mail.apache.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728787AbgBYTIV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 14:08:21 -0500
Received: (qmail 61454 invoked by uid 99); 25 Feb 2020 19:08:20 -0000
Received: from Unknown (HELO mailrelay1-lw-us.apache.org) (10.10.3.159)
    by apache.org (qpsmtpd/0.29) with ESMTP; Tue, 25 Feb 2020 19:08:20 +0000
Received: from serre.fritz.box (pD9E9DBE8.dip0.t-ipconnect.de [217.233.219.232])
        by mailrelay1-lw-us.apache.org (ASF Mail Server at mailrelay1-lw-us.apache.org) with ESMTPA id 08E282234;
        Tue, 25 Feb 2020 19:08:18 +0000 (UTC)
From:   benno@bmevers.de
To:     junio@pobox.com
Cc:     git@vger.kernel.org, spearce@spearce.org,
        Benno Evers <benno@bmevers.de>
Subject: Re: [PATCH] describe: dont abort too early when searching tags
Date:   Tue, 25 Feb 2020 20:07:51 +0100
Message-Id: <20200225190751.5898-1-benno@bmevers.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <xmqq4kvfpv17.fsf@gitster-ct.c.googlers.com>
References: <xmqq4kvfpv17.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Benno Evers <benno@bmevers.de>

> How much, if any, does this change hurt the performance by forcing
> the code to dig further if there aren't multiple roots?  If there is
> such an unnecessary overhead that degrades performance for the more
> common case, can we improve it further to avoid it?

If there aren't multiple roots, then this should be visiting exactly
the same number of commits as before. This is because in this case, if
we're down to a single branch, the current commit must be an ancestor
of *all* tag candidates so the stopping condition is always true.

It's actually a bit challenging to find good test repositories for
this in the wild, as the big ones that use a merging workflow (like git
itself, the kernel, etc.) usually have so many branches active at any
point in time that the search will only stop when it hits the max number
of candidates. So I might be missing some edge cases. However, for the
"normal" repositories that I tested the number of traversed commits was
always the same before and after the change.
 
