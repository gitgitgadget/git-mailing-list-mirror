Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F592203E2
	for <e@80x24.org>; Thu, 10 Nov 2016 20:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966136AbcKJUfm (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 15:35:42 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35902 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965621AbcKJUfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 15:35:16 -0500
Received: by mail-pf0-f173.google.com with SMTP id 189so152174754pfz.3
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 12:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R6XDdsox9pRtc3Nw4Mp2PrHchHmoP6VTI7MOizxTC2c=;
        b=lTy+PLAHRfGhLqvKnKrobyxRL8HYu4TctfDYz+yckSzJ2pNIIz7UtN42ZCkREzvMuA
         d3wIVIsCAdzWm2+H63obxTOs290n1zDsxqXs7IiSQeJENS6pWuHUFvQ98kTy/GyiYqZL
         hyNyJwKe/3V9SRNVSSbiPMcQX+S3v+GCaZsx//91ry9uLwi06oTU/N5YBPFGrcYejZyD
         p/duazfKUiNK0/HI6FCeaDQOANFhhFEGDK4jb8C3arjDrF7Cmuf+/WJ1MH9nK/iRVg/D
         F3N+7ocP+TIf70QXBuIke3zTKM+q3UNc0AkLpXFP7ZAeuQAxWTFgzf66/d0M4c40sNCx
         HsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R6XDdsox9pRtc3Nw4Mp2PrHchHmoP6VTI7MOizxTC2c=;
        b=Xmj9f4VaiIZD8UT7yqlMCGAzijBtEgvmVN2tFurga1ERcUo/mqU6M3jygtEKGLKSSG
         ztE2LBKa593XAv2GoEgPh3RIUYtWuqmQxhJyu/i4ckQXtUpBuwL7aih30CtYj6XseMcR
         +vZ749XNe5ai1BC/E34taL2o+SrGeohbFnPQr6Dp0EaYra5yZxhXsWVgHlRZ7eAn+ay+
         eef+j5vi65RKsoh5YrXBgOM+ENr+4aJetEhSbzsNbbNJZidnnFt3aQ/QLA562UX9YIvI
         EBDU+riBqh2MDGgheJ2x76PO2HC8lF0DgBNPBwmMXbOdryEMnnAT63tGhykpDg0S+PaM
         zMZQ==
X-Gm-Message-State: ABUngveezfzl4StsbHNOnkqWbCIr9Bxhj8F6Eb43QfJmrccOX4vb82ZHFyPRuTBRHtfB1vak
X-Received: by 10.99.55.30 with SMTP id e30mr38565823pga.75.1478810115583;
        Thu, 10 Nov 2016 12:35:15 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b504:dcf8:965a:7ab8])
        by smtp.gmail.com with ESMTPSA id r1sm9294477pfg.56.2016.11.10.12.35.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 12:35:15 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com, pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 30/35] pathspec: move prefix check out of the inner loop
Date:   Thu, 10 Nov 2016 12:34:23 -0800
Message-Id: <20161110203428.30512-31-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161110203428.30512-1-sbeller@google.com>
References: <20161110203428.30512-1-sbeller@google.com>
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
index 67678fc..d44f8e7 100644
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
2.10.1.469.g00a8914

