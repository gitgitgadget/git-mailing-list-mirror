Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B52E2035F
	for <e@80x24.org>; Fri, 28 Oct 2016 18:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034392AbcJ1S4q (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:56:46 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34505 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034320AbcJ1S4X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:56:23 -0400
Received: by mail-pf0-f169.google.com with SMTP id n85so41597302pfi.1
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 11:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R4EfgdWYGdlbj7bc3Sp13M2M75YOsAVR/H/HjyOY7Sw=;
        b=B/t+0PYMWluksdcLirKmtsUtOhgxtGya/IFBPRCZTV8WTuZtP+TX8BsSS4tmhhd7sY
         hk1eo7h8NETw3pwF/6EugonSOQ1+eiGtKd0Z/a20IjPLJKDY/q0QZ+uxTN/Wn+CTMmNi
         +R9CZfoE3l4uW30t4kEn8ax0BVQxpdriMGcFQy7Mc7p/K/dNohZirnITskXGVYDXXK4R
         LOqR5InzqcbW5CPO/4pkFnSsv5FblMOhxz1P4RCjmqc1DNSi4WzCFVY2OnjXBEaMm1pX
         YVNA+4iPQTPREgfOEfXqjAKNopPerS9P1KqBkwsCiPadh4wnotmNqVjWvnEqAT1aZdqv
         d7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R4EfgdWYGdlbj7bc3Sp13M2M75YOsAVR/H/HjyOY7Sw=;
        b=YYxui2+QhQx8j0o6Oed0cihf6xyjZ/yXimoX1ZPwDLDlty14yE5klNmcNjPZ8ySL2S
         2vJt7qMy4qcuP75em8A3pknUSidJUzOL1b3yST9DDUm6se1DcaqgaFJPC9glzHcE9+HZ
         DiPPoDZ+1yzFUYoVkIupw21BTYHUNxDS+9gWj1NTDjUwHpcWR0+Y/WtafILqODiuvWeF
         zM1/8dyKjsr4TyFmeklSay46Evp7B4k4qS5nx6EDNC/I2AHwjieuo6Pzm/XRkotR8z/J
         S5/wi5DG4xERDh9tCVXkd2nWsIJgSNe3O7PiXWZzkM7Uf8x81AYyaGJrVyc2jTqVmnhY
         Gbcg==
X-Gm-Message-State: ABUngveb5S1JFpPuphE46vdxNM+e4VyopFU89yrVdDscoVniCgHUhg4DSjkpIKGf6cMunrUO
X-Received: by 10.99.1.23 with SMTP id 23mr22760168pgb.37.1477680982258;
        Fri, 28 Oct 2016 11:56:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:91ed:bb99:5319:17e9])
        by smtp.gmail.com with ESMTPSA id v66sm16743067pfa.33.2016.10.28.11.56.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 11:56:21 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 31/36] pathspec: move prefix check out of the inner loop
Date:   Fri, 28 Oct 2016 11:54:57 -0700
Message-Id: <20161028185502.8789-32-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.714.ge3da0db
In-Reply-To: <20161028185502.8789-1-sbeller@google.com>
References: <20161028185502.8789-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The prefix check is not related the check of pathspec magic; also there
is no code that is relevant after we'd break the loop on a match for
"prefix:". So move the check before the loop and shortcircuit the outer
loop.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pathspec.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index ad13556c82..83b46c1910 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -107,21 +107,22 @@ static void eat_long_magic(struct pathspec_item *item, const char *elt,
 			nextat = copyfrom + len;
 		if (!len)
 			continue;
+
+		if (starts_with(copyfrom, "prefix:")) {
+			char *endptr;
+			*pathspec_prefix = strtol(copyfrom + 7,
+						  &endptr, 10);
+			if (endptr - copyfrom != len)
+				die(_("invalid parameter for pathspec magic 'prefix'"));
+			continue;
+		}
+
 		for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
 			if (strlen(pathspec_magic[i].name) == len &&
 			    !strncmp(pathspec_magic[i].name, copyfrom, len)) {
 				*magic |= pathspec_magic[i].bit;
 				break;
 			}
-			if (starts_with(copyfrom, "prefix:")) {
-				char *endptr;
-				*pathspec_prefix = strtol(copyfrom + 7,
-							  &endptr, 10);
-				if (endptr - copyfrom != len)
-					die(_("invalid parameter for pathspec magic 'prefix'"));
-				/* "i" would be wrong, but it does not matter */
-				break;
-			}
 		}
 		if (ARRAY_SIZE(pathspec_magic) <= i)
 			die(_("Invalid pathspec magic '%.*s' in '%s'"),
-- 
2.10.1.714.ge3da0db

