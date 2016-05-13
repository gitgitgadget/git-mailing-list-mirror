From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] t9107: use "return 1" instead of "exit 1"
Date: Fri, 13 May 2016 15:50:21 -0400
Message-ID: <20160513195021.GC9890@sigill.intra.peff.net>
References: <20160513194716.GA9806@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Armin Kunaschik <megabreit@googlemail.com>,
	Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 13 21:50:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1J6S-0001QI-1N
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 21:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbcEMTuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 15:50:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:39308 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932211AbcEMTuY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 15:50:24 -0400
Received: (qmail 14051 invoked by uid 102); 13 May 2016 19:50:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 15:50:23 -0400
Received: (qmail 21105 invoked by uid 107); 13 May 2016 19:50:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 15:50:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 May 2016 15:50:21 -0400
Content-Disposition: inline
In-Reply-To: <20160513194716.GA9806@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294565>

When a test runs a loop, it cannot rely on the usual
&&-chaining to propagate a failure inside the loop; it needs
to break out with a failure signal. However, unless you are
in a subshell, doing so with "exit 1" will exit the entire
test script, not just the test snippet we are in (and cause
the harness to complain that test_done was never reached).

So the fundamental point of this patch is s/exit/return/.
But while we're there, let's fix a number of style and
readability issues:

  - snippets in double-quotes need an extra layer of quoting
    for their meta-characters; let's avoid that by using
    single quotes

  - accumulating loop output by appending to a file in each
    iteration is brittle, as it can be affected by content
    left in the file by earlier tests. Instead, it's better
    to redirect stdout for the whole loop, so we know the
    output only comes from that loop.

  - using "test -z" to check that diff output is empty is
    overly verbose; we can just ask diff to use --exit-code.

  - we can factor out long lists of refs to make it more
    obvious we're using the same ones in each loop

  - subshells are unnecessary when ending an &&-chain with
    "|| return 1"

  - minor style fixups like space-after-redirection, and
    "do" and "done" on their own lines

Signed-off-by: Jeff King <peff@peff.net>
---
This covers all of the "|| exit 1" cases I could find. If you grep,
there are a number of them, but they are all inside subshells (where
it's the correct thing to use).

This is a bugfix, but it's not _that_ big a deal, in the sense that
using "exit 1" would definitely signal to the caller that the test
failed. :) But it disrupts things like the TAP output.

 t/t9107-git-svn-migrate.sh | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
index 6efc2ab..2908aef 100755
--- a/t/t9107-git-svn-migrate.sh
+++ b/t/t9107-git-svn-migrate.sh
@@ -56,9 +56,11 @@ test_expect_success 'initialize a multi-repository repo' '
 	                        "^tags/\*:refs/remotes/origin/tags/\*$" &&
 	git config --add svn-remote.svn.fetch "branches/a:refs/remotes/origin/a" &&
 	git config --add svn-remote.svn.fetch "branches/b:refs/remotes/origin/b" &&
-	for i in tags/0.1 tags/0.2 tags/0.3; do
+	for i in tags/0.1 tags/0.2 tags/0.3
+	do
 		git config --add svn-remote.svn.fetch \
-		                 $i:refs/remotes/origin/$i || exit 1; done &&
+			$i:refs/remotes/origin/$i || return 1
+	done &&
 	git config --get-all svn-remote.svn.fetch > fetch.out &&
 	grep "^trunk:refs/remotes/origin/trunk$" fetch.out &&
 	grep "^branches/a:refs/remotes/origin/a$" fetch.out &&
@@ -70,30 +72,38 @@ test_expect_success 'initialize a multi-repository repo' '
 	'
 
 # refs should all be different, but the trees should all be the same:
-test_expect_success 'multi-fetch works on partial urls + paths' "
+test_expect_success 'multi-fetch works on partial urls + paths' '
+	refs="trunk a b tags/0.1 tags/0.2 tags/0.3" &&
 	git svn multi-fetch &&
-	for i in trunk a b tags/0.1 tags/0.2 tags/0.3; do
-		git rev-parse --verify refs/remotes/origin/\$i^0 >> refs.out || exit 1;
-	    done &&
-	test -z \"\$(sort < refs.out | uniq -d)\" &&
-	for i in trunk a b tags/0.1 tags/0.2 tags/0.3; do
-	  for j in trunk a b tags/0.1 tags/0.2 tags/0.3; do
-		if test \$j != \$i; then continue; fi
-	    test -z \"\$(git diff refs/remotes/origin/\$i \
-				 refs/remotes/origin/\$j)\" ||exit 1; done; done
-	"
+	for i in $refs
+	do
+		git rev-parse --verify refs/remotes/origin/$i^0 || return 1;
+	done >refs.out &&
+	test -z "$(sort <refs.out | uniq -d)" &&
+	>expect &&
+	for i in $refs
+	do
+		for j in $refs
+		do
+			git diff --exit-code refs/remotes/origin/$i refs/remotes/origin/$j ||
+				return 1
+		done
+	done
+'
 
 test_expect_success 'migrate --minimize on old inited layout' '
 	git config --unset-all svn-remote.svn.fetch &&
 	git config --unset-all svn-remote.svn.url &&
 	rm -rf "$GIT_DIR"/svn &&
-	for i in $(cat fetch.out); do
+	for i in $(cat fetch.out)
+	do
 		path=$(expr $i : "\([^:]*\):.*$")
 		ref=$(expr $i : "[^:]*:\(refs/remotes/.*\)$")
 		if test -z "$ref"; then continue; fi
 		if test -n "$path"; then path="/$path"; fi
-		( mkdir -p "$GIT_DIR"/svn/$ref/info/ &&
-		echo "$svnrepo"$path > "$GIT_DIR"/svn/$ref/info/url ) || exit 1;
+		mkdir -p "$GIT_DIR"/svn/$ref/info/ &&
+		echo "$svnrepo"$path >"$GIT_DIR"/svn/$ref/info/url ||
+		return 1
 	done &&
 	git svn migrate --minimize &&
 	test -z "$(git config -l | grep "^svn-remote\.git-svn\.")" &&
-- 
2.8.2.825.gea31738
