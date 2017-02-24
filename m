Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D198B201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 20:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbdBXUnk (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 15:43:40 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33170 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbdBXUni (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 15:43:38 -0500
Received: by mail-pg0-f52.google.com with SMTP id z128so15627709pgb.0
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 12:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BpSnjWgKcdOZzFaGXtW2lvKtX2SyXh4Ckk0dOGA9mRU=;
        b=J1MJgafV5hJVWawzMaCDyiQzms+nBsar4uVt99H3xa7v8g1L1kQpx9tJ3PULZKsCE6
         Xt4eaZWtyBzfl2SSAaJNqniV7nVCrO1IXRDNcrehJrIafuClAoOSWThxWpEKgHnKUVT2
         IDWL+ljFhlG/bHMuDKVcUv6jxjCDlts/EMz1wrDkZ42NaJbj51peozFZeKNpFBnRo1w6
         I/TtTA6idKIqg5iLVTTgGYIXKnHfVeCTbrGQGhtXtZ3gyy1Oz/9Odka4eFmH2yHKzB4t
         VyMonKIwExIWpHK7mMowvzGhtxQVt0+uE20REdbwGHzgmsCqS8yfdnN0yjGjhp+ugfXN
         iF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BpSnjWgKcdOZzFaGXtW2lvKtX2SyXh4Ckk0dOGA9mRU=;
        b=YqyaA1AK0K7R7MMpQE+0ZF+fbgNbTqi9HM82MlZN1tddRODzdl2E9fqTYStqXBYpH8
         GGnaZadMOl3DPmfiilFyGrOsolqgDUsoYhyygW2XKpMAnZzHsnp8jhJHH9XQ9ubSRyod
         bg/Bk03p+9tueBfffpmum066f6UzBVhsEekZHHeMSKRuRX0sHKvOq+PgKvt25t1t5G40
         y5V3ojnw3e6ZAh6+NuR4gAklifkK/BeZoFFQ7YAxXKHmhvUPxqZCb+wrKV+Mbw3+zfxI
         QnE9EMz+joKHCCad+OzpAm/yAGW61w8yDQNusBOJcLhvLh4KD9vk7fe2RAF+G2sdCVmv
         mefg==
X-Gm-Message-State: AMke39ndJ4G76r4y5hV2v0hyWI0K/K+VU7F8B9jEOuVwlRIovg0xEM/C/H0tKjmrEWX3nVmN
X-Received: by 10.98.133.202 with SMTP id m71mr5966230pfk.102.1487969017498;
        Fri, 24 Feb 2017 12:43:37 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2d9e:d4fd:456:fee4])
        by smtp.gmail.com with ESMTPSA id n8sm16764524pgc.16.2017.02.24.12.43.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 12:43:36 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, peff@peff.net
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] refs: parse_hide_refs_config to use parse_config_key
Date:   Fri, 24 Feb 2017 12:43:35 -0800
Message-Id: <20170224204335.10652-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.16.ge4278d41a0.dirty
In-Reply-To: <20170224203940.hbmfsouw5k67l3h3@sigill.intra.peff.net>
References: <20170224203940.hbmfsouw5k67l3h3@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

parse_config_key was introduced in 1b86bbb0ade (config: add helper
function for parsing key names, 2013-01-22), the NEEDSWORK that is removed
in this patch was introduced at daebaa7813 (upload/receive-pack: allow
hiding ref hierarchies, 2013-01-18), which is only a couple days apart,
so presumably the code replaced in this patch was only introduced due
to not wanting to wait on the proper helper function being available.

Make the condition easier to read by using parse_config_key.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index cd36b64ed9..21bc8c9101 100644
--- a/refs.c
+++ b/refs.c
@@ -1034,10 +1034,11 @@ static struct string_list *hide_refs;
 
 int parse_hide_refs_config(const char *var, const char *value, const char *section)
 {
+	const char *subsection, *key;
+	int subsection_len;
 	if (!strcmp("transfer.hiderefs", var) ||
-	    /* NEEDSWORK: use parse_config_key() once both are merged */
-	    (starts_with(var, section) && var[strlen(section)] == '.' &&
-	     !strcmp(var + strlen(section), ".hiderefs"))) {
+	    (!parse_config_key(var, section, &subsection, &subsection_len, &key)
+	    && !subsection && !strcmp(key, "hiderefs"))) {
 		char *ref;
 		int len;
 
-- 
2.12.0.rc1.16.ge4278d41a0.dirty

