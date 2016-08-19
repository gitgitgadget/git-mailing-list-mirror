Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FAE41F859
	for <e@80x24.org>; Fri, 19 Aug 2016 20:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755490AbcHSU6K (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 16:58:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:58364 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755392AbcHSU6J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 16:58:09 -0400
Received: (qmail 25176 invoked by uid 109); 19 Aug 2016 20:58:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Aug 2016 20:58:09 +0000
Received: (qmail 29932 invoked by uid 111); 19 Aug 2016 20:58:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Aug 2016 16:58:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Aug 2016 16:58:06 -0400
Date:   Fri, 19 Aug 2016 16:58:06 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org,
        Stefan Beller <stefanbeller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v8 7/8] cache: add empty_tree_oid object
Message-ID: <20160819205806.vxzzgphqf4lgdor7@sigill.intra.peff.net>
References: <20160819000031.24854-1-jacob.e.keller@intel.com>
 <20160819000031.24854-8-jacob.e.keller@intel.com>
 <xmqqfuq01oww.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfuq01oww.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2016 at 01:31:27PM -0700, Junio C Hamano wrote:

> Jacob Keller <jacob.e.keller@intel.com> writes:
> 
> > From: Jacob Keller <jacob.keller@gmail.com>
> >
> > Add an empty_tree_oid object which can be used in place of
> > EMPTY_TREE_SHA1_BIN_LITERAL for code which is being converted to struct
> > object_id.
> 
> How widely do you envision the users of this symbol would be spread
> across the entire codebase?  I am debating myself if we need a
> singleton in-core copy like this (if we end up referring to it from
> everywhere), or we only need one level higher abstraction,
> e.g. "is_empty_tree_oid()" helper (in which case I do not think we
> even need a singleton; just imitate how is_empty_blob_sha1() is
> implemented).

I suspect we need more than just the "is_empty" query. At least for the
blob case, we do hashcpy() it into a struct (which should eventually
become oidcpy). The empty-tree case even more so, as we pass it to
random functions like lookup_tree().

Our EMPTY_TREE_SHA1_BIN_LITERAL effectively ends up as a singleton
in-core, too; it's just handled transparently by the compiler, since
it's a literal. This effectively gives us _two_ singletons. We could do:

  const struct object_id empty_blob_oid = {
	  "\xe6\x9d\xe2\x9b\xb2\xd1\xd6\x43\x4b\x8b"
	  "\x29\xae\x77\x5a\xd8\xc2\xe4\x8c\x53\x91"
  };
  #define EMPTY_BLOB_SHA1_BIN (empty_blob_oid.hash)

It's possible the use of an actual string literal lets the compiler do
more optimizations, but I'd doubt it matters in practice. Probably it is
just sticking that literal somewhere in BSS and filling in the pointer
to it.

-Peff
