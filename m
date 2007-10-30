From: Lars Knoll <lars@trolltech.com>
Subject: [PATCH v3] Speedup scanning for excluded files.
Date: Tue, 30 Oct 2007 09:46:01 +0200
Organization: Trolltech
Message-ID: <200710300846.02010.lars@trolltech.com>
References: <200710290845.26727.lars@trolltech.com> <7vzly1sc7p.fsf@gitster.siamese.dyndns.org> <200710300828.49840.lars@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Morten Welinder" <mwelinder@gmail.com>, git@vger.kernel.org,
	"Pierre Habouzit" <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 08:46:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imlns-0001b1-Kw
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 08:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168AbXJ3HqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 03:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753110AbXJ3HqH
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 03:46:07 -0400
Received: from esparsett.troll.no ([62.70.27.18]:35411 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081AbXJ3HqE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 03:46:04 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id ADB74741FD; Tue, 30 Oct 2007 08:46:02 +0100 (CET)
Received: from dahab.troll.no (dahab.troll.no [10.3.4.8])
	by esparsett.troll.no (Postfix) with ESMTP
	id 95B7474195; Tue, 30 Oct 2007 08:46:02 +0100 (CET)
User-Agent: KMail/1.9.6
In-Reply-To: <200710300828.49840.lars@trolltech.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Try to avoid a lot of work scanning for excluded files,
by caching some more information when setting up the exclusion
data structure.

Speeds up 'git runstatus' on a repository containing the Qt sources by 30% and
reduces the amount of instructions executed (as measured by valgrind) by a
factor of 2. A 'git runstatus' on the git repository goes from 100M instructions
down to about 22M.

Signed-off-by: Lars Knoll <lars@trolltech.com>
---

Included an out of bounds check for the issue Morten found.

 dir.c |   61 ++++++++++++++++++++++++++++++++++++++++++++-----------------
 dir.h |    7 +++++++
 2 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/dir.c b/dir.c
index 4c17d36..b3d7462 100644
--- a/dir.c
+++ b/dir.c
@@ -118,14 +118,32 @@ int match_pathspec(const char **pathspec, const char *name, int namelen, int pre
 	return retval;
 }
 
+static int no_wildcard(const char *string)
+{
+	return string[strcspn(string, "*?[{")] == '\0';
+}
+
 void add_exclude(const char *string, const char *base,
 		 int baselen, struct exclude_list *which)
 {
 	struct exclude *x = xmalloc(sizeof (*x));
 
+	x->to_exclude = 1;
+	if (*string == '!') {
+		x->to_exclude = 0;
+		string++;
+	}
 	x->pattern = string;
+	x->patternlen = strlen(string);
 	x->base = base;
 	x->baselen = baselen;
+	x->flags = 0;
+	if (!strchr(string, '/'))
+		x->flags |= EXC_FLAG_NODIR;
+	if (no_wildcard(string))
+		x->flags |= EXC_FLAG_NOWILDCARD;
+	if (*string == '*' && no_wildcard(string+1))
+		x->flags |= EXC_FLAG_ENDSWITH;
 	if (which->nr == which->alloc) {
 		which->alloc = alloc_nr(which->alloc);
 		which->excludes = xrealloc(which->excludes,
@@ -209,7 +227,7 @@ void pop_exclude_per_directory(struct dir_struct *dir, int stk)
  * Return 1 for exclude, 0 for include and -1 for undecided.
  */
 static int excluded_1(const char *pathname,
-		      int pathlen,
+		      int pathlen, const char *basename, 
 		      struct exclude_list *el)
 {
 	int i;
@@ -218,19 +236,21 @@ static int excluded_1(const char *pathname,
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
+				if (x->flags & EXC_FLAG_NOWILDCARD) {
+					if (!strcmp(exclude, basename))
+						return to_exclude;
+				} else if (x->flags & EXC_FLAG_ENDSWITH) {
+					if (x->patternlen - 1 <= pathlen &&
+                                            !strcmp(exclude + 1, pathname + pathlen - x->patternlen + 1))
+						return to_exclude;
+				} else {
+					if (fnmatch(exclude, basename, 0) == 0)
+						return to_exclude;
+				}
 			}
 			else {
 				/* match with FNM_PATHNAME:
@@ -246,9 +266,14 @@ static int excluded_1(const char *pathname,
 				    strncmp(pathname, x->base, baselen))
 				    continue;
 
-				if (fnmatch(exclude, pathname+baselen,
-					    FNM_PATHNAME) == 0)
-					return to_exclude;
+				if (x->flags & EXC_FLAG_NOWILDCARD) {
+					if (!strcmp(exclude, pathname + baselen))
+						return to_exclude;
+				} else {
+					if (fnmatch(exclude, pathname+baselen,
+						    FNM_PATHNAME) == 0)
+					    return to_exclude;
+				}
 			}
 		}
 	}
@@ -259,9 +284,11 @@ int excluded(struct dir_struct *dir, const char *pathname)
 {
 	int pathlen = strlen(pathname);
 	int st;
-
+	const char *basename = strrchr(pathname, '/');
+	basename = (basename) ? basename+1 : pathname;
+	
 	for (st = EXC_CMDL; st <= EXC_FILE; st++) {
-		switch (excluded_1(pathname, pathlen, &dir->exclude_list[st])) {
+		switch (excluded_1(pathname, pathlen, basename, &dir->exclude_list[st])) {
 		case 0:
 			return 0;
 		case 1:
diff --git a/dir.h b/dir.h
index a248a23..3ce8dbe 100644
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
+		int patternlen;		   
 		const char *base;
 		int baselen;
+		int to_exclude;
+		int flags;
 	} **excludes;
 };
 
-- 
1.5.3.4.383.gd90a7
