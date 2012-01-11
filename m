From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] archive: loosen restrictions on remote object lookup
Date: Wed, 11 Jan 2012 14:42:32 -0500
Message-ID: <20120111194232.GB12441@sigill.intra.peff.net>
References: <20120111193916.GA12333@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Albert Astals Cid <aacid@kde.org>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Jan 11 20:42:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl44L-0000gP-KF
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 20:42:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757980Ab2AKTmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 14:42:38 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35297
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757635Ab2AKTmh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 14:42:37 -0500
Received: (qmail 22717 invoked by uid 107); 11 Jan 2012 19:49:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 11 Jan 2012 14:49:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jan 2012 14:42:32 -0500
Content-Disposition: inline
In-Reply-To: <20120111193916.GA12333@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188387>

Initially, "git upload-archive" would feed the tree
specification from the remote side directly into get_sha1,
giving the remote user the full power of the object name
resolver. This was convenient, but it also meant that remote
users could fetch disconnected trees by their sha1s, which
violates the long-standing behavior of upload-pack not to
make such objects available.

Later, commit ee27ca4 tightened this to use dwim_ref instead
of get_sha1 for the remote case, allowing only the use of
actual refs. Unfortunately, this broke some existing use
cases, like fetching sub-trees with "$ref:subdir".

This patch loosens the restrictions to re-enable those use
cases. It does this by using get_sha1_with_context for the
object lookup, and checking that only allowable features
were used.

Signed-off-by: Jeff King <peff@peff.net>
---
 archive.c                     |   34 ++++++++++++++-------
 t/t5002-archive-resolution.sh |   66 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+), 11 deletions(-)
 create mode 100755 t/t5002-archive-resolution.sh

diff --git a/archive.c b/archive.c
index 164bbd0..a031bde 100644
--- a/archive.c
+++ b/archive.c
@@ -246,6 +246,25 @@ static void parse_pathspec_arg(const char **pathspec,
 	}
 }
 
+static int check_object_context(int remote, const struct object_context *oc)
+{
+	/* For local requests, allow anything */
+	if (!remote)
+		return 1;
+	/*
+	 * Otherwise, require that we accessed the object through a ref,
+	 * but not have used any of the advanced features like looking in
+	 * the reflog.
+	 */
+	return oc->used_ref &&
+	       !oc->used_reflog &&
+	       !oc->used_index &&
+	       !oc->used_nth_checkout &&
+	       !oc->used_describe_name &&
+	       !oc->used_oneline &&
+	       !oc->used_raw_hex;
+}
+
 static void parse_treeish_arg(const char **argv,
 		struct archiver_args *ar_args, const char *prefix,
 		int remote)
@@ -256,18 +275,11 @@ static void parse_treeish_arg(const char **argv,
 	struct tree *tree;
 	const struct commit *commit;
 	unsigned char sha1[20];
+	struct object_context oc;
 
-	/* Remotes are only allowed to fetch actual refs */
-	if (remote) {
-		char *ref = NULL;
-		if (!dwim_ref(name, strlen(name), sha1, &ref))
-			die("no such ref: %s", name);
-		free(ref);
-	}
-	else {
-		if (get_sha1(name, sha1))
-			die("Not a valid object name");
-	}
+	if (get_sha1_with_context(name, sha1, &oc) ||
+	    !check_object_context(remote, &oc))
+		die("Not a valid object name");
 
 	commit = lookup_commit_reference_gently(sha1, 1);
 	if (commit) {
diff --git a/t/t5002-archive-resolution.sh b/t/t5002-archive-resolution.sh
new file mode 100755
index 0000000..bf2b55c
--- /dev/null
+++ b/t/t5002-archive-resolution.sh
@@ -0,0 +1,66 @@
+#!/bin/sh
+
+test_description='test object resolution methods for local and remote archive'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo a >a &&
+	git add . &&
+	git commit -m one &&
+	sha1_one=`git rev-parse HEAD` &&
+	mkdir subdir &&
+	echo b >subdir/b &&
+	git add . &&
+	git commit -m two &&
+	git checkout -b other &&
+	git checkout master
+'
+
+while read desc where what expect; do
+	cmd="git archive --format=tar -o result.tar"
+	test "$where" = "remote" && cmd="$cmd --remote=."
+	cmd="$cmd $what"
+
+	if test "$expect" = "deny"; then
+		test_expect_success "archive $desc ($where, should deny)" "
+			test_must_fail $cmd
+		"
+	else
+		test_expect_success "archive $desc ($where, should work)" '
+			'"$cmd"' &&
+			for i in '"$expect"'; do
+				echo "$i:`basename $i`"
+			done >expect &&
+			rm -rf result &&
+			mkdir result &&
+			(cd result &&
+			tar xf ../result.tar &&
+			for i in `find * -type f`; do
+				echo "$i:`cat $i`"
+			done >../actual
+			) &&
+			test_cmp expect actual
+		'
+	fi
+done <<EOF
+ref local  master a subdir/b
+ref remote master a subdir/b
+parent local  master^ a
+parent remote master^ a
+tree local  master^{tree} a subdir/b
+tree remote master^{tree} a subdir/b
+subtree local  master:subdir b
+subtree remote master:subdir b
+sha1 local  $sha1_one a
+sha1 remote $sha1_one deny
+reflog local  master@{1} a
+reflog remote master@{1} deny
+oneline local  :/one a
+oneline remote :/one deny
+oneline-ref local  master^{/one} a
+oneline-ref remote master^{/one} deny
+nth-checkout local  @{-1} a subdir/b
+nth-checkout remote @{-1} deny
+EOF
+
+test_done
-- 
1.7.9.rc0.33.gd3c17
