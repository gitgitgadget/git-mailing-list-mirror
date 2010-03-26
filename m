From: Peter Collingbourne <peter@pcc.me.uk>
Subject: [PATCH 06/12] Introduce remove_or_warn function
Date: Fri, 26 Mar 2010 15:25:34 +0000
Message-ID: <1269617140-7827-7-git-send-email-peter@pcc.me.uk>
References: <1269617140-7827-1-git-send-email-peter@pcc.me.uk>
Cc: Peter Collingbourne <peter@pcc.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 26 16:26:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvBQh-0005ou-2g
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 16:26:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754507Ab0CZP0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 11:26:30 -0400
Received: from master.pcc.me.uk ([207.192.74.179]:55549 "EHLO master.pcc.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754273Ab0CZPZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 11:25:57 -0400
Received: from [10.179.145.9] (helo=lapas.pcc.me.uk)
	by master.pcc.me.uk with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1NvBQ2-0001o7-J3; Fri, 26 Mar 2010 15:25:55 +0000
Received: from peter by lapas.pcc.me.uk with local (Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1NvBQ1-00023J-9H; Fri, 26 Mar 2010 15:25:53 +0000
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1269617140-7827-1-git-send-email-peter@pcc.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143248>

This patch introduces the remove_or_warn function which is a
generalised version of the {unlink,rmdir}_or_warn functions.  It takes
an additional parameter indicating the mode of the file to be removed.

The patch also modifies certain functions to use remove_or_warn
where appropriate, and adds a test case for a bug fixed by the use
of remove_or_warn.

Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
---
 builtin/apply.c            |    6 +-----
 git-compat-util.h          |    5 +++++
 t/t4134-apply-submodule.sh |   38 ++++++++++++++++++++++++++++++++++++++
 unpack-trees.c             |   12 ++----------
 wrapper.c                  |    5 +++++
 5 files changed, 51 insertions(+), 15 deletions(-)
 create mode 100755 t/t4134-apply-submodule.sh

diff --git a/builtin/apply.c b/builtin/apply.c
index 7ca9047..65a594c 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3144,11 +3144,7 @@ static void remove_file(struct patch *patch, int rmdir_empty)
 			die("unable to remove %s from index", patch->old_name);
 	}
 	if (!cached) {
-		if (S_ISGITLINK(patch->old_mode)) {
-			if (rmdir(patch->old_name))
-				warning("unable to remove submodule %s",
-					patch->old_name);
-		} else if (!unlink_or_warn(patch->old_name) && rmdir_empty) {
+		if (!remove_or_warn(patch->old_mode, patch->old_name) && rmdir_empty) {
 			remove_path(patch->old_name);
 		}
 	}
diff --git a/git-compat-util.h b/git-compat-util.h
index 67ea4c8..3ebf966 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -473,5 +473,10 @@ int unlink_or_warn(const char *path);
  * Likewise for rmdir(2).
  */
 int rmdir_or_warn(const char *path);
+/*
+ * Calls the correct function out of {unlink,rmdir}_or_warn based on
+ * the supplied file mode.
+ */
+int remove_or_warn(unsigned int mode, const char *path);
 
 #endif
diff --git a/t/t4134-apply-submodule.sh b/t/t4134-apply-submodule.sh
new file mode 100755
index 0000000..1b82f93
--- /dev/null
+++ b/t/t4134-apply-submodule.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Peter Collingbourne
+#
+
+test_description='git apply submodule tests'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	cat > create-sm.patch <<EOF
+diff --git a/dir/sm b/dir/sm
+new file mode 160000
+index 0000000..0123456
+--- /dev/null
++++ b/dir/sm
+@@ -0,0 +1 @@
++Subproject commit 0123456789abcdef0123456789abcdef01234567
+EOF
+	cat > remove-sm.patch <<EOF
+diff --git a/dir/sm b/dir/sm
+deleted file mode 160000
+index 0123456..0000000
+--- a/dir/sm
++++ /dev/null
+@@ -1 +0,0 @@
+-Subproject commit 0123456789abcdef0123456789abcdef01234567
+EOF
+'
+
+test_expect_success 'removing a submodule also removes all leading subdirectories' '
+	git apply --index create-sm.patch &&
+	test -d dir/sm &&
+	git apply --index remove-sm.patch &&
+	test \! -d dir
+'
+
+test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 75f54ca..c29a9e0 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -67,16 +67,8 @@ static void unlink_entry(struct cache_entry *ce)
 {
 	if (has_symlink_or_noent_leading_path(ce->name, ce_namelen(ce)))
 		return;
-	if (S_ISGITLINK(ce->ce_mode)) {
-		if (rmdir(ce->name)) {
-			warning("unable to rmdir %s: %s",
-				ce->name, strerror(errno));
-			return;
-		}
-	}
-	else
-		if (unlink_or_warn(ce->name))
-			return;
+	if (remove_or_warn(ce->ce_mode, ce->name))
+		return;
 	schedule_dir_for_removal(ce->name, ce_namelen(ce));
 }
 
diff --git a/wrapper.c b/wrapper.c
index 4017bff..10a6750 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -333,3 +333,8 @@ int rmdir_or_warn(const char *file)
 {
 	return warn_if_unremovable("rmdir", file, rmdir(file));
 }
+
+int remove_or_warn(unsigned int mode, const char *file)
+{
+	return S_ISGITLINK(mode) ? rmdir_or_warn(file) : unlink_or_warn(file);
+}
-- 
1.6.5
