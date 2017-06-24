Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27ACB20401
	for <e@80x24.org>; Sat, 24 Jun 2017 20:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754970AbdFXUja (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 16:39:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:52098 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751586AbdFXUja (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 16:39:30 -0400
Received: (qmail 26147 invoked by uid 109); 24 Jun 2017 20:39:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 24 Jun 2017 20:39:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25272 invoked by uid 111); 24 Jun 2017 20:39:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 24 Jun 2017 16:39:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Jun 2017 16:39:28 -0400
Date:   Sat, 24 Jun 2017 16:39:28 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 7/8] sha1_file: do not access pack if unneeded
Message-ID: <20170624203927.r35esm7nvcqnarlr@sigill.intra.peff.net>
References: <cover.1497920092.git.jonathantanmy@google.com>
 <cover.1497035376.git.jonathantanmy@google.com>
 <cover.1497920092.git.jonathantanmy@google.com>
 <fb656dfeb96e3c69f612fed924d0d9dec592c772.1497920092.git.jonathantanmy@google.com>
 <xmqq8tklqkbe.fsf@gitster.mtv.corp.google.com>
 <20170624124813.wajhxkrqhw4xoee4@sigill.intra.peff.net>
 <xmqq7f019qjg.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7f019qjg.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 24, 2017 at 11:41:39AM -0700, Junio C Hamano wrote:

> > The other nice thing about whence_only is that it flips the logic. So
> > any existing callers which depend on filling the union automatically
> > will not be affected (though I would be surprised if there are any such
> > callers; most of that information isn't actually that interesting).
> 
> Hmph, but the solution does not scale.  When a caller wants whence
> and something else that cannot be asked for or ignored by being a
> "pointer to a result" field, such a request cannot be expressed.  We
> either need to make all fields in oi request to "pointer to a
> result, if the result is needed, or NULL when the result is not of
> interest", or give a bit for each non-pointer field to allow the
> caller to express "I am not interested in the value of this field".

True.

> In the usecase Jonathan has, the caller's wish is a very narrow "I
> am interested in nothing; just checking if the object is there", and
> passing NULL for oi works fine.  So I'm inclined to suggest that we
> take that approach now and worry about a more generic and scalable
> "how would one tell the machinery that the value for a field is
> uninteresting when the field is not a pointer to result?" mechanism
> until a real need arises.

If we are open to writing anything, then I think it should follow the
same pointer-to-data pattern that the rest of the struct does. I.e.,
declare the extra pack-data struct as a pointer, and let callers fill it
in or not. It's excessive in the sense that it's not a variable-sized
answer, but it at least makes the interface consistent.

And no callers who read it would be silently broken; the actual data
type in "struct object_info" would change, so they'd get a noisy compile
error.

-Peff
