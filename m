From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] fix segfault with git log -c --follow
Date: Tue, 28 May 2013 00:49:57 +0200
Message-ID: <20130527224957.GA7492@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 28 01:22:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uh6ju-0001OO-H2
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 01:22:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758115Ab3E0XWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 19:22:01 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:64305 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756209Ab3E0XWA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 19:22:00 -0400
X-Greylist: delayed 1853 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 May 2013 19:22:00 EDT
Received: from bsmtp.bon.at (unknown [192.168.181.108])
	by lbmfmo03.bon.at (Postfix) with ESMTP id C34E2CDFF6
	for <git@vger.kernel.org>; Tue, 28 May 2013 00:51:05 +0200 (CEST)
Received: from [127.0.0.1] (p5B22D37E.dip0.t-ipconnect.de [91.34.211.126])
	by bsmtp.bon.at (Postfix) with ESMTP id ED0A913004A;
	Tue, 28 May 2013 00:50:46 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225615>

In diff_tree_combined we make a copy of diffopts. In
try_to_follow_renames, called via diff_tree_sha1, we free and
re-initialize diffopts->pathspec->items. Since we did not make a deep
copy of diffopts in diff_tree_combined, the original diffopts does not
get the update. By the time we return from diff_tree_combined,
rev->diffopt->pathspec->items points to an invalid memory address. We
get a segfault next time we try to access that pathspec.

Instead, along with the copy of diffopts, make a copy pathspec->items as
well.

We would also have to make a copy of pathspec->raw to keep it consistent
with pathspec->items, but nobody seems to rely on that.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

I wonder why I get a segfault from this so reliably, since it's not
actually a null-pointer dereference. Maybe this is gcc 4.8 doing
something different from previous versions?

Also, I have absolutely no confidence in my understanding of this code.
This is the first solution that came to mind, and could be totally
wrong. I just figured a patch is better than no patch.

Clemens

 combine-diff.c |  3 +++
 t/t4202-log.sh | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/combine-diff.c b/combine-diff.c
index 77d7872..8825604 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1302,6 +1302,7 @@ void diff_tree_combined(const unsigned char *sha1,
 	int i, num_paths, needsep, show_log_first, num_parent = parents->nr;
 
 	diffopts = *opt;
+	diff_tree_setup_paths(diffopts.pathspec.raw, &diffopts);
 	diffopts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	DIFF_OPT_SET(&diffopts, RECURSIVE);
 	DIFF_OPT_CLR(&diffopts, ALLOW_EXTERNAL);
@@ -1372,6 +1373,8 @@ void diff_tree_combined(const unsigned char *sha1,
 		paths = paths->next;
 		free(tmp);
 	}
+
+	diff_tree_release_paths(&diffopts);
 }
 
 void diff_tree_combined_merge(const struct commit *commit, int dense,
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 9243a97..cb03d28 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -530,6 +530,20 @@ test_expect_success 'show added path under "--follow -M"' '
 	)
 '
 
+test_expect_success 'git log -c --follow' '
+	test_create_repo follow-c &&
+	(
+		cd follow-c &&
+		test_commit initial file original &&
+		git rm file &&
+		test_commit rename file2 original &&
+		git reset --hard initial &&
+		test_commit modify file foo &&
+		git merge -m merge rename &&
+		git log -c --follow file2
+	)
+'
+
 cat >expect <<\EOF
 *   commit COMMIT_OBJECT_NAME
 |\  Merge: MERGE_PARENTS
-- 
1.8.2.3
