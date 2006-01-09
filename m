From: Michal Ostrowski <mostrows@watson.ibm.com>
Subject: [PATCH 1/2] Remember and use GIT_EXEC_PATH on exec()'s
Date: Mon, 09 Jan 2006 18:35:53 -0500
Message-ID: <1136849754.11717.517.camel@brick.watson.ibm.com>
References: <1136849678.11717.514.camel@brick.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 10 00:34:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ew6Wu-0001aE-GN
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 00:34:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWAIXeW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 18:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWAIXeW
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 18:34:22 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:660 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1751318AbWAIXeV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2006 18:34:21 -0500
Received: from sp1n294en1.watson.ibm.com (sp1n294en1.watson.ibm.com [129.34.20.40])
	by igw2.watson.ibm.com (8.12.11/8.13.1/8.13.1-2005-04-25 igw) with ESMTP id k09NaXQD022918
	for <git@vger.kernel.org>; Mon, 9 Jan 2006 18:36:33 -0500
Received: from sp1n294en1.watson.ibm.com (localhost [127.0.0.1])
	by sp1n294en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_2) with ESMTP id k09NYKc322218
	for <git@vger.kernel.org>; Mon, 9 Jan 2006 18:34:20 -0500
Received: from mgsmtp00.watson.ibm.com (mgsmtp00.watson.ibm.com [9.2.40.58])
	by sp1n294en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_1) with ESMTP id k09NYJs322216
	for <git@vger.kernel.org>; Mon, 9 Jan 2006 18:34:19 -0500
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.224.107])
	by mgsmtp00.watson.ibm.com (8.12.11/8.12.11/2005/09/01) with ESMTP id k0A0V83p004893
	for <git@vger.kernel.org>; Mon, 9 Jan 2006 19:31:09 -0500
Received: from brick (brick.watson.ibm.com [9.2.216.48])
	by kitch0.watson.ibm.com (AIX5.1/8.11.6p2/8.11.0/03-06-2002) with ESMTP id k09NYIm31696
	for <git@vger.kernel.org>; Mon, 9 Jan 2006 18:34:18 -0500
To: git@vger.kernel.org
In-Reply-To: <1136849678.11717.514.camel@brick.watson.ibm.com>
X-Mailer: Evolution 2.4.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14386>

If git-upload-pack is invoked by ssh, it may have been invoked because
ssh was explicitly told which program to execute on the remote end
(i.e. --exec had been used with git-clone-pack).  In this case, the
git suite may not be in the PATH, and so subsequent exec's by
git-upload-pack (i.e. git-rev-list, git-pack-objects) will fail.

These changes provide for ${bindir} to be stored at compile time in
environment.c. git_setup_exec_path() is implemented; this function
will append GIT_EXEC_PATH or the saved ${bindir} to PATH.

Signed-off-by: Michal Ostrowski <mostrows@watson.ibm.com>

---

 Makefile      |    7 +++++++
 cache.h       |    1 +
 environment.c |   29 +++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 0 deletions(-)

b24fde016c2d7382016b80bc0b9a011db3413bb3
diff --git a/Makefile b/Makefile
index c9c15b5..ffd2a68 100644
--- a/Makefile
+++ b/Makefile
@@ -437,6 +437,13 @@ init-db.o: init-db.c
 	$(CC) -c $(ALL_CFLAGS) \
 		-DDEFAULT_GIT_TEMPLATE_DIR=$(call shellquote,"$(template_dir)") $*.c
 
+# Recompile environment.o if GIT_EXEC_PATH changes
+.environment.GIT_EXEC_PATH:
+	@(test -e $@ && grep -h -e '^$(bindir)$$' $@) || echo $(bindir) > $@
+environment.o: .environment.GIT_EXEC_PATH
+environment.o: CFLAGS+= -DGIT_EXEC_PATH=\"$(bindir)\"
+
+
 $(LIB_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIB_H)
 $(DIFF_OBJS): diffcore.h
diff --git a/cache.h b/cache.h
index 29c9e81..d73071e 100644
--- a/cache.h
+++ b/cache.h
@@ -244,6 +244,7 @@ unsigned long approxidate(const char *);
 extern int setup_ident(void);
 extern const char *git_author_info(void);
 extern const char *git_committer_info(void);
+extern void git_setup_exec_path(void);
 
 struct checkout {
 	const char *base_dir;
diff --git a/environment.c b/environment.c
index 0596fc6..4dc0249 100644
--- a/environment.c
+++ b/environment.c
@@ -9,6 +9,10 @@
  */
 #include "cache.h"
 
+#ifndef GIT_EXEC_PATH
+#define GIT_EXEC_PATH NULL
+#endif
+
 char git_default_email[MAX_GITNAME];
 char git_default_name[MAX_GITNAME];
 int trust_executable_bit = 1;
@@ -16,6 +20,7 @@ int only_use_symrefs = 0;
 int repository_format_version = 0;
 char git_commit_encoding[MAX_ENCODING_LENGTH] = "utf-8";
 int shared_repository = 0;
+char *git_exec_path = GIT_EXEC_PATH;
 
 static char *git_dir, *git_object_dir, *git_index_file, *git_refs_dir,
 	*git_graft_file;
@@ -76,4 +81,28 @@ char *get_graft_file(void)
 	return git_graft_file;
 }
 
+void git_setup_exec_path(void)
+{
+	char *path, *old_path = getenv("PATH");
+	int path_len, len, old_len;
+	char *exec_path = getenv("GIT_EXEC_PATH");
+
+	if (!exec_path)
+		exec_path = git_exec_path;
+
+	len = strlen(exec_path);
+
+	if (!old_path)
+		old_path = "/usr/local/bin:/usr/bin:/bin";
 
+	old_len = strlen(old_path);
+	path_len = len + old_len + 1;
+
+	path = malloc(path_len + 1);
+
+	memcpy(path, old_path, old_len);
+	path[old_len] = ':';
+	memcpy(path + old_len + 1, exec_path, len);
+
+	setenv("PATH", path, 1);
+}
-- 
0.99.9m-g02ad
