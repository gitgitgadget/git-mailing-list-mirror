From: Jeff King <peff@peff.net>
Subject: [PATCH 3/5] for-each-ref: add "upstream" format field
Date: Tue, 7 Apr 2009 03:09:39 -0400
Message-ID: <20090407070939.GC2924@coredump.intra.peff.net>
References: <20090407070254.GA2870@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 09:11:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr5Sz-0003XE-D7
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 09:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757168AbZDGHJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 03:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757909AbZDGHJq
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 03:09:46 -0400
Received: from peff.net ([208.65.91.99]:52411 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752919AbZDGHJp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 03:09:45 -0400
Received: (qmail 369 invoked by uid 107); 7 Apr 2009 07:09:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 07 Apr 2009 03:09:41 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Apr 2009 03:09:39 -0400
Content-Disposition: inline
In-Reply-To: <20090407070254.GA2870@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115912>

The logic for determining the upstream ref of a branch is
somewhat complex to perform in a shell script. This patch
provides a plumbing mechanism for scripts to access the C
logic used internally by git-status, git-branch, etc.

For example:

  $ git for-each-ref \
       --format='%(refname:short) %(upstream:short)' \
       refs/heads/
  master origin/master

Signed-off-by: Jeff King <peff@peff.net>
---
This is a cleaned-up version of what I sent previously. Mainly just code
cleanups, and it no longer frees the branch struct, which seems to be
allocated from semi-permanent storage during branch_get.

Should the documentation explain the concept of "upstream" more fully? I
noticed Santi sent a glossary patch earlier today, so maybe that is
enough.

 Documentation/git-for-each-ref.txt |    5 +++++
 builtin-for-each-ref.c             |   14 ++++++++++++++
 t/t6300-for-each-ref.sh            |   22 ++++++++++++++++++++++
 3 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 5061d3e..b362e9e 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -85,6 +85,11 @@ objectsize::
 objectname::
 	The object name (aka SHA-1).
 
+upstream::
+	The name of a local ref which can be considered ``upstream''
+	from the displayed ref. Respects `:short` in the same way as
+	`refname` above.
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index b50c93b..277d1fb 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -8,6 +8,7 @@
 #include "blob.h"
 #include "quote.h"
 #include "parse-options.h"
+#include "remote.h"
 
 /* Quoting styles */
 #define QUOTE_NONE 0
@@ -66,6 +67,7 @@ static struct {
 	{ "subject" },
 	{ "body" },
 	{ "contents" },
+	{ "upstream" },
 };
 
 /*
@@ -682,6 +684,18 @@ static void populate_value(struct refinfo *ref)
 
 		if (!prefixcmp(name, "refname"))
 			refname = ref->refname;
+		else if(!prefixcmp(name, "upstream")) {
+			struct branch *branch;
+			/* only local branches may have an upstream */
+			if (prefixcmp(ref->refname, "refs/heads/"))
+				continue;
+			branch = branch_get(ref->refname + 11);
+
+			if (!branch || !branch->merge || !branch->merge[0] ||
+			    !branch->merge[0]->dst)
+				continue;
+			refname = branch->merge[0]->dst;
+		}
 		else
 			continue;
 
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 8bfae44..daf02d5 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -26,6 +26,13 @@ test_expect_success 'Create sample commit with known timestamp' '
 	git tag -a -m "Tagging at $datestamp" testtag
 '
 
+test_expect_success 'Create upstream config' '
+	git update-ref refs/remotes/origin/master master &&
+	git remote add origin nowhere &&
+	git config branch.master.remote origin &&
+	git config branch.master.merge refs/heads/master
+'
+
 test_atom() {
 	case "$1" in
 		head) ref=refs/heads/master ;;
@@ -39,6 +46,7 @@ test_atom() {
 }
 
 test_atom head refname refs/heads/master
+test_atom head upstream refs/remotes/origin/master
 test_atom head objecttype commit
 test_atom head objectsize 171
 test_atom head objectname 67a36f10722846e891fbada1ba48ed035de75581
@@ -68,6 +76,7 @@ test_atom head contents 'Initial
 '
 
 test_atom tag refname refs/tags/testtag
+test_atom tag upstream ''
 test_atom tag objecttype tag
 test_atom tag objectsize 154
 test_atom tag objectname 98b46b1d36e5b07909de1b3886224e3e81e87322
@@ -203,6 +212,7 @@ test_expect_success 'Check format "rfc2822" date fields output' '
 
 cat >expected <<\EOF
 refs/heads/master
+refs/remotes/origin/master
 refs/tags/testtag
 EOF
 
@@ -214,6 +224,7 @@ test_expect_success 'Verify ascending sort' '
 
 cat >expected <<\EOF
 refs/tags/testtag
+refs/remotes/origin/master
 refs/heads/master
 EOF
 
@@ -224,6 +235,7 @@ test_expect_success 'Verify descending sort' '
 
 cat >expected <<\EOF
 'refs/heads/master'
+'refs/remotes/origin/master'
 'refs/tags/testtag'
 EOF
 
@@ -244,6 +256,7 @@ test_expect_success 'Quoting style: python' '
 
 cat >expected <<\EOF
 "refs/heads/master"
+"refs/remotes/origin/master"
 "refs/tags/testtag"
 EOF
 
@@ -273,6 +286,15 @@ test_expect_success 'Check short refname format' '
 	test_cmp expected actual
 '
 
+cat >expected <<EOF
+origin/master
+EOF
+
+test_expect_success 'Check short upstream format' '
+	git for-each-ref --format="%(upstream:short)" refs/heads >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'Check for invalid refname format' '
 	test_must_fail git for-each-ref --format="%(refname:INVALID)"
 '
-- 
1.6.2.2.450.gd6aa9.dirty
