From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 05/23] send-pack: move REF_STATUS_REJECT_NODELETE logic a bit higher
Date: Mon, 15 Sep 2014 15:24:06 -0700
Message-ID: <1410819864-22967-6-git-send-email-gitster@pobox.com>
References: <1410819864-22967-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 16 00:24:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTehS-0006GD-Bq
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 00:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758709AbaIOWYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 18:24:44 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60469 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755224AbaIOWYh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 18:24:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C8B073B184;
	Mon, 15 Sep 2014 18:24:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=HKDn
	DJofrDQLdCSIWwDky8wnvRA=; b=mega1FO6VPIm02Sga++okpnQZ01OLLa1hVbv
	ljZY+t3eZeBbCnfe4PrEPCqPbC8fv7TPfE5ou1puWb7ttJ1wornb23iAS5hzfM6M
	0DbWQJr9NYW/DWeLVq1bA1uoJMVADFUXZ0ICPPhzPBqOxFUPW54dkKrAHDFC6+GP
	pdT5yEY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=vBKYH3
	trUWUQDJqNLR1dLsH/vqYSmbI2qFUyJ850S90F7z9Nquz9szv6S4wvwZOstwe4DK
	oG0M64fr2cmhLhnfimN4X4EFjClDh35DjD7YvWYMeuWUboi0FOxVra4AgnEh10vB
	G6qur9Bc9L3ytkmlmG90lvRjoWhzM4dLuyoJo=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BE5633B183;
	Mon, 15 Sep 2014 18:24:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 20F703B182;
	Mon, 15 Sep 2014 18:24:36 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-420-g23b5121
In-Reply-To: <1410819864-22967-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1319B344-3D27-11E4-84A7-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257090>

20e8b465 (refactor ref status logic for pushing, 2010-01-08)
restructured the code to set status for each ref to be pushed, but
did not quite go far enough.  We inspect the status set earlier by
set_refs_status_for_push() and then perform yet another update to
the status of a ref with an otherwise OK status to be deleted to
mark it with REF_STATUS_REJECT_NODELETE when the protocol tells us
never to delete.

Split the latter into a separate loop that comes before we enter the
per-ref loop.  This way we would have one less condition to check in
the main loop.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 send-pack.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 6129b0f..22a1709 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -231,6 +231,15 @@ int send_pack(struct send_pack_args *args,
 		return 0;
 	}
 
+	/*
+	 * NEEDSWORK: why does delete-refs have to be so specific to
+	 * send-pack machinery that set_ref_status_for_push() cannot
+	 * set this bit for us???
+	 */
+	for (ref = remote_refs; ref; ref = ref->next)
+		if (ref->deletion && !allow_deleting_refs)
+			ref->status = REF_STATUS_REJECT_NODELETE;
+
 	if (!args->dry_run)
 		advertise_shallow_grafts_buf(&req_buf);
 
@@ -249,17 +258,13 @@ int send_pack(struct send_pack_args *args,
 		case REF_STATUS_REJECT_FETCH_FIRST:
 		case REF_STATUS_REJECT_NEEDS_FORCE:
 		case REF_STATUS_REJECT_STALE:
+		case REF_STATUS_REJECT_NODELETE:
 		case REF_STATUS_UPTODATE:
 			continue;
 		default:
 			; /* do nothing */
 		}
 
-		if (ref->deletion && !allow_deleting_refs) {
-			ref->status = REF_STATUS_REJECT_NODELETE;
-			continue;
-		}
-
 		if (!ref->deletion)
 			new_refs++;
 
-- 
2.1.0-410-gd72dacd
