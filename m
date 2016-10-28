Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63DB0203BD
	for <e@80x24.org>; Fri, 28 Oct 2016 18:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966284AbcJ1Szs (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:55:48 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35269 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966136AbcJ1Szj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:55:39 -0400
Received: by mail-pf0-f179.google.com with SMTP id s8so41507899pfj.2
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 11:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yVOHwTK8azbR5HKamId+A1WjCb9jm515Y53omhtymVs=;
        b=ERRTXU37cyKqL4oDdLhMyK7W2hfu2Ubp6qKoBPZAd/4DE7lvvyMiRn4/DZnH9DKqYJ
         9qMq0HgJI2q+ykwUKzEjuYT1wAzC3e4d0bTA4xEfgQAXsgginyez5PPYAFn0TsWFedOr
         FpXUghYTxyCO1FqrkuJDliwdTaLEpYyP82WFkjD1m3jPJXI41C8WA5oQek9EAX6lJqEw
         DoXia6vuDvWQjGHMHQVhOCZLEoeg2h/M78SW1nZN+XwvLToPAQ4Id9oLOQkSOmujPVFn
         IkRnf5oz/QvFFZDGzuOUIJSTBG2IDbkwBN8SLyeEV/S50KlIG6DaxlZReEgPFHgIZ3F4
         1nXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yVOHwTK8azbR5HKamId+A1WjCb9jm515Y53omhtymVs=;
        b=gVwr44l1aHLpciXrE09U8yP1EXMCXtn5Djvyp5UlNwpk1Dq775cUK2fdRbCV1IWqDq
         ldaETHToyoZVDTw4HEm3OAcsAB/IklDGcwx+AaDq7FyZMpjelifaB5CU07uLPOhEZy3W
         x+f3KxFUTwulbyACFImyzXk7ElmNJNEuStZu/I5YOMb9LtneeK50TGPLBgi9FX/2aA1z
         m/ntI3BnOvJhruf9RsuLvjC8Dc9uMu8ia2pRDTo/YqUreCdWJ4aiqx47whdPmC91dsOf
         7WMtHHZEljV8GJT0J8KkmMUOAPDxSsgRfyVG6kvgtC4tuwpMZ2nUcZ163rLp8Y9qcqwh
         Qw2w==
X-Gm-Message-State: ABUngvdHA1Kwih9CctAJa69qTkmSfxutt0+eA3vPhtYvecFfhV4Npe90ZnwJVRlAVfHLqbLW
X-Received: by 10.98.103.152 with SMTP id t24mr27717032pfj.77.1477680938643;
        Fri, 28 Oct 2016 11:55:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:91ed:bb99:5319:17e9])
        by smtp.gmail.com with ESMTPSA id r77sm20615390pfb.2.2016.10.28.11.55.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 11:55:38 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 11/36] attr: (re)introduce git_check_attr() and struct git_attr_check
Date:   Fri, 28 Oct 2016 11:54:37 -0700
Message-Id: <20161028185502.8789-12-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.714.ge3da0db
In-Reply-To: <20161028185502.8789-1-sbeller@google.com>
References: <20161028185502.8789-1-sbeller@google.com>
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
index 2dc8d6ca57..11e3951371 100644
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
index ff7f0a59eb..20d64b34f4 100644
--- a/attr.c
+++ b/attr.c
@@ -833,3 +833,37 @@ void git_attr_set_direction(enum git_attr_direction new, struct index_state *ist
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
index dd3c4a3aef..3fd8690749 100644
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
2.10.1.714.ge3da0db

