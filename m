From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] Introduce <branch>@{upstream} as shortcut to the tracked
 branch
Date: Thu, 10 Sep 2009 17:25:57 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909101724520.8306@pacific.mpi-cbg.de>
References: <20090905140127.GA29037@atjola.homenet> <20090905142841.GB15631@coredump.intra.peff.net> <7vfxaz9wfi.fsf@alter.siamese.dyndns.org> <20090907084324.GB17997@coredump.intra.peff.net> <alpine.DEB.1.00.0909071126040.8306@pacific.mpi-cbg.de>
 <20090909104550.GA20108@coredump.intra.peff.net> <7vzl93cncn.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0909100941330.8306@pacific.mpi-cbg.de> <alpine.DEB.1.00.0909101135590.8306@pacific.mpi-cbg.de> <20090910141618.GB4942@coredump.intra.peff.net>
 <20090910142628.GA7275@coredump.intra.peff.net> <alpine.DEB.1.00.0909101723260.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 10 17:24:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MllVh-0005B2-CE
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 17:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbZIJPYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 11:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbZIJPYY
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 11:24:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:36953 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750842AbZIJPYX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 11:24:23 -0400
Received: (qmail invoked by alias); 10 Sep 2009 15:24:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 10 Sep 2009 17:24:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/OmeNK3MLO5QEwU3UEeHRjsBytRYF6W95RGnphDS
	td7vcnQR4OAKJ8
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0909101723260.8306@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.45
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128121>


Often, it is quite interesting to inspect the branch tracked by a given
branch.  This patch introduces a nice notation to get at the tracked
branch: '<branch>@{upstream}' can be used to access that tracked branch.

A special shortcut '@{upstream}' refers to the branch tracked by the
current branch.

Suggested by Pasky.

The syntax was suggested by Junio.

A test for a now-fixed crash was provided by Mikael Magnusson.

The crash has been pointed out by Peff again (because this here developer
managed to forget about the fix).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Changes since v1:
	- changed to @{upstream} (and @{u})
	- included the fix I forgot about

 Documentation/git-rev-parse.txt |    4 ++
 sha1_name.c                     |   39 ++++++++++++++++++++--
 t/t1506-rev-parse-tracked.sh    |   69 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+), 3 deletions(-)
 create mode 100755 t/t1506-rev-parse-tracked.sh

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 82045a2..09a2145 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -231,6 +231,10 @@ when you run 'git-merge'.
 * The special construct '@\{-<n>\}' means the <n>th branch checked out
   before the current one.
 
+* The suffix '@{upstream}' to a ref (short form 'blabla@{u}') refers to
+  the branch tracked by that ref.  If no ref was specified, it means the
+  branch tracked by the current branch.
+
 * A suffix '{caret}' to a revision parameter means the first parent of
   that commit object.  '{caret}<n>' means the <n>th parent (i.e.
   'rev{caret}'
diff --git a/sha1_name.c b/sha1_name.c
index 44bb62d..ae4280e 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -5,6 +5,7 @@
 #include "blob.h"
 #include "tree-walk.h"
 #include "refs.h"
+#include "remote.h"
 
 static int find_short_object_filename(int len, const char *name, unsigned char *sha1)
 {
@@ -238,9 +239,24 @@ static int ambiguous_path(const char *path, int len)
 	return slash;
 }
 
+static inline int tracked_suffix(const char *string, int len)
+{
+	const char *suffix[] = { "@{upstream}", "@{u}" };
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(suffix); i++) {
+		int suffix_len = strlen(suffix[i]);
+		if (len >= suffix_len && !memcmp(string + len - suffix_len,
+					suffix[i], suffix_len))
+			return suffix_len;
+	}
+	return 0;
+}
+
 /*
  * *string and *len will only be substituted, and *string returned (for
- * later free()ing) if the string passed in is of the form @{-<n>}.
+ * later free()ing) if the string passed in is of the form @{-<n>} or
+ * of the form <branch>@{upstream}.
  */
 static char *substitute_branch_name(const char **string, int *len)
 {
@@ -254,6 +270,21 @@ static char *substitute_branch_name(const char **string, int *len)
 		return (char *)*string;
 	}
 
+	ret = tracked_suffix(*string, *len);
+	if (ret) {
+		char *ref = xstrndup(*string, *len - ret);
+		struct branch *tracking = branch_get(*ref ? ref : NULL);
+
+		free(ref);
+		if (!tracking)
+			die ("No tracking branch found for '%s'", ref);
+		if (tracking->merge && tracking->merge[0]->dst) {
+			*string = xstrdup(tracking->merge[0]->dst);
+			*len = strlen(*string);
+			return (char *)*string;
+		}
+	}
+
 	return NULL;
 }
 
@@ -340,8 +371,10 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 	if (len && str[len-1] == '}') {
 		for (at = len-2; at >= 0; at--) {
 			if (str[at] == '@' && str[at+1] == '{') {
-				reflog_len = (len-1) - (at+2);
-				len = at;
+				if (!tracked_suffix(str + at, len - at)) {
+					reflog_len = (len-1) - (at+2);
+					len = at;
+				}
 				break;
 			}
 		}
diff --git a/t/t1506-rev-parse-tracked.sh b/t/t1506-rev-parse-tracked.sh
new file mode 100755
index 0000000..72d0579
--- /dev/null
+++ b/t/t1506-rev-parse-tracked.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+
+test_description='test <branch>@{upstream} syntax'
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
+test_expect_success '@{upstream} resolves to correct full name' '
+	test refs/remotes/origin/master = "$(full_name @{upstream})"
+'
+
+test_expect_success '@{u} resolves to correct full name' '
+	test refs/remotes/origin/master = "$(full_name @{u})"
+'
+
+test_expect_success 'my-side@{upstream} resolves to correct full name' '
+	test refs/remotes/origin/side = "$(full_name my-side@{u})"
+'
+
+test_expect_success 'my-side@{u} resolves to correct commit' '
+	git checkout side &&
+	test_commit 5 &&
+	(cd clone && git fetch) &&
+	test 2 = "$(commit_subject my-side)" &&
+	test 5 = "$(commit_subject my-side@{u})"
+'
+
+test_expect_success 'not-tracking@{u} fails' '
+	test_must_fail full_name non-tracking@{u} &&
+	(cd clone && git checkout --no-track -b non-tracking) &&
+	test_must_fail full_name non-tracking@{u}
+'
+
+test_expect_success '<branch>@{u}@{1} resolves correctly' '
+	test_commit 6 &&
+	(cd clone && git fetch) &&
+	test 5 = $(commit_subject my-side@{u}@{1})
+'
+
+test_expect_success '% without specifying branch crashes on a detached HEAD' '
+	git checkout HEAD^0 &&
+	test_must_fail git rev-parse @{u}
+'
+
+test_done
-- 
1.6.4.313.g3d9e3
