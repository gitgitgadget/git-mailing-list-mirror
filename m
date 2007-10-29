From: Lars Knoll <lars@trolltech.com>
Subject: [PATCH] Speedup scanning for excluded files.
Date: Mon, 29 Oct 2007 09:45:26 +0200
Organization: Trolltech
Message-ID: <200710290845.26727.lars@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 29 08:45:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImPJe-0006YJ-NC
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 08:45:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635AbXJ2Hp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 03:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752189AbXJ2Hp3
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 03:45:29 -0400
Received: from esparsett.troll.no ([62.70.27.18]:49724 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095AbXJ2Hp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 03:45:28 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 3B04F741CF
	for <git@vger.kernel.org>; Mon, 29 Oct 2007 08:45:27 +0100 (CET)
Received: from dahab.troll.no (dahab.troll.no [10.3.4.8])
	by esparsett.troll.no (Postfix) with ESMTP id 24DF1741C4
	for <git@vger.kernel.org>; Mon, 29 Oct 2007 08:45:27 +0100 (CET)
User-Agent: KMail/1.9.6
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62608>

Try to avoid a lot of work while scanning for excluded files,
by caching some more information when setting up the exclusion
data structure.

Speeds up 'git runstatus' on a repository containing the Qt sources by 30% and 
reduces the amount of instructions executed (as measured by valgrind) by a 
factor of 2.
---

I did a short timing measurement on the git repository itself, the timings 
without and with the patch give:

[lars@dahab git (speedup)]$ time git runstatus > /dev/null

real    0m0.098s
user    0m0.068s
sys     0m0.020s
[lars@dahab git (speedup)]$ time ./git runstatus > /dev/null

real    0m0.033s
user    0m0.012s
sys     0m0.016s

Cheers,
Lars

 dir.c |   58 ++++++++++++++++++++++++++++++++++++++++++----------------
 dir.h |    7 +++++++
 2 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/dir.c b/dir.c
index 4c17d36..7bb5add 100644
--- a/dir.c
+++ b/dir.c
@@ -118,14 +118,32 @@ int match_pathspec(const char **pathspec, const char 
*name, int namelen, int pre
 	return retval;
 }
 
+static int no_wildcard(const char *string)
+{
+    return !strchr(string, '*') && !strchr(string, '?') 
&& !strchr(string, '[') && !strchr(string, '{');
+}
+
 void add_exclude(const char *string, const char *base,
 		 int baselen, struct exclude_list *which)
 {
 	struct exclude *x = xmalloc(sizeof (*x));
 
+        x->to_exclude = 1;
+        if (*string == '!') {
+            x->to_exclude = 0;
+            string++;
+        }
 	x->pattern = string;
+        x->patternlen = strlen(string);
 	x->base = base;
 	x->baselen = baselen;
+        x->flags = 0;
+        if (!strchr(string, '/'))
+            x->flags |= EXC_FLAG_NODIR;
+        if (no_wildcard(string))
+            x->flags |= EXC_FLAG_NOWILDCARD;
+        if (*string == '*' && no_wildcard(string+1))
+            x->flags |= EXC_FLAG_ENDSWITH;
 	if (which->nr == which->alloc) {
 		which->alloc = alloc_nr(which->alloc);
 		which->excludes = xrealloc(which->excludes,
@@ -209,7 +227,7 @@ void pop_exclude_per_directory(struct dir_struct *dir, int 
stk)
  * Return 1 for exclude, 0 for include and -1 for undecided.
  */
 static int excluded_1(const char *pathname,
-		      int pathlen,
+		      int pathlen, const char *basename, 
 		      struct exclude_list *el)
 {
 	int i;
@@ -218,19 +236,20 @@ static int excluded_1(const char *pathname,
 		for (i = el->nr - 1; 0 <= i; i--) {
 			struct exclude *x = el->excludes[i];
 			const char *exclude = x->pattern;
-			int to_exclude = 1;
+			int to_exclude = x->to_exclude;
 
-			if (*exclude == '!') {
-				to_exclude = 0;
-				exclude++;
-			}
-
-			if (!strchr(exclude, '/')) {
+			if (x->flags & EXC_FLAG_NODIR) {
 				/* match basename */
-				const char *basename = strrchr(pathname, '/');
-				basename = (basename) ? basename+1 : pathname;
-				if (fnmatch(exclude, basename, 0) == 0)
-					return to_exclude;
+                            if (x->flags & EXC_FLAG_NOWILDCARD) {
+                                if (!strcmp(exclude, basename))
+                                    return to_exclude;
+                            } else if (x->flags & EXC_FLAG_ENDSWITH) {
+                                if (!strcmp(exclude + 1, pathname + 
pathlen -x->patternlen + 1))
+                                    return to_exclude;
+                            } else {
+                                if (fnmatch(exclude, basename, 0) == 0)
+                                    return to_exclude;
+                            }
 			}
 			else {
 				/* match with FNM_PATHNAME:
@@ -246,10 +265,15 @@ static int excluded_1(const char *pathname,
 				    strncmp(pathname, x->base, baselen))
 				    continue;
 
-				if (fnmatch(exclude, pathname+baselen,
-					    FNM_PATHNAME) == 0)
+                                if (x->flags & EXC_FLAG_NOWILDCARD) {
+                                    if (!strcmp(exclude, pathname + baselen))
+                                        return to_exclude;
+                                } else {
+                                    if (fnmatch(exclude, pathname+baselen,
+                                                FNM_PATHNAME) == 0)
 					return to_exclude;
-			}
+                                }
+                        }
 		}
 	}
 	return -1; /* undecided */
@@ -259,9 +283,11 @@ int excluded(struct dir_struct *dir, const char 
*pathname)
 {
 	int pathlen = strlen(pathname);
 	int st;
+        const char *basename = strrchr(pathname, '/');
+        basename = (basename) ? basename+1 : pathname;
 
 	for (st = EXC_CMDL; st <= EXC_FILE; st++) {
-		switch (excluded_1(pathname, pathlen, &dir->exclude_list[st])) {
+		switch (excluded_1(pathname, pathlen, basename, &dir->exclude_list[st])) {
 		case 0:
 			return 0;
 		case 1:
diff --git a/dir.h b/dir.h
index a248a23..4dc3c6e 100644
--- a/dir.h
+++ b/dir.h
@@ -17,13 +17,20 @@ struct dir_entry {
 	char name[FLEX_ARRAY]; /* more */
 };
 
+#define EXC_FLAG_NODIR 1
+#define EXC_FLAG_NOWILDCARD 2
+#define EXC_FLAG_ENDSWITH 4
+
 struct exclude_list {
 	int nr;
 	int alloc;
 	struct exclude {
 		const char *pattern;
+                int patternlen;            
 		const char *base;
 		int baselen;
+                int to_exclude;
+                int flags;
 	} **excludes;
 };
 
-- 
1.5.3.4.383.gd90a7
