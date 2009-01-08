From: Alexander Potashev <aspotashev@gmail.com>
Subject: [PATCH 1/2] Allow cloning to an existing empty directory
Date: Fri,  9 Jan 2009 02:24:22 +0300
Message-ID: <1231457063-29186-2-git-send-email-aspotashev@gmail.com>
References: <1231457063-29186-1-git-send-email-aspotashev@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Alexander Potashev <aspotashev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 00:25:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LL4G3-0005bA-Hq
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 00:25:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494AbZAHXYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 18:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753101AbZAHXYO
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 18:24:14 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:51810 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525AbZAHXYM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 18:24:12 -0500
Received: by bwz14 with SMTP id 14so28191832bwz.13
        for <git@vger.kernel.org>; Thu, 08 Jan 2009 15:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=KUg8tbrUqgHc3vqfqvKbEETgthwnyZmA6HoMJhGCThE=;
        b=EF26+qU/8fPBFp7Tk7AfT7jFCTXnZogD6mgM09YRlwhWVi0bGOGNT/DyaWQdGJ1Ss3
         TN5P6ekVKqoBBUWnCzlEtVw5owafJCOfdTtiteY+JpFBwUjYIDjE/JeDmoTiZh/58AGL
         UOC46kyJMXvr5uVREXvw4/nC/hrAzK04HGONM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qVdx16GbashPbB8CLDZ1qqgA9KtfNMBKlWQyhCcwJFk6l57h44AtztGVyGAR9DOuzb
         Bzxs42pAnyhe/eN6GLSVr4GQQ0vAspnxVTubeDMhhIj52D3jCpG9WtyLG82nbfh78uqF
         zlWCsbrxgRSK8K3T2oSOcTe7wmEkLSsAhWQ4A=
Received: by 10.223.116.10 with SMTP id k10mr18021456faq.100.1231457050400;
        Thu, 08 Jan 2009 15:24:10 -0800 (PST)
Received: from localhost.localdomain (ppp91-77-14-152.pppoe.mtu-net.ru [91.77.14.152])
        by mx.google.com with ESMTPS id p17sm45302243fka.30.2009.01.08.15.24.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Jan 2009 15:24:09 -0800 (PST)
X-Mailer: git-send-email 1.6.1.77.g84c9
In-Reply-To: <1231457063-29186-1-git-send-email-aspotashev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104966>

The die() message changed accordingly.

The previous behaviour was to only allow cloning when the destination
directory doesn't exist.

A new inline function is_pseudo_dir_name is used to check if the
directory name is either "." or "..". It returns a non-zero value if
the given string is "." or "..". It's applicable to a lot of other Git
source code.

Signed-off-by: Alexander Potashev <aspotashev@gmail.com>
---
 builtin-clone.c |    8 +++++---
 dir.c           |   19 +++++++++++++++++++
 dir.h           |    8 ++++++++
 3 files changed, 32 insertions(+), 3 deletions(-)

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
index 0131983..bd97e50 100644
--- a/dir.c
+++ b/dir.c
@@ -779,6 +779,25 @@ int is_inside_dir(const char *dir)
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
+		if (!is_pseudo_dir_name(e->d_name)) {
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
index 768425a..940e057 100644
--- a/dir.h
+++ b/dir.h
@@ -77,6 +77,14 @@ extern int file_exists(const char *);
 extern char *get_relative_cwd(char *buffer, int size, const char *dir);
 extern int is_inside_dir(const char *dir);
 
+static inline int is_pseudo_dir_name(const char *name)
+{
+	return name[0] == '.' && (name[1] == '\0' ||
+		(name[1] == '.' && name[2] == '\0')); /* "." and ".." */
+}
+
+extern int is_empty_dir(const char *dir);
+
 extern void setup_standard_excludes(struct dir_struct *dir);
 extern int remove_dir_recursively(struct strbuf *path, int only_empty);
 
-- 
1.6.1.77.g84c9
