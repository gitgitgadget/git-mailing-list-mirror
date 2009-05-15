From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4/3] Introduce 'convert_path_to_git()'
Date: Fri, 15 May 2009 12:01:29 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905151156090.3343@localhost.localdomain>
References: <alpine.LFD.2.01.0905141341470.3343@localhost.localdomain> <alpine.LFD.2.01.0905141342520.3343@localhost.localdomain> <alpine.LFD.2.01.0905141346440.3343@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 15 21:01:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M52fE-0001TZ-LQ
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 21:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238AbZEOTBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 15:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbZEOTBj
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 15:01:39 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47241 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751652AbZEOTBi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 May 2009 15:01:38 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4FJ1TTN002568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 15 May 2009 12:01:30 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4FJ1TYF006322;
	Fri, 15 May 2009 12:01:29 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0905141346440.3343@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.964 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119278>


Ok, this is at the stage where if somebody wants UTF-8 filenames to work 
sanely on OS X, you can now add just a couple of lines (assuming you find 
the right conversion function to turn it into NFC), and get a pretty 
efficient end result.

It avoids the conversion overhead for the case where the filename is 
perfectly normal US-ASCII, so in 99% of all cases you'd not have to do 
anything fancy, and then if you have a slightly more expensive thing to 
handle decomposed -> composed UTF-8, you'll still be ok.

There's a comment on "This is where we should get fancy. Some day", and 
the only case that matters for OS X is "convert_path_to_git()", since you 
never need to do it the other way around.

Anybody with OS X, and a wish to be able to sanely use non-ASCII UTF-8?

(I only did the "unsigned long at a time" for x86, which does unaligneds 
well. If your architecture sucks at unaligned accesses, you don't want to 
do that thing.)

		Linus

---
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri May 15 09:40:57 2009 -0700

Add initial support for pathname conversion to UTF-8

We're still not converting anything, but this adds the infrastructure
for it, including a fast-path to handle the trivial case of all-ASCII
characters with no need for conversion.

That means that we can then afford to spend a bit more time on the case
where conversion fails.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 Makefile   |    1 +
 dir.c      |   11 ++-----
 dir.h      |    3 ++
 filename.c |   86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 93 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 6e21643..fc847c7 100644
--- a/Makefile
+++ b/Makefile
@@ -473,6 +473,7 @@ LIB_OBJS += editor.o
 LIB_OBJS += entry.o
 LIB_OBJS += environment.o
 LIB_OBJS += exec_cmd.o
+LIB_OBJS += filename.o
 LIB_OBJS += fsck.o
 LIB_OBJS += graph.o
 LIB_OBJS += grep.o
diff --git a/dir.c b/dir.c
index 2d53b11..3c5c6a6 100644
--- a/dir.c
+++ b/dir.c
@@ -589,13 +589,6 @@ static int get_dtype(struct dirent *de, const char *path)
 	return dtype;
 }
 
-/* No actual conversion yet */
-static int convert_path_to_git(const char *path, int plen, char *result)
-{
-	memcpy(result, path, plen+1);
-	return plen;
-}
-
 /*
  * For testing!
  *
@@ -650,7 +643,9 @@ static int read_directory_recursive(struct dir_struct *dir,
 				continue;
 			memcpy(newpath + pathlen, de->d_name, len+1);
 
-			nlen = convert_path_to_git(de->d_name, len, converted);
+			nlen = convert_path_to_git(de->d_name, len, converted, sizeof(converted));
+			if (nlen <= 0)
+				continue;
 			if (nlen + baselen + 8 > sizeof(newbase))
 				continue;
 			memcpy(newbase + baselen, converted, nlen+1);
diff --git a/dir.h b/dir.h
index f9d69dd..c04eb3a 100644
--- a/dir.h
+++ b/dir.h
@@ -66,6 +66,9 @@ struct dir_struct {
 #define MATCHED_EXACTLY 3
 extern int match_pathspec(const char **pathspec, const char *name, int namelen, int prefix, char *seen);
 
+extern int convert_path_to_git(const char *, int, char *, int);
+extern int convert_git_to_path(const char *, int, char *, int);
+
 extern int fill_directory(struct dir_struct *dir, const char **pathspec);
 extern int read_directory(struct dir_struct *, const char *path, const char *base, int baselen, const char **pathspec);
 
diff --git a/filename.c b/filename.c
new file mode 100644
index 0000000..8a049ab
--- /dev/null
+++ b/filename.c
@@ -0,0 +1,86 @@
+/*
+ * Filename character set conversion
+ */
+#include "cache.h"
+#include "dir.h"
+
+#if defined(__x86_64__) || defined(__i386__)
+#define FAST_UNALIGNED
+#endif
+
+/*
+ * The "common" case that requires no conversion: all 7-bit ASCII.
+ *
+ * Return how many character were trivially converted, negative on
+ * error (result wouldn't fit in buffer even trivially).
+ */
+static int convert_path_common(const char *path, int plen, char *result, int resultlen)
+{
+	int retval;
+
+	if (plen+1 > resultlen)
+		return -1;
+	retval = 0;
+#ifdef FAST_UNALIGNED
+	while (plen >= sizeof(unsigned long)) {
+		unsigned long x = *(unsigned long *)path;
+		if (x & (unsigned long) 0x8080808080808080ull)
+			break;
+		*(unsigned long *)result = x;
+		path += sizeof(unsigned long);
+		result += sizeof(unsigned long);
+		plen -= sizeof(unsigned long);
+		retval += sizeof(unsigned long);
+	}
+#endif
+	while (plen > 0) {
+		unsigned char x = *path;
+		if (x & 0x80)
+			break;
+		*result = x;
+		path++;
+		result++;
+		plen--;
+		retval++;
+	}
+	*result = 0;
+	return retval;
+}
+
+int convert_path_to_git(const char *path, int plen, char *result, int resultlen)
+{
+	int retval;
+
+	retval = convert_path_common(path, plen, result, resultlen);
+	/* Absolute failure, or total success.. */
+	if (retval < 0 || retval == plen)
+		return retval;
+
+	/* Skip the part we already did trivially */
+	result += retval;
+	path += retval;
+	plen -= retval;
+
+	/* This is where we should get fancy. Some day */
+	memcpy(result, path, plen+1);
+	return retval + plen;
+}
+
+int convert_git_to_path(const char *path, int plen, char *result, int resultlen)
+{
+	int retval;
+
+	retval = convert_path_common(path, plen, result, resultlen);
+	/* Absolute failure, or total success.. */
+	if (retval < 0 || retval == plen)
+		return retval;
+
+	/* Skip the part we already did trivially */
+	result += retval;
+	path += retval;
+	plen -= retval;
+
+	/* This is where we should get fancy. Some day */
+	memcpy(result, path, plen+1);
+	return retval + plen;
+}
