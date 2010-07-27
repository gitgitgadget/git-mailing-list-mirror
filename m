From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 4/4] Allow detached form for --glob, --branches, --tags and --remote.
Date: Tue, 27 Jul 2010 23:21:59 +0200
Message-ID: <1280265719-30968-5-git-send-email-Matthieu.Moy@imag.fr>
References: <1280265719-30968-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 27 23:22:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odrc1-0002gF-J1
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 23:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804Ab0G0VWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 17:22:51 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42525 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752235Ab0G0VWr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 17:22:47 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o6RLKKdB026604
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 27 Jul 2010 23:20:20 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OdrbA-00026H-6g; Tue, 27 Jul 2010 23:22:04 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OdrbA-00084v-5I; Tue, 27 Jul 2010 23:22:04 +0200
X-Mailer: git-send-email 1.7.2.25.g9ebe3
In-Reply-To: <1280265719-30968-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 27 Jul 2010 23:20:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o6RLKKdB026604
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1280870421.084@KEbtfgh1pzOPzvo2z/b/Nw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152001>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 revision.c               |   31 +++++++++++++++++++++++--------
 t/t6018-rev-list-glob.sh |    6 ++++++
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/revision.c b/revision.c
index 5d62340..93e6233 100644
--- a/revision.c
+++ b/revision.c
@@ -1486,6 +1486,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 {
 	int i, flags, left, seen_dashdash, read_from_stdin, got_rev_arg = 0;
 	const char **prune_data = NULL;
+	const char *optarg;
 
 	/* First, search for "--" */
 	seen_dashdash = 0;
@@ -1501,6 +1502,20 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		break;
 	}
 
+	/*
+	 * Variant of IF_LONG_OPT, for setup_revisions (use argv[i+1]
+	 * instead of argv[1], increment i directly)
+	 */
+#define IF_LONG_OPT_SR(optname)					\
+	((!strcmp(arg, "--" #optname)				\
+	  && (argv[i+1] || (die("Option `" #optname "' requires a value"), 1), \
+	      optarg   = argv[i+1],	       			\
+	      i++,						\
+	      1)) ||						\
+	 (!prefixcmp(arg, "--" #optname "=")			\
+	  && (optarg = arg + strlen("--" #optname "="),		\
+	      1)))
+
 	/* Second, deal with arguments and options */
 	flags = 0;
 	read_from_stdin = 0;
@@ -1532,28 +1547,28 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 				handle_refs(revs, flags, for_each_remote_ref);
 				continue;
 			}
-			if (!prefixcmp(arg, "--glob=")) {
+			if (IF_LONG_OPT_SR(glob)) {
 				struct all_refs_cb cb;
 				init_all_refs_cb(&cb, revs, flags);
-				for_each_glob_ref(handle_one_ref, arg + 7, &cb);
+				for_each_glob_ref(handle_one_ref, optarg, &cb);
 				continue;
 			}
-			if (!prefixcmp(arg, "--branches=")) {
+			if (IF_LONG_OPT_SR(branches)) {
 				struct all_refs_cb cb;
 				init_all_refs_cb(&cb, revs, flags);
-				for_each_glob_ref_in(handle_one_ref, arg + 11, "refs/heads/", &cb);
+				for_each_glob_ref_in(handle_one_ref, optarg, "refs/heads/", &cb);
 				continue;
 			}
-			if (!prefixcmp(arg, "--tags=")) {
+			if (IF_LONG_OPT_SR(tags)) {
 				struct all_refs_cb cb;
 				init_all_refs_cb(&cb, revs, flags);
-				for_each_glob_ref_in(handle_one_ref, arg + 7, "refs/tags/", &cb);
+				for_each_glob_ref_in(handle_one_ref, optarg, "refs/tags/", &cb);
 				continue;
 			}
-			if (!prefixcmp(arg, "--remotes=")) {
+			if (IF_LONG_OPT_SR(remotes)) {
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
