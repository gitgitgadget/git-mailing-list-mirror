From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] Revert "builtin-archive: use RUN_SETUP"
Date: Thu, 05 Apr 2007 22:55:43 +0200
Message-ID: <4615624F.50504@lsrfire.ath.cx>
References: <4614DD0C.50600@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 05 22:56:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZZ01-0006Jl-Dq
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 22:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767307AbXDEU4B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 16:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767304AbXDEU4B
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 16:56:01 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:47981
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1767222AbXDEU4A (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Apr 2007 16:56:00 -0400
Received: from [10.0.1.201] (p508E5FD3.dip.t-dialin.net [80.142.95.211])
	by neapel230.server4you.de (Postfix) with ESMTP id 9CCB43D00D;
	Thu,  5 Apr 2007 22:55:58 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <4614DD0C.50600@garzik.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43855>

Commit 64edf4b2 cleaned up the initialization of git-archive,
at the cost of 'git-archive --list' now requiring a git repo.
This patch reverts the cleanup and documents the requirement
for this particular dirtyness in a test.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---

Jeff Garzik schrieb:
> "git-archive --list" requires a git repository.  Certainly listing the
> archive formats doesn't /really/ require such things.

 builtin-archive.c   |    2 ++
 git.c               |    2 +-
 t/t5000-tar-tree.sh |    4 ++++
 3 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/builtin-archive.c b/builtin-archive.c
index 2fae885..8ea6cb1 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -252,6 +252,8 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 
 	memset(&ar, 0, sizeof(ar));
 	tree_idx = parse_archive_args(argc, argv, &ar);
+	if (prefix == NULL)
+		prefix = setup_git_directory();
 
 	argv += tree_idx;
 	parse_treeish_arg(argv, &ar.args, prefix);
diff --git a/git.c b/git.c
index 5b1bc2a..33dd4d3 100644
--- a/git.c
+++ b/git.c
@@ -226,7 +226,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "add", cmd_add, RUN_SETUP | NOT_BARE },
 		{ "annotate", cmd_annotate, USE_PAGER },
 		{ "apply", cmd_apply },
-		{ "archive", cmd_archive, RUN_SETUP },
+		{ "archive", cmd_archive },
 		{ "blame", cmd_blame, RUN_SETUP },
 		{ "branch", cmd_branch, RUN_SETUP },
 		{ "bundle", cmd_bundle },
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index ac835fe..b4359df 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -130,4 +130,8 @@ test_expect_success \
     'validate file contents with prefix' \
     'diff -r a e/prefix/a'
 
+test_expect_success \
+    'git-archive --list outside of a git repo' \
+    'GIT_DIR=some/non-existing/directory git-archive --list'
+
 test_done
