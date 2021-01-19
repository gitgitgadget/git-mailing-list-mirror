Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7ADAC433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79AEF22D71
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405144AbhASOwQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 09:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388095AbhASOn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 09:43:57 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F360C061575
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 06:43:16 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id g3so9444304ejb.6
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 06:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e++4EuSUki4qhfmh0FkfXvyz4ZW2jABlIMoNSC7ENlI=;
        b=HKvHRDwTgDHTWsdmCSlOQFacIXv1eAbjJxjzQti9+PiP/AZLwcr5kTS52EehNJcyz6
         fh5MtWVW/NaqhRSLyZeYQN9eOogOD0ADcdxBLbCmgg2h7Y2Kxt9jVymvclWQvTsB0e+M
         DcVsqfh5MHwH8V+ZaA2b+/XPnZmv1K/MvqQM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e++4EuSUki4qhfmh0FkfXvyz4ZW2jABlIMoNSC7ENlI=;
        b=H/AZsZ0YVXzTNOIVg/qsYdCNpgqjGbFfqhYjW+6PjQdk8g2ohu3MxGzAR2JdTNYNVB
         aXExXfyWmO2jxBVwFh0dM/ynQ8v2/CaOAapC2qca1AJJf9gWWMI3trEsUta9UNai79nQ
         gFOYxdGNpuPUNLCAo/P1Wb+O6wLMoKci6wWMcyalZLGAcJ7heMmBZTExf+CEjD3pWrbB
         IamF5zVojSR4M28aLKx/3J85cBjjQqP5rfH+LNcRdCJemXK6colzcp+1dXikhA3dvS5t
         KedP/Qwil98yUdaScav6FjOMBVqLIU/QYaysV0QyapAHTw4rVZCdkGSCbb5VCi/TLS6Q
         /sTw==
X-Gm-Message-State: AOAM532bOKZCKdEk60Mbr6oNdadCJKFbPtoYSekTZNmlVOZJgrZ05+tB
        sAfw2f+EULhyVo/zeCdliQq0FaLud7gSn/90
X-Google-Smtp-Source: ABdhPJwJaxzXr9OUbzHhwbLaX6unLtdMka4sx5VqPIx0Dyd3kIboVb6BbJX1rwS7S8/npC+7E8h0GA==
X-Received: by 2002:a17:906:2694:: with SMTP id t20mr3264241ejc.48.1611067394827;
        Tue, 19 Jan 2021 06:43:14 -0800 (PST)
Received: from localhost.localdomain (e93008.upc-e.chello.nl. [213.93.93.8])
        by smtp.gmail.com with ESMTPSA id j25sm12037652edy.13.2021.01.19.06.43.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jan 2021 06:43:14 -0800 (PST)
From:   Jacob Vosmaer <jacob@gitlab.com>
To:     git@vger.kernel.org
Cc:     Jacob Vosmaer <jacob@gitlab.com>
Subject: [PATCH 1/1] ls-refs.c: minimize number of refs visited
Date:   Tue, 19 Jan 2021 15:42:51 +0100
Message-Id: <20210119144251.27924-2-jacob@gitlab.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210119144251.27924-1-jacob@gitlab.com>
References: <20210119144251.27924-1-jacob@gitlab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous implementation of ls-refs would perform exactly one ref
walk, matching each ref against the prefixes (if any) provided by the
user. This can be expensive if there are a lot of refs and the user
only cares about a small subset of them.

In this patch we analyze the prefixes provided by the user and build a
minimal set of disjoint prefixes that contains all of them. We then do
a ref walk for each of these minimal prefixes.

It is tempting to have just one strvec for the prefixes and use it
both for matching and for iterating. But every time I tried that, it
made things more complicated. I settled on leaving the existing ref
matching (using &data.prefixes) alone, and I added a new layer around
it for the ref walk optimization (using &iter_prefixes).

This commit also fixes a bug in ls-refs.c that was not triggered
before: we were using a strvec set to zero, which is not how you are
supposed to initialize a strvec. We now call strvec_init after zeroing.

Signed-off-by: Jacob Vosmaer <jacob@gitlab.com>
---
 ls-refs.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/ls-refs.c b/ls-refs.c
index a1e0b473e4..6d5f0c769a 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -84,12 +84,44 @@ static int ls_refs_config(const char *var, const char *value, void *data)
 	return parse_hide_refs_config(var, value, "uploadpack");
 }
 
+static int cmp_prefix(const void *a_, const void *b_){
+	const char *a = *(const char **)a_;
+	const char *b = *(const char **)b_;
+	return strcmp(a, b);
+}
+
+static void deduplicate_prefixes(struct strvec *prefixes) {
+	int i;
+
+	QSORT(prefixes->v, prefixes->nr, cmp_prefix);
+
+	for (i = 1; i < prefixes->nr;) {
+		const char *p = prefixes->v[i];
+
+		/*
+		 * If p is "refs/foobar" and its predecessor is "refs/foo" then we should
+		 * drop p, both to avoid sending duplicate refs to the user, and to avoid
+		 * doing unnecessary work.
+		 */
+		if (starts_with(p, prefixes->v[i - 1])) {
+			MOVE_ARRAY(&prefixes->v[i], &prefixes->v[i + 1], prefixes->nr - (i + 1));
+			prefixes->v[prefixes->nr - 1] = p;
+			strvec_pop(prefixes);
+		} else {
+			i++;
+		}
+	}
+}
+
 int ls_refs(struct repository *r, struct strvec *keys,
 	    struct packet_reader *request)
 {
 	struct ls_refs_data data;
+	struct strvec iter_prefixes = STRVEC_INIT;
+	const char **p;
 
 	memset(&data, 0, sizeof(data));
+	strvec_init(&data.prefixes);
 
 	git_config(ls_refs_config, NULL);
 
@@ -109,8 +141,37 @@ int ls_refs(struct repository *r, struct strvec *keys,
 		die(_("expected flush after ls-refs arguments"));
 
 	head_ref_namespaced(send_ref, &data);
-	for_each_namespaced_ref(send_ref, &data);
+
+	/*
+	 * Try to create a minimal disjoint set of prefixes that
+	 * contains everything the user wants to see, but that lets us
+	 * avoid a full ref walk. If the repo has a lot of refs and
+	 * the user only wants to see refs/heads and refs/tags,
+	 * it is faster to do two small walks of refs/heads and
+	 * refs/tags instead of one big walk of all of refs/.
+	 */
+	for (p = data.prefixes.v; *p; p++) {
+		if (starts_with(*p, "refs/")) {
+			strvec_push(&iter_prefixes, *p);
+		} else { /* full ref walk in pathological cases like "" */
+			strvec_push(&iter_prefixes, "refs/");
+		}
+	}
+
+	if (!iter_prefixes.nr) /* full ref walk when there are no prefixes */
+		strvec_push(&iter_prefixes, "refs/");
+
+	deduplicate_prefixes(&iter_prefixes);
+
+	for (p = iter_prefixes.v; *p; p++) {
+		struct strbuf buf = STRBUF_INIT;
+		strbuf_addf(&buf, "%s%s", get_git_namespace(), *p);
+		for_each_fullref_in(buf.buf, send_ref, &data, 0);
+		strbuf_release(&buf);
+	}
+
 	packet_flush(1);
 	strvec_clear(&data.prefixes);
+	strvec_clear(&iter_prefixes);
 	return 0;
 }
-- 
2.30.0

