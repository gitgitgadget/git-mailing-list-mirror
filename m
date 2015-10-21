From: Max Kirillov <max@max630.net>
Subject: [PATCH 2/2] blame: allow blame --reverse --first-parent when it makes sense
Date: Wed, 21 Oct 2015 07:08:02 +0300
Message-ID: <1445400482-1977-3-git-send-email-max@max630.net>
References: <1445400482-1977-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 21 06:16:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zokp6-0006Js-VU
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 06:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbbJUEPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 00:15:54 -0400
Received: from p3plsmtpa11-01.prod.phx3.secureserver.net ([68.178.252.102]:60924
	"EHLO p3plsmtpa11-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750698AbbJUEPZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Oct 2015 00:15:25 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Oct 2015 00:15:23 EDT
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa11-01.prod.phx3.secureserver.net with 
	id Xg861r0045B68XE01g8GiK; Tue, 20 Oct 2015 21:08:17 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
In-Reply-To: <1445400482-1977-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279964>

Do not die immediately when the two flags are specified. Instead
check that the specified range is along first-parent chain.  Explioit
how prepare_revision_walk() handles first_parent_only flag: the commits
outside of first-parent chain are either unknown (and do not have any
children recorded) or appear as non-first parent of a commit along the
first-parent chain.

Since the check seems fragile, add test which makes sure that blame dies
in both cases.

Signed-off-by: Max Kirillov <max@max630.net>
---
 builtin/blame.c          | 11 +++++++++--
 t/t8009-blame-reverse.sh |  7 ++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 295ce92..27de544 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2692,8 +2692,6 @@ parse_done:
 	}
 	else if (contents_from)
 		die("--contents and --children do not blend well.");
-	else if (revs.first_parent_only)
-		die("combining --first-parent and --reverse is not supported");
 	else {
 		final_commit_name = prepare_initial(&sb);
 		sb.commits.compare = compare_commits_by_reverse_commit_date;
@@ -2721,6 +2719,15 @@ parse_done:
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
 
+	if (reverse && revs.first_parent_only) {
+		struct commit_list *final_children = lookup_decoration(&revs.children,
+								       &sb.final->object);
+		if (!final_children ||
+		    hashcmp(final_children->item->parents->item->object.sha1,
+			    sb.final->object.sha1))
+		    die("--reverse --first-parent together require range along first-parent chain");
+	}
+
 	if (is_null_sha1(sb.final->object.sha1)) {
 		o = sb.final->util;
 		sb.final_buf = xmemdupz(o->file.ptr, o->file.size);
diff --git a/t/t8009-blame-reverse.sh b/t/t8009-blame-reverse.sh
index 9f40613..042863b 100755
--- a/t/t8009-blame-reverse.sh
+++ b/t/t8009-blame-reverse.sh
@@ -24,11 +24,16 @@ test_expect_failure 'blame --reverse finds B1, not C1' '
 	test_cmp expect actual
 	'
 
-test_expect_failure 'blame --reverse --first-parent finds A1' '
+test_expect_success 'blame --reverse --first-parent finds A1' '
 	git blame --porcelain --reverse --first-parent A0..A3 -- file.t >actual_full &&
 	head -1 <actual_full | sed -e "sX .*XX" >actual &&
 	git rev-parse A1 >expect &&
 	test_cmp expect actual
 	'
 
+test_expect_success 'blame --reverse --first-parse dies if no first parent chain' '
+	test_must_fail git blame --porcelain --reverse --first-parent B1..A3 -- file.t &&
+	test_must_fail git blame --porcelain --reverse --first-parent B2..A3 -- file.t
+	'
+
 test_done
-- 
2.3.4.2801.g3d0809b
