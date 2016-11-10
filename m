Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 105D02075A
	for <e@80x24.org>; Thu, 10 Nov 2016 20:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965624AbcKJUfN (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 15:35:13 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34014 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965251AbcKJUfC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 15:35:02 -0500
Received: by mail-pf0-f181.google.com with SMTP id n85so151866058pfi.1
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 12:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q8DLFMUs7k+vTYJi5mzZDqZ+mEWAEd5Y3Vnyj3NURfk=;
        b=evFLoxT7CJeYO56Rq+Ihji85/18HMsqkNAZuAePdTJaWqRcOovmJojBw0f6IK/Cdj9
         s2K73mqQhEYeX48AN6+bAv8+ZC/mpIRi/0kUmcx3ZkBrvyps2RDP6s93ppmOB0AL7le7
         Tf+l9BEhK8uqQ5ScxN6po4/V5+HZL/nE4OCRl6LT1Ll05tQ1FaaM+uVsWAsWt98ZkMyC
         CJf5tkoJemSx+LYHM/I2jH9gljwRiQ39ZuOst3l5MqnE0QSjKH1bmJgjHJpIKGHbd01Z
         ZVbvOfpRilmSyAMcrpumZiYEkdCuXq7OeqbQUF7X5JIP3erwmr+pdtzBqZSZ/SQp3/7o
         uobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q8DLFMUs7k+vTYJi5mzZDqZ+mEWAEd5Y3Vnyj3NURfk=;
        b=Tc8+cZUo23Cz/GUza00NVoJbryhrI48gqAbxZgBsYfXBQ5LaMeU+13Ap2RFvQL71rm
         ArDx4rxHl5JCY0muSEYQUzYLUCPOVXYoJcM86EoXzTmfqSs+5NXmx6eVTmsMf8t17uU/
         Q5gC/HqSUKHFdSwQPOaa7t761AFAR5cWbvzO7+68eUo/oiIFdJvN6bjGhuMJqIzB5/Gr
         EZy7/Rrcy0leFMv75aQn9Nx/FzSXjKdOn/eSzuZ28rYfZujcbpYbZqxNxKFBZcuFnENN
         Dbe/xeqBFkWE6O+yh87Eue42R4cJg7X/Fr7y6ZNgIRBbptj7jQib3d6fnCp9dXKWaBkZ
         W5Yg==
X-Gm-Message-State: ABUngvfjOx7HhFePFLCA8//ea7b7uESKlS9B5yInp/JTjBbHA9tpAMngZvsBpt2I7bB12KIT
X-Received: by 10.99.63.135 with SMTP id m129mr26743108pga.16.1478810101167;
        Thu, 10 Nov 2016 12:35:01 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b504:dcf8:965a:7ab8])
        by smtp.gmail.com with ESMTPSA id z3sm9284980paw.48.2016.11.10.12.35.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 12:35:00 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com, pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 19/35] attr.c: pass struct git_attr_check down the callchain
Date:   Thu, 10 Nov 2016 12:34:12 -0800
Message-Id: <20161110203428.30512-20-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161110203428.30512-1-sbeller@google.com>
References: <20161110203428.30512-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

The callchain that starts from git_check_attrs() down to
collect_some_attrs() used to take an array of git_attr_check_elem
as their parameters.  Pass the enclosing git_attr_check instance
instead, so that they will have access to new fields we will add to
the data structure.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/attr.c b/attr.c
index a504cb3..219ab11 100644
--- a/attr.c
+++ b/attr.c
@@ -751,14 +751,25 @@ static int attr_check_is_dynamic(const struct git_attr_check *check)
  * check_all_attr. If num is non-zero, only attributes in check[] are
  * collected. Otherwise all attributes are collected.
  */
-static void collect_some_attrs(const char *path, int pathlen, int num,
-			       struct git_attr_check_elem *check)
+static void collect_some_attrs(const char *path, int pathlen,
+			       struct git_attr_check *check)
 
 {
 	struct attr_stack *stk;
 	int i, rem, dirlen;
 	const char *cp, *last_slash = NULL;
 	int basename_offset;
+	int num;
+	struct git_attr_check_elem *celem;
+
+	if (!check) {
+		/* Yuck - ugly git_all_attrs() hack! */
+		celem = NULL;
+		num = 0;
+	} else {
+		celem = check->check;
+		num = check->check_nr;
+	}
 
 	for (cp = path; cp < path + pathlen; cp++) {
 		if (*cp == '/' && cp[1])
@@ -778,9 +789,9 @@ static void collect_some_attrs(const char *path, int pathlen, int num,
 	if (num && !cannot_trust_maybe_real) {
 		rem = 0;
 		for (i = 0; i < num; i++) {
-			if (!check[i].attr->maybe_real) {
+			if (!celem[i].attr->maybe_real) {
 				struct git_attr_check_elem *c;
-				c = check_all_attr + check[i].attr->attr_nr;
+				c = check_all_attr + celem[i].attr->attr_nr;
 				c->value = ATTR__UNSET;
 				rem++;
 			}
@@ -794,18 +805,19 @@ static void collect_some_attrs(const char *path, int pathlen, int num,
 		rem = fill(path, pathlen, basename_offset, stk, rem);
 }
 
-static int git_check_attrs(const char *path, int pathlen, int num,
-			   struct git_attr_check_elem *check)
+static int git_check_attrs(const char *path, int pathlen,
+			   struct git_attr_check *check)
 {
 	int i;
+	struct git_attr_check_elem *celem = check->check;
 
-	collect_some_attrs(path, pathlen, num, check);
+	collect_some_attrs(path, pathlen, check);
 
-	for (i = 0; i < num; i++) {
-		const char *value = check_all_attr[check[i].attr->attr_nr].value;
+	for (i = 0; i < check->check_nr; i++) {
+		const char *value = check_all_attr[celem[i].attr->attr_nr].value;
 		if (value == ATTR__UNKNOWN)
 			value = ATTR__UNSET;
-		check[i].value = value;
+		celem[i].value = value;
 	}
 
 	return 0;
@@ -816,7 +828,7 @@ void git_all_attrs(const char *path, struct git_attr_check *check)
 	int i;
 
 	git_attr_check_clear(check);
-	collect_some_attrs(path, strlen(path), 0, NULL);
+	collect_some_attrs(path, strlen(path), NULL);
 
 	for (i = 0; i < attr_nr; i++) {
 		const char *name = check_all_attr[i].attr->name;
@@ -845,7 +857,7 @@ int git_check_attr_counted(const char *path, int pathlen,
 			   struct git_attr_check *check)
 {
 	check->finalized = 1;
-	return git_check_attrs(path, pathlen, check->check_nr, check->check);
+	return git_check_attrs(path, pathlen, check);
 }
 
 int git_check_attr(const char *path, struct git_attr_check *check)
-- 
2.10.1.469.g00a8914

