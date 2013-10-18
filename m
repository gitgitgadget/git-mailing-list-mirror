From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v4 1/2] checkout: allow dwim for branch creation for "git checkout $branch --"
Date: Fri, 18 Oct 2013 11:25:57 +0200
Message-ID: <1382088358-2213-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: pclouds@gmail.com, jc@sahnwaldt.de, jrnieder@gmail.com,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Oct 18 11:26:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VX6K9-000712-W1
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 11:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385Ab3JRJ0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 05:26:19 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53733 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752252Ab3JRJ0S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 05:26:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r9I9Q1Rp027525
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 18 Oct 2013 11:26:03 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VX6Jm-0002uo-UR; Fri, 18 Oct 2013 11:26:02 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VX6Jm-0000aZ-IF; Fri, 18 Oct 2013 11:26:02 +0200
X-Mailer: git-send-email 1.8.4.479.g0ed768e
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 18 Oct 2013 11:26:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r9I9Q1Rp027525
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1382693165.17974@WyBThVIzhZkXQSoP71zSRA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236338>

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
> So it may be even cleaner to read if you did it this way:

Indeed. The code reads better now.

 builtin/checkout.c       | 78 ++++++++++++++++++++++++++++++++++--------------
 t/t2024-checkout-dwim.sh | 21 +++++++++++++
 2 files changed, 76 insertions(+), 23 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0f57397..2003795 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -885,20 +885,30 @@ static int parse_branchname_arg(int argc, const char **argv,
 	 *
 	 *   everything after the '--' must be paths.
 	 *
-	 * case 3: git checkout <something> [<paths>]
+	 * case 3: git checkout <something> [--]
 	 *
-	 *   With no paths, if <something> is a commit, that is to
-	 *   switch to the branch or detach HEAD at it.  As a special case,
-	 *   if <something> is A...B (missing A or B means HEAD but you can
-	 *   omit at most one side), and if there is a unique merge base
-	 *   between A and B, A...B names that merge base.
+	 *   (a) If <something> is a commit, that is to
+	 *       switch to the branch or detach HEAD at it.  As a special case,
+	 *       if <something> is A...B (missing A or B means HEAD but you can
+	 *       omit at most one side), and if there is a unique merge base
+	 *       between A and B, A...B names that merge base.
 	 *
-	 *   With no paths, if <something> is _not_ a commit, no -t nor -b
-	 *   was given, and there is a tracking branch whose name is
-	 *   <something> in one and only one remote, then this is a short-hand
-	 *   to fork local <something> from that remote-tracking branch.
+	 *   (b) If <something> is _not_ a commit, either "--" is present
+	 *       or <something> is not a path, no -t nor -b was given, and
+	 *       and there is a tracking branch whose name is <something>
+	 *       in one and only one remote, then this is a short-hand to
+	 *       fork local <something> from that remote-tracking branch.
 	 *
-	 *   Otherwise <something> shall not be ambiguous.
+	 *   (c) Otherwise, if "--" is present, treat it like case (1).
+	 *
+	 *   (d) Otherwise :
+	 *       - if it's a reference, treat it like case (1)
+	 *       - else if it's a path, treat it like case (2)
+	 *       - else: fail.
+	 *
+	 * case 4: git checkout <something> <paths>
+	 *
+	 *   The first argument must not be ambiguous.
 	 *   - If it's *only* a reference, treat it like case (1).
 	 *   - If it's only a path, treat it like case (2).
 	 *   - else: fail.
@@ -917,18 +927,40 @@ static int parse_branchname_arg(int argc, const char **argv,
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
+		 *
+		 * It's likely an error, but we need to find out if
+		 * we should auto-create the branch, case (3).(b).
+		 */
+		int recover_with_dwim = dwim_new_local_branch_ok;
+
+		if (check_filename(NULL, arg) && !has_dash_dash)
+			recover_with_dwim = 0;
+		/*
+		 * Accept "git checkout foo" and "git checkout foo --"
+		 * as candidates for dwim.
+		 */
+		if (!(argc == 1 && !has_dash_dash) &&
+		    !(argc == 2 && has_dash_dash))
+			recover_with_dwim = 0;
+
+		if (recover_with_dwim) {
 			const char *remote = unique_tracking_name(arg, rev);
-			if (!remote)
-				return argcount;
-			*new_branch = arg;
-			arg = remote;
-			/* DWIMmed to create local branch */
-		} else {
+			if (remote) {
+				*new_branch = arg;
+				arg = remote;
+				/* DWIMmed to create local branch, case (3).(b) */
+			} else {
+				recover_with_dwim = 0;
+			}
+		}
+
+		if (!recover_with_dwim) {
+			if (has_dash_dash)
+				die(_("invalid reference: %s"), arg);
 			return argcount;
 		}
 	}
@@ -958,7 +990,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 
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
1.8.4.479.g0ed768e
