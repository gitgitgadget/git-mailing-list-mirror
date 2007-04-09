From: Jim Meyering <jim@meyering.net>
Subject: sscanf/strtoul: parse integers robustly
Date: Tue, 10 Apr 2007 01:01:44 +0200
Message-ID: <871witxicn.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 10 05:09:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hb2s8-0000aO-JU
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 01:02:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753203AbXDIXBq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 19:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753540AbXDIXBq
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 19:01:46 -0400
Received: from mx.meyering.net ([82.230.74.64]:41754 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753203AbXDIXBp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 19:01:45 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id BEBEB551FC; Tue, 10 Apr 2007 01:01:44 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44098>

* builtin-grep.c (strtoul_ui): Move function definition from here, to...
* git-compat-util.h (strtoul_ui): ...here, with an added "base" parameter.
* builtin-grep.c (cmd_grep): Update use of strtoul_ui to include base, "10".
* builtin-update-index.c (read_index_info): Diagnose an invalid mode integer
that is out of range or merely larger than INT_MAX.
(cmd_update_index): Use strtoul_ui, not sscanf.
* convert-objects.c (write_subdirectory): Likewise.

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 builtin-grep.c         |   15 +--------------
 builtin-update-index.c |   10 +++++++---
 convert-objects.c      |    2 +-
 git-compat-util.h      |   13 +++++++++++++
 4 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 981f3d4..e13cb31 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -434,19 +434,6 @@ static const char emsg_missing_context_len[] =
 static const char emsg_missing_argument[] =
 "option requires an argument -%s";
 
-static int strtoul_ui(char const *s, unsigned int *result)
-{
-	unsigned long ul;
-	char *p;
-
-	errno = 0;
-	ul = strtoul(s, &p, 10);
-	if (errno || *p || p == s || (unsigned int) ul != ul)
-		return -1;
-	*result = ul;
-	return 0;
-}
-
 int cmd_grep(int argc, const char **argv, const char *prefix)
 {
 	int hit = 0;
@@ -569,7 +556,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 				scan = arg + 1;
 				break;
 			}
-			if (strtoul_ui(scan, &num))
+			if (strtoul_ui(scan, 10, &num))
 				die(emsg_invalid_context_len, scan);
 			switch (arg[1]) {
 			case 'A':
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 47d42ed..b3d4ace 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -227,6 +227,7 @@ static void read_index_info(int line_termination)
 		char *path_name;
 		unsigned char sha1[20];
 		unsigned int mode;
+		unsigned long ul;
 		int stage;
 
 		/* This reads lines formatted in one of three formats:
@@ -249,9 +250,12 @@ static void read_index_info(int line_termination)
 		if (buf.eof)
 			break;
 
-		mode = strtoul(buf.buf, &ptr, 8);
-		if (ptr == buf.buf || *ptr != ' ')
+		errno = 0;
+		ul = strtoul(buf.buf, &ptr, 8);
+		if (ptr == buf.buf || *ptr != ' '
+		    || errno || (unsigned int) ul != ul)
 			goto bad_line;
+		mode = ul;
 
 		tab = strchr(ptr, '\t');
 		if (!tab || tab - ptr < 41)
@@ -547,7 +551,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 				if (i+3 >= argc)
 					die("git-update-index: --cacheinfo <mode> <sha1> <path>");
 
-				if ((sscanf(argv[i+1], "%o", &mode) != 1) ||
+				if ((strtoul_ui(argv[i+1], 8, &mode) != 1) ||
 				    get_sha1_hex(argv[i+2], sha1) ||
 				    add_cacheinfo(mode, sha1, argv[i+3], 0))
 					die("git-update-index: --cacheinfo"
diff --git a/convert-objects.c b/convert-objects.c
index 4809f91..cf03bcf 100644
--- a/convert-objects.c
+++ b/convert-objects.c
@@ -88,7 +88,7 @@ static int write_subdirectory(void *buffer, unsigned long size, const char *base
 		unsigned int mode;
 		char *slash, *origpath;
 
-		if (!path || sscanf(buffer, "%o", &mode) != 1)
+		if (!path || strtoul_ui(buffer, 8, &mode) != 1)
 			die("bad tree conversion");
 		mode = convert_mode(mode);
 		path++;
diff --git a/git-compat-util.h b/git-compat-util.h
index 139fc19..5f6a281 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -301,4 +301,17 @@ static inline int prefixcmp(const char *str, const char *prefix)
 	return strncmp(str, prefix, strlen(prefix));
 }
 
+static inline int strtoul_ui(char const *s, int base, unsigned int *result)
+{
+	unsigned long ul;
+	char *p;
+
+	errno = 0;
+	ul = strtoul(s, &p, base);
+	if (errno || *p || p == s || (unsigned int) ul != ul)
+		return -1;
+	*result = ul;
+	return 0;
+}
+
 #endif
-- 
1.5.1.rc3-dirty
