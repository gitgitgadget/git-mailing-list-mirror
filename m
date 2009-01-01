From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/3] Introduce the diff option '--patience'
Date: Thu, 1 Jan 2009 17:39:17 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901011738430.30769@pacific.mpi-cbg.de>
References: <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp> <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp>
 <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: davidel@xmailserver.org, Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jan 01 17:40:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIQb3-0007PQ-Ux
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 17:40:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756360AbZAAQi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 11:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756350AbZAAQi5
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 11:38:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:48210 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756348AbZAAQi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 11:38:56 -0500
Received: (qmail invoked by alias); 01 Jan 2009 16:38:50 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp046) with SMTP; 01 Jan 2009 17:38:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19aF79UwRFav4pDfhHYxJCv3/tin1/OE8ADaIS81T
	Wi8ZKuF6Q335UE
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104301>


This commit teaches Git to produce diff output using the patience diff
algorithm with the diff option '--patience'.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	git log --check complains about this patch, for obvious reasons.

 Documentation/diff-options.txt |    3 +
 Makefile                       |    2 +-
 diff.c                         |    2 +
 t/t4033-diff-patience.sh       |  168 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 174 insertions(+), 1 deletions(-)
 create mode 100755 t/t4033-diff-patience.sh

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 671f533..15ef35a 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -36,6 +36,9 @@ endif::git-format-patch[]
 --patch-with-raw::
 	Synonym for "-p --raw".
 
+--patience:
+	Generate a diff using the "patience diff" algorithm.
+
 --stat[=width[,name-width]]::
 	Generate a diffstat.  You can override the default
 	output width for 80-column terminal by "--stat=width".
diff --git a/Makefile b/Makefile
index 154cf34..2217873 100644
--- a/Makefile
+++ b/Makefile
@@ -1287,7 +1287,7 @@ $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIB_OBJS)
 
 XDIFF_OBJS=xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
-	xdiff/xmerge.o
+	xdiff/xmerge.o xdiff/xpatience.o
 $(XDIFF_OBJS): xdiff/xinclude.h xdiff/xmacros.h xdiff/xdiff.h xdiff/xtypes.h \
 	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
 
diff --git a/diff.c b/diff.c
index 56b80f9..67718b7 100644
--- a/diff.c
+++ b/diff.c
@@ -2472,6 +2472,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->xdl_opts |= XDF_IGNORE_WHITESPACE_CHANGE;
 	else if (!strcmp(arg, "--ignore-space-at-eol"))
 		options->xdl_opts |= XDF_IGNORE_WHITESPACE_AT_EOL;
+	else if (!strcmp(arg, "--patience"))
+		options->xdl_opts |= XDF_PATIENCE_DIFF;
 
 	/* flags options */
 	else if (!strcmp(arg, "--binary")) {
diff --git a/t/t4033-diff-patience.sh b/t/t4033-diff-patience.sh
new file mode 100755
index 0000000..63c1b00
--- /dev/null
+++ b/t/t4033-diff-patience.sh
@@ -0,0 +1,168 @@
+#!/bin/sh
+
+test_description='patience diff algorithm'
+
+. ./test-lib.sh
+
+cat > file1 << EOF
+#include <stdio.h>
+
+// Frobs foo heartily
+int frobnitz(int foo)
+{
+    int i;
+    for(i = 0; i < 10; i++)
+    {
+        printf("Your answer is: ");
+        printf("%d\n", foo);
+    }
+}
+
+int fact(int n)
+{
+    if(n > 1)
+    {
+        return fact(n-1) * n;
+    }
+    return 1;
+}
+
+int main(int argc, char **argv)
+{
+    frobnitz(fact(10));
+}
+EOF
+
+cat > file2 << EOF
+#include <stdio.h>
+
+int fib(int n)
+{
+    if(n > 2)
+    {
+        return fib(n-1) + fib(n-2);
+    }
+    return 1;
+}
+
+// Frobs foo heartily
+int frobnitz(int foo)
+{
+    int i;
+    for(i = 0; i < 10; i++)
+    {
+        printf("%d\n", foo);
+    }
+}
+
+int main(int argc, char **argv)
+{
+    frobnitz(fib(10));
+}
+EOF
+
+cat > expect << EOF
+diff --git a/file1 b/file2
+index 6faa5a3..e3af329 100644
+--- a/file1
++++ b/file2
+@@ -1,26 +1,25 @@
+ #include <stdio.h>
+ 
++int fib(int n)
++{
++    if(n > 2)
++    {
++        return fib(n-1) + fib(n-2);
++    }
++    return 1;
++}
++
+ // Frobs foo heartily
+ int frobnitz(int foo)
+ {
+     int i;
+     for(i = 0; i < 10; i++)
+     {
+-        printf("Your answer is: ");
+         printf("%d\n", foo);
+     }
+ }
+ 
+-int fact(int n)
+-{
+-    if(n > 1)
+-    {
+-        return fact(n-1) * n;
+-    }
+-    return 1;
+-}
+-
+ int main(int argc, char **argv)
+ {
+-    frobnitz(fact(10));
++    frobnitz(fib(10));
+ }
+EOF
+
+test_expect_success 'patience diff' '
+
+	test_must_fail git diff --no-index --patience file1 file2 > output &&
+	test_cmp expect output
+
+'
+
+test_expect_success 'patience diff output is valid' '
+
+	mv file2 expect &&
+	git apply < output &&
+	test_cmp expect file2
+
+'
+
+cat > uniq1 << EOF
+1
+2
+3
+4
+5
+6
+EOF
+
+cat > uniq2 << EOF
+a
+b
+c
+d
+e
+f
+EOF
+
+cat > expect << EOF
+diff --git a/uniq1 b/uniq2
+index b414108..0fdf397 100644
+--- a/uniq1
++++ b/uniq2
+@@ -1,6 +1,6 @@
+-1
+-2
+-3
+-4
+-5
+-6
++a
++b
++c
++d
++e
++f
+EOF
+
+test_expect_success 'completely different files' '
+
+	test_must_fail git diff --no-index --patience uniq1 uniq2 > output &&
+	test_cmp expect output
+
+'
+
+test_done
-- 
1.6.1.rc3.412.ga72b
