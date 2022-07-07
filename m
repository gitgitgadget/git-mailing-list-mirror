Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE72C43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 05:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiGGFxD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 01:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiGGFxC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 01:53:02 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD5231921
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 22:53:01 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D327C138FBD;
        Thu,  7 Jul 2022 01:53:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7ZH4hlLjVNY81uA9Ew1TpyQLK4fPSWZ/bH4Ctu
        i08yY=; b=ixtuNrPP8ovsAd5FPuI9XlIxKydUInFGy5VnX0UmCOOdtWVTc/CAY4
        h99CxH3mvEkn7krkENsP3chSIVXDqN392J3pr7aNNs8/P1dSLbGgm9zn838qOSDi
        O2gGHA3sAn/pwKThBJTzMSoKWM69hN0xwdpqurPd2m92GJhjgmu4I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B7089138FBA;
        Thu,  7 Jul 2022 01:53:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E3021138FB9;
        Thu,  7 Jul 2022 01:52:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2] builtin/mv.c: use the MOVE_ARRAY() macro instead of
 memmove()
References: <xmqq8rp54r4l.fsf@gitster.g>
Date:   Wed, 06 Jul 2022 22:52:58 -0700
In-Reply-To: <xmqq8rp54r4l.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        06 Jul 2022 19:02:18 -0700")
Message-ID: <xmqqy1x531vp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0EB95600-FDB9-11EC-97E4-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The variables 'source', 'destination', and 'submodule_gitfile' are
all of type "const char **", and an element of such an array is of
"type const char *", but these memmove() calls were written as if
these variables are of type "char **".

Once these memmove() calls are fixed to use the correct type to
compute the number of bytes to be moved, e.g.

-      memmove(source + i, source + i + 1, n * sizeof(char *));
+      memmove(source + i, source + i + 1, n * sizeof(const char *));

existing contrib/coccinelle/array.cocci rules can recognize them as
candidates for turning into MOVE_ARRAY().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mv.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 83a465ba83..d599233057 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -282,14 +282,12 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 remove_entry:
 		if (--argc > 0) {
 			int n = argc - i;
-			memmove(source + i, source + i + 1,
-				n * sizeof(char *));
-			memmove(destination + i, destination + i + 1,
-				n * sizeof(char *));
+			MOVE_ARRAY(source + i, source + i + 1, n);
+			MOVE_ARRAY(destination + i, destination + i + 1, n);
 			memmove(modes + i, modes + i + 1,
 				n * sizeof(enum update_mode));
-			memmove(submodule_gitfile + i, submodule_gitfile + i + 1,
-				n * sizeof(char *));
+			MOVE_ARRAY(submodule_gitfile + i,
+				   submodule_gitfile + i + 1, n);
 			i--;
 		}
 	}
-- 
2.37.0-211-gafcdf5f063

