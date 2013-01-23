From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 2/3] push: further simplify the logic to assign rejection
 reason
Date: Wed, 23 Jan 2013 13:55:29 -0800
Message-ID: <1358978130-12216-3-git-send-email-gitster@pobox.com>
References: <20130121234002.GE17156@sigill.intra.peff.net>
 <1358978130-12216-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Chris Rorvick <chris@rorvick.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 23 22:56:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty8Ib-0002k4-0C
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 22:56:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752455Ab3AWVzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 16:55:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42321 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752325Ab3AWVzh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 16:55:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE2D9B7D9;
	Wed, 23 Jan 2013 16:55:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=kjE6
	xxZzrnWJ5JmiTiuW4cdhILQ=; b=c/omDA6x/4Rr+qqUGxtdsqtyM7htvNxhomsH
	oJZpvR2DMvSNYGEjSoTZD8hfGIb7Y8BCh/Yw84A6LuJlPikwMjEf04xUJJKhCtMh
	85/pprqmPOxVc8MpzshJmDYNeZMd8pZN+GcEcldcMvBCmsv4qOFMU4d5IjW8BIot
	ru7Q0uY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	bmhTs5sXTbyLw2NJKEtSmiukErXNZ+wl/1AA/ghBk/bHcdAx7/POl6jkpbiw9qFD
	82uBRkEaILQUhKzNOSA0qvioj/fPZBsUZlfk4mkQOXdpFDOszX7GuYYAFlk/Ogll
	Q/S/WjuzYTbCfmONyXYur7rH4xK1Bx0SyenkjoZfFM4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3E23B7D8;
	Wed, 23 Jan 2013 16:55:36 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB0CFB7D6; Wed, 23 Jan 2013
 16:55:35 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.517.g0318d2b
In-Reply-To: <1358978130-12216-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9E065B3C-65A7-11E2-B641-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214370>

First compute the reason why this push would fail if done without
"--force", and then fail it by assigning that reason when the push
was not forced (or if there is no reason to require force, allow it
to succeed).

Record the fact that the push was forced in the forced_update field
only when the push would have failed without the option.

The code becomes shorter, less repetitive and easier to read this
way, especially given that the set of rejection reasons will be
extended in a later patch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/remote.c b/remote.c
index 3375914..969aa11 100644
--- a/remote.c
+++ b/remote.c
@@ -1318,23 +1318,18 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		 */
 
 		if (!ref->deletion && !is_null_sha1(ref->old_sha1)) {
-			int nonfastforward =
-				!has_sha1_file(ref->old_sha1)
-				|| !ref_newer(ref->new_sha1, ref->old_sha1);
-
-			if (!prefixcmp(ref->name, "refs/tags/")) {
-				if (!force_ref_update) {
-					ref->status = REF_STATUS_REJECT_ALREADY_EXISTS;
-					continue;
-				}
-				ref->forced_update = 1;
-			} else if (nonfastforward) {
-				if (!force_ref_update) {
-					ref->status = REF_STATUS_REJECT_NONFASTFORWARD;
-					continue;
-				}
+			int why = 0; /* why would this push require --force? */
+
+			if (!prefixcmp(ref->name, "refs/tags/"))
+				why = REF_STATUS_REJECT_ALREADY_EXISTS;
+			else if (!has_sha1_file(ref->old_sha1)
+				 || !ref_newer(ref->new_sha1, ref->old_sha1))
+				why = REF_STATUS_REJECT_NONFASTFORWARD;
+
+			if (!force_ref_update)
+				ref->status = why;
+			else if (why)
 				ref->forced_update = 1;
-			}
 		}
 	}
 }
-- 
1.8.1.1.517.g0318d2b
