From: Jeff King <peff@peff.net>
Subject: [PATCH 01/16] tr portability fixes
Date: Wed, 12 Mar 2008 17:29:57 -0400
Message-ID: <20080312212957.GB26286@coredump.intra.peff.net>
References: <cover.1205356737.git.peff@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Whit Armstrong <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 22:30:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZYX2-0006Ca-VG
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 22:30:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbYCLVaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 17:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751918AbYCLVaA
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 17:30:00 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4844 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751343AbYCLV37 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 17:29:59 -0400
Received: (qmail 2618 invoked by uid 111); 12 Mar 2008 21:29:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Mar 2008 17:29:58 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2008 17:29:57 -0400
Content-Disposition: inline
In-Reply-To: <cover.1205356737.git.peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76991>

Specifying character ranges in tr differs between System V
and POSIX. In System V, brackets are required (e.g.,
'[A-Z]'), whereas in POSIX they are not.

We can mostly get around this by just using the bracket form
for both sets, as in:

  tr '[A-Z] '[a-z]'

in which case POSIX interpets this as "'[' becomes '['",
which is OK.

However, this doesn't work with multiple sequences, like:

  # rot13
  tr '[A-Z][a-z]' '[N-Z][A-M][n-z][a-m]'

where the POSIX version does not behave the same as the
System V version. In this case, we must simply enumerate the
sequence.

This patch fixes problematic uses of tr in git scripts and
test scripts in one of three ways:

  - if a single sequence, make sure it uses brackets
  - if multiple sequences, enumerate
  - if extra brackets (e.g., tr '[A]' 'a'), eliminate
    brackets

Signed-off-by: Jeff King <peff@peff.net>
---
This was posted earlier, but mid-thread.

 git-bisect.sh            |    4 ++--
 git-filter-branch.sh     |    4 ++--
 t/t4022-diff-rewrite.sh  |    5 ++++-
 t/t7003-filter-branch.sh |    2 +-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 2c32d0b..48fb92d 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -293,14 +293,14 @@ bisect_next() {
 	bisect_next_check good
 
 	skip=$(git for-each-ref --format='%(objectname)' \
-		"refs/bisect/skip-*" | tr '[\012]' ' ') || exit
+		"refs/bisect/skip-*" | tr '\012' ' ') || exit
 
 	BISECT_OPT=''
 	test -n "$skip" && BISECT_OPT='--bisect-all'
 
 	bad=$(git rev-parse --verify refs/bisect/bad) &&
 	good=$(git for-each-ref --format='^%(objectname)' \
-		"refs/bisect/good-*" | tr '[\012]' ' ') &&
+		"refs/bisect/good-*" | tr '\012' ' ') &&
 	eval="git rev-list --bisect-vars $BISECT_OPT $good $bad --" &&
 	eval="$eval $(cat "$GIT_DIR/BISECT_NAMES")" &&
 	eval=$(filter_skipped "$eval" "$skip") &&
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 010353a..59cf023 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -58,8 +58,8 @@ eval "$functions"
 # "author" or "committer
 
 set_ident () {
-	lid="$(echo "$1" | tr "A-Z" "a-z")"
-	uid="$(echo "$1" | tr "a-z" "A-Z")"
+	lid="$(echo "$1" | tr "[A-Z]" "[a-z]")"
+	uid="$(echo "$1" | tr "[a-z]" "[A-Z]")"
 	pick_id_script='
 		/^'$lid' /{
 			s/'\''/'\''\\'\'\''/g
diff --git a/t/t4022-diff-rewrite.sh b/t/t4022-diff-rewrite.sh
index 6de4acb..bf996fc 100755
--- a/t/t4022-diff-rewrite.sh
+++ b/t/t4022-diff-rewrite.sh
@@ -8,7 +8,10 @@ test_expect_success setup '
 
 	cat ../../COPYING >test &&
 	git add test &&
-	tr 'a-zA-Z' 'n-za-mN-ZA-M' <../../COPYING >test
+	tr \
+	  "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" \
+	  "nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM" \
+	  <../../COPYING >test
 
 '
 
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 6e14bf1..553131f 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -4,7 +4,7 @@ test_description='git-filter-branch'
 . ./test-lib.sh
 
 make_commit () {
-	lower=$(echo $1 | tr A-Z a-z)
+	lower=$(echo $1 | tr '[A-Z]' '[a-z]')
 	echo $lower > $lower
 	git add $lower
 	test_tick
-- 
1.5.4.4.543.g30fdd.dirty
