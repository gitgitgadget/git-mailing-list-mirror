From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: [PATCH] Added support for core.ignorecase when excluding gitignore
 entries
Date: Wed, 15 Jul 2009 23:19:05 -0600
Message-ID: <4A5EB849.1000803@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 07:25:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRJTc-0000hh-AR
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 07:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757508AbZGPFZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 01:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757505AbZGPFZp
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 01:25:45 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:35086 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757471AbZGPFZo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 01:25:44 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Jul 2009 01:25:44 EDT
Received: (qmail 31380 invoked by uid 399); 15 Jul 2009 23:19:01 -0600
Received: from unknown (HELO ?192.168.1.107?) (jjensen@workspacewhiz.com@24.10.200.9)
  by hsmail.qwknetllc.com with ESMTPAM; 15 Jul 2009 23:19:01 -0600
X-Originating-IP: 24.10.200.9
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123364>

This patch allows core.ignorecase=true to work properly with gitignore 
exclusions.

This is especially beneficial when using Windows and Perforce and the 
git-p4 bridge.  Perforce preserves a given file's full path including 
case.  When syncing a file down, directories are created, if necessary, 
using the case as stored with the filename.  Unfortunately, two files in 
the same directory can have differing cases for their respective paths, 
such as /dirA/file1.c and /DirA/file2.c.  Depending on sync order, DirA/ 
may get created instead of dirA/.

Trying to catch all case combinations for a set of gitignore entries is 
very difficult.  Having the exclusions honor the core.ignorecase=true 
makes the process less error prone.
---
 dir.c |   49 ++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/dir.c b/dir.c
index 0e6b752..c63e0a0 100644
--- a/dir.c
+++ b/dir.c
@@ -315,14 +315,25 @@ static int excluded_1(const char *pathname,
             if (x->flags & EXC_FLAG_NODIR) {
                 /* match basename */
                 if (x->flags & EXC_FLAG_NOWILDCARD) {
-                    if (!strcmp(exclude, basename))
-                        return to_exclude;
+                    if (ignore_case) {
+                        if (!strcasecmp(exclude, basename))
+                            return to_exclude;
+                    } else {
+                        if (!strcmp(exclude, basename))
+                            return to_exclude;
+                    }
                 } else if (x->flags & EXC_FLAG_ENDSWITH) {
-                    if (x->patternlen - 1 <= pathlen &&
-                        !strcmp(exclude + 1, pathname + pathlen - 
x->patternlen + 1))
-                        return to_exclude;
+                    if (ignore_case) {
+                        if (x->patternlen - 1 <= pathlen &&
+                            !strcasecmp(exclude + 1, pathname + pathlen 
- x->patternlen + 1))
+                            return to_exclude;
+                    } else {
+                        if (x->patternlen - 1 <= pathlen &&
+                            !strcmp(exclude + 1, pathname + pathlen - 
x->patternlen + 1))
+                            return to_exclude;
+                    }
                 } else {
-                    if (fnmatch(exclude, basename, 0) == 0)
+                    if (fnmatch(exclude, basename, ignore_case ? 
FNM_CASEFOLD : 0) == 0)
                         return to_exclude;
                 }
             }
@@ -335,17 +346,29 @@ static int excluded_1(const char *pathname,
                 if (*exclude == '/')
                     exclude++;
 
-                if (pathlen < baselen ||
-                    (baselen && pathname[baselen-1] != '/') ||
-                    strncmp(pathname, x->base, baselen))
-                    continue;
+                if (ignore_case) {
+                    if (pathlen < baselen ||
+                        (baselen && pathname[baselen-1] != '/') ||
+                        strncasecmp(pathname, x->base, baselen))
+                        continue;
+                } else {
+                    if (pathlen < baselen ||
+                        (baselen && pathname[baselen-1] != '/') ||
+                        strncmp(pathname, x->base, baselen))
+                        continue;
+                }
 
                 if (x->flags & EXC_FLAG_NOWILDCARD) {
-                    if (!strcmp(exclude, pathname + baselen))
-                        return to_exclude;
+                    if (ignore_case) {
+                        if (!strcasecmp(exclude, pathname + baselen))
+                            return to_exclude;
+                    } else {
+                        if (!strcmp(exclude, pathname + baselen))
+                            return to_exclude;
+                    }
                 } else {
                     if (fnmatch(exclude, pathname+baselen,
-                            FNM_PATHNAME) == 0)
+                            FNM_PATHNAME | (ignore_case ? FNM_CASEFOLD 
: 0)) == 0)
                         return to_exclude;
                 }
             }
-- 
1.6.3.2.1299.gee46c.dirty
