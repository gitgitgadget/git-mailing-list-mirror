From: Jeff King <peff@peff.net>
Subject: [PATCH 10/12] sha1_name: implement @{push} shorthand
Date: Fri, 1 May 2015 18:55:41 -0400
Message-ID: <20150501225541.GJ1534@peff.net>
References: <20150501224414.GA25551@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 02 00:55:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoJqW-0004sf-Cn
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 00:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbbEAWzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 18:55:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:53123 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750778AbbEAWzn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 18:55:43 -0400
Received: (qmail 24178 invoked by uid 102); 1 May 2015 22:55:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 17:55:43 -0500
Received: (qmail 21127 invoked by uid 107); 1 May 2015 22:56:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 18:56:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 May 2015 18:55:41 -0400
Content-Disposition: inline
In-Reply-To: <20150501224414.GA25551@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268195>

In a triangular workflow, each branch may have two distinct
points of interest: the @{upstream} that you normally pull
from, and the destination that you normally push to. There
isn't a shorthand for the latter, but it's useful to have.

For instance, you may want to know which commits you haven't
pushed yet:

  git log @{push}..

Or as a more complicated example, imagine that you normally
pull changes from origin/master (which you set as your
@{upstream}), and push changes to your own personal fork
(e.g., as myfork/topic). You may push to your fork from
multiple machines, requiring you to integrate the changes
from the push destination, rather than upstream. With this
patch, you can just do:

  git rebase @{push}

rather than typing out the full name.

The heavy lifting is all done by branch_get_push; here we
just wire it up to the "@{push}" syntax.

Signed-off-by: Jeff King <peff@peff.net>
---
Most of this is from v1, but the heavy lifting was already extracted.

 Documentation/revisions.txt | 25 ++++++++++++++++++
 sha1_name.c                 | 14 +++++++++-
 t/t1514-rev-parse-push.sh   | 63 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100755 t/t1514-rev-parse-push.sh

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 0796118..d85e303 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -98,6 +98,31 @@ some output processing may assume ref names in UTF-8.
   `branch.<name>.merge`).  A missing branchname defaults to the
   current one.
 
+'<branchname>@\{push\}', e.g. 'master@\{push\}', '@\{push\}'::
+  The suffix '@\{push}' reports the branch "where we would push to" if
+  `git push` were run while `branchname` was checked out (or the current
+  'HEAD' if no branchname is specified). Since our push destination is
+  in a remote repository, of course, we report the local tracking branch
+  that corresponds to that branch (i.e., something in 'refs/remotes/').
++
+Here's an example to make it more clear:
++
+------------------------------
+$ git config push.default current
+$ git config remote.pushdefault myfork
+$ git checkout -b mybranch origin/master
+
+$ git rev-parse --symbolic-full-name @{upstream}
+refs/remotes/origin/master
+
+$ git rev-parse --symbolic-full-name @{push}
+refs/remotes/myfork/mybranch
+------------------------------
++
+Note in the example that we set up a triangular workflow, where we pull
+from one location and push to another. In a non-triangular workflow,
+'@\{push}' is the same as '@\{upstream}', and there is no need for it.
+
 '<rev>{caret}', e.g. 'HEAD{caret}, v1.5.1{caret}0'::
   A suffix '{caret}' to a revision parameter means the first parent of
   that commit object.  '{caret}<n>' means the <n>th parent (i.e.
diff --git a/sha1_name.c b/sha1_name.c
index 506e0c9..1096943 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -435,6 +435,12 @@ static inline int upstream_mark(const char *string, int len)
 	return at_mark(string, len, suffix, ARRAY_SIZE(suffix));
 }
 
+static inline int push_mark(const char *string, int len)
+{
+	const char *suffix[] = { "@{push}" };
+	return at_mark(string, len, suffix, ARRAY_SIZE(suffix));
+}
+
 static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned lookup_flags);
 static int interpret_nth_prior_checkout(const char *name, int namelen, struct strbuf *buf);
 
@@ -482,7 +488,8 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1,
 					nth_prior = 1;
 					continue;
 				}
-				if (!upstream_mark(str + at, len - at)) {
+				if (!upstream_mark(str + at, len - at) &&
+				    !push_mark(str + at, len - at)) {
 					reflog_len = (len-1) - (at+2);
 					len = at;
 				}
@@ -1145,6 +1152,11 @@ int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
 					    upstream_mark, branch_get_upstream);
 		if (len > 0)
 			return len;
+
+		len = interpret_branch_mark(name, namelen, at - name, buf,
+					    push_mark, branch_get_push);
+		if (len > 0)
+			return len;
 	}
 
 	return -1;
diff --git a/t/t1514-rev-parse-push.sh b/t/t1514-rev-parse-push.sh
new file mode 100755
index 0000000..7214f5b
--- /dev/null
+++ b/t/t1514-rev-parse-push.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
+
+test_description='test <branch>@{push} syntax'
+. ./test-lib.sh
+
+resolve () {
+	echo "$2" >expect &&
+	git rev-parse --symbolic-full-name "$1" >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'setup' '
+	git init --bare parent.git &&
+	git init --bare other.git &&
+	git remote add origin parent.git &&
+	git remote add other other.git &&
+	test_commit base &&
+	git push origin HEAD &&
+	git branch --set-upstream-to=origin/master master &&
+	git branch --track topic origin/master &&
+	git push origin topic &&
+	git push other topic
+'
+
+test_expect_success '@{push} with default=nothing' '
+	test_config push.default nothing &&
+	test_must_fail git rev-parse master@{push}
+'
+
+test_expect_success '@{push} with default=simple' '
+	test_config push.default simple &&
+	resolve master@{push} refs/remotes/origin/master
+'
+
+test_expect_success 'triangular @{push} fails with default=simple' '
+	test_config push.default simple &&
+	test_must_fail git rev-parse topic@{push}
+'
+
+test_expect_success '@{push} with default=current' '
+	test_config push.default current &&
+	resolve topic@{push} refs/remotes/origin/topic
+'
+
+test_expect_success '@{push} with default=matching' '
+	test_config push.default matching &&
+	resolve topic@{push} refs/remotes/origin/topic
+'
+
+test_expect_success '@{push} with pushremote defined' '
+	test_config push.default current &&
+	test_config branch.topic.pushremote other &&
+	resolve topic@{push} refs/remotes/other/topic
+'
+
+test_expect_success '@{push} with push refspecs' '
+	test_config push.default nothing &&
+	test_config remote.origin.push refs/heads/*:refs/heads/magic/* &&
+	git push &&
+	resolve topic@{push} refs/remotes/origin/magic/topic
+'
+
+test_done
-- 
2.4.0.rc3.477.gc25258d
