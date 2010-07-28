From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 4/4 v2] Allow detached form for --glob, --branches, --tags and --remote.
Date: Wed, 28 Jul 2010 11:41:02 +0200
Message-ID: <1280310062-16793-4-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqr5ioukca.fsf@bauges.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 28 11:52:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe3JO-0003MO-4Y
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 11:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754564Ab0G1JwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 05:52:25 -0400
Received: from imag.imag.fr ([129.88.30.1]:57931 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752934Ab0G1JwY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 05:52:24 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o6S9f6XP019850
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Jul 2010 11:41:07 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oe38M-0000KY-NQ; Wed, 28 Jul 2010 11:41:06 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oe38M-0004Na-MK; Wed, 28 Jul 2010 11:41:06 +0200
X-Mailer: git-send-email 1.7.2.25.g9ebe3
In-Reply-To: <vpqr5ioukca.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 28 Jul 2010 11:41:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152067>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 revision.c               |   22 ++++++++++++++--------
 t/t6018-rev-list-glob.sh |    6 ++++++
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/revision.c b/revision.c
index 92035a3..33fa0b5 100644
--- a/revision.c
+++ b/revision.c
@@ -1486,6 +1486,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 {
 	int i, flags, left, seen_dashdash, read_from_stdin, got_rev_arg = 0;
 	const char **prune_data = NULL;
+	const char *optarg;
+	int argcount;
 
 	/* First, search for "--" */
 	seen_dashdash = 0;
@@ -1532,28 +1534,32 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 				handle_refs(revs, flags, for_each_remote_ref);
 				continue;
 			}
-			if (!prefixcmp(arg, "--glob=")) {
+			if ((argcount = diff_long_opt("glob", argv + i, &optarg))) {
+				i += argcount - 1;
 				struct all_refs_cb cb;
 				init_all_refs_cb(&cb, revs, flags);
-				for_each_glob_ref(handle_one_ref, arg + 7, &cb);
+				for_each_glob_ref(handle_one_ref, optarg, &cb);
 				continue;
 			}
-			if (!prefixcmp(arg, "--branches=")) {
+			if ((argcount = diff_long_opt("branches", argv + i, &optarg))) {
+				i += argcount - 1;
 				struct all_refs_cb cb;
 				init_all_refs_cb(&cb, revs, flags);
-				for_each_glob_ref_in(handle_one_ref, arg + 11, "refs/heads/", &cb);
+				for_each_glob_ref_in(handle_one_ref, optarg, "refs/heads/", &cb);
 				continue;
 			}
-			if (!prefixcmp(arg, "--tags=")) {
+			if ((argcount = diff_long_opt("tags", argv + i, &optarg))) {
+				i += argcount - 1;
 				struct all_refs_cb cb;
 				init_all_refs_cb(&cb, revs, flags);
-				for_each_glob_ref_in(handle_one_ref, arg + 7, "refs/tags/", &cb);
+				for_each_glob_ref_in(handle_one_ref, optarg, "refs/tags/", &cb);
 				continue;
 			}
-			if (!prefixcmp(arg, "--remotes=")) {
+			if ((argcount = diff_long_opt("remotes", argv + i, &optarg))) {
+				i += argcount - 1;
 				struct all_refs_cb cb;
 				init_all_refs_cb(&cb, revs, flags);
-				for_each_glob_ref_in(handle_one_ref, arg + 10, "refs/remotes/", &cb);
+				for_each_glob_ref_in(handle_one_ref, optarg, "refs/remotes/", &cb);
 				continue;
 			}
 			if (!strcmp(arg, "--reflog")) {
diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
index 58428d9..fb8291c 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -123,6 +123,12 @@ test_expect_success 'rev-list --glob=refs/heads/subspace/*' '
 
 '
 
+test_expect_success 'rev-list --glob refs/heads/subspace/*' '
+
+	compare rev-list "subspace/one subspace/two" "--glob refs/heads/subspace/*"
+
+'
+
 test_expect_success 'rev-list --glob=heads/subspace/*' '
 
 	compare rev-list "subspace/one subspace/two" "--glob=heads/subspace/*"
-- 
1.7.2.25.g9ebe3
