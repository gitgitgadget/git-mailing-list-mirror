From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 2/3] change default push refspec when --current is given
Date: Tue, 14 Jul 2009 01:07:41 +0200
Message-ID: <1247526462-17584-3-git-send-email-bonzini@gnu.org>
References: <1247526462-17584-1-git-send-email-bonzini@gnu.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 14 01:08:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQUd0-0000nt-Uj
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 01:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757588AbZGMXH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2009 19:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753773AbZGMXHy
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 19:07:54 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:39443 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968AbZGMXHv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2009 19:07:51 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1MQUcg-0007UO-CY
	for git@vger.kernel.org; Mon, 13 Jul 2009 19:07:50 -0400
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <1247526462-17584-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123210>

This patch is separate because I find it a little more controversial.
Actually, after writing the tests I am pretty sure that it results
in a more intuitive behavior, but keeping it separate also makes it
clearer to see the effect of the patch (from the changes to the
testsuite).

With this patch, if there is no push.default specified I make the
default push refspec "HEAD".  This conforms to the idea of pushing
the current branch only.

The main effect of the patch is that, in a normal configuration,
"git push --current FOO" will *not* give an error when pushing to
an empty destination.  Instead, it will obviously push the current
branch to the destination, with the same name.  I find this quite
intuitive.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
	Actually, I'm pretty sure that the behavior after patch 1 is
	more or less "wrong".

	The reason why I split this patch is that I'm undecided whether
	to do something even more Draconian: when --current is used,
	*always* use a default refspec of HEAD, even when push.default
	is set.  I somehow felt this was more correct, yet I didn't do it
	for three reasons.  Together, these were enough to discourage
	me:

	1) it would have been more complicated to document, even though
	easier to code;

	2) this only affects one case, i.e. pushing a new branch;

	3) I want to implement "git remote add
	--push={matching,current,tracking}" as the next step; this will
	automatically a remote.*.push=HEAD line when appropriate.

	This means that in practice nobody will see the difference
	assuming I get to (3) before 1.6.5 or something like that.

 Documentation/git-push.txt |    6 +++++-
 builtin-push.c             |    8 ++++++--
 t/t5516-fetch-push.sh      |   20 +++++++++-----------
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 0d6fcaa..ce6133e 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -75,11 +75,15 @@ nor in any Push line of the corresponding remotes file---see below).
 	Independent of the other options, restrict pushing to the current
 	HEAD.
 
-	Refspecs given in the configuration is still used to find the
+	Refspecs given in the configuration are still used to find the
 	destination name of the current branch.  However, this option
 	cannot be specified if an explicit refspec is given on the
 	command line, because it would be useless and possibly confusing.
 
+	Additionally, if there is no refspec in the configuration and no
+	`push.default` configuration either, with this option git will
+	use a default refspec of `HEAD` rather than `:`.
+
 --mirror::
 	Instead of naming each ref to push, specifies that all
 	refs under `$GIT_DIR/refs/` (which includes but is not
diff --git a/builtin-push.c b/builtin-push.c
index 8921d53..2911513 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -88,7 +88,6 @@ static void warn_unconfigured_push(void)
 
 static void setup_default_push_refspecs(void)
 {
-	git_config(git_default_config, NULL);
 	switch (push_default) {
 	case PUSH_DEFAULT_UNSPECIFIED:
 		warn_unconfigured_push();
@@ -150,8 +149,13 @@ static int do_push(const char *repo, int flags)
 		if (remote->push_refspec_nr) {
 			refspec = remote->push_refspec;
 			refspec_nr = remote->push_refspec_nr;
-		} else if (!(flags & TRANSPORT_PUSH_MIRROR))
+		} else if (!(flags & TRANSPORT_PUSH_MIRROR)) {
+			push_default = (flags & TRANSPORT_PUSH_CURRENT
+					? PUSH_DEFAULT_CURRENT
+					: PUSH_DEFAULT_UNSPECIFIED);
+			git_config(git_default_config, NULL);
 			setup_default_push_refspecs();
+		}
 	}
 	errs = 0;
 	if (remote->pushurl_nr) {
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 3333ce9..bdc98ec 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -586,7 +586,7 @@ test_expect_success 'push with branches containing #' '
 	git checkout master
 '
 
-test_expect_success 'push --current fails on empty repository' '
+test_expect_success 'push --current succeeds on empty repository' '
 	git init &&
 	mkdir b.git &&
 	(cd b.git && git init --bare) &&
@@ -598,20 +598,14 @@ test_expect_success 'push --current succeeds on empty repository' '
 	git add b &&
 	git commit -m branch &&
 	git checkout master &&
-	! git push --current b.git
-'
-
-test_expect_success 'push --current succeeds when push is configured' '
-	git config remote.bremote.url b.git &&
-	git config remote.bremote.push refs/heads/master:refs/heads/master &&
-	git push --current bremote &&
+	git push --current b.git
 	test `git rev-parse master` = `cd b.git && git rev-parse master`
 '
 
-test_expect_success 'push --current does nothing when current branch does not exist' '
+test_expect_success 'push --current always creates current branch' '
 	git checkout branch &&
-	git push --current b.git 2>&1 | grep "Everything up-to-date" &&
-	git push b.git branch
+	git push --current b.git &&
+	test `git rev-parse branch` = `cd b.git && git rev-parse branch`
 '
 
 test_expect_success 'push --current does not push other branches' '
@@ -633,6 +627,10 @@ test_expect_success 'push --current does update the current branches' '
 '
 
 test_expect_success 'push --current respects configuration' '
+	git config remote.bremote.url b.git &&
+	git config remote.bremote.push refs/heads/master:refs/heads/master2 &&
+	git push --current bremote &&
+	test `git rev-parse master` = `cd b.git && git rev-parse master2`
 	git checkout branch &&
 	git push --current bremote 2>&1 | grep "Everything up-to-date" &&
 	test `git rev-parse branch^` = `cd b.git && git rev-parse branch`
-- 
1.6.2.5
