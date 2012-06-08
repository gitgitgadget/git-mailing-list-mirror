From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] revision: note the lack of free() in simplify_merges()
Date: Fri,  8 Jun 2012 15:53:28 -0700
Message-ID: <1339196009-14555-3-git-send-email-gitster@pobox.com>
References: <1339196009-14555-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 00:54:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd850-0000ut-BM
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jun 2012 00:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759928Ab2FHWyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 18:54:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51363 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754869Ab2FHWxf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 18:53:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D0F78B95
	for <git@vger.kernel.org>; Fri,  8 Jun 2012 18:53:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Fvl6
	LwRb3r5gYHQspyMF8SrOrn4=; b=TfHtUMccpMGFXkkWEZlugOlvOloyEm0u3Blr
	PN00dc9+83fY3Yw81iurTTSqHbgpn+X/JwHi5DxtjZyqNLH6HJkqoKyzFtp7ed0y
	xPe4/ORv6NbgBfKTouvtjHRcdR3CqxUjPXdM7xoKzwipRIg4D5hceHWkpaDyTTUu
	z0JfLWc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=QQZNu+
	Lo/Qtc2tGx7HAGwLEs/ld3jN/R4T+VjTLmsUlVYMd5YJnLLNjc64hK2NOm48Nwl8
	QOQDOE81uK/uA8GL1NfbXKf5MAUFtEZcoFa7AQe0w6diPCN91bPoWzmpLWZbOqZE
	1ewqahQkedDq/Le1u/8/maxfadzCQfnrLItV0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 345868B93
	for <git@vger.kernel.org>; Fri,  8 Jun 2012 18:53:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B909F8B91 for
 <git@vger.kernel.org>; Fri,  8 Jun 2012 18:53:34 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc2.29.g85b30f3
In-Reply-To: <1339196009-14555-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C6F42CF8-B1BC-11E1-9700-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199540>

Among the three similar-looking loops that walk singly linked
commit_list, the first one is only peeking and the same list is
later used for real work.  Leave a comment not to mistakenly
free its elements there.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/revision.c b/revision.c
index 00aaefe..814b96f 100644
--- a/revision.c
+++ b/revision.c
@@ -2015,23 +2015,31 @@ static struct commit_list **simplify_one(struct rev_info *revs, struct commit *c
 
 static void simplify_merges(struct rev_info *revs)
 {
-	struct commit_list *list;
+	struct commit_list *list, *next;
 	struct commit_list *yet_to_do, **tail;
+	struct commit *commit;
 
 	if (!revs->prune)
 		return;
 
 	/* feed the list reversed */
 	yet_to_do = NULL;
-	for (list = revs->commits; list; list = list->next)
-		commit_list_insert(list->item, &yet_to_do);
+	for (list = revs->commits; list; list = next) {
+		commit = list->item;
+		next = list->next;
+		/*
+		 * Do not free(list) here yet; the original list
+		 * is used later in this function.
+		 */
+		commit_list_insert(commit, &yet_to_do);
+	}
 	while (yet_to_do) {
 		list = yet_to_do;
 		yet_to_do = NULL;
 		tail = &yet_to_do;
 		while (list) {
-			struct commit *commit = list->item;
-			struct commit_list *next = list->next;
+			commit = list->item;
+			next = list->next;
 			free(list);
 			list = next;
 			tail = simplify_one(revs, commit, tail);
@@ -2043,9 +2051,10 @@ static void simplify_merges(struct rev_info *revs)
 	revs->commits = NULL;
 	tail = &revs->commits;
 	while (list) {
-		struct commit *commit = list->item;
-		struct commit_list *next = list->next;
 		struct merge_simplify_state *st;
+
+		commit = list->item;
+		next = list->next;
 		free(list);
 		list = next;
 		st = locate_simplify_state(revs, commit);
-- 
1.7.11.rc2.29.g85b30f3
