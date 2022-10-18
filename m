Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8E0C4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 06:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiJRG3L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 02:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiJRG3E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 02:29:04 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A19A6C3E
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 23:29:02 -0700 (PDT)
Received: (qmail 29845 invoked by uid 109); 18 Oct 2022 06:29:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Oct 2022 06:29:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16309 invoked by uid 111); 18 Oct 2022 06:29:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Oct 2022 02:29:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Oct 2022 02:29:01 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, vdye@github.com, derrickstolee@github.com,
        avarab@gmail.com
Subject: Re: [PATCH v2] builtin/repack.c: remove redundant pack-based bitmaps
Message-ID: <Y05HrVT9HxxDiXc2@coredump.intra.peff.net>
References: <393fd4c6db78cd694e6d4dfcf24f17e2850ccd99.1665601403.git.me@ttaylorr.com>
 <1e0ef7ee7ff5feb323c77e594cd65433fb1d99f7.1666061096.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1e0ef7ee7ff5feb323c77e594cd65433fb1d99f7.1666061096.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 17, 2022 at 10:45:12PM -0400, Taylor Blau wrote:

> When we write a MIDX bitmap after repacking, it is possible that the
> repository would be left in a state with both pack- and multi-pack
> reachability bitmaps.
> 
> This can occur, for instance, if a pack that was kept (either by having
> a .keep file, or during a geometric repack in which it is not rolled up)
> has a bitmap file, and the repack wrote a multi-pack index and bitmap.
> 
> When loading a reachability bitmap for the repository, the multi-pack
> one is always preferred, so the pack-based one is redundant. Let's
> remove it unconditionally, even if '-d' isn't passed, since there is no
> practical reason to keep both around. The patch below does just that.

Thanks, this version looks great to me.

> 1:  393fd4c6db ! 1:  1e0ef7ee7f builtin/repack.c: remove redundant pack-based bitmaps
>     @@ builtin/repack.c: static int write_midx_included_packs(struct string_list *inclu
>      +		strbuf_addstr(&path, ".bitmap");
>      +
>      +		if (unlink(path.buf) && errno != ENOENT)
>     -+			die_errno(_("could not remove stale bitmap: %s"),
>     -+				  path.buf);
>     ++			warning_errno(_("could not remove stale bitmap: %s"),
>     ++				      path.buf);

As noted elsewhere in the thread, this could be unlink_or_warn(), but
doing it manually lets us produce a more specific message, which is
nice.

-Peff
