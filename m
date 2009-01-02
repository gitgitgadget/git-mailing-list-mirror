From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH RESEND] Introduce core.keepHardLinks
Date: Fri, 2 Jan 2009 19:07:46 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901021218000.27818@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jan 02 19:08:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIoS4-0002Vo-Of
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 19:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758562AbZABSHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 13:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758718AbZABSHX
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 13:07:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:47614 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758356AbZABSHV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 13:07:21 -0500
Received: (qmail invoked by alias); 02 Jan 2009 18:07:17 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp004) with SMTP; 02 Jan 2009 19:07:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX185usx6eK05MvWsb6FtGwvwQR+0dacXpev74ygxaU
	9UhBpddgWKPHFA
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104390>


When a tracked file was hard linked, we used to break the hard link
whenever Git writes to that file.

In some situations, this behavior is less-than-desirable, especially
given the fact that some popular editors do not do that, such as
(in alphabetical order) emacs and vi.

So teach Git not to break hard links when the config variable
core.keepHardLinks is set to true.  For backwards compatibility, this
variable defaults to false.

>From a safety viewpoint, nothing really changes, as to keep hard links,
Git will now open the files it updates with O_TRUNC instead of deleting
them first and then opening them with O_EXCL.

To keep the implementation simple, mode changes will still break the
hard links.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Only the commit message was modified since last time, to
	provide a better justification for the patch.

 Documentation/config.txt |    4 +++
 cache.h                  |    1 +
 config.c                 |    4 +++
 entry.c                  |    7 ++++-
 environment.c            |    1 +
 t/t0056-hardlinked.sh    |   58 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 73 insertions(+), 2 deletions(-)
 create mode 100644 t/t0056-hardlinked.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7408bb2..086d8a4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -209,6 +209,10 @@ core.symlinks::
 	file. Useful on filesystems like FAT that do not support
 	symbolic links. True by default.
 
+core.keepHardLinks::
+	If true, do not break hard links by deleting and recreating the
+	files.  Off by default.
+
 core.gitProxy::
 	A "proxy command" to execute (as 'command host port') instead
 	of establishing direct connection to the remote server when
diff --git a/cache.h b/cache.h
index 231c06d..a9c5812 100644
--- a/cache.h
+++ b/cache.h
@@ -538,6 +538,7 @@ enum rebase_setup_type {
 
 extern enum branch_track git_branch_track;
 extern enum rebase_setup_type autorebase;
+extern int keep_hard_links;
 
 #define GIT_REPO_VERSION 0
 extern int repository_format_version;
diff --git a/config.c b/config.c
index 790405a..8ff2b4b 100644
--- a/config.c
+++ b/config.c
@@ -492,6 +492,10 @@ static int git_default_core_config(const char *var, const char *value)
 
 	if (!strcmp(var, "core.preloadindex")) {
 		core_preload_index = git_config_bool(var, value);
+	}
+
+	if (!strcmp(var, "core.keephardlinks")) {
+		keep_hard_links = git_config_bool(var, value);
 		return 0;
 	}
 
diff --git a/entry.c b/entry.c
index aa2ee46..dfddf83 100644
--- a/entry.c
+++ b/entry.c
@@ -82,7 +82,8 @@ static void remove_subtree(const char *path)
 static int create_file(const char *path, unsigned int mode)
 {
 	mode = (mode & 0100) ? 0777 : 0666;
-	return open(path, O_WRONLY | O_CREAT | O_EXCL, mode);
+	return open(path, O_WRONLY | O_CREAT |
+			(keep_hard_links ? O_TRUNC : O_EXCL), mode);
 }
 
 static void *read_blob_entry(struct cache_entry *ce, const char *path, unsigned long *size)
@@ -225,7 +226,9 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *t
 			if (!state->force)
 				return error("%s is a directory", path);
 			remove_subtree(path);
-		} else if (unlink(path))
+		} else if ((!keep_hard_links || !S_ISREG(st.st_mode) ||
+					st.st_mode != ce->ce_mode) &&
+				unlink(path))
 			return error("unable to unlink old '%s' (%s)", path, strerror(errno));
 	} else if (state->not_new)
 		return 0;
diff --git a/environment.c b/environment.c
index e278bce..fc91809 100644
--- a/environment.c
+++ b/environment.c
@@ -42,6 +42,7 @@ enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
+int keep_hard_links = 0;
 
 /* Parallel index stat data preload? */
 int core_preload_index = 0;
diff --git a/t/t0056-hardlinked.sh b/t/t0056-hardlinked.sh
new file mode 100644
index 0000000..934c2bc
--- /dev/null
+++ b/t/t0056-hardlinked.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+
+test_description='read-tree and checkout respect hardlinked files'
+
+. ./test-lib.sh
+
+cat > file << EOF
+1. Nf3 Nf6 2. c4 g6 3. Nc3 Bg7 4. d4 O-O 5. Bf4 d5 6. Qb3 dxc4 7. Qxc4 c6
+8. e4 Nbd7 9. Rd1 Nb6 10. Qc5 Bg4 11. Bg5 Na4 12. Qa3 Nxc3 13. bxc3 Nxe4
+14. Bxe7 Qb6 15. Bc4 Nxc3 16. Bc5 Rfe8+ 17. Kf1 Be6 18. Bxb6 Bxc4+ 19. Kg1 Ne2+
+20. Kf1 Nxd4+ 21. Kg1 Ne2+ 22. Kf1 Nc3+ 23. Kg1 axb6 24. Qb4 Ra4 25. Qxb6 Nxd1
+26. h3 Rxa2 27. Kh2 Nxf2 28. Re1 Rxe1 29. Qd8+ Bf8 30. Nxe1 Bd5 31. Nf3 Ne4
+32. Qb8 b5 33. h4 h5 34. Ne5 Kg7 35. Kg1 Bc5+ 36. Kf1 Ng3+ 37. Ke1 Bb4+
+38. Kd1 Bb3+ 39. Kc1 Ne2+ 40. Kb1 Nc3+
+EOF
+
+ln file link || {
+	say "Could not hard link; skipping test"
+	test_done
+	exit
+}
+
+test_expect_success setup '
+
+	git config core.keepHardLinks true &&
+	test_cmp file link &&
+	cp file old &&
+	git add file &&
+	test_tick &&
+	git commit -m initial &&
+	echo "41. Kc1 Rc2#" >> file &&
+	git add file &&
+	test_tick &&
+	git commit -m 2nd &&
+	test_cmp file link &&
+	! test_cmp file old
+
+'
+
+test_expect_success 'checking a file out does not break the hard link' '
+
+	git checkout HEAD^ -- file &&
+	test_cmp file link &&
+	test_cmp file old
+
+'
+
+test_expect_success 'read-tree -u -m does not break the hard link' '
+
+	git reset --hard &&
+	test_cmp file link &&
+	git read-tree -u -m HEAD^ &&
+	test_cmp file link &&
+	test_cmp file old
+
+'
+
+test_done
-- 
1.6.1.rc3.224.g95ac9
