Return-Path: <SRS0=OIeF=BS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B8AC433E0
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 07:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02E2420866
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 07:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="EWl06pZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgHHHxu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 03:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgHHHxu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 03:53:50 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C33C061756
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 00:53:49 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1596873225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sDo2/z5eCBbp3hBqM3X9hwfsAtnvj61fAyLrtPuHHcE=;
        b=EWl06pZpKwQGyfeY9Wu1455ypJxXExaKbPysCiQEU+6H/xMcGFIGjyNR4ENWNPodCEa+px
        izZ25W4GcIkJmsVsGft8Po+Et5lyfWmO5HjLoqCqQhOKpOVAfYLrS6Ru/4ZcO0thiYNXuc
        Bwv0JExCjB5wq2ZwQxrGM1u3kczJoKk=
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, "Raymond E. Pasco" <ray@ameretat.dev>
Subject: [PATCH 1/1] diff-lib: use worktree mode in diffs from i-t-a entries
Date:   Sat,  8 Aug 2020 03:53:23 -0400
Message-Id: <20200808075323.36041-1-ray@ameretat.dev>
In-Reply-To: <20200806060119.74587-1-ray@ameretat.dev>
References: <20200806060119.74587-1-ray@ameretat.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When creating "new file" diffs against i-t-a index entries, diff-lib
erroneously used the mode of the cache entry rather than the mode of the
file in the worktree. This changes run_diff_files() to correctly use the
mode of the worktree file in this case.

Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
---
This is a distinct bugfix from the other changes, so I've sent it as a
separate patch also based on v2.28.0.

 diff-lib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/diff-lib.c b/diff-lib.c
index 25fd2dee19..50521e2093 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -219,7 +219,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 				continue;
 			} else if (revs->diffopt.ita_invisible_in_index &&
 				   ce_intent_to_add(ce)) {
-				diff_addremove(&revs->diffopt, '+', ce->ce_mode,
+				newmode = ce_mode_from_stat(ce, st.st_mode);
+				diff_addremove(&revs->diffopt, '+', newmode,
 					       &null_oid, 0, ce->name, 0);
 				continue;
 			}
-- 
2.28.0.5.gfc8e108108

