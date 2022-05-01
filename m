Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6EEC433EF
	for <git@archiver.kernel.org>; Sun,  1 May 2022 05:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbiEAFEC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 May 2022 01:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239437AbiEAFD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 May 2022 01:03:59 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74FF2DCC
        for <git@vger.kernel.org>; Sat, 30 Apr 2022 22:00:33 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C866129326;
        Sun,  1 May 2022 01:00:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=C
        9wmvXsPI551vrOem3+yTAJ7eQqaEmYQehTTFCYyqy8=; b=KwX8ADfbXALcm/Dzb
        X+qJNR1VIAQ03ZiF6BZ40Tuad/X3FZyHN5V7A1MGOA/+WqmnedsFSm5n68xwP62A
        z2MaiPhbfxbJN3sfNdx1wKOh8mvVMJ5x3QaIDBm2T7nngdXmaKKA539Io25XAJVR
        rNaFpxiVwRNt8pfuk9Gv/Q6G40=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 556ED129324;
        Sun,  1 May 2022 01:00:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BD5C812931F;
        Sun,  1 May 2022 01:00:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] cocci: drop bogus xstrdup_or_null() rule
Date:   Sat, 30 Apr 2022 22:00:30 -0700
Message-ID: <xmqq1qxd6e4x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A09A7064-C90B-11EC-AC0F-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

13092a91 (cocci: refactor common patterns to use xstrdup_or_null(),
2016-10-12) introduced a rule to rewrite this conditional call to
xstrdup(E) and an assignment to variable V:

    - if (E)
    -    V = xstrdup(E);

into an unconditional call to xstrdup_or_null(E) and an assignment
to variable V:

    + V = xstrdup_or_null(E);

which is utterly bogus.  The original code may already have an
acceptable value in V and the conditional assignment may be to
improve the value already in V with a copy of a better value E when
(and only when) E is not NULL.

The rewritten construct unconditionally discards the existing value
of V and replaces it with a copy of E, even when E is NULL, which
changes the meaning of the program.

By the way, if it were

	-if (E && !V)
	-	V = xstrdup(E);
	+V = xstrdup_or_null(E);

it would probably have been correct.  But there is no existing code
that would have been improved by such a rule, so let's just remove
the bogus one without replacing with the more specific one.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/coccinelle/xstrdup_or_null.cocci | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/contrib/coccinelle/xstrdup_or_null.cocci b/contrib/coccinelle/xstrdup_or_null.cocci
index 8e05d1ca4b..9c1d2939b6 100644
--- a/contrib/coccinelle/xstrdup_or_null.cocci
+++ b/contrib/coccinelle/xstrdup_or_null.cocci
@@ -1,11 +1,3 @@
-@@
-expression E;
-expression V;
-@@
-- if (E)
--    V = xstrdup(E);
-+ V = xstrdup_or_null(E);
-
 @@
 expression E;
 @@
-- 
2.36.0-233-gea8f06b421

