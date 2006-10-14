From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2] When packing and pruning refs, remove "deleted-refs".
Date: Sat, 14 Oct 2006 15:41:09 +0200
Message-ID: <20061014154109.9a093319.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 14 15:34:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYjej-0001Wl-St
	for gcvg-git@gmane.org; Sat, 14 Oct 2006 15:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422631AbWJNNeX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Oct 2006 09:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422638AbWJNNeX
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Oct 2006 09:34:23 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:3254 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1422632AbWJNNeW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Oct 2006 09:34:22 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g19.free.fr (Postfix) with SMTP id 5E10E735DF;
	Sat, 14 Oct 2006 15:34:21 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28878>

When running "git pack-refs --prune" we have to also prune
deleted ref files. To do this, remove recusively everything
under "$GIT_DIR/deleted-refs".

The new "remove_all_recursive" function has been copied from
"remove_empty_dir_recursive" in "refs.c".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-pack-refs.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
index 1087657..84ca170 100644
--- a/builtin-pack-refs.c
+++ b/builtin-pack-refs.c
@@ -54,12 +54,54 @@ static void prune_ref(struct ref_to_prun
 	}
 }
 
+static int remove_all_recursive(char *path)
+{
+	DIR *dir = opendir(path);
+	struct dirent *e;
+	int ret = 0;
+	int len = strlen(path);
+
+	if (!dir)
+		return unlink(path);
+	if (path[len-1] != '/')
+		path[len++] = '/';
+	while ((e = readdir(dir)) != NULL) {
+		struct stat st;
+		int namlen;
+		if ((e->d_name[0] == '.') &&
+		    ((e->d_name[1] == 0) ||
+		     ((e->d_name[1] == '.') && e->d_name[2] == 0)))
+			continue; /* "." and ".." */
+
+		namlen = strlen(e->d_name);
+		if ((len + namlen < PATH_MAX) &&
+		    strcpy(path + len, e->d_name) &&
+		    !lstat(path, &st) &&
+		    (S_ISDIR(st.st_mode) ?
+		     !remove_all_recursive(path) :
+		     !unlink(path)))
+			continue; /* happy */
+
+		/* path too long, stat, rmdir or unlink fails */
+		ret = -1;
+		break;
+	}
+	closedir(dir);
+	if (!ret) {
+		path[len] = 0;
+		ret = rmdir(path);
+	}
+	return ret;
+}
+
 static void prune_refs(struct ref_to_prune *r)
 {
 	while (r) {
 		prune_ref(r);
 		r = r->next;
 	}
+
+	remove_all_recursive(git_path("deleted-refs"));
 }
 
 static struct lock_file packed;
-- 
1.4.3.rc2.gbcf275-dirty
