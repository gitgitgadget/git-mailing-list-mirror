From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] diffcore-pickaxe: fix leaks in "log -S<block>" and "log
 -G<pattern>"
Date: Thu,  4 Apr 2013 21:45:25 -0700
Message-ID: <1365137126-21659-2-git-send-email-gitster@pobox.com>
References: <7v1uapfuyp.fsf@alter.siamese.dyndns.org>
 <1365137126-21659-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 05 06:46:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNyXM-0007d0-Pg
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 06:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161079Ab3DEEpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 00:45:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33777 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190Ab3DEEpa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 00:45:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12CBF11B4B
	for <git@vger.kernel.org>; Fri,  5 Apr 2013 04:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=wp4+
	vOtEyxx22GAOxQWb3ZEF+bA=; b=BI0LlHIBhOFPKRkRfZLxaA8kqF7f5Sdchisi
	/dPK/IbMqKsLWZyLayxXcmyydCqNP4Biq4jHcsDSRGuPDJCXEhDa1eoav0nl1RiL
	+IFQpIhB3jarKy4OkhCZKhjA1Tb8tNP5wE8q4YYwNjGf5Vb5hXPOL0NRcm2SoG1K
	/kqOj5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=s8TA88
	IZoKfoJcodvFyKTsmPjMpIwdRCc7zsupuThAg3bLw3Amm5wZ61/xhOnPkQI9FVv1
	pRURtjdM+gsEuXB4Fiwzr5JsYxc5T/kj4TxF/0DyO8ZwcEVGqWQHught1iNLDSIF
	qDIcrog5ttSq7I+dupW/cgsgMf7sO10nwyLHo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A88011B4A
	for <git@vger.kernel.org>; Fri,  5 Apr 2013 04:45:30 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9278A11B47 for
 <git@vger.kernel.org>; Fri,  5 Apr 2013 04:45:29 +0000 (UTC)
X-Mailer: git-send-email 1.8.2-588-gbf1c992
In-Reply-To: <1365137126-21659-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A44E2C18-9DAB-11E2-B412-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220139>

The diff_grep() and has_changes() functions had early return
codepaths for unmerged filepairs, which simply returned 0.  When we
taught textconv filter to them, one was ignored and continued to
return early without freeing the result filtered by textconv, and
the other had a failed attempt to fix, which allowed the planned
return value 0 to be overwritten by a bogus call to contains().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diffcore-pickaxe.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index bfaabab..cadb071 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -99,9 +99,10 @@ static int diff_grep(struct diff_filepair *p, struct diff_options *o,
 
 	if (!DIFF_FILE_VALID(p->one)) {
 		if (!DIFF_FILE_VALID(p->two))
-			return 0; /* ignore unmerged */
-		/* created "two" -- does it have what we are looking for? */
-		hit = !regexec(regexp, mf2.ptr, 1, &regmatch, 0);
+			hit = 0; /* ignore unmerged */
+		else
+			/* created "two" -- does it have what we are looking for? */
+			hit = !regexec(regexp, mf2.ptr, 1, &regmatch, 0);
 	} else if (!DIFF_FILE_VALID(p->two)) {
 		/* removed "one" -- did it have what we are looking for? */
 		hit = !regexec(regexp, mf1.ptr, 1, &regmatch, 0);
@@ -229,8 +230,9 @@ static int has_changes(struct diff_filepair *p, struct diff_options *o,
 	if (!DIFF_FILE_VALID(p->one)) {
 		if (!DIFF_FILE_VALID(p->two))
 			ret = 0; /* ignore unmerged */
-		/* created */
-		ret = contains(&mf2, o, regexp, kws) != 0;
+		else
+			/* created */
+			ret = contains(&mf2, o, regexp, kws) != 0;
 	}
 	else if (!DIFF_FILE_VALID(p->two)) /* removed */
 		ret = contains(&mf1, o, regexp, kws) != 0;
-- 
1.8.2-588-gbf1c992
