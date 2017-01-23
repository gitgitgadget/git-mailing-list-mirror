Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C07320A17
	for <e@80x24.org>; Mon, 23 Jan 2017 20:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751720AbdAWUgm (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 15:36:42 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36533 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751513AbdAWUft (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 15:35:49 -0500
Received: by mail-pg0-f41.google.com with SMTP id t6so47711897pgt.3
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 12:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tt7MhDHHSAVSwo2c2rHrpsjiQ0AGGMCrUS9IV5aRSKw=;
        b=et9DwscWOpysPc6kHa3EIdRrZBw96IgAcY63kDPD+pKBuIyYO95KG0zfB/kdRyV7bb
         mialiIp+bkRfoKTFOW/0zhUcCQwHB4ZsSTdJ0Nfbl9PnFkuS9A8AcaHLnu8U4CDWZLcG
         sBxe7F1dO70BFkBYLIj729snhtzy7wDYthuMl5w4GWJKhokGkACX8iobRBlhl4t58uM1
         U6r+NTatbhv+EM8mFs/b+/ozKImVqn98s3dE0llb7alBNWkkaFR2/MG5fvcwtUm3oo7D
         C6DhVRwYkmebbpbFykJkKs8TScRU9pDHLXb0SU1F3Sm+DV++ZKifk2DQyiTLUl1OYchF
         9eKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tt7MhDHHSAVSwo2c2rHrpsjiQ0AGGMCrUS9IV5aRSKw=;
        b=i1Ssw5+r6xnwYAxPYUSF524Ur5E0uZpcmBtl/fQaHsIgXv4f+OyEOEUfIz6Ujaq7Xn
         NH6C9YArMYK8UI/TnbXTqfTjrYdQzHQUDNuK8PmLFIyWUwy0XR7YXDCdoI9UStEu77ci
         98itBRvp2xLM/3SHC9S1BDLb3JWIQWYcxeNl/taX9iXKgiUzPYOlI4oyh4XunAXlnD7a
         xSxIjJz5SEDaxtivzKy8JWtiRDjJcH9ZcgSgXTdX2mDYgUTNPBLr7BQbs/9PbPloIdK9
         Tka0tKRon1C9H/7HYIeYKxbv+coKJGkDUbVr3vjner+7sYOWbRXBODOX2uxSAlL2x7Xy
         KMAQ==
X-Gm-Message-State: AIkVDXIFbkh5d0ogQvs+p/lfKF8RjKwFInZ/8a7uwEzBHD4aq8IJjdsxBK6FGjgqlUw0aJxR
X-Received: by 10.84.241.129 with SMTP id b1mr46196131pll.135.1485203748748;
        Mon, 23 Jan 2017 12:35:48 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id z29sm39280832pgc.7.2017.01.23.12.35.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jan 2017 12:35:47 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 08/27] attr.c: tighten constness around "git_attr" structure
Date:   Mon, 23 Jan 2017 12:35:06 -0800
Message-Id: <20170123203525.185058-9-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170123203525.185058-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
 <20170123203525.185058-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

It holds an interned string, and git_attr_name() is a way to peek
into it.  Make sure the involved pointer types are pointer-to-const.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 2 +-
 attr.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/attr.c b/attr.c
index e42f931b3..f7cf7ae30 100644
--- a/attr.c
+++ b/attr.c
@@ -43,7 +43,7 @@ static int cannot_trust_maybe_real;
 static struct git_attr_check *check_all_attr;
 static struct git_attr *(git_attr_hash[HASHSIZE]);
 
-char *git_attr_name(struct git_attr *attr)
+const char *git_attr_name(const struct git_attr *attr)
 {
 	return attr->name;
 }
diff --git a/attr.h b/attr.h
index 8b08d33af..00d7a662c 100644
--- a/attr.h
+++ b/attr.h
@@ -25,7 +25,7 @@ extern const char git_attr__false[];
  * Unset one is returned as NULL.
  */
 struct git_attr_check {
-	struct git_attr *attr;
+	const struct git_attr *attr;
 	const char *value;
 };
 
@@ -34,7 +34,7 @@ struct git_attr_check {
  * return value is a pointer to a null-delimited string that is part
  * of the internal data structure; it should not be modified or freed.
  */
-char *git_attr_name(struct git_attr *);
+extern const char *git_attr_name(const struct git_attr *);
 
 int git_check_attr(const char *path, int, struct git_attr_check *);
 
-- 
2.11.0.483.g087da7b7c-goog

