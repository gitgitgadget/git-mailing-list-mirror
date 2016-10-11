Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3F0D20989
	for <e@80x24.org>; Tue, 11 Oct 2016 00:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752960AbcJKAWf (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 20:22:35 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:32805 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752746AbcJKAVo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 20:21:44 -0400
Received: by mail-pa0-f43.google.com with SMTP id vu5so3986201pab.0
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 17:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AK1zd05Emh/z3zIVxSRl+N6UK/fdjlPh6lyMvbKhCKM=;
        b=eIRp8MbOJla0zFMM1AnY/3NZgCuVp0UFuIz3MqKAGKY4MvU3RzvpkL1zZJo4i5Ksem
         5QFkcjpQiMclj6lohDcXRTB9oTvsfUllIFWoUq7fB1u3tZlmHykygAser89o0p5NSfuC
         FrJ3VPtNuPFVX6LQE6rMsMOxfHqDTfj6MF3+fZMrctwedsC58fA0W36JNXn5T0Ncda43
         BLyF032ApE1Zc8zEG/ogkJU5oeLJaiufADawrHaPV5Hi06dTTl0P+6z/HpXlrhdlH6wM
         0jtncfbTjNpPqsYnvfkdC7hFfdPCiNwHqSAwK69FwyOWL7N6110vAkgLbqVPWciQr6nE
         JU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AK1zd05Emh/z3zIVxSRl+N6UK/fdjlPh6lyMvbKhCKM=;
        b=HrO9S/3uJOzJSzYaTDyofXrL+tDXlfbFacOISLBEsewYA1VdmFssAJN/lsQK7IDkKe
         1wKfUoxIBWt9Gt1Xz4Ix9Q3RT0Qnzb39ovcpOuyK1DAODu+oVIlUXOIEB4UVgOeyh4t7
         rKKhsRdbetO3O3rN3tkKLk1Ny5on/V/Vo43mGEbQBXTs2CAw2Fp1+3Fi6cN557C+UKmb
         jUpxoylfn0aMbhNAfAYFoTMppP9goJzJ7TVKSHt5MrqPhSWF9JR9B8siwAkpsIkkMIwY
         VmnhjCPX6glx5qti0AWV2kVWjGkU21U8Cj+AC/RfyaGdExJbzkqogAu3DFyiad84LH2f
         zROQ==
X-Gm-Message-State: AA6/9RnWqIGEF2mqje2ZnZThwNTDKzk/Z6X1h26phCo2qxnrdH1QC+WYDpMI6cV5te1J/lb6
X-Received: by 10.66.142.169 with SMTP id rx9mr1743420pab.122.1476145304037;
        Mon, 10 Oct 2016 17:21:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b8ee:61f5:e989:77a7])
        by smtp.gmail.com with ESMTPSA id i191sm531870pfe.27.2016.10.10.17.21.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Oct 2016 17:21:43 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 12/28] attr: convert git_all_attrs() to use "struct git_attr_check"
Date:   Mon, 10 Oct 2016 17:20:59 -0700
Message-Id: <20161011002115.23312-13-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.382.ga23ca1b.dirty
In-Reply-To: <20161011002115.23312-1-sbeller@google.com>
References: <20161011002115.23312-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

This updates the other two ways the attribute check is done via an
array of "struct git_attr_check_elem" elements.  These two niches
appear only in "git check-attr".

 * The caller does not know offhand what attributes it wants to ask
   about and cannot use git_attr_check_initl() to prepare the
   git_attr_check structure.

 * The caller may not know what attributes it wants to ask at all,
   and instead wants to learn everything that the given path has.

Such a caller can call git_attr_check_alloc() to allocate an empty
git_attr_check, and then call git_attr_check_append() to add
attribute names one by one.  A new attribute can be appended until
git_attr_check structure is "finalized", which happens when it is
used to ask for attributes for any path by calling git_check_attr()
or git_all_attrs().  A git_attr_check structure that is initialized
by git_attr_check_initl() is already finalized when it is returned.

I am not at all happy with the way git_all_attrs() API turned out to
be, but it is only to support one niche caller ("check-attr --all"),
so I'll stop here for now.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c               | 75 ++++++++++++++++++++++++++++++++++++++--------------
 attr.h               | 16 ++++++-----
 builtin/check-attr.c | 51 ++++++++++++++++++-----------------
 3 files changed, 90 insertions(+), 52 deletions(-)

diff --git a/attr.c b/attr.c
index 861e1a2..76f0d6b 100644
--- a/attr.c
+++ b/attr.c
@@ -724,6 +724,11 @@ static int macroexpand_one(int nr, int rem)
 	return rem;
 }
 
+static int attr_check_is_dynamic(const struct git_attr_check *check)
+{
+	return (void *)(check->check) != (void *)(check + 1);
+}
+
 /*
  * Collect attributes for path into the array pointed to by
  * check_all_attr. If num is non-zero, only attributes in check[] are
@@ -789,32 +794,21 @@ int git_check_attrs(const char *path, int num, struct git_attr_check_elem *check
 	return 0;
 }
 
-int git_all_attrs(const char *path, int *num, struct git_attr_check_elem **check)
+void git_all_attrs(const char *path, struct git_attr_check *check)
 {
-	int i, count, j;
+	int i;
 
+	git_attr_check_clear(check);
 	collect_some_attrs(path, 0, NULL);
 
-	/* Count the number of attributes that are set. */
-	count = 0;
-	for (i = 0; i < attr_nr; i++) {
-		const char *value = check_all_attr[i].value;
-		if (value != ATTR__UNSET && value != ATTR__UNKNOWN)
-			++count;
-	}
-	*num = count;
-	ALLOC_ARRAY(*check, count);
-	j = 0;
 	for (i = 0; i < attr_nr; i++) {
+		const char *name = check_all_attr[i].attr->name;
 		const char *value = check_all_attr[i].value;
-		if (value != ATTR__UNSET && value != ATTR__UNKNOWN) {
-			(*check)[j].attr = check_all_attr[i].attr;
-			(*check)[j].value = value;
-			++j;
-		}
+		if (value == ATTR__UNSET || value == ATTR__UNKNOWN)
+			continue;
+		git_attr_check_append(check, git_attr(name));
+		check->check[check->check_nr - 1].value = value;
 	}
-
-	return 0;
 }
 
 void git_attr_set_direction(enum git_attr_direction new, struct index_state *istate)
@@ -832,6 +826,7 @@ void git_attr_set_direction(enum git_attr_direction new, struct index_state *ist
 
 int git_check_attr(const char *path, struct git_attr_check *check)
 {
+	check->finalized = 1;
 	return git_check_attrs(path, check->check_nr, check->check);
 }
 
@@ -849,17 +844,57 @@ struct git_attr_check *git_attr_check_initl(const char *one, ...)
 	check = xcalloc(1,
 			sizeof(*check) + cnt * sizeof(*(check->check)));
 	check->check_nr = cnt;
+	check->finalized = 1;
 	check->check = (struct git_attr_check_elem *)(check + 1);
 
 	check->check[0].attr = git_attr(one);
 	va_start(params, one);
 	for (cnt = 1; cnt < check->check_nr; cnt++) {
+		struct git_attr *attr;
 		param = va_arg(params, const char *);
 		if (!param)
 			die("BUG: counted %d != ended at %d",
 			    check->check_nr, cnt);
-		check->check[cnt].attr = git_attr(param);
+		attr = git_attr(param);
+		if (!attr)
+			die("BUG: %s: not a valid attribute name", param);
+		check->check[cnt].attr = attr;
 	}
 	va_end(params);
 	return check;
 }
+
+struct git_attr_check *git_attr_check_alloc(void)
+{
+	return xcalloc(1, sizeof(struct git_attr_check));
+}
+
+struct git_attr_check_elem *git_attr_check_append(struct git_attr_check *check,
+						  const struct git_attr *attr)
+{
+	struct git_attr_check_elem *elem;
+	if (check->finalized)
+		die("BUG: append after git_attr_check structure is finalized");
+	if (!attr_check_is_dynamic(check))
+		die("BUG: appending to a statically initialized git_attr_check");
+	ALLOC_GROW(check->check, check->check_nr + 1, check->check_alloc);
+	elem = &check->check[check->check_nr++];
+	elem->attr = attr;
+	return elem;
+}
+
+void git_attr_check_clear(struct git_attr_check *check)
+{
+	if (!attr_check_is_dynamic(check))
+		die("BUG: clearing a statically initialized git_attr_check");
+	free(check->check);
+	check->check_nr = 0;
+	check->check_alloc = 0;
+	check->finalized = 0;
+}
+
+void git_attr_check_free(struct git_attr_check *check)
+{
+	git_attr_check_clear(check);
+	free(check);
+}
diff --git a/attr.h b/attr.h
index 3fd8690..0d94077 100644
--- a/attr.h
+++ b/attr.h
@@ -30,6 +30,7 @@ struct git_attr_check_elem {
 };
 
 struct git_attr_check {
+	int finalized;
 	int check_nr;
 	int check_alloc;
 	struct git_attr_check_elem *check;
@@ -38,6 +39,12 @@ struct git_attr_check {
 extern struct git_attr_check *git_attr_check_initl(const char *, ...);
 extern int git_check_attr(const char *path, struct git_attr_check *);
 
+extern struct git_attr_check *git_attr_check_alloc(void);
+extern struct git_attr_check_elem *git_attr_check_append(struct git_attr_check *, const struct git_attr *);
+
+extern void git_attr_check_clear(struct git_attr_check *);
+extern void git_attr_check_free(struct git_attr_check *);
+
 /*
  * Return the name of the attribute represented by the argument.  The
  * return value is a pointer to a null-delimited string that is part
@@ -48,13 +55,10 @@ extern const char *git_attr_name(const struct git_attr *);
 int git_check_attrs(const char *path, int, struct git_attr_check_elem *);
 
 /*
- * Retrieve all attributes that apply to the specified path.  *num
- * will be set to the number of attributes on the path; **check will
- * be set to point at a newly-allocated array of git_attr_check
- * objects describing the attributes and their values.  *check must be
- * free()ed by the caller.
+ * Retrieve all attributes that apply to the specified path.
+ * check holds the attributes and their values.
  */
-int git_all_attrs(const char *path, int *num, struct git_attr_check_elem **check);
+void git_all_attrs(const char *path, struct git_attr_check *check);
 
 enum git_attr_direction {
 	GIT_ATTR_CHECKIN,
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 97e3837..ec61476 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -24,12 +24,13 @@ static const struct option check_attr_options[] = {
 	OPT_END()
 };
 
-static void output_attr(int cnt, struct git_attr_check_elem *check,
-			const char *file)
+static void output_attr(struct git_attr_check *check, const char *file)
 {
 	int j;
+	int cnt = check->check_nr;
+
 	for (j = 0; j < cnt; j++) {
-		const char *value = check[j].value;
+		const char *value = check->check[j].value;
 
 		if (ATTR_TRUE(value))
 			value = "set";
@@ -42,36 +43,37 @@ static void output_attr(int cnt, struct git_attr_check_elem *check,
 			printf("%s%c" /* path */
 			       "%s%c" /* attrname */
 			       "%s%c" /* attrvalue */,
-			       file, 0, git_attr_name(check[j].attr), 0, value, 0);
+			       file, 0,
+			       git_attr_name(check->check[j].attr), 0, value, 0);
 		} else {
 			quote_c_style(file, NULL, stdout, 0);
-			printf(": %s: %s\n", git_attr_name(check[j].attr), value);
+			printf(": %s: %s\n",
+			       git_attr_name(check->check[j].attr), value);
 		}
-
 	}
 }
 
 static void check_attr(const char *prefix,
-		       int cnt, struct git_attr_check_elem *check,
+		       struct git_attr_check *check,
 		       const char *file)
 {
 	char *full_path =
 		prefix_path(prefix, prefix ? strlen(prefix) : 0, file);
 	if (check != NULL) {
-		if (git_check_attrs(full_path, cnt, check))
-			die("git_check_attrs died");
-		output_attr(cnt, check, file);
+		if (git_check_attr(full_path, check))
+			die("git_check_attr died");
+		output_attr(check, file);
 	} else {
-		if (git_all_attrs(full_path, &cnt, &check))
-			die("git_all_attrs died");
-		output_attr(cnt, check, file);
-		free(check);
+		check = git_attr_check_alloc();
+		git_all_attrs(full_path, check);
+		output_attr(check, file);
+		git_attr_check_free(check);
 	}
 	free(full_path);
 }
 
 static void check_attr_stdin_paths(const char *prefix,
-				   int cnt, struct git_attr_check_elem *check)
+				   struct git_attr_check *check)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf unquoted = STRBUF_INIT;
@@ -85,7 +87,7 @@ static void check_attr_stdin_paths(const char *prefix,
 				die("line is badly quoted");
 			strbuf_swap(&buf, &unquoted);
 		}
-		check_attr(prefix, cnt, check, buf.buf);
+		check_attr(prefix, check, buf.buf);
 		maybe_flush_or_die(stdout, "attribute to stdout");
 	}
 	strbuf_release(&buf);
@@ -100,7 +102,7 @@ static NORETURN void error_with_usage(const char *msg)
 
 int cmd_check_attr(int argc, const char **argv, const char *prefix)
 {
-	struct git_attr_check_elem *check;
+	struct git_attr_check *check;
 	int cnt, i, doubledash, filei;
 
 	if (!is_bare_repository())
@@ -163,24 +165,21 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	if (all_attrs) {
 		check = NULL;
 	} else {
-		check = xcalloc(cnt, sizeof(*check));
+		check = git_attr_check_alloc();
 		for (i = 0; i < cnt; i++) {
-			const char *name;
-			struct git_attr *a;
-			name = argv[i];
-			a = git_attr(name);
+			struct git_attr *a = git_attr(argv[i]);
 			if (!a)
 				return error("%s: not a valid attribute name",
-					name);
-			check[i].attr = a;
+					     argv[i]);
+			git_attr_check_append(check, a);
 		}
 	}
 
 	if (stdin_paths)
-		check_attr_stdin_paths(prefix, cnt, check);
+		check_attr_stdin_paths(prefix, check);
 	else {
 		for (i = filei; i < argc; i++)
-			check_attr(prefix, cnt, check, argv[i]);
+			check_attr(prefix, check, argv[i]);
 		maybe_flush_or_die(stdout, "attribute to stdout");
 	}
 	return 0;
-- 
2.10.1.382.ga23ca1b.dirty

