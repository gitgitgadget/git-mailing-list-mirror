From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 07/12] attr.c: simplify macroexpand_one()
Date: Mon, 16 May 2016 14:05:40 -0700
Message-ID: <20160516210545.6591-8-gitster@pobox.com>
References: <20160516210545.6591-1-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 23:06:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2PiU-0001LI-BQ
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 23:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbcEPVGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 17:06:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62511 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751266AbcEPVGF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 17:06:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DB4A01C449;
	Mon, 16 May 2016 17:06:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Zmbl
	nFdQQQNKx9hjRrRkZh2ypJM=; b=bnE/ScKeL5E+zTmI2gQ9jFC5PYGfFpm98SFb
	cbRxUF++1ULCdM6PAuLkvaTQ91u0gI1qUgIGzfXtSXVYSip9rbBQZNAg4irCE3Ws
	cX8pxC+qWfGZCHA9RUVhi+WV5j3DQ3XAziO6PSxG/s4w6PCqnIQBeTOxW2EzRiU5
	RgS6xfo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=YejIcg
	peJ/S/cDYb1M1d5OADpX5Q2EJMIglDc+BEhD4juAPL6DCDNIP44A4jZCcyMB+MuS
	IREhGak93gAwlrS/xH3n+KJN1xf4R+EYJLTxwaEGMtSkxT2kJELo+kknMgCPyGUb
	iPc8ICYQcySnYPxRaReuLw0Itz1Dkistod2nQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D43841C448;
	Mon, 16 May 2016 17:06:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 56D321C447;
	Mon, 16 May 2016 17:06:04 -0400 (EDT)
X-Mailer: git-send-email 2.8.2-755-g8847aff
In-Reply-To: <20160516210545.6591-1-gitster@pobox.com>
X-Pobox-Relay-ID: 003BD320-1BAA-11E6-9143-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294792>

The double-loop wants to do an early return immediately when one
matching macro is found.  Eliminate the extra variable 'a' used for
that purpose and rewrite the "assign the found item to 'a' to make
it non-NULL and force the loop(s) to terminate" with a direct return
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
