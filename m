Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170E0EB64DD
	for <git@archiver.kernel.org>; Sat, 12 Aug 2023 01:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbjHLBOl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 21:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjHLBOk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 21:14:40 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3C71BD9
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 18:14:40 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 03CF81A84F0;
        Fri, 11 Aug 2023 21:14:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=QARCAdKygPgOCI/bcbbK6qXXHYsg0DLLa3Zh+Ay2gQ8=; b=BXvy
        Jzh0IeWE6jkGSslR/VaokiFXJg++8KgKtaOEOkP/FplrICECg1AbZzpBdIn3H9qG
        dZtaQWr3IP1d6U3PePxt3k8L6chEk8Od1nJwE7cEqm3IzesH4CUVDlb0xX/GhgV6
        ZYgndpQ19UJCd7LbGNrNd4popW+zcu0TDsn6ldI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F07351A84EF;
        Fri, 11 Aug 2023 21:14:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 669A91A84EE;
        Fri, 11 Aug 2023 21:14:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Sebastian Thiel via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Sebastian Thiel <sebastian.thiel@icloud.com>
Subject: [PATCH] mv: fix error for moving directory to another
References: <pull.1561.git.1691506431114.gitgitgadget@gmail.com>
        <xmqqy1il77wp.fsf@gitster.g>
        <20230808184054.cjhiboifschkwuoz@tb-raspi4>
        <xmqqmsz16w1q.fsf@gitster.g>
Date:   Fri, 11 Aug 2023 18:14:35 -0700
Message-ID: <xmqqjzu1njt0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A4D7482-38AD-11EE-BBF3-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If both directories D1 and D2 already exists, and further there is a
filesystem entity D2/D1, "git mv D1 D2" would fail, and we get an
error message that says:

    "cannot move directory over file, source=D1, destination=D2/D1"

regardless of the type of existing "D2/D1".  If it is a file, the
message is correct, but if it is a directory, it is not (we could
make the D2/D1 directory a union of its original contents and what
was in D1/, but that is not what we do).

The code that decies to issue the error message only checks for
existence of "D2/D1" and does not care what kind of thing sits at
the path.

Rephrase the message to say

    "destination already exists, source=D1, destination=D2/D1"

that would be suitable for any kind of thing being in the way.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Just so that we do not forget what we discussed.  It is kind of
   interesting that no tests need adjustment for this change, which
   make me suspect how good our test coverage is.

   This patch has a trivial textual conflict with Sebastian's patch,
   but the resolution should be obvious.

 builtin/mv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 665bd27448..80fc7a3c70 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -304,7 +304,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		}
 		if (S_ISDIR(st.st_mode)
 		    && lstat(dst, &st) == 0) {
-			bad = _("cannot move directory over file");
+			bad = _("destination already exists");
 			goto act_on_entry;
 		}
 
-- 
2.42.0-rc1

