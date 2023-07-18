Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DD8EB64DD
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 18:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjGRSXw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jul 2023 14:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjGRSXe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2023 14:23:34 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234FC1710
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 11:23:12 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B9F8E1999FB;
        Tue, 18 Jul 2023 14:22:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=j
        yH2FDcUuKypLBUiFxV/FLVO/cuCPv2drKUd3tRfMfU=; b=jgNLKpq3kFb0dpGxL
        2RDrcQp3jvlvum9DQ4c3iaTgWJtkzb2gW4waRXC7EuK1qTdRSFYfcswa8bdxwd+0
        zOHTrx6GAb28k6KvtmFMkD1pZ2tC0k1IBIkfsJ+BZyS3mCBJN3i2BNVPagRdO07W
        AI6WL9LoReIVRlEyXx/C8av4d8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B22711999FA;
        Tue, 18 Jul 2023 14:22:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 06F881999F9;
        Tue, 18 Jul 2023 14:22:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] am: simplify parsing of "--[no-]keep-cr"
Date:   Tue, 18 Jul 2023 11:22:40 -0700
Message-ID: <xmqqr0p5gjv3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 15765E36-2598-11EE-9B02-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Command line options "--keep-cr" and its negation trigger
OPT_SET_INT_F(PARSE_OPT_NONEG) to set a variable to 1 and 0
respectively.  Using OPT_SET_INT() to implement the positive variant
that sets the variable to 1 without specifying PARSE_OPT_NONEG gives
us the negative variant to set it to 0 for free.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/am.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index dcb89439b1..39d3e11f84 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2347,12 +2347,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 			N_("pass -b flag to git-mailinfo"), KEEP_NON_PATCH),
 		OPT_BOOL('m', "message-id", &state.message_id,
 			N_("pass -m flag to git-mailinfo")),
-		OPT_SET_INT_F(0, "keep-cr", &keep_cr,
-			N_("pass --keep-cr flag to git-mailsplit for mbox format"),
-			1, PARSE_OPT_NONEG),
-		OPT_SET_INT_F(0, "no-keep-cr", &keep_cr,
-			N_("do not pass --keep-cr flag to git-mailsplit independent of am.keepcr"),
-			0, PARSE_OPT_NONEG),
+		OPT_SET_INT(0, "keep-cr", &keep_cr,
+			    N_("pass --keep-cr flag to git-mailsplit for mbox format"),
+			    1),
 		OPT_BOOL('c', "scissors", &state.scissors,
 			N_("strip everything before a scissors line")),
 		OPT_CALLBACK_F(0, "quoted-cr", &state.quoted_cr, N_("action"),
-- 
2.41.0-376-gcba07a324d

