From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] unpack-trees: allow pruning with pathspec
Date: Mon, 29 Aug 2011 14:33:22 -0700
Message-ID: <1314653603-7533-3-git-send-email-gitster@pobox.com>
References: <7vty9054qr.fsf@alter.siamese.dyndns.org>
 <1314653603-7533-1-git-send-email-gitster@pobox.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 29 23:33:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy9Sb-00085Q-4P
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 23:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755078Ab1H2Vdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 17:33:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39655 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754524Ab1H2Vda (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 17:33:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD84647D1;
	Mon, 29 Aug 2011 17:33:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Xdlz
	PZd7ZnuIhN4fW+lfe63Mm9o=; b=SOJJ08DyCItdBPft+lfGzbQkzaGjyCT/3D8c
	AD7BqHZihy55WK7vwoyGfZVJzWJBwTAMTfpO4dDLjSDKuTlsWKnSqoYQVorJF12m
	wiT1Rq3TpmR6nltU/EmNJL7CKcY5EHPLQaKK+GrMvr0Mce8DwnAcqlQppZy5SaNc
	BIV1ztI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	hXECEERHT0Rtjlzp//TGeddMbgEr7ZumzLq9ZN34Mhuox4IQ5ZMGlviD65bSEgdR
	7i5a677ZwlOe8gtDCvvDYkmk5eCi5ABx38DfRNJ3Dkb/Ut2JEF7Ej5x71LZnlaoA
	qWznj9mn28R/PoDo0u7IPFChcqxT99cuB4kREQJ5VkE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C522247D0;
	Mon, 29 Aug 2011 17:33:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2647D47CC; Mon, 29 Aug 2011
 17:33:29 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.70.g82660
In-Reply-To: <1314653603-7533-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8946839E-D286-11E0-B72E-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180360>

Use the pathspec pruning of traverse_trees() from unpack_trees(). Again,
the unpack_trees() machinery is primarily meant for merging two (or more)
trees, and because a merge is a full tree operation, it didn't support any
pruning with pathspec, and this codepath probably should not be enabled
while running a merge, but the caller in diff-lib.c::diff_cache() should
be able to take advanrage of it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 unpack-trees.c |    2 ++
 unpack-trees.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index cc616c3..670b464 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -444,6 +444,7 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
 
 	newinfo = *info;
 	newinfo.prev = info;
+	newinfo.pathspec = info->pathspec;
 	newinfo.name = *p;
 	newinfo.pathlen += tree_entry_len(p->path, p->sha1) + 1;
 	newinfo.conflicts |= df_conflicts;
@@ -1040,6 +1041,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		info.fn = unpack_callback;
 		info.data = o;
 		info.show_all_errors = o->show_all_errors;
+		info.pathspec = o->pathspec;
 
 		if (o->prefix) {
 			/*
diff --git a/unpack-trees.h b/unpack-trees.h
index 7998948..5e432f5 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -52,6 +52,7 @@ struct unpack_trees_options {
 	const char *prefix;
 	int cache_bottom;
 	struct dir_struct *dir;
+	struct pathspec *pathspec;
 	merge_fn_t fn;
 	const char *msgs[NB_UNPACK_TREES_ERROR_TYPES];
 	/*
-- 
1.7.7.rc0.70.g82660
