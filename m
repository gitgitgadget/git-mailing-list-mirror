From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] apply --index-info: fall back to current index for mode
 changes
Date: Mon, 17 Sep 2007 01:24:57 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709170119270.28586@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Chris Shoemaker <c.shoemaker@cox.net>, gitster@pobox.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 02:25:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX4Qv-0006we-Ju
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 02:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048AbXIQAZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 20:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754034AbXIQAZp
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 20:25:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:56707 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753442AbXIQAZo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 20:25:44 -0400
Received: (qmail invoked by alias); 17 Sep 2007 00:25:42 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp046) with SMTP; 17 Sep 2007 02:25:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Qq5UknQuQ09aMpq6EavFG67PvqT1tbmvXYqQhN7
	LxeJ1UaeJEMpr/
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58368>


"git diff" does not record index lines for pure mode changes (i.e. no
lines changed).  Therefore, apply --index-info would call out a bogus
error.

Instead, fall back to reading the info from the current index.

Incidentally, this fixes an error where git-rebase would not rebase a 
commit including a pure mode change, and changes requiring a threeway 
merge.

Noticed by Chris Shoemaker.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-apply.c   |   26 ++++++++++++++++++++++++--
 t/t3400-rebase.sh |   15 +++++++++++++++
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 7057d0d..bae4413 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2215,6 +2215,20 @@ static int check_patch_list(struct patch *patch)
 	return err;
 }
 
+/* This function tries to read the sha1 from the current index */
+static int get_current_sha1(const char *path, unsigned char *sha1)
+{
+	int pos;
+
+	if (read_cache() < 0)
+		return -1;
+	pos = cache_name_pos(path, strlen(path));
+	if (pos < 0)
+		return -1;
+	hashcpy(sha1, active_cache[pos]->sha1);
+	return 0;
+}
+
 static void show_index_list(struct patch *list)
 {
 	struct patch *patch;
@@ -2231,8 +2245,16 @@ static void show_index_list(struct patch *list)
 		if (0 < patch->is_new)
 			sha1_ptr = null_sha1;
 		else if (get_sha1(patch->old_sha1_prefix, sha1))
-			die("sha1 information is lacking or useless (%s).",
-			    name);
+			/* git diff has no index line for mode/type changes */
+			if (!patch->lines_added && !patch->lines_deleted) {
+				if (get_current_sha1(patch->new_name, sha1) ||
+				    get_current_sha1(patch->old_name, sha1))
+					die("mode change for %s, which is not "
+						"in current HEAD", name);
+				sha1_ptr = sha1;
+			} else
+				die("sha1 information is lacking or useless "
+					"(%s).", name);
 		else
 			sha1_ptr = sha1;
 
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 62205b2..95e33b5 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -68,4 +68,19 @@ test_expect_success \
      test 3 = $(git rev-list master.. | wc -l)
 '
 
+test_expect_success 'rebase a single mode change' '
+     git checkout master &&
+     echo 1 > X &&
+     git add X &&
+     test_tick &&
+     git commit -m prepare &&
+     git checkout -b modechange HEAD^ &&
+     echo 1 > X &&
+     git add X &&
+     chmod a+x A &&
+     test_tick &&
+     git commit -m modechange A X &&
+     GIT_TRACE=1 git rebase master
+'
+
 test_done
-- 
1.5.3.1.949.g98c3
