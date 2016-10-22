Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11BC020986
	for <e@80x24.org>; Sat, 22 Oct 2016 23:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935471AbcJVXcw (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 19:32:52 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:35422 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935144AbcJVXcu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 19:32:50 -0400
Received: by mail-it0-f43.google.com with SMTP id 198so53149581itw.0
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 16:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UOh3r59Lq8Hnz4z0CSLGP+AW51c6Rza89WokyQaYLRw=;
        b=KgQ1Xbmi/Wufv3t04r4uglTAscqFi1fRwyRru0uc3M6Kv5N3xzA+uj0hWPgQqkCP+y
         7CaOieP95aTdn2JiJqmg02WFw4QTMTXVY8jXnrhANggZy31CbWgyUuI/8ricNZmb5saP
         UpY5yL+ZkiyYDsbXgFTLbJiR8h1DTeh2AthdMiO0cidpo1cmuU/iKqt7VqaPA4W1xLrC
         OIqYFkheON7HtTJibUy390lJvR27+Mwa2g+3LdJDmfInGMufu+9pQ4Gk9S8dIWOD3m7s
         uuYwQw4h3kq3hKifqSA4erYJ2nYjjd9JiEii63m2AP0GLhOTrB1l22DDwpRq68Vu0AmG
         jjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UOh3r59Lq8Hnz4z0CSLGP+AW51c6Rza89WokyQaYLRw=;
        b=lLnfpvj1IRpYTX75MYKAztUdBN7RY3sx0u0rZg62IczheEXdh8x2aL+OCaOwD02igc
         q/m+ozxXQJQZsV5N9F9uqDpvNDfz0a5DYeHUtfud+3gNkQxFoJcaPzO2iO+chWp9R5tv
         JvG2pLTUNfW8Nxnd6LSMMlLnhvzJr6LtdtaLg8UKl9UYjJ5rz+UuybXYSpVIq7sTKOba
         bk9H9UGVTer/QUSYQFA/iHxrkReooRR0sa1BUCz2PJ+MLni2o1AUJaMOJimqQylMPr00
         TGdH3TYENWWlwqpSV5wKyjJE9TPMqYcDS57DVv9Hb+bOg3tuW/ujdW2BE4m7eYX3RLzM
         LHoQ==
X-Gm-Message-State: ABUngvdirORjhE3jaAn+1JjS0SA9A6h45RgeeVgDhqJ4++7eFwNl/1SssWaCpldavOTgPmLA
X-Received: by 10.107.141.197 with SMTP id p188mr8413059iod.37.1477179169077;
        Sat, 22 Oct 2016 16:32:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4ca0:b1d9:cc22:1c7b])
        by smtp.gmail.com with ESMTPSA id v69sm1987193itc.1.2016.10.22.16.32.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 22 Oct 2016 16:32:48 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 09/36] attr.c: plug small leak in parse_attr_line()
Date:   Sat, 22 Oct 2016 16:31:58 -0700
Message-Id: <20161022233225.8883-10-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.508.g6572022
In-Reply-To: <20161022233225.8883-1-sbeller@google.com>
References: <20161022233225.8883-1-sbeller@google.com>
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
2.10.1.508.g6572022

