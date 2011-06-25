From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH/RFC] Reduce parse-options.o dependencies
Date: Sat, 25 Jun 2011 17:12:14 +0600
Message-ID: <1309000334-31980-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 25 13:11:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QaQlw-00018W-HB
	for gcvg-git-2@lo.gmane.org; Sat, 25 Jun 2011 13:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558Ab1FYLL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jun 2011 07:11:27 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49564 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348Ab1FYLL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2011 07:11:26 -0400
Received: by bwd5 with SMTP id 5so323735bwd.19
        for <git@vger.kernel.org>; Sat, 25 Jun 2011 04:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=3S9Go3CwFFb4t0OeGbpr2hCwcWVqyORhNIWQnEuj2CQ=;
        b=hafFd8+bzMTndCB//1uM3viCEVm13Hmq3Fj6JX5pAptq0rQS1bUQfvTzHo4u3apMmw
         AMgVEijib4uAMgGk5IMONTlWWaajs8fV6dG+yYlQwWLvciOYaiaoevdhbkBYsGOMncVT
         8okuydIapVruhYGTZD7C9OgCWXN5mzay5MQHY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=nCECG/9tt5ZCyrY8cvUE7AuI38mEZR3JfsatQw4AwkxVzbpfYGchrIGTi07o5L0SFz
         boHANknbLEgs56NXmEoqElExyPn/6nylwxfQ/h8M9UeC37DPPLOdZyRqvR6hy2JFa/r1
         SAQ9jaVbodNaT5Yu6Scl7gUETEHD4EYWICReE=
Received: by 10.205.35.1 with SMTP id su1mr2771112bkb.129.1309000284721;
        Sat, 25 Jun 2011 04:11:24 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id v6sm2416859bkf.11.2011.06.25.04.11.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 25 Jun 2011 04:11:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176318>

Currently parse-options.o pulls quite a big bunch
of dependencies. This complicates it's usage in
contrib/ because it pulls external dependencies
and it also increases executables size.

Split off less generic and more internal to git
part of parse-options.c to parse-options-git.c.
Declare optbug and opterror as extern as they are
shared between these parts and also may be used
elsewhere.

Move prefix_function from setup.c to abspath.c.
abspath.o and wrapper.o pull each other, so it's
unlikely to increase the dependencies. It was a
dependency of parse-options.o that pulled many
others.

Now parse-options.o pulls just abspath.o, ctype.o,
strbuf.o, usage.o, wrapper.o, libc directly and
strlcpy.o indirectly.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 Makefile            |    3 +-
 abspath.c           |   28 +++++++++++++
 parse-options-git.c |  108 +++++++++++++++++++++++++++++++++++++++++++++++++++
 parse-options.c     |  108 +--------------------------------------------------
 parse-options.h     |    3 +
 setup.c             |   28 -------------
 6 files changed, 143 insertions(+), 135 deletions(-)
 create mode 100644 parse-options-git.c

diff --git a/Makefile b/Makefile
index e954dff..24ecefa 100644
--- a/Makefile
+++ b/Makefile
@@ -631,6 +631,7 @@ LIB_OBJS += pack-revindex.o
 LIB_OBJS += pack-write.o
 LIB_OBJS += pager.o
 LIB_OBJS += parse-options.o
+LIB_OBJS += parse-options-git.o
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
diff --git a/parse-options-git.c b/parse-options-git.c
new file mode 100644
index 0000000..0ddfcd9
--- /dev/null
+++ b/parse-options-git.c
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
index 73bd28a..503ab5d 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -11,14 +11,14 @@ static int parse_options_usage(struct parse_opt_ctx_t *ctx,
 #define OPT_SHORT 1
 #define OPT_UNSET 2
 
-static int optbug(const struct option *opt, const char *reason)
+int optbug(const struct option *opt, const char *reason)
 {
 	if (opt->long_name)
 		return error("BUG: option '%s' %s", opt->long_name, reason);
 	return error("BUG: switch '%c' %s", opt->short_name, reason);
 }
 
-static int opterror(const struct option *opt, const char *reason, int flags)
+int opterror(const struct option *opt, const char *reason, int flags)
 {
 	if (flags & OPT_SHORT)
 		return error("switch `%c' %s", opt->short_name, reason);
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
diff --git a/parse-options.h b/parse-options.h
index d1b12fe..a62c6c3 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -147,6 +147,9 @@ struct option {
 		parse_opt_color_flag_cb, (intptr_t)"always" }
 
 
+extern int optbug(const struct option *opt, const char *reason);
+extern int opterror(const struct option *opt, const char *reason, int flags);
+
 /* parse_options() will filter out the processed options and leave the
  * non-option arguments in argv[].
  * Returns the number of arguments left in argv[].
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
