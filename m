From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v9 1/9] git-clean: refactor git-clean into two phases
Date: Tue, 14 May 2013 16:45:15 +0800
Message-ID: <7c551bf22bc45cfcdd62d1baf6300f3f86244312.1368518327.git.worldhello.net@gmail.com>
References: <cover.1368518327.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 14 10:46:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcAsE-00030F-GU
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 10:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756932Ab3ENIqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 04:46:00 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:36482 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756719Ab3ENIpv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 04:45:51 -0400
Received: by mail-pb0-f53.google.com with SMTP id un1so235734pbc.26
        for <git@vger.kernel.org>; Tue, 14 May 2013 01:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=qGQVGcatIsKbVGTrqb/rQmOs/dW4RbkfKZqc5xOroLs=;
        b=0BkM8ygCh+1WhrPDkzyXungX8SjdXcdDqKB0jgDLYB/DOeIbJkbLPsfrSE5nDu6ETE
         Ipmd+lNwihut7VnPYBLDwlS7YJbG8v1JoXdV6KzVk8/iqmw++mKK1gXd3/Wy67m2Sl65
         qRgTOx7ktAvjn8CNl4ub7wR0kXOD2YpjN3bath4N0rZmutqp65cNGIQ1OCOjshRvWhPN
         KTerf2U1/ozqh+0MXTLs8kPAlpgD0ke3T7PExnKcMFSKfT+lXY2P6HlIcSsgX/VRp+NN
         JAua3N1CSkEk7jGdts1cCf4DDN2a5uFxwq/rxbAdF0mtG8c+VUnKbsQYC544NRmLA7bb
         gZ+w==
X-Received: by 10.66.20.7 with SMTP id j7mr33732974pae.142.1368521151000;
        Tue, 14 May 2013 01:45:51 -0700 (PDT)
Received: from localhost.localdomain ([114.248.141.128])
        by mx.google.com with ESMTPSA id wt5sm17356069pbc.38.2013.05.14.01.45.47
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 14 May 2013 01:45:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.401.gfc9adf8
In-Reply-To: <cover.1368518327.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368518327.git.worldhello.net@gmail.com>
References: <cover.1368518327.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224288>

Before introducing interactive git-clean, refactor git-clean operations
into two phases:

 * hold cleaning items in del_list,
 * and remove them in a separate loop at the end.

We will introduce interactive git-clean between the two phases. The
interactive git-clean will show what would be done and must confirm
before do real cleaning.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/clean.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 85 insertions(+), 18 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 04e39..ccd4 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -15,6 +15,7 @@
 #include "quote.h"
 
 static int force = -1; /* unset */
+static struct string_list del_list = STRING_LIST_INIT_DUP;
 
 static const char *const builtin_clean_usage[] = {
 	N_("git clean [-d] [-f] [-n] [-q] [-e <pattern>] [-x | -X] [--] <paths>..."),
@@ -142,18 +143,61 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 	return ret;
 }
 
+/*
+ * Give path as relative to prefix.
+ *
+ * This function is a combination of path_relative (in quote.c) and
+ * relative_path (in path.c)
+ */
+static const char *path_relative(const char *in, const char *prefix)
+{
+	static char buf[PATH_MAX + 1];
+	int off, i;
+	int len, prefix_len;
+
+	len = strlen(in);
+	if (prefix)
+		prefix_len = strlen(prefix);
+	else
+		prefix_len = 0;
+
+	off = 0;
+	i = 0;
+	while (i < prefix_len && i < len && prefix[i] == in[i]) {
+		if (prefix[i] == '/')
+			off = i + 1;
+		i++;
+	}
+	in += off;
+	len -= off;
+
+	if (i >= prefix_len)
+		return in;
+
+	buf[0] = '\0';
+	while (i < prefix_len) {
+		if (prefix[i] == '/')
+			strcat(buf, "../");
+		i++;
+	}
+	strcat(buf, in);
+
+	return buf;
+}
+
 int cmd_clean(int argc, const char **argv, const char *prefix)
 {
 	int i, res;
 	int dry_run = 0, remove_directories = 0, quiet = 0, ignored = 0;
 	int ignored_only = 0, config_set = 0, errors = 0, gone = 1;
 	int rm_flags = REMOVE_DIR_KEEP_NESTED_GIT;
-	struct strbuf directory = STRBUF_INIT;
+	struct strbuf abs_path = STRBUF_INIT;
 	struct dir_struct dir;
 	static const char **pathspec;
 	struct strbuf buf = STRBUF_INIT;
 	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
 	struct exclude_list *el;
+	struct string_list_item *item;
 	const char *qname;
 	char *seen = NULL;
 	struct option options[] = {
@@ -223,6 +267,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		int matches = 0;
 		struct cache_entry *ce;
 		struct stat st;
+		const char *rel;
 
 		/*
 		 * Remove the '/' at the end that directory
@@ -242,11 +287,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 				continue; /* Yup, this one exists unmerged */
 		}
 
-		/*
-		 * we might have removed this as part of earlier
-		 * recursive directory removal, so lstat() here could
-		 * fail with ENOENT.
-		 */
 		if (lstat(ent->name, &st))
 			continue;
 
@@ -257,33 +297,60 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		}
 
 		if (S_ISDIR(st.st_mode)) {
-			strbuf_addstr(&directory, ent->name);
 			if (remove_directories || (matches == MATCHED_EXACTLY)) {
-				if (remove_dirs(&directory, prefix, rm_flags, dry_run, quiet, &gone))
-					errors++;
-				if (gone && !quiet) {
-					qname = quote_path_relative(directory.buf, directory.len, &buf, prefix);
-					printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
-				}
+				rel = path_relative(ent->name, prefix);
+				string_list_append(&del_list, rel);
 			}
-			strbuf_reset(&directory);
 		} else {
 			if (pathspec && !matches)
 				continue;
-			res = dry_run ? 0 : unlink(ent->name);
+			rel = path_relative(ent->name, prefix);
+			string_list_append(&del_list, rel);
+		}
+	}
+
+	/* TODO: do interactive git-clean here, which will modify del_list */
+
+	for_each_string_list_item(item, &del_list) {
+		struct stat st;
+
+		if (prefix) {
+			strbuf_addstr(&abs_path, prefix);
+		}
+		strbuf_addstr(&abs_path, item->string);
+
+		/*
+		 * we might have removed this as part of earlier
+		 * recursive directory removal, so lstat() here could
+		 * fail with ENOENT.
+		 */
+		if (lstat(abs_path.buf, &st))
+			continue;
+
+		if (S_ISDIR(st.st_mode)) {
+			if (remove_dirs(&abs_path, prefix, rm_flags, dry_run, quiet, &gone))
+				errors++;
+			if (gone && !quiet) {
+				qname = quote_path_relative(item->string, -1, &buf, NULL);
+				printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
+			}
+		} else {
+			res = dry_run ? 0 : unlink(abs_path.buf);
 			if (res) {
-				qname = quote_path_relative(ent->name, -1, &buf, prefix);
+				qname = quote_path_relative(item->string, -1, &buf, NULL);
 				warning(_(msg_warn_remove_failed), qname);
 				errors++;
 			} else if (!quiet) {
-				qname = quote_path_relative(ent->name, -1, &buf, prefix);
+				qname = quote_path_relative(item->string, -1, &buf, NULL);
 				printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
 			}
 		}
+		strbuf_reset(&abs_path);
 	}
 	free(seen);
 
-	strbuf_release(&directory);
+	strbuf_release(&abs_path);
+	string_list_clear(&del_list, 0);
 	string_list_clear(&exclude_list, 0);
 	return (errors != 0);
 }
-- 
1.8.3.rc1.404.gb9fcf3e
