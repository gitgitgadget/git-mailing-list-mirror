From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: [PATCH v2 2/6] Case insensitivity support for .gitignore via
 core.ignorecase
Date: Sat, 02 Oct 2010 22:32:34 -0600
Message-ID: <20101003043234.1960.12596.stgit@SlamDunk>
References: <20101003043221.1960.73178.stgit@SlamDunk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: j6t@kdbg.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 06:32:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2GFk-0005hQ-Ls
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 06:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328Ab0JCEcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 00:32:35 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:49485 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153Ab0JCEce (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 00:32:34 -0400
Received: (qmail 1298 invoked by uid 399); 2 Oct 2010 22:32:32 -0600
Received: from unknown (HELO ?192.168.56.1?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 2 Oct 2010 22:32:32 -0600
X-Originating-IP: 76.27.116.215
In-Reply-To: <20101003043221.1960.73178.stgit@SlamDunk>
User-Agent: StGit/0.15-60-g0641
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157820>

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
---
 dir.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/dir.c b/dir.c
index ffa410d..63d7b41 100644
--- a/dir.c
+++ b/dir.c
@@ -436,14 +436,14 @@ int excluded_from_list(const char *pathname,
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
@@ -458,14 +458,14 @@ int excluded_from_list(const char *pathname,
 
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
