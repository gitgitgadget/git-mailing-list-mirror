Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 005741FAAD
	for <e@80x24.org>; Sat, 28 Jan 2017 02:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751199AbdA1CCy (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 21:02:54 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33202 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbdA1CCm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 21:02:42 -0500
Received: by mail-pg0-f41.google.com with SMTP id 204so85673812pge.0
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 18:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O+45k8H2jJuWldxUOQadee5jc/jqPN+P6kbHVofHOEY=;
        b=c0oiVRMEffXuzuS20NjMUyGkcVsRXcNJXOTlC8G64gx0aHcToPf97gqfxwtgxVjOcK
         A1PfpbUge+pMNnaCxg4JwtZvJIpqefqEtTrhMXXiVDiC479thBAlAfp6NgP3VcgtmNTJ
         2VzKkya7jnlkeABLqvSJS1iRQaTc2FPOwe1Pc/3FbOCudXYfn/J/ZBQmrFa+3BchzBse
         sF0MabGUK7d10BdxC70sF8SpfRdk7bUW3bZWVsif00kV0h38DWeVKJ3q62NwTomqNYv4
         t3UXvmhEQT6kYtcbxfPqXO8mXpEEK3LxmqGVCpy7Nta+nGWgUT9P8k/Z/FZGW9bjw7Dy
         uY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O+45k8H2jJuWldxUOQadee5jc/jqPN+P6kbHVofHOEY=;
        b=JcMYFiNsg9ypw6wbgD2utFMk6ANunC2Spic2xqjKOxpL6QTh0txZOhWENfjq3XGQ8i
         q18MWPzcDPGM0n05Yy85FzmSEBAK/YX7Co8lXGv312mCRocQxxdS4A17xqwGC1Rug35E
         L5i0lHcsAWtYUsK2Ra53imNyUF6pVpvPZX/Js7xqop7KW4JEBmKcA61jzoLayTnt2B2q
         SrLnvmEiC2/7wSjJNQ9XdW4OMZDm7QF6zkTy38Rmj9KdqwHgnVcR8nzmDGwLb6EBldTQ
         qk9Psf1JTAzuCqO1XpLrSCwlfxMXvLseJiDGWtjNQeKckA2afr8ABLB04wSd+MTQBenG
         zA8Q==
X-Gm-Message-State: AIkVDXJuJWrfK6hnLETUC5mB48mlesgbaa4cUkzGhbexfUQEY1qpoafQDkcOCDciJR+uBsb8
X-Received: by 10.99.217.85 with SMTP id e21mr12769562pgj.79.1485568961800;
        Fri, 27 Jan 2017 18:02:41 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id w76sm14136185pfd.74.2017.01.27.18.02.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jan 2017 18:02:40 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 09/27] attr.c: plug small leak in parse_attr_line()
Date:   Fri, 27 Jan 2017 18:01:49 -0800
Message-Id: <20170128020207.179015-10-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170128020207.179015-1-bmwill@google.com>
References: <20170123203525.185058-1-bmwill@google.com>
 <20170128020207.179015-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

If any error is noticed after the match_attr structure is allocated,
we shouldn't just return NULL from this function.

Add a fail_return label that frees the allocated structure and
returns NULL, and consistently jump there when we want to return
NULL after cleaning up.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/attr.c b/attr.c
index f7cf7ae30..d180c7833 100644
--- a/attr.c
+++ b/attr.c
@@ -223,7 +223,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 		if (!macro_ok) {
 			fprintf(stderr, "%s not allowed: %s:%d\n",
 				name, src, lineno);
-			return NULL;
+			goto fail_return;
 		}
 		is_macro = 1;
 		name += strlen(ATTRIBUTE_MACRO_PREFIX);
@@ -233,7 +233,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 			fprintf(stderr,
 				"%.*s is not a valid attribute name: %s:%d\n",
 				namelen, name, src, lineno);
-			return NULL;
+			goto fail_return;
 		}
 	}
 	else
@@ -246,7 +246,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 	for (cp = states, num_attr = 0; *cp; num_attr++) {
 		cp = parse_attr(src, lineno, cp, NULL);
 		if (!cp)
-			return NULL;
+			goto fail_return;
 	}
 
 	res = xcalloc(1,
@@ -267,7 +267,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 		if (res->u.pat.flags & EXC_FLAG_NEGATIVE) {
 			warning(_("Negative patterns are ignored in git attributes\n"
 				  "Use '\\!' for literal leading exclamation."));
-			return NULL;
+			goto fail_return;
 		}
 	}
 	res->is_macro = is_macro;
@@ -283,6 +283,10 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 	}
 
 	return res;
+
+fail_return:
+	free(res);
+	return NULL;
 }
 
 /*
-- 
2.11.0.483.g087da7b7c-goog

