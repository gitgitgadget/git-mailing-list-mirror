From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 11/11] rerere: adjust 'forget' to multi-variant world order
Date: Mon, 28 Mar 2016 15:42:22 -0700
Message-ID: <1459204942-26601-12-git-send-email-gitster@pobox.com>
References: <1442275050-30497-1-git-send-email-gitster@pobox.com>
 <1459204942-26601-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 00:43:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akfsF-0005OR-Mc
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 00:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755518AbcC1Wmt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 18:42:49 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:63599 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755504AbcC1Wmo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 18:42:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6AA394FFDA;
	Mon, 28 Mar 2016 18:42:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=HWkU
	wwTkPvYNBu6sYTbYuwJ6JkY=; b=jeQ2HLklOmBD2pvPmH7iA8qjwCdybeYZ3J0X
	Y7ftIAYt04110X2YeeSxhcxNhqGcip8tz09iNf1CU8RKaxN/P+2xaZQSsJ/hh8Yt
	Xycy+ghBXGhmiSmnb/TEjmqHN6zLSWgzfjxz9xiLAuDbREmW6eviG9FOWe+99L6k
	/2Y5nSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=dbu6Tw
	2AiiPymWNtDl//iwGTxzL6dRUMTxVcBuTLIJdffw7Ee4UeI8U3wcXwhN6ujWGgM0
	k7aH7/xk8oemRe10zvawxy47mD+b+k8z7hmXNIQMkHxR8/81kiSLQeBf/GAKmE2i
	Vrbf5DAh1M+mNGRC+6C2wg8YP0R04rLDcyCAU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 61DC54FFD8;
	Mon, 28 Mar 2016 18:42:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DADA54FFD7;
	Mon, 28 Mar 2016 18:42:42 -0400 (EDT)
X-Mailer: git-send-email 2.8.0-215-g046a488
In-Reply-To: <1459204942-26601-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 62311D1E-F536-11E5-89B4-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290077>

Because conflicts with the same contents inside conflict blocks
enclosed by "<<<<<<<" and ">>>>>>>" can now have multiple variants
to help three-way merge to adjust to the differences outside the
conflict blocks, "rerere forget $path" needs to be taught that there
may be multiple recorded resolutions that share the same conflict
hash (which groups the conflicts with "the same contents inside
conflict blocks"), among which there are some that would not be
relevant to the conflict we are looking at.  These "other variants"
that happen to share the same conflict hash should not be cleared,
and the variant that would apply to the current conflict may not be
the zero-th one (which is the only one that is cleared by the
current code).

After finding the conflict hash, iterate over the existing variants
and try to resolve the conflict using each of them to find the one
that "cleanly" resolves the current conflict.  That is the one we
want to forget and record the preimage for, so that the user can
record the corrected resolution.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * New in v2.  I _think_ we should refactor the code further in
   order to avoid rewriting "thisimage", "thisimage.1", etc. on the
   filesystem (instead, teach handle_path() to output to an in-core
   buffer and keep it around during this loop), and doing the same
   handle_cache() over and over again, but for now this should do.

 rerere.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/rerere.c b/rerere.c
index e636d4b..1693866 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1038,7 +1038,33 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 
 	/* Nuke the recorded resolution for the conflict */
 	id = new_rerere_id(sha1);
-	id->variant = 0; /* for now */
+
+	for (id->variant = 0;
+	     id->variant < id->collection->status_nr;
+	     id->variant++) {
+		mmfile_t cur = { NULL, 0 };
+		mmbuffer_t result = {NULL, 0};
+		int cleanly_resolved;
+
+		if (!has_rerere_resolution(id))
+			continue;
+
+		handle_cache(path, sha1, rerere_path(id, "thisimage"));
+		if (read_mmfile(&cur, rerere_path(id, "thisimage"))) {
+			free(cur.ptr);
+			return error("Failed to update conflicted state in '%s'",
+				     path);
+		}
+		cleanly_resolved = !try_merge(id, path, &cur, &result);
+		free(result.ptr);
+		free(cur.ptr);
+		if (cleanly_resolved)
+			break;
+	}
+
+	if (id->collection->status_nr <= id->variant)
+		return error("no remembered resolution for '%s'", path);
+
 	filename = rerere_path(id, "postimage");
 	if (unlink(filename))
 		return (errno == ENOENT
-- 
2.8.0-215-g046a488
