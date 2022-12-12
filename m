Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12D8C4708E
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 11:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiLLLkr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 06:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiLLLkX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 06:40:23 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A696428
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 03:35:33 -0800 (PST)
Received: from localhost (unknown [86.123.78.117])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 629DB66015F1
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 11:35:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670844932;
        bh=EpPuOYcNIDJvsjrEc2MG3EoLBObwkpDINMLMFYEfS0M=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dsf6w6prZiwWdNS4Qi5W12Tleox2dnDoJC640Lt38ZzpYplZmgsmteRLhL/M5EPPv
         F2mGRVgYU9sWpHtgZxnUXBdrVWKDV/TqSnpcn7kw2ApCgv2E2Jt5i70vifs1Vzg2KL
         TyNeR8MfZHGkfcMkncfe99BdXtifrIL+Fvb1s0t1d4JZg/5GpFD4pRf4xOBZWnSUBw
         eJTQU1vDMiKZJm2N35svQEdZxz3LaX++eA2P76JCMqwk3ZjXvPH/EzJGj+c0S7BLTj
         2Qp3FMNNfGgGXpdfSrCLt+yZMT2ly2CMZbTyup6UjPbu6/2Av4X+NnBMKehv+euPHS
         yC4qqClZ0Kzhw==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     git@vger.kernel.org
Subject: [RFC PATCH 1/1] rebase --onto: Skip previously applied commits
Date:   Mon, 12 Dec 2022 13:35:16 +0200
Message-Id: <20221212113516.27816-2-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221212113516.27816-1-cristian.ciocaltea@collabora.com>
References: <20221212113516.27816-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When rebase is used with '--onto <newbase>', the patches that might have
been already applied on <newbase> are not detected, unless they resolve
to an empty commit. When the related files contain additional changes
merged, the rebase operation fails due to conflicts that require manual
intervention.

Ensure the '--onto' variant behaviour is consistent with the common
rebase by dropping the already applied commits on the target branch.

Note the current behavior is still reachable by using the
'--reapply-cherry-picks' flag.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 builtin/rebase.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index b22768ca5b9f..2907c6db5cce 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1659,8 +1659,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		strbuf_addstr(&buf, "...");
 		strbuf_addstr(&buf, branch_name);
 		options.onto_name = xstrdup(buf.buf);
-	} else if (!options.onto_name)
+	} else if (!options.onto_name) {
 		options.onto_name = options.upstream_name;
+	} else if (options.upstream) {
+		options.restrict_revision = options.upstream;
+		options.upstream = NULL;
+	}
 	if (strstr(options.onto_name, "...")) {
 		if (get_oid_mb(options.onto_name, &branch_base) < 0) {
 			if (keep_base)
-- 
2.38.1

