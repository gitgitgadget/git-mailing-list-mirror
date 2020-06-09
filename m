Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209C2C433DF
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 23:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A06212078C
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 23:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="ZW/JZv8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgFIXwx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 19:52:53 -0400
Received: from avasout04.plus.net ([212.159.14.19]:35938 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgFIXww (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 19:52:52 -0400
Received: from [10.0.2.15] ([217.32.115.138])
        by smtp with ESMTPA
        id io2yj35n7rXCcio2zjPBZb; Wed, 10 Jun 2020 00:52:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1591746770; bh=cMY+hIAb1XXlxMoMKaHvXrTLYQp/pN5FCEY6gii3PA8=;
        h=To:Cc:From:Subject:Date;
        b=ZW/JZv8ZBHy7pF2EumVWC1hOHQ5QdHebu+8v6EAgqD6ShXbHeKu1qOfwde6yLMe0o
         bnj4yZTZhYnSpffjVbw/8ELM84e2VfuBP5CCoIiKibQLUta71VDmO1nJazYEnvzSjs
         jwlTUNN9A6644/IvE2bSfYFxGUCMPRFMaXFLlXG2CRAHlSv3RzqLU5RsAbCz1oVe2A
         QPAhhCfQhlTbrf4Z1m9NhR9MPtq3VWwCs6nfB7RCO9bwHyD/tFGe3uztn/hcyKbG44
         lH/AqwXSDHk0/AiqiMCr2hhFKzOvAnFbpcfe/GTr4nPh2uPYzGdu2zP67ycRYliJR3
         GCaaLriTiqYiA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Q+xJH7+a c=1 sm=1 tr=0
 a=T9WNts+jH3PhiGdS1gtV5Q==:117 a=T9WNts+jH3PhiGdS1gtV5Q==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=ADwfJgPhLUSuyJab2bAA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] builtin/worktree.c: fix a sparse '0 as NULL pointer' warning
Message-ID: <89e22af5-227f-7a38-372a-af2fe7d42be2@ramsayjones.plus.com>
Date:   Wed, 10 Jun 2020 00:52:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMcO7Gv6eE/Ft3G0mKVSnUpLLCHmN0+g8M26cEUbIIpeZxSGGMNmQ1x33yIlaBVM5NNA+7zxuCnF6JFHYaPc8teY0ARuHHeAbCFu146H8GAg+usLME87
 CsnecF+cKz6WvzeZ5TGCPnndHmyHotmOTppFBo/k9rZGFG0Br73ANcn6qCl2iyctorOeRVN5gMsRjA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Eric,

If you need to re-roll your 'es/worktree-duplicate-paths' branch, could you
please squash this into the relevant patch (commit 71806ee9e8 (worktree: prune
linked worktree referencing main worktree path, 2020-06-08)).

Note that this is based on top of the 'pu' branch, and Junio has a fixup
patch (commit 4b01d684fe (SQUASH??? -Werror=main, 2020-06-08)) which also
changes this line of code (s/main/main_path/).

Thanks!

ATB,
Ramsay Jones

 builtin/worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7762333228..2d8540bdae 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -199,7 +199,7 @@ static void prune_worktrees(void)
 	strbuf_add_absolute_path(&main_path, get_git_common_dir());
 	/* massage main worktree absolute path to match 'gitdir' content */
 	strbuf_strip_suffix(&main_path, "/.");
-	string_list_append(&kept, strbuf_detach(&main_path, 0));
+	string_list_append(&kept, strbuf_detach(&main_path, NULL));
 	prune_dups(&kept);
 	string_list_clear(&kept, 1);
 
-- 
2.27.0
