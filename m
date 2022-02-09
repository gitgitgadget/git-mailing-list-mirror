Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552B9C433F5
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 16:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236754AbiBIQYC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 11:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiBIQYB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 11:24:01 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BD8C0613C9
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 08:24:04 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id y8so2418401pfa.11
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 08:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+MosabNMOhMq91JEQgJ381MySSG00LnAQCMCGj6e0fA=;
        b=ZC/yQB+YXx2aINNVfcl6gIsGqp/xoCq7ovPv1Yr+JnO4yin1adq/r42Ieaok6eW3Kq
         dOpS+t39WRxBUPURBYMO5oAHa1PMudlEv6rGNQyzJB2nH1CmCQjlCBLweqUaWP3OZz3l
         GoZNbWhkmIMPwS5QPrR6iL1zDe3vuEClNq/xAYWhcqSKtUjINFBuP/5lRBBUYIOA0IBy
         o+44AXKsScGimTGzqAwJs3RFoxGpnxcQl1FlqFe1w8B0tcIvYYdR6+1ESLf9KwFS5ios
         BsneOLaSLXQJyExfKY1M9IkR587XGp2CZNeMg4QGptwn5ew9XQCfWt2KS7uhrPNXM4zx
         ej+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+MosabNMOhMq91JEQgJ381MySSG00LnAQCMCGj6e0fA=;
        b=mezQkO65IKUFcU5o5WXQJTCZ6bM3zWW6iPWfBBW1qh+92aFhv9bmhp3Rm0wusjU+MA
         G+AAY9S8hop5nFvvWaZDbPUoS4VZjXD7n4SHcM3nLWKF6dkVnKU/EJFr6nie/l3TSis1
         p8XekYcgk8d9YH3s37ddu3ju1+qKJqJl0YLuWu3yyZdaIGNjU9MUSYdBl/lP1RPewjtZ
         s4wYhE7Q2E6U2v4rhAqSom/q3c52yAKHKRp3gun7eftSD5sZknj5wtInBTRZkjQiaxi3
         NUUWRwjR1+QFB208XTrUbAm3isDrUoGXJ7YrsWfCDBiUurb33Zpevs5pW4/i3Y/D2/+r
         HnHA==
X-Gm-Message-State: AOAM530Ylw6zzQJuxc820nwY8AmndELZ8sMGS3uPcWDOc4ry6kTjDlKA
        ryIfUuVdrDTd4I7YTvu/S3p4mZ7A+AI=
X-Google-Smtp-Source: ABdhPJyOzSIZXoa8JaFUG+T96yZEpcb3JesL5OSRTODoG7S4Pu7j9hu90j5UMWoSWHYJrXaYS85nkw==
X-Received: by 2002:aa7:9512:: with SMTP id b18mr1531078pfp.53.1644423843123;
        Wed, 09 Feb 2022 08:24:03 -0800 (PST)
Received: from xavier.lan ([2001:470:b:114::cc1])
        by smtp.gmail.com with ESMTPSA id u12sm21504246pfk.220.2022.02.09.08.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 08:24:02 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, paulus@ozlabs.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH 1/3] log: fix memory leak if --graph is passed multiple times
Date:   Wed,  9 Feb 2022 09:23:47 -0700
Message-Id: <20220209162350.169971-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.32.0.2645.gc109162a1f
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 revision.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/revision.c b/revision.c
index ad4286fbdd..c03c387edd 100644
--- a/revision.c
+++ b/revision.c
@@ -2424,9 +2424,11 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->pretty_given = 1;
 		revs->abbrev_commit = 1;
 	} else if (!strcmp(arg, "--graph")) {
-		revs->topo_order = 1;
-		revs->rewrite_parents = 1;
-		revs->graph = graph_init(revs);
+		if (!revs->graph) {
+			revs->topo_order = 1;
+			revs->rewrite_parents = 1;
+			revs->graph = graph_init(revs);
+		}
 	} else if (!strcmp(arg, "--encode-email-headers")) {
 		revs->encode_email_headers = 1;
 	} else if (!strcmp(arg, "--no-encode-email-headers")) {
-- 
2.32.0.2645.gc109162a1f

