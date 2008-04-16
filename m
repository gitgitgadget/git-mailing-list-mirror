From: Junio C Hamano <gitster@pobox.com>
Subject: [RFH] cleaning up "add across symlinks"
Date: Wed, 16 Apr 2008 13:53:47 -0700
Message-ID: <7vd4oppllw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 23:04:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmEeU-00088b-Jz
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 22:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbYDPUx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 16:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbYDPUx4
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 16:53:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44087 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932397AbYDPUxz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 16:53:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 670352DF2;
	Wed, 16 Apr 2008 16:53:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 3FAE32DF1; Wed, 16 Apr 2008 16:53:49 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79749>

If you have this structure in your work tree:

	lrwxrwxrwx a -> c
	drwxrwxrwx c
	-rw-rw-rw- c/b

and let million monkeys give random paths to "git-update-index --add" or
"git add", you should end up with the index with two entries, a symlink
"a" and file "c/b".

Not so.  If an unfortunate monkey says "git add a/b", we happily add it to
the index, because we notice lstat("a/b") succeeds and assume that there
is such a path.  There isn't, as far as git is concerned, because we track
symbolic links.

The attached is still rough, in that while I think the commands prevent
such bogosities from entering the index, their reporting of the failure is
suboptimal.

For example, if you run the new test script added with this commit, the
error message from "update-index" would say "a/b does not exist", while it
might be true from the point of view of git, it is not from the end user's
point of view (IOW, the message may need to be reworded to read "not
adding a/b because leading path component a is a symlink --- add a itself,
or not add anything at all").  Similarly, the "git add a/b" should report
that it did not add a/b, but it doesn't.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-update-index.c            |   10 ++++++
 dir.c                             |    5 +++
 symlinks.c                        |    4 +-
 t/t2210-add-not-across-symlink.sh |   64 +++++++++++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+), 2 deletions(-)
 create mode 100755 t/t2210-add-not-across-symlink.sh

diff --git a/builtin-update-index.c b/builtin-update-index.c
index a8795d3..24f3180 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -27,6 +27,8 @@ static int mark_valid_only;
 #define MARK_VALID 1
 #define UNMARK_VALID 2
 
+static char last_symlink_cache[PATH_MAX];
+
 static void report(const char *fmt, ...)
 {
 	va_list vp;
@@ -201,6 +203,14 @@ static int process_path(const char *path)
 	if (lstat(path, &st) < 0)
 		return process_lstat_error(path, errno);
 
+	/*
+	 * If "a" is a symlink and the caller gives "a/b", that is
+	 * a nonsense.  As far as git is concerned, there is no such
+	 * file in the work tree.
+	 */
+	if (has_symlink_leading_path(path, last_symlink_cache))
+		return process_lstat_error(path, ENOENT);
+
 	len = strlen(path);
 	if (S_ISDIR(st.st_mode))
 		return process_directory(path, len, &st);
diff --git a/dir.c b/dir.c
index d79762c..e91fed6 100644
--- a/dir.c
+++ b/dir.c
@@ -49,6 +49,11 @@ int common_prefix(const char **pathspec)
 			break;
 		}
 	}
+	if (prefix) {
+		int sym = has_symlink_leading_path(path, NULL);
+		if (sym && sym < prefix)
+			return sym;
+	}
 	return prefix;
 }
 
diff --git a/symlinks.c b/symlinks.c
index be9ace6..9d9116e 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -15,7 +15,7 @@ int has_symlink_leading_path(const char *name, char *last_symlink)
 		if (last_len < len &&
 		    !strncmp(name, last_symlink, last_len) &&
 		    name[last_len] == '/')
-			return 1;
+			return last_len;
 		*last_symlink = '\0';
 	}
 
@@ -37,7 +37,7 @@ int has_symlink_leading_path(const char *name, char *last_symlink)
 		if (S_ISLNK(st.st_mode)) {
 			if (last_symlink)
 				strcpy(last_symlink, path);
-			return 1;
+			return len;
 		}
 
 		dp[len++] = '/';
diff --git a/t/t2210-add-not-across-symlink.sh b/t/t2210-add-not-across-symlink.sh
new file mode 100755
index 0000000..102d407
--- /dev/null
+++ b/t/t2210-add-not-across-symlink.sh
@@ -0,0 +1,64 @@
+#!/bin/sh
+
+test_description='index not getting confused by intermediate symlinks'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	( echo a; echo c/b ) >expect &&
+	mkdir c &&
+	>c/b &&
+	ln -s c a &&
+	git update-index --add a c/b &&
+
+	git ls-files >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'update-index confusion (1)' '
+	test_must_fail git update-index --add a/b &&
+
+	git ls-files >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'update-index confusion (2)' '
+	test_must_fail git update-index --add a/b &&
+
+	git ls-files >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'add confusion (0)' '
+
+	git add a/b c
+
+	git ls-files >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'add confusion (1)' '
+
+	git add a/b
+
+	git ls-files >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'add confusion (2)' '
+
+	git add a
+
+	git ls-files >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'add confusion (3)' '
+
+	test_must_fail git add "a/*" &&
+
+	git ls-files >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.5.5.120.gea9a0
