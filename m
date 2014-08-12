From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] send-pack: move REF_STATUS_REJECT_NODELETE logic a bit higher
Date: Tue, 12 Aug 2014 15:13:27 -0700
Message-ID: <xmqqr40l4arc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 00:13:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHKK6-00025a-19
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 00:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000AbaHLWNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2014 18:13:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55284 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788AbaHLWNh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2014 18:13:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 721F931C7E;
	Tue, 12 Aug 2014 18:13:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=6
	eL0UDDKiGUFzaNzvGeFXkptpNU=; b=BFs1vCvoy/TJaqnwHNtH/gWf08xYY0xsR
	Au1rSvu+gSeCqBhQGFPiu8IvNa3sqfCHxWGhbqMvup+5MH8RU0LfpR2Mu6Swmx/C
	nSxyItBK/gth2/27dNx/5Fz884l9DvoLOiJuQ9AXwRNjQCqW86IY9aJDNflcp6ZN
	GHeiFb1R70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=nj6
	V3UWucn7qFzOGNqsCxJAyAq6BnTR5C9V8wF9Cy3nFywbF/1pjuQkXWaGtV09uHjU
	kpjhGVqk53vhxGPfv6bHnpqTuVWXWdixzNwEzi/FvdiDQk9ftRC4q7A+QsjM5voZ
	3lvYPSaRdqhS2eScLeW17DK47Zd65p/pqZ5OwoI4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6902D31C7D;
	Tue, 12 Aug 2014 18:13:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 471AB31C74;
	Tue, 12 Aug 2014 18:13:29 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E396100A-226D-11E4-9255-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255172>

This is more of an RFH than a PATCH.  I think we would want to
encapsulate the logic to set STATUS_REJECT_NODELETE in
set_ref_status_for_push() function, but I do not see a good code
structure to do so, given the constraints of the dataflow (i.e. the
protocol capability is only inspected here with server_supports()).

The motivation behind this patch is that I want to move the "Among
refs on remote_refs list, these are not going to be updated on the
remote end" logic into a separate helper function in the next step
and call that before we enter in this per-ref main loop.

-- >8 --
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
 send-pack.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 6129b0f..51497c3 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -231,6 +231,14 @@ int send_pack(struct send_pack_args *args,
 		return 0;
 	}
 
+	/*
+	 * Why is delete-refs so specific to send-pack machinery
+	 * that set_ref_status_for_push() cannot set this bit for us???
+	 */
+	for (ref = remote_refs; ref; ref = ref->next)
+		if (ref->deletion && !allow_deleting_refs)
+			ref->status = REF_STATUS_REJECT_NODELETE;
+
 	if (!args->dry_run)
 		advertise_shallow_grafts_buf(&req_buf);
 
@@ -249,17 +257,13 @@ int send_pack(struct send_pack_args *args,
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
2.1.0-rc2-243-g9c8a734
