Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F1262098A
	for <e@80x24.org>; Tue, 11 Oct 2016 00:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752731AbcJKAVk (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 20:21:40 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35884 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752690AbcJKAVj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 20:21:39 -0400
Received: by mail-pa0-f48.google.com with SMTP id ry6so3886908pac.3
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 17:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uU2lWcB6Hec/Mt5envtj7Pq9Ptcol8DkG3zY4sDmkBM=;
        b=KcGsH1sj4DjZpT+FcUH5M2CZ/GbmiSbfsBHW8pONHIfgTeoq6VFFX+w4co8/KVauxc
         EG9RSd8LZ8M7QaiuguM4MpqAQ1oLRKAeXN+6WFl8cavlhQ0bSHXoSs2wv71SKPZCkn5T
         hkJEnj42jsKq9t9JTr+5znaCDbO/+02fZbuhmAyHW5lFHgEDeTkt/rf1NxWuRbI3GYg3
         nSiKD/8lC7WH+n78tNra5Y+GdMtaWsh9mLPBxalT0O0740isXMc0OMracRkV9OHpeGbi
         udElh19i/T8gcO6R3bY0umzvDdBHgb08jSG9qGFdgU/9y7te1nCxyXgJTPdPHWUvtLrd
         Z9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uU2lWcB6Hec/Mt5envtj7Pq9Ptcol8DkG3zY4sDmkBM=;
        b=Ma2uHLEObNA9RwDVwG7j7jzXUBw4cGQVcNfm2fiA+kty7qbmPI9b8/lKGmysQLwENR
         42eifrRuR/cPAx7L5Dsh9NKH8DPbZB2IVxk4o8N3M9mqCmEXm2Za8zrzmDrZFaSLJRPm
         CjPhb+zI82BY2c098ImtB0jsMV8JrNfrLt9udNpa5ujPddLTvTHuz2wcBCl/nr9ylIAT
         v437yAA/8VWnRM0B7FoPzYudvnlq1tyFLxh6FI5s6KlsL1SLnx2EOqb3SLy/wIpJ8Nge
         g30Mdb7Glwq46tA/DUIUma85L+D5ilzLPb4ieDm3hPZjnTOOO9DHhBJapJbUBJYGaGlN
         RR6g==
X-Gm-Message-State: AA6/9RmjxOX2P1S9XhRvkPa3pjpdUSPvkbbJCABXjg133RLAaxBv81VV97Q6qoV8FsFNYagU
X-Received: by 10.66.245.98 with SMTP id xn2mr1706111pac.98.1476145298541;
        Mon, 10 Oct 2016 17:21:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b8ee:61f5:e989:77a7])
        by smtp.gmail.com with ESMTPSA id yi2sm525001pab.17.2016.10.10.17.21.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Oct 2016 17:21:38 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 09/28] attr.c: plug small leak in parse_attr_line()
Date:   Mon, 10 Oct 2016 17:20:56 -0700
Message-Id: <20161011002115.23312-10-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.382.ga23ca1b.dirty
In-Reply-To: <20161011002115.23312-1-sbeller@google.com>
References: <20161011002115.23312-1-sbeller@google.com>
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
2.10.1.382.ga23ca1b.dirty

