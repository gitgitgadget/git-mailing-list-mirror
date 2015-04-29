From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 13/15] merge: decide if we auto-generate the message early in collect_parents()
Date: Wed, 29 Apr 2015 14:29:31 -0700
Message-ID: <1430342973-30344-14-git-send-email-gitster@pobox.com>
References: <1430025967-24479-1-git-send-email-gitster@pobox.com>
 <1430342973-30344-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 23:30:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnZYb-0006e8-5y
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 23:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbbD2VaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 17:30:09 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58274 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751215AbbD2V34 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 17:29:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F120F4DADC;
	Wed, 29 Apr 2015 17:29:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Nfkn
	Xu+7BxYNltSQn/HOO8gFRNo=; b=mieoeCbyLGy003YTPpk2myo9waxOVUByCPGG
	8JqBwpTBO5yRCJc4b9QXdKVbVGHH2bZpB41BdIoRYSp3+XioRvfDlfUA1CPF0k6B
	+37xGAu0k6iH2GIuuoYHTnkBlUkn8Wzu1KwPCJ5ZDS/MGiZqocOQSXmLeOnLkMmG
	/8LNOGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=VhZ+EZ
	RlenMrSKLv3kFU7Zx3TfNIk8RmLbNoMv0JR0j8/I1r8QGtz/K5Lb4/I6CkTz7aKL
	i2j83Y4CkQHDqEUhQrZEeJ2Tgu8gCQ3om9+o+hll6GUXJGfHvC464cA8Sc1abmuu
	uqaV7WaFgnYvZPRad3q5wnQqiVK+BIk5BVFjs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EAA454DADB;
	Wed, 29 Apr 2015 17:29:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 707774DAD9;
	Wed, 29 Apr 2015 17:29:55 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc3-300-g052d062
In-Reply-To: <1430342973-30344-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E106D6CE-EEB6-11E4-A47F-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268020>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 9f98538..eb3be68 100644
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
@@ -1111,15 +1115,13 @@ static struct commit_list *collect_parents(struct commit *head_commit,
 
 	remoteheads = reduce_parents(head_commit, head_subsumed, remoteheads);
 
-	if (merge_msg &&
-	    (!have_message || shortlog_len)) {
-		struct strbuf merge_names = STRBUF_INIT;
+	if (autogen) {
 		struct commit_list *p;
-
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
2.4.0-rc3-300-g052d062
