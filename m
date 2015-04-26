From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 12/14] merge: decide if we auto-generate the message early in collect_parents()
Date: Sat, 25 Apr 2015 22:26:05 -0700
Message-ID: <1430025967-24479-13-git-send-email-gitster@pobox.com>
References: <xmqqiocqli1c.fsf@gitster.dls.corp.google.com>
 <1430025967-24479-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 26 07:26:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmF5U-0002kU-Sh
	for gcvg-git-2@plane.gmane.org; Sun, 26 Apr 2015 07:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbbDZF0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2015 01:26:35 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50336 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751004AbbDZF00 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2015 01:26:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D5F9746709;
	Sun, 26 Apr 2015 01:26:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=GQk+
	4PL/4aduFIKvafxXMzzEM9o=; b=c1fcC/IgaYEoC8ONBLHKNRwzwY3UiMmMSSp4
	GrtCZOSZLdxse2V64PX666EaVHS676VnQMwfDxGwioNCc0PaUjkB/0jYl9dah1NN
	ahOjmQf4hmxW9Sb7DONQQrLsZe/GnzqGd8KuEqb7RJxbmZFOnJuf8GOH5y4TCuzt
	6cNgoUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=ff023i
	aavyxDhqe2M9QpnBHf0erAgvrG2ErM+tOgPwqxUfIjWewX1al92b29lVi2gz8FeT
	ngyMnkPZtgBYva40LSsxQh8dy+qvkK2yI5zWmbfionWBMzro1XjdtNEk+pw9qZPs
	yYfVyz5Nbgk1Le+65QZzjZgFe7OU1cg5UOn3M=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CA26B46708;
	Sun, 26 Apr 2015 01:26:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4E91F46704;
	Sun, 26 Apr 2015 01:26:25 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc3-238-g36f5934
In-Reply-To: <1430025967-24479-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C8423D0C-EBD4-11E4-B9AA-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267819>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 84ebb22..c7d9d6e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1098,6 +1098,10 @@ static struct commit_list *collect_parents(struct commit *head_commit,
 	int i;
 	struct commit_list *remoteheads = NULL;
 	struct commit_list **remotes = &remoteheads;
+	struct strbuf merge_names = STRBUF_INIT, *autogen = NULL;
+
+	if (merge_msg && (!have_message || shortlog_len))
+		autogen = &merge_names;
 
 	if (head_commit)
 		remotes = &commit_list_insert(head_commit, remotes)->next;
@@ -1111,14 +1115,12 @@ static struct commit_list *collect_parents(struct commit *head_commit,
 
 	remoteheads = reduce_parents(head_commit, head_subsumed, remoteheads);
 
-	if (merge_msg &&
-	    (!have_message || shortlog_len)) {
-		struct strbuf merge_names = STRBUF_INIT;
-
+	if (autogen) {
 		for (p = remoteheads; p; p = p->next)
-			merge_name(merge_remote_util(p->item)->name, &merge_names);
-		prepare_merge_message(&merge_names, merge_msg);
-		strbuf_release(&merge_names);
+			merge_name(merge_remote_util(p->item)->name, autogen);
+
+		prepare_merge_message(autogen, merge_msg);
+		strbuf_release(autogen);
 	}
 
 	return remoteheads;
-- 
2.4.0-rc3-238-g36f5934
