From: Trevor Saunders <tbsaunde@tbsaunde.org>
Subject: [PATCH] bisect: stop printing raw diff of first bad commit
Date: Thu, 28 May 2015 12:16:13 -0400
Message-ID: <1432829773-4754-1-git-send-email-tbsaunde@tbsaunde.org>
Cc: Trevor Saunders <tbsaunde@tbsaunde.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 28 23:26:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy5Jj-0002av-R5
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 23:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755180AbbE1V0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 17:26:15 -0400
Received: from tbsaunde.org ([66.228.47.254]:41443 "EHLO
	paperclip.tbsaunde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754566AbbE1V0O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 17:26:14 -0400
Received: from iceball.corp.tor1.mozilla.com (unknown [66.207.208.102])
	by paperclip.tbsaunde.org (Postfix) with ESMTPSA id 84DDDC07C;
	Thu, 28 May 2015 21:26:13 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270201>

Signed-off-by: Trevor Saunders <tbsaunde@tbsaunde.org>
---
The test change only kind of tests the change in behavior and doesn't seem all
that useful.  However I'm not sure if its preferable to not even try and test
that something isn't output.

 bisect.c                    | 7 ++-----
 t/t6030-bisect-porcelain.sh | 3 ++-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/bisect.c b/bisect.c
index 10f5e57..244f9e5 100644
--- a/bisect.c
+++ b/bisect.c
@@ -875,16 +875,13 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
 	init_revisions(&opt, prefix);
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	opt.abbrev = 0;
-	opt.diff = 1;
+	opt.diff = 0;
 
 	/* This is what "--pretty" does */
 	opt.verbose_header = 1;
 	opt.use_terminator = 0;
 	opt.commit_format = CMIT_FMT_DEFAULT;
-
-	/* diff-tree init */
-	if (!opt.diffopt.output_format)
-		opt.diffopt.output_format = DIFF_FORMAT_RAW;
+	opt.always_show_header = 1;
 
 	log_tree_commit(&opt, commit);
 }
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 06b4868..eb820b2 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -591,7 +591,8 @@ test_expect_success 'test bisection on bare repo - --no-checkout defaulted' '
 			"test \$(git rev-list BISECT_HEAD ^$HASH2 --max-count=1 | wc -l) = 0" \
 			>../defaulted.log
 	) &&
-	grep "$HASH3 is the first bad commit" defaulted.log
+	grep "$HASH3 is the first bad commit" defaulted.log &&
+	test 0 -eq $(grep -c '^:' defaulted.log)
 '
 
 #
-- 
2.4.0
