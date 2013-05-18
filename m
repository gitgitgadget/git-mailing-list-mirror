From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v12 06/15] git-clean: refactor git-clean into two phases
Date: Sat, 18 May 2013 11:18:58 +0800
Message-ID: <271643036271eeaadb6b65c223905771be4bef71.1368846844.git.worldhello.net@gmail.com>
References: <cover.1368846844.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 18 05:19:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdXgW-0004GC-1v
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 05:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518Ab3ERDTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 23:19:47 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33828 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932387Ab3ERDTp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 23:19:45 -0400
Received: by mail-pa0-f51.google.com with SMTP id ld10so4126426pab.10
        for <git@vger.kernel.org>; Fri, 17 May 2013 20:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=PNDfoLSO1e75XBPTFIVNX3HeGW21JfIkfin0gzgxylw=;
        b=ejmCxMiEr4bDXZC6uaaWaqeJndjIHJz9MSGDtn9TQ+/VQBEf83kD643lz+mG9e2tME
         o4iBt7cFaTwMjP0lnT9SQ0xsiyW2WmsIzQZHvNkWJpG2jYm7fVYiKyNe47Fq8LGvyFD4
         PmKsXjaEfYQ+6HJtYa7xPD6Oi5djZitMzJ07s0HeXIxhn6MzSZNStrpyLd44YapQ+ljM
         dLOvDNzdbxjPK8I8DJgfvLTQODmiDnJBDC9vcVfbqfazprxqmktlScYDpyjborX5tumT
         rWq6GCjhFXPwW28CZbkEtmj3m8eMOfjy9DskEDxWUiJ8CisvsPp+vzygSSVxoZ5QSWfL
         QgUA==
X-Received: by 10.68.202.34 with SMTP id kf2mr50409663pbc.56.1368847184471;
        Fri, 17 May 2013 20:19:44 -0700 (PDT)
Received: from localhost.localdomain ([114.248.155.144])
        by mx.google.com with ESMTPSA id fn2sm13676683pbc.15.2013.05.17.20.19.41
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 May 2013 20:19:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.26.g7472058
In-Reply-To: <cover.1368846844.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368846844.git.worldhello.net@gmail.com>
References: <cover.1368782129.git.worldhello.net@gmail.com> <cover.1368846844.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224761>

Before introducing interactive git-clean, refactor git-clean operations
into two phases:

 * hold cleaning items in del_list,
 * and remove them in a separate loop at the end.

We will introduce interactive git-clean between the two phases. The
interactive git-clean will show what would be done and must confirm
before do real cleaning.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/clean.c | 64 ++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index f77f95..23e1f 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -15,6 +15,7 @@
 #include "quote.h"
 
 static int force = -1; /* unset */
+static struct string_list del_list = STRING_LIST_INIT_DUP;
 
 static const char *const builtin_clean_usage[] = {
 	N_("git clean [-d] [-f] [-n] [-q] [-e <pattern>] [-x | -X] [--] <paths>..."),
@@ -148,12 +149,13 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
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
@@ -223,6 +225,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		int matches = 0;
 		struct cache_entry *ce;
 		struct stat st;
+		const char *rel;
 
 		/*
 		 * Remove the '/' at the end that directory
@@ -242,13 +245,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 				continue; /* Yup, this one exists unmerged */
 		}
 
-		/*
-		 * we might have removed this as part of earlier
-		 * recursive directory removal, so lstat() here could
-		 * fail with ENOENT.
-		 */
 		if (lstat(ent->name, &st))
-			continue;
+			die_errno("Cannot lstat '%s'", ent->name);
 
 		if (pathspec) {
 			memset(seen, 0, argc > 0 ? argc : 1);
@@ -257,33 +255,61 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		}
 
 		if (S_ISDIR(st.st_mode)) {
-			strbuf_addstr(&directory, ent->name);
 			if (remove_directories || (matches == MATCHED_EXACTLY)) {
-				if (remove_dirs(&directory, prefix, rm_flags, dry_run, quiet, &gone))
-					errors++;
-				if (gone && !quiet) {
-					qname = quote_path_relative(directory.buf, prefix, &buf);
-					printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
-				}
+				rel = relative_path(ent->name, prefix, &buf);
+				string_list_append(&del_list, rel);
 			}
-			strbuf_reset(&directory);
 		} else {
 			if (pathspec && !matches)
 				continue;
-			res = dry_run ? 0 : unlink(ent->name);
+			rel = relative_path(ent->name, prefix, &buf);
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
+				qname = quote_path_relative(item->string, NULL, &buf);
+				printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
+			}
+		} else {
+			res = dry_run ? 0 : unlink(abs_path.buf);
 			if (res) {
-				qname = quote_path_relative(ent->name, prefix, &buf);
+				qname = quote_path_relative(item->string, NULL, &buf);
 				warning(_(msg_warn_remove_failed), qname);
 				errors++;
 			} else if (!quiet) {
-				qname = quote_path_relative(ent->name, prefix, &buf);
+				qname = quote_path_relative(item->string, NULL, &buf);
 				printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
 			}
 		}
+		strbuf_reset(&abs_path);
 	}
 	free(seen);
 
-	strbuf_release(&directory);
+	strbuf_release(&abs_path);
+	strbuf_release(&buf);
+	string_list_clear(&del_list, 0);
 	string_list_clear(&exclude_list, 0);
 	return (errors != 0);
 }
-- 
1.8.3.rc2.26.g7472058
