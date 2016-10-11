Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8813D2098A
	for <e@80x24.org>; Tue, 11 Oct 2016 00:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752865AbcJKAWH (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 20:22:07 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35535 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752845AbcJKAWD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 20:22:03 -0400
Received: by mail-pa0-f45.google.com with SMTP id qn10so3908893pac.2
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 17:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FJlJhg+cfTZHI8wDV57gYGCk4FYDYp6ZBjZVprn6Tz4=;
        b=i9Js1F/CYKZu960S/RruUmp2hh7cZhTRsQTxAv+W5j6HpdeS8WoqisE9om3l6xsDLd
         PMbOsgxHcsBQVU6tQKiydgpsAwY2L78EYP2H5vPTiFpuaHxX2KMHBxlygcGi89okbkj2
         0PKaIbtEalS7+rbStpiDbeAD6JtzDhZOgyJ7kYWBTJcCs4ZhrOmqRAqWtPO5+xLP5TC0
         4+V2qP6mUTX8NQOL4XImFAmSmUlmA1UomCJLAq5kqGzUuld7y7JtuKh3minQNP8C4q8b
         1LYhpfF/UTCS9Agqn3fjGaLb0qEdTLMFOW+VaZaxQMyPvhpLEJv4Qr2MjHjCT7sCur7E
         l7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FJlJhg+cfTZHI8wDV57gYGCk4FYDYp6ZBjZVprn6Tz4=;
        b=dSI+iwkAvUcL+XtrvqATJIfoD06N3dBPQkvWg7Nxw4U51Wd8UR/2GLvtSimaCDCdfy
         VTEQldHnWMR3f14YwuNBvnXBThoFeg4gl1UmXg7Nz0w/DpIR0Uamj8yfBM4Myua2IfNM
         OpYmUr0KUxJq0EP3nsEtmgDF3KlhcNgqoaFbF1BlUi9e+V6N0Cy36YKNqmy7Gk4oFPKB
         /CPHxsay4eIlv2A38j1KJlK735JRim91A75GxP/0lILItYMHy9qK+Yr74U2dPA2WH8TL
         2GShoHB6lRbr3eftEKc5gnEWrLKA1AwaNUvK43OEPucy+DqvSeygqflN2aBS9uP4WllH
         FtXg==
X-Gm-Message-State: AA6/9RkTXxDnzaEu+ZoK+DpOEArtnJr58NYAVaYOwwy7sTJAlMYO5uteywu64TEWSmRE1eFV
X-Received: by 10.66.131.104 with SMTP id ol8mr1700353pab.198.1476145322173;
        Mon, 10 Oct 2016 17:22:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b8ee:61f5:e989:77a7])
        by smtp.gmail.com with ESMTPSA id a78sm521426pfj.44.2016.10.10.17.22.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Oct 2016 17:22:01 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 22/28] attr.c: correct ugly hack for git_all_attrs()
Date:   Mon, 10 Oct 2016 17:21:09 -0700
Message-Id: <20161011002115.23312-23-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.382.ga23ca1b.dirty
In-Reply-To: <20161011002115.23312-1-sbeller@google.com>
References: <20161011002115.23312-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

The collect_some_attrs() function has an ugly hack since

06a604e6 (attr: avoid heavy work when we know the specified attr is
not defined, 2014-12-28) added an optimization that relies on the
fact that the caller knows what attributes it is interested in, so
that we can leave once we know the final answer for all the
attributes the caller asked.

git_all_attrs() that asks "what attributes are on this path?"
however does not know what attributes it is interested in, other
than the vague "we are interested in all of them", which is not a
very useful thing to say.  As a way to disable this optimization
for this caller, the said commit added a code to skip it when
the caller passes a NULL for the check structure.

However, it skipped the optimization not when check is NULL, but
when the number of attributes being checked is 0, which is
unnecessarily pessimistic.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/attr.c b/attr.c
index abf23d8..8d8df20 100644
--- a/attr.c
+++ b/attr.c
@@ -748,8 +748,8 @@ static int attr_check_is_dynamic(const struct git_attr_check *check)
 
 /*
  * Collect attributes for path into the array pointed to by
- * check_all_attr. If num is non-zero, only attributes in check[] are
- * collected. Otherwise all attributes are collected.
+ * check_all_attr.  If check is not NULL, only attributes in
+ * check[] are collected. Otherwise all attributes are collected.
  */
 static void collect_some_attrs(const char *path, int pathlen,
 			       struct git_attr_check *check)
@@ -759,17 +759,6 @@ static void collect_some_attrs(const char *path, int pathlen,
 	int i, rem, dirlen;
 	const char *cp, *last_slash = NULL;
 	int basename_offset;
-	int num;
-	struct git_attr_check_elem *celem;
-
-	if (!check) {
-		/* Yuck - ugly git_all_attrs() hack! */
-		celem = NULL;
-		num = 0;
-	} else {
-		celem = check->check;
-		num = check->check_nr;
-	}
 
 	for (cp = path; cp < path + pathlen; cp++) {
 		if (*cp == '/' && cp[1])
@@ -786,9 +775,12 @@ static void collect_some_attrs(const char *path, int pathlen,
 	prepare_attr_stack(path, dirlen);
 	for (i = 0; i < attr_nr; i++)
 		check_all_attr[i].value = ATTR__UNKNOWN;
-	if (num && !cannot_trust_maybe_real) {
+
+	if (check && !cannot_trust_maybe_real) {
+		struct git_attr_check_elem *celem = check->check;
+
 		rem = 0;
-		for (i = 0; i < num; i++) {
+		for (i = 0; i < check->check_nr; i++) {
 			if (!celem[i].attr->maybe_real) {
 				struct git_attr_check_elem *c;
 				c = check_all_attr + celem[i].attr->attr_nr;
@@ -796,7 +788,7 @@ static void collect_some_attrs(const char *path, int pathlen,
 				rem++;
 			}
 		}
-		if (rem == num)
+		if (rem == check->check_nr)
 			return;
 	}
 
-- 
2.10.1.382.ga23ca1b.dirty

