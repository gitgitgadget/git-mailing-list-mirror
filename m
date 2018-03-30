Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71BE31F42D
	for <e@80x24.org>; Fri, 30 Mar 2018 20:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752639AbeC3USf (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 16:18:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:49328 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752490AbeC3USe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 16:18:34 -0400
Received: (qmail 29555 invoked by uid 109); 30 Mar 2018 20:18:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 30 Mar 2018 20:18:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32689 invoked by uid 111); 30 Mar 2018 20:19:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 30 Mar 2018 16:19:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2018 16:18:32 -0400
Date:   Fri, 30 Mar 2018 16:18:32 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH v7 02/13] pack-objects: turn type and in_pack_type to
 bitfields
Message-ID: <20180330201832.GA14782@sigill.intra.peff.net>
References: <20180318142526.9378-1-pclouds@gmail.com>
 <20180324063353.24722-1-pclouds@gmail.com>
 <20180324063353.24722-3-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180324063353.24722-3-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 24, 2018 at 07:33:42AM +0100, Nguyễn Thái Ngọc Duy wrote:

> +static inline void oe_set_type(struct object_entry *e,
> +			       enum object_type type)
> +{
> +	if (type >= OBJ_ANY)
> +		die("BUG: OBJ_ANY cannot be set in pack-objects code");

A minor nit, but this (and other new assertions) should probably be
BUG().

> +	e->type_valid = type >= OBJ_NONE;
> +	e->type_ = (unsigned)type;

Hmm, so if !e->type_valid, then we may write utter garbage into
e->type_. That's OK, since everybody will access it via oe_type(), but I
wonder if we could trigger weird compiler behavior. I guess the unsigned
cast makes the truncation well-defined.

-Peff
