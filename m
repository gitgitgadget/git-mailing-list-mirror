From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Introduce core.keepHardLinks
Date: Mon, 13 Oct 2008 11:03:38 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810131058110.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0810111344241.22125@pacific.mpi-cbg.de.mpi-cbg.de> <7vskr1c976.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 10:58:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpJFh-0001XC-6w
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 10:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754790AbYJMI45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 04:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754942AbYJMI45
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 04:56:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:43137 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754773AbYJMI44 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 04:56:56 -0400
Received: (qmail invoked by alias); 13 Oct 2008 08:56:54 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp019) with SMTP; 13 Oct 2008 10:56:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+l+xdBrb2lO/sPOXoa//LdSvOtXknYT1RjTiJf5I
	RLr2LfY62NRtlO
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <7vskr1c976.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98097>

Hi,

On Sun, 12 Oct 2008, Junio C Hamano wrote:

> Shawn had this queued in pu, but it appears to even fail its own tests 
> on my machine, when applied on top of 'master'.

Sorry, I cannot reproduce at all.

I tested this on two machines, i686 and x86_64 (of course, on top of my 
patches to 'next', but now repeated the test with the commit 
cherry-picked to your 5c283eb(Merge branch 'maint')).

It passes.

Ciao,
Dscho

P.S.: I even made "make clean && make -j50 test", just in case  we have 
some dependency issue in the Makefile (happened before).  Still passes.

P.P.S.: It would be nice if you could run the test with -i -v (and maybe 
with sh -x) and post the output.  Thank you very much.

P.P.P.S.: Just for reference: this is what the cherry-picked commit 
format-patches to:

-- snipsnap --
[PATCH] Introduce core.keepHardLinks

When a tracked file was hard linked, we used to break the hard link
whenever Git writes to that file.  Make that optional.

To keep the implementation simple, mode changes will still break the
hard links.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt |    4 +++
 cache.h                  |    1 +
 config.c                 |    5 ++++
 entry.c                  |    7 ++++-
 environment.c            |    1 +
 t/t0056-hardlinked.sh    |   58 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 74 insertions(+), 2 deletions(-)
 create mode 100644 t/t0056-hardlinked.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index da18a54..aacaeae 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -207,6 +207,10 @@ core.symlinks::
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
index 991544c..d6348a1 100644
--- a/cache.h
+++ b/cache.h
@@ -478,6 +478,7 @@ enum rebase_setup_type {
 
 extern enum branch_track git_branch_track;
 extern enum rebase_setup_type autorebase;
+extern int keep_hard_links;
 
 #define GIT_REPO_VERSION 0
 extern int repository_format_version;
diff --git a/config.c b/config.c
index b8d289d..944e18e 100644
--- a/config.c
+++ b/config.c
@@ -490,6 +490,11 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.keephardlinks")) {
+		keep_hard_links = git_config_bool(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
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
index 0693cd9..ef721e0 100644
--- a/environment.c
+++ b/environment.c
@@ -42,6 +42,7 @@ enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
+int keep_hard_links = 0;
 
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
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
1.6.0.2.749.g0cc32
