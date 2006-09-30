From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2] Check packed refs when creating leading directories.
Date: Sat, 30 Sep 2006 22:02:16 +0200
Message-ID: <20060930220216.233c6f7b.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 30 21:55:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTkwE-000686-Vq
	for gcvg-git@gmane.org; Sat, 30 Sep 2006 21:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbWI3Tzw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Sep 2006 15:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbWI3Tzv
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Sep 2006 15:55:51 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:23694 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751805AbWI3Tzv (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Sep 2006 15:55:51 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g19.free.fr (Postfix) with SMTP id 9FC1844706;
	Sat, 30 Sep 2006 21:55:49 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28151>

This patch adds an optionnal packed refs check to the
"safe_create_leading_directories" function. This check is
controled by a new int parameter "check_packed_ref" that
must be set.

In "lock_ref_sha1_basic", "safe_create_leading_directories"
is now called with this parameter set, so that no directory
frotz can be created if there is already a frotz packed ref.

The previous check for this is removed from "git-branch.sh"
as it is now useless.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-apply.c   |    2 +-
 cache.h           |    2 +-
 git-branch.sh     |   10 ----------
 local-fetch.c     |    2 +-
 merge-recursive.c |    2 +-
 refs.c            |    4 ++--
 server-info.c     |    4 ++--
 sha1_file.c       |   12 +++++++++++-
 8 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index de5f855..0d6a20c 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2291,7 +2291,7 @@ static void create_one_file(char *path, 
 		return;
 
 	if (errno == ENOENT) {
-		if (safe_create_leading_directories(path))
+		if (safe_create_leading_directories(path, 0))
 			return;
 		if (!try_create_file(path, mode, buf, size))
 			return;
diff --git a/cache.h b/cache.h
index f37bc18..e05a7b0 100644
--- a/cache.h
+++ b/cache.h
@@ -239,7 +239,7 @@ enum sharedrepo {
 };
 int git_config_perm(const char *var, const char *value);
 int adjust_shared_perm(const char *path);
-int safe_create_leading_directories(char *path);
+int safe_create_leading_directories(char *path, int check_packed_ref);
 char *enter_repo(char *path, int strict);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
diff --git a/git-branch.sh b/git-branch.sh
index c616830..bf84b30 100755
--- a/git-branch.sh
+++ b/git-branch.sh
@@ -121,16 +121,6 @@ then
 	done
 fi
 
-branchdir=$(dirname $branchname)
-while test "$branchdir" != "."
-do
-	if git-show-ref --verify --quiet -- "refs/heads/$branchdir"
-	then
-		die "$branchdir already exists."
-	fi
-	branchdir=$(dirname $branchdir)
-done
-
 prev=''
 if git-show-ref --verify --quiet -- "refs/heads/$branchname"
 then
diff --git a/local-fetch.c b/local-fetch.c
index 7b6875c..14672f6 100644
--- a/local-fetch.c
+++ b/local-fetch.c
@@ -56,7 +56,7 @@ static int setup_indices(void)
 static int copy_file(const char *source, char *dest, const char *hex,
 		     int warn_if_not_exists)
 {
-	safe_create_leading_directories(dest);
+	safe_create_leading_directories(dest, 0);
 	if (use_link) {
 		if (!link(source, dest)) {
 			pull_say("link %s\n", hex);
diff --git a/merge-recursive.c b/merge-recursive.c
index 611cd95..4c9b6b2 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -515,7 +515,7 @@ static int mkdir_p(const char *path, uns
 {
 	/* path points to cache entries, so xstrdup before messing with it */
 	char *buf = xstrdup(path);
-	int result = safe_create_leading_directories(buf);
+	int result = safe_create_leading_directories(buf, 0);
 	free(buf);
 	return result;
 }
diff --git a/refs.c b/refs.c
index 5e3988b..1ac7d61 100644
--- a/refs.c
+++ b/refs.c
@@ -506,7 +506,7 @@ static struct ref_lock *lock_ref_sha1_ba
 	ref_file = git_path("%s", ref);
 	lock->force_write = lstat(ref_file, &st) && errno == ENOENT;
 
-	if (safe_create_leading_directories(ref_file))
+	if (safe_create_leading_directories(ref_file, 1))
 		die("unable to create directory for %s", ref_file);
 	lock->lock_fd = hold_lock_file_for_update(lock->lk, ref_file, 1);
 
@@ -549,7 +549,7 @@ static int log_ref_write(struct ref_lock
 	const char *committer;
 
 	if (log_all_ref_updates) {
-		if (safe_create_leading_directories(lock->log_file) < 0)
+		if (safe_create_leading_directories(lock->log_file, 0) < 0)
 			return error("unable to create directory for %s",
 				lock->log_file);
 		oflags |= O_CREAT;
diff --git a/server-info.c b/server-info.c
index 6cd38be..455f333 100644
--- a/server-info.c
+++ b/server-info.c
@@ -30,7 +30,7 @@ static int update_info_refs(int force)
 	strcpy(path1, path0);
 	strcpy(path1 + len, "+");
 
-	safe_create_leading_directories(path0);
+	safe_create_leading_directories(path0, 0);
 	info_ref_fp = fopen(path1, "w");
 	if (!info_ref_fp)
 		return error("unable to update %s", path0);
@@ -219,7 +219,7 @@ static int update_info_packs(int force)
 
 	init_pack_info(infofile, force);
 
-	safe_create_leading_directories(name);
+	safe_create_leading_directories(name, 0);
 	fp = fopen(name, "w");
 	if (!fp)
 		return error("cannot open %s", name);
diff --git a/sha1_file.c b/sha1_file.c
index 18c2f88..b6c0da3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -74,7 +74,7 @@ int get_sha1_hex(const char *hex, unsign
 	return 0;
 }
 
-int safe_create_leading_directories(char *path)
+int safe_create_leading_directories(char *path, int check_packed_ref)
 {
 	char *pos = path;
 	struct stat st;
@@ -102,6 +102,16 @@ int safe_create_leading_directories(char
 			*pos = '/';
 			return -2;
 		}
+		else if (check_packed_ref) {
+			unsigned char sha1[20];
+			const char *ref = path + strlen(get_git_dir()) + 1;
+			if (resolve_packed_ref(ref, sha1, 1, NULL)) {
+				rmdir(path);
+				fprintf(stderr, "%s already exists.\n", ref);
+				*pos = '/';
+				return -4;
+			}
+		}
 		*pos++ = '/';
 	}
 	return 0;
-- 
1.4.2.1.g7cf04
