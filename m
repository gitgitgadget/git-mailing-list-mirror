Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA3C21FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 23:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750945AbdALXzj (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 18:55:39 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35845 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbdALXz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 18:55:26 -0500
Received: by mail-pf0-f179.google.com with SMTP id 189so20630189pfu.3
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 15:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RkyXNJbCg2+053SUg0PNrJWCynpT9HkMZi5XknUZiPE=;
        b=gShyzsBR6V6yWr64FsZ6gwJchIMo42IuDKcaQW//tGnpCfr+DGWeW8kgbDMXvy4c53
         1CZNHk6ZDuB0VCRhW1sDX1RzNG6IIzi7fHzq6qd4ZFDaVYqtEngKdTCHU0dOQ4uVZX37
         DW2gCcm4MauhpdO/+Yqi6+1MWP6J5aGYbeX2gLO0s+RM9zQ8k7UsP/+PJBxLWWI7q1u4
         S7ri4PHdhwm+Tx6PvP8HGcjtXNJvJOLT1ixBsvhUplStl4qdWJnFM6ttUP46cswmLVbP
         1ncbWiDgUSxEMZetbvw0TrZ+48QeSFVzJZInBkIt+wEafGrRR1S4/uF6lAF+fllORLlj
         SbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RkyXNJbCg2+053SUg0PNrJWCynpT9HkMZi5XknUZiPE=;
        b=N+X5AXB+6rQczykRDpmTKF6kyEfJeeb418hTGsmsd4A4tksIPQrfzubVRDsEnJL1LN
         NK9b/Yx7fq/vx62jcsSjhvfguZJRdskb1i++xBpWMkxzFZOivcXCqX7CGeMvOKHdO2D0
         GWONHKtdaKrE0OR0DsEyNkIKOSenkxzF7TeBrScfi9vKW5fStFu7YclTh1U5gr4UpNiw
         6d3yWjZPoh7SPT2O+awYOmeCgUHAfgZ4/TfHY4y6lm+xQ5lHJLROMlwXVGU1S/qnu+vm
         TsU/B12j9OGvvfxaZ5Uh0aEL0w3CCADybs0MWJjEocdrHHPCUmgZk21dskeF8HdayYC3
         qfPA==
X-Gm-Message-State: AIkVDXJ47xgfzd7sCAFuEb7gbQRf3hueW7lMGug/D4cHc9gevY6Dyu95OX4ZdiYAxjTaxVjD
X-Received: by 10.84.138.3 with SMTP id 3mr25337497plo.108.1484265265645;
        Thu, 12 Jan 2017 15:54:25 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id e6sm24312192pgf.4.2017.01.12.15.54.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jan 2017 15:54:24 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, pclouds@gmail.com,
        sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 15/27] attr: (re)introduce git_check_attr() and struct attr_check
Date:   Thu, 12 Jan 2017 15:53:42 -0800
Message-Id: <20170112235354.153403-16-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170112235354.153403-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

A common pattern to check N attributes for many paths is to

 (1) prepare an array A of N attr_check_item items;
 (2) call git_attr() to intern the N attribute names and fill A;
 (3) repeatedly call git_check_attrs() for path with N and A;

A look-up for these N attributes for a single path P scans the
entire attr_stack, starting from the .git/info/attributes file and
then .gitattributes file in the directory the path P is in, going
upwards to find .gitattributes file found in parent directories.

An earlier commit 06a604e6 (attr: avoid heavy work when we know the
specified attr is not defined, 2014-12-28) tried to optimize out
this scanning for one trivial special case: when the attribute being
sought is known not to exist, we do not have to scan for it.  While
this may be a cheap and effective heuristic, it would not work well
when N is (much) more than 1.

What we would want is a more customized way to skip irrelevant
entries in the attribute stack, and the definition of irrelevance
is tied to the set of attributes passed to git_check_attrs() call,
i.e. the set of attributes being sought.  The data necessary for
this optimization needs to live alongside the set of attributes, but
a simple array of git_attr_check_elem simply does not have any place
for that.

Introduce "struct attr_check" that contains N, the number of
attributes being sought, and A, the array that holds N
attr_check_item items, and a function git_check_attr() that
takes a path P and this structure as its parameters.  This structure
can later be extended to hold extra data necessary for optimization.

Also, to make it easier to write the first two steps in common
cases, introduce git_attr_check_initl() helper function, which takes
a NULL-terminated list of attribute names and initialize this
structure.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 attr.h | 17 +++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/attr.c b/attr.c
index 2f180d609..be9e398e9 100644
--- a/attr.c
+++ b/attr.c
@@ -865,6 +865,80 @@ int git_all_attrs(const char *path, int *num, struct attr_check_item **check)
 	return 0;
 }
 
+struct attr_check *attr_check_alloc(void)
+{
+	return xcalloc(1, sizeof(struct attr_check));
+}
+
+int git_check_attr(const char *path, struct attr_check *check)
+{
+	return git_check_attrs(path, check->check_nr, check->check);
+}
+
+struct attr_check *attr_check_initl(const char *one, ...)
+{
+	struct attr_check *check;
+	int cnt;
+	va_list params;
+	const char *param;
+
+	va_start(params, one);
+	for (cnt = 1; (param = va_arg(params, const char *)) != NULL; cnt++)
+		;
+	va_end(params);
+
+	check = attr_check_alloc();
+	check->check_nr = cnt;
+	check->check_alloc = cnt;
+	check->check = xcalloc(cnt, sizeof(struct attr_check_item));
+
+	check->check[0].attr = git_attr(one);
+	va_start(params, one);
+	for (cnt = 1; cnt < check->check_nr; cnt++) {
+		struct git_attr *attr;
+		param = va_arg(params, const char *);
+		if (!param)
+			die("BUG: counted %d != ended at %d",
+			    check->check_nr, cnt);
+		attr = git_attr(param);
+		if (!attr)
+			die("BUG: %s: not a valid attribute name", param);
+		check->check[cnt].attr = attr;
+	}
+	va_end(params);
+	return check;
+}
+
+struct attr_check_item *attr_check_append(struct attr_check *check,
+					  const struct git_attr *attr)
+{
+	struct attr_check_item *item;
+
+	ALLOC_GROW(check->check, check->check_nr + 1, check->check_alloc);
+	item = &check->check[check->check_nr++];
+	item->attr = attr;
+	return item;
+}
+
+void attr_check_reset(struct attr_check *check)
+{
+	check->check_nr = 0;
+}
+
+void attr_check_clear(struct attr_check *check)
+{
+	free(check->check);
+	check->check = NULL;
+	check->check_alloc = 0;
+	check->check_nr = 0;
+}
+
+void attr_check_free(struct attr_check *check)
+{
+	attr_check_clear(check);
+	free(check);
+}
+
 void git_attr_set_direction(enum git_attr_direction new, struct index_state *istate)
 {
 	enum git_attr_direction old = direction;
diff --git a/attr.h b/attr.h
index efc7bb3b3..459347f4b 100644
--- a/attr.h
+++ b/attr.h
@@ -29,6 +29,22 @@ struct attr_check_item {
 	const char *value;
 };
 
+struct attr_check {
+	int check_nr;
+	int check_alloc;
+	struct attr_check_item *check;
+};
+
+extern struct attr_check *attr_check_alloc(void);
+extern struct attr_check *attr_check_initl(const char *, ...);
+
+extern struct attr_check_item *attr_check_append(struct attr_check *check,
+						 const struct git_attr *attr);
+
+extern void attr_check_reset(struct attr_check *check);
+extern void attr_check_clear(struct attr_check *check);
+extern void attr_check_free(struct attr_check *check);
+
 /*
  * Return the name of the attribute represented by the argument.  The
  * return value is a pointer to a null-delimited string that is part
@@ -37,6 +53,7 @@ struct attr_check_item {
 extern const char *git_attr_name(const struct git_attr *);
 
 int git_check_attrs(const char *path, int, struct attr_check_item *);
+extern int git_check_attr(const char *path, struct attr_check *check);
 
 /*
  * Retrieve all attributes that apply to the specified path.  *num
-- 
2.11.0.390.gc69c2f50cf-goog

