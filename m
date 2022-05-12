Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B705C433F5
	for <git@archiver.kernel.org>; Thu, 12 May 2022 22:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356068AbiELWb1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 18:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349298AbiELWbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 18:31:25 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F53556FA9
        for <git@vger.kernel.org>; Thu, 12 May 2022 15:31:25 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C5291368B9;
        Thu, 12 May 2022 18:31:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7W6meANiQE9wqjEyvvuq5rwR5MsOPXoD56RKz0
        9IWlk=; b=Vjoe1rfBJ8I//4zN6Shc8c+r0awjqXFnL2bNEArWC88dLF56fOYgiW
        Fd4jfSfmf07UydFO707BvKYJx3SGmERm3XOINo6wRAJv6/Xt2g965sY+JtnR7cjY
        aVfxPEtX9LPMiFRU0FcqSq8C35uctUP72tv01ZSBwjZNCsxhoDRjM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 222061368B7;
        Thu, 12 May 2022 18:31:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 839981368B6;
        Thu, 12 May 2022 18:31:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] fixup! archive: optionally add "virtual" files
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
        <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
        <45662cf582ab7c8b1c32f55c9a34f4d73a28b71d.1652210824.git.gitgitgadget@gmail.com>
        <xmqqtu9x6ovh.fsf@gitster.g>
Date:   Thu, 12 May 2022 15:31:19 -0700
In-Reply-To: <xmqqtu9x6ovh.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        10 May 2022 14:48:02 -0700")
Message-ID: <xmqqee0ye62w.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3FBBD0A8-D243-11EC-BA83-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do not let add_file_cb() assume that two existing callers are the
only ones, and checking that the caller is not one of them is
sufficient to determine it is the other one.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * To be squashed to the commit with the title in the series.

   The "What's cooking" report is getting crowded with too many
   topics marked as "Expecting a reroll", and I'm trying to do
   easier ones myself to see how much reduction we can make.

 archive.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/archive.c b/archive.c
index 477eba60ac..98c7449ea1 100644
--- a/archive.c
+++ b/archive.c
@@ -533,7 +533,7 @@ static int add_file_cb(const struct option *opt, const char *arg, int unset)
 		if (!S_ISREG(info->stat.st_mode))
 			die(_("Not a regular file: %s"), path);
 		info->content = NULL; /* read the file later */
-	} else {
+	} else if (!strcmp(opt->long_name, "add-file-with-content")) {
 		struct strbuf buf = STRBUF_INIT;
 		const char *p = arg;
 
@@ -560,6 +560,8 @@ static int add_file_cb(const struct option *opt, const char *arg, int unset)
 		info->stat.st_mode = S_IFREG | 0644;
 		info->content = xstrdup(p + 1);
 		info->stat.st_size = strlen(info->content);
+	} else {
+		BUG("add_file_cb() called for %s", opt->long_name);
 	}
 	item = string_list_append_nodup(&args->extra_files, path);
 	item->util = info;
-- 
2.36.1-338-g1c7f76a54c

