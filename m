From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v3 1/2] checkout: allow dwim for branch creation for "git checkout $branch --"
Date: Thu, 26 Sep 2013 11:08:05 +0200
Message-ID: <1380186486-8220-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: pclouds@gmail.com, jc@sahnwaldt.de, jrnieder@gmail.com,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 26 11:08:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VP7Yh-0004zx-N4
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 11:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755530Ab3IZJIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 05:08:23 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50759 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753313Ab3IZJIW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 05:08:22 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r8Q98Ao5000972
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 26 Sep 2013 11:08:10 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VP7YR-0001xI-NV; Thu, 26 Sep 2013 11:08:11 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VP7YR-00029c-CS; Thu, 26 Sep 2013 11:08:11 +0200
X-Mailer: git-send-email 1.8.4.474.g128a96c
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 26 Sep 2013 11:08:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8Q98Ao5000972
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1380791291.916@S/LHmcpI73XFsCIWTGS2EQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235409>

The "--" notation disambiguates files and branches, but as a side-effect
of the previous implementation, also disabled the branch auto-creation
when $branch does not exist.

A possible scenario is then:

git checkout $branch
=> fails if $branch is both a ref and a file, and suggests --

git checkout $branch --
=> refuses to create the $branch

This patch allows the second form to create $branch, and since the -- is
provided, it does not look for file named $branch.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Since v2: essentially Jonathan's comments.

 builtin/checkout.c       | 70 ++++++++++++++++++++++++++++++++++--------------
 t/t2024-checkout-dwim.sh | 21 +++++++++++++++
 2 files changed, 71 insertions(+), 20 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0f57397..9edd9c3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -863,6 +863,13 @@ static const char *unique_tracking_name(const char *name, unsigned char *sha1)
 	return NULL;
 }
 
+static int error_invalid_ref(const char *arg, int has_dash_dash, int argcount)
+{
+	if (has_dash_dash)
+		die(_("invalid reference: %s"), arg);
+	return argcount;
+}
+
 static int parse_branchname_arg(int argc, const char **argv,
 				int dwim_new_local_branch_ok,
 				struct branch_info *new,
@@ -885,20 +892,30 @@ static int parse_branchname_arg(int argc, const char **argv,
 	 *
 	 *   everything after the '--' must be paths.
 	 *
-	 * case 3: git checkout <something> [<paths>]
+	 * case 3: git checkout <something> [--]
+	 *
+	 *   (a) If <something> is a commit, that is to
+	 *       switch to the branch or detach HEAD at it.  As a special case,
+	 *       if <something> is A...B (missing A or B means HEAD but you can
+	 *       omit at most one side), and if there is a unique merge base
+	 *       between A and B, A...B names that merge base.
+	 *
+	 *   (b) If <something> is _not_ a commit, either "--" is present
+	 *       or <something> is not a path, no -t nor -b was given, and
+	 *       and there is a tracking branch whose name is <something>
+	 *       in one and only one remote, then this is a short-hand to
+	 *       fork local <something> from that remote-tracking branch.
+	 *
+	 *   (c) Otherwise, if "--" is present, treat it like case (1).
 	 *
-	 *   With no paths, if <something> is a commit, that is to
-	 *   switch to the branch or detach HEAD at it.  As a special case,
-	 *   if <something> is A...B (missing A or B means HEAD but you can
-	 *   omit at most one side), and if there is a unique merge base
-	 *   between A and B, A...B names that merge base.
+	 *   (d) Otherwise :
+	 *       - if it's a reference, treat it like case (1)
+	 *       - else if it's a path, treat it like case (2)
+	 *       - else: fail.
 	 *
-	 *   With no paths, if <something> is _not_ a commit, no -t nor -b
-	 *   was given, and there is a tracking branch whose name is
-	 *   <something> in one and only one remote, then this is a short-hand
-	 *   to fork local <something> from that remote-tracking branch.
+	 * case 4: git checkout <something> <paths>
 	 *
-	 *   Otherwise <something> shall not be ambiguous.
+	 *   The first argument must not be ambiguous.
 	 *   - If it's *only* a reference, treat it like case (1).
 	 *   - If it's only a path, treat it like case (2).
 	 *   - else: fail.
@@ -917,19 +934,32 @@ static int parse_branchname_arg(int argc, const char **argv,
 		arg = "@{-1}";
 
 	if (get_sha1_mb(arg, rev)) {
-		if (has_dash_dash)          /* case (1) */
-			die(_("invalid reference: %s"), arg);
-		if (dwim_new_local_branch_ok &&
-		    !check_filename(NULL, arg) &&
-		    argc == 1) {
+		/*
+		 * Either case (3) or (4), with <something> not being
+		 * a commit, or an attempt to use case (1) with an
+		 * invalid ref.
+		 */
+		int try_dwim = dwim_new_local_branch_ok;
+
+		if (check_filename(NULL, arg) && !has_dash_dash)
+			try_dwim = 0;
+		/*
+		 * Accept "git checkout foo" and "git checkout foo --"
+		 * as candidates for dwim.
+		 */
+		if (!(argc == 1 && !has_dash_dash) &&
+		    !(argc == 2 && has_dash_dash))
+			try_dwim = 0;
+
+		if (try_dwim) {
 			const char *remote = unique_tracking_name(arg, rev);
 			if (!remote)
-				return argcount;
+				return error_invalid_ref(arg, has_dash_dash, argcount);
 			*new_branch = arg;
 			arg = remote;
-			/* DWIMmed to create local branch */
+			/* DWIMmed to create local branch, case (3).(b) */
 		} else {
-			return argcount;
+			return error_invalid_ref(arg, has_dash_dash, argcount);
 		}
 	}
 
@@ -958,7 +988,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 
 	if (!*source_tree)                   /* case (1): want a tree */
 		die(_("reference is not a tree: %s"), arg);
-	if (!has_dash_dash) {/* case (3 -> 1) */
+	if (!has_dash_dash) {/* case (3).(d) -> (1) */
 		/*
 		 * Do not complain the most common case
 		 *	git checkout branch
diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index 094b92e..6ecb559 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -164,4 +164,25 @@ test_expect_success 'checkout of branch from a single remote succeeds #4' '
 	test_branch_upstream eggs repo_d eggs
 '
 
+test_expect_success 'checkout of branch with a file having the same name fails' '
+	git checkout -B master &&
+	test_might_fail git branch -D spam &&
+
+	>spam &&
+	test_must_fail git checkout spam &&
+	test_must_fail git rev-parse --verify refs/heads/spam &&
+	test_branch master
+'
+
+test_expect_success 'checkout <branch> -- succeeds, even if a file with the same name exists' '
+	git checkout -B master &&
+	test_might_fail git branch -D spam &&
+
+	>spam &&
+	git checkout spam -- &&
+	test_branch spam &&
+	test_cmp_rev refs/remotes/extra_dir/repo_c/extra_dir/spam HEAD &&
+	test_branch_upstream spam repo_c spam
+'
+
 test_done
-- 
1.8.4.474.g128a96c
