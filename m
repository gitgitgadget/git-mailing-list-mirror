From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] Add core.symlinks to mark filesystems that do not support symbolic links.
Date: Fri, 2 Mar 2007 22:11:30 +0100
Message-ID: <200703022211.30322.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 22:11:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNF2S-0003lm-Np
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 22:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965636AbXCBVLh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 16:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965638AbXCBVLh
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 16:11:37 -0500
Received: from smtp3.noc.eunet-ag.at ([193.154.160.89]:45184 "EHLO
	smtp3.noc.eunet-ag.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965636AbXCBVLf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 16:11:35 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.noc.eunet-ag.at (Postfix) with ESMTP id 48C2834500
	for <git@vger.kernel.org>; Fri,  2 Mar 2007 22:11:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id EF3A23B46D
	for <git@vger.kernel.org>; Fri,  2 Mar 2007 22:11:30 +0100 (CET)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41248>

Some file systems that can host git repositories and their working copies
do not support symbolic links. But then if the repository contains a symbolic
link, it is impossible to check out the working copy.

This patch enables partial support of symbolic links so that it is possible
to check out a working copy on such a file system.  A new flag
core.symlinks (which is true by default) can be set to false to indicate
that the filesystem does not support symbolic links. In this case, symbolic
links that exist in the trees are checked out as small plain files, and
checking in modifications of these files preserve the symlink property in
the database (as long as an entry exists in the index).

Of course, this does not magically make symbolic links work on such defective
file systems; hence, this solution does not help if the working copy relies
on that an entry is a real symbolic link.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---

This is a resend of my earlier patch series, this time as a single patch
since it's quite small. And with some basic tests.

Hannes

 Documentation/config.txt           |    7 +++++++
 Documentation/git-update-index.txt |    5 +++++
 builtin-apply.c                    |    2 +-
 builtin-update-index.c             |    6 +++---
 cache.h                            |    6 +++++-
 config.c                           |    5 +++++
 diff-lib.c                         |    3 +++
 entry.c                            |    9 ++++++---
 environment.c                      |    1 +
 read-cache.c                       |   10 ++++++----
 t/t2005-checkout-index-symlinks.sh |   28 ++++++++++++++++++++++++++++
 t/t2102-update-index-symlinks.sh   |   31 +++++++++++++++++++++++++++++++
 12 files changed, 101 insertions(+), 12 deletions(-)
 create mode 100644 t/t2005-checkout-index-symlinks.sh
 create mode 100644 t/t2102-update-index-symlinks.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9fec769..08d13ca 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -116,6 +116,13 @@ core.fileMode::
 	the working copy are ignored; useful on broken filesystems like FAT.
 	See gitlink:git-update-index[1]. True by default.
 
+core.symlinks::
+	If false, symbolic links are checked out as small plain files that
+	contain the link text. gitlink:git-update-index[1] and
+	gitlink:git-add[1] will not change the recorded type to regular
+	file. Useful on filesystems like FAT that do not support
+	symbolic links. True by default.
+
 core.gitProxy::
 	A "proxy command" to execute (as 'command host port') instead
 	of establishing direct connection to the remote server when
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index b161c8b..cd5e014 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -295,6 +295,11 @@ in the index and the file mode on the filesystem if they differ only on
 executable bit.   On such an unfortunate filesystem, you may
 need to use `git-update-index --chmod=`.
 
+Quite similarly, if `core.symlinks` configuration variable is set
+to 'false' (see gitlink:git-config[1]), symbolic links are checked out
+as plain files, and this command does not modify a recorded file mode
+from symbolic link to regular file.
+
 The command looks at `core.ignorestat` configuration variable.  See
 'Using "assume unchanged" bit' section above.
 
diff --git a/builtin-apply.c b/builtin-apply.c
index bec95d6..83ee20b 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2284,7 +2284,7 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
 {
 	int fd;
 
-	if (S_ISLNK(mode))
+	if (has_symlinks && S_ISLNK(mode))
 		/* Although buf:size is counted string, it also is NUL
 		 * terminated.
 		 */
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 772aaba..982640a 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -109,11 +109,11 @@ static int add_file_to_cache(const char *path)
 	ce->ce_flags = htons(namelen);
 	fill_stat_cache_info(ce, &st);
 
-	if (trust_executable_bit)
+	if (trust_executable_bit && has_symlinks)
 		ce->ce_mode = create_ce_mode(st.st_mode);
 	else {
-		/* If there is an existing entry, pick the mode bits
-		 * from it, otherwise assume unexecutable.
+		/* If there is an existing entry, pick the mode bits and type
+		 * from it, otherwise assume unexecutable regular file.
 		 */
 		struct cache_entry *ent;
 		int pos = cache_name_pos(path, namelen);
diff --git a/cache.h b/cache.h
index 04f8e63..6f932fe 100644
--- a/cache.h
+++ b/cache.h
@@ -108,7 +108,10 @@ static inline unsigned int create_ce_mode(unsigned int mode)
 }
 static inline unsigned int ce_mode_from_stat(struct cache_entry *ce, unsigned int mode)
 {
-	extern int trust_executable_bit;
+	extern int trust_executable_bit, has_symlinks;
+	if (!has_symlinks && S_ISREG(mode) &&
+	    ce && S_ISLNK(ntohl(ce->ce_mode)))
+		return ce->ce_mode;
 	if (!trust_executable_bit && S_ISREG(mode)) {
 		if (ce && S_ISREG(ntohl(ce->ce_mode)))
 			return ce->ce_mode;
@@ -202,6 +205,7 @@ extern int delete_ref(const char *, unsigned char *sha1);
 /* Environment bits from configuration mechanism */
 extern int use_legacy_headers;
 extern int trust_executable_bit;
+extern int has_symlinks;
 extern int assume_unchanged;
 extern int prefer_symlink_refs;
 extern int log_all_ref_updates;
diff --git a/config.c b/config.c
index c938aa0..8181c6f 100644
--- a/config.c
+++ b/config.c
@@ -269,6 +269,11 @@ int git_default_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.symlinks")) {
+		has_symlinks = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.bare")) {
 		is_bare_repository_cfg = git_config_bool(var, value);
 		return 0;
diff --git a/diff-lib.c b/diff-lib.c
index 60c0fa6..2c121d2 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -134,6 +134,9 @@ int run_diff_files(struct rev_info *revs, int silent_on_removed)
 		    S_ISREG(newmode) && S_ISREG(oldmode) &&
 		    ((newmode ^ oldmode) == 0111))
 			newmode = oldmode;
+		else if (!has_symlinks &&
+		    S_ISREG(newmode) && S_ISLNK(oldmode))
+			newmode = oldmode;
 		diff_change(&revs->diffopt, oldmode, newmode,
 			    ce->sha1, (changed ? null_sha1 : ce->sha1),
 			    ce->name, NULL);
diff --git a/entry.c b/entry.c
index c2641dd..87609ca 100644
--- a/entry.c
+++ b/entry.c
@@ -97,9 +97,12 @@ static int write_entry(struct cache_entry *ce, char *path, struct checkout *stat
 			return error("git-checkout-index: unable to write file %s", path);
 		break;
 	case S_IFLNK:
-		if (to_tempfile) {
-			strcpy(path, ".merge_link_XXXXXX");
-			fd = mkstemp(path);
+		if (to_tempfile || !has_symlinks) {
+			if (to_tempfile) {
+				strcpy(path, ".merge_link_XXXXXX");
+				fd = mkstemp(path);
+			} else
+				fd = create_file(path, 0666);
 			if (fd < 0) {
 				free(new);
 				return error("git-checkout-index: unable to create "
diff --git a/environment.c b/environment.c
index 54c22f8..48bc4f0 100644
--- a/environment.c
+++ b/environment.c
@@ -13,6 +13,7 @@ char git_default_email[MAX_GITNAME];
 char git_default_name[MAX_GITNAME];
 int use_legacy_headers = 1;
 int trust_executable_bit = 1;
+int has_symlinks = 1;
 int assume_unchanged;
 int prefer_symlink_refs;
 int is_bare_repository_cfg = -1; /* unspecified */
diff --git a/read-cache.c b/read-cache.c
index 605b352..e8da76c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -125,7 +125,9 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 			changed |= MODE_CHANGED;
 		break;
 	case S_IFLNK:
-		changed |= !S_ISLNK(st->st_mode) ? TYPE_CHANGED : 0;
+		if (!S_ISLNK(st->st_mode) &&
+		    (has_symlinks || !S_ISREG(st->st_mode)))
+			changed |= TYPE_CHANGED;
 		break;
 	default:
 		die("internal error: ce_mode is %o", ntohl(ce->ce_mode));
@@ -344,11 +346,11 @@ int add_file_to_index(const char *path, int verbose)
 	ce->ce_flags = htons(namelen);
 	fill_stat_cache_info(ce, &st);
 
-	if (trust_executable_bit)
+	if (trust_executable_bit && has_symlinks)
 		ce->ce_mode = create_ce_mode(st.st_mode);
 	else {
-		/* If there is an existing entry, pick the mode bits
-		 * from it, otherwise assume unexecutable.
+		/* If there is an existing entry, pick the mode bits and type
+		 * from it, otherwise assume unexecutable regular file.
 		 */
 		struct cache_entry *ent;
 		int pos = cache_name_pos(path, namelen);
diff --git a/t/t2005-checkout-index-symlinks.sh b/t/t2005-checkout-index-symlinks.sh
new file mode 100644
index 0000000..e34a515
--- /dev/null
+++ b/t/t2005-checkout-index-symlinks.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Johannes Sixt
+#
+
+test_description='git-checkout-index on filesystem w/o symlinks test.
+
+This tests that git-checkout-index creates a symbolic link as a plain
+file if core.symlinks is false.'
+
+. ./test-lib.sh
+
+test_expect_success \
+'preparation' '
+git-config core.symlinks false &&
+l=$(echo -n file | git-hash-object -t blob -w --stdin) &&
+echo "120000 $l	symlink" | git-update-index --index-info'
+
+test_expect_success \
+'the checked-out symlink must be a file' '
+git-checkout-index symlink &&
+test -f symlink'
+
+test_expect_success \
+'the file must be the blob we added during the setup' '
+test "$(git-hash-object -t blob symlink)" = $l'
+
+test_done
diff --git a/t/t2102-update-index-symlinks.sh b/t/t2102-update-index-symlinks.sh
new file mode 100644
index 0000000..969ef89
--- /dev/null
+++ b/t/t2102-update-index-symlinks.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Johannes Sixt
+#
+
+test_description='git-update-index on filesystem w/o symlinks test.
+
+This tests that git-update-index keeps the symbolic link property
+even if a plain file is in the working tree if core.symlinks is false.'
+
+. ./test-lib.sh
+
+test_expect_success \
+'preparation' '
+git-config core.symlinks false &&
+l=$(echo -n file | git-hash-object -t blob -w --stdin) &&
+echo "120000 $l	symlink" | git-update-index --index-info'
+
+test_expect_success \
+'modify the symbolic link' '
+echo -n new-file > symlink &&
+git-update-index symlink'
+
+test_expect_success \
+'the index entry must still be a symbolic link' '
+case "`git-ls-files --stage --cached symlink`" in
+120000" "*symlink) echo ok;;
+*) echo fail; git-ls-files --stage --cached symlink; (exit 1);;
+esac'
+
+test_done
-- 
1.5.0.19.gddff
