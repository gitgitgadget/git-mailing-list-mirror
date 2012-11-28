From: Jeff King <peff@peff.net>
Subject: [PATCH] fsck: warn about '.' and '..' in trees
Date: Tue, 27 Nov 2012 21:27:37 -0500
Message-ID: <20121128022736.GA3739@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 03:27:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdXNS-0003UZ-AX
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 03:27:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053Ab2K1C1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 21:27:39 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58875 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750776Ab2K1C1j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 21:27:39 -0500
Received: (qmail 691 invoked by uid 107); 28 Nov 2012 02:28:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Nov 2012 21:28:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Nov 2012 21:27:37 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210675>

A tree with meta-paths like '.' or '..' does not work well
with git; the index will refuse to load it or check it out
to the filesystem (and even if we did not have that safety,
it would look like we were overwriting an untracked
directory). For the same reason, it is difficult to create
such a tree with regular git.

Let's warn about these dubious entries during fsck, just in
case somebody has created a bogus tree (and this also lets
us prevent them from propagating when transfer.fsckObjects
is set).

Signed-off-by: Jeff King <peff@peff.net>
---
I don't think this is happening in the wild, but I did see somebody
playing around with libgit2 make such a tree (and it is easy to do with
git-mktree, of course).

Technically one could use git with such a tree as long as you never ever
checked out the result, but I think it is sufficiently crazy that we
should probably detect it, just in case.

Should we also detect ".git" in the same way? It is similarly treated
specially by verify_path(), and its presence is likely to cause weird
errors.

 fsck.c          | 10 ++++++++++
 t/t1450-fsck.sh | 16 ++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/fsck.c b/fsck.c
index 7395ef6..31c9a51 100644
--- a/fsck.c
+++ b/fsck.c
@@ -142,6 +142,8 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
 	int has_null_sha1 = 0;
 	int has_full_path = 0;
 	int has_empty_name = 0;
+	int has_dot = 0;
+	int has_dotdot = 0;
 	int has_zero_pad = 0;
 	int has_bad_modes = 0;
 	int has_dup_entries = 0;
@@ -168,6 +170,10 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
 			has_full_path = 1;
 		if (!*name)
 			has_empty_name = 1;
+		if (!strcmp(name, "."))
+			has_dot = 1;
+		if (!strcmp(name, ".."))
+			has_dotdot = 1;
 		has_zero_pad |= *(char *)desc.buffer == '0';
 		update_tree_entry(&desc);
 
@@ -217,6 +223,10 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
 		retval += error_func(&item->object, FSCK_WARN, "contains full pathnames");
 	if (has_empty_name)
 		retval += error_func(&item->object, FSCK_WARN, "contains empty pathname");
+	if (has_dot)
+		retval += error_func(&item->object, FSCK_WARN, "contains '.'");
+	if (has_dotdot)
+		retval += error_func(&item->object, FSCK_WARN, "contains '..'");
 	if (has_zero_pad)
 		retval += error_func(&item->object, FSCK_WARN, "contains zero-padded file modes");
 	if (has_bad_modes)
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 08aa24c..0b5c30b 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -237,4 +237,20 @@ test_expect_success 'fsck notices submodule entry pointing to null sha1' '
 	)
 '
 
+test_expect_success 'fsck notices "." and ".." in trees' '
+	(
+		git init dots &&
+		cd dots &&
+		blob=$(echo foo | git hash-object -w --stdin) &&
+		tab=$(printf "\\t") &&
+		git mktree <<-EOF &&
+		100644 blob $blob$tab.
+		100644 blob $blob$tab..
+		EOF
+		git fsck 2>out &&
+		cat out &&
+		grep "warning.*\\." out
+	)
+'
+
 test_done
-- 
1.8.0.207.gdf2154c
