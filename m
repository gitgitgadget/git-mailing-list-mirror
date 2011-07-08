From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] pack-objects: optimize "recency order"
Date: Fri, 08 Jul 2011 15:47:23 -0700
Message-ID: <7vfwmgfkzo.fsf@alter.siamese.dyndns.org>
References: <1310084657-16790-1-git-send-email-gitster@pobox.com>
 <1310084657-16790-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jul 09 00:47:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QfJpc-0003kd-H7
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jul 2011 00:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113Ab1GHWr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jul 2011 18:47:27 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52655 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057Ab1GHWr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2011 18:47:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 261306F8A;
	Fri,  8 Jul 2011 18:47:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eyKK648c/4Si+bjzFn/m38D7fNc=; b=ruYXXi
	lGZfkgQOTp+qkzAK0v1x9dnUCxCT4h/MxNbC1ZppQgVCh4iCeAA9PyhNeG0NCM+X
	sNqs6c0NF8n5r0czY5//24PnwDcWcdHqPRH4RxAzGIZz2jIW4wpB1VxEfaGdPRz4
	aeUxSWNvvrRCoYMlUXyytqJr3C3Tmv5yVq0qA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cr3QxYnIFF4Cx/SoSyOPp5IFYHd2XbZt
	zzQHBOTbYQqWpDuUERN9PNSpzrklmDuMlrTq//EqS5WNrWE+bZPyZ4kWP3RdTvK6
	oBctG8buHIcBz1/F/UMbC53CXiI3RzQvAWsVq4Tdmf0phJN1ow/FrnCLZgg3MU2a
	gS5jfOfCU10=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1EFD46F89;
	Fri,  8 Jul 2011 18:47:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 48FD16F87; Fri,  8 Jul 2011
 18:47:25 -0400 (EDT)
In-Reply-To: <1310084657-16790-3-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Thu, 7 Jul 2011 17:24:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3FF0EF5E-A9B4-11E0-9FFE-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176806>

This updates the codepath to write commit objects so that when a commit is
emitted, its parents are scheduled to be output next (but this does not go
recursively), in the hope that it may help a typical "rev-list" traversal.

I've tried various workloads from the previous message; while this patch
does not regress any of them significantly, it does not seem to improve
them significantly, either.



 builtin/pack-objects.c |   96 ++++++++++++++++++++++++++++++++++-------------
 1 files changed, 69 insertions(+), 27 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 27132bb..46ae610 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -487,6 +487,74 @@ static void add_family_to_write_order(struct object_entry **wo,
 	add_descendants_to_write_order(wo, endp, root);
 }
 
+static void add_commit_to_write_order(struct object_entry **wo,
+				      int *endp,
+				      struct object_entry *e)
+{
+	/*
+	 * A typical rev-list traversal looks at the parent of a
+	 * commit before deciding to emit the commit; if it ends up
+	 * emitting this commit, it is likely that it needs an early
+	 * access of its parents.
+	 */
+	struct commit *commit;
+	struct commit_list *parents;
+
+	if (e->filled)
+		return;
+	add_to_write_order(wo, endp, e);
+	commit = lookup_commit(e->idx.sha1);
+	if (!commit ||
+	    (!commit->object.parsed && parse_commit(commit)))
+		die("BUG: calling add_commit with a non-commit???");
+	for (parents = commit->parents; parents; parents = parents->next) {
+		struct object_entry *pe;
+		struct commit *parent = parents->item;
+		pe = locate_object_entry(parent->object.sha1);
+		if (pe)
+			add_to_write_order(wo, endp, pe);
+	}
+}
+
+static int add_commits_to_write_order(struct object_entry **wo)
+{
+	int i, wo_end;
+
+	/*
+	 * Give the commits in the original recency order until
+	 * we see a tagged tip.
+	 */
+	for (i = wo_end = 0; i < nr_objects; i++) {
+		if (objects[i].type != OBJ_COMMIT)
+			continue;
+		if (objects[i].tagged)
+			break;
+		add_commit_to_write_order(wo, &wo_end, &objects[i]);
+	}
+
+	/*
+	 * Then fill all the tagged tips.
+	 */
+	for (i = 0; i < nr_objects; i++) {
+		if (objects[i].type != OBJ_COMMIT)
+			continue;
+		if (objects[i].tagged)
+			add_commit_to_write_order(wo, &wo_end, &objects[i]);
+	}
+
+	/*
+	 * And then all remaining commits and tags.
+	 */
+	for (i = 0; i < nr_objects; i++) {
+		if (objects[i].type == OBJ_COMMIT)
+			add_commit_to_write_order(wo, &wo_end, &objects[i]);
+		else if (objects[i].type != OBJ_TAG)
+			add_to_write_order(wo, &wo_end, &objects[i]);
+	}
+
+	return wo_end;
+}
+
 static struct object_entry **compute_write_order(void)
 {
 	int i, wo_end;
@@ -519,33 +587,7 @@ static struct object_entry **compute_write_order(void)
 	 */
 	for_each_tag_ref(mark_tagged, NULL);
 
-	/*
-	 * Give the commits in the original recency order until
-	 * we see a tagged tip.
-	 */
-	for (i = wo_end = 0; i < nr_objects; i++) {
-		if (objects[i].tagged)
-			break;
-		add_to_write_order(wo, &wo_end, &objects[i]);
-	}
-
-	/*
-	 * Then fill all the tagged tips.
-	 */
-	for (; i < nr_objects; i++) {
-		if (objects[i].tagged)
-			add_to_write_order(wo, &wo_end, &objects[i]);
-	}
-
-	/*
-	 * And then all remaining commits and tags.
-	 */
-	for (i = 0; i < nr_objects; i++) {
-		if (objects[i].type != OBJ_COMMIT &&
-		    objects[i].type != OBJ_TAG)
-			continue;
-		add_to_write_order(wo, &wo_end, &objects[i]);
-	}
+	wo_end = add_commits_to_write_order(wo);
 
 	/*
 	 * And then all the trees.
