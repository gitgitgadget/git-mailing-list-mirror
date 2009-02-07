From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/2] Let ls-files strip trailing slashes in submodules'
 paths
Date: Sat, 7 Feb 2009 14:43:03 +0100 (CET)
Message-ID: <2bff02915466796c36d93ac17435f4256c46403f.1234013924u.git.johannes.schindelin@gmx.de>
References: <7vfxiqy76k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 07 14:43:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVnTO-0000f3-Cy
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 14:43:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251AbZBGNm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 08:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753243AbZBGNm0
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 08:42:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:53658 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753140AbZBGNmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 08:42:25 -0500
Received: (qmail invoked by alias); 07 Feb 2009 13:42:22 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp026) with SMTP; 07 Feb 2009 14:42:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19wgWZgNVFwzdCAO70zcO/G8b1XpPrhzayUljvOUz
	U6u5xys5PEh9kL
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vfxiqy76k.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108851>

Tab completion makes it easy to add a trailing slash to a submodule path.
As it is completely clear what the user actually wanted to say, be nice
and strip that slash at the end.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-ls-files.c         |   21 ++++++++++++++++++++-
 t/t7400-submodule-basic.sh |    6 ++++++
 2 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 3434031..9dec282 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -262,6 +262,21 @@ static const char *verify_pathspec(const char *prefix)
 	return max ? xmemdupz(prev, max) : NULL;
 }
 
+static void strip_trailing_slash_from_submodules(void)
+{
+	const char **p;
+
+	for (p = pathspec; *p != NULL; p++) {
+		int len = strlen(*p), pos;
+
+		if (len < 1 || (*p)[len - 1] != '/')
+			continue;
+		pos = cache_name_pos(*p, len - 1);
+		if (pos >= 0 && S_ISGITLINK(active_cache[pos]->ce_mode))
+			*p = xstrndup(*p, len - 1);
+	}
+}
+
 /*
  * Read the tree specified with --with-tree option
  * (typically, HEAD) into stage #1 and then
@@ -510,6 +525,11 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 
 	pathspec = get_pathspec(prefix, argv + i);
 
+	/* be nice with submodule patsh ending in a slash */
+	read_cache();
+	if (pathspec)
+		strip_trailing_slash_from_submodules();
+
 	/* Verify that the pathspec matches the prefix */
 	if (pathspec)
 		prefix = verify_pathspec(prefix);
@@ -533,7 +553,6 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 	      show_killed | show_modified))
 		show_cached = 1;
 
-	read_cache();
 	if (prefix)
 		prune_cache(prefix);
 	if (with_tree) {
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 2ec7ac6..a74f24c 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -234,4 +234,10 @@ test_expect_success 'gracefully add submodule with a trailing slash' '
 
 '
 
+test_expect_success 'ls-files gracefully handles trailing slash' '
+
+	test "init" = "$(git ls-files init/)"
+
+'
+
 test_done
-- 
1.6.1.2.630.g01a7e
