From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/2] Fix ranges with git-show
Date: Tue, 19 Jun 2012 22:04:58 +0200
Message-ID: <a598bb8c20221679e295caa743197c86219eda68.1340136145.git.trast@student.ethz.ch>
References: <d3e839101b031a7208e74a0b6e22d343d5a093e9.1340136145.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 19 22:05:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh4ft-0005pv-RG
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 22:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867Ab2FSUFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 16:05:05 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:2643 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753902Ab2FSUFE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 16:05:04 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Jun
 2012 22:05:00 +0200
Received: from thomas.inf.ethz.ch (129.132.211.105) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Jun
 2012 22:05:00 +0200
X-Mailer: git-send-email 1.7.11.266.g2b10bc0
In-Reply-To: <d3e839101b031a7208e74a0b6e22d343d5a093e9.1340136145.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.211.105]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200237>

As explained in the previous commit, git-show's DWIM walking mode
fails with ranges where propagating the UNINTERESTING marks is needed
for correctness.

To fix this issue, use a new strategy for of dealing with commits:
handle everything else first, then pass all commits to a single
revision walker "in bulk".  This keeps the UNINTERESTING commits and
correctly shows all ranges.

Sadly we can use this only when actually walking.  In other cases,
such as 'git show A B', it would seem more important to keep the order
of the objects shown consistent with the command line.  There are no
such guarantees when running the walker with several commits (even in
no-walk mode), so we still feed them one by one.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 builtin/log.c   | 16 ++++++++++++----
 t/t7007-show.sh |  2 +-
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 4f1b42a..26f6c01 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -444,6 +444,7 @@ static void show_rev_tweak_rev(struct rev_info *rev, struct setup_revision_opt *
 int cmd_show(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
+	struct object_array commits = {0};
 	struct object_array_entry *objects;
 	struct setup_revision_opt opt;
 	struct pathspec match_all;
@@ -505,15 +506,22 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 			rev.shown_one = 1;
 			break;
 		case OBJ_COMMIT:
-			rev.pending.nr = rev.pending.alloc = 0;
-			rev.pending.objects = NULL;
-			add_object_array(o, name, &rev.pending);
-			ret = cmd_log_walk(&rev);
+			add_object_array(o, name, &commits);
+			if (rev.no_walk) {
+				rev.pending = commits;
+				ret = cmd_log_walk(&rev);
+				commits.nr = commits.alloc = 0;
+				commits.objects = NULL;
+			}
 			break;
 		default:
 			ret = error(_("Unknown type: %d"), o->type);
 		}
 	}
+	if (!ret && commits.nr) {
+		rev.pending = commits;
+		ret = cmd_log_walk(&rev);
+	}
 	free(objects);
 	return ret;
 }
diff --git a/t/t7007-show.sh b/t/t7007-show.sh
index 1c43963..3936ff7 100755
--- a/t/t7007-show.sh
+++ b/t/t7007-show.sh
@@ -57,7 +57,7 @@ EOF
 	test_cmp expect actual.filtered
 '
 
-test_expect_failure 'showing a range walks (Y shape, ^ last)' '
+test_expect_success 'showing a range walks (Y shape, ^ last)' '
 	cat >expect <<EOF &&
 commit $(git rev-parse main3)
 commit $(git rev-parse main2)
-- 
1.7.11.266.g2b10bc0
