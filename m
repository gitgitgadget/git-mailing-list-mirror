From: Jeff King <peff@peff.net>
Subject: [PATCH 6/6] sha1_name: implement @{push} shorthand
Date: Tue, 31 Mar 2015 13:38:35 -0400
Message-ID: <20150331173834.GF18912@peff.net>
References: <20150331173339.GA17732@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 19:38:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd07e-0006W2-Et
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 19:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753029AbbCaRii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 13:38:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:40431 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751735AbbCaRih (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 13:38:37 -0400
Received: (qmail 16898 invoked by uid 102); 31 Mar 2015 17:38:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Mar 2015 12:38:37 -0500
Received: (qmail 25677 invoked by uid 107); 31 Mar 2015 17:38:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Mar 2015 13:38:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Mar 2015 13:38:35 -0400
Content-Disposition: inline
In-Reply-To: <20150331173339.GA17732@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266539>

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

Signed-off-by: Jeff King <peff@peff.net>
---
As an aside, I messed up an &&-chain in the tests, which was caught by
GIT_TEST_CHAIN_LINT before submitting. The system works!

 Documentation/revisions.txt |  25 +++++++++++
 sha1_name.c                 | 102 +++++++++++++++++++++++++++++++++++++++++++-
 t/t1514-rev-parse-push.sh   |  63 +++++++++++++++++++++++++++
 3 files changed, 189 insertions(+), 1 deletion(-)
 create mode 100755 t/t1514-rev-parse-push.sh

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 0796118..5d9df25 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -98,6 +98,31 @@ some output processing may assume ref names in UTF-8.
   `branch.<name>.merge`).  A missing branchname defaults to the
   current one.
 
+'<branchname>@\{push\}', e.g. 'master@\{push\}', '@\{push\}'::
+  The suffix `@{push}` reports the branch "where we would push to" if
+  `git push` were run while `branchname` was checked out (or the current
+  `HEAD` is no branchname is specified). Since our push destination is
+  in a remote repository, of course, we report the local tracking branch
+  that corresponds to that branch (i.e., something in `refs/remotes/`).
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
+`@{push}` is the same as `@{upstream}`, and there is no need for it.
+
 '<rev>{caret}', e.g. 'HEAD{caret}, v1.5.1{caret}0'::
   A suffix '{caret}' to a revision parameter means the first parent of
   that commit object.  '{caret}<n>' means the <n>th parent (i.e.
diff --git a/sha1_name.c b/sha1_name.c
index 3741ca3..1da3291 100644
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
@@ -1104,6 +1111,95 @@ static int interpret_upstream_mark(const char *name, int namelen,
 	return len + at;
 }
 
+static char *tracking_ref_for(struct remote *remote, const char *refname)
+{
+	char *ret;
+
+	ret = apply_refspecs(remote->fetch, remote->fetch_refspec_nr, refname);
+	if (!ret)
+		die(_("@{push} has no local tracking branch for remote '%s'"),
+		    refname);
+	return ret;
+}
+
+static char *get_push_branch(const char *name, int len)
+{
+	char *branch_name;
+	struct branch *branch;
+	struct remote *remote;
+
+	branch_name = xmemdupz(name, len);
+	branch = branch_get(*branch_name ? branch_name : NULL);
+	if (!branch)
+		die(_("HEAD does not point to a branch"));
+	free(branch_name);
+
+	remote = remote_get(pushremote_for_branch(branch, NULL));
+	if (!remote)
+		die(_("branch '%s' has no remote for pushing"), branch->name);
+
+	if (remote->push_refspec_nr) {
+		char *dst, *ret;
+
+		dst = apply_refspecs(remote->push, remote->push_refspec_nr,
+				     branch->refname);
+		if (!dst)
+			die(_("push refspecs for '%s' do not include '%s'"),
+			    remote->name, branch->name);
+
+		ret = tracking_ref_for(remote, dst);
+		free(dst);
+		return ret;
+	}
+
+	if (remote->mirror)
+		return tracking_ref_for(remote, branch->refname);
+
+	switch (push_default) {
+	case PUSH_DEFAULT_NOTHING:
+		die(_("@{push} has no destination (push.default is 'nothing'"));
+
+	case PUSH_DEFAULT_MATCHING:
+	case PUSH_DEFAULT_CURRENT:
+		return tracking_ref_for(remote, branch->refname);
+
+	case PUSH_DEFAULT_UPSTREAM:
+		return xstrdup(get_upstream_branch(name, len));
+
+	case PUSH_DEFAULT_UNSPECIFIED:
+	case PUSH_DEFAULT_SIMPLE:
+		{
+			const char *up = get_upstream_branch(name, len);
+			char *cur = tracking_ref_for(remote, branch->refname);
+			if (strcmp(cur, up))
+				die("cannot resolve 'simple' @{push} to a single destination");
+			return cur;
+		}
+	}
+
+	die("BUG: unhandled @{push} situation");
+}
+
+static int interpret_push_mark(const char *name, int namelen,
+			       int at, struct strbuf *buf)
+{
+	int len;
+	char *result;
+
+	len = push_mark(name + at, namelen - at);
+	if (!len)
+		return -1;
+
+	if (memchr(name, ':', at))
+		return -1;
+
+	result = get_push_branch(name, at);
+	set_shortened_ref(buf, result);
+	free(result);
+
+	return len + at;
+}
+
 /*
  * This reads short-hand syntax that not only evaluates to a commit
  * object name, but also can act as if the end user spelled the name
@@ -1154,6 +1250,10 @@ int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
 		len = interpret_upstream_mark(name, namelen, at - name, buf);
 		if (len > 0)
 			return len;
+
+		len = interpret_push_mark(name, namelen, at - name, buf);
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
2.4.0.rc0.363.gf9f328b
