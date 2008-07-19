From: Olivier Marin <dkr+ml.git@free.fr>
Subject: [PATCH V2] builtin-rm: fix index lock file path
Date: Sat, 19 Jul 2008 18:24:46 +0200
Message-ID: <4882154E.5050806@free.fr>
References: <20080719082314.GA15419@mail.local.tull.net> <48821485.6050507@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nick Andrew <nick@nick-andrew.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Sat Jul 19 18:25:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKFFj-0000Cs-GQ
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 18:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753560AbYGSQYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 12:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753538AbYGSQYs
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 12:24:48 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:59546 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753536AbYGSQYs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 12:24:48 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id E6C2B12B6C1;
	Sat, 19 Jul 2008 18:24:46 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 9208B12B6DE;
	Sat, 19 Jul 2008 18:24:46 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <48821485.6050507@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89112>

From: Olivier Marin <dkr@freesurf.fr>

When hold_locked_index() is called with a relative git_dir and you are
outside the work tree, the lock file become relative to the current
directory. So when later setup_work_tree() change the current directory
it breaks lock file path and commit_locked_index() fails.

This patch move index locking code after setup_work_tree() call to make
lock file relative to the working tree as it should be and add a test
case.

Noticed by Nick Andrew.

Signed-off-by: Olivier Marin <dkr@freesurf.fr>
---

 The same with the test case!

 builtin-rm.c  |   10 +++++-----
 t/t3600-rm.sh |   12 ++++++++++++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/builtin-rm.c b/builtin-rm.c
index 56454ec..ee8247b 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -146,11 +146,6 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
-	newfd = hold_locked_index(&lock_file, 1);
-
-	if (read_cache() < 0)
-		die("index file corrupt");
-
 	argc = parse_options(argc, argv, builtin_rm_options, builtin_rm_usage, 0);
 	if (!argc)
 		usage_with_options(builtin_rm_usage, builtin_rm_options);
@@ -158,6 +153,11 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	if (!index_only)
 		setup_work_tree();
 
+	newfd = hold_locked_index(&lock_file, 1);
+
+	if (read_cache() < 0)
+		die("index file corrupt");
+
 	pathspec = get_pathspec(prefix, argv);
 	seen = NULL;
 	for (i = 0; pathspec[i] ; i++)
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 316775e..79c06ad 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -217,4 +217,16 @@ test_expect_success 'Remove nonexistent file returns nonzero exit status' '
 	test_must_fail git rm nonexistent
 '
 
+test_expect_success 'Call "rm" from outside the work tree' '
+	mkdir repo &&
+	cd repo &&
+	git init &&
+	echo something > somefile &&
+	git add somefile &&
+	git commit -m "add a file" &&
+	(cd .. &&
+	 git --git-dir=repo/.git --work-tree=repo rm somefile) &&
+	test_must_fail git ls-files --error-unmatch somefile
+'
+
 test_done
-- 
1.5.6.3.440.g489d7
