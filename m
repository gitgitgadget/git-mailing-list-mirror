From: Jeff King <peff@peff.net>
Subject: Re: t3404 static check of bad SHA-1 failure
Date: Fri, 13 May 2016 14:23:26 -0400
Message-ID: <20160513182325.GB30700@sigill.intra.peff.net>
References: <CALR6jEiH6oxq=KXfz1pqOue9VKnkp=S8zNqC4OFmbuhRFFxoMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Armin Kunaschik <megabreit@googlemail.com>
X-From: git-owner@vger.kernel.org Fri May 13 20:23:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1HkN-0004oq-MU
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 20:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421AbcEMSXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 14:23:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:39245 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753523AbcEMSX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 14:23:29 -0400
Received: (qmail 9981 invoked by uid 102); 13 May 2016 18:23:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 14:23:28 -0400
Received: (qmail 20401 invoked by uid 107); 13 May 2016 18:23:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 14:23:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 May 2016 14:23:26 -0400
Content-Disposition: inline
In-Reply-To: <CALR6jEiH6oxq=KXfz1pqOue9VKnkp=S8zNqC4OFmbuhRFFxoMw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294555>

On Fri, May 13, 2016 at 06:09:35PM +0200, Armin Kunaschik wrote:

> in t3404 test 91 - static check of bad SHA-1 fails (with ksh) with a
> syntax error in git-rebase.
> git-rebase[6]: test: argument expected

Here's a fix that covers these and another I found:

-- >8 --
Subject: [PATCH] always quote arguments to "test -z" in shell

Modern shells are pretty forgiving about us doing:

  test -z $foo

If $foo is indeed empty, the test command will see only:

  test -z

and treat the missing argument as "yes, this is empty". But
some older shells, reportedly ksh88, complain about the
missing argument. We can be more portable by spelling this
as:

  test -z "$foo"

so that "test" sees an empty argument, not a missing one.

This covers all cases detected by:

  git grep 'test -z [^"]'

(though note that has a few false positives for tests which
need an extra layer of quoting to do '\"').

Reported-by: Armin Kunaschik <megabreit@googlemail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
Actually, this misses the case in t4151 which already has a fix queued
on pu. Arguably these should all just be squashed together (and I am
happy, Junio, if you want to do so and leave Armin as the author of the
new commit).

 git-rebase--interactive.sh | 4 ++--
 git-stash.sh               | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

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
index c7c65e2..57f9dc1 100755
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
-- 
2.8.2.825.gea31738
