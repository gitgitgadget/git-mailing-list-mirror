From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: [PATCH 2/7] Case insensitivity support for .gitignore via core.ignorecase
Date: Thu, 20 May 2010 22:50:30 -0600
Message-ID: <1274417435-2344-3-git-send-email-jjensen@workspacewhiz.com>
References: <1274417435-2344-1-git-send-email-jjensen@workspacewhiz.com>
Cc: Joshua Jensen <jjensen@workspacewhiz.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 21 06:50:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFKCD-0007X7-BK
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 06:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754099Ab0EUEus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 00:50:48 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:39242 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116Ab0EUEuq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 00:50:46 -0400
Received: (qmail 28870 invoked by uid 399); 20 May 2010 22:50:45 -0600
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on jeltz.qwknetllc.net
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=14.0 tests=AWL,HELO_LH_LD,RDNS_NONE,
	SUBJECT_FUZZY_TION autolearn=disabled version=3.2.5
X-Virus-Scan: Scanned by ClamAV 0.95.2 (no viruses);
  Thu, 20 May 2010 22:50:45 -0600
Received: from unknown (HELO localhost.localdomain) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAMMM; 20 May 2010 22:50:44 -0600
X-Originating-IP: 76.27.116.215
X-Mailer: git-send-email 1.7.1.1930.gcd3ce
In-Reply-To: <1274417435-2344-1-git-send-email-jjensen@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147436>

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
index 21d2104..a19b7ab 100644
--- a/dir.c
+++ b/dir.c
@@ -409,14 +409,14 @@ int excluded_from_list(const char *pathname,
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
@@ -431,14 +431,14 @@ int excluded_from_list(const char *pathname,
 
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
1.7.1.1930.gca7dd4
