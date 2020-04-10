Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A861EC2D0EC
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 19:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B242083E
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 19:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgDJTo3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:44:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:40066 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726177AbgDJTo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 15:44:28 -0400
Received: (qmail 7633 invoked by uid 109); 10 Apr 2020 19:44:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Apr 2020 19:44:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2211 invoked by uid 111); 10 Apr 2020 19:55:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Apr 2020 15:55:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Apr 2020 15:44:28 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/6] parse_config_key(): return subsection len as size_t
Message-ID: <20200410194428.GB1363756@coredump.intra.peff.net>
References: <20200410194211.GA1363484@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200410194211.GA1363484@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We return the length to a subset of a string using an "int *"
out-parameter. This is fine most of the time, as we'd expect config keys
to be relatively short, but it could behave oddly if we had a gigantic
config key. A more appropriate type is size_t.

Let's switch over, which lets our callers use size_t as appropriate
(they are bound by our type because they must pass the out-parameter as
a pointer). This is mostly just a cleanup to make it clear this code
handles long strings correctly. In practice, our config parser already
chokes on long key names (because of a similar int/size_t mixup!).

When doing an int/size_t conversion, we have to be careful that nobody
was trying to assign a negative value to the variable. I manually
confirmed that for each case here. They tend to just feed the result to
xmemdupz() or similar; in a few cases I adjusted the parameter types for
helper functions to make sure the size_t is preserved.

Signed-off-by: Jeff King <peff@peff.net>
---
 archive-tar.c      | 4 ++--
 builtin/help.c     | 2 +-
 builtin/reflog.c   | 2 +-
 config.c           | 4 ++--
 config.h           | 2 +-
 convert.c          | 2 +-
 fsck.c             | 2 +-
 ll-merge.c         | 2 +-
 promisor-remote.c  | 2 +-
 remote.c           | 2 +-
 submodule-config.c | 3 ++-
 userdiff.c         | 4 ++--
 12 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 5a77701a15..5ceec3684b 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -364,7 +364,7 @@ static struct archiver **tar_filters;
 static int nr_tar_filters;
 static int alloc_tar_filters;
 
-static struct archiver *find_tar_filter(const char *name, int len)
+static struct archiver *find_tar_filter(const char *name, size_t len)
 {
 	int i;
 	for (i = 0; i < nr_tar_filters; i++) {
@@ -380,7 +380,7 @@ static int tar_filter_config(const char *var, const char *value, void *data)
 	struct archiver *ar;
 	const char *name;
 	const char *type;
-	int namelen;
+	size_t namelen;
 
 	if (parse_config_key(var, "tar", &name, &namelen, &type) < 0 || !name)
 		return 0;
diff --git a/builtin/help.c b/builtin/help.c
index e5590d7787..c024110531 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -242,7 +242,7 @@ static int add_man_viewer_cmd(const char *name,
 static int add_man_viewer_info(const char *var, const char *value)
 {
 	const char *name, *subkey;
-	int namelen;
+	size_t namelen;
 
 	if (parse_config_key(var, "man", &name, &namelen, &subkey) < 0 || !name)
 		return 0;
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 81dfd563c0..52ecf6d43c 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -459,7 +459,7 @@ static struct reflog_expire_cfg *find_cfg_ent(const char *pattern, size_t len)
 static int reflog_expire_config(const char *var, const char *value, void *cb)
 {
 	const char *pattern, *key;
-	int pattern_len;
+	size_t pattern_len;
 	timestamp_t expire;
 	int slot;
 	struct reflog_expire_cfg *ent;
diff --git a/config.c b/config.c
index d17d2bd9dc..ff7998df46 100644
--- a/config.c
+++ b/config.c
@@ -309,7 +309,7 @@ int git_config_include(const char *var, const char *value, void *data)
 {
 	struct config_include_data *inc = data;
 	const char *cond, *key;
-	int cond_len;
+	size_t cond_len;
 	int ret;
 
 	/*
@@ -3238,7 +3238,7 @@ int config_error_nonbool(const char *var)
 
 int parse_config_key(const char *var,
 		     const char *section,
-		     const char **subsection, int *subsection_len,
+		     const char **subsection, size_t *subsection_len,
 		     const char **key)
 {
 	const char *dot;
diff --git a/config.h b/config.h
index 9b3773f778..d57df283b3 100644
--- a/config.h
+++ b/config.h
@@ -359,7 +359,7 @@ int git_config_include(const char *name, const char *value, void *data);
  */
 int parse_config_key(const char *var,
 		     const char *section,
-		     const char **subsection, int *subsection_len,
+		     const char **subsection, size_t *subsection_len,
 		     const char **key);
 
 /**
diff --git a/convert.c b/convert.c
index 5aa87d45e3..572449825c 100644
--- a/convert.c
+++ b/convert.c
@@ -1018,7 +1018,7 @@ static int apply_filter(const char *path, const char *src, size_t len,
 static int read_convert_config(const char *var, const char *value, void *cb)
 {
 	const char *key, *name;
-	int namelen;
+	size_t namelen;
 	struct convert_driver *drv;
 
 	/*
diff --git a/fsck.c b/fsck.c
index 640d813d84..41031e459b 100644
--- a/fsck.c
+++ b/fsck.c
@@ -920,7 +920,7 @@ static int fsck_gitmodules_fn(const char *var, const char *value, void *vdata)
 {
 	struct fsck_gitmodules_data *data = vdata;
 	const char *subsection, *key;
-	int subsection_len;
+	size_t subsection_len;
 	char *name;
 
 	if (parse_config_key(var, "submodule", &subsection, &subsection_len, &key) < 0 ||
diff --git a/ll-merge.c b/ll-merge.c
index d65a8971db..1ec0b959e0 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -247,7 +247,7 @@ static int read_merge_config(const char *var, const char *value, void *cb)
 {
 	struct ll_merge_driver *fn;
 	const char *key, *name;
-	int namelen;
+	size_t namelen;
 
 	if (!strcmp(var, "merge.default"))
 		return git_config_string(&default_ll_merge, var, value);
diff --git a/promisor-remote.c b/promisor-remote.c
index 9f338c945f..ff8721fd56 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -101,7 +101,7 @@ static void promisor_remote_move_to_tail(struct promisor_remote *r,
 static int promisor_remote_config(const char *var, const char *value, void *data)
 {
 	const char *name;
-	int namelen;
+	size_t namelen;
 	const char *subkey;
 
 	if (!strcmp(var, "core.partialclonefilter"))
diff --git a/remote.c b/remote.c
index 35bc3f9f2d..534c6426f1 100644
--- a/remote.c
+++ b/remote.c
@@ -305,7 +305,7 @@ static void read_branches_file(struct remote *remote)
 static int handle_config(const char *key, const char *value, void *cb)
 {
 	const char *name;
-	int namelen;
+	size_t namelen;
 	const char *subkey;
 	struct remote *remote;
 	struct branch *branch;
diff --git a/submodule-config.c b/submodule-config.c
index 4d1c92d582..e175dfbc38 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -225,7 +225,8 @@ static int name_and_item_from_var(const char *var, struct strbuf *name,
 				  struct strbuf *item)
 {
 	const char *subsection, *key;
-	int subsection_len, parse;
+	size_t subsection_len;
+	int parse;
 	parse = parse_config_key(var, "submodule", &subsection,
 			&subsection_len, &key);
 	if (parse < 0 || !subsection)
diff --git a/userdiff.c b/userdiff.c
index efbe05e5a5..30ab42df8e 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -222,7 +222,7 @@ static struct userdiff_driver driver_false = {
 	{ NULL, 0 }
 };
 
-static struct userdiff_driver *userdiff_find_by_namelen(const char *k, int len)
+static struct userdiff_driver *userdiff_find_by_namelen(const char *k, size_t len)
 {
 	int i;
 	for (i = 0; i < ndrivers; i++) {
@@ -266,7 +266,7 @@ int userdiff_config(const char *k, const char *v)
 {
 	struct userdiff_driver *drv;
 	const char *name, *type;
-	int namelen;
+	size_t namelen;
 
 	if (parse_config_key(k, "diff", &name, &namelen, &type) || !name)
 		return 0;
-- 
2.26.0.414.ge3a6455e3d

