From: Ray Zhang <zhanglei002@gmail.com>
Subject: [PATCH] add option -n (--no-checkout) to git-worktree add
Date: Wed, 23 Mar 2016 15:08:59 +0000
Message-ID: <01020153a40588f3-5401ea3e-ece8-435c-a046-a5c1c1f92cd6-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 23 16:27:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aikgg-0006IB-Nd
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 16:27:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755981AbcCWP1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 11:27:06 -0400
Received: from a6-246.smtp-out.eu-west-1.amazonses.com ([54.240.6.246]:55445
	"EHLO a6-246.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755721AbcCWP1E (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 11:27:04 -0400
X-Greylist: delayed 1082 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Mar 2016 11:27:04 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1458745739;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=YGnkBJiK81zjUqlsA+xIId5Ovh+Ng00kG/JreTJELyw=;
	b=D41Y2/cHmHD8susJ2n4bIxXP/77rUq9fk+6Gmo+cXnvEbq5081Wqk2IdjDHgV92V
	WrD5EetugGeAbeA49Gn9Dh046BY24aAivKlTQoGpOo2EIQWjS3zagN5VPtFcyPeIuq/
	JS8ODMC9TQhwQuO5Rkpb8zyfAq+JPlRXsOWo38OI=
X-SES-Outgoing: 2016.03.23-54.240.6.246
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289659>

By adding option -n, we can make some customizations before checkout, like sparse checkout, etc.

Signed-off-by: Ray Zhang <zhanglei002@gmail.com>
---
 builtin/worktree.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 38b5609..14ca3d9 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -21,6 +21,7 @@ static const char * const worktree_usage[] = {
 struct add_opts {
 	int force;
 	int detach;
+	int no_checkout;
 	const char *new_branch;
 	int force_new_branch;
 };
@@ -284,11 +285,13 @@ static int add_worktree(const char *path, const char *refname,
 	if (ret)
 		goto done;
 
-	cp.argv = NULL;
-	argv_array_clear(&cp.args);
-	argv_array_pushl(&cp.args, "reset", "--hard", NULL);
-	cp.env = child_env.argv;
-	ret = run_command(&cp);
+	if (!opts->no_checkout) {
+		cp.argv = NULL;
+		argv_array_clear(&cp.args);
+		argv_array_pushl(&cp.args, "reset", "--hard", NULL);
+		cp.env = child_env.argv;
+		ret = run_command(&cp);
+	}
 	if (!ret) {
 		is_junk = 0;
 		free(junk_work_tree);
@@ -320,6 +323,7 @@ static int add(int ac, const char **av, const char *prefix)
 		OPT_STRING('B', NULL, &new_branch_force, N_("branch"),
 			   N_("create or reset a branch")),
 		OPT_BOOL(0, "detach", &opts.detach, N_("detach HEAD at named commit")),
+		OPT_BOOL('n', "no-checkout", &opts.no_checkout, N_("don't create a checkout")),
 		OPT_END()
 	};
 

--
https://github.com/git/git/pull/217
