Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 670102035F
	for <e@80x24.org>; Fri, 28 Oct 2016 18:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034417AbcJ1S5H (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:57:07 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35312 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966286AbcJ1Szu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:55:50 -0400
Received: by mail-pf0-f174.google.com with SMTP id s8so41509995pfj.2
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 11:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8LEfN828tHdiW1xrIWjsp6iJE+4yfqFoIhsX3n35uOo=;
        b=LLslz3BfszCbF+HoGtQcqgAHIvSPv8btRkw0vss9QzPpTDa3bt87OCCvluOmiuMk6w
         PNG+0/qXPHKOXHSAVuXBwCRP54QywSRzU0bf5WYypW/Fp5yKgy33fbbCLOXdBxenMNW2
         shtQcu6MiIIrRCf3KEHpI+hEV8nV1H1r8MsgZjQs5woiGBQlj98gDqJ2qbb9NplldQO/
         JY3MtEAEF3k9ySvbjcFJMf1JL8Y7xJySzd7N6AEVAzP0FnC5/PrWjpDCO4/qjA8c3Gzb
         uMwq+vTc3+6AE5orZiIxtGaGiD8c9DZNTo2FtkoYARmO1fFXAUicXYw1cBzVBpIyGC0d
         xlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8LEfN828tHdiW1xrIWjsp6iJE+4yfqFoIhsX3n35uOo=;
        b=NXaTwxN+l4LzW2HpzhxmH1nUdRqIWVE0z+NXCEcpQoEIFkIRZFCTis+jj4tw0+MBfz
         MfeAi1dD6nVDIWCs4urKSfJkfkM7t/T6Wy7DkCWQYYKzJZAAo8gQKiHkI7Qsr5XRaQhx
         lR/9EgkssB0od1OKR/BolrxRIayKuvf5Gosk5Y9066NqM4ixV4mpTle3kmZpTiMI8dtl
         s4ip2GCxVTFInQKU/cj2tKPHR3487mGuAVS4ufxOg6Cuce7L2RGHunFnhG7OYGD5SQem
         0Vm5Cowe4Hsp6tFjzyMsr5q6V4FdLtGHOYGOpBNFrBSNHNadoPLuRe2A4/WnAfMP+Vr0
         TfpA==
X-Gm-Message-State: ABUngvfI/Us4fJ1m3zzGEs0EcM58vr1wNqSlRAzl/3vl2i2d7IhoW85DbHpHsHgA0zY8TugC
X-Received: by 10.98.77.1 with SMTP id a1mr27527391pfb.160.1477680949982;
        Fri, 28 Oct 2016 11:55:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:91ed:bb99:5319:17e9])
        by smtp.gmail.com with ESMTPSA id uh10sm20633419pab.5.2016.10.28.11.55.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 11:55:49 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 16/36] attr: add counted string version of git_attr()
Date:   Fri, 28 Oct 2016 11:54:42 -0700
Message-Id: <20161028185502.8789-17-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.714.ge3da0db
In-Reply-To: <20161028185502.8789-1-sbeller@google.com>
References: <20161028185502.8789-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Often a potential caller has <name, namelen> pair that
represents the name it wants to create an attribute out of.

When name[namelen] is not NUL, the caller has to xmemdupz()
only to call git_attr().

Add git_attr_counted() that takes such a counted string instead of
"const char *name".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 8 ++++----
 attr.h | 5 ++++-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/attr.c b/attr.c
index dc9d61b411..7058e1c9fa 100644
--- a/attr.c
+++ b/attr.c
@@ -78,7 +78,7 @@ static int invalid_attr_name(const char *name, int namelen)
 	return 0;
 }
 
-static struct git_attr *git_attr_internal(const char *name, int len)
+struct git_attr *git_attr_counted(const char *name, size_t len)
 {
 	unsigned hval = hash_name(name, len);
 	unsigned pos = hval % HASHSIZE;
@@ -109,7 +109,7 @@ static struct git_attr *git_attr_internal(const char *name, int len)
 
 struct git_attr *git_attr(const char *name)
 {
-	return git_attr_internal(name, strlen(name));
+	return git_attr_counted(name, strlen(name));
 }
 
 /* What does a matched pattern decide? */
@@ -199,7 +199,7 @@ static const char *parse_attr(const char *src, int lineno, const char *cp,
 		else {
 			e->setto = xmemdupz(equals + 1, ep - equals - 1);
 		}
-		e->attr = git_attr_internal(cp, len);
+		e->attr = git_attr_counted(cp, len);
 	}
 	return ep + strspn(ep, blank);
 }
@@ -254,7 +254,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 		      sizeof(struct attr_state) * num_attr +
 		      (is_macro ? 0 : namelen + 1));
 	if (is_macro) {
-		res->u.attr = git_attr_internal(name, namelen);
+		res->u.attr = git_attr_counted(name, namelen);
 		res->u.attr->maybe_macro = 1;
 	} else {
 		char *p = (char *)&(res->state[num_attr]);
diff --git a/attr.h b/attr.h
index c84f164b8e..bcedf928b5 100644
--- a/attr.h
+++ b/attr.h
@@ -8,7 +8,10 @@ struct git_attr;
  * Given a string, return the gitattribute object that
  * corresponds to it.
  */
-struct git_attr *git_attr(const char *);
+extern struct git_attr *git_attr(const char *);
+
+/* The same, but with counted string */
+extern struct git_attr *git_attr_counted(const char *, size_t);
 
 /* Internal use */
 extern const char git_attr__true[];
-- 
2.10.1.714.ge3da0db

