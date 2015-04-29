From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 12/15] merge: make collect_parents() auto-generate the merge message
Date: Wed, 29 Apr 2015 14:29:30 -0700
Message-ID: <1430342973-30344-13-git-send-email-gitster@pobox.com>
References: <1430025967-24479-1-git-send-email-gitster@pobox.com>
 <1430342973-30344-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 23:30:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnZYa-0006e8-7E
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 23:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbbD2VaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 17:30:07 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58548 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751214AbbD2V3z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 17:29:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D1F54DAD6;
	Wed, 29 Apr 2015 17:29:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=5ZNl
	xDx4ybFbOgSxwdph+iL/tJY=; b=nHW1FIjF7HssJxsX2j+lJxZ9lgKR1k7okgEa
	z58tiPHBwMtmXVcdfTTZychv1WRsgyJ+Dz4AByRIP3eZCHFHXe1lhcawOxy9wlCS
	GneUMIZivuwd6UKzTEQCAB+ORoLyt4vRIx/VZO8XaNFB4yHZO9bUQAd3D1miIVjB
	FeoZ1k0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=TD2wfx
	KL+wHvMOtjCIXSHbDO6ElaASNwPE+1uNn8k8ArI7bUVBweswBvZNU02v213ExShF
	w9yxRhtBFhdSMge4awVPwiBEMlDUa8xGoZQOyLsO/1Q8PfbEri4pEGLXcKaXqaVx
	IkitMOVxOHXM8ekgFwd81vOFCQO4mB0TLlmnU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 85DC94DAD5;
	Wed, 29 Apr 2015 17:29:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C5154DAD4;
	Wed, 29 Apr 2015 17:29:53 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc3-300-g052d062
In-Reply-To: <1430342973-30344-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E02F8F8E-EEB6-11E4-A203-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268022>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index a972ed6..9f98538 100644
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
@@ -1108,7 +1109,20 @@ static struct commit_list *collect_parents(struct commit *head_commit,
 		remotes = &commit_list_insert(commit, remotes)->next;
 	}
 
-	return reduce_parents(head_commit, head_subsumed, remoteheads);
+	remoteheads = reduce_parents(head_commit, head_subsumed, remoteheads);
+
+	if (merge_msg &&
+	    (!have_message || shortlog_len)) {
+		struct strbuf merge_names = STRBUF_INIT;
+		struct commit_list *p;
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
@@ -1222,7 +1236,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		if (fast_forward == FF_NO)
 			die(_("Non-fast-forward commit does not make sense into "
 			    "an empty head"));
-		remoteheads = collect_parents(head_commit, &head_subsumed, argc, argv);
+		remoteheads = collect_parents(head_commit, &head_subsumed,
+					      argc, argv, NULL);
 		remote_head = remoteheads->item;
 		if (!remote_head)
 			die(_("%s - not something we can merge"), argv[0]);
@@ -1248,7 +1263,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		head_arg = argv[1];
 		argv += 2;
 		argc -= 2;
-		remoteheads = collect_parents(head_commit, &head_subsumed, argc, argv);
+		remoteheads = collect_parents(head_commit, &head_subsumed,
+					      argc, argv, NULL);
 	} else {
 		/* We are invoked directly as the first-class UI. */
 		head_arg = "HEAD";
@@ -1258,16 +1274,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
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
2.4.0-rc3-300-g052d062
