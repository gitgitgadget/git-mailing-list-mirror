From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] revision: mark contents of an uninteresting tree uninteresting
Date: Wed, 15 Jan 2014 15:59:43 -0800
Message-ID: <1389830384-22851-2-git-send-email-gitster@pobox.com>
References: <1389830384-22851-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 16 01:00:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3aNM-0002ju-2C
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 01:00:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbaAOX7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 18:59:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45397 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751890AbaAOX7u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 18:59:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8209064ED5;
	Wed, 15 Jan 2014 18:59:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=dSec
	KrX7rliMaCDFFSqzMtNikKY=; b=WjlNS1iVmGwz+c0d5yveOVrRsgI2pojp+J6j
	xqFrJikHl1+ZnhpfD5zZ1QLZsum9ilSSa9KSUJ7dSZJHmmmVNT3nMEDamuwDlZVH
	L9ATpStR8dLm+ofFrTmgWBQQ8vRtiP//gfgYUnBzxuYv/7gHfSSkMxzxOzZpsuPY
	2Vqs/2w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	AfTxrQV9gNUKo74bf2nR1KhDTNKb+kdgfMXw3rBfA4/G+IXKb5w3FLavt4BTfGe+
	TBuwcek38/nVzROWZpxPqM9RD7iY/uI5pqnT7OM+y010N2nrAQKXm5Ru7/uDZMMd
	LA6V/FEeZlDIt3BbrGyyDZSZSBN47Q+VGHTMD30XYSA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CF1664ED2;
	Wed, 15 Jan 2014 18:59:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B96E464ECC;
	Wed, 15 Jan 2014 18:59:49 -0500 (EST)
X-Mailer: git-send-email 1.8.5.3-493-gb139ac2
In-Reply-To: <1389830384-22851-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1E4E8AFA-7E41-11E3-B80D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240492>

"git rev-list --objects ^A^{tree} B^{tree}" ought to mean "I want a
list of objects inside B's tree, but please exclude the objects that
appear inside A's tree".

we see the top-level tree marked as uninteresting (i.e. ^A^{tree} in
the above example) and call mark_tree_uninteresting() on it; this
unfortunately prevents us from recursing into the tree and marking
the objects in the tree as uninteresting.

The reason why "git log ^A A" yields an empty set of commits,
i.e. we do not have a similar issue for commits, is because we call
mark_parents_uninteresting() after seeing an uninteresting commit.
The uninteresting-ness of the commit itself does not prevent its
parents from being marked as uninteresting.

Introduce mark_tree_contents_uninteresting() and structure the code
in handle_commit() in such a way that it makes it the responsibility
of the callchain leading to this function to mark commits, trees and
blobs as uninteresting, and also make it the responsibility of the
helpers called from this function to mark objects that are reachable
from them.

Note that this is a very old bug that probably dates back to the day
when "rev-list --objects" was introduced.  The line to clear
tree->object.parsed at the end of mark_tree_contents_uninteresting()
can be removed when this fix is merged to the codebase after
6e454b9a (clear parsed flag when we free tree buffers, 2013-06-05).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c               | 25 +++++++++++++++++--------
 t/t6000-rev-list-misc.sh |  6 ++++++
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/revision.c b/revision.c
index 7010aff..28449c5 100644
--- a/revision.c
+++ b/revision.c
@@ -98,17 +98,12 @@ static void mark_blob_uninteresting(struct blob *blob)
 	blob->object.flags |= UNINTERESTING;
 }
 
-void mark_tree_uninteresting(struct tree *tree)
+static void mark_tree_contents_uninteresting(struct tree *tree)
 {
 	struct tree_desc desc;
 	struct name_entry entry;
 	struct object *obj = &tree->object;
 
-	if (!tree)
-		return;
-	if (obj->flags & UNINTERESTING)
-		return;
-	obj->flags |= UNINTERESTING;
 	if (!has_sha1_file(obj->sha1))
 		return;
 	if (parse_tree(tree) < 0)
@@ -135,6 +130,19 @@ void mark_tree_uninteresting(struct tree *tree)
 	 */
 	free(tree->buffer);
 	tree->buffer = NULL;
+	tree->object.parsed = 0;
+}
+
+void mark_tree_uninteresting(struct tree *tree)
+{
+	struct object *obj = &tree->object;
+
+	if (!tree)
+		return;
+	if (obj->flags & UNINTERESTING)
+		return;
+	obj->flags |= UNINTERESTING;
+	mark_tree_contents_uninteresting(tree);
 }
 
 void mark_parents_uninteresting(struct commit *commit)
@@ -294,7 +302,8 @@ static struct commit *handle_commit(struct rev_info *revs, struct object *object
 		if (!revs->tree_objects)
 			return NULL;
 		if (flags & UNINTERESTING) {
-			mark_tree_uninteresting(tree);
+			tree->object.flags |= UNINTERESTING;
+			mark_tree_contents_uninteresting(tree);
 			return NULL;
 		}
 		add_pending_object(revs, object, "");
@@ -309,7 +318,7 @@ static struct commit *handle_commit(struct rev_info *revs, struct object *object
 		if (!revs->blob_objects)
 			return NULL;
 		if (flags & UNINTERESTING) {
-			mark_blob_uninteresting(blob);
+			blob->object.flags |= UNINTERESTING;
 			return NULL;
 		}
 		add_pending_object(revs, object, "");
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index 15e3d64..9ad4971 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -56,4 +56,10 @@ test_expect_success 'rev-list A..B and rev-list ^A B are the same' '
 	test_cmp expect actual
 '
 
+test_expect_success 'propagate uninteresting flag down correctly' '
+	git rev-list --objects ^HEAD^{tree} HEAD^{tree} >actual &&
+	>expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.5.3-493-gb139ac2
