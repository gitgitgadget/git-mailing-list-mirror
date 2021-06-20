Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B64BC49361
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 15:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33CD16109F
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 15:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhFTPOb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 11:14:31 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:15344 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229875AbhFTPO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 11:14:28 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 917F712FC
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 17:12:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1624201934; x=1626016335;
         bh=M7xBIB3jR/9acNZxTOVZ64Wz03YiJeP6dE8TUECT3To=; b=Hj0eqvqvbCCR
        QYZ471hycQ9NMaNVKul4di/0qg5eS4yg4YrxN2hx1QrNbPeB4mylw435LSngeBra
        sGx0qhIKHgtSxJsqYfYvEdYpREnabhqB99pGZMqy1CGBc3ny2V3z1JRhd+KVDIIY
        JeF9o3Haxgb1CthclJ8lbNgbt79XNbD3H3z6EyJoq2o/VMsz7/BWNYo/dxE0F55c
        AheaXGiOc7KCVaUa6TB9hbpecp4NYkj56+D5g4HbSE61ExnT+QqYLMkB2f1jvA88
        zyrPp+JEQEskjJikZXLmQHnSal+URsFk9yWBdH/eeO/L8h7k/dUSjzInegXfk4us
        GZnIKdilux11ISAbDK9iAAsCOL75s6DQHVDpEe/4uSgj2AibnnhAs8OoFTF6MVHo
        ayvYdIhJnwjx6zPiJUl7HsImosZFgDdlmujDwCQwp63o1JAMTJ1/OKFVF0RVP4hH
        2S8P3PXhmG7sh9mhRr0q5gvIqJv5Eq+JVIPCqTCnQ7sNPKZVT26Xy8A4QVqYhDVZ
        rHHeDXEFg6bQszh4EPTad+CE+nYkVjhU0DvJHEpifJJiYcQjpu496YKeim5OfEBg
        2jUxhguzc22auHtoDwYY2C0yt3R2gmyFwzcRo3Q3zXVf9DK5S0wgKDcQcPrQlO+L
        mzmwq9YGTXEibAVW4lC0Ez3DH2HkElo=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Iu9ocvUo3f5r for <git@vger.kernel.org>;
        Sun, 20 Jun 2021 17:12:14 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 0D3C85C1
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 17:12:13 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 9E87334B;
        Sun, 20 Jun 2021 17:12:12 +0200 (CEST)
From:   andrzej@ahunt.org
To:     git@vger.kernel.org
Cc:     andrzej@ahunt.org
Subject: [PATCH 03/12] builtin/submodule--helper: release unused strbuf to avoid leak
Date:   Sun, 20 Jun 2021 17:11:55 +0200
Message-Id: <20210620151204.19260-4-andrzej@ahunt.org>
In-Reply-To: <20210620151204.19260-1-andrzej@ahunt.org>
References: <20210620151204.19260-1-andrzej@ahunt.org>
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
index ae6174ab05..4015d114b3 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -188,11 +188,13 @@ static char *relative_url(const char *remote_url,
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

