From: Aaron Schrab <aaron@schrab.com>
Subject: [PATCH 2/2] clone: Allow repo using gitfile as a reference
Date: Mon,  8 Apr 2013 18:46:40 -0400
Message-ID: <1365461200-13509-3-git-send-email-aaron@schrab.com>
References: <20130408185957.GM27178@pug.qqx.org>
 <1365461200-13509-1-git-send-email-aaron@schrab.com>
Cc: gitster@pobox.com, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 09 00:47:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPKqG-0007QA-F1
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 00:47:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936366Ab3DHWrH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 18:47:07 -0400
Received: from pug.qqx.org ([50.116.43.67]:36538 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935227Ab3DHWrG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 18:47:06 -0400
Received: from zim.qqx.org (cpe-107-015-024-243.nc.res.rr.com [107.15.24.243])
	by pug.qqx.org (Postfix) with ESMTPSA id E1E5E57E03
	for <git@vger.kernel.org>; Mon,  8 Apr 2013 18:47:05 -0400 (EDT)
Received: from ats (uid 1000)
	(envelope-from aaron@schrab.com)
	id 4032b
	by zim.qqx.org (DragonFly Mail Agent);
	Mon, 08 Apr 2013 18:47:05 -0400
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1365461200-13509-1-git-send-email-aaron@schrab.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220537>

Try reading gitfile files when processing --reference options to clone.
This will allow, among other things, using a submodule checked out with
a recent version of git as a reference repository without requiring the
user to have internal knowledge of submodule layout.

Signed-off-by: Aaron Schrab <aaron@schrab.com>
---
 builtin/clone.c            |   12 ++++++++++--
 t/t5700-clone-reference.sh |    7 +++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 0a1e0bf..0dc0791 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -232,11 +232,19 @@ static void strip_trailing_slashes(char *dir)
 static int add_one_reference(struct string_list_item *item, void *cb_data)
 {
 	char *ref_git;
+	const char *repo;
 	struct strbuf alternate = STRBUF_INIT;
 
-	/* Beware: real_path() and mkpath() return static buffer */
+	/* Beware: read_gitfile(), real_path() and mkpath() return static buffer */
 	ref_git = xstrdup(real_path(item->string));
-	if (is_directory(mkpath("%s/.git/objects", ref_git))) {
+
+	repo = read_gitfile(mkpath("%s/.git", ref_git));
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
1.7.10.4
