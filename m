From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] submodule: Demonstrate known breakage during recursive
	merge
Date: Wed, 24 Aug 2011 21:14:38 +0200
Message-ID: <20110824191438.GA45292@book.hvoigt.net>
References: <680d2679c3275c01152500760311b5f96a93ea62.1314193375.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 21:14:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwIuU-0005DS-MO
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 21:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809Ab1HXTOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 15:14:42 -0400
Received: from darksea.de ([83.133.111.250]:52840 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753796Ab1HXTOk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 15:14:40 -0400
Received: (qmail 5286 invoked from network); 24 Aug 2011 21:14:38 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 24 Aug 2011 21:14:38 +0200
Content-Disposition: inline
In-Reply-To: <680d2679c3275c01152500760311b5f96a93ea62.1314193375.git.brad.king@kitware.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180027>

Hi,

thanks for finding this subtle bug!

On Wed, Aug 24, 2011 at 09:59:50AM -0400, Brad King wrote:
> Since commit 68d03e4a (Implement automatic fast-forward merge for
> submodules, 2010-07-07) we try to suggest submodule commits that resolve
> a conflict.  Consider a true recursive merge case
> 
>     b---bc
>    / \ /
>   o   X
>    \ / \
>     c---cb

And here is a patch[1] that you can apply on top of yours which should fix
this. An extra pair of merge machinery knowing eyes appreciated. Its a
little bit workaroundish so if anymore has an idea how to fix this in
nicer way, please tell me.

[1]--8<----
From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] protect submodule merge search against multiple calls for
 the same path

When multiple merge-bases are found for two commits to be merged the
merge machinery will ask twice for a merge resolution. Currently its not
possible to use the revision-walking api for walking the same commits
multiple times. Since the result will not change we can simply fail
here if we are asked for a resolution of the same path again.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 submodule.c                |    9 +++++++++
 t/t7405-submodule-merge.sh |    2 +-
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/submodule.c b/submodule.c
index 1ba9646..a4af08e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -646,6 +646,7 @@ int merge_submodule(unsigned char result[20], const char *path,
 		    const unsigned char base[20], const unsigned char a[20],
 		    const unsigned char b[20])
 {
+	static char last_path[PATH_MAX] = {'\0'};
 	struct commit *commit_base, *commit_a, *commit_b;
 	int parent_count;
 	struct object_array merges;
@@ -699,6 +700,13 @@ int merge_submodule(unsigned char result[20], const char *path,
 	 * user needs to confirm the resolution.
 	 */
 
+	/* in case of multiple merge-bases the merge algorithm will ask
+	 * again for a resolution. We should not search twice for the
+	 * same path.
+	 */
+	if (!strcmp(path, last_path))
+		return 0;
+
 	/* find commit which merges them */
 	parent_count = find_first_merges(&merges, path, commit_a, commit_b);
 	switch (parent_count) {
@@ -726,6 +734,7 @@ int merge_submodule(unsigned char result[20], const char *path,
 			print_commit((struct commit *) merges.objects[i].item);
 	}
 
+	memcpy(last_path, path, strlen(path) + 1);
 	free(merges.objects);
 	return 0;
 }
diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
index 8f6f2d6..603fb72 100755
--- a/t/t7405-submodule-merge.sh
+++ b/t/t7405-submodule-merge.sh
@@ -269,7 +269,7 @@ test_expect_success 'setup for recursive merge with submodule' '
 '
 
 # merge should leave submodule unmerged in index
-test_expect_failure 'recursive merge with submodule' '
+test_expect_success 'recursive merge with submodule' '
 	(cd merge-recursive &&
 	 test_must_fail git merge top-bc &&
 	 echo "160000 $(git rev-parse top-cb:sub) 2	sub" > expect2 &&
-- 
1.7.6.551.g4266ca
