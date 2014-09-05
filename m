From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 05/22] send-pack: move REF_STATUS_REJECT_NODELETE logic a bit higher
Date: Fri,  5 Sep 2014 13:54:53 -0700
Message-ID: <1409950510-10209-6-git-send-email-gitster@pobox.com>
References: <1409950510-10209-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 22:55:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQ0Xu-0005bR-32
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 22:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226AbaIEUzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 16:55:32 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50880 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751987AbaIEUz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 16:55:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9E5F43665A;
	Fri,  5 Sep 2014 16:55:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=h4ha
	5jHn5o2psgwUQebxcJkr/DE=; b=ESJpZEUC3LlWV/j1gI0DTmScqGCx/WV1g0xL
	C6TApbUMWMqRqIEYvvvAK1aJm8nKqHl6m7F0zvHD5STahPlLfBERnXL5Ov4arYs1
	eIAJB74GTfJ5l7HRIYMpH5WtbtuFxrbuNH3DZf/chjPna1sz9HqcG0wFjWAYrEux
	rKPHN9U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=pcjhoJ
	cSHTucVmjeQGudjtsTRcpdBf2qRcY2kRxp/vH8NvQcWLEQhqyi7+g4V1bcbIs0OW
	/x3m3Y5lhNqg2FQ9Eh/xemwxIXUh+JmhSDuAQkxwlPyT88HuvJJQht1+mJR9DymY
	9D+CaVSM2Bkw0u7TGfC1/SJONJlABla/rV+V8=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 912FF36658;
	Fri,  5 Sep 2014 16:55:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 953783663D;
	Fri,  5 Sep 2014 16:55:24 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-404-gcacb207
In-Reply-To: <1409950510-10209-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: F5367492-353E-11E4-90F3-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256525>

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
2.1.0-399-g2df620b
