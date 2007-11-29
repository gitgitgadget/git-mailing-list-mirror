From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] receive-pack: allow deletion of corrupt refs
Date: Thu, 29 Nov 2007 01:02:53 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711290101420.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com, pasky@suse.cz
X-From: git-owner@vger.kernel.org Thu Nov 29 02:03:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxXoi-0000Nm-RA
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 02:03:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760437AbXK2BDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 20:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760128AbXK2BDG
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 20:03:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:35675 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759269AbXK2BDD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 20:03:03 -0500
Received: (qmail invoked by alias); 29 Nov 2007 01:03:01 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp012) with SMTP; 29 Nov 2007 02:03:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/6H4RGKPr6l/2WRgqiWrF19zwqbAB0V/uHOR2Po/
	REx+qS7RRgERfo
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66483>


Occasionally, in some setups (*cough* forks on repo.or.cz *cough*) some
refs go stale, e.g. when the forkee rebased and lost some objects needed
by the fork.  The quick & dirty way to deal with those refs is to delete
them and push them again.

However, git-push first would first fetch the current commit name for the
ref, would receive a null sha1 since the ref does not point to a valid
object, then tell receive-pack that it should delete the ref with this
commit name.  delete_ref() would be subsequently be called, and check that
resolve_ref() (which does _not_ check for validity of the object) returns
the same commit name.  Which would fail.

The proper fix is to avoid corrupting repositories, but in the meantime
this is a good fix in any case.

Incidentally, some instances of "cd .." in the test cases were fixed, so
that subsequent test cases run in t/trash/ irrespective of the outcome of
the previous test cases.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I was bitten one time too many by a rebased git/mingw.git/.

	Will work on the "proper fix" I hinted at.

 receive-pack.c        |    4 ++++
 t/t5516-fetch-push.sh |   41 ++++++++++++++++++++++++++---------------
 2 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/receive-pack.c b/receive-pack.c
index ed44b89..fba4cf8 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -200,6 +200,10 @@ static const char *update(struct command *cmd)
 	}
 
 	if (is_null_sha1(new_sha1)) {
+		if (!parse_object(old_sha1)) {
+			warning ("Allowing deletion of corrupt ref.");
+			old_sha1 = NULL;
+		}
 		if (delete_ref(name, old_sha1)) {
 			error("failed to delete %s", name);
 			return "failed to delete";
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index fd5f284..9d2dc33 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -274,9 +274,8 @@ test_expect_success 'push with HEAD nonexisting at remote' '
 test_expect_success 'push with dry-run' '
 
 	mk_test heads/master &&
-	cd testrepo &&
-	old_commit=$(git show-ref -s --verify refs/heads/master) &&
-	cd .. &&
+	(cd testrepo &&
+	 old_commit=$(git show-ref -s --verify refs/heads/master)) &&
 	git push --dry-run testrepo &&
 	check_push_result $old_commit heads/master
 '
@@ -284,28 +283,40 @@ test_expect_success 'push with dry-run' '
 test_expect_success 'push updates local refs' '
 
 	rm -rf parent child &&
-	mkdir parent && cd parent && git init &&
-		echo one >foo && git add foo && git commit -m one &&
-	cd .. &&
-	git clone parent child && cd child &&
+	mkdir parent &&
+	(cd parent && git init &&
+		echo one >foo && git add foo && git commit -m one) &&
+	git clone parent child &&
+	(cd child &&
 		echo two >foo && git commit -a -m two &&
 		git push &&
-	test $(git rev-parse master) = $(git rev-parse remotes/origin/master)
+	test $(git rev-parse master) = $(git rev-parse remotes/origin/master))
 
 '
 
 test_expect_success 'push does not update local refs on failure' '
 
 	rm -rf parent child &&
-	mkdir parent && cd parent && git init &&
+	mkdir parent &&
+	(cd parent && git init &&
 		echo one >foo && git add foo && git commit -m one &&
 		echo exit 1 >.git/hooks/pre-receive &&
-		chmod +x .git/hooks/pre-receive &&
-	cd .. &&
-	git clone parent child && cd child &&
-		echo two >foo && git commit -a -m two || exit 1
-		git push && exit 1
-	test $(git rev-parse master) != $(git rev-parse remotes/origin/master)
+		chmod +x .git/hooks/pre-receive) &&
+	git clone parent child &&
+	(cd child &&
+		echo two >foo && git commit -a -m two &&
+		! git push &&
+		test $(git rev-parse master) != \
+			$(git rev-parse remotes/origin/master))
+
+'
+
+test_expect_success 'allow deleting an invalid remote ref' '
+
+	pwd &&
+	rm -f testrepo/.git/objects/??/* &&
+	git push testrepo :refs/heads/master &&
+	(cd testrepo && ! git rev-parse --verify refs/heads/master)
 
 '
 
-- 
1.5.3.6.2065.gd47ac
