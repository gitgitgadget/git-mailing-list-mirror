From: Jeff King <peff@peff.net>
Subject: [PATCH 07/17] prefer mkpathdup to mkpath in assignments
Date: Mon, 10 Aug 2015 05:35:38 -0400
Message-ID: <20150810093538.GG30981@sigill.intra.peff.net>
References: <20150810092731.GA9027@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 11:35:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjUi-0004Lm-G6
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753558AbbHJJfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:35:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:42828 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753302AbbHJJfn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 05:35:43 -0400
Received: (qmail 30917 invoked by uid 102); 10 Aug 2015 09:35:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 04:35:43 -0500
Received: (qmail 3135 invoked by uid 107); 10 Aug 2015 09:35:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 05:35:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Aug 2015 05:35:38 -0400
Content-Disposition: inline
In-Reply-To: <20150810092731.GA9027@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275573>

As with the previous commit to git_path, assigning the
result of mkpath is suspicious, since it is not clear
whether we will still depend on the value after it may have
been overwritten by subsequent calls. This patch converts
low-hanging fruit to use mkpathdup instead of mkpath (with
the downside that we must remember to free the result).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/repack.c | 24 +++++++++++++-----------
 refs.c           |  6 ++++--
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index af7340c..70b9b1e 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -285,8 +285,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	failed = 0;
 	for_each_string_list_item(item, &names) {
 		for (ext = 0; ext < ARRAY_SIZE(exts); ext++) {
-			const char *fname_old;
-			char *fname;
+			char *fname, *fname_old;
 			fname = mkpathdup("%s/pack-%s%s", packdir,
 						item->string, exts[ext].name);
 			if (!file_exists(fname)) {
@@ -294,7 +293,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 
-			fname_old = mkpath("%s/old-%s%s", packdir,
+			fname_old = mkpathdup("%s/old-%s%s", packdir,
 						item->string, exts[ext].name);
 			if (file_exists(fname_old))
 				if (unlink(fname_old))
@@ -302,10 +301,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 			if (!failed && rename(fname, fname_old)) {
 				free(fname);
+				free(fname_old);
 				failed = 1;
 				break;
 			} else {
 				string_list_append(&rollback, fname);
+				free(fname_old);
 			}
 		}
 		if (failed)
@@ -314,13 +315,13 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (failed) {
 		struct string_list rollback_failure = STRING_LIST_INIT_DUP;
 		for_each_string_list_item(item, &rollback) {
-			const char *fname_old;
-			char *fname;
+			char *fname, *fname_old;
 			fname = mkpathdup("%s/%s", packdir, item->string);
-			fname_old = mkpath("%s/old-%s", packdir, item->string);
+			fname_old = mkpathdup("%s/old-%s", packdir, item->string);
 			if (rename(fname_old, fname))
 				string_list_append(&rollback_failure, fname);
 			free(fname);
+			free(fname_old);
 		}
 
 		if (rollback_failure.nr) {
@@ -368,13 +369,14 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	/* Remove the "old-" files */
 	for_each_string_list_item(item, &names) {
 		for (ext = 0; ext < ARRAY_SIZE(exts); ext++) {
-			const char *fname;
-			fname = mkpath("%s/old-%s%s",
-					packdir,
-					item->string,
-					exts[ext].name);
+			char *fname;
+			fname = mkpathdup("%s/old-%s%s",
+					  packdir,
+					  item->string,
+					  exts[ext].name);
 			if (remove_path(fname))
 				warning(_("removing '%s' failed"), fname);
+			free(fname);
 		}
 	}
 
diff --git a/refs.c b/refs.c
index 93b250e..e70941a 100644
--- a/refs.c
+++ b/refs.c
@@ -3380,7 +3380,7 @@ static int commit_ref_update(struct ref_lock *lock,
 int create_symref(const char *ref_target, const char *refs_heads_master,
 		  const char *logmsg)
 {
-	const char *lockpath;
+	char *lockpath = NULL;
 	char ref[1000];
 	int fd, len, written;
 	char *git_HEAD = git_pathdup("%s", ref_target);
@@ -3407,7 +3407,7 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 		error("refname too long: %s", refs_heads_master);
 		goto error_free_return;
 	}
-	lockpath = mkpath("%s.lock", git_HEAD);
+	lockpath = mkpathdup("%s.lock", git_HEAD);
 	fd = open(lockpath, O_CREAT | O_EXCL | O_WRONLY, 0666);
 	if (fd < 0) {
 		error("Unable to open %s for writing", lockpath);
@@ -3427,9 +3427,11 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 	error_unlink_return:
 		unlink_or_warn(lockpath);
 	error_free_return:
+		free(lockpath);
 		free(git_HEAD);
 		return -1;
 	}
+	free(lockpath);
 
 #ifndef NO_SYMLINK_HEAD
 	done:
-- 
2.5.0.414.g670f2a4
