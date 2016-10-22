Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4546C20986
	for <e@80x24.org>; Sat, 22 Oct 2016 23:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964940AbcJVXdC (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 19:33:02 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:35464 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935666AbcJVXcy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 19:32:54 -0400
Received: by mail-it0-f47.google.com with SMTP id 198so53151512itw.0
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 16:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xTLoLp34pThn6G6c2eKuk8yE6U7PsN7/EbB+/BIWRVI=;
        b=crcRBj7dosq2Vc26dY5Uv2Y9pjsrZ5pFZxa/ThCdW76ep1rbxLHUnaF4LwoaRCZOb+
         3cp1h82C95y7YwXYRNxhj1RZIStoCtWxcaaebqCIVuldlX0lIcxJt72Hh8HRiPxMt7Ky
         MTD8FA1zY4e59tasOPORAcuYcPg88HcN3qAACZh6b84KUL9cIf/pMJg7tbeuU6s/tlDU
         9eSShlgoegRk7daL+zM9kBDhaYZlB8s2x9DygjhshqvrNMRZJ04PKwG8H41fdmLsGN8r
         cYyScLHsQM5Ga6NHsKjDW3l+poW9JHXfj2TLQo5QtwAVpta2iw+sMFOe/oR+bO53ZLyD
         CoNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xTLoLp34pThn6G6c2eKuk8yE6U7PsN7/EbB+/BIWRVI=;
        b=lsLBrO0k8+ZBc24VZfYzEHVs1vMBLTen5yBr3FEHlgauQ1XmBzIQZKTrobG8J/8eiL
         siRl7KpIBJQGTZEMzH9u9p2LBhjhXAoiDLYTqsV+F2Kpv6Cs+Vg+ciirOEaaLn+gJKbG
         862gT6Lpgme6UVjW0zBDue1bvRayRN2bXvMSxz9CpQoeo4+oI1htkvErVF5ehNUIbOgD
         hhjM/R/Ta5eCnaIw4sWQqXuPluf09BLZO+/fikOERhNTkCISqgth6zzkW3AyrUZ2d9/y
         qBMtk2vpLczUQ9xYz2il7sRSD1oUSBoaOzUkI+zUmGTCzerCv3r4NRlwDVWGSqdNk5r8
         Shlg==
X-Gm-Message-State: ABUngvfea7rxiDmLFwaQw9BavKY8U4ZTZPq1ZDMj1dH50ThtL5zhscSwqcgoks+xWYndsMB3
X-Received: by 10.36.44.80 with SMTP id i77mr7168146iti.119.1477179173063;
        Sat, 22 Oct 2016 16:32:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4ca0:b1d9:cc22:1c7b])
        by smtp.gmail.com with ESMTPSA id e6sm2588292ite.2.2016.10.22.16.32.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 22 Oct 2016 16:32:52 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 11/36] attr: (re)introduce git_check_attr() and struct git_attr_check
Date:   Sat, 22 Oct 2016 16:32:00 -0700
Message-Id: <20161022233225.8883-12-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.508.g6572022
In-Reply-To: <20161022233225.8883-1-sbeller@google.com>
References: <20161022233225.8883-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

A common pattern to check N attributes for many paths is to

 (1) prepare an array A of N git_attr_check_elem items;
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

Introduce "struct git_attr_check" that contains N, the number of
attributes being sought, and A, the array that holds N
git_attr_check_elem items, and a function git_check_attr() that
takes a path P and this structure as its parameters.  This structure
can later be extended to hold extra data necessary for optimization.

Also, to make it easier to write the first two steps in common
cases, introduce git_attr_check_initl() helper function, which takes
a NULL-terminated list of attribute names and initialize this
structure.

As an illustration of this new API, convert archive.c that asks for
export-subst and export-ignore attributes for each paths.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 archive.c | 24 ++++++------------------
 attr.c    | 34 ++++++++++++++++++++++++++++++++++
 attr.h    |  9 +++++++++
 3 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/archive.c b/archive.c
index 2dc8d6c..11e3951 100644
--- a/archive.c
+++ b/archive.c
@@ -87,19 +87,6 @@ void *sha1_file_to_archive(const struct archiver_args *args,
 	return buffer;
 }
 
-static void setup_archive_check(struct git_attr_check_elem *check)
-{
-	static struct git_attr *attr_export_ignore;
-	static struct git_attr *attr_export_subst;
-
-	if (!attr_export_ignore) {
-		attr_export_ignore = git_attr("export-ignore");
-		attr_export_subst = git_attr("export-subst");
-	}
-	check[0].attr = attr_export_ignore;
-	check[1].attr = attr_export_subst;
-}
-
 struct directory {
 	struct directory *up;
 	struct object_id oid;
@@ -123,7 +110,7 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 	struct archiver_context *c = context;
 	struct archiver_args *args = c->args;
 	write_archive_entry_fn_t write_entry = c->write_entry;
-	struct git_attr_check_elem check[2];
+	static struct git_attr_check *check;
 	const char *path_without_prefix;
 	int err;
 
@@ -137,11 +124,12 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 		strbuf_addch(&path, '/');
 	path_without_prefix = path.buf + args->baselen;
 
-	setup_archive_check(check);
-	if (!git_check_attrs(path_without_prefix, ARRAY_SIZE(check), check)) {
-		if (ATTR_TRUE(check[0].value))
+	if (!check)
+		check = git_attr_check_initl("export-ignore", "export-subst", NULL);
+	if (!git_check_attr(path_without_prefix, check)) {
+		if (ATTR_TRUE(check->check[0].value))
 			return 0;
-		args->convert = ATTR_TRUE(check[1].value);
+		args->convert = ATTR_TRUE(check->check[1].value);
 	}
 
 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
diff --git a/attr.c b/attr.c
index c99e23a..861e1a2 100644
--- a/attr.c
+++ b/attr.c
@@ -829,3 +829,37 @@ void git_attr_set_direction(enum git_attr_direction new, struct index_state *ist
 		drop_attr_stack();
 	use_index = istate;
 }
+
+int git_check_attr(const char *path, struct git_attr_check *check)
+{
+	return git_check_attrs(path, check->check_nr, check->check);
+}
+
+struct git_attr_check *git_attr_check_initl(const char *one, ...)
+{
+	struct git_attr_check *check;
+	int cnt;
+	va_list params;
+	const char *param;
+
+	va_start(params, one);
+	for (cnt = 1; (param = va_arg(params, const char *)) != NULL; cnt++)
+		;
+	va_end(params);
+	check = xcalloc(1,
+			sizeof(*check) + cnt * sizeof(*(check->check)));
+	check->check_nr = cnt;
+	check->check = (struct git_attr_check_elem *)(check + 1);
+
+	check->check[0].attr = git_attr(one);
+	va_start(params, one);
+	for (cnt = 1; cnt < check->check_nr; cnt++) {
+		param = va_arg(params, const char *);
+		if (!param)
+			die("BUG: counted %d != ended at %d",
+			    check->check_nr, cnt);
+		check->check[cnt].attr = git_attr(param);
+	}
+	va_end(params);
+	return check;
+}
diff --git a/attr.h b/attr.h
index dd3c4a3..3fd8690 100644
--- a/attr.h
+++ b/attr.h
@@ -29,6 +29,15 @@ struct git_attr_check_elem {
 	const char *value;
 };
 
+struct git_attr_check {
+	int check_nr;
+	int check_alloc;
+	struct git_attr_check_elem *check;
+};
+
+extern struct git_attr_check *git_attr_check_initl(const char *, ...);
+extern int git_check_attr(const char *path, struct git_attr_check *);
+
 /*
  * Return the name of the attribute represented by the argument.  The
  * return value is a pointer to a null-delimited string that is part
-- 
2.10.1.508.g6572022

