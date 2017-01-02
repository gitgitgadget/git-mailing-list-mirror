Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74968205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 18:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756557AbdABS1J (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 13:27:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:34348 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751842AbdABS0m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 13:26:42 -0500
Received: (qmail 25656 invoked by uid 109); 2 Jan 2017 18:26:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Jan 2017 18:26:42 +0000
Received: (qmail 18849 invoked by uid 111); 2 Jan 2017 18:27:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Jan 2017 13:27:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jan 2017 13:26:39 -0500
Date:   Mon, 2 Jan 2017 13:26:39 -0500
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        David Turner <novalis@novalis.org>
Subject: Re: [PATCH v3 21/23] try_remove_empty_parents(): don't accommodate
 consecutive slashes
Message-ID: <20170102182639.c53flvqdkb4kjuuh@sigill.intra.peff.net>
References: <5051c78e-51f9-becd-e1a6-9c0b781d6912@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5051c78e-51f9-becd-e1a6-9c0b781d6912@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 02, 2017 at 07:06:32PM +0100, Michael Haggerty wrote:

> My assumption was that only valid reference names should ever be allowed
> to be inserted into a `ref_transaction` entry. But Peff is right that
> sometimes the reference name is checked by `refname_is_safe()` rather
> than `check_refname_format()`. Let's audit this more carefully...
> 
> * `ref_transaction_add_update()` relies on its caller doing the check
>   (this fact is documented). Its callers are:
>   * `ref_transaction_update()` (the usual codepath), which checks the
>     reference itself using either check_refname_format() or
>     refname_is_safe() depending on what kind of update it is.
>   * `split_head_update()` passes the literal string "HEAD".
>   * `split_symref_update()` picks apart reference updates that go
>     through existing symbolic references. As such I don't think they
>     are an attack surface. It doesn't do any checking itself (here
>     we're talking about its `referent` argument). It has only one
>     caller:
>     * `lock_ref_for_update()`, which gets `referent` from:
>       * `files_read_raw_ref()`, which gets the value either:
>         * by reading a filesystem-level symlink's contents and
>           checking it with `check_refname_format()`, or
>         * reading a symref from the filesystem. In this case, *the
>           value is not checked*.
> 
> Obviously this chain of custody is disconcertingly long and complicated.
> And the gap for symrefs should probably be fixed, even though they are
> hopefully trustworthy.

Thanks as always for a careful analysis. I agree it seems like a bug
that symlinks are checked but symrefs are not.

> I think the best thing to do is to drop this patch from the patch
> series, and address these checks in a separate series. (There are more
> known problems in this area, for example that the checks in
> `check_refname_format()` are not a strict superset of the checks in
> `refname_is_safe()`.)

Sounds like a good plan. I'd be very happy if the "superset" mismatch is
fixed. It seems like it has come up in our discussions more than once.

-Peff
