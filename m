Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DCD21F403
	for <e@80x24.org>; Thu,  7 Jun 2018 14:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932888AbeFGOEO (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 10:04:14 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:45669 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932838AbeFGOEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 10:04:09 -0400
Received: by mail-qt0-f194.google.com with SMTP id i18-v6so9913456qtp.12
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 07:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n5m7DdAfZW7vxlFpLXWRr0qZm/eRnIlMUzRvM3jywBI=;
        b=M5H7pV7h6MTfgLJggt0aM11p8aabSMXUnJ75W7aXgMXJY4W3PDVc5gBG8sgV/sKf4Z
         023cibp+40oglyxnxt7NBqLjavDvG+6qJf3hFo0mbVdIMdmn5LPdKs1YPHL7bmIofQLc
         bqMm5O2AzHoA+C2okr5rQbEqRm4VI/LC9Nxiw11eGPgp0p7QzZwlIUbH6j3fQwzzgxwt
         xCVVL64A7OCKyHXsh9ASQdgeIKO4qHQFpi2K9GCC5Vq+EZGqmN1VLSes7qtQlk63UCol
         RfOMy0iaaQdg1+/vde/j9OqwuyKSBPIHRyHxdumyuSPRTK48w++zfvtKoIgPqznCMXrW
         1IYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n5m7DdAfZW7vxlFpLXWRr0qZm/eRnIlMUzRvM3jywBI=;
        b=NjirpJuvzj9MZ+kOBQUVnMKSHQeClNDYFIf1iqNQDZ/FbajS4d7N1nkditQ2RcPDf1
         7ysdqbnxheZRnp30ypjkc0ryeyKIm21oWW+9Hj78bFwHV43xZHuH3+IDR9lIvKzpzXiZ
         IDoOfa3VXpDr1Ay16NSWrqAhUTlT1gbDNt53/MoZUu7A6jWRXakQBYj+2qOtZzh+qhZZ
         eIG/CkBOazHs8nX7KP6ySMov+0N2/DWx4QyGw5cSu3+5oDn5J+phKIstdPd4zj4yA8p+
         7tcaLvbv6N5V6OxPRJYFKzcnmP12tVkC3svKZB/aFswqQCqlt8uqf9I/6f8KmYGxnQsf
         hl/Q==
X-Gm-Message-State: APt69E3UW2ITSCFQoM4iF5eVTbtnBduKJEdfQmIqI5Q3zNR6qhhfcbtt
        JwUyh1JpdniJpk9F68ra/RykxQYx
X-Google-Smtp-Source: ADUXVKLdh60aMyGW5BoFvgwjddraZ+fqP0PjyM63U0TZh1a9eneLUayRFPa80OKk9Mjh3lVz3SOKIw==
X-Received: by 2002:a0c:d790:: with SMTP id z16-v6mr1784720qvi.33.1528380248134;
        Thu, 07 Jun 2018 07:04:08 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u74-v6sm12532763qku.55.2018.06.07.07.04.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 07:04:07 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, dstolee@microsoft.com, avarab@gmail.com,
        jrnieder@gmail.com, jonathantanmy@google.com, mfick@codeaurora.org
Subject: [PATCH 21/23] midx: prevent duplicate packfile loads
Date:   Thu,  7 Jun 2018 10:03:36 -0400
Message-Id: <20180607140338.32440-22-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180607140338.32440-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the multi-pack-index contains a packfile, then we do not need to add
that packfile to the packed_git linked list or the MRU list.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c     | 23 +++++++++++++++++++++++
 midx.h     |  1 +
 packfile.c |  7 +++++++
 3 files changed, 31 insertions(+)

diff --git a/midx.c b/midx.c
index 388d79b7d9..3242646fe0 100644
--- a/midx.c
+++ b/midx.c
@@ -278,6 +278,29 @@ int fill_midx_entry(const struct object_id *oid, struct pack_entry *e, struct mi
 	return nth_midxed_pack_entry(m, e, pos);
 }
 
+int midx_contains_pack(struct midxed_git *m, const char *idx_name)
+{
+	uint32_t first = 0, last = m->num_packs;
+
+	while (first < last) {
+		uint32_t mid = first + (last - first) / 2;
+		const char *current;
+		int cmp;
+
+		current = m->pack_names[mid];
+		cmp = strcmp(idx_name, current);
+		if (!cmp)
+			return 1;
+		if (cmp > 0) {
+			first = mid + 1;
+			continue;
+		}
+		last = mid;
+	}
+
+	return 0;
+}
+
 int prepare_midxed_git_one(struct repository *r, const char *object_dir)
 {
 	struct midxed_git *m = r->objects->midxed_git;
diff --git a/midx.h b/midx.h
index 497bdcc77c..c1db58d8c4 100644
--- a/midx.h
+++ b/midx.h
@@ -13,6 +13,7 @@ struct object_id *nth_midxed_object_oid(struct object_id *oid,
 					struct midxed_git *m,
 					uint32_t n);
 int fill_midx_entry(const struct object_id *oid, struct pack_entry *e, struct midxed_git *m);
+int midx_contains_pack(struct midxed_git *m, const char *idx_name);
 int prepare_midxed_git_one(struct repository *r, const char *object_dir);
 
 int write_midx_file(const char *object_dir);
diff --git a/packfile.c b/packfile.c
index 059b2aa097..479cb69b9f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -746,6 +746,11 @@ static void prepare_packed_git_one(struct repository *r, char *objdir, int local
 	DIR *dir;
 	struct dirent *de;
 	struct string_list garbage = STRING_LIST_INIT_DUP;
+	struct midxed_git *m = r->objects->midxed_git;
+
+	/* look for the multi-pack-index for this object directory */
+	while (m && strcmp(m->object_dir, objdir))
+		m = m->next;
 
 	strbuf_addstr(&path, objdir);
 	strbuf_addstr(&path, "/pack");
@@ -772,6 +777,8 @@ static void prepare_packed_git_one(struct repository *r, char *objdir, int local
 		base_len = path.len;
 		if (strip_suffix_mem(path.buf, &base_len, ".idx")) {
 			/* Don't reopen a pack we already have. */
+			if (m && midx_contains_pack(m, de->d_name))
+				continue;
 			for (p = r->objects->packed_git; p;
 			     p = p->next) {
 				size_t len;
-- 
2.18.0.rc1

