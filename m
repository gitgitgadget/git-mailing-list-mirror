From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] diff -c/--cc: do not mistake "resolved as deletion" as "use
 working tree"
Date: Thu, 04 Aug 2011 11:58:45 -0700
Message-ID: <7vwret3swq.fsf_-_@alter.siamese.dyndns.org>
References: <201108011935.11373.johan@herland.net>
 <7vsjph6g4j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 20:58:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qp38A-0002is-4y
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 20:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468Ab1HDS6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 14:58:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53559 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754604Ab1HDS6s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 14:58:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 369804192;
	Thu,  4 Aug 2011 14:58:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jrL/dXcxbstjXrUt60KirrKLYD4=; b=oNY8yO
	gbIL6Oa68FKHMkZVQN+DQHInAKnoL1o0lioX/oymm1FAvCAFnfcnFyBxd5jfXaEr
	1HjgvP0OJny507bmT6njQphxkRcCIpoDg/3gaVX9TjvuQ2m2+3nnU8723F31pEpg
	OrfM6p20TykWwhRu50CU3VuUR0LoPSRituZww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LHyFREnOA62Haf5HdoD71IY3kkvjh3J8
	MBf+IuIWqdODrIuz7P80wxhzS+ZOYQsj5nLhf+JmStKOb/PcUZkj0Zemqa+zpI7u
	GKPanVoc/sNUbiv6XC8zQa9nH7x/UwQ5QEDzbrj7siHa0IKZ7knu43gVYPW4nFxV
	FbWlUAg+qvo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EB004191;
	Thu,  4 Aug 2011 14:58:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F0C6418F; Thu,  4 Aug 2011
 14:58:46 -0400 (EDT)
In-Reply-To: <7vsjph6g4j.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 03 Aug 2011 19:54:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C824F560-BECB-11E0-9599-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178762>

The combined diff machinery can be used to compare:

 - a merge commit with its parent commits;
 - a working-tree file with multiple stages in an unmerged index; or
 - a working-tree file with the HEAD and the index.

The internal function combine-diff.c:show_patch_diff() checked if it needs
to read the "result" from the working tree by looking at the object name
of the result --- if it is null_sha1, it read from the working tree.

This mistook a merge that records a deletion as the conflict resolution
as if it is a cue to read from the working tree. Pass this information
explicitly from the caller instead.

Noticed and reported by Johan Herland.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The patch is based on a bit older maintenance branch but will be queued
   in 'pu'.

 combine-diff.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 655fa89..360b816 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -682,7 +682,8 @@ static void dump_quoted_path(const char *head,
 }
 
 static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
-			    int dense, struct rev_info *rev)
+			    int dense, int working_tree_file,
+			    struct rev_info *rev)
 {
 	struct diff_options *opt = &rev->diffopt;
 	unsigned long result_size, cnt, lno;
@@ -691,7 +692,6 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	struct sline *sline; /* survived lines */
 	int mode_differs = 0;
 	int i, show_hunks;
-	int working_tree_file = is_null_sha1(elem->sha1);
 	int abbrev = DIFF_OPT_TST(opt, FULL_INDEX) ? 40 : DEFAULT_ABBREV;
 	const char *a_prefix, *b_prefix;
 	mmfile_t result_file;
@@ -954,6 +954,12 @@ static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct re
 	write_name_quoted(p->path, stdout, line_termination);
 }
 
+/*
+ * The result (p->elem) is from the working tree and their
+ * parents are typically from multiple stages during a merge
+ * (i.e. diff-files) or the state in HEAD and in the index
+ * (i.e. diff-index).
+ */
 void show_combined_diff(struct combine_diff_path *p,
 		       int num_parent,
 		       int dense,
@@ -967,7 +973,7 @@ void show_combined_diff(struct combine_diff_path *p,
 				  DIFF_FORMAT_NAME_STATUS))
 		show_raw_diff(p, num_parent, rev);
 	else if (opt->output_format & DIFF_FORMAT_PATCH)
-		show_patch_diff(p, num_parent, dense, rev);
+		show_patch_diff(p, num_parent, dense, 1, rev);
 }
 
 void diff_tree_combined(const unsigned char *sha1,
@@ -1035,7 +1041,7 @@ void diff_tree_combined(const unsigned char *sha1,
 			for (p = paths; p; p = p->next) {
 				if (p->len)
 					show_patch_diff(p, num_parent, dense,
-							rev);
+							0, rev);
 			}
 		}
 	}
-- 
1.7.6.401.g6a319
