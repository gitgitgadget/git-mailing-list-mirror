From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 10/25] get_sha1(): fix error status regression
Date: Tue,  3 Jul 2012 14:37:00 -0700
Message-ID: <1341351435-31011-11-git-send-email-gitster@pobox.com>
References: <1341351435-31011-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 23:39:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmAoP-0006e0-KU
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 23:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756624Ab2GCViO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 17:38:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34987 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756525Ab2GCVhi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 17:37:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B38BE8653
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=DljM
	hTAqupi5cMOoniFrULx5c1I=; b=qZoxUHcguDqaUqZAFJK5bwidJo6EBE+vwYSk
	oRq8AOy5TyDNO4T+74W171eB9yi7j8SgHwI4sXHmZdt8eOAzicIoTF21XBGTmlt7
	vdewijsYLM86YIWqRoEAWSTl6PtD1v6hexRi2oy8/WDOHw0WPjMmOlmNLfY2r2XI
	vHx0Z2A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=EaAqyT
	16k5ulXAh9WY8wLUEAwmW8K5cy8oii2uBnSdiUm+rpZcJLBb6s7WMzGzcbxAtzOY
	9rO6OIKsClXLf1BoCTpzU4p9kQlTaH9GCwK911TgAW4tQuKaUbK/rpL8R38f5vJO
	99KodPi5/tvkIvCCDZNtTv4dDFQStuXcUoYnI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB2448652
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BAE338651 for
 <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:36 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.229.g706c98f
In-Reply-To: <1341351435-31011-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4E814DCE-C557-11E1-A359-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200963>

In finish_object_disambiguation(), if the candidate hasn't been
checked, there are two cases:

 - It is the first and only object that match the prefix; or
 - It replaced another object that matched the prefix but that
   object did not satisfy ds->fn() callback.

And the former case we set ds->candidate_ok to true without doing
anything else, while for the latter we check the candidate, which
may set ds->candidate_ok to false.

At this point in the code, ds->candidate_ok can be false only if
this last-round check found that the candidate does not pass the
check, because the state after update_candidates() returns cannot
satisfy

    !ds->ambiguous && ds->candidate_exists && ds->candidate_checked

and !ds->canidate_ok at the same time.

Hence, when we execute this "return", we know we have seen more than
one object that match the prefix (and none of them satisfied ds->fn),
meaning that we should say "the short name is ambiguous", not "there
is no object that matches the prefix".

Noticed by Jeff King.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1_name.c b/sha1_name.c
index 2e2dbb8..c824bdd 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -212,7 +212,7 @@ static int finish_object_disambiguation(struct disambiguate_state *ds,
 				    ds->fn(ds->candidate, ds->cb_data));
 
 	if (!ds->candidate_ok)
-		return SHORT_NAME_NOT_FOUND;
+		return SHORT_NAME_AMBIGUOUS;
 
 	hashcpy(sha1, ds->candidate);
 	return 0;
-- 
1.7.11.1.229.g706c98f
