From: Junio C Hamano <junio@pobox.com>
Subject: [PATCH] list-objects.c: don't add an unparsed NULL as a pending tree
Date: Fri, 18 Mar 2011 00:24:36 -0700
Message-ID: <7vbp18zya3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 18 08:25:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0U3P-0007JL-Ld
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 08:25:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756309Ab1CRHYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 03:24:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63847 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756264Ab1CRHYn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 03:24:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 76C08246E;
	Fri, 18 Mar 2011 03:26:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=d
	J0gkReEbAuUUsC1QMZC//0aAv8=; b=lqW7N7jthEqQRLu2UeFT287OwG3rKwvD6
	mCWN/ABz8x061z1O3xUnBUWhYlcvmE8apwnfPDxOwSWmGd2n/xE22KwSzPL7cdKR
	bLDpFN/Wi0hvndbxHyMVQL6QAWNxfQSQIZyU8sZlQg9mNv3bNK2Wtju/cuCAOpLc
	2KB/ORiF9U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=lb7
	t/YX/zWvW5uUSHmz6Lg7HagKbduEU05Qoqemqh3cw6IPQoCOVhKnXKo078+pzFCe
	P61+SBLem60TLL6yFzw1uEx3140gw4PvwoXKxrcjdxxF/6mpSSEMZalwHwUz+nJT
	V21lPSLpQg4LKuUO68sr9wjvS1VJDK833m47jsPM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6479A2468;
	Fri, 18 Mar 2011 03:26:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9E18C2461; Fri, 18 Mar 2011
 03:26:12 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 019A7DAA-5131-11E0-9FB2-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169294>

"git rev-list --first-parent --boundary $commit^..$commit" segfaults on a
merge commit since 8d2dfc4 (process_{tree,blob}: show objects without
buffering, 2009-04-10), as it tried to dereference a commit that was
discarded as UNINTERESTING without being parsed (hence lacking "tree").

Signed-off-by: Junio C Hamano <junio@pobox.com>
---

 * The test has its own test_commit as I did this patch directly on top of
   8d2dfc4; back then we didn't have the helper in test-lib.sh.  Need to
   remove it when merging up to branches that have 0088496 (test-lib.sh:
   introduce test_commit() and test_merge() helpers, 2009-01-27).

 list-objects.c             |    7 ++++++-
 t/t6110-rev-list-sparse.sh |   27 +++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletions(-)
 create mode 100755 t/t6110-rev-list-sparse.sh

diff --git a/list-objects.c b/list-objects.c
index 5a4af62..518c665 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -147,7 +147,12 @@ void traverse_commit_list(struct rev_info *revs,
 	struct commit *commit;
 
 	while ((commit = get_revision(revs)) != NULL) {
-		add_pending_tree(revs, commit->tree);
+		/*
+		 * an uninteresting boundary commit may not have its tree
+		 * parsed yet, but we are not going to show them anyway
+		 */
+		if (commit->tree)
+			add_pending_tree(revs, commit->tree);
 		show_commit(commit);
 	}
 	for (i = 0; i < revs->pending.nr; i++) {
diff --git a/t/t6110-rev-list-sparse.sh b/t/t6110-rev-list-sparse.sh
new file mode 100755
index 0000000..2a267e8
--- /dev/null
+++ b/t/t6110-rev-list-sparse.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+
+test_description='operations that cull histories in unusual ways'
+. ./test-lib.sh
+
+test_commit () {
+	echo "$1" >"$1.file" &&
+	git add "$1.file" &&
+	test_tick &&
+	git commit -m "$1"
+}
+
+test_expect_success setup '
+	test_commit A &&
+	test_commit B &&
+	test_commit C &&
+	git checkout -b side HEAD^ &&
+	test_commit D &&
+	test_commit E &&
+	git merge master
+'
+
+test_expect_success 'rev-list --first-parent --boundary' '
+	git rev-list --first-parent --boundary HEAD^..
+'
+
+test_done
-- 
1.7.4.1.408.gb6b16
