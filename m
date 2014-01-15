From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] revision: propagate flag bits from tags to pointees
Date: Wed, 15 Jan 2014 15:59:44 -0800
Message-ID: <1389830384-22851-3-git-send-email-gitster@pobox.com>
References: <1389830384-22851-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 16 01:00:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3aNT-0002vs-QC
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 01:00:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbaAOX77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 18:59:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53988 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694AbaAOX7w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 18:59:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AE2964EDD;
	Wed, 15 Jan 2014 18:59:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=CL/G
	bCVm4G6ahvqOFVgR5huLMCI=; b=eqDbGrBRQgwQGImeUfZoar3CDFFiEQqVam36
	OSuIv1kbsuZ532WZruhe9rmWeilM96S8rIFfqaNG3BFkcUMoLWwjFGnTVa1WzmfM
	FI0tIA3HXSp5DwQ5xPRRVlvGkcT4JhkDtkreVdGzplrDhaxRuo2slIdu38epX4De
	FimggGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	lpkZgtwjd55LC4PZwnFQf1jl1Ob7TnWcn9Ud6FJK3BVfS19SkZOBCH9nHCLbIK1F
	FM5SUweM/XMWhTxDCeVQxUg0QhlGIWNI/ZXu1RJ4KPD9JcNx8g+WQ+f/Cs/e7ebp
	Tk76aOeYiX0DHbSy6+8TTlrB9v3XsvDnc4pUI7nQqFE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CC0664EDC;
	Wed, 15 Jan 2014 18:59:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8678964EDB;
	Wed, 15 Jan 2014 18:59:51 -0500 (EST)
X-Mailer: git-send-email 1.8.5.3-493-gb139ac2
In-Reply-To: <1389830384-22851-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1F5FEE20-7E41-11E3-9FBA-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240493>

With the previous fix 895c5ba3 (revision: do not peel tags used in
range notation, 2013-09-19), handle_revision_arg() that processes
command line arguments for the "git log" family of commands no
longer directly places the object pointed by the tag in the pending
object array when it sees a tag object.  We used to place pointee
there after copying the flag bits like UNINTERESTING and
SYMMETRIC_LEFT.

This change meant that any flag that is relevant to later history
traversal must now be propagated to the pointed objects (most often
these are commits) while starting the traversal, which is partly
done by handle_commit() that is called from prepare_revision_walk().
We did propagate UNINTERESTING, but did not do so for others, most
notably SYMMETRIC_LEFT.  This caused "git log --left-right v1.0..."
(where "v1.0" is a tag) to start losing the "leftness" from the
commit the tag points at.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c               |  8 ++------
 t/t6000-rev-list-misc.sh | 11 +++++++++++
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/revision.c b/revision.c
index 28449c5..aec0333 100644
--- a/revision.c
+++ b/revision.c
@@ -273,6 +273,7 @@ static struct commit *handle_commit(struct rev_info *revs, struct object *object
 				return NULL;
 			die("bad object %s", sha1_to_hex(tag->tagged->sha1));
 		}
+		object->flags |= flags;
 	}
 
 	/*
@@ -284,7 +285,6 @@ static struct commit *handle_commit(struct rev_info *revs, struct object *object
 		if (parse_commit(commit) < 0)
 			die("unable to parse commit %s", name);
 		if (flags & UNINTERESTING) {
-			commit->object.flags |= UNINTERESTING;
 			mark_parents_uninteresting(commit);
 			revs->limited = 1;
 		}
@@ -302,7 +302,6 @@ static struct commit *handle_commit(struct rev_info *revs, struct object *object
 		if (!revs->tree_objects)
 			return NULL;
 		if (flags & UNINTERESTING) {
-			tree->object.flags |= UNINTERESTING;
 			mark_tree_contents_uninteresting(tree);
 			return NULL;
 		}
@@ -314,13 +313,10 @@ static struct commit *handle_commit(struct rev_info *revs, struct object *object
 	 * Blob object? You know the drill by now..
 	 */
 	if (object->type == OBJ_BLOB) {
-		struct blob *blob = (struct blob *)object;
 		if (!revs->blob_objects)
 			return NULL;
-		if (flags & UNINTERESTING) {
-			blob->object.flags |= UNINTERESTING;
+		if (flags & UNINTERESTING)
 			return NULL;
-		}
 		add_pending_object(revs, object, "");
 		return NULL;
 	}
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index 9ad4971..3794e4c 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -62,4 +62,15 @@ test_expect_success 'propagate uninteresting flag down correctly' '
 	test_cmp expect actual
 '
 
+test_expect_success 'symleft flag bit is propagated down from tag' '
+	git log --format="%m %s" --left-right v1.0...master >actual &&
+	cat >expect <<-\EOF &&
+	> two
+	> one
+	< another
+	< that
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.5.3-493-gb139ac2
