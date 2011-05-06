From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3] rerere: Expose an API corresponding to 'clear' functionality
Date: Fri,  6 May 2011 12:06:53 +0530
Message-ID: <1304663813-27724-1-git-send-email-artagnon@gmail.com>
References: <20110413203843.GC30630@elie>
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 06 08:37:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIEes-0007eo-6k
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 08:37:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580Ab1EFGg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 02:36:57 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:25674 "EHLO
	smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159Ab1EFGg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 02:36:56 -0400
X-IronPort-AV: E=Sophos;i="4.64,325,1301875200"; 
   d="scan'208";a="72640604"
Received: from smtp-in-1105.vdc.amazon.com ([10.140.9.24])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 May 2011 06:36:55 +0000
Received: from ramkum.desktop.amazon.com (ramkum.desktop.amazon.com [172.25.205.64])
	by smtp-in-1105.vdc.amazon.com (8.13.8/8.13.8) with ESMTP id p466as5g021029;
	Fri, 6 May 2011 06:36:54 GMT
Received: by ramkum.desktop.amazon.com (Postfix, from userid 272482)
	id 9236175472E; Fri,  6 May 2011 12:06:53 +0530 (IST)
X-Mailer: git-send-email 1.7.5.GIT
In-Reply-To: <20110413203843.GC30630@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172947>

Libify the "rerere clear" into a simple function called rerere_clear
that takes no arguments, and returns the exit status.  Also export
unlink_rr_item as unlink_rerere_item so rerere_clear and the
un-libified "git rerere gc" can both use it.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 What changed since v2: Jonathan's review.

 builtin/rerere.c |   21 ++++-----------------
 rerere.c         |   27 +++++++++++++++++++++++++++
 rerere.h         |    2 ++
 3 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 8235885..8f939b3 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -28,14 +28,6 @@ static time_t rerere_last_used_at(const char *name)
 	return stat(rerere_path(name, "postimage"), &st) ? (time_t) 0 : st.st_mtime;
 }
 
-static void unlink_rr_item(const char *name)
-{
-	unlink(rerere_path(name, "thisimage"));
-	unlink(rerere_path(name, "preimage"));
-	unlink(rerere_path(name, "postimage"));
-	rmdir(git_path("rr-cache/%s", name));
-}
-
 static int git_rerere_gc_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "gc.rerereresolved"))
@@ -76,7 +68,7 @@ static void garbage_collect(struct string_list *rr)
 			string_list_append(&to_remove, e->d_name);
 	}
 	for (i = 0; i < to_remove.nr; i++)
-		unlink_rr_item(to_remove.items[i].string);
+		unlink_rerere_item(to_remove.items[i].string);
 	string_list_clear(&to_remove, 0);
 }
 
@@ -142,19 +134,14 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 		pathspec = get_pathspec(prefix, argv + 1);
 		return rerere_forget(pathspec);
 	}
+	if (!strcmp(argv[0], "clear"))
+		return rerere_clear();
 
 	fd = setup_rerere(&merge_rr, flags);
 	if (fd < 0)
 		return 0;
 
-	if (!strcmp(argv[0], "clear")) {
-		for (i = 0; i < merge_rr.nr; i++) {
-			const char *name = (const char *)merge_rr.items[i].util;
-			if (!has_rerere_resolution(name))
-				unlink_rr_item(name);
-		}
-		unlink_or_warn(git_path("MERGE_RR"));
-	} else if (!strcmp(argv[0], "gc"))
+	if (!strcmp(argv[0], "gc"))
 		garbage_collect(&merge_rr);
 	else if (!strcmp(argv[0], "status"))
 		for (i = 0; i < merge_rr.nr; i++)
diff --git a/rerere.c b/rerere.c
index 22dfc84..aaca3b0 100644
--- a/rerere.c
+++ b/rerere.c
@@ -25,6 +25,14 @@ const char *rerere_path(const char *hex, const char *file)
 	return git_path("rr-cache/%s/%s", hex, file);
 }
 
+void unlink_rerere_item(const char *name)
+{
+	unlink(rerere_path(name, "thisimage"));
+	unlink(rerere_path(name, "preimage"));
+	unlink(rerere_path(name, "postimage"));
+	rmdir(git_path("rr-cache/%s", name));
+}
+
 int has_rerere_resolution(const char *hex)
 {
 	struct stat st;
@@ -671,3 +679,22 @@ int rerere_forget(const char **pathspec)
 	}
 	return write_rr(&merge_rr, fd);
 }
+
+int rerere_clear(void)
+{
+	int i, fd;
+	struct string_list merge_rr = STRING_LIST_INIT_DUP;
+
+	fd = setup_rerere(&merge_rr, 0);
+	if (fd < 0)
+		return -1;
+	for (i = 0; i < merge_rr.nr; i++) {
+		const char *name = (const char *)merge_rr.items[i].util;
+		if (!has_rerere_resolution(name))
+			unlink_rerere_item(name);
+	}
+	string_list_clear(&merge_rr, 1);
+	unlink_or_warn(git_path("MERGE_RR"));
+	rollback_lock_file(&write_lock);
+	return 0;
+}
diff --git a/rerere.h b/rerere.h
index 595f49f..cd2cdb2 100644
--- a/rerere.h
+++ b/rerere.h
@@ -16,8 +16,10 @@ extern void *RERERE_RESOLVED;
 extern int setup_rerere(struct string_list *, int);
 extern int rerere(int);
 extern const char *rerere_path(const char *hex, const char *file);
+extern void unlink_rerere_item(const char *name);
 extern int has_rerere_resolution(const char *hex);
 extern int rerere_forget(const char **);
+extern int rerere_clear(void);
 extern int rerere_remaining(struct string_list *);
 
 #define OPT_RERERE_AUTOUPDATE(v) OPT_UYN(0, "rerere-autoupdate", (v), \
-- 
1.7.5.GIT
