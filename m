From: Alexander Potashev <aspotashev@gmail.com>
Subject: [PATCH] Allow cloning to an existing empty directory
Date: Sun, 11 Jan 2009 15:19:12 +0300
Message-ID: <1231676352-16082-1-git-send-email-aspotashev@gmail.com>
References: <1231589270-15812-1-git-send-email-aspotashev@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Alexander Potashev <aspotashev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 11 13:20:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLzJ3-0004ea-Ds
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 13:20:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbZAKMTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 07:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbZAKMTQ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 07:19:16 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:34664 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbZAKMTP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 07:19:15 -0500
Received: by fg-out-1718.google.com with SMTP id 19so3741644fgg.17
        for <git@vger.kernel.org>; Sun, 11 Jan 2009 04:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=cLTLT1QbH/MWyEVf8GFXAtBn3mjGiK1zE3Xb6xGfAYE=;
        b=PNC0aQ+8D3nFdiW8vEdI9ICwNSjh68fZya+7x4WVDyvuM6bMNJ7N4dW9oV+cfrU/Zc
         YYuzGdwVSqS79Wj20Z6ILbREDb2RR3HzHwoS09Mx9ru/VpAoEzHadnUDGf/NkDFDevHf
         O63ZiUE5K14fxiqgZ+bn1Ni1O8mISEG1+oZAk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BJPA3IJhzCZ6/sJfgqJ2o8kztsaPJVMEpWoVxRReh5P7A6TMdxe/SSdvmiaUn8ilJl
         wPFzkFBB71uzSoDcFR8rV1fHtY1nK7YRU9jDA3/GiNxaS+5+uM0CMJZUDkpwpk7LkU04
         U9v0/Y/VUMv/dYM9cmH+60wRxycqmF8/JYH/8=
Received: by 10.86.84.5 with SMTP id h5mr16092890fgb.49.1231676353755;
        Sun, 11 Jan 2009 04:19:13 -0800 (PST)
Received: from localhost.localdomain (ppp83-237-189-41.pppoe.mtu-net.ru [83.237.189.41])
        by mx.google.com with ESMTPS id 3sm6434220fge.37.2009.01.11.04.19.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Jan 2009 04:19:13 -0800 (PST)
X-Mailer: git-send-email 1.6.1
In-Reply-To: <1231589270-15812-1-git-send-email-aspotashev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105172>

The die() message updated accordingly.

The previous behaviour was to only allow cloning when the destination
directory doesn't exist.

Signed-off-by: Alexander Potashev <aspotashev@gmail.com>
---
 builtin-clone.c |    8 +++++---
 dir.c           |   19 +++++++++++++++++++
 dir.h           |    2 ++
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index f1a1a0c..e732f15 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -357,6 +357,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	struct stat buf;
 	const char *repo_name, *repo, *work_tree, *git_dir;
 	char *path, *dir;
+	int dest_exists;
 	const struct ref *refs, *head_points_at, *remote_head, *mapped_refs;
 	struct strbuf key = STRBUF_INIT, value = STRBUF_INIT;
 	struct strbuf branch_top = STRBUF_INIT, reflog_msg = STRBUF_INIT;
@@ -406,8 +407,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		dir = guess_dir_name(repo_name, is_bundle, option_bare);
 	strip_trailing_slashes(dir);
 
-	if (!stat(dir, &buf))
-		die("destination directory '%s' already exists.", dir);
+	if ((dest_exists = !stat(dir, &buf)) && !is_empty_dir(dir))
+		die("destination path '%s' already exists and is not "
+			"an empty directory.", dir);
 
 	strbuf_addf(&reflog_msg, "clone: from %s", repo);
 
@@ -431,7 +433,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		if (safe_create_leading_directories_const(work_tree) < 0)
 			die("could not create leading directories of '%s': %s",
 					work_tree, strerror(errno));
-		if (mkdir(work_tree, 0755))
+		if (!dest_exists && mkdir(work_tree, 0755))
 			die("could not create work tree dir '%s': %s.",
 					work_tree, strerror(errno));
 		set_git_work_tree(work_tree);
diff --git a/dir.c b/dir.c
index 3347f46..7c59829 100644
--- a/dir.c
+++ b/dir.c
@@ -777,6 +777,25 @@ int is_inside_dir(const char *dir)
 	return get_relative_cwd(buffer, sizeof(buffer), dir) != NULL;
 }
 
+int is_empty_dir(const char *path)
+{
+	DIR *dir = opendir(path);
+	struct dirent *e;
+	int ret = 1;
+
+	if (!dir)
+		return 0;
+
+	while ((e = readdir(dir)) != NULL)
+		if (!is_dot_or_dotdot(e->d_name)) {
+			ret = 0;
+			break;
+		}
+
+	closedir(dir);
+	return ret;
+}
+
 int remove_dir_recursively(struct strbuf *path, int only_empty)
 {
 	DIR *dir = opendir(path->buf);
diff --git a/dir.h b/dir.h
index e1640a8..c950c83 100644
--- a/dir.h
+++ b/dir.h
@@ -83,6 +83,8 @@ static inline int is_dot_or_dotdot(const char *name)
 		(name[1] == '.' && name[2] == '\0')); /* "." and ".." */
 }
 
+extern int is_empty_dir(const char *dir);
+
 extern void setup_standard_excludes(struct dir_struct *dir);
 extern int remove_dir_recursively(struct strbuf *path, int only_empty);
 
-- 
1.6.1
