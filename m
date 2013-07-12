From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] mailmap: do not lose single-letter names
Date: Fri, 12 Jul 2013 14:38:52 -0700
Message-ID: <1373665135-32484-2-git-send-email-gitster@pobox.com>
References: <1373665135-32484-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 23:39:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxl3e-0003aP-65
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 23:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965475Ab3GLVjD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 17:39:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46384 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965441Ab3GLVi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 17:38:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81E253031C
	for <git@vger.kernel.org>; Fri, 12 Jul 2013 21:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=XlN3
	YYkFRsAhNlqkN/2IjJ93JNE=; b=YB2ov2WSyYdPPolvgsU5i7gmLQQiGWazX1bb
	3LZJIzo5pyFpXzn5gk92pFUavBHswzyRXvpPPOCgPRx/IB1GbkOOJTm6DAYHTBrw
	eL1oIrvq9kuSNaEDFIY8liZZNM6r6Vswpl1u+04irz/WTZNwcb4Rzaf5X8SMSpXf
	9wleP1E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=iIBKtP
	ySwN3W+AI17VzvNicJqtlsoEyETdp+OJTPLPGDlyVaAz8o6igxv8lrqKgOPebeTM
	B/iq8lrbDRR0ve8dM46peapkiEUvHnoc8kSxdDEUc+Et+BMUNa/B4UehmE3uWSuI
	uhqzp/V0wd51yLN0j6xEQrmZ0fub8Zaf/eyNE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 741373031B
	for <git@vger.kernel.org>; Fri, 12 Jul 2013 21:38:59 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE83630319
	for <git@vger.kernel.org>; Fri, 12 Jul 2013 21:38:58 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2-941-gda9c3c8
In-Reply-To: <1373665135-32484-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 75EBF214-EB3B-11E2-B2EF-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230259>

In parse_name_and_email() function, there is this line:

	*name = (nstart < nend ? nstart : NULL);

When the function is given a buffer "A <A@example.org> <old@x.z>",
nstart scans from the beginning of the buffer, skipping whitespaces
(there isn't any, so nstart points at the buffer), while nend starts
from one byte before the first '<' and skips whitespaces backwards
and stops at the first non-whitespace (i.e. it hits "A" at the
beginning of the buffer).  nstart == nend in this case for a
single-letter name, and an off-by-one error makes it fail to pick up
the name, which makes the entry equivalent to

	<A@example.org> <old@x.z>

without the name.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 mailmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mailmap.c b/mailmap.c
index 2a7b366..418081e 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -122,7 +122,7 @@ static char *parse_name_and_email(char *buffer, char **name,
 	while (nend > nstart && isspace(*nend))
 		--nend;
 
-	*name = (nstart < nend ? nstart : NULL);
+	*name = (nstart <= nend ? nstart : NULL);
 	*email = left+1;
 	*(nend+1) = '\0';
 	*right++ = '\0';
-- 
1.8.3.2-941-gda9c3c8
