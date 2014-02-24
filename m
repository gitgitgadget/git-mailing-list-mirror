From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 04/19] tree-diff: no need to pass match to skip_uninteresting()
Date: Mon, 24 Feb 2014 20:21:36 +0400
Message-ID: <540b87fe7a353e4f2ac798270991038f3bb89c35.1393257006.git.kirr@mns.spb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 17:21:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHyH9-0003IB-EO
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 17:21:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127AbaBXQUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 11:20:54 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:34154 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753089AbaBXQUx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 11:20:53 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WHyGx-0003zn-TN; Mon, 24 Feb 2014 20:20:52 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WHyId-00079c-25; Mon, 24 Feb 2014 20:22:35 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
In-Reply-To: <cover.1393257006.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1393257006.git.kirr@mns.spb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242592>

It is neither used there as input, nor the output written through it, is
used outside.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

( re-posting without change )

 tree-diff.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 5810b00..a8c2aec 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -109,13 +109,14 @@ static void show_entry(struct diff_options *opt, const char *prefix,
 }
 
 static void skip_uninteresting(struct tree_desc *t, struct strbuf *base,
-			       struct diff_options *opt,
-			       enum interesting *match)
+			       struct diff_options *opt)
 {
+	enum interesting match;
+
 	while (t->size) {
-		*match = tree_entry_interesting(&t->entry, base, 0, &opt->pathspec);
-		if (*match) {
-			if (*match == all_entries_not_interesting)
+		match = tree_entry_interesting(&t->entry, base, 0, &opt->pathspec);
+		if (match) {
+			if (match == all_entries_not_interesting)
 				t->size = 0;
 			break;
 		}
@@ -128,8 +129,6 @@ int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
 {
 	struct strbuf base;
 	int baselen = strlen(base_str);
-	enum interesting t1_match = entry_not_interesting;
-	enum interesting t2_match = entry_not_interesting;
 
 	/* Enable recursion indefinitely */
 	opt->pathspec.recursive = DIFF_OPT_TST(opt, RECURSIVE);
@@ -141,8 +140,8 @@ int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
 		if (diff_can_quit_early(opt))
 			break;
 		if (opt->pathspec.nr) {
-			skip_uninteresting(t1, &base, opt, &t1_match);
-			skip_uninteresting(t2, &base, opt, &t2_match);
+			skip_uninteresting(t1, &base, opt);
+			skip_uninteresting(t2, &base, opt);
 		}
 		if (!t1->size) {
 			if (!t2->size)
-- 
1.9.rc1.181.g641f458
