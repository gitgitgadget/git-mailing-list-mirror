From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] attr.c: simplify macroexpand_one()
Date: Sun, 15 May 2016 15:57:25 -0700
Message-ID: <xmqqmvnr3p62.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 00:57:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b24yd-00064x-Bq
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 00:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbcEOW53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 18:57:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50206 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751871AbcEOW53 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 18:57:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A9BE1B94E;
	Sun, 15 May 2016 18:57:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=9
	DZTmTwouRMj/kYgXtAo2GdzW8U=; b=G5YyCyhhtqAJbPADFwa00GSYEaQRdBwl/
	T7F1ZNrWoE22r9HUuBQLx+HP8vlKH2rCxZPDiOw2MmmfmPT6ZhOGIRXHrb6ddoLo
	8u6tu8cbOsBU9nSE3SfOBjd9OyZyf0HTjCc+uh/cdP4Ok4RTCoWTgnTuzJ9hLDQr
	w4lMIp/R5c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=MsL
	4jP6DxZ4OjppaolzYY8GxWH5TtOlPS90U3yiUGz6918tXIcD7WrjDCC/4prmr48z
	+FwPi81n/fyRCCTGL7dT9ZmMvKWcG4WAVOf9352QHHqH7QfTQeoM1d+lnsCK/i9Z
	C38iOR18Gwgtoo/gbxlXIHGG0RyOEGsq+ccRKJMs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 735BF1B94D;
	Sun, 15 May 2016 18:57:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E21791B94C;
	Sun, 15 May 2016 18:57:27 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 658A3E70-1AF0-11E6-AEE3-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294691>

The double-loop wants to do an early return immediately when one
matching macro is found.  Eliminate the extra variable 'a' used for
that purpose and rewrite the "assign found itme to 'a' to make it
non-NULL and force the loop(s) to terminate" with a direct return
from there.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/attr.c b/attr.c
index 95416d3..7bfeef3 100644
--- a/attr.c
+++ b/attr.c
@@ -701,24 +701,21 @@ static int fill(const char *path, int pathlen, int basename_offset,
 static int macroexpand_one(int nr, int rem)
 {
 	struct attr_stack *stk;
-	struct match_attr *a = NULL;
 	int i;
 
 	if (check_all_attr[nr].value != ATTR__TRUE ||
 	    !check_all_attr[nr].attr->maybe_macro)
 		return rem;
 
-	for (stk = attr_stack; !a && stk; stk = stk->prev)
-		for (i = stk->num_matches - 1; !a && 0 <= i; i--) {
+	for (stk = attr_stack; stk; stk = stk->prev) {
+		for (i = stk->num_matches - 1; 0 <= i; i--) {
 			struct match_attr *ma = stk->attrs[i];
 			if (!ma->is_macro)
 				continue;
 			if (ma->u.attr->attr_nr == nr)
-				a = ma;
+				return fill_one("expand", ma, rem);
 		}
-
-	if (a)
-		rem = fill_one("expand", a, rem);
+	}
 
 	return rem;
 }
-- 
2.8.2-748-gfb85f76
