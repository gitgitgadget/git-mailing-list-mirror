Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09EAC56202
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 08:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E52720DD4
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 08:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgKZIcn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 03:32:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:43574 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbgKZIcn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 03:32:43 -0500
Received: (qmail 15793 invoked by uid 109); 26 Nov 2020 08:32:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Nov 2020 08:32:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14775 invoked by uid 111); 26 Nov 2020 08:32:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Nov 2020 03:32:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Nov 2020 03:32:41 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH 12/12] mktag: bring back some of the verify_object()
 logic
Message-ID: <X79oKaMARatPS83t@coredump.intra.peff.net>
References: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
 <20201126012854.399-13-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201126012854.399-13-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 26, 2020 at 02:28:54AM +0100, Ævar Arnfjörð Bjarmason wrote:

> When working on this series I saw too late that I'd removed the mktag
> check for validating the object the tag points to. The fsck_tag() code
> doesn't do this because it's meant for the context of fsck, where
> we're validating reachability anyway.
> 
> We'd need to either refactor fsck_tag() so that it can pass us back
> its "tagged_oid" and the "type_from_string_gently()" value it throws
> away to get rid of the re-parsing of stdin here, or just duplicate the
> logic as I'm doing here.

We have yet another tag parser (because of course there's more): the one
in parse_tag_buffer() that we use for reading tags. I think your new
function here could just be:

  enum object_type real_type;
  struct tag t; /* yuck! another fake object */

  memset(&t, 0, sizeof(t));
  if (parse_tag_buffer(r, &t, buf, len) < 0)
	die("unable to parse");

  real_type = oid_object_info(r, &t->tagged->oid, NULL);
  if (real_type < 0)
	die("tagged object does not exist");
  if (real_type != t->tagged->type)
	die("tagged object's type does not match tag type field");

I almost wonder if we could simply rely on parse_tag_buffer() instead of
fsck_tag(), but it is not nearly as picky about finding potential
problems (its goal is the opposite: to return something usable if it's
at all possible to do so).

The "yuck" above isn't great. We could use pretend_object_file() for
that, though it's a bit heavy-weight (it computes the actual oid!). And
also it's a weird one-off that we've talked about getting rid of.

-Peff
