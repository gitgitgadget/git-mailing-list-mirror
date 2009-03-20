From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3] Introduce BEL<branch> as shortcut to the tracked branch
Date: Fri, 20 Mar 2009 10:29:11 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903201027450.10279@pacific.mpi-cbg.de>
References: <200903181448.50706.agruen@suse.de> <20090318182603.GM8940@machine.or.cz> <alpine.DEB.1.00.0903182210310.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903182245280.10279@pacific.mpi-cbg.de> <7vr60ubgul.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200121330.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200137230.10279@pacific.mpi-cbg.de> <20090320004029.GX23521@spearce.org> <20090320004450.GY23521@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>,
	Andreas Gruenbacher <agruen@suse.de>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 20 10:29:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkb2c-0005F4-HZ
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 10:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571AbZCTJ1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 05:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751974AbZCTJ1R
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 05:27:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:37996 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751080AbZCTJ1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 05:27:16 -0400
Received: (qmail invoked by alias); 20 Mar 2009 09:27:13 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 20 Mar 2009 10:27:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/kfXRkxAjkXZIkRO2ikCQiaKJVPoR8Rdd420+uwK
	VDZhaD2xC+QFvE
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090320004450.GY23521@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113921>


Often, it is quite interesting to inspect the branch tracked by a given
branch.  This patch introduces a nice notation to get at the tracked
branch: 'BEL<branch>' can be used to access that tracked branch.

A special shortcut 'BEL' refers to the branch tracked by the current branch.

Suggested by Pasky and Shawn.

This patch extends the function introduced to handle the nth-last branch
(via the {-<n>} notation); therefore that function name was renamed to
something more general.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Thu, 19 Mar 2009, Shawn O. Pearce wrote:

	> Use BEL for your %helloworld hack.

	Here you are.

 Documentation/git-rev-parse.txt |    3 ++
 sha1_name.c                     |   21 ++++++++++++---
 t/t1506-rev-parse-tracked.sh    |   54 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+), 4 deletions(-)
 create mode 100755 t/t1506-rev-parse-tracked.sh

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 5ed2bc8..a4bcd5e 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -215,6 +215,9 @@ when you run 'git-merge'.
 * The special construct '@\{-<n>\}' means the <n>th branch checked out
   before the current one.
 
+* The prefix 'BEL' to a ref means the branch tracked by that ref.  If no
+  ref was specified, it means the branch tracked by the current branch.
+
 * A suffix '{caret}' to a revision parameter means the first parent of
   that commit object.  '{caret}<n>' means the <n>th parent (i.e.
   'rev{caret}'
diff --git a/sha1_name.c b/sha1_name.c
index 2f75179..cb4168d 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -5,6 +5,7 @@
 #include "blob.h"
 #include "tree-walk.h"
 #include "refs.h"
+#include "remote.h"
 
 static int find_short_object_filename(int len, const char *name, unsigned char *sha1)
 {
@@ -240,9 +241,10 @@ static int ambiguous_path(const char *path, int len)
 
 /*
  * *string and *len will only be substituted, and *string returned (for
- * later free()ing) if the string passed in is of the form @{-<n>}.
+ * later free()ing) if the string passed in is of the form @{-<n>} or
+ * of the form BEL<branch>.
  */
-static char *substitute_nth_last_branch(const char **string, int *len)
+static char *substitute_branch(const char **string, int *len)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int ret = interpret_nth_last_branch(*string, &buf);
@@ -254,12 +256,23 @@ static char *substitute_nth_last_branch(const char **string, int *len)
 		return (char *)*string;
 	}
 
+	if (**string == '\007') {
+		struct branch *tracking = branch_get((*string)[1] ?
+			(*string) + 1 : NULL);
+
+		if (tracking->merge && tracking->merge[0]->dst) {
+			*string = xstrdup(tracking->merge[0]->dst);
+			*len = strlen(*string);
+			return (char *)*string;
+		}
+	}
+
 	return NULL;
 }
 
 int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 {
-	char *last_branch = substitute_nth_last_branch(&str, &len);
+	char *last_branch = substitute_branch(&str, &len);
 	const char **p, *r;
 	int refs_found = 0;
 
@@ -288,7 +301,7 @@ int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 
 int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 {
-	char *last_branch = substitute_nth_last_branch(&str, &len);
+	char *last_branch = substitute_branch(&str, &len);
 	const char **p;
 	int logs_found = 0;
 
diff --git a/t/t1506-rev-parse-tracked.sh b/t/t1506-rev-parse-tracked.sh
new file mode 100755
index 0000000..359f648
--- /dev/null
+++ b/t/t1506-rev-parse-tracked.sh
@@ -0,0 +1,54 @@
+#!/bin/sh
+
+test_description='test BEL<branch> syntax'
+
+. ./test-lib.sh
+
+
+test_expect_success 'setup' '
+
+	test_commit 1 &&
+	git checkout -b side &&
+	test_commit 2 &&
+	git checkout master &&
+	git clone . clone &&
+	test_commit 3 &&
+	(cd clone &&
+	 test_commit 4 &&
+	 git branch --track my-side origin/side)
+
+'
+
+full_name () {
+	(cd clone &&
+	 git rev-parse --symbolic-full-name "$@")
+}
+
+commit_subject () {
+	(cd clone &&
+	 git show -s --pretty=format:%s "$@")
+}
+
+test_expect_success 'BEL resolves to correct full name' '
+
+	test refs/remotes/origin/master = "$(full_name "$(echo -e '\007')")"
+
+'
+
+test_expect_success 'BELmy-side resolves to correct full name' '
+
+	test refs/remotes/origin/side = "$(full_name "$(echo -e '\007')"my-side)"
+
+'
+
+test_expect_success 'BELmy-side resolves to correct commit' '
+
+	git checkout side &&
+	test_commit 5 &&
+	(cd clone && git fetch) &&
+	test 2 = "$(commit_subject my-side)" &&
+	test 5 = "$(commit_subject "$(echo -e '\007')"my-side)"
+
+'
+
+test_done
-- 
1.6.2.1.477.g74567
