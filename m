Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50DCB2035F
	for <e@80x24.org>; Fri, 28 Oct 2016 18:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034422AbcJ1S5J (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:57:09 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33383 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966136AbcJ1Szt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:55:49 -0400
Received: by mail-pf0-f172.google.com with SMTP id 197so41756823pfu.0
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 11:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e8+1CABjODuMQuh5TQf7Q5d2RFMFr6ZOT0JwiT7hkF0=;
        b=lX3i2K1XYytj+xHJGq6dbSi2O2BZEde38dl6Oep2IdDivz1S0TOz9XSM7WbaIPykTR
         VyckqT4k+duTYjZQpMKXyHii1hq1YF6GajQPO5hkvQWw9UoDTqgc3JBuKuKyft21hjFE
         8u17xCCXJKnal/bSoIWv76uBhBCY5Ps+9XgbLk3oDqmKvL06qf8fl/2LsPIIEfgFsUc1
         ZqTaCuQ4k8fVfSEpKI5UY1CGC+2O9pM0zpdCi9on08kRqROWSQd+bSF5tpJiE0H/IuJp
         ltutpOwlH6pgM5mZGDv2Ncq1AGGBKGwPAvwJtPxu/XyaTnIjYuWW3gkKOEEPVN9Eif73
         3ZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e8+1CABjODuMQuh5TQf7Q5d2RFMFr6ZOT0JwiT7hkF0=;
        b=FrQyGFs24aheXXK7nYXhUwJ/J5MG9ERA4YQQDjm0Pb5vkYO1m8MYS6wPsQKy8y1y5b
         69YYvXzoRSo0X2jAADsi+uCWzEJVpKH9NWzzdJFxpgOnh8WRXmhCINmUEHgu9n8aFZ6v
         CBTAJNbqbmgQXIZH3YqsyzsHdc40vUw3X1+mJu/B9VZ9Hc8XS1tVZZaV6u7Q3sajCONS
         QxE19hu+GfNpMQSJxX/eL2FjT0q6rsAvDiKcWyC1lTWRlm07LUzOeoCqqyXIi3nOKkhC
         XJvcBqR1JMstRBR3vnLvh3XMr1jQOdy6CVxY9mSIAFzbz+TcSXNoB6IXbOQzB1Q3IuVR
         +VHg==
X-Gm-Message-State: ABUngvdOjh1UwGA4A382n7aoqFkcObwrnJ6NlBxjkmIZ36Uh0TiNpnG5DmyW1w3HBOrQxWER
X-Received: by 10.98.53.199 with SMTP id c190mr18295331pfa.63.1477680948254;
        Fri, 28 Oct 2016 11:55:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:91ed:bb99:5319:17e9])
        by smtp.gmail.com with ESMTPSA id g78sm20589366pfe.19.2016.10.28.11.55.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 11:55:47 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 15/36] attr: add counted string version of git_check_attr()
Date:   Fri, 28 Oct 2016 11:54:41 -0700
Message-Id: <20161028185502.8789-16-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.714.ge3da0db
In-Reply-To: <20161028185502.8789-1-sbeller@google.com>
References: <20161028185502.8789-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Often a potential caller has <path, pathlen> pair that
represents the path it wants to ask attributes for; when
path[pathlen] is not NUL, the caller has to xmemdupz()
only to call git_check_attr().

Add git_check_attr_counted() that takes such a counted
string instead of "const char *path".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 23 ++++++++++++++---------
 attr.h |  1 +
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/attr.c b/attr.c
index 30953c905b..dc9d61b411 100644
--- a/attr.c
+++ b/attr.c
@@ -738,20 +738,19 @@ static int attr_check_is_dynamic(const struct git_attr_check *check)
  * check_all_attr. If num is non-zero, only attributes in check[] are
  * collected. Otherwise all attributes are collected.
  */
-static void collect_some_attrs(const char *path, int num,
+static void collect_some_attrs(const char *path, int pathlen, int num,
 			       struct git_attr_check_elem *check)
 
 {
 	struct attr_stack *stk;
-	int i, pathlen, rem, dirlen;
+	int i, rem, dirlen;
 	const char *cp, *last_slash = NULL;
 	int basename_offset;
 
-	for (cp = path; *cp; cp++) {
+	for (cp = path; cp < path + pathlen; cp++) {
 		if (*cp == '/' && cp[1])
 			last_slash = cp;
 	}
-	pathlen = cp - path;
 	if (last_slash) {
 		basename_offset = last_slash + 1 - path;
 		dirlen = last_slash - path;
@@ -782,12 +781,12 @@ static void collect_some_attrs(const char *path, int num,
 		rem = fill(path, pathlen, basename_offset, stk, rem);
 }
 
-static int git_check_attrs(const char *path, int num,
+static int git_check_attrs(const char *path, int pathlen, int num,
 			   struct git_attr_check_elem *check)
 {
 	int i;
 
-	collect_some_attrs(path, num, check);
+	collect_some_attrs(path, pathlen, num, check);
 
 	for (i = 0; i < num; i++) {
 		const char *value = check_all_attr[check[i].attr->attr_nr].value;
@@ -804,7 +803,7 @@ void git_all_attrs(const char *path, struct git_attr_check *check)
 	int i;
 
 	git_attr_check_clear(check);
-	collect_some_attrs(path, 0, NULL);
+	collect_some_attrs(path, strlen(path), 0, NULL);
 
 	for (i = 0; i < attr_nr; i++) {
 		const char *name = check_all_attr[i].attr->name;
@@ -829,10 +828,16 @@ void git_attr_set_direction(enum git_attr_direction new, struct index_state *ist
 	use_index = istate;
 }
 
-int git_check_attr(const char *path, struct git_attr_check *check)
+int git_check_attr_counted(const char *path, int pathlen,
+			   struct git_attr_check *check)
 {
 	check->finalized = 1;
-	return git_check_attrs(path, check->check_nr, check->check);
+	return git_check_attrs(path, pathlen, check->check_nr, check->check);
+}
+
+int git_check_attr(const char *path, struct git_attr_check *check)
+{
+	return git_check_attr_counted(path, strlen(path), check);
 }
 
 struct git_attr_check *git_attr_check_initl(const char *one, ...)
diff --git a/attr.h b/attr.h
index 506db0ca74..c84f164b8e 100644
--- a/attr.h
+++ b/attr.h
@@ -38,6 +38,7 @@ struct git_attr_check {
 
 extern struct git_attr_check *git_attr_check_initl(const char *, ...);
 extern int git_check_attr(const char *path, struct git_attr_check *);
+extern int git_check_attr_counted(const char *, int, struct git_attr_check *);
 
 extern struct git_attr_check *git_attr_check_alloc(void);
 extern struct git_attr_check_elem *git_attr_check_append(struct git_attr_check *, const struct git_attr *);
-- 
2.10.1.714.ge3da0db

