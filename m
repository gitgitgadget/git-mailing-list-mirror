From: Linus Torvalds <torvalds@osdl.org>
Subject: Improve handling of "." and ".." in git-diff-*
Date: Tue, 16 Aug 2005 20:44:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508162037080.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Aug 17 05:44:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5Er2-00032n-Mi
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 05:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbVHQDoi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 23:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbVHQDoi
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 23:44:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4296 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750821AbVHQDoh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2005 23:44:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7H3iXjA027536
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 16 Aug 2005 20:44:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7H3iW2N031646;
	Tue, 16 Aug 2005 20:44:33 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This fixes up usage of ".." (without an ending slash) and "." (with or 
without the ending slash) in the git diff family.

It also fixes pathspec matching for the case of an empty pathspec, since a 
"." in the top-level directory (or enough ".." under subdirectories) will 
result in an empty pathspec. We used to not match it against anything, but 
it should in fact match everything.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
----

This is in addition to the previous fix for the t0000 testcase and applies 
independently of that.

NOTE! This does _not_ handle ".." or "." in the _middle_ of a pathspec. If 
you have people who do

	git diff net/../char/

this will not help them - it will _not_ simplify this to

	git diff char/

and only ".." and "." components at the head of the pathspec will be
honoured.

Finally, if you try to give a pathspec that goes "outside" of the .git
directory (eg, a ".." pattern at the top of the git archive), the code
will politely tell you to f*ck off and die (this is not a new feature, the
previous code drop did that too, but because we now handle it even for the
top-level case without any extra prefix, it's worth noting).

---
diff --git a/diffcore-pathspec.c b/diffcore-pathspec.c
--- a/diffcore-pathspec.c
+++ b/diffcore-pathspec.c
@@ -29,6 +29,8 @@ static int matches_pathspec(const char *
 		    name[len] == 0 ||
 		    name[len] == '/')
 			return 1;
+		if (!len)
+			return 1;
 	}
 	return 0;
 }
diff --git a/read-cache.c b/read-cache.c
--- a/read-cache.c
+++ b/read-cache.c
@@ -191,6 +191,8 @@ int ce_path_match(const struct cache_ent
 			return 1;
 		if (name[matchlen] == '/' || !name[matchlen])
 			return 1;
+		if (!matchlen)
+			return 1;
 	}
 	return 0;
 }
diff --git a/setup.c b/setup.c
--- a/setup.c
+++ b/setup.c
@@ -1,23 +1,60 @@
 #include "cache.h"
 
+static char *prefix_path(const char *prefix, int len, char *path)
+{
+	char *orig = path;
+	for (;;) {
+		char c;
+		if (*path != '.')
+			break;
+		c = path[1];
+		/* "." */
+		if (!c) {
+			path++;
+			break;
+		}
+		/* "./" */
+		if (c == '/') {
+			path += 2;
+			continue;
+		}
+		if (c != '.')
+			break;
+		c = path[2];
+		if (!c)
+			path += 2;
+		else if (c == '/')
+			path += 3;
+		else
+			break;
+		/* ".." and "../" */
+		/* Remove last component of the prefix */
+		do {
+			if (!len)
+				die("'%s' is outside repository", orig);
+			len--;
+		} while (len && prefix[len-1] != '/');
+		continue;
+	}
+	if (len) {
+		int speclen = strlen(path);
+		char *n = xmalloc(speclen + len + 1);
+	
+		memcpy(n, prefix, len);
+		memcpy(n + len, path, speclen+1);
+		path = n;
+	}
+	return path;
+}
+
 const char **get_pathspec(const char *prefix, char **pathspec)
 {
 	char *entry = *pathspec;
 	char **p;
 	int prefixlen;
 
-	if (!prefix) {
-		char **p;
-		if (!entry)
-			return NULL;
-		p = pathspec;
-		do {
-			if (*entry != '.')
-				continue;
-			/* fixup ? */
-		} while ((entry = *++p) != NULL);
-		return (const char **) pathspec;
-	}
+	if (!prefix && !entry)
+		return NULL;
 
 	if (!entry) {
 		static const char *spec[2];
@@ -27,38 +64,10 @@ const char **get_pathspec(const char *pr
 	}
 
 	/* Otherwise we have to re-write the entries.. */
-	prefixlen = strlen(prefix);
 	p = pathspec;
+	prefixlen = prefix ? strlen(prefix) : 0;
 	do {
-		int speclen, len = prefixlen;
-		char *n;
-
-		for (;;) {
-			if (!strcmp(entry, ".")) {
-				entry++;
-				break;
-			}
-			if (!strncmp(entry, "./", 2)) {
-				entry += 2;
-				continue;
-			}
-			if (!strncmp(entry, "../", 3)) {
-				do {
-					if (!len)
-						die("'%s' is outside repository", *p);
-					len--;
-				} while (len && prefix[len-1] != '/');
-				entry += 3;
-				continue;
-			}
-			break;
-		}
-		speclen = strlen(entry);
-		n = xmalloc(speclen + len + 1);
-		
-		memcpy(n, prefix, len);
-		memcpy(n + len, entry, speclen+1);
-		*p = n;
+		*p = prefix_path(prefix, prefixlen, entry);
 	} while ((entry = *++p) != NULL);
 	return (const char **) pathspec;
 }
