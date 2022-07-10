Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2770BC43334
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 01:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiGJBeE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jul 2022 21:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiGJBeC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jul 2022 21:34:02 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7C2193E9
        for <git@vger.kernel.org>; Sat,  9 Jul 2022 18:34:00 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 530A419183B;
        Sat,  9 Jul 2022 21:33:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lSS6l8kHf8L46UTlLlliErlzRDgM9WtHtDcNfL
        f7tHU=; b=hkLqcj4Kk/BH4cJHjBL8gxijlQI10cXeeT8txHzjvYI5h0pY9rCJRA
        DKKaeFm4zm7txWQTKSWclq8V0C5EfbHxUAEMIHD/AUz44DtRmRVuYnrYoNEXClyQ
        p3Ombm7Yv89goCQht2FFaswpBYd+6BhTgO3K6ovqa9QQU0x49rtyc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4BA6919183A;
        Sat,  9 Jul 2022 21:33:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 03868191839;
        Sat,  9 Jul 2022 21:33:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v3] builtin/mv.c: use the MOVE_ARRAY() macro instead of
 memmove()
References: <xmqq8rp54r4l.fsf@gitster.g> <xmqqy1x531vp.fsf@gitster.g>
Date:   Sat, 09 Jul 2022 18:33:54 -0700
In-Reply-To: <xmqqy1x531vp.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        06 Jul 2022 22:52:58 -0700")
Message-ID: <xmqq4jzpu4xp.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D1144AA-FFF0-11EC-A84D-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
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

While at it, use CALLOC_ARRAY() instead of xcalloc() to allocate the
modes[] array that is involved in the change.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The first hunk is new; with this additional rewrite from
   xcalloc() to CALLOC_ARRAY(), the static-analysis job on 'seen'
   starts passing (cf. https://github.com/git/git/runs/7267146111)

   I think this is now good enough to merge down to 'next' and to
   'master'.

 builtin/mv.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 83a465ba83..859fa5023f 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -148,7 +148,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		die(_("index file corrupt"));
 
 	source = internal_prefix_pathspec(prefix, argv, argc, 0);
-	modes = xcalloc(argc, sizeof(enum update_mode));
+	CALLOC_ARRAY(modes, argc);
+
 	/*
 	 * Keep trailing slash, needed to let
 	 * "git mv file no-such-dir/" error out, except in the case
@@ -282,14 +283,11 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 remove_entry:
 		if (--argc > 0) {
 			int n = argc - i;
-			memmove(source + i, source + i + 1,
-				n * sizeof(char *));
-			memmove(destination + i, destination + i + 1,
-				n * sizeof(char *));
-			memmove(modes + i, modes + i + 1,
-				n * sizeof(enum update_mode));
-			memmove(submodule_gitfile + i, submodule_gitfile + i + 1,
-				n * sizeof(char *));
+			MOVE_ARRAY(source + i, source + i + 1, n);
+			MOVE_ARRAY(destination + i, destination + i + 1, n);
+			MOVE_ARRAY(modes + i, modes + i + 1, n);
+			MOVE_ARRAY(submodule_gitfile + i,
+				   submodule_gitfile + i + 1, n);
 			i--;
 		}
 	}
-- 
2.37.0-238-g7905cdbf0e

