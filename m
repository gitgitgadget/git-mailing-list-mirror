Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D20CC433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 12:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D83AB20DD4
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 12:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgFPM6f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:58:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:33060 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728553AbgFPM6f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 08:58:35 -0400
Received: (qmail 21677 invoked by uid 109); 16 Jun 2020 12:58:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Jun 2020 12:58:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12892 invoked by uid 111); 16 Jun 2020 12:58:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Jun 2020 08:58:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Jun 2020 08:58:33 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        sandals@crustytoothpaste.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/12] fast-export: do anonymize the primary branch
 name
Message-ID: <20200616125833.GE666057@coredump.intra.peff.net>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
 <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
 <ebd10f73cd73a8fca84d1862e5a4b7b62a549bcd.1592225416.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ebd10f73cd73a8fca84d1862e5a4b7b62a549bcd.1592225416.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 15, 2020 at 12:50:05PM +0000, Junio C Hamano via GitGitGadget wrote:

> There is a comment that explains why it is OK to leave 'master'
> unanonymized (because everybody calls the primary branch 'master'
> and it is no secret), but that does not justify why it is bad to
> anonymize 'master' and make it indistinguishable from other
> branches.  Assuming there _is_ a need to allow the readers of the
> output to tell where the tip of the primary branch is, let's keep
> the special casing of 'master', but still anonymize it to "ref0".
> Because all other branches will be given ref+N where N is a positive
> integer, this will keep the primary branch identifiable in the
> output stream, without exposing what the name of the primary branch
> is in the repository the export stream was taken from.

I think this is fine. The reason I left "master" as-is in the original
is that it is potentially helpful to have an idea of its specialness
when reproducing a traversal in the anonymized. I.e., if you know that a
bug is shown by "git rev-list master~17..master~3", then you can
reproduce it with the same command in the anonymized repo. Losing any
idea of where the primary branch is would make that impossible. But with
this patch, you can swap it out for "ref0~17", etc, which is OK.

Of course that only helps you for _one_ branch. A more generally useful
mechanism would be to teach fast-export to write the ref mapping (and
perhaps file mappings, etc) to a separate file. Then you could convert
any reproduction recipe to use the anonymized names, and share only that
recipe along with the anonymized dump. But that's _way_ outside the
scope of your series. This seems like a good interim step to retain the
status quo.

-Peff
