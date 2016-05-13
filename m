From: Jeff King <peff@peff.net>
Subject: [PATCH 6/6] always quote shell arguments to test -z/-n
Date: Fri, 13 May 2016 16:47:33 -0400
Message-ID: <20160513204732.GF15391@sigill.intra.peff.net>
References: <20160513204654.GA10684@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 13 22:47:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1Jzo-0000e2-TA
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 22:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbcEMUrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 16:47:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:39383 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932178AbcEMUrg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 16:47:36 -0400
Received: (qmail 16758 invoked by uid 102); 13 May 2016 20:47:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 16:47:35 -0400
Received: (qmail 21645 invoked by uid 107); 13 May 2016 20:47:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 16:47:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 May 2016 16:47:33 -0400
Content-Disposition: inline
In-Reply-To: <20160513204654.GA10684@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294583>

In shell code like:

  test -z $foo
  test -n $foo

that does not quote its arguments, it's easy to think that
it is actually looking at the contents of $foo in each case.
But if $foo is empty, then "test" does not see any argument
at all! The results are quite subtle.

POSIX specifies that test's behavior depends on the number
of arguments it sees, and if $foo is empty, it sees only
one. The behavior in this case is:

  1 argument: Exit true (0) if $1 is not null; otherwise,
              exit false.

So in the "-z $foo" case, if $foo is empty, then we check
that "-z" is non-null, and it returns success. Which happens
to match what we expected.  But for "-n $foo", if $foo is
empty, we'll see that "-n" is non-null and still return
success. That's the opposite of what we intended!

Furthermore, if $foo contains whitespace, we'll end up with
more than 2 arguments. The results in this case are
generally unspecified (unless the first part of $foo happens
to be a valid binary operator, in which case the results are
specified but certainly not what we intended).

And on top of this, even though "test -z $foo" _should_ work
for the empty case, some older shells (reportedly ksh88)
complain about the missing argument.

So let's make sure we consistently quote our variable
arguments to "test". After this patch, the results of:

  git grep 'test -[zn] [^"]'

are empty.

Reported-by: Armin Kunaschik <megabreit@googlemail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 git-rebase--interactive.sh | 4 ++--
 git-stash.sh               | 4 ++--
 t/t4151-am-abort.sh        | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 9ea3075..470413b 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -866,12 +866,12 @@ add_exec_commands () {
 # $3: the input filename
 check_commit_sha () {
 	badsha=0
-	if test -z $1
+	if test -z "$1"
 	then
 		badsha=1
 	else
 		sha1_verif="$(git rev-parse --verify --quiet $1^{commit})"
-		if test -z $sha1_verif
+		if test -z "$sha1_verif"
 		then
 			badsha=1
 		fi
diff --git a/git-stash.sh b/git-stash.sh
index c7c65e2..c7509e8 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -185,7 +185,7 @@ store_stash () {
 
 	git update-ref --create-reflog -m "$stash_msg" $ref_stash $w_commit
 	ret=$?
-	test $ret != 0 && test -z $quiet &&
+	test $ret != 0 && test -z "$quiet" &&
 	die "$(eval_gettext "Cannot update \$ref_stash with \$w_commit")"
 	return $ret
 }
@@ -277,7 +277,7 @@ save_stash () {
 			git clean --force --quiet -d $CLEAN_X_OPTION
 		fi
 
-		if test "$keep_index" = "t" && test -n $i_tree
+		if test "$keep_index" = "t" && test -n "$i_tree"
 		then
 			git read-tree --reset -u $i_tree
 		fi
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index ea5ace9..9473c27 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -82,7 +82,7 @@ test_expect_success 'am -3 --abort removes otherfile-4' '
 	test 4 = "$(cat otherfile-4)" &&
 	git am --abort &&
 	test_cmp_rev initial HEAD &&
-	test -z $(git ls-files -u) &&
+	test -z "$(git ls-files -u)" &&
 	test_path_is_missing otherfile-4
 '
 
-- 
2.8.2.825.gea31738
