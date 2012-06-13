From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 01/19] apply: fix an incomplete comment in check_patch()
Date: Wed, 13 Jun 2012 12:32:42 -0700
Message-ID: <1339615980-19727-2-git-send-email-gitster@pobox.com>
References: <1339615980-19727-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 21:33:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SetJY-0007CQ-KN
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 21:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754733Ab2FMTdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 15:33:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65285 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754516Ab2FMTdE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 15:33:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51E1786EB
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=cZ+9
	zsaHoE9xZ+2z4bzgVP78Phw=; b=o6FgSlmNDbMZ1wWFubo9Y4MFIr0J0bVihyTv
	9GzEqGOSHR80fsu7wSL6HYGm7VS2RLWOAIX+rii0QxKZXuhE6Zlgkm0hZjfja0ic
	Jj/MdWebz70003UUci8bUeNhYZI/4NXUTqTQl0sTwZi/oxJ9ix230TP9b55wVLmr
	evpMxiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=kcxeG/
	P47KJ6jEbLwvSK43zcgFzOqHySV8/Aq0bwNr0W+3Sp/h7WA9mFOlr5LUSLa3Jp3h
	u7mAaRWIBIY0EIVGxwcxHxFK5cffN85LGvkKSk/uWhZ/DUrkjl/JpYsLgpxq2nRh
	FateUdCVWyZu5EUFU8k7U+PYfzQnNnEt8Oi50=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4953686EA
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C4BD586E9 for
 <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:03 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc3.30.g3bdace2
In-Reply-To: <1339615980-19727-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 98031BA4-B58E-11E1-A5E7-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199918>

This check is not only about type-change (for which it would be
sufficient to check only was_deleted()) but is also about a swap
rename.  Otherwise to_be_deleted() check is not justified.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 725712d..be4e3f3 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3218,16 +3218,22 @@ static int check_patch(struct patch *patch)
 		return status;
 	old_name = patch->old_name;
 
+	/*
+	 * A type-change diff is always split into a patch to
+	 * delete old, immediately followed by a patch to
+	 * create new (see diff.c::run_diff()); in such a case
+	 * it is Ok that the entry to be deleted by the
+	 * previous patch is still in the working tree and in
+	 * the index.
+	 *
+	 * A patch to swap-rename between A and B would first rename
+	 * A to B and then rename B to A.  While applying the first
+	 * one, the presense of B should not stop A from renamed to B,
+	 * as to_be_deleted() knows about the later rename.  Removal
+	 * of B and rename from A to B will be handle the same way.
+	 */
 	if ((tpatch = in_fn_table(new_name)) &&
-			(was_deleted(tpatch) || to_be_deleted(tpatch)))
-		/*
-		 * A type-change diff is always split into a patch to
-		 * delete old, immediately followed by a patch to
-		 * create new (see diff.c::run_diff()); in such a case
-		 * it is Ok that the entry to be deleted by the
-		 * previous patch is still in the working tree and in
-		 * the index.
-		 */
+	    (was_deleted(tpatch) || to_be_deleted(tpatch)))
 		ok_if_exists = 1;
 	else
 		ok_if_exists = 0;
-- 
1.7.11.rc3.30.g3bdace2
