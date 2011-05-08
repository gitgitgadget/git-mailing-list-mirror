From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v4 2/2] rerere: Libify "rerere clear" and "rerere gc"
Date: Sun,  8 May 2011 13:00:51 +0530
Message-ID: <1304839851-6477-3-git-send-email-artagnon@gmail.com>
References: <7vr58b22ny.fsf@alter.siamese.dyndns.org>
 <1304839851-6477-1-git-send-email-artagnon@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 09:31:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIySX-0003lW-22
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 09:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388Ab1EHHa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 03:30:56 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:17570 "EHLO
	smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911Ab1EHHaz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 03:30:55 -0400
X-IronPort-AV: E=Sophos;i="4.64,334,1301875200"; 
   d="scan'208";a="430224092"
Received: from smtp-in-1104.vdc.amazon.com ([10.140.10.25])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 May 2011 07:30:53 +0000
Received: from ramkum.desktop.amazon.com (ramkum.desktop.amazon.com [172.25.205.64])
	by smtp-in-1104.vdc.amazon.com (8.13.8/8.13.8) with ESMTP id p487Uqbh009245;
	Sun, 8 May 2011 07:30:52 GMT
Received: by ramkum.desktop.amazon.com (Postfix, from userid 272482)
	id AACB3754824; Sun,  8 May 2011 13:00:51 +0530 (IST)
X-Mailer: git-send-email 1.7.5.GIT
In-Reply-To: <1304839851-6477-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173076>

Libify "rerere clear" and "rerere gc" into simple functions called
rerere_clear and rerere_garbage_collect; both functions take flags as
a lone argument and return the exit status.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Have I cleaned up all the locks correctly? The tests should probably
 be updated to catch unclean exists- I'll probably work on this
 shortly.

 builtin/rerere.c |   81 ++------------------------------------------
 rerere.c         |   99 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 rerere.h         |    2 +
 3 files changed, 105 insertions(+), 77 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 8235885..e2abdaa 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -12,74 +12,6 @@ static const char * const rerere_usage[] = {
 	NULL,
 };
 
-/* these values are days */
-static int cutoff_noresolve = 15;
-static int cutoff_resolve = 60;
-
-static time_t rerere_created_at(const char *name)
-{
-	struct stat st;
-	return stat(rerere_path(name, "preimage"), &st) ? (time_t) 0 : st.st_mtime;
-}
-
-static time_t rerere_last_used_at(const char *name)
-{
-	struct stat st;
-	return stat(rerere_path(name, "postimage"), &st) ? (time_t) 0 : st.st_mtime;
-}
-
-static void unlink_rr_item(const char *name)
-{
-	unlink(rerere_path(name, "thisimage"));
-	unlink(rerere_path(name, "preimage"));
-	unlink(rerere_path(name, "postimage"));
-	rmdir(git_path("rr-cache/%s", name));
-}
-
-static int git_rerere_gc_config(const char *var, const char *value, void *cb)
-{
-	if (!strcmp(var, "gc.rerereresolved"))
-		cutoff_resolve = git_config_int(var, value);
-	else if (!strcmp(var, "gc.rerereunresolved"))
-		cutoff_noresolve = git_config_int(var, value);
-	else
-		return git_default_config(var, value, cb);
-	return 0;
-}
-
-static void garbage_collect(struct string_list *rr)
-{
-	struct string_list to_remove = STRING_LIST_INIT_DUP;
-	DIR *dir;
-	struct dirent *e;
-	int i, cutoff;
-	time_t now = time(NULL), then;
-
-	git_config(git_rerere_gc_config, NULL);
-	dir = opendir(git_path("rr-cache"));
-	if (!dir)
-		die_errno("unable to open rr-cache directory");
-	while ((e = readdir(dir))) {
-		if (is_dot_or_dotdot(e->d_name))
-			continue;
-
-		then = rerere_last_used_at(e->d_name);
-		if (then) {
-			cutoff = cutoff_resolve;
-		} else {
-			then = rerere_created_at(e->d_name);
-			if (!then)
-				continue;
-			cutoff = cutoff_noresolve;
-		}
-		if (then < now - cutoff * 86400)
-			string_list_append(&to_remove, e->d_name);
-	}
-	for (i = 0; i < to_remove.nr; i++)
-		unlink_rr_item(to_remove.items[i].string);
-	string_list_clear(&to_remove, 0);
-}
-
 static int outf(void *dummy, mmbuffer_t *ptr, int nbuf)
 {
 	int i;
@@ -142,20 +74,15 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 		pathspec = get_pathspec(prefix, argv + 1);
 		return rerere_forget(pathspec);
 	}
+	else if (!strcmp(argv[0], "clear"))
+		return rerere_clear(flags);
+	else if (!strcmp(argv[0], "gc"))
+		return rerere_garbage_collect(flags);
 
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
-		garbage_collect(&merge_rr);
 	else if (!strcmp(argv[0], "status"))
 		for (i = 0; i < merge_rr.nr; i++)
 			printf("%s\n", merge_rr.items[i].string);
diff --git a/rerere.c b/rerere.c
index 22dfc84..18c7413 100644
--- a/rerere.c
+++ b/rerere.c
@@ -20,6 +20,10 @@ static int rerere_autoupdate;
 
 static char *merge_rr_path;
 
+/* these values are days */
+static int cutoff_noresolve = 15;
+static int cutoff_resolve = 60;
+
 const char *rerere_path(const char *hex, const char *file)
 {
 	return git_path("rr-cache/%s/%s", hex, file);
@@ -31,6 +35,37 @@ int has_rerere_resolution(const char *hex)
 	return !stat(rerere_path(hex, "postimage"), &st);
 }
 
+static time_t rerere_created_at(const char *name)
+{
+	struct stat st;
+	return stat(rerere_path(name, "preimage"), &st) ? (time_t) 0 : st.st_mtime;
+}
+
+static time_t rerere_last_used_at(const char *name)
+{
+	struct stat st;
+	return stat(rerere_path(name, "postimage"), &st) ? (time_t) 0 : st.st_mtime;
+}
+
+static void unlink_rr_item(const char *name)
+{
+	unlink(rerere_path(name, "thisimage"));
+	unlink(rerere_path(name, "preimage"));
+	unlink(rerere_path(name, "postimage"));
+	rmdir(git_path("rr-cache/%s", name));
+}
+
+static int git_rerere_gc_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "gc.rerereresolved"))
+		cutoff_resolve = git_config_int(var, value);
+	else if (!strcmp(var, "gc.rerereunresolved"))
+		cutoff_noresolve = git_config_int(var, value);
+	else
+		return git_default_config(var, value, cb);
+	return 0;
+}
+
 static void read_rr(struct string_list *rr)
 {
 	unsigned char sha1[20];
@@ -623,6 +658,51 @@ int rerere(int flags)
 	return do_plain_rerere(&merge_rr, fd);
 }
 
+int rerere_garbage_collect(int flags)
+{
+	struct string_list merge_rr = STRING_LIST_INIT_DUP;
+	struct string_list to_remove = STRING_LIST_INIT_DUP;
+
+	DIR *dir;
+	struct dirent *e;
+	int i, fd, cutoff;
+	time_t now = time(NULL), then;
+
+	fd = setup_rerere(&merge_rr, flags);
+	if (fd < 0)
+		return 0;
+
+	git_config(git_rerere_gc_config, NULL);
+	dir = opendir(git_path("rr-cache"));
+	if (!dir) {
+		rollback_lock_file(&write_lock);
+		return error_errno("Unable to open rr-cache directory");
+	}
+	while ((e = readdir(dir))) {
+		if (is_dot_or_dotdot(e->d_name))
+			continue;
+
+		then = rerere_last_used_at(e->d_name);
+		if (then)
+			cutoff = cutoff_resolve;
+		else {
+			then = rerere_created_at(e->d_name);
+			if (!then)
+				continue;
+			cutoff = cutoff_noresolve;
+		}
+		if (then < now - cutoff * 86400)
+			string_list_append(&to_remove, e->d_name);
+	}
+	for (i = 0; i < to_remove.nr; i++)
+		unlink_rr_item(to_remove.items[i].string);
+
+	string_list_clear(&merge_rr, 1);
+	string_list_clear(&to_remove, 0);
+	rollback_lock_file(&write_lock);
+	return 0;
+}
+
 static int rerere_forget_one_path(const char *path, struct string_list *rr)
 {
 	const char *filename;
@@ -671,3 +751,22 @@ int rerere_forget(const char **pathspec)
 	}
 	return write_rr(&merge_rr, fd);
 }
+
+int rerere_clear(int flags)
+{
+	int i, fd;
+	struct string_list merge_rr = STRING_LIST_INIT_DUP;
+
+	fd = setup_rerere(&merge_rr, flags);
+	if (fd < 0)
+		return 0;
+	for (i = 0; i < merge_rr.nr; i++) {
+		const char *name = (const char *)merge_rr.items[i].util;
+		if (!has_rerere_resolution(name))
+			unlink_rr_item(name);
+	}
+	string_list_clear(&merge_rr, 1);
+	unlink_or_warn(git_path("MERGE_RR"));
+	rollback_lock_file(&write_lock);
+	return 0;
+}
diff --git a/rerere.h b/rerere.h
index 595f49f..59849f6 100644
--- a/rerere.h
+++ b/rerere.h
@@ -15,10 +15,12 @@ extern void *RERERE_RESOLVED;
 
 extern int setup_rerere(struct string_list *, int);
 extern int rerere(int);
+extern int rerere_garbage_collect(int);
 extern const char *rerere_path(const char *hex, const char *file);
 extern int has_rerere_resolution(const char *hex);
 extern int rerere_forget(const char **);
 extern int rerere_remaining(struct string_list *);
+extern int rerere_clear(int);
 
 #define OPT_RERERE_AUTOUPDATE(v) OPT_UYN(0, "rerere-autoupdate", (v), \
 	"update the index with reused conflict resolution if possible")
-- 
1.7.5.GIT
