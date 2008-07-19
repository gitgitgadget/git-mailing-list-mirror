From: Olivier Marin <dkr+ml.git@free.fr>
Subject: [PATCH] builtin-rm: fix index lock file path
Date: Sat, 19 Jul 2008 18:21:25 +0200
Message-ID: <48821485.6050507@free.fr>
References: <20080719082314.GA15419@mail.local.tull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nick Andrew <nick@nick-andrew.net>
X-From: git-owner@vger.kernel.org Sat Jul 19 18:22:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKFCV-0007eF-Kc
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 18:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493AbYGSQV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 12:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753293AbYGSQV2
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 12:21:28 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:39998 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753137AbYGSQV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 12:21:28 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 8D33612B706;
	Sat, 19 Jul 2008 18:21:26 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 3F17D12B702;
	Sat, 19 Jul 2008 18:21:25 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <20080719082314.GA15419@mail.local.tull.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89111>

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
 builtin-rm.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

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
-- 
1.5.6.3.440.g489d7
