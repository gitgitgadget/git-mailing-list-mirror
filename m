From: Ali Gholami Rudi <ali@rudi.ir>
Subject: [PATCH] builtin-clone.c: fix memory leak in cmd_clone()
Date: Wed, 1 Apr 2009 19:10:56 +0430
Message-ID: <20090401144056.GC2237@lilem.mirepesht>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 01 16:43:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp1f1-0001M1-Pc
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 16:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765841AbZDAOlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 10:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765404AbZDAOlK
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 10:41:10 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:60114 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765479AbZDAOlI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 10:41:08 -0400
Received: by fxm2 with SMTP id 2so66062fxm.37
        for <git@vger.kernel.org>; Wed, 01 Apr 2009 07:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=W6SBLbaZ2PPr1Mtu8Dp28u+K7/mJF3TAbptJFpxmKwA=;
        b=BpaYruwapnMTapEBkFNf1b966OlhUS8sm/F1H6Xy0tHw/prhSLJvMPse20vRUDEtrW
         bAS28QeWz+UlDPek3NbwFY/Wjr798yVSm4c73Yc6bAtLlw6w8+oInECJ8DjnnLte37VP
         KKQdZHxbVTjh3Hc3zIld1zKdlJUyfkREJWWYg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=tiV5EWvmDtLPT9EGiUj97+uw3cKAGgnCy+ajsPHbuQIUhRkK8x+A3+gulQH21lyYey
         7lZ7SWrBlEj01HBA7GoZ/FvoazT/wFUkS3OXy+zYSmvCQCKxYl63BskZpgAgt9r+s8FC
         Nvd4Z/ltPB0SU+08Ax4lCrRKvt4Q6LZDbVb5c=
Received: by 10.223.115.80 with SMTP id h16mr6223275faq.94.1238596865463;
        Wed, 01 Apr 2009 07:41:05 -0700 (PDT)
Received: from localhost ([85.185.70.254])
        by mx.google.com with ESMTPS id z15sm6266fkz.11.2009.04.01.07.41.00
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Apr 2009 07:41:04 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115392>

With this patch, cmd_clone() safely frees its xstrdup()-allocated
memory.  Also junk_work_tree and junk_git_dir (used in remove_junk()
which is called asynchronously) were changed to use static arrays rather
than sharing the memory allocated in cmd_clone().

Signed-off-by: Ali Gholami Rudi <ali@rudi.ir>
---
 builtin-clone.c |   22 +++++++++++++---------
 1 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 0031b5f..8149fc0 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -268,8 +268,8 @@ static const struct ref *clone_local(const char *src_repo,
 	return ret;
 }
 
-static const char *junk_work_tree;
-static const char *junk_git_dir;
+static char junk_work_tree[PATH_MAX];
+static char junk_git_dir[PATH_MAX];
 pid_t junk_pid;
 
 static void remove_junk(void)
@@ -277,12 +277,12 @@ static void remove_junk(void)
 	struct strbuf sb = STRBUF_INIT;
 	if (getpid() != junk_pid)
 		return;
-	if (junk_git_dir) {
+	if (*junk_git_dir) {
 		strbuf_addstr(&sb, junk_git_dir);
 		remove_dir_recursively(&sb, 0);
 		strbuf_reset(&sb);
 	}
-	if (junk_work_tree) {
+	if (*junk_work_tree) {
 		strbuf_addstr(&sb, junk_work_tree);
 		remove_dir_recursively(&sb, 0);
 		strbuf_reset(&sb);
@@ -320,8 +320,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int is_bundle = 0;
 	struct stat buf;
-	const char *repo_name, *repo, *work_tree, *git_dir;
-	char *path, *dir;
+	const char *repo_name, *work_tree;
+	char *path, *dir, *repo, *git_dir;
 	int dest_exists;
 	const struct ref *refs, *head_points_at, *remote_head, *mapped_refs;
 	struct strbuf key = STRBUF_INIT, value = STRBUF_INIT;
@@ -362,7 +362,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	else if (!strchr(repo_name, ':'))
 		repo = xstrdup(make_absolute_path(repo_name));
 	else
-		repo = repo_name;
+		repo = xstrdup(repo_name);
 
 	if (argc == 2)
 		dir = xstrdup(argv[1]);
@@ -393,7 +393,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 
 	if (!option_bare) {
-		junk_work_tree = work_tree;
+		strcpy(junk_work_tree, work_tree);
 		if (safe_create_leading_directories_const(work_tree) < 0)
 			die("could not create leading directories of '%s': %s",
 					work_tree, strerror(errno));
@@ -402,7 +402,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 					work_tree, strerror(errno));
 		set_git_work_tree(work_tree);
 	}
-	junk_git_dir = git_dir;
+	strcpy(junk_git_dir, git_dir);
 	atexit(remove_junk);
 	sigchain_push_common(remove_junk_on_signal);
 
@@ -590,6 +590,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	strbuf_release(&branch_top);
 	strbuf_release(&key);
 	strbuf_release(&value);
+	free(path);
+	free(repo);
+	free(dir);
+	free(git_dir);
 	junk_pid = 0;
 	return err;
 }
