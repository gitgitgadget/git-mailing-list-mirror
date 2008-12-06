From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/6] builtin-commit.c: further refactor branch switching
Date: Fri,  5 Dec 2008 17:54:14 -0800
Message-ID: <1228528455-3089-6-git-send-email-gitster@pobox.com>
References: <1228528455-3089-1-git-send-email-gitster@pobox.com>
 <1228528455-3089-2-git-send-email-gitster@pobox.com>
 <1228528455-3089-3-git-send-email-gitster@pobox.com>
 <1228528455-3089-4-git-send-email-gitster@pobox.com>
 <1228528455-3089-5-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 06 02:56:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8mP5-0005m7-A0
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 02:56:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755296AbYLFByk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2008 20:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756042AbYLFByj
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 20:54:39 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61893 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755935AbYLFByc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2008 20:54:32 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 758F9182CB
	for <git@vger.kernel.org>; Fri,  5 Dec 2008 20:54:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CB8FD18321 for
 <git@vger.kernel.org>; Fri,  5 Dec 2008 20:54:31 -0500 (EST)
X-Mailer: git-send-email 1.6.1.rc1.72.ga5ce6
In-Reply-To: <1228528455-3089-5-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D378A538-C338-11DD-B6D8-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102436>

This adds reset_index_and_worktree() to further factor out the logic for
switching the index and the work tree state from one commit to another to
shrink merge_working_tree() function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-checkout.c |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 9c45c49..a08941a 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -433,6 +433,18 @@ static int switch_trees(int merge, int quiet, int *wt_error,
 	return ret;
 }
 
+int reset_index_and_worktree(int force, int merge, int quiet, int *wt_error,
+			     struct commit *old_commit, const char *old_label,
+			     struct commit *new_commit, const char *new_label)
+{
+	if (force)
+		return reset_tree(new_commit->tree, quiet, 1, wt_error);
+	else
+		return switch_trees(merge, quiet, wt_error,
+				    old_commit, old_label,
+				    new_commit, new_label);
+}
+
 struct branch_info {
 	const char *name; /* The short name used */
 	const char *path; /* The full name of a real branch */
@@ -457,14 +469,10 @@ static int merge_working_tree(struct checkout_opts *opts,
 	if (read_cache() < 0)
 		return error("corrupt index file");
 
-	if (opts->force)
-		ret = reset_tree(new->commit->tree, opts->quiet, 1,
-				 &opts->writeout_error);
-	else
-		ret = switch_trees(opts->merge, opts->quiet,
-				   &opts->writeout_error,
-				   old->commit, "local",
-				   new->commit, new->name);
+	ret = reset_index_and_worktree(opts->force, opts->merge, opts->quiet,
+				       &opts->writeout_error,
+				       old->commit, "local",
+				       new->commit, new->name);
 	if (ret)
 		return ret;
 
-- 
1.6.1.rc1.72.ga5ce6
