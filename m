From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 01/19] apply: fix an incomplete comment in check_patch()
Date: Tue, 10 Jul 2012 00:03:54 -0700
Message-ID: <1341903852-4815-2-git-send-email-gitster@pobox.com>
References: <1341903852-4815-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 09:04:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoUUm-00085p-Re
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 09:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037Ab2GJHEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 03:04:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52965 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752152Ab2GJHEU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 03:04:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A1D67DC6
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=6LYd
	q6cPGjxvlmY22V1gdPKV0H8=; b=hASdqDhAUK+AMx7N3xPFzSwvbxMX51S1xy92
	CzHq8SIpGKOzFG+UofS1cAg/Km1Cew7RLX+ez4qV9qV8FcZC5m1Oy9EUstsJgVLH
	IMs4ORxg8H9e5Duk7B0PxqQ8Dnuag+Qv1nPZfzfdhAnJrexJUx560Fq9x+WuJ7AV
	kgu7LoY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=NNeYQB
	/qRzvUEba+df3jLj4LgQv91TtEsMOkSUUEGNc3ph311AjLlcFC6ohWERRoSb3afL
	CUYDZievqiBBGLsyy3TMgjxmsy/dZHlp35dNP8hcCJJkcHcYQyNUS2LzDTdbxB9m
	murRrF/XtGUs8kIYi+G4xRjStYN8GG/ytEPs4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 211307DC5
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:20 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C3DB7DC4 for
 <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:17 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.294.g68a9409
In-Reply-To: <1341903852-4815-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 76E38BFA-CA5D-11E1-84BD-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201239>

This check is not only about type-change (for which it would be
sufficient to check only was_deleted()) but is also about a swap
rename.  Otherwise to_be_deleted() check is not justified.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 725712d..44f6de9 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3218,16 +3218,22 @@ static int check_patch(struct patch *patch)
 		return status;
 	old_name = patch->old_name;
 
+	/*
+	 * A type-change diff is always split into a patch to delete
+	 * old, immediately followed by a patch to create new (see
+	 * diff.c::run_diff()); in such a case it is Ok that the entry
+	 * to be deleted by the previous patch is still in the working
+	 * tree and in the index.
+	 *
+	 * A patch to swap-rename between A and B would first rename A
+	 * to B and then rename B to A.  While applying the first one,
+	 * the presense of B should not stop A from getting renamed to
+	 * B; ask to_be_deleted() about the later rename.  Removal of
+	 * B and rename from A to B is handled the same way by asking
+	 * was_deleted().
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
1.7.11.1.294.g68a9409
