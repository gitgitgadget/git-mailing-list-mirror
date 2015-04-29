From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/15] merge: split reduce_parents() out of collect_parents()
Date: Wed, 29 Apr 2015 14:29:27 -0700
Message-ID: <1430342973-30344-10-git-send-email-gitster@pobox.com>
References: <1430025967-24479-1-git-send-email-gitster@pobox.com>
 <1430342973-30344-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 23:30:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnZYS-0006XY-6A
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 23:30:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbbD2VaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 17:30:01 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64500 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751168AbbD2V3v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 17:29:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 70B874DAC2;
	Wed, 29 Apr 2015 17:29:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=iSfL
	8TmU8jNUBlRyXa4L1zsOyY8=; b=jXuVbO8llk329F5o20dbwlGlv85/g5JlKbrO
	9o3FThjkplBx/e3G5IgTL+QaiVkgNYIRT4pEavWauukqLk20CPsH7Tn9GsWFimEw
	5rQoMYn9X1V4KZDhxi3+GUYc4ticQlU2/JPNJkS415Q5BxgDnYorMUAeB/tEyn17
	Rh+oxVk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=XUXYpL
	36PhfmthDJw6vWcxbwTwPLyMsY5ielzd+TIyva+uQv4BKylXvDGJRWPKSm8ZirXf
	/hFS3E4+aTF+ewRPZWTKoDYplMbxhs9Jxq0eX/xyQi2Ixwi7NYFJ3U5Bzqzv0+qn
	qpcleMuY+/loCrKq+LYL2nPdrEGYz4nuxe1Ik=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 692D74DAC1;
	Wed, 29 Apr 2015 17:29:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DF1624DABF;
	Wed, 29 Apr 2015 17:29:49 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc3-300-g052d062
In-Reply-To: <1430342973-30344-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: DDB82DCE-EEB6-11E4-9F25-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268018>

The latter does two separate things:

 - Parse the list of commits on the command line, and formulate the
   list of commits to be merged (including the current HEAD);

 - Compute the list of parents to be recorded in the resulting merge
   commit.

Split the latter into a separate helper function, so that we can
later supply the list commits to be merged from a different source
(namely, FETCH_HEAD).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index d2e36e2..054f052 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1044,23 +1044,11 @@ static int default_edit_option(void)
 		st_stdin.st_mode == st_stdout.st_mode);
 }
 
-static struct commit_list *collect_parents(struct commit *head_commit,
-					   int *head_subsumed,
-					   int argc, const char **argv)
+static struct commit_list *reduce_parents(struct commit *head_commit,
+					  int *head_subsumed,
+					  struct commit_list *remoteheads)
 {
-	int i;
-	struct commit_list *remoteheads = NULL, *parents, *next;
-	struct commit_list **remotes = &remoteheads;
-
-	if (head_commit)
-		remotes = &commit_list_insert(head_commit, remotes)->next;
-	for (i = 0; i < argc; i++) {
-		struct commit *commit = get_merge_parent(argv[i]);
-		if (!commit)
-			help_unknown_ref(argv[i], "merge",
-					 "not something we can merge");
-		remotes = &commit_list_insert(commit, remotes)->next;
-	}
+	struct commit_list *parents, *next, **remotes = &remoteheads;
 
 	/*
 	 * Is the current HEAD reachable from another commit being
@@ -1088,6 +1076,27 @@ static struct commit_list *collect_parents(struct commit *head_commit,
 	return remoteheads;
 }
 
+static struct commit_list *collect_parents(struct commit *head_commit,
+					   int *head_subsumed,
+					   int argc, const char **argv)
+{
+	int i;
+	struct commit_list *remoteheads = NULL;
+	struct commit_list **remotes = &remoteheads;
+
+	if (head_commit)
+		remotes = &commit_list_insert(head_commit, remotes)->next;
+	for (i = 0; i < argc; i++) {
+		struct commit *commit = get_merge_parent(argv[i]);
+		if (!commit)
+			help_unknown_ref(argv[i], "merge",
+					 "not something we can merge");
+		remotes = &commit_list_insert(commit, remotes)->next;
+	}
+
+	return reduce_parents(head_commit, head_subsumed, remoteheads);
+}
+
 int cmd_merge(int argc, const char **argv, const char *prefix)
 {
 	unsigned char result_tree[20];
-- 
2.4.0-rc3-300-g052d062
