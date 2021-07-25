Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97D8C4338F
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 13:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C94360E78
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 13:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhGYM3D (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jul 2021 08:29:03 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:12488 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230343AbhGYM2n (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jul 2021 08:28:43 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 6D3521323;
        Sun, 25 Jul 2021 15:08:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1627218523; x=1629032924;
         bh=N61Kbb5rr9mc5ydLsEy0KFYLJcLMsEhXtxob2QT9x78=; b=LTdaw75Cw1d7
        ZGDXbQDAZuEdqXeXWvfYPSvMBJwjKRkg6Fupyxhjt8UBnAqGbZ45XXArEk7anwRb
        ph1WxNBCriovDe35B02yexNRRPSmzZL15oteCdzKx4KKYyoT61vxI0nz0UncfJ19
        HM+sHmGOCZJiNqBb9P3UMvhVaT4imjHzk9E2ktHBJEk8lPJcxwXQgtzQPtbTtdZb
        NrLHFOGpTTvcq/14yiqbXBcy7s04zkQF/RRwbmrk2zLvxSFz8h0+FBCgTSe8EWMn
        U+8ckISQRgPd9d8cqXnTunnQOHVbDp/L5JdBd5eddFpTfla7Apl8N2wvBQz4q6Ey
        AyapRYRiicHep1SKbb7Huk39bw+UY0kYy4pET4I4aGzVJQ3QCy6wengmF/3Z+AKO
        YDi6B1qzUxcJPk2u6lX7kGaT5eJk7+J419McJVwBbPG9d26homtAcGQ1ssT9KbN8
        oQz8BP8c5ZB+DzeWpYXSeC8qCQQzruu1soQpqH7tA20D+Oaw6scwZbYf418oTRrP
        ZYibPu4yOZY64zL9IRKVzlqDHsB1GVKUXhPi0IRF3/kANRFH670VcXXc8zvsETVl
        67VLsTn5vQ51AR+54CZXvxLiv2+VEAMkTkqZcu7BONRY0FLitM/OhjzpesgMwB2h
        GQFtnHeKOlxzq5vx5epx9kG2Gac1y50=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sJNgIdRJIcTA; Sun, 25 Jul 2021 15:08:43 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id DD31FBCD;
        Sun, 25 Jul 2021 15:08:42 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id AE9792469;
        Sun, 25 Jul 2021 15:08:40 +0200 (CEST)
From:   andrzej@ahunt.org
To:     git@vger.kernel.org
Cc:     andrzej@ahunt.org, phillip.wood123@gmail.com, newren@gmail.com
Subject: [PATCH v2 03/12] builtin/submodule--helper: release unused strbuf to avoid leak
Date:   Sun, 25 Jul 2021 15:08:21 +0200
Message-Id: <20210725130830.5145-4-andrzej@ahunt.org>
In-Reply-To: <20210725130830.5145-1-andrzej@ahunt.org>
References: <20210620151204.19260-1-andrzej@ahunt.org>
 <20210725130830.5145-1-andrzej@ahunt.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

relative_url() populates sb. In the normal return path, its buffer is
detached using strbuf_detach(). However the early return path does
nothing with sb, which means that sb's memory is leaked - therefore
we add a release to avoid this leak.

The reset is also only necessary for the normal return path, hence we
move it down to after the early-return to avoid unnecessary work.

LSAN output from t0060:

Direct leak of 121 byte(s) in 1 object(s) allocated from:
    #0 0x7f31246f28b0 in realloc (/usr/lib64/libasan.so.4+0xdc8b0)
    #1 0x98d7d6 in xrealloc wrapper.c:126
    #2 0x909a60 in strbuf_grow strbuf.c:98
    #3 0x90bf00 in strbuf_vaddf strbuf.c:401
    #4 0x90c321 in strbuf_addf strbuf.c:335
    #5 0x5cb78d in relative_url builtin/submodule--helper.c:182
    #6 0x5cbe46 in resolve_relative_url_test builtin/submodule--helper.c:248
    #7 0x410dcd in run_builtin git.c:475
    #8 0x410dcd in handle_builtin git.c:729
    #9 0x414087 in run_argv git.c:818
    #10 0x414087 in cmd_main git.c:949
    #11 0x40e9ec in main common-main.c:52
    #12 0x7f3123c41349 in __libc_start_main (/lib64/libc.so.6+0x24349)

SUMMARY: AddressSanitizer: 121 byte(s) leaked in 1 allocation(s).

Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
---
 builtin/submodule--helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 414fcb63ea..528a78eed8 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -187,11 +187,13 @@ static char *relative_url(const char *remote_url,
 		out = xstrdup(sb.buf + 2);
 	else
 		out = xstrdup(sb.buf);
-	strbuf_reset(&sb);
 
-	if (!up_path || !is_relative)
+	if (!up_path || !is_relative) {
+		strbuf_release(&sb);
 		return out;
+	}
 
+	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s%s", up_path, out);
 	free(out);
 	return strbuf_detach(&sb, NULL);
-- 
2.26.2

