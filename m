From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 08/14] merge: split reduce_parents() out of collect_parents()
Date: Sat, 25 Apr 2015 22:26:01 -0700
Message-ID: <1430025967-24479-9-git-send-email-gitster@pobox.com>
References: <xmqqiocqli1c.fsf@gitster.dls.corp.google.com>
 <1430025967-24479-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 26 07:26:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmF5M-0002kU-7k
	for gcvg-git-2@plane.gmane.org; Sun, 26 Apr 2015 07:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbbDZF02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2015 01:26:28 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60894 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751076AbbDZF0U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2015 01:26:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E895466F8;
	Sun, 26 Apr 2015 01:26:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Tc9F
	pODdRhPcXUUUSKP7V7c9hXU=; b=MNIS9L8t5uY4ozMUedBgcZ8MZrVkvsDpuCgF
	w/2kdkBYq/eM3odC9a+u4EOb/CsbKWjaxMy7U9sgHA+t5bm5Nv2Po/2k1EP7cstQ
	VcTEeHS9kxtqSx1/virIoza0inKMqAPOHMSJ9C1Db95BYLdHFG4vVk13mgKudDHP
	SgzrkuU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=YU+OI5
	OtwqnhzR9IDa8c4i+PluAY65l0/ciHcHTGVECPN0L0K5/fG/z+3911OjGFboUYUt
	KfwT9/xDNIg5SF5lEJXxDJfoM4CmnMRH8E8kqJh9/nSItOQ2ZcrkY9VHWDUhosVV
	IfQUA53qmC5NbhQEauzH8Ad7EJjXvJdP5F/vw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2641C466F7;
	Sun, 26 Apr 2015 01:26:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9F051466F6;
	Sun, 26 Apr 2015 01:26:19 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc3-238-g36f5934
In-Reply-To: <1430025967-24479-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C4E113F4-EBD4-11E4-8F27-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267808>

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
2.4.0-rc3-238-g36f5934
