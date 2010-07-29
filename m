From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 5/5] log: parse detached option for --glob
Date: Thu, 29 Jul 2010 10:20:29 +0200
Message-ID: <1280391629-30017-6-git-send-email-Matthieu.Moy@imag.fr>
References: <1280391629-30017-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 29 10:24:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeOPZ-0005u7-Mj
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 10:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754312Ab0G2IYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 04:24:12 -0400
Received: from imag.imag.fr ([129.88.30.1]:64563 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751052Ab0G2IYL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 04:24:11 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o6T8KbqJ018975
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 29 Jul 2010 10:20:37 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OeOM0-0004OD-VX; Thu, 29 Jul 2010 10:20:37 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OeOM0-0004IP-UL; Thu, 29 Jul 2010 10:20:36 +0200
X-Mailer: git-send-email 1.7.2.21.ge9796
In-Reply-To: <1280391629-30017-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 29 Jul 2010 10:20:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152166>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 revision.c               |    7 +++++--
 t/t6018-rev-list-glob.sh |    6 ++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 7006340..188fa21 100644
--- a/revision.c
+++ b/revision.c
@@ -1484,6 +1484,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 {
 	int i, flags, left, seen_dashdash, read_from_stdin, got_rev_arg = 0;
 	const char **prune_data = NULL;
+	const char *optarg;
+	int argcount;
 
 	/* First, search for "--" */
 	seen_dashdash = 0;
@@ -1530,10 +1532,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
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
 			if (!prefixcmp(arg, "--branches=")) {
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
1.7.2.21.ge9796
