From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] revision: note the lack of free() in
 simplify_merges()
Date: Fri, 22 Jun 2012 15:27:39 -0700
Message-ID: <1340404061-11619-3-git-send-email-gitster@pobox.com>
References: <1340404061-11619-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 23 00:27:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiCKU-0007W8-MO
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jun 2012 00:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759027Ab2FVW1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 18:27:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38026 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753246Ab2FVW1q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 18:27:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 529399496
	for <git@vger.kernel.org>; Fri, 22 Jun 2012 18:27:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=IK8h
	eTFzfaq6H1yDwMdMmY+Pg7Y=; b=NsO3Ts1UxBXZ9HJTF/3JHf066Oqa2pKxdhyX
	XCJ9rhotyvZcirCGfzeaDOeGZFAG7CkXlSspnSdto3ntynfjCicTT9GhWr0lvhb4
	nm+3HsWvTq9Lt+ZoAxrBsV7BIkOfAZPqCOQt6t8Fbuxxoo1DHB+ukGP23Z865156
	K8IG5uQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=U9WHop
	HKndulznUq+Yv7ZDCBuXX65DG2jgW4TquBuXNvDgVCmaSYxJD9jH9QzIHDBJvBHR
	s5VtPkJ+p8ZRNUI/8AjlvmoZg2Kgi1I2EGKUTPD3FiF3P/gQHBJ2XCRyB1mmIwtD
	tCVFjn5q1ajhjFb6Rvjr/HdknnRsXKemWlmJE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49D3F9495
	for <git@vger.kernel.org>; Fri, 22 Jun 2012 18:27:46 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF75B9494 for
 <git@vger.kernel.org>; Fri, 22 Jun 2012 18:27:45 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.29.gf71be5c
In-Reply-To: <1340404061-11619-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 7D83D034-BCB9-11E1-9ADE-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200480>

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
1.7.11.1.29.gf71be5c
