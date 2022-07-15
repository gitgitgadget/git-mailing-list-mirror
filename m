Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A95DC43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 17:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiGOR3y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 13:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiGOR3u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 13:29:50 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A696632447
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 10:29:48 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id l16-20020a170902f69000b0016bf6a77effso2335496plg.2
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 10:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=oWPDI93y8N+vFLHMZbjlTIfvqdGvKATsgtY/hC8+lR8=;
        b=Oh7jyx4xPw0nMRDfSWWBku1q/rurMAYLy5BGcnhPc43DKOB55gSlI7HbhM82t+j+6+
         jBsWjejg74EH6WLRlUmRPMcAm+1Ci6+odNNZu97LCvpMlaGs+V/GrQ0SMvZGYkJbTREA
         NFUMBbWfVCLNpLoO44DLHY4g2XRC54WYSvxpaZFGukxNi3GwzjcFowopA4lwEZOD9FDo
         F+b7gwDsyKRWGYQlJuG/83Yatc73oA5W6fJPWaeu0XEgHNr2ChtSzQwCwrgR+aTc2JAs
         V1gorM1PRoaHJg9WjSMLZXwJCZkRWk3sRbyYi6dhX5ScGqGpGmcmzz8BSwmViFDNMqv5
         Zklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=oWPDI93y8N+vFLHMZbjlTIfvqdGvKATsgtY/hC8+lR8=;
        b=pQ6zqTcHVGhDXndBltu0qF5y05EKYQ5aKj1pM2tPy/1kn/ravQhDyazYKwjxzz2pMe
         N0E3BQ6kcXWQdVucCXtSAd8sehvsN2WM++Z4T0XgBMexCXt9OxSXmZdZ0E3M3hU2q2cg
         8uwImEEc3CXK4doLkZnWyO0EPoR2n6hNTewQZ3K0BNj/ZEGUWKODp7kkWDmC9WSxjeNJ
         EAbhmIOFmVmTIDX6kTNXGjYeM605RvgqVZvo7OaSt8RIDTrIfK471riKtk3HjpzVv2J/
         ILDCHq2FlmXH9+S77ouRZzEknhaJiTbfGD+yfPibpzz44JWZ+lzNmDJ7cZSxzxuAP4c+
         cXvw==
X-Gm-Message-State: AJIora8cYBfu72i0CNtpRq56yU97SGyV0HlOYVQrzbq6EmLYigL1R4h9
        nkU+m1QCZyiNNdZHJuI2R0++v3dK7dxlwJv6iVVba1VgrHhf/0A6jy4/T25Uwxg5YnUBrvuV7+Y
        zBkluGP02XCV0ASB0krUlBp+rF/8shSeit4XZO4zDCtACQWc3oh/12ApQMSrT6KrI1Z+AldtLGv
        ij
X-Google-Smtp-Source: AGRyM1tQXX81PGRdNRz+WZw4ftHIc6480fjvO3fggDttAcgfqNUfRqceHbXOi91Qjk3jGOl6cd1AcDd0VK4AlSTeAWcd
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:903:245:b0:16b:9b6d:20bc with
 SMTP id j5-20020a170903024500b0016b9b6d20bcmr14255836plh.14.1657906188011;
 Fri, 15 Jul 2022 10:29:48 -0700 (PDT)
Date:   Fri, 15 Jul 2022 10:29:42 -0700
Message-Id: <20220715172943.2681492-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH] fetch-pack: write effective filter to trace2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Administrators of a managed Git environment (like the one at $DAYJOB)
might want to quantify the performance change of fetches with and
without partial clone from the client's point of view. Therefore, log
the effective filter being sent to the server whenever a fetch (or
clone) occurs. Note that this is not necessarily the same as what's
specified on the CLI, because during a fetch, the configured filter is
used whenever a filter is not specified on the CLI.

This is implemented for protocol v0, v1, and v2.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index cb6647d657..dec8743bec 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -392,7 +392,10 @@ static int find_common(struct fetch_negotiator *negotiator,
 	if (server_supports_filtering && args->filter_options.choice) {
 		const char *spec =
 			expand_list_objects_filter_spec(&args->filter_options);
+		trace2_data_string("fetch", the_repository, "fetch/effective-filter", spec);
 		packet_buf_write(&req_buf, "filter %s", spec);
+	} else {
+		trace2_data_string("fetch", the_repository, "fetch/effective-filter", "none");
 	}
 	packet_buf_flush(&req_buf);
 	state_len = req_buf.len;
@@ -1328,9 +1331,12 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 		const char *spec =
 			expand_list_objects_filter_spec(&args->filter_options);
 		print_verbose(args, _("Server supports filter"));
+		trace2_data_string("fetch", the_repository, "fetch/effective-filter", spec);
 		packet_buf_write(&req_buf, "filter %s", spec);
-	} else if (args->filter_options.choice) {
-		warning("filtering not recognized by server, ignoring");
+	} else {
+		if (args->filter_options.choice)
+			warning("filtering not recognized by server, ignoring");
+		trace2_data_string("fetch", the_repository, "fetch/effective-filter", "none");
 	}
 
 	if (server_supports_feature("fetch", "packfile-uris", 0)) {
-- 
2.37.0.170.g444d1eabd0-goog

