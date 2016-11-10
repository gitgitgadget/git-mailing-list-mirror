Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CA10203E2
	for <e@80x24.org>; Thu, 10 Nov 2016 20:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965048AbcKJUev (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 15:34:51 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35165 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935817AbcKJUer (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 15:34:47 -0500
Received: by mail-pf0-f171.google.com with SMTP id i88so151078724pfk.2
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 12:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D4VvNpwwMTJbg7w8eEzjXr4Z49jbcBDoY6oy2ErHMtA=;
        b=bXLddRTHAFGLysJyZG7/SMC7WfPSe/BxLpJNgvgqMhAi/2X6v3pf+tGmOGYlv+1/Md
         9QGCzx0bk0w5DNQD9OLSTzMlkStXRhpy0UKfC80Xbc4i+XEPTjCfPLjGZ0WKy7us+Sdj
         mcQSb+Kb0lQtCpjiKYZhQlP3p/g6yqIwvyhY0ZEGyFLWy9Enml/Z07KGNpMfObmqfmGM
         tDrGS2AeI36QMTlLi4Nc6eYEFZbTSsjWl8fFDCcgKRQwxQfy7Ln06fHRLOrKXDt/yO5M
         f4ydsW9uiBbcTVKPRq5XMomOCx4i7ysa0tTjGGJM6pOWjipbjhnSohzujFCH4D+2cT8K
         LXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D4VvNpwwMTJbg7w8eEzjXr4Z49jbcBDoY6oy2ErHMtA=;
        b=fV0X2doKExYUYyzSaWtCtRyPbR4CKLOauFlWJEoXgcTKuGzmTr1dBV+geA9kJBFPx8
         PRa61ijaio3NWQclK50IhU5OTUxCZ4M+safgIJGy+/aU2ifnTMCioAy24jbxA1K8r97c
         C2cvd9qsUK8iV3fAB5if2hBf/X7OKgbwPtxia5CroDJLy8DdNyajZWSKLtpNYpjxmplx
         0mm9ZCsVh0YrgfAslZGTl4DR7nLueTVU4oPzFwaLyJmmn/l5K4Rbj8ba4ET/EIxrwpuK
         hDDD2IW+P7EpBffVt1kkJtDAMuZuaZQJVV5EC2VWySCN1r2h9NhBXF4kJ5/M/a/BwUM1
         is5A==
X-Gm-Message-State: ABUngvc94/L/Q6LPXhv6YuyGoELloKCrtbolsx/cNn+4h66mFYwD3lk2xvuMsXHcd9OKpgfn
X-Received: by 10.99.142.201 with SMTP id k192mr26135691pge.174.1478810086653;
        Thu, 10 Nov 2016 12:34:46 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b504:dcf8:965a:7ab8])
        by smtp.gmail.com with ESMTPSA id d15sm9295568pfl.46.2016.11.10.12.34.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 12:34:46 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com, pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 09/35] attr.c: plug small leak in parse_attr_line()
Date:   Thu, 10 Nov 2016 12:34:02 -0800
Message-Id: <20161110203428.30512-10-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161110203428.30512-1-sbeller@google.com>
References: <20161110203428.30512-1-sbeller@google.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/attr.c b/attr.c
index 5c35d42..1877f7a 100644
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
2.10.1.469.g00a8914

