From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] fix bsd shell negation
Date: Wed, 14 May 2008 00:01:22 -0400
Message-ID: <20080514040122.GA9985@sigill.intra.peff.net>
References: <20080513084338.GA23729@sigill.intra.peff.net> <20080513084452.GA23799@sigill.intra.peff.net> <7viqxhr55h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 14 06:02:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw8CR-00035H-Mt
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 06:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbYENEB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 00:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbYENEB3
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 00:01:29 -0400
Received: from peff.net ([208.65.91.99]:2456 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770AbYENEB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 00:01:28 -0400
Received: (qmail 818 invoked by uid 111); 14 May 2008 04:01:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 14 May 2008 00:01:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 May 2008 00:01:22 -0400
Content-Disposition: inline
In-Reply-To: <7viqxhr55h.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82067>

On Tue, May 13, 2008 at 07:27:54PM -0700, Junio C Hamano wrote:

> After applying this patch, we still seem to have fair number of hits:
> 
>     $ git grep -n -e '![^(]* |' -- '*.sh'
> 
> t/t5302-pack-index.sh:68:	! echo "$msg" | grep "pack too large .* off_t"

This one didn't trigger for me because it is the second half of a
short-circuit conditional. But it should be fixed.

> t/t7002-grep.sh:111:		! git grep -c test $H | grep -q /dev/null

Hmm. I think my previous analysis is not quite right. The problem is not
exactly "! foo | bar". It must happen as part of a logic chain.

So:

  # all sane
  $ !  true |  true; echo $?; \
    !  true | false; echo $?; \
    ! false |  true; echo $?; \
    ! false | false; echo $?
  1
  0
  1
  0

  # but not this
  $ true && !  true |  true; echo $?; \
    true && !  true | false; echo $?; \
    true && ! false |  true; echo $?; \
    true && ! false | false; echo $?
  0
  1
  0
  1

(whereas with bash, one gets the same "1010" response for the second
set).

So it seems like it is parsing as:

  (true && ! true) | true

instead of

  true && ! (true | true)

But that is not quite right, either, since the output of the first
command doesn't go to the third. E.g.,:

  $ echo foo && ! echo bar | nl
  foo
      1 bar

So just the exit code gets munged.

However, explicitly grouping with a subshell does seem to fix it. In the
t7002-grep.sh case, though, there are no other logic operators, so it
works either way.

> t/t7600-merge.sh:378:	if ! grep "^ file |  *2 +-$" diffstat.txt
> t/t7600-merge.sh:392:	if ! grep "^ file |  *2 +-$" diffstat.txt

These are false positives to your grep; the | is part of a string. ;)

> t/t9400-git-cvsserver-server.sh:160:    ! cat request-anonymous |
> t/t9400-git-cvsserver-server.sh:169:    ! cat request-anonymous |
> t/t9400-git-cvsserver-server.sh:187:    ! cat request-anonymous |

Same precedence issue as above.

Below is an updated patch 1/4; it includes the one extra fix mentioned
above and fixes the inaccuracies in the commit message.

-- >8 --
fix bsd shell negation

On some shells (notably /bin/sh on FreeBSD 6.1), the
construct

  foo && ! bar | baz

is true if

  foo && baz

whereas for most other shells (such as bash) is true if

  foo && ! baz

We can work around this by specifying

  foo && ! (bar | baz)

which works everywhere.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-rebase.sh         |    2 +-
 t/t3400-rebase.sh     |    4 ++--
 t/t3700-add.sh        |    6 +++---
 t/t5302-pack-index.sh |    2 +-
 t/t7501-commit.sh     |    2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 9b13b83..fbb0f28 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -353,7 +353,7 @@ orig_head=$branch
 mb=$(git merge-base "$onto" "$branch")
 if test "$upstream" = "$onto" && test "$mb" = "$onto" &&
 	# linear history?
-	! git rev-list --parents "$onto".."$branch" | grep " .* " > /dev/null
+	! (git rev-list --parents "$onto".."$branch" | grep " .* ") > /dev/null
 then
 	# Lazily switch to the target branch if needed...
 	test -z "$switch_to" || git checkout "$switch_to"
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 496f4ec..fdad7da 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -44,13 +44,13 @@ test_expect_success 'rebase against master' '
 
 test_expect_success \
     'the rebase operation should not have destroyed author information' \
-    '! git log | grep "Author:" | grep "<>"'
+    '! (git log | grep "Author:" | grep "<>")'
 
 test_expect_success 'rebase after merge master' '
      git reset --hard topic &&
      git merge master &&
      git rebase master &&
-     ! git show | grep "^Merge:"
+     ! (git show | grep "^Merge:")
 '
 
 test_expect_success 'rebase of history with merges is linearized' '
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 287e058..68c5dde 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -81,17 +81,17 @@ test_expect_success '.gitignore test setup' '
 
 test_expect_success '.gitignore is honored' '
 	git add . &&
-	! git ls-files | grep "\\.ig"
+	! (git ls-files | grep "\\.ig")
 '
 
 test_expect_success 'error out when attempting to add ignored ones without -f' '
 	! git add a.?? &&
-	! git ls-files | grep "\\.ig"
+	! (git ls-files | grep "\\.ig")
 '
 
 test_expect_success 'error out when attempting to add ignored ones without -f' '
 	! git add d.?? &&
-	! git ls-files | grep "\\.ig"
+	! (git ls-files | grep "\\.ig")
 '
 
 test_expect_success 'add ignored ones with -f' '
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index b88b5bb..09fd917 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -65,7 +65,7 @@ test_expect_success \
 
 have_64bits=
 if msg=$(git verify-pack -v "test-3-${pack3}.pack" 2>&1) ||
-	! echo "$msg" | grep "pack too large .* off_t"
+	! (echo "$msg" | grep "pack too large .* off_t")
 then
 	have_64bits=t
 else
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index c0288f3..89710af 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -41,7 +41,7 @@ test_expect_success \
 test_expect_success \
 	"using paths with --interactive" \
 	"echo bong-o-bong >file &&
-	! echo 7 | git-commit -m foo --interactive file"
+	! (echo 7 | git-commit -m foo --interactive file)"
 
 test_expect_success \
 	"using invalid commit with -C" \
-- 
1.5.5.1.219.g82ba.dirty
