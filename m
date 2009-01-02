From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RESEND PATCH] git add: do not add files from a submodule
Date: Fri, 2 Jan 2009 19:08:40 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901021715370.27818@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jan 02 19:10:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIoTG-0002tl-37
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 19:10:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759171AbZABSIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 13:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758773AbZABSIP
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 13:08:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:51563 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759262AbZABSIN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 13:08:13 -0500
Received: (qmail invoked by alias); 02 Jan 2009 18:08:10 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 02 Jan 2009 19:08:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19BYKtb8b5BzARujBNcUxpCEsg8NydfFYqNIo81wv
	jmnIFXqSY4Vzfl
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104395>


It comes quite as a surprise to an unsuspecting Git user that calling
"git add submodule/file" (which is a mistake, alright) _removes_
the submodule in the index, and adds the file.  Instead, complain loudly.

While at it, be nice when the user said "git add submodule/" which is
most likely the consequence of tab-completion, and stage the submodule,
instead of trying to add the contents of that directory.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Okay, so I let this slip for way too long.  AFAIR I waited for
	a few patches to go into 'next', and it was in an -rc cycle.

	Happily, the patches seem to be in, and we're out of -rc.

	Looking over the patch again, I do not find anything obviously
	wrong, but certainly somebody will.

 builtin-add.c              |   28 ++++++++++++++++++++++++++++
 t/t7400-submodule-basic.sh |   25 +++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 719de8b..ac98c83 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -68,6 +68,33 @@ static void prune_directory(struct dir_struct *dir, const char **pathspec, int p
         free(seen);
 }
 
+static void treat_gitlinks(const char **pathspec)
+{
+	int i;
+
+	if (!pathspec || !*pathspec)
+		return;
+
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *ce = active_cache[i];
+		if (S_ISGITLINK(ce->ce_mode)) {
+			int len = ce_namelen(ce), j;
+			for (j = 0; pathspec[j]; j++) {
+				int len2 = strlen(pathspec[j]);
+				if (len2 <= len || pathspec[j][len] != '/' ||
+				    memcmp(ce->name, pathspec[j], len))
+					continue;
+				if (len2 == len + 1)
+					/* strip trailing slash */
+					pathspec[j] = xstrndup(ce->name, len);
+				else
+					die ("Path '%s' is in submodule '%.*s'",
+						pathspec[j], len, ce->name);
+			}
+		}
+	}
+}
+
 static void fill_directory(struct dir_struct *dir, const char **pathspec,
 		int ignored_too)
 {
@@ -261,6 +288,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	if (read_cache() < 0)
 		die("index file corrupt");
+	treat_gitlinks(pathspec);
 
 	if (add_new_files)
 		/* This picks up the paths that are not tracked */
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index be73f7b..2ec7ac6 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -209,4 +209,29 @@ test_expect_success 'update --init' '
 
 '
 
+test_expect_success 'do not add files from a submodule' '
+
+	git reset --hard &&
+	test_must_fail git add init/a
+
+'
+
+test_expect_success 'gracefully add submodule with a trailing slash' '
+
+	git reset --hard &&
+	git commit -m "commit subproject" init &&
+	(cd init &&
+	 echo b > a) &&
+	git add init/ &&
+	git diff --exit-code --cached init &&
+	commit=$(cd init &&
+	 git commit -m update a >/dev/null &&
+	 git rev-parse HEAD) &&
+	git add init/ &&
+	test_must_fail git diff --exit-code --cached init &&
+	test $commit = $(git ls-files --stage |
+		sed -n "s/^160000 \([^ ]*\).*/\1/p")
+
+'
+
 test_done
-- 
1.6.1.rc3.224.g95ac9
