Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7620C43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 02:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbiGGCCY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 22:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiGGCCX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 22:02:23 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B965C2F030
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 19:02:21 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE54914075E;
        Wed,  6 Jul 2022 22:02:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=I
        NvDhXhTdV8377OVL2NL5E1CdgFwNpRkE5obD30kVvM=; b=AkzN4Cm6eAsnY1UAV
        FvLRsZYMM1+FBOhHFO1Wh+NHgdw7VmGt6/yluEf+DZVfHCzb+UTGhZ1WKh8l4Ft+
        +hGZGkcvTaSy+nrE79nyU+GT86WN/sgK5U3zHz6EOCXfLXj/WNkMSuZKYiClAAd+
        4Q5gFiZxevxPmx1UkNLqvCqSkg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C511D14075D;
        Wed,  6 Jul 2022 22:02:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 02A8B14075C;
        Wed,  6 Jul 2022 22:02:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] builtin/mv.c: use correct type to compute size of an array
 element
Date:   Wed, 06 Jul 2022 19:02:18 -0700
Message-ID: <xmqq8rp54r4l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D57DE5EC-FD98-11EC-89D1-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The variables 'source', 'destination', and 'submodule_gitfile' are
all of type "const char **", and an element of such an array is of
"type const char *".

Noticed while running "make contrib/coccinelle/array.cocci.patch".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * There is this rule in the array.cocci file:

        @@
        type T;
        T *dst;
        T *src;
        expression n;
        @@
        (
        - memmove(dst, src, (n) * sizeof(*dst));
        + MOVE_ARRAY(dst, src, n);
        |
        - memmove(dst, src, (n) * sizeof(*src));
        + MOVE_ARRAY(dst, src, n);
        |
        - memmove(dst, src, (n) * sizeof(T));
        + MOVE_ARRAY(dst, src, n);
        )

   but it triggered only for modes[] array among the four parallel
   arrays that are being moved here.

   There are a few tangents.

   * Should we in general use sizeof(TYPE) in these cases, instead
     of the size of the zeroth element, e.g.

 		memmove(source + i, source + i + 1,
			n * sizeof(source[i]));
    
     It would have been caught by the above Coccinelle rule (we are
     taking the size of *dst).

   * Shouldn't we have an array of struct with four members, instead
     of four parallel arrays, e.g.

		struct {
			const char *source;
			const char *destination;
			enum update_mode mode;
			const char *submodule_gitfile;
		} *mv_file;

   The latter question is important to answer before we accept
   Coccinelle-suggested rewrite to use four MOVE_ARRAY() on these
   four parallel arrays on top of this fix.

 builtin/mv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git c/builtin/mv.c w/builtin/mv.c
index 2a38e2af46..d419e83f0f 100644
--- c/builtin/mv.c
+++ w/builtin/mv.c
@@ -377,13 +377,13 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		if (--argc > 0) {
 			int n = argc - i;
 			memmove(source + i, source + i + 1,
-				n * sizeof(char *));
+				n * sizeof(const char *));
 			memmove(destination + i, destination + i + 1,
-				n * sizeof(char *));
+				n * sizeof(const char *));
 			memmove(modes + i, modes + i + 1,
 				n * sizeof(enum update_mode));
 			memmove(submodule_gitfile + i, submodule_gitfile + i + 1,
-				n * sizeof(char *));
+				n * sizeof(const char *));
 			i--;
 		}
 	}
