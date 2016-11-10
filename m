Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A815C203E2
	for <e@80x24.org>; Thu, 10 Nov 2016 20:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965129AbcKJUe6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 15:34:58 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33086 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965083AbcKJUe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 15:34:57 -0500
Received: by mail-pf0-f172.google.com with SMTP id d2so152090462pfd.0
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 12:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z3yAAPFTgOuG3d7hvJ5o9Coai75k4b7bW4CiJwsbCFs=;
        b=R0++IMLIVka1ic2YaHdH7JbGdv2WmoQfjc+F+FRjL2QA5tMSxakv6ChlmV2o0r/8qE
         WNILrXQfor0zz3/y7PPwr4fJfs93YlD/IXQTSQPtidKbg9pLR9JIqsKNVNiseotaNUbT
         G6JIKY3WZNMy5Lyy5ZNn73D512XKq4bPIJtSyT0zxWE6BU5Ki9du/Rw2JlJLw+UqVgtQ
         9k9z4VI4/bf8ZD5zDlRJsxDZmL28PbveUmbKyHOsAPcNXBkvHJNZyDg5veBnm5oxtr+W
         nwoFEhBjYoN4OX0EInidq1cioYH+1h2aHbNSmGi3zSPPX0MoSx/9CtPXfQYABc9bzEju
         vC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z3yAAPFTgOuG3d7hvJ5o9Coai75k4b7bW4CiJwsbCFs=;
        b=RoOwRUtZmCAuatmwl6qvs6qvfP74LV/3JPxTBtqJujhiGDw697lvy/BcfKPQyg0z6U
         OOfJ/EQQsvRSl1NpV+trOvcUCns3+Nt4ijjjGhYwOHrgnjDhndEGQgKSbrtPXrfsvfDg
         //wLnxgiZO3dhWWflyQjVbEdfCVaYpM4BfxmuYPaTHF86beQVaf2ic5S2UFdWgxDvuYF
         sLy+GPQf+GTG9ytteZl0+/2bw1jEfHzFSCutT+Zn/aHYEhJM5q0MkKJBVaWQOJOTG6yv
         DPLpj3akxzTktWkpCR7NawQeQ/mLns4/SGtC1m/DH+HcgiKk+/y3EFb23k1+upp58p6K
         2xDw==
X-Gm-Message-State: ABUngvfkpXiBdtOUl8Jd4CW2lScD83B6f63/nnchOvDEMiBmJSTE8p90OrLqVz6TkDBRjJHQ
X-Received: by 10.99.227.81 with SMTP id o17mr38583658pgj.69.1478810096531;
        Thu, 10 Nov 2016 12:34:56 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b504:dcf8:965a:7ab8])
        by smtp.gmail.com with ESMTPSA id g10sm9352486pac.14.2016.11.10.12.34.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 12:34:56 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com, pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 15/35] attr: add counted string version of git_check_attr()
Date:   Thu, 10 Nov 2016 12:34:08 -0800
Message-Id: <20161110203428.30512-16-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161110203428.30512-1-sbeller@google.com>
References: <20161110203428.30512-1-sbeller@google.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 23 ++++++++++++++---------
 attr.h |  1 +
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/attr.c b/attr.c
index d427798..9bec243 100644
--- a/attr.c
+++ b/attr.c
@@ -734,20 +734,19 @@ static int attr_check_is_dynamic(const struct git_attr_check *check)
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
@@ -778,12 +777,12 @@ static void collect_some_attrs(const char *path, int num,
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
@@ -800,7 +799,7 @@ void git_all_attrs(const char *path, struct git_attr_check *check)
 	int i;
 
 	git_attr_check_clear(check);
-	collect_some_attrs(path, 0, NULL);
+	collect_some_attrs(path, strlen(path), 0, NULL);
 
 	for (i = 0; i < attr_nr; i++) {
 		const char *name = check_all_attr[i].attr->name;
@@ -825,10 +824,16 @@ void git_attr_set_direction(enum git_attr_direction new, struct index_state *ist
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
index 506db0c..c84f164 100644
--- a/attr.h
+++ b/attr.h
@@ -38,6 +38,7 @@ struct git_attr_check {
 
 extern struct git_attr_check *git_attr_check_initl(const char *, ...);
 extern int git_check_attr(const char *path, struct git_attr_check *);
+extern int git_check_attr_counted(const char *, int, struct git_attr_check *);
 
 extern struct git_attr_check *git_attr_check_alloc(void);
 extern struct git_attr_check_elem *git_attr_check_append(struct git_attr_check *, const struct git_attr *);
-- 
2.10.1.469.g00a8914

