From: Max Kirillov <max@max630.net>
Subject: [PATCH v5 3/3] blame: allow blame --reverse --first-parent when it makes sense
Date: Fri, 30 Oct 2015 07:01:53 +0200
Message-ID: <1446181313-15094-4-git-send-email-max@max630.net>
References: <1446181313-15094-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 06:02:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zs1pQ-0004We-79
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 06:02:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673AbbJ3FCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 01:02:09 -0400
Received: from p3plsmtpa07-01.prod.phx3.secureserver.net ([173.201.192.230]:51741
	"EHLO p3plsmtpa07-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752346AbbJ3FCG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Oct 2015 01:02:06 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa07-01.prod.phx3.secureserver.net with 
	id bH1u1r0075B68XE01H25fn; Thu, 29 Oct 2015 22:02:06 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
In-Reply-To: <1446181313-15094-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280479>

Allow combining --reverse and --first-parent if initial commit of
specified range is at the first-parent chain starting from the final
commit. Disable the prepare_revision_walk()'s builtin children
collection, instead picking only the ones which are along the first
parent chain.

Signed-off-by: Max Kirillov <max@max630.net>
---
 builtin/blame.c                   | 32 ++++++++++++++++++++++++++++++--
 t/t8009-blame-vs-topicbranches.sh |  2 +-
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 38f6267..98b1810 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2507,6 +2507,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	long dashdash_pos, lno;
 	char *final_commit_name = NULL;
 	enum object_type type;
+	struct commit *final_commit = NULL;
 
 	static struct string_list range_list;
 	static int output_option = 0, opt = 0;
@@ -2697,11 +2698,11 @@ parse_done:
 	}
 	else if (contents_from)
 		die("--contents and --children do not blend well.");
-	else if (revs.first_parent_only)
-		die("combining --first-parent and --reverse is not supported");
 	else {
 		final_commit_name = prepare_initial(&sb);
 		sb.commits.compare = compare_commits_by_reverse_commit_date;
+		if (revs.first_parent_only)
+			revs.children.name = NULL;
 	}
 
 	if (!sb.final) {
@@ -2718,6 +2719,14 @@ parse_done:
 	else if (contents_from)
 		die("Cannot use --contents with final commit object name");
 
+	if (reverse && revs.first_parent_only) {
+		struct object_array_entry *entry = find_single_final(sb.revs);
+		if (!entry)
+			die("--reverse and --first-parent together require specified latest commit");
+		else
+			final_commit = (struct commit*) entry->item;
+	}
+
 	/*
 	 * If we have bottom, this will mark the ancestors of the
 	 * bottom commits we would reach while traversing as
@@ -2726,6 +2735,25 @@ parse_done:
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
 
+	if (reverse && revs.first_parent_only) {
+		struct commit *c = final_commit;
+
+		sb.revs->children.name = "children";
+		while (c->parents &&
+		       hashcmp(c->object.sha1, sb.final->object.sha1)) {
+			struct commit_list *l = xcalloc(1, sizeof(*l));
+
+			l->item = c;
+			if (add_decoration(&sb.revs->children,
+					   &c->parents->item->object, l))
+				die("BUG: not unique item in first-parent chain");
+			c = c->parents->item;
+		}
+
+		if (hashcmp(c->object.sha1, sb.final->object.sha1))
+			die("--reverse --first-parent together require range along first-parent chain");
+	}
+
 	if (is_null_sha1(sb.final->object.sha1)) {
 		o = sb.final->util;
 		sb.final_buf = xmemdupz(o->file.ptr, o->file.size);
diff --git a/t/t8009-blame-vs-topicbranches.sh b/t/t8009-blame-vs-topicbranches.sh
index 175ad37..72596e3 100755
--- a/t/t8009-blame-vs-topicbranches.sh
+++ b/t/t8009-blame-vs-topicbranches.sh
@@ -26,7 +26,7 @@ test_expect_success setup '
 	test_merge A3 C1
 	'
 
-test_expect_failure 'blame --reverse --first-parent finds A1' '
+test_expect_success 'blame --reverse --first-parent finds A1' '
 	git blame --porcelain --reverse --first-parent A0..A3 -- file.t >actual_full &&
 	head -n 1 <actual_full | sed -e "s/ .*//" >actual &&
 	git rev-parse A1 >expect &&
-- 
2.3.4.2801.g3d0809b
