Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BAEC34022
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 06:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1AC0208E4
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 06:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgBSGzf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 01:55:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:47708 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726133AbgBSGzf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 01:55:35 -0500
Received: (qmail 22078 invoked by uid 109); 19 Feb 2020 06:55:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Feb 2020 06:55:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25389 invoked by uid 111); 19 Feb 2020 07:04:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 19 Feb 2020 02:04:35 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 19 Feb 2020 01:55:33 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v6 4/5] Add reftable library
Message-ID: <20200219065533.GA623000@coredump.intra.peff.net>
References: <pull.539.v5.git.1581344060.gitgitgadget@gmail.com>
 <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
 <fe29a9db39922e42929e47a12c816dcb92ba2204.1582015420.git.gitgitgadget@gmail.com>
 <xmqqtv3niosf.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtv3niosf.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 18, 2020 at 01:11:28PM -0800, Junio C Hamano wrote:

> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > +void put_u64(byte *out, uint64_t v)
> > +{
> > +	int i = 0;
> > +	for (i = sizeof(uint64_t); i--;) {
> > +		out[i] = (byte)(v & 0xff);
> > +		v >>= 8;
> > +	}
> > +}
> 
> This looks OK, but ...

There's a useless initialization of "i" there, I think?

It also seems weird to decrement "i" in the loop condition and leave the
final field of the for-loop empty. Would:

  int i = sizeof(uint64_t);
  while (i--) {
     ...
  }

be more clear? But...

We also have put_be64() already (it's coded without a loop, though I'd
imagine just about any compiler would unroll the loop above).

I wonder how possible it would be to use the Git names for these utility
functions in the reftable library, and then push the common ones out
into a compat file within the reftable library. Then we could toss out
the compat file when importing the library to Git, but it could still
compile standalone.

-Peff
