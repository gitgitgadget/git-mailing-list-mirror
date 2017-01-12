Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E4131FEB3
	for <e@80x24.org>; Fri, 13 Jan 2017 00:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751017AbdAMACT (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 19:02:19 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33807 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbdAMACS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 19:02:18 -0500
Received: by mail-pf0-f179.google.com with SMTP id 127so20503644pfg.1
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 16:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rsbMHFY1noU9jFoFtQzkaJ31lIycUh4tfTpxav3i3No=;
        b=iYqJMAMIMrnhg/Jqb2xQP9pNl4PYr+Kd3yDKTMnavFW+Wfc1Rd2nwjM/WkH5HBbUox
         O0kZV8vdWhtXu7n4TK26PqmFseoRG1gzpkT7RVIM6GLMhHd0zLH2LOoML+pPmN5JVRxr
         vS8oJJn4hAlpreFkgFQ9qGpalXNu8JPhdJeOy1NlzWjTVAmtVl28tNF9kz/RhDK4Xbhh
         hwtDbJrqsN8rTxd6J+ZPUrrj8SvviXzWx6HtkmOkrbnCcSj+DKIxE+xWHxc/zHoo5z3m
         g5ttJGHr/9tZrBcSj6qITBAqw032akTxJko59sy4Z/MjsgeaggVoHn5Hui0gjeuLawef
         fVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rsbMHFY1noU9jFoFtQzkaJ31lIycUh4tfTpxav3i3No=;
        b=Bg6rM3SAGX+SpbJQUvODmOu4AX4/Ylue1EmAEp0IhAFnV59JaUfRrp1/8srYkCzlvN
         bAZ3CcK4I10GESId0xiX+UD2L7zZq6/s61AQXrpSXlRtf5wWGotx/50aP0mUj0ZCNgVl
         4gohRZeuBh1NiVQxpp77BBO4yuS/Ma7gBENclETY9RP+67UvfoZLN8HKYBqFabFi5U4W
         znCnjd/OpktaNk5j4TbzdcJm30ZZ10skVn4a4UsHKOofTSxwi0C/rUxBm1Zxl2hJvn0F
         SNPcBGn9LTAvhonBZp1zuPOGkUWf3jI11eXl3Q9itOt44L32+dzq772RKdsQrOejxz8d
         zoWQ==
X-Gm-Message-State: AIkVDXKoDTjJ3RgzkXBGqnoIJsnbMsW5rxv1KE//UCRauOoyrTf42ZBLk5ApkYFV5GQ1nBsp
X-Received: by 10.84.236.2 with SMTP id q2mr25323325plk.148.1484265256055;
        Thu, 12 Jan 2017 15:54:16 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id e6sm24312192pgf.4.2017.01.12.15.54.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jan 2017 15:54:14 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, pclouds@gmail.com,
        sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 09/27] attr.c: plug small leak in parse_attr_line()
Date:   Thu, 12 Jan 2017 15:53:36 -0800
Message-Id: <20170112235354.153403-10-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170112235354.153403-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
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
2.11.0.390.gc69c2f50cf-goog

