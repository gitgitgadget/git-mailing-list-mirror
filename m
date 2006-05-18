From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Do "git add" as a builtin
Date: Thu, 18 May 2006 08:26:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605180807060.10823@g5.osdl.org>
References: <Pine.LNX.4.64.0605170927050.10823@g5.osdl.org>
 <7vhd3ocvyy.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605171321020.10823@g5.osdl.org>
 <7v64k3698l.fsf@assigned-by-dhcp.cox.net> <7vwtcj4tp6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 18 17:27:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgkPM-0005Fn-DC
	for gcvg-git@gmane.org; Thu, 18 May 2006 17:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWERP0s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 11:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWERP0s
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 11:26:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49801 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751367AbWERP0r (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 May 2006 11:26:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4IFQdtH016842
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 18 May 2006 08:26:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4IFQcF2022940;
	Thu, 18 May 2006 08:26:38 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtcj4tp6.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20288>



On Thu, 18 May 2006, Junio C Hamano wrote:
> 
> Ouch, things are worse than I thought...
> 
> 	$ mkdir foo
>         $ date >bar
>         $ git-add foo/../bar
> 	$ git ls-files
>         foo/../bar
> 
> Huh?

"git-update-index" does a "verify_path()" which I missed, so the new 
builtin add doesn't do it.

We could do it either in the "add_cache_entry()" function (which would be 
safest, because then by _definition_ you couldn't make this mistake 
again), or we could do it in the caller.

This patch does it in the caller, just to match the old "git add" (which 
would just say "Ignoring path ..." and not do anything).

But if people are ok with changing it from a "print a warning and ignore" 
into an _error_, we could just move it into "add_cache_entry()".

The real _meat_ of this patch is really just that first hunk to 
"builtin-add.c" - all the rest is just making that "verify_path()" 
function available in the git library.

		Linus
---
diff --git a/builtin-add.c b/builtin-add.c
index 7083820..0346bb5 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -172,6 +172,11 @@ static int add_file_to_index(const char 
 	if (lstat(path, &st))
 		die("%s: unable to stat (%s)", path, strerror(errno));
 
+	if (!verify_path(path)) {
+		fprintf(stderr, "Ignoring path %s\n", path);
+		return -1;
+	}
+		
 	if (!S_ISREG(st.st_mode) && !S_ISLNK(st.st_mode))
 		die("%s: can only add regular files or symbolic links", path);
 
diff --git a/cache.h b/cache.h
index b1300cd..f9b7049 100644
--- a/cache.h
+++ b/cache.h
@@ -143,6 +143,7 @@ #define alloc_nr(x) (((x)+16)*3/2)
 /* Initialize and use the cache information */
 extern int read_cache(void);
 extern int write_cache(int newfd, struct cache_entry **cache, int entries);
+extern int verify_path(const char *path);
 extern int cache_name_pos(const char *name, int namelen);
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
diff --git a/read-cache.c b/read-cache.c
index ed0da38..6b323dd 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -347,6 +347,70 @@ int ce_path_match(const struct cache_ent
 }
 
 /*
+ * We fundamentally don't like some paths: we don't want
+ * dot or dot-dot anywhere, and for obvious reasons don't
+ * want to recurse into ".git" either.
+ *
+ * Also, we don't want double slashes or slashes at the
+ * end that can make pathnames ambiguous.
+ */
+static int verify_dotfile(const char *rest)
+{
+	/*
+	 * The first character was '.', but that
+	 * has already been discarded, we now test
+	 * the rest.
+	 */
+	switch (*rest) {
+	/* "." is not allowed */
+	case '\0': case '/':
+		return 0;
+
+	/*
+	 * ".git" followed by  NUL or slash is bad. This
+	 * shares the path end test with the ".." case.
+	 */
+	case 'g':
+		if (rest[1] != 'i')
+			break;
+		if (rest[2] != 't')
+			break;
+		rest += 2;
+	/* fallthrough */
+	case '.':
+		if (rest[1] == '\0' || rest[1] == '/')
+			return 0;
+	}
+	return 1;
+}
+
+int verify_path(const char *path)
+{
+	char c;
+
+	goto inside;
+	for (;;) {
+		if (!c)
+			return 1;
+		if (c == '/') {
+inside:
+			c = *path++;
+			switch (c) {
+			default:
+				continue;
+			case '/': case '\0':
+				break;
+			case '.':
+				if (verify_dotfile(path))
+					continue;
+			}
+			return 0;
+		}
+		c = *path++;
+	}
+}
+
+/*
  * Do we have another file that has the beginning components being a
  * proper superset of the name we're trying to add?
  */
diff --git a/update-index.c b/update-index.c
index f6b09a4..69b9a71 100644
--- a/update-index.c
+++ b/update-index.c
@@ -8,6 +8,7 @@ #include "strbuf.h"
 #include "quote.h"
 #include "cache-tree.h"
 #include "tree-walk.h"
+#include "dir.h"
 
 /*
  * Default to not allowing changes to the list of files. The
@@ -245,70 +246,6 @@ static int refresh_cache(int really)
 	return has_errors;
 }
 
-/*
- * We fundamentally don't like some paths: we don't want
- * dot or dot-dot anywhere, and for obvious reasons don't
- * want to recurse into ".git" either.
- *
- * Also, we don't want double slashes or slashes at the
- * end that can make pathnames ambiguous.
- */
-static int verify_dotfile(const char *rest)
-{
-	/*
-	 * The first character was '.', but that
-	 * has already been discarded, we now test
-	 * the rest.
-	 */
-	switch (*rest) {
-	/* "." is not allowed */
-	case '\0': case '/':
-		return 0;
-
-	/*
-	 * ".git" followed by  NUL or slash is bad. This
-	 * shares the path end test with the ".." case.
-	 */
-	case 'g':
-		if (rest[1] != 'i')
-			break;
-		if (rest[2] != 't')
-			break;
-		rest += 2;
-	/* fallthrough */
-	case '.':
-		if (rest[1] == '\0' || rest[1] == '/')
-			return 0;
-	}
-	return 1;
-}
-
-static int verify_path(const char *path)
-{
-	char c;
-
-	goto inside;
-	for (;;) {
-		if (!c)
-			return 1;
-		if (c == '/') {
-inside:
-			c = *path++;
-			switch (c) {
-			default:
-				continue;
-			case '/': case '\0':
-				break;
-			case '.':
-				if (verify_dotfile(path))
-					continue;
-			}
-			return 0;
-		}
-		c = *path++;
-	}
-}
-
 static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
 			 const char *path, int stage)
 {
