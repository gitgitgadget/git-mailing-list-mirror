From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] Add test-chmtime: a utility to change mtime on files
Date: Sat, 24 Feb 2007 16:59:51 -0800
Message-ID: <11723651923476-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 25 02:00:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HL7k6-0000sp-Q6
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 01:59:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932928AbXBYA7z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Feb 2007 19:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932941AbXBYA7z
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Feb 2007 19:59:55 -0500
Received: from hand.yhbt.net ([66.150.188.102]:35749 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932928AbXBYA7y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Feb 2007 19:59:54 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 821532DC01A;
	Sat, 24 Feb 2007 16:59:52 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 24 Feb 2007 16:59:52 -0800
X-Mailer: git-send-email 1.5.0.137.ge6502
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40528>

This is intended to be a portable replacement for our usage
of date(1), touch(1), and Perl one-liners in tests.

Usage: test-chtime (+|=|-)<seconds> <file_1> [<file_2>]"

  '+' increments the mtime on the file by <seconds>
  '-' decrements the mtime on the file by <seconds>
  '=' sets the mtime on the file to exactly <seconds>

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 .gitignore     |    1 +
 Makefile       |    4 +++-
 test-chmtime.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 1 deletions(-)
 create mode 100644 test-chmtime.c

diff --git a/.gitignore b/.gitignore
index f15155d..eb8a1f8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -139,6 +139,7 @@ git-whatchanged
 git-write-tree
 git-core-*/?*
 gitweb/gitweb.cgi
+test-chmtime
 test-date
 test-delta
 test-dump-cache-tree
diff --git a/Makefile b/Makefile
index e51b448..105f3ec 100644
--- a/Makefile
+++ b/Makefile
@@ -829,7 +829,7 @@ GIT-CFLAGS: .FORCE-GIT-CFLAGS
 
 export NO_SVN_TESTS
 
-test: all
+test: all test-chmtime$X
 	$(MAKE) -C t/ all
 
 test-date$X: test-date.c date.o ctype.o
@@ -844,6 +844,8 @@ test-dump-cache-tree$X: dump-cache-tree.o $(GITLIBS)
 test-sha1$X: test-sha1.o $(GITLIBS)
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
+test-chmtime$X: test-chmtime.o
+
 check-sha1:: test-sha1$X
 	./test-sha1.sh
 
diff --git a/test-chmtime.c b/test-chmtime.c
new file mode 100644
index 0000000..69b3ba9
--- /dev/null
+++ b/test-chmtime.c
@@ -0,0 +1,48 @@
+#include "git-compat-util.h"
+#include <utime.h>
+
+static const char usage_str[] = "(+|=|-)<seconds> <file_1> [<file_2>]";
+
+int main(int argc, const char *argv[])
+{
+	int i;
+	int set_eq;
+	long int set_time;
+	char *test;
+
+	if (argc < 3)
+		goto usage;
+
+	set_eq = (argv[1][0] == '=') ? 1 : 0;
+	set_time = strtol(argv[1] + set_eq, &test, 10);
+	if (*test) {
+		fprintf(stderr, "Not a base-10 integer: %s\n", argv[1] + 1);
+		goto usage;
+	}
+
+	for (i = 2; i < argc; i++) {
+		struct stat sb;
+		struct utimbuf utb;
+
+		if (stat(argv[i], &sb) < 0) {
+			fprintf(stderr, "Failed to stat %s: %s\n",
+			        argv[i], strerror(errno));
+			return -1;
+		}
+
+		utb.actime = sb.st_atime;
+		utb.modtime = set_eq ? set_time : sb.st_mtime + set_time;
+
+		if (utime(argv[i], &utb) < 0) {
+			fprintf(stderr, "Failed to modify time on %s: %s\n",
+			        argv[i], strerror(errno));
+			return -1;
+		}
+	}
+
+	return 0;
+
+usage:
+	fprintf(stderr, "Usage: %s %s\n", argv[0], usage_str);
+	return -1;
+}
-- 
1.5.0.137.ge6502
