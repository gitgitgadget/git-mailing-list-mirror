Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97CE31F461
	for <e@80x24.org>; Wed, 10 Jul 2019 18:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfGJSh1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 14:37:27 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45359 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbfGJSh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 14:37:27 -0400
Received: by mail-lf1-f67.google.com with SMTP id u10so2272531lfm.12
        for <git@vger.kernel.org>; Wed, 10 Jul 2019 11:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=he+bfYTaMvabn/fKges5vgvhBZ9/CKEokVhHZxfYeP8=;
        b=cq1hgCTMZ/+XvMUH+ts7c6XJiqxi2cE++TX9JU3N7JwDV9ZzUzh9SoCuA38vLdhJUZ
         EjIJVAhAsae0bQqDQ+lD20sgg1pUxHE0DKvNcx56eUs9GUFDDC8vGQOo4MW0UJdTIKZJ
         7ygH/IGFzvSomM3m17Kysr2XiBhscxaEA4SsvsL58cD1UHfOO7tauMbTSrmuBGGAu41V
         o0+hlywv4Xm60fpsagZU19WVg6FITJmpB6c6yVCTD6mNJ9bsTaKQhqx3zHiMVJD7NhHz
         x6epu4wLPc5tyPP29l/EtmbaiNrtxNTgCdGQsWw6mNEx8A0OnFGEUNiCJisdR/tJIjG6
         T0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=he+bfYTaMvabn/fKges5vgvhBZ9/CKEokVhHZxfYeP8=;
        b=Eotq5po4Iuvnrlf7hj76kFCcqCb77+WI4VZMWGm6zirPvE3dF8OixwEKRm9ifSWVWV
         4IxP9hFXocTX7Hsi0t/Zx2KYCuJAikdfuKfJIzvLD+wEbac21YNrMpuDqmD3jfI9gMxY
         R06hVb4CKivAapuBJtls6FdTxR9hUQ/Rc2Ty2eyeVpAqYe58JGhA8N1z2gkRHOg/AZoU
         hSmuTfXwoHMD/7Wdhja/Y2kwmJc0JkTdPqZtJc/J/bnayD1UYnzBSe2W2NIL5JWwryry
         vukJP3sV8j7TjZTS3ke22fVMJg0Ws/QOX4SSNokF3jTyH/oixlN2EXcWoTiPJ/+/XPIg
         8SxA==
X-Gm-Message-State: APjAAAUHJomrAeccki9V5Gy8GKo5Eu/ccWaOD9wgg0Y1R+kNK/yP7JIW
        TooQsp2MkoDCjOjDnjNmvO+1if9B
X-Google-Smtp-Source: APXvYqxzxZvi8szdvMpmBM7Wt1wX9fb8QmU7XqfQvMm/e4LLNzhIjlVMAEuB/VcO5416fDKigR3L2w==
X-Received: by 2002:ac2:4ac4:: with SMTP id m4mr541789lfp.172.1562783844841;
        Wed, 10 Jul 2019 11:37:24 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id h1sm456959lfj.21.2019.07.10.11.37.23
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 11:37:24 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] ref-filter: fix memory leak in `free_array_item()`
Date:   Wed, 10 Jul 2019 20:36:39 +0200
Message-Id: <20190710183639.4123992-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.22.0.428.g6d5b264208
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We treat the `value` pointer as a pointer to a struct and free its `s`
field. But `value` is in fact an array of structs. As a result, we only
free the first `s` out of `used_atom_cnt`-many and leak the rest. Make
sure we free all items in `value`.

In the caller, `ref_array_clear()`, this means we need to be careful not
to zero `used_atom_cnt` until after we've called `free_array_item()`. We
could move just a single line, but let's keep related things close
together instead, by first handling `array`, then `used_atom`.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 ref-filter.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 791f0648a6..1c1a2af880 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2105,7 +2105,9 @@ static void free_array_item(struct ref_array_item *item)
 {
 	free((char *)item->symref);
 	if (item->value) {
-		free((char *)item->value->s);
+		int i;
+		for (i = 0; i < used_atom_cnt; i++)
+			free((char *)item->value[i].s);
 		free(item->value);
 	}
 	free(item);
@@ -2116,14 +2118,16 @@ void ref_array_clear(struct ref_array *array)
 {
 	int i;
 
-	for (i = 0; i < used_atom_cnt; i++)
-		free((char *)used_atom[i].name);
-	FREE_AND_NULL(used_atom);
-	used_atom_cnt = 0;
 	for (i = 0; i < array->nr; i++)
 		free_array_item(array->items[i]);
 	FREE_AND_NULL(array->items);
 	array->nr = array->alloc = 0;
+
+	for (i = 0; i < used_atom_cnt; i++)
+		free((char *)used_atom[i].name);
+	FREE_AND_NULL(used_atom);
+	used_atom_cnt = 0;
+
 	if (ref_to_worktree_map.worktrees) {
 		hashmap_free(&(ref_to_worktree_map.map), 1);
 		free_worktrees(ref_to_worktree_map.worktrees);
-- 
2.22.0.428.g6d5b264208

