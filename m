From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH] make commit --interactive lock index
Date: Thu, 29 May 2008 10:09:21 +0200
Message-ID: <E1K1eXH-00063c-Bt@fencepost.gnu.org>
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 29 11:37:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1eZl-0005xe-Rm
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 11:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbYE2Jgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 05:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752049AbYE2Jgt
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 05:36:49 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:45953 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbYE2Jgs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 05:36:48 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1K1eXH-00063c-Bt
	for git@vger.kernel.org; Thu, 29 May 2008 05:35:03 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83187>

I noticed that the way "git commit --interactive" sets up the commit
is different from the way a normal "git commit" does it.  Commit
2888605c changed one, but not the other.  This makes the behavior
equivalent in the two cases.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 builtin-commit.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

	I am sending this patch for review as I don't know if it's
	necessary.  The code is a tad cleaner, but it does cause more
	system calls in the commit --interactive case, because of the
	additional read of the index.

	The assert tests that, in the interactive case, we'll go down to
	the COMMIT_ASIS case.

	The patch is on top of the previous change I sent for signal
	handling in git-commit.

diff --git a/builtin-commit.c b/builtin-commit.c
index ef8b1f0..5a5f9a3 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -219,13 +219,8 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 	struct path_list partial;
 	const char **pathspec = NULL;
 
-	if (interactive) {
+	if (interactive)
 		interactive_add(argc, argv, prefix);
-		if (read_cache() < 0)
-			die("index file corrupt");
-		commit_style = COMMIT_AS_IS;
-		return get_index_file();
-	}
 
 	if (read_cache() < 0)
 		die("index file corrupt");
@@ -233,6 +228,8 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 	if (*argv)
 		pathspec = get_pathspec(prefix, argv);
 
+	assert (!(interactive && pathspec && *pathspec));
+
 	signal (SIGINT, rollback_on_signal);
 	signal (SIGHUP, rollback_on_signal);
 	signal (SIGTERM, rollback_on_signal);
-- 
1.5.5
