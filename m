From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] rerere: make sure it works even in a workdir attached to a
 young repository
Date: Thu, 10 Mar 2011 16:46:40 -0800
Message-ID: <7vr5ae1o27.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 11 01:46:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxqVH-0008DN-VO
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 01:46:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753660Ab1CKAqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 19:46:47 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38169 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248Ab1CKAqq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 19:46:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 305D83DED;
	Thu, 10 Mar 2011 19:48:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=v
	fS0mdyrLOax7oe0W6I0cE2+DOE=; b=Fvyk6pulRYggPs1+foHAEbG0VybXF77sm
	rSdF6F2jme7FHGHAfPIyo8VonatdrbttuNOCWNJuG9I/BRiQ1T85QNF8zOFXEcvJ
	RZkdnNyqOrvNk/hhInuMD0e+37whToejpnuECmQaFYEBHojozL5cYSq9m9C3Eq+E
	7LM3SdYlqc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=b6j
	BmfjFToqiTrpcKdfHMiXQJ6UsmqjlaEQNsA4+vQe4YOnYuhNTG8mzoH03DAx8nUp
	Pg1jFV9OC//HaBZ/AqsM8wQaHMpurfCB7V11WOjX1GIIbqTDo5ZrL82v+6GeUoq9
	oE77xOKzjkX5F61nnAZ5Xm28Cd0pK+65AhLa4M70=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1E0853DEC;
	Thu, 10 Mar 2011 19:48:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0EEFB3DEB; Thu, 10 Mar 2011
 19:48:11 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3EF44C70-4B79-11E0-8DE6-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168873>

The git-new-workdir script in contrib/ makes a new work tree by sharing
many subdirectories of the .git directory with the original repository.
When rerere.enabled is set in the original repository, but the user has
not encountered any conflicts yet, the original repository may not yet
have .git/rr-cache directory.

When rerere wants to run in a new work tree created from such a young
original repository, it fails to mkdir(2) .git/rr-cache that is a symlink
to a yet-to-be-created directory.

There are three possible approaches to this:

 - A naive solution is not to create a symlink in the git-new-workdir
   script to a directory the original does not have (yet).  This is not a
   solution, as we tend to lazily create subdirectories of .git/, and
   having rerere.enabled configuration set is a strong indication that the
   user _wants_ to have this lazy creation to happen;

 - We could always create .git/rr-cache upon repository creation.  This is
   tempting but will not help people with existing repositories.

 - Detect this case by seeing that mkdir(2) failed with EEXIST, checking
   that the path is a symlink, and try running mkdir(2) on the link
   target.

This patch solves the issue by doing the third one.

Signed-off-by: Junio C Hamano <gitster@pobox.com>

---

 * As the third test in the new test t1021 says, this is incomplete in
   that it does not attempt to handle relative symbolic link that points
   into the original repository.  It is good enough for a workdir the
   contrib script creates, but I wouldn't be surprised if there are
   scripts that creates a similar thin workdir using relative symbolic
   links, and this _will_ fail in such a setting.

 cache.h                      |    1 +
 rerere.c                     |    3 +-
 sha1_file.c                  |   29 +++++++++++++++++++++++
 t/t1021-rerere-in-workdir.sh |   52 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+), 2 deletions(-)
 create mode 100755 t/t1021-rerere-in-workdir.sh

diff --git a/cache.h b/cache.h
index 6e54993..2eddee7 100644
--- a/cache.h
+++ b/cache.h
@@ -674,6 +674,7 @@ int set_shared_perm(const char *path, int mode);
 #define adjust_shared_perm(path) set_shared_perm((path), 0)
 int safe_create_leading_directories(char *path);
 int safe_create_leading_directories_const(const char *path);
+int mkdir_in_gitdir(const char *path);
 extern char *expand_user_path(const char *path);
 char *enter_repo(char *path, int strict);
 static inline int is_absolute_path(const char *path)
diff --git a/rerere.c b/rerere.c
index a59f74f..2d8de61 100644
--- a/rerere.c
+++ b/rerere.c
@@ -522,8 +522,7 @@ static int is_rerere_enabled(void)
 	if (rerere_enabled < 0)
 		return rr_cache_exists;
 
-	if (!rr_cache_exists &&
-	    (mkdir(rr_cache, 0777) || adjust_shared_perm(rr_cache)))
+	if (!rr_cache_exists && mkdir_in_gitdir(rr_cache))
 		die("Could not create directory %s", rr_cache);
 	return 1;
 }
diff --git a/sha1_file.c b/sha1_file.c
index c23cc5e..0926643 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -42,6 +42,35 @@ static inline int offset_1st_component(const char *path)
 	return *path == '/';
 }
 
+int mkdir_in_gitdir(const char *path)
+{
+	if (mkdir(path, 0777)) {
+		int saved_errno = errno;
+		struct stat st;
+		struct strbuf sb = STRBUF_INIT;
+
+		if (errno != EEXIST)
+			return -1;
+		/*
+		 * Are we looking at a path in a symlinked worktree
+		 * whose original repository does not yet have it?
+		 * e.g. .git/rr-cache pointing at its original
+		 * repository in which the user hasn't performed any
+		 * conflict resolution yet?
+		 */
+		if (lstat(path, &st) || !S_ISLNK(st.st_mode) ||
+		    strbuf_readlink(&sb, path, st.st_size) ||
+		    !is_absolute_path(sb.buf) ||
+		    mkdir(sb.buf, 0777)) {
+			strbuf_release(&sb);
+			errno = saved_errno;
+			return -1;
+		}
+		strbuf_release(&sb);
+	}
+	return adjust_shared_perm(path);
+}
+
 int safe_create_leading_directories(char *path)
 {
 	char *pos = path + offset_1st_component(path);
diff --git a/t/t1021-rerere-in-workdir.sh b/t/t1021-rerere-in-workdir.sh
new file mode 100755
index 0000000..ec8621c
--- /dev/null
+++ b/t/t1021-rerere-in-workdir.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+
+test_description='rerere run in a workdir'
+. ./test-lib.sh
+
+test_expect_success SYMLINKS setup '
+	git config rerere.enabled true &&
+	>world &&
+	git add world &&
+	test_tick &&
+	git commit -m initial &&
+
+	echo hello >world &&
+	test_tick &&
+	git commit -a -m hello &&
+
+	git checkout -b side HEAD^ &&
+	echo goodbye >world &&
+	test_tick &&
+	git commit -a -m goodbye &&
+
+	git checkout master
+'
+
+test_expect_success SYMLINKS 'rerere in workdir' '
+	rm -rf .git/rr-cache &&
+	"$SHELL_PATH" "$TEST_DIRECTORY/../contrib/workdir/git-new-workdir" . work &&
+	(
+		cd work &&
+		test_must_fail git merge side &&
+		git rerere status >actual &&
+		echo world >expect &&
+		test_cmp expect actual
+	)
+'
+
+# This fails because we don't resolve relative symlink in mkdir_in_gitdir()
+test_expect_failure SYMLINKS 'rerere in workdir (relative)' '
+	rm -rf .git/rr-cache &&
+	"$SHELL_PATH" "$TEST_DIRECTORY/../contrib/workdir/git-new-workdir" . krow &&
+	(
+		cd krow &&
+		rm -f .git/rr-cache &&
+		ln -s ../.git/rr-cache .git/rr-cache &&
+		test_must_fail git merge side &&
+		git rerere status >actual &&
+		echo world >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_done
-- 
1.7.4.1.373.g37629
