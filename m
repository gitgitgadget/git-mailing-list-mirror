Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F32CC1FADF
	for <e@80x24.org>; Mon, 22 Jan 2018 19:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751078AbeAVTb1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 14:31:27 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53916 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbeAVTbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 14:31:25 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E2D4AD4F3D;
        Mon, 22 Jan 2018 14:31:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XjAJqm8NXEtNw9ixvRFcr6vC/zM=; b=PTNsGN
        zfPAAhpzCqgelaMAILjaWqeErmgb3jnqZrqtcngLfWbIJvceDPetljfPEzsRPUkU
        PR9W/M7WHpnDacwmOCEheyo2MFkNLcA34+mtAaXCZVHb/sTuchr5bbJXX7qIAfrA
        0CKbUnInAxLRZ+e4zzHGBoJfoP9j4h9pFwko0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ovxb+YL+Kwjaw8UyauSx01+uezAhu7HP
        3GdP0cv3zRWpnZbRnIn6sOOcPDF1SGQuLYI8LrfQb/IhIp4JSv6UxBVCrNsz9i7q
        Ma3iHA2XxC+TeKDeMEETpfP4RKXhhereHVe8wjXidRAy1MhC33igBqwztYxMVJ2G
        7Hy1qkdH/KY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D9F6ED4F3C;
        Mon, 22 Jan 2018 14:31:22 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 55D85D4F3A;
        Mon, 22 Jan 2018 14:31:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Jeff King <peff@peff.net>, Kim Gybels <kgybels@infogroep.be>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3] packed_ref_cache: don't use mmap() for small files
References: <20180115235251.GA21900@sigill.intra.peff.net>
        <20180116193815.4568-1-kgybels@infogroep.be>
        <20180117220902.GA14952@sigill.intra.peff.net>
        <29c51594-6e29-be34-3d5f-2b9f399490f2@alum.mit.edu>
Date:   Mon, 22 Jan 2018 11:31:20 -0800
In-Reply-To: <29c51594-6e29-be34-3d5f-2b9f399490f2@alum.mit.edu> (Michael
        Haggerty's message of "Sun, 21 Jan 2018 05:41:48 +0100")
Message-ID: <xmqqh8rdn113.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D3F55C82-FFAA-11E7-B137-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> `snapshot->buf` can still be NULL if the `packed-refs` file didn't exist
> (see the earlier code path in `load_contents()`). So either that code
> path *also* has to get the `xmalloc()` treatment, or my third patch is
> still necessary. (My second patch wouldn't be necessary because the
> ENOENT case makes `load_contents()` return 0, triggering the early exit
> from `create_snapshot()`.)
>
> I don't have a strong preference either way.

Which would be a two-liner, like the attached, which does not look
too bad by itself.

The direction, if we take this approach, means that we are declaring
that .buf being NULL is an invalid state for a snapshot to be in,
instead of saying "an empty snapshot looks exactly like one that was
freshly initialized", which seems to be the intention of the original
design.

After Kim's fix and with 3/3 in your follow-up series, various
helpers are still unsafe against .buf being NULL, like
sort_snapshot(), verify_buffer_safe(), clear_snapshot_buffer() (only
when mmapped bit is set), find_reference_location().

packed_ref_iterator_begin() checks if snapshot->buf is NULL and
returns early.  At the first glance, this appears a useful short cut
to optimize the empty case away, but the check also is acting as a
guard to prevent a snapshot with NULL .buf from being fed to an
unsafe find_reference_location().  An implicit guard like this feels
a bit more brittle than my liking.  If we ensure .buf is never NULL,
that check can become a pure short-cut optimization and stop being
a correctness thing.

So...


 refs/packed-backend.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index b6e2bc3c1d..1eeb5c7f80 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -473,12 +473,11 @@ static int load_contents(struct snapshot *snapshot)
 	if (fd < 0) {
 		if (errno == ENOENT) {
 			/*
-			 * This is OK; it just means that no
-			 * "packed-refs" file has been written yet,
-			 * which is equivalent to it being empty,
-			 * which is its state when initialized with
-			 * zeros.
+			 * Treat missing "packed-refs" as equivalent to
+			 * it being empty.
 			 */
+			snapshot->eof = snapshot->buf = xmalloc(0);
+			snapshot->mmapped = 0;
 			return 0;
 		} else {
 			die_errno("couldn't read %s", snapshot->refs->path);
