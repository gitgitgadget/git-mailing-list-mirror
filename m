From: koreth@midwinter.com
Subject: [PATCH] Change git-rev-parse --show-cdup to output an absolute path
Date: Wed, 25 Apr 2007 16:28:29 -0700
Message-ID: <20070425232829.GA15930@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 01:28:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgquh-0003f1-5W
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 01:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbXDYX2b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 19:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbXDYX2a
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 19:28:30 -0400
Received: from tater.midwinter.com ([216.32.86.90]:52101 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751153AbXDYX2a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 19:28:30 -0400
Received: (qmail 17171 invoked by uid 1001); 25 Apr 2007 23:28:29 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45593>

Add a test case for deep symlinking into a repo, which breaks with the
old relative output of --show-cdup.

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---

I have a symlink pointing to a subdirectory of a repo of mine. If I cd
to that symlink, some shell-script git commands don't work.  Shell scripts
use the PWD environment variable as the working directory, and the chain
of "../"s from git-rev-parse --show-cdup just peels entries off that
variable. That's fine when PWD is a real path, but not so great when it's
a reference to a symlink from an outside directory.

A typical failure case:

$ git clone git://whatever.git foobar
$ ln -s foobar/src/tools/misc/myapp myapp
$ cd myapp
$ git pull
fatal: Not a git repository

This patch adds a test for the problem (fails in the current git build)
and a proposed fix: making git-rev-parse --show-cdup output an absolute
path. It's possible that'll break something somewhere, but all the tests
in the test suite pass, so I think the breakage can't be *too* severe if
there's any at all.

 builtin-rev-parse.c       |   18 +++++++++---------
 t/t6102-rev-parse-cdup.sh |   24 ++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 9 deletions(-)
 create mode 100755 t/t6102-rev-parse-cdup.sh

diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 37addb2..99a95eb 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -320,15 +320,15 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--show-cdup")) {
-				const char *pfx = prefix;
-				while (pfx) {
-					pfx = strchr(pfx, '/');
-					if (pfx) {
-						pfx++;
-						printf("../");
-					}
-				}
-				putchar('\n');
+				char cwd[PATH_MAX];
+				/*
+				 * The prefix computation does chdir("..") until it
+				 * reaches the top level, so the current directory
+				 * is actually the thing we want to output.
+				 */
+				if (!getcwd(cwd, PATH_MAX))
+					die("unable to get current working directory");
+				printf("%s/\n", cwd);
 				continue;
 			}
 			if (!strcmp(arg, "--git-dir")) {
diff --git a/t/t6102-rev-parse-cdup.sh b/t/t6102-rev-parse-cdup.sh
new file mode 100755
index 0000000..233d9cf
--- /dev/null
+++ b/t/t6102-rev-parse-cdup.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Steven Grimm
+#
+
+test_description='Test git-rev-parse --show-cdup'
+
+. ./test-lib.sh
+. ../t6000lib.sh # t6xxx specific functions
+
+# Make a subdirectory and a symbolic link pointing to it from outside the repo.
+mkdir subdir
+ln -s `pwd`/subdir /tmp/git-test.$$
+cd /tmp/git-test.$$
+
+test_expect_success 'shell pwd references symlink' "pwd | grep git-test.$$"
+test_expect_success 'cdup goes to top level of repo' '
+	cd `git-rev-parse --show-cdup` &&
+	test -d .git'
+
+rm /tmp/git-test.$$
+
+test_done
+
-- 
1.5.2.rc0.1.g2cc31
