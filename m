Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF1E620986
	for <e@80x24.org>; Sat, 22 Oct 2016 23:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965069AbcJVXdX (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 19:33:23 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:36078 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964974AbcJVXdP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 19:33:15 -0400
Received: by mail-it0-f44.google.com with SMTP id e187so74375465itc.1
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 16:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JMSNWkD99bbru6hFiThypm5T7eV1kOfaE0PwRu7ftYw=;
        b=UrzYY78bYlm2hlEhqXQIBd2jRh8FSnX4Wo5OZr5yZK8aK08cCTy5sZiP24bo4Q0F/a
         hTfCHlpgJe7rkJWbAfReS7uay5Z5HL9T1FQWP7hFsVON/0f4L1sxzIm9oxNW9jYLuDgQ
         mQ7MXml8tu2PXml9+2D+6GF8xGvfVnVRdaFrUa/NRrWIqErmrYK8hIzHRmOlqklNSq9X
         Li3RE9XF9QPdgVjIJN9JgXqdzqpKOXtoFMRdLpC21FjgMsAhI+c2sv/9Iq4jqncMffFn
         VAU9ZqrT7sF7NJQYAWyX5/ITf6qQ4es+lCcYQwC94hGe8IRIigWZHNvuG/SysuxImvvJ
         Y7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JMSNWkD99bbru6hFiThypm5T7eV1kOfaE0PwRu7ftYw=;
        b=PbOLBPJar8vVnYzwksZD3GlPyNRM0QZKVXN8YhuJcRd6cETCT42ghE0WBz6WlZWvSC
         IyMPSr5/pezrra7Bje3xvMfzhEQjmf8UQMdQvDC0VtORpDSuzHbsv8HD9fPuqNgeo7x8
         EQyE+2378gYz6zgzT3iJj75xrSGLe9LYQvru6leRKPzhYqwLZa15jj5n2cd9fh6DlMHJ
         JmZ8cYYyV0O1u/IYqQsMIYAyUttCUrV/Qka4L+mZ4JsbNTSbq1ZamU4jhTl9hWJrVBVa
         se3xbfrkFuE6kZo6ajFDuGk9Ein0CrPsr3CHeAaGOjuudWE+aYuZPpAXsgnCwIGrRPUQ
         KCdA==
X-Gm-Message-State: ABUngvelKFWnyecGBzTad+bNT6T46lp/Dd7D0PhJsbSYadoz8nUQJVqga96ZOSNWOc+NRF+5
X-Received: by 10.107.137.215 with SMTP id t84mr7452063ioi.61.1477179194214;
        Sat, 22 Oct 2016 16:33:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4ca0:b1d9:cc22:1c7b])
        by smtp.gmail.com with ESMTPSA id 80sm4549661iot.36.2016.10.22.16.33.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 22 Oct 2016 16:33:13 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 22/36] attr.c: correct ugly hack for git_all_attrs()
Date:   Sat, 22 Oct 2016 16:32:11 -0700
Message-Id: <20161022233225.8883-23-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.508.g6572022
In-Reply-To: <20161022233225.8883-1-sbeller@google.com>
References: <20161022233225.8883-1-sbeller@google.com>
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
index 7869277..2d13441 100644
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
2.10.1.508.g6572022

