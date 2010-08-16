From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 2/6] Case insensitivity support for .gitignore via core.ignorecase
Date: Mon, 16 Aug 2010 21:38:10 +0200
Message-ID: <0207df477b402bacf5792a6c9cb410e924501b27.1281985411.git.j6t@kdbg.org>
References: <cover.1281985411.git.j6t@kdbg.org>
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 16 21:39:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ol5Wq-0007Pw-MG
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 21:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203Ab0HPTii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Aug 2010 15:38:38 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:59106 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932176Ab0HPTie (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Aug 2010 15:38:34 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 41077CDF86;
	Mon, 16 Aug 2010 21:38:33 +0200 (CEST)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id F1F7A19F5AE;
	Mon, 16 Aug 2010 21:38:32 +0200 (CEST)
X-Mailer: git-send-email 1.7.1.402.gf1eeb
In-Reply-To: <cover.1281985411.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153670>

From: Joshua Jensen <jjensen@workspacewhiz.com>

This is especially beneficial when using Windows and Perforce and the
git-p4 bridge. Internally, Perforce preserves a given file's full path
including its case at the time it was added to the Perforce repository.
When syncing a file down via Perforce, missing directories are created,
if necessary, using the case as stored with the filename. Unfortunately,
two files in the same directory can have differing cases for their
respective paths, such as /diRa/file1.c and /DirA/file2.c. Depending on
sync order, DirA/ may get created instead of diRa/.

It is possible to handle directory names in a case insensitive manner
without this patch, but it is highly inconvenient, requiring each
character to be specified like so: [Bb][Uu][Ii][Ll][Dd]. With this patch, the
gitignore exclusions honor the core.ignorecase=true configuration
setting and make the process less error prone. The above is specified
like so: Build

Signed-off-by: Joshua Jensen <jjensen@workspacewhiz.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 dir.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/dir.c b/dir.c
index 4d001fd..be21c20 100644
--- a/dir.c
+++ b/dir.c
@@ -390,14 +390,14 @@ int excluded_from_list(const char *pathname,
 			if (x->flags & EXC_FLAG_NODIR) {
 				/* match basename */
 				if (x->flags & EXC_FLAG_NOWILDCARD) {
-					if (!strcmp(exclude, basename))
+					if (!strcmp_icase(exclude, basename))
 						return to_exclude;
 				} else if (x->flags & EXC_FLAG_ENDSWITH) {
 					if (x->patternlen - 1 <= pathlen &&
-					    !strcmp(exclude + 1, pathname + pathlen - x->patternlen + 1))
+					    !strcmp_icase(exclude + 1, pathname + pathlen - x->patternlen + 1))
 						return to_exclude;
 				} else {
-					if (fnmatch(exclude, basename, 0) == 0)
+					if (fnmatch_icase(exclude, basename, 0) == 0)
 						return to_exclude;
 				}
 			}
@@ -412,14 +412,14 @@ int excluded_from_list(const char *pathname,
 
 				if (pathlen < baselen ||
 				    (baselen && pathname[baselen-1] != '/') ||
-				    strncmp(pathname, x->base, baselen))
+				    strncmp_icase(pathname, x->base, baselen))
 				    continue;
 
 				if (x->flags & EXC_FLAG_NOWILDCARD) {
-					if (!strcmp(exclude, pathname + baselen))
+					if (!strcmp_icase(exclude, pathname + baselen))
 						return to_exclude;
 				} else {
-					if (fnmatch(exclude, pathname+baselen,
+					if (fnmatch_icase(exclude, pathname+baselen,
 						    FNM_PATHNAME) == 0)
 					    return to_exclude;
 				}
-- 
1.7.1.402.gf1eeb
