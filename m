Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EF8E1F406
	for <e@80x24.org>; Fri,  5 Jan 2018 07:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751289AbeAEHIY (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 02:08:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:53982 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751056AbeAEHIX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 02:08:23 -0500
Received: (qmail 15286 invoked by uid 109); 5 Jan 2018 07:08:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Jan 2018 07:08:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2305 invoked by uid 111); 5 Jan 2018 07:08:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Jan 2018 02:08:54 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Jan 2018 02:08:21 -0500
Date:   Fri, 5 Jan 2018 02:08:21 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?54mb5pet?= <niuxu16@nudt.edu.cn>
Cc:     git <git@vger.kernel.org>
Subject: Re: Recommendation for consistent update on invoke of "sha1_to_hex()"
Message-ID: <20180105070821.GB14251@sigill.intra.peff.net>
References: <fb56cfe.6744.160c45a9e5a.Coremail.niuxu16@nudt.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb56cfe.6744.160c45a9e5a.Coremail.niuxu16@nudt.edu.cn>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 05, 2018 at 11:26:01AM +0800, 牛旭 wrote:

> By mining historical patches, we suggest that invokes of sha1_to_hex()
> should be replaced with that of oid_to_hex(). One example for
> recommendation and corresponding patch are listed as follows. 

Note that these two functions take different types. If you only have a
"const unsigned char *", then you must use sha1_to_hex(). If you have a
"struct object_id", then you should be using oid_to_hex(). If there are
sites which do:

  sha1_to_hex(oid.hash)

those should be converted to use oid_to_hex(). I think there's a
coccinelle rule for this, though, so there shouldn't be any lingering
calls like that.

Of course the ultimate goal is for every function to use oid_to_hex().
But that's much bigger than a single-line change, since groups of
dependent functions need to be converted (try "git log
--author=carlson" to see example patches).

> One example of missed spot:
> 1  void assert_sha1_type(const unsigned char *sha1, enum 
>   object_type expect)
> 2 {
> 3  enum object_type type = sha1_object_info(sha1, NULL);
> 4  if (type < 0)
> 5   die("%s is not a valid object",sha1_to_hex(sha1));
> 6  if (type != expect)
> 7   die("%s is not a valid '%s' object", sha1_to_hex(sha1),
> 8  typename(expect));
> 9 }

So this is an example that doesn't convert easily. The function has only
the bare pointer, so you'd have to change its parameter list (and
therefore all of its callers).

-Peff
