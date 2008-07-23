From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] git-checkout: fix argument parsing to detect ambiguous arguments.
Date: Wed, 23 Jul 2008 03:02:20 +0200
Message-ID: <1216774940-4955-1-git-send-email-madcoder@debian.org>
Cc: gitster@pobox.com, Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 03:03:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLSlI-0000VP-Bi
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 03:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753104AbYGWBCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 21:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753149AbYGWBCY
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 21:02:24 -0400
Received: from pan.madism.org ([88.191.52.104]:51660 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753100AbYGWBCX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 21:02:23 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 1E8F63A396;
	Wed, 23 Jul 2008 03:02:21 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id D0D09C45B; Wed, 23 Jul 2008 03:02:20 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.153.ge8bf3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89585>

Note that it also fix a bug, git checkout -- <path> would be badly
understood as git checkout <branch> if <path> is ambiguous with a branch.

Testcases included.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

  A user on #git happened to have issues that made me realize that
  builtin-checkout is badly broken wrt argument parseing.

  This clearly needs to be applied to master, probably to maint too.

  The patch is against next though, but should probably apply to other
  branches just fine.


 builtin-checkout.c            |    9 +++++++--
 t/t2010-checkout-ambiguous.sh |   27 +++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 2 deletions(-)
 create mode 100755 t/t2010-checkout-ambiguous.sh

diff --git a/builtin-checkout.c b/builtin-checkout.c
index fbd5105..1490e8e 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -438,9 +438,14 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 	opts.track = git_branch_track;
 
-	argc = parse_options(argc, argv, options, checkout_usage, 0);
-	if (argc) {
+	argc = parse_options(argc, argv, options, checkout_usage,
+			     PARSE_OPT_KEEP_DASHDASH);
+
+	if (argc && strcmp(argv[0], "--")) {
 		arg = argv[0];
+
+		if (argc == 1 || strcmp(argv[1], "--"))
+			verify_non_filename(NULL, arg);
 		if (get_sha1(arg, rev))
 			;
 		else if ((new.commit = lookup_commit_reference_gently(rev, 1))) {
diff --git a/t/t2010-checkout-ambiguous.sh b/t/t2010-checkout-ambiguous.sh
new file mode 100755
index 0000000..c1a86a2
--- /dev/null
+++ b/t/t2010-checkout-ambiguous.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+test_description='checkout and pathspecs/refspecs ambiguities'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo hello >world &&
+	git add world &&
+	git commit -m initial &&
+	git branch world
+'
+
+test_expect_success 'branch switching' '
+	git checkout world --
+'
+
+test_expect_success 'checkout world from the index' '
+	git checkout -- world
+'
+
+test_expect_success 'ambiguous call' '
+	test_must_fail git checkout world
+'
+
+test_done
-- 
1.6.0.rc0.154.g60644
