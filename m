From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH/RFC v2 2/2] Reduce parse-options.o dependencies
Date: Sun,  3 Jul 2011 17:04:05 +0600
Message-ID: <1309691045-30180-2-git-send-email-divanorama@gmail.com>
References: <20110629202959.GJ22556@elie>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 03 13:03:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QdKSN-0003wo-Ah
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jul 2011 13:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755790Ab1GCLDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jul 2011 07:03:07 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59696 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755658Ab1GCLDC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2011 07:03:02 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so3507998bwd.19
        for <git@vger.kernel.org>; Sun, 03 Jul 2011 04:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=JMTpNdbgCUE1iizQA13JxNQ34GgEJ3OtR7CHr2/wuy0=;
        b=D+LSCouJM/N0Ou/uOPgEvJTJHJIA87i/Kei7d+VVTjYq2Jr0eO+LbNcbkfZsiX1ktP
         6Y5J5lJGKGle9k1WZ10ipEQmmZpfIrK2uucDpkHa+SdkdzKoJCUoMsR3Ixv53nQyzXDH
         Rcm0Qq05V9cUZTgBV8TgR5H2LepRsn0hGj+nk=
Received: by 10.204.19.19 with SMTP id y19mr4536594bka.164.1309690981273;
        Sun, 03 Jul 2011 04:03:01 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id n3sm4598570bka.16.2011.07.03.04.02.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Jul 2011 04:03:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <20110629202959.GJ22556@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176573>

Currently parse-options.o pulls quite a big bunch
of dependencies. This complicates it's usage in
contrib/ because it pulls external dependencies
and it also increases executables size.

Split off less generic and more internal to git
part of parse-options.c to parse-options-cb.c.

Move prefix_filename function from setup.c to
abspath.c. abspath.o and wrapper.o pull each other,
so it's unlikely to increase the dependencies.
It was a dependency of parse-options.o that pulled
many others.

Now parse-options.o pulls just abspath.o, ctype.o,
strbuf.o, usage.o, wrapper.o, libc directly and
strlcpy.o indirectly.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 Makefile           |    3 +-
 abspath.c          |   28 +++++++++++++
 parse-options-cb.c |  108 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 parse-options.c    |  104 --------------------------------------------------
 setup.c            |   28 -------------
 5 files changed, 138 insertions(+), 133 deletions(-)
 create mode 100644 parse-options-cb.c

diff --git a/Makefile b/Makefile
index e954dff..0a46a99 100644
--- a/Makefile
+++ b/Makefile
@@ -631,6 +631,7 @@ LIB_OBJS += pack-revindex.o
 LIB_OBJS += pack-write.o
 LIB_OBJS += pager.o
 LIB_OBJS += parse-options.o
+LIB_OBJS += parse-options-cb.o
 LIB_OBJS += patch-delta.o
 LIB_OBJS += patch-ids.o
 LIB_OBJS += path.o
@@ -2168,7 +2169,7 @@ test-delta$X: diff-delta.o patch-delta.o
 
 test-line-buffer$X: vcs-svn/lib.a
 
-test-parse-options$X: parse-options.o
+test-parse-options$X: parse-options.o parse-options-git.o
 
 test-svn-fe$X: vcs-svn/lib.a
 
diff --git a/abspath.c b/abspath.c
index 3005aed..aabc383 100644
--- a/abspath.c
+++ b/abspath.c
@@ -138,3 +138,31 @@ const char *absolute_path(const char *path)
 	}
 	return buf;
 }
+
+/*
+ * Unlike prefix_path, this should be used if the named file does
+ * not have to interact with index entry; i.e. name of a random file
+ * on the filesystem.
+ */
+const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
+{
+	static char path[PATH_MAX];
+#ifndef WIN32
+	if (!pfx_len || is_absolute_path(arg))
+		return arg;
+	memcpy(path, pfx, pfx_len);
+	strcpy(path + pfx_len, arg);
+#else
+	char *p;
+	/* don't add prefix to absolute paths, but still replace '\' by '/' */
+	if (is_absolute_path(arg))
+		pfx_len = 0;
+	else if (pfx_len)
+		memcpy(path, pfx, pfx_len);
+	strcpy(path + pfx_len, arg);
+	for (p = path + pfx_len; *p; p++)
+		if (*p == '\\')
+			*p = '/';
+#endif
+	return path;
+}
diff --git a/parse-options-cb.c b/parse-options-cb.c
new file mode 100644
index 0000000..0ddfcd9
--- /dev/null
+++ b/parse-options-cb.c
@@ -0,0 +1,108 @@
+#include "git-compat-util.h"
+#include "parse-options.h"
+#include "cache.h"
+#include "commit.h"
+#include "color.h"
+
+/*----- some often used options -----*/
+
+int parse_opt_abbrev_cb(const struct option *opt, const char *arg, int unset)
+{
+	int v;
+
+	if (!arg) {
+		v = unset ? 0 : DEFAULT_ABBREV;
+	} else {
+		v = strtol(arg, (char **)&arg, 10);
+		if (*arg)
+			return opterror(opt, "expects a numerical value", 0);
+		if (v && v < MINIMUM_ABBREV)
+			v = MINIMUM_ABBREV;
+		else if (v > 40)
+			v = 40;
+	}
+	*(int *)(opt->value) = v;
+	return 0;
+}
+
+int parse_opt_approxidate_cb(const struct option *opt, const char *arg,
+			     int unset)
+{
+	*(unsigned long *)(opt->value) = approxidate(arg);
+	return 0;
+}
+
+int parse_opt_color_flag_cb(const struct option *opt, const char *arg,
+			    int unset)
+{
+	int value;
+
+	if (!arg)
+		arg = unset ? "never" : (const char *)opt->defval;
+	value = git_config_colorbool(NULL, arg, -1);
+	if (value < 0)
+		return opterror(opt,
+			"expects \"always\", \"auto\", or \"never\"", 0);
+	*(int *)opt->value = value;
+	return 0;
+}
+
+int parse_opt_verbosity_cb(const struct option *opt, const char *arg,
+			   int unset)
+{
+	int *target = opt->value;
+
+	if (unset)
+		/* --no-quiet, --no-verbose */
+		*target = 0;
+	else if (opt->short_name == 'v') {
+		if (*target >= 0)
+			(*target)++;
+		else
+			*target = 1;
+	} else {
+		if (*target <= 0)
+			(*target)--;
+		else
+			*target = -1;
+	}
+	return 0;
+}
+
+int parse_opt_with_commit(const struct option *opt, const char *arg, int unset)
+{
+	unsigned char sha1[20];
+	struct commit *commit;
+
+	if (!arg)
+		return -1;
+	if (get_sha1(arg, sha1))
+		return error("malformed object name %s", arg);
+	commit = lookup_commit_reference(sha1);
+	if (!commit)
+		return error("no such commit %s", arg);
+	commit_list_insert(commit, opt->value);
+	return 0;
+}
+
+int parse_opt_tertiary(const struct option *opt, const char *arg, int unset)
+{
+	int *target = opt->value;
+	*target = unset ? 2 : 1;
+	return 0;
+}
+
+int parse_options_concat(struct option *dst, size_t dst_size, struct option *src)
+{
+	int i, j;
+
+	for (i = 0; i < dst_size; i++)
+		if (dst[i].type == OPTION_END)
+			break;
+	for (j = 0; i < dst_size; i++, j++) {
+		dst[i] = src[j];
+		if (src[j].type == OPTION_END)
+			return 0;
+	}
+	return -1;
+}
diff --git a/parse-options.c b/parse-options.c
index 37a1d3b..503ab5d 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -583,107 +583,3 @@ static int parse_options_usage(struct parse_opt_ctx_t *ctx,
 	return usage_with_options_internal(ctx, usagestr, opts, 0, err);
 }
 
-
-/*----- some often used options -----*/
-#include "cache.h"
-
-int parse_opt_abbrev_cb(const struct option *opt, const char *arg, int unset)
-{
-	int v;
-
-	if (!arg) {
-		v = unset ? 0 : DEFAULT_ABBREV;
-	} else {
-		v = strtol(arg, (char **)&arg, 10);
-		if (*arg)
-			return opterror(opt, "expects a numerical value", 0);
-		if (v && v < MINIMUM_ABBREV)
-			v = MINIMUM_ABBREV;
-		else if (v > 40)
-			v = 40;
-	}
-	*(int *)(opt->value) = v;
-	return 0;
-}
-
-int parse_opt_approxidate_cb(const struct option *opt, const char *arg,
-			     int unset)
-{
-	*(unsigned long *)(opt->value) = approxidate(arg);
-	return 0;
-}
-
-int parse_opt_color_flag_cb(const struct option *opt, const char *arg,
-			    int unset)
-{
-	int value;
-
-	if (!arg)
-		arg = unset ? "never" : (const char *)opt->defval;
-	value = git_config_colorbool(NULL, arg, -1);
-	if (value < 0)
-		return opterror(opt,
-			"expects \"always\", \"auto\", or \"never\"", 0);
-	*(int *)opt->value = value;
-	return 0;
-}
-
-int parse_opt_verbosity_cb(const struct option *opt, const char *arg,
-			   int unset)
-{
-	int *target = opt->value;
-
-	if (unset)
-		/* --no-quiet, --no-verbose */
-		*target = 0;
-	else if (opt->short_name == 'v') {
-		if (*target >= 0)
-			(*target)++;
-		else
-			*target = 1;
-	} else {
-		if (*target <= 0)
-			(*target)--;
-		else
-			*target = -1;
-	}
-	return 0;
-}
-
-int parse_opt_with_commit(const struct option *opt, const char *arg, int unset)
-{
-	unsigned char sha1[20];
-	struct commit *commit;
-
-	if (!arg)
-		return -1;
-	if (get_sha1(arg, sha1))
-		return error("malformed object name %s", arg);
-	commit = lookup_commit_reference(sha1);
-	if (!commit)
-		return error("no such commit %s", arg);
-	commit_list_insert(commit, opt->value);
-	return 0;
-}
-
-int parse_opt_tertiary(const struct option *opt, const char *arg, int unset)
-{
-	int *target = opt->value;
-	*target = unset ? 2 : 1;
-	return 0;
-}
-
-int parse_options_concat(struct option *dst, size_t dst_size, struct option *src)
-{
-	int i, j;
-
-	for (i = 0; i < dst_size; i++)
-		if (dst[i].type == OPTION_END)
-			break;
-	for (j = 0; i < dst_size; i++, j++) {
-		dst[i] = src[j];
-		if (src[j].type == OPTION_END)
-			return 0;
-	}
-	return -1;
-}
diff --git a/setup.c b/setup.c
index 03cd84f..fc593bf 100644
--- a/setup.c
+++ b/setup.c
@@ -40,34 +40,6 @@ char *prefix_path(const char *prefix, int len, const char *path)
 	return sanitized;
 }
 
-/*
- * Unlike prefix_path, this should be used if the named file does
- * not have to interact with index entry; i.e. name of a random file
- * on the filesystem.
- */
-const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
-{
-	static char path[PATH_MAX];
-#ifndef WIN32
-	if (!pfx_len || is_absolute_path(arg))
-		return arg;
-	memcpy(path, pfx, pfx_len);
-	strcpy(path + pfx_len, arg);
-#else
-	char *p;
-	/* don't add prefix to absolute paths, but still replace '\' by '/' */
-	if (is_absolute_path(arg))
-		pfx_len = 0;
-	else if (pfx_len)
-		memcpy(path, pfx, pfx_len);
-	strcpy(path + pfx_len, arg);
-	for (p = path + pfx_len; *p; p++)
-		if (*p == '\\')
-			*p = '/';
-#endif
-	return path;
-}
-
 int check_filename(const char *prefix, const char *arg)
 {
 	const char *name;
-- 
1.7.3.4
