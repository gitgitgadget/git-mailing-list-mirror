Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E75E20989
	for <e@80x24.org>; Tue, 11 Oct 2016 00:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752758AbcJKAVq (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 20:21:46 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35903 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752739AbcJKAVn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 20:21:43 -0400
Received: by mail-pa0-f42.google.com with SMTP id ry6so3887820pac.3
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 17:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GUsVGCsYCqpnXppwPz9Ldh26/o7A0Ye7FiR5t/YO3ec=;
        b=i6tZCTKzFz0RVawN+dRljSct0F3yfOpqXYCt7QXG9BZaz0LK0uZP6zYLEBirHM2Z5R
         lu3QVRd04B7ADzx6yE4lx0ck1ulJ1kdGFgwfIpj61pNEE50Tb8EYuyW1nURv+uIfaHNQ
         ApXcKYHLnSULOHTrEAjEKi1TT4zv/Be3VQmZQwE4pCHrR6h+4V1QQdFdXFqFFlR5qfln
         KuqUJGpc+iOPd4J6Q/7mHaxyK5d/njn4uYwvuqjRh1dMHph1GVTmKXf9QvUdaEPJi0II
         M2jsGTRCxwqxcmdsR0ngKCzWJrZlIR5b2KTQ0+v25/OZaoCHsAzxemS8hCo/yGUMxU+g
         loxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GUsVGCsYCqpnXppwPz9Ldh26/o7A0Ye7FiR5t/YO3ec=;
        b=iDdWIki/5iUXivDnJX9TIAQ7SzlovfTM4H9jqEUOug9vFBvCZXjuir9kgTcKEnGQ0z
         iiZW+w3+1tzZBvFsljEh7BHciBZnUwpI4pM/KIji0czSCBQ1kQD4SL/z/iLmL9O3RLZI
         48Z5bb+/VePjcBfewDVDydkmCKc99parIPp7lfUFHDJkOFHRQZunNXSzSYiQ7IOseFkX
         Xjdlsc3BC1r5sl4k4YY0t/V3l7o2KxOknrGH81ekeffEV4Siq+6Yc8FR6mgLZN6cJHNJ
         k71wzzwCflMbc3JJoI0wKtNa9aXsvzhUYDWcNmMVn0piA6ffGCkaNEbKVbnOlzSsbbEy
         72zQ==
X-Gm-Message-State: AA6/9RlH5vxLtFgAOLHJDZrH3gTqx3EeBm94O1//u0xPuXiCwPUBK2b6hZieSH2zMHkqTKR+
X-Received: by 10.66.97.72 with SMTP id dy8mr1725650pab.114.1476145302195;
        Mon, 10 Oct 2016 17:21:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b8ee:61f5:e989:77a7])
        by smtp.gmail.com with ESMTPSA id 128sm546434pfy.4.2016.10.10.17.21.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Oct 2016 17:21:41 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 11/28] attr: (re)introduce git_check_attr() and struct git_attr_check
Date:   Mon, 10 Oct 2016 17:20:58 -0700
Message-Id: <20161011002115.23312-12-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.382.ga23ca1b.dirty
In-Reply-To: <20161011002115.23312-1-sbeller@google.com>
References: <20161011002115.23312-1-sbeller@google.com>
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
2.10.1.382.ga23ca1b.dirty

