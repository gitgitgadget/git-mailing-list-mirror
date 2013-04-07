From: Aaron Schrab <aaron@schrab.com>
Subject: [PATCH 2/2] clone: Allow repo using gitfile as a reference
Date: Sun,  7 Apr 2013 19:17:09 -0400
Message-ID: <1365376629-16054-2-git-send-email-aaron@schrab.com>
References: <1365376629-16054-1-git-send-email-aaron@schrab.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 08:49:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5qQ-0000sy-0u
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934485Ab3DGXXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 19:23:24 -0400
Received: from pug.qqx.org ([50.116.43.67]:33188 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934473Ab3DGXXX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 19:23:23 -0400
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Apr 2013 19:23:23 EDT
Received: from frak.qqx.org (frak.qqx.org [IPv6:2001:470:8:86c:21f:3bff:feaa:6c05])
	by pug.qqx.org (Postfix) with ESMTPSA id BA5021D3EC
	for <git@vger.kernel.org>; Sun,  7 Apr 2013 19:17:16 -0400 (EDT)
Received: from ats (uid 1000)
	(envelope-from aaron@schrab.com)
	id 456a4
	by frak.qqx.org (DragonFly Mail Agent);
	Sun, 07 Apr 2013 19:17:15 -0400
X-Mailer: git-send-email 1.8.2.677.g7422c62
In-Reply-To: <1365376629-16054-1-git-send-email-aaron@schrab.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220396>

Try reading gitfile files when processing --reference options to clone.
This will allow, among other things, using a submodule checked out with
a recent version of git as a reference repository without requiring the
user to have internal knowledge of submodule layout.

Signed-off-by: Aaron Schrab <aaron@schrab.com>
---
 builtin/clone.c            | 13 ++++++++++---
 t/t5700-clone-reference.sh |  7 +++++++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 0a1e0bf..376ded8 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -231,12 +231,19 @@ static void strip_trailing_slashes(char *dir)
 
 static int add_one_reference(struct string_list_item *item, void *cb_data)
 {
-	char *ref_git;
+	char *ref_git, *repo;
 	struct strbuf alternate = STRBUF_INIT;
 
-	/* Beware: real_path() and mkpath() return static buffer */
+	/* Beware: read_gitfile(), real_path() and mkpath() return static buffer */
 	ref_git = xstrdup(real_path(item->string));
-	if (is_directory(mkpath("%s/.git/objects", ref_git))) {
+
+	repo = (char *)read_gitfile(mkpath("%s/.git", ref_git));
+	if (repo) {
+		free(ref_git);
+		ref_git = xstrdup(repo);
+	}
+
+	if (!repo && is_directory(mkpath("%s/.git/objects", ref_git))) {
 		char *ref_git_git = mkpathdup("%s/.git", ref_git);
 		free(ref_git);
 		ref_git = ref_git_git;
diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index 2a7b78b..7a9044c 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -185,4 +185,11 @@ test_expect_success 'fetch with incomplete alternates' '
 	! grep " want $tag_object" "$U.K"
 '
 
+test_expect_success 'clone using repo with gitfile as a reference' '
+	git clone --separate-git-dir=L A M &&
+	git clone --reference=M A N &&
+	echo "$base_dir/L/objects" > expected &&
+	test_cmp expected "$base_dir/N/.git/objects/info/alternates"
+'
+
 test_done
-- 
1.8.2.677.g7422c62
