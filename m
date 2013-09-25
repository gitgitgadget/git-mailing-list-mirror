From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC/PATCH] checkout: allow dwim for branch creation for "git checkout $branch --"
Date: Wed, 25 Sep 2013 14:49:09 +0200
Message-ID: <1380113349-19838-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: pclouds@gmail.com, jc@sahnwaldt.de,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 25 14:49:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOoWv-00055V-B6
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 14:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755159Ab3IYMtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 08:49:17 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55999 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754752Ab3IYMtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 08:49:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r8PCnBOK023403
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 25 Sep 2013 14:49:11 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VOoWm-0007OY-L1; Wed, 25 Sep 2013 14:49:12 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VOoWm-0005Am-91; Wed, 25 Sep 2013 14:49:12 +0200
X-Mailer: git-send-email 1.8.4.475.g703937e.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 25 Sep 2013 14:49:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8PCnBOK023403
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1380718152.36274@ykL4jGk1U6p7yXM/2YeEZg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235342>

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
 builtin/checkout.c       | 32 ++++++++++++++++++++++++--------
 t/t2024-checkout-dwim.sh | 22 ++++++++++++++++++++++
 2 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0f57397..f1f5915 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -863,6 +863,14 @@ static const char *unique_tracking_name(const char *name, unsigned char *sha1)
 	return NULL;
 }
 
+static int error_invalid_ref(const char *arg, int has_dash_dash, int argcount)
+{
+	if (has_dash_dash)
+		die(_("invalid reference: %s"), arg);
+	else
+		return argcount;
+}
+
 static int parse_branchname_arg(int argc, const char **argv,
 				int dwim_new_local_branch_ok,
 				struct branch_info *new,
@@ -916,20 +924,28 @@ static int parse_branchname_arg(int argc, const char **argv,
 	if (!strcmp(arg, "-"))
 		arg = "@{-1}";
 
-	if (get_sha1_mb(arg, rev)) {
-		if (has_dash_dash)          /* case (1) */
-			die(_("invalid reference: %s"), arg);
-		if (dwim_new_local_branch_ok &&
-		    !check_filename(NULL, arg) &&
-		    argc == 1) {
+	if (get_sha1_mb(arg, rev)) { /* case (1)? */
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
 			/* DWIMmed to create local branch */
 		} else {
-			return argcount;
+			return error_invalid_ref(arg, has_dash_dash, argcount);
 		}
 	}
 
diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index 094b92e..d9afdb2 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -164,4 +164,26 @@ test_expect_success 'checkout of branch from a single remote succeeds #4' '
 	test_branch_upstream eggs repo_d eggs
 '
 
+test_expect_success 'checkout of branch with a file having the same name fails' '
+	git checkout -B master &&
+	test_might_fail git branch -D spam &&
+
+	>spam &&
+	test_must_fail git checkout spam &&
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
1.8.4.475.g703937e.dirty
