From: Junio C Hamano <gitster@pobox.com>
Subject: Re: reproducible unexpected behavior for 'git reset'
Date: Wed, 13 Jul 2011 23:01:09 -0700
Message-ID: <7vzkkh2yfu.fsf@alter.siamese.dyndns.org>
References: <75BBC138-2BD7-41F9-9D84-CEFF23CDC235@johnnowak.com>
 <7vwrfoa3fg.fsf@alter.siamese.dyndns.org>
 <7voc10a1a2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Nowak <john@johnnowak.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 08:10:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhF7x-0008Dq-Jc
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 08:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349Ab1GNGKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 02:10:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51262 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752308Ab1GNGKT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 02:10:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32DA224D3;
	Thu, 14 Jul 2011 02:01:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=uC1LR5PsecXhfbFhkScxW6a/who=; b=fDzcPS
	6zM/o6Qx9Od56Mq0a0qYlBAsISvk1s1UHUETNAJzDwSyp4uiaw3Oc6x1n/O8pvGS
	SR0U8pUidkD10xZTscQ3+e+w/OvUDZsZz16Qq1qGbsqJxf6t8sI7xud62I5xyp8V
	0ExTprLGTLSWSw9jrZDg3eP5biPlH0VnF7uqs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d/Tfsxwna+WPZx81jFUD07+jmDTIxEiu
	6y0u7cTqfzvKKFFfqVtNJ9Nkv1bwp2t9qyB3ntnyMPPPn/8G0EAlzWld/Jhvc9oI
	8QN8O36czO9Ag/Wlf6bg6vr1bbldqb39/2gVkt8x+7ab3h3V9YTcddipJbEGgYj/
	dHhQAIPyWhw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AAC624D2;
	Thu, 14 Jul 2011 02:01:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6120D24D1; Thu, 14 Jul 2011
 02:01:10 -0400 (EDT)
In-Reply-To: <7voc10a1a2.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 11 Jul 2011 15:41:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC2CD7D6-ADDE-11E0-9681-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177101>

Junio C Hamano <gitster@pobox.com> writes:

> This patch is probably a wrong way to fix this issue...

Yes, it was a wrong way. Here is the hopefully right one ;-)

Funny thing is that this is a rather ancient bug, dating back to d1f2d7e
(Make run_diff_index() use unpack_trees(), not read_tree(), 2008-01-19)
and survived a fix for that commit at 29796c6 (diff-index: report unmerged
new entries, 2009-08-04). The reason it survived is probably because
people care about the fact that the path is unmerged, but not the exact
object name on the LHS of the diff (which comes from the tree).

-- >8 --
Subject: [PATCH] reset [<commit>] paths...: do not mishandle unmerged paths

Because "diff --cached HEAD" showed an incorrect blob object name on the
LHS of the diff, we ended up updating the index entry with bogus value,
not what we read from the tree.

Noticed by John Nowak.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/reset.c  |    2 +-
 diff-lib.c       |    3 ++-
 t/t7102-reset.sh |   15 +++++++++++++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 98bca04..777e7c6 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -162,7 +162,7 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filespec *one = q->queue[i]->one;
-		if (one->mode) {
+		if (one->mode && !is_null_sha1(one->sha1)) {
 			struct cache_entry *ce;
 			ce = make_cache_entry(one->mode, one->sha1, one->path,
 				0, 0);
diff --git a/diff-lib.c b/diff-lib.c
index 9c29293..fd61acb 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -379,7 +379,8 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 	if (cached && idx && ce_stage(idx)) {
 		struct diff_filepair *pair;
 		pair = diff_unmerge(&revs->diffopt, idx->name);
-		fill_filespec(pair->one, idx->sha1, idx->ce_mode);
+		if (tree)
+			fill_filespec(pair->one, tree->sha1, tree->ce_mode);
 		return;
 	}
 
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index f1cfc9a..b096dc8 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -429,6 +429,21 @@ test_expect_success '--mixed refreshes the index' '
 	test_i18ncmp expect output
 '
 
+test_expect_success 'resetting specific path that is unmerged' '
+	git rm --cached file2 &&
+	F1=$(git rev-parse HEAD:file1) &&
+	F2=$(git rev-parse HEAD:file2) &&
+	F3=$(git rev-parse HEAD:secondfile) &&
+	{
+		echo "100644 $F1 1	file2" &&
+		echo "100644 $F2 2	file2" &&
+		echo "100644 $F3 3	file2"
+	} | git update-index --index-info &&
+	git ls-files -u &&
+	test_must_fail git reset HEAD file2 &&
+	git diff-index --exit-code --cached HEAD
+'
+
 test_expect_success 'disambiguation (1)' '
 
 	git reset --hard &&
-- 
1.7.6.178.g55272
