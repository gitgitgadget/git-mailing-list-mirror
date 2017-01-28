Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C91361F437
	for <e@80x24.org>; Sat, 28 Jan 2017 02:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751281AbdA1CDE (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 21:03:04 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34593 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbdA1CCw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 21:02:52 -0500
Received: by mail-pg0-f50.google.com with SMTP id 14so85553702pgg.1
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 18:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q/nnb2wbMkVDsw2CX6JwDJYEX5RK2ek2zPdmI9qOW5U=;
        b=SBuFEc8k2/dQVfPk//uaBOeTTRHfZN1mFvC/tfa0BBND4SSnIhpWff5neDHcOVukTc
         YhfsV4FyV50u6dph71zsxHnW/js78KX98AxyaeYGxC019IRAcEOByxqWp3heVuCIcmq4
         WYzoTPHVFlIcpZ5UjRv2jWy3IIF9IHMt8CSM417qZqda8zsFbN4SpMG+nZ1Wus0OW/ju
         ISPNPGzSgKmjW0vg2OX/ZvAm4wp1qtRY81rbyTeFcdQR33eZ1jbi8q3pfuizpsEj9iMp
         d7U3Ns3ENuN46B++WSbQ7nlYfpOqdN3WXirwilv22GjtgX2Ro1K/3gf6hF3pze7mGFxg
         0RcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q/nnb2wbMkVDsw2CX6JwDJYEX5RK2ek2zPdmI9qOW5U=;
        b=o+Xx7vKxajY2Cff8iyRc1lKGCag4DhmHl8xJWxe/4zNGuiXP4RxzKqAIujSTQBNik0
         9Q2Q6FJnKbh/eKCoWUBxb0h3WYwNlNfEzXW0v3Ie3gbj3BsknNRZCuHIIB9iJhd9NjbB
         iG7vbT9sl+y0fBu4MFOE9ts9NJioFho32RGcQO101HFQF9F6zcXxklz2e/DI/VmkY/Dk
         QNFSSNr18jOkKAK9f88r7GRBLOlgAzEDk9rTSWp7Ff3hjrne0ajV35vAgWTmH4ukOszi
         nyZLPnvkpUSvxH0qN0kl15NS24Dtx2OkDIgu+jzijcy9vdhLqcXd0kp9eSv9vXJUPjJe
         YxLQ==
X-Gm-Message-State: AIkVDXK1Dj5MlSDe8478SaH75pAnieisQq3yFaPVB4yAovZ73QviBgJ2vvNRJwn3iudcCoLE
X-Received: by 10.99.173.14 with SMTP id g14mr12703919pgf.176.1485568971471;
        Fri, 27 Jan 2017 18:02:51 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id w76sm14136185pfd.74.2017.01.27.18.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jan 2017 18:02:50 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 15/27] attr: (re)introduce git_check_attr() and struct attr_check
Date:   Fri, 27 Jan 2017 18:01:55 -0800
Message-Id: <20170128020207.179015-16-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170128020207.179015-1-bmwill@google.com>
References: <20170123203525.185058-1-bmwill@google.com>
 <20170128020207.179015-1-bmwill@google.com>
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
index 2f180d609..de8bf35a3 100644
--- a/attr.c
+++ b/attr.c
@@ -132,6 +132,75 @@ struct git_attr *git_attr(const char *name)
 	return git_attr_internal(name, strlen(name));
 }
 
+struct attr_check *attr_check_alloc(void)
+{
+	return xcalloc(1, sizeof(struct attr_check));
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
+	check->nr = cnt;
+	check->alloc = cnt;
+	check->items = xcalloc(cnt, sizeof(struct attr_check_item));
+
+	check->items[0].attr = git_attr(one);
+	va_start(params, one);
+	for (cnt = 1; cnt < check->nr; cnt++) {
+		const struct git_attr *attr;
+		param = va_arg(params, const char *);
+		if (!param)
+			die("BUG: counted %d != ended at %d",
+			    check->nr, cnt);
+		attr = git_attr(param);
+		if (!attr)
+			die("BUG: %s: not a valid attribute name", param);
+		check->items[cnt].attr = attr;
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
+	ALLOC_GROW(check->items, check->nr + 1, check->alloc);
+	item = &check->items[check->nr++];
+	item->attr = attr;
+	return item;
+}
+
+void attr_check_reset(struct attr_check *check)
+{
+	check->nr = 0;
+}
+
+void attr_check_clear(struct attr_check *check)
+{
+	free(check->items);
+	check->items = NULL;
+	check->alloc = 0;
+	check->nr = 0;
+}
+
+void attr_check_free(struct attr_check *check)
+{
+	attr_check_clear(check);
+	free(check);
+}
+
 /* What does a matched pattern decide? */
 struct attr_state {
 	struct git_attr *attr;
@@ -865,6 +934,11 @@ int git_all_attrs(const char *path, int *num, struct attr_check_item **check)
 	return 0;
 }
 
+int git_check_attr(const char *path, struct attr_check *check)
+{
+	return git_check_attrs(path, check->nr, check->items);
+}
+
 void git_attr_set_direction(enum git_attr_direction new, struct index_state *istate)
 {
 	enum git_attr_direction old = direction;
diff --git a/attr.h b/attr.h
index efc7bb3b3..e611b139a 100644
--- a/attr.h
+++ b/attr.h
@@ -29,6 +29,22 @@ struct attr_check_item {
 	const char *value;
 };
 
+struct attr_check {
+	int nr;
+	int alloc;
+	struct attr_check_item *items;
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
2.11.0.483.g087da7b7c-goog

