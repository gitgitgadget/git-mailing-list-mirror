From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 1/3] Refactor working tree setup
Date: Sat,  3 Nov 2007 12:23:11 +0100
Message-ID: <1194088993-25692-1-git-send-email-mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 03 12:24:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoH7N-0003JZ-3g
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 12:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998AbXKCLY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 07:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753047AbXKCLY1
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 07:24:27 -0400
Received: from vawad.err.no ([85.19.200.177]:57398 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752975AbXKCLYY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 07:24:24 -0400
Received: from aputeaux-153-1-33-156.w82-124.abo.wanadoo.fr ([82.124.3.156] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IoH6n-0007sl-Ib; Sat, 03 Nov 2007 12:24:12 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IoH5t-0006ge-V6; Sat, 03 Nov 2007 12:23:14 +0100
X-Mailer: git-send-email 1.5.3.5
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63236>

Create a setup_work_tree() that can be used from any command requiring
a working tree conditionally.

Signed-off-by: Mike Hommey <mh@glandium.org>
---

This kind of implements what Dscho suggested in
http://article.gmane.org/gmane.comp.version-control.git/62487

 cache.h |    1 +
 git.c   |   11 +++--------
 setup.c |    9 +++++++++
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index bfffa05..497b9f9 100644
--- a/cache.h
+++ b/cache.h
@@ -222,6 +222,7 @@ extern const char *get_git_work_tree(void);
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
 extern const char **get_pathspec(const char *prefix, const char **pathspec);
+extern void setup_work_tree(void);
 extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
 extern const char *prefix_path(const char *prefix, int len, const char *path);
diff --git a/git.c b/git.c
index 4e10581..eb31c93 100644
--- a/git.c
+++ b/git.c
@@ -249,14 +249,9 @@ static int run_command(struct cmd_struct *p, int argc, const char **argv)
 		prefix = setup_git_directory();
 	if (p->option & USE_PAGER)
 		setup_pager();
-	if (p->option & NEED_WORK_TREE) {
-		const char *work_tree = get_git_work_tree();
-		const char *git_dir = get_git_dir();
-		if (!is_absolute_path(git_dir))
-			set_git_dir(make_absolute_path(git_dir));
-		if (!work_tree || chdir(work_tree))
-			die("%s must be run in a work tree", p->cmd);
-	}
+	if (p->option & NEED_WORK_TREE)
+		setup_work_tree();
+
 	trace_argv_printf(argv, argc, "trace: built-in: git");
 
 	status = p->fn(argc, argv, prefix);
diff --git a/setup.c b/setup.c
index 145eca5..df006d9 100644
--- a/setup.c
+++ b/setup.c
@@ -206,6 +206,15 @@ static const char *set_work_tree(const char *dir)
 	return NULL;
 }
 
+void setup_work_tree(void) {
+	const char *work_tree = get_git_work_tree();
+	const char *git_dir = get_git_dir();
+	if (!is_absolute_path(git_dir))
+		set_git_dir(make_absolute_path(git_dir));
+	if (!work_tree || chdir(work_tree))
+		die("This operation must be run in a work tree");
+}
+
 /*
  * We cannot decide in this function whether we are in the work tree or
  * not, since the config can only be read _after_ this function was called.
-- 
1.5.3.5
