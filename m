From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 11/14] merge: make collect_parents() auto-generate the merge message
Date: Sat, 25 Apr 2015 22:26:04 -0700
Message-ID: <1430025967-24479-12-git-send-email-gitster@pobox.com>
References: <xmqqiocqli1c.fsf@gitster.dls.corp.google.com>
 <1430025967-24479-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 26 07:26:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmF5U-0002kU-91
	for gcvg-git-2@plane.gmane.org; Sun, 26 Apr 2015 07:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbbDZF0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2015 01:26:34 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55932 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751077AbbDZF0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2015 01:26:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B25E46703;
	Sun, 26 Apr 2015 01:26:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=YHuH
	PtuU/l965eZKYqfCZtnPRJg=; b=Gi+AIMS63L3xuCST2zJzjRuP5F+9kDcJtFSG
	RzL4wjARCxJHVcBQSNHc80mrcRNMFxzrMFJVeg3n7u26j1vHklrQkHQHtOh9a6dN
	6rrybpfXUkpmwBuK7B8+ncqJOl11bhI0C6ebhq3z9aFNwV1chVzbEpDnbqd+65bF
	skLYJQU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=vjPD4Z
	9BGPxzIUrP4MldouupTfVgSj4vYCIDOJNxFby7BwVsQ14s8SLyIZ54gtVLJDOd9n
	ofBvNGsnRFqCobfcEtfjoQVBCZ/OeEUvBpLyzxvU9XNvLqWosW3moR2XGRvACv1t
	7L9wqg3DwZrGcIl5YRUPZx3bbFn1hzIZwYcS0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6431F46702;
	Sun, 26 Apr 2015 01:26:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DEDE746701;
	Sun, 26 Apr 2015 01:26:23 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc3-238-g36f5934
In-Reply-To: <1430025967-24479-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C76B164C-EBD4-11E4-9C54-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267817>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index a972ed6..84ebb22 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1092,7 +1092,8 @@ static void prepare_merge_message(struct strbuf *merge_names, struct strbuf *mer
 
 static struct commit_list *collect_parents(struct commit *head_commit,
 					   int *head_subsumed,
-					   int argc, const char **argv)
+					   int argc, const char **argv,
+					   struct strbuf *merge_msg)
 {
 	int i;
 	struct commit_list *remoteheads = NULL;
@@ -1108,7 +1109,19 @@ static struct commit_list *collect_parents(struct commit *head_commit,
 		remotes = &commit_list_insert(commit, remotes)->next;
 	}
 
-	return reduce_parents(head_commit, head_subsumed, remoteheads);
+	remoteheads = reduce_parents(head_commit, head_subsumed, remoteheads);
+
+	if (merge_msg &&
+	    (!have_message || shortlog_len)) {
+		struct strbuf merge_names = STRBUF_INIT;
+
+		for (p = remoteheads; p; p = p->next)
+			merge_name(merge_remote_util(p->item)->name, &merge_names);
+		prepare_merge_message(&merge_names, merge_msg);
+		strbuf_release(&merge_names);
+	}
+
+	return remoteheads;
 }
 
 int cmd_merge(int argc, const char **argv, const char *prefix)
@@ -1222,7 +1235,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		if (fast_forward == FF_NO)
 			die(_("Non-fast-forward commit does not make sense into "
 			    "an empty head"));
-		remoteheads = collect_parents(head_commit, &head_subsumed, argc, argv);
+		remoteheads = collect_parents(head_commit, &head_subsumed,
+					      argc, argv, NULL);
 		remote_head = remoteheads->item;
 		if (!remote_head)
 			die(_("%s - not something we can merge"), argv[0]);
@@ -1248,7 +1262,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		head_arg = argv[1];
 		argv += 2;
 		argc -= 2;
-		remoteheads = collect_parents(head_commit, &head_subsumed, argc, argv);
+		remoteheads = collect_parents(head_commit, &head_subsumed,
+					      argc, argv, NULL);
 	} else {
 		/* We are invoked directly as the first-class UI. */
 		head_arg = "HEAD";
@@ -1258,16 +1273,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 * the standard merge summary message to be appended
 		 * to the given message.
 		 */
-		remoteheads = collect_parents(head_commit, &head_subsumed, argc, argv);
-
-		if (!have_message || shortlog_len) {
-			struct strbuf merge_names = STRBUF_INIT;
-
-			for (p = remoteheads; p; p = p->next)
-				merge_name(merge_remote_util(p->item)->name, &merge_names);
-			prepare_merge_message(&merge_names, &merge_msg);
-			strbuf_release(&merge_names);
-		}
+		remoteheads = collect_parents(head_commit, &head_subsumed,
+					      argc, argv, &merge_msg);
 	}
 
 	if (!head_commit || !argc)
-- 
2.4.0-rc3-238-g36f5934
