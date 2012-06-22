From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] revision: ignore side parents while running
 simplify-merges
Date: Fri, 22 Jun 2012 15:27:40 -0700
Message-ID: <1340404061-11619-4-git-send-email-gitster@pobox.com>
References: <1340404061-11619-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 23 00:28:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiCKd-0007ix-CS
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jun 2012 00:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759243Ab2FVW1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 18:27:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38041 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753246Ab2FVW1s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 18:27:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B3FF9499
	for <git@vger.kernel.org>; Fri, 22 Jun 2012 18:27:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Vvcp
	wCo3wtw6P8nc5hpj1c0b4eU=; b=nrX9YPmc+LQMBrfL7gSY8dzsid4dco0DlN+Y
	Pvrzl9eR2+sPuq7BthwDUepMF3PpsE5eU0/qJDTzYMSGrgPI+enMDWa+Cpfe8Tjg
	ApZ/BVm8Mv26kaSvqHJSQRgrvklGEsyVDsSMw2zGVfYnodViLgaF0mMS9MZOCThl
	sF3NBLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=gXfNRQ
	AsxgeYkqxabH+Si2kkq8yvp+lTb69MrR7CeKoqyvNsjBNp/vkL144jjPs0ZAcsnx
	mhY03k8v0i6tF1PDJZqTi9FnunZEZHlzS9JrcbkD9kwdMQWtaUhgKWEt+i7w6Y5X
	1uuB1JGIxQ0pXXhq40HfRVVH7xpxePpvmq6UQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 132559498
	for <git@vger.kernel.org>; Fri, 22 Jun 2012 18:27:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 98CFF9497 for
 <git@vger.kernel.org>; Fri, 22 Jun 2012 18:27:47 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.29.gf71be5c
In-Reply-To: <1340404061-11619-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 7E92E618-BCB9-11E1-979E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200481>

The simplify_merges() function needs to look at all history chain to
find the closest ancestor that is relevant after the simplification,
but after --first-parent traversal, side parents haven't been marked
for relevance (they are irrelevant by definition due to the nature
of first-parent-only traversal) nor culled from the parents list of
resulting commits.

We cannot simply remove these side parents from the parents list, as
the output phase still wants to see the parents.  Instead, teach
simplify_one() and its callees to ignore the later parents.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/revision.c b/revision.c
index 814b96f..d1a4ef5 100644
--- a/revision.c
+++ b/revision.c
@@ -1949,8 +1949,9 @@ static struct commit_list **simplify_one(struct rev_info *revs, struct commit *c
 	}
 
 	/*
-	 * Do we know what commit all of our parents should be rewritten to?
-	 * Otherwise we are not ready to rewrite this one yet.
+	 * Do we know what commit all of our parents that matter
+	 * should be rewritten to?  Otherwise we are not ready to
+	 * rewrite this one yet.
 	 */
 	for (cnt = 0, p = commit->parents; p; p = p->next) {
 		pst = locate_simplify_state(revs, p->item);
@@ -1958,6 +1959,8 @@ static struct commit_list **simplify_one(struct rev_info *revs, struct commit *c
 			tail = &commit_list_insert(p->item, tail)->next;
 			cnt++;
 		}
+		if (revs->first_parent_only)
+			break;
 	}
 	if (cnt) {
 		tail = &commit_list_insert(commit, tail)->next;
@@ -1970,8 +1973,13 @@ static struct commit_list **simplify_one(struct rev_info *revs, struct commit *c
 	for (p = commit->parents; p; p = p->next) {
 		pst = locate_simplify_state(revs, p->item);
 		p->item = pst->simplified;
+		if (revs->first_parent_only)
+			break;
 	}
-	cnt = remove_duplicate_parents(commit);
+	if (!revs->first_parent_only)
+		cnt = remove_duplicate_parents(commit);
+	else
+		cnt = 1;
 
 	/*
 	 * It is possible that we are a merge and one side branch
-- 
1.7.11.1.29.gf71be5c
