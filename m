From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] push: further simplify the logic to assign rejection
 status
Date: Mon, 21 Jan 2013 22:30:30 -0800
Message-ID: <1358836230-9197-4-git-send-email-gitster@pobox.com>
References: <20130121234002.GE17156@sigill.intra.peff.net>
 <1358836230-9197-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Chris Rorvick <chris@rorvick.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 22 07:31:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxXO0-0002C0-RA
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 07:31:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752496Ab3AVGan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 01:30:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40735 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752174Ab3AVGak (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 01:30:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5679868FF;
	Tue, 22 Jan 2013 01:30:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=8CNt
	JC7jm4BhujggTw+kWN3dH+I=; b=Tqd4ztXdp5dTljFZGZOWSNux/8xvEmEYvfD8
	kEyVPYKc+Rn7ol4YwFUdsRi4II6980EWg1yinPZ6kIQvaqW/NOfKW2P0aIjC7QA6
	eJV2SQvuXGEk1DydJl3yRndlOYlO5HOSNKDfDTVblXYYYwJTIX269Tp1y1f7gAep
	Kjgq0cg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	k1+6YdEFD6FXCShSKBl9z4h3aiqqpU5WDxEpYBZVjcZzsVKgfm/X7g+9Zyb4NASU
	Al/1iM33geOZbNW8n/y0NaQBH2/dnrv83X6FtEL8QHbGlTD0ixYjrhkoDx1gydrj
	wY9zDf8hdE/GybXBFXIqUqOwmQGlA6CYPbdCTM3oIrs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C2F668FE;
	Tue, 22 Jan 2013 01:30:39 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B647468FD; Tue, 22 Jan 2013
 01:30:38 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.498.gfdee8be
In-Reply-To: <1358836230-9197-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 3CB17204-645D-11E2-ADF9-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214204>

Instead of using deeply nested if/else statements, first decide what
rejection status we would get if this push weren't forced, and then
assign the rejection reason to the ref->status field and flip the
ref->forced_update field when we forced a push for a ref that indeed
required forcing.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The first one mistakenly changed the semantics and reported a
   forced push even when the push was done with useless and
   unnecessary --force option (e.g. the update was properly
   fast-forwarding but --force was given from the command line).
   This fixes it.

 remote.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/remote.c b/remote.c
index c991915..af2136d 100644
--- a/remote.c
+++ b/remote.c
@@ -1318,32 +1318,22 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		 */
 
 		if (!ref->deletion && !is_null_sha1(ref->old_sha1)) {
-			if (!prefixcmp(ref->name, "refs/tags/")) {
-				if (!force_ref_update) {
-					ref->status = REF_STATUS_REJECT_ALREADY_EXISTS;
-					continue;
-				}
+			int status = 0;
+
+			if (!prefixcmp(ref->name, "refs/tags/"))
+				status = REF_STATUS_REJECT_ALREADY_EXISTS;
+			else if (!has_sha1_file(ref->old_sha1))
+				status = REF_STATUS_REJECT_FETCH_FIRST;
+			else if (!lookup_commit_reference_gently(ref->old_sha1, 1) ||
+				 !lookup_commit_reference_gently(ref->new_sha1, 1))
+				status = REF_STATUS_REJECT_NEEDS_FORCE;
+			else if (!ref_newer(ref->new_sha1, ref->old_sha1))
+				status = REF_STATUS_REJECT_NONFASTFORWARD;
+
+			if (!force_ref_update)
+				ref->status = status;
+			else if (status)
 				ref->forced_update = 1;
-			} else if (!has_sha1_file(ref->old_sha1)) {
-				if (!force_ref_update) {
-					ref->status = REF_STATUS_REJECT_FETCH_FIRST;
-					continue;
-				}
-				ref->forced_update = 1;
-			} else if (!lookup_commit_reference_gently(ref->old_sha1, 1) ||
-				   !lookup_commit_reference_gently(ref->new_sha1, 1)) {
-				if (!force_ref_update) {
-					ref->status = REF_STATUS_REJECT_NEEDS_FORCE;
-					continue;
-				}
-				ref->forced_update = 1;
-			} else if (!ref_newer(ref->new_sha1, ref->old_sha1)) {
-				if (!force_ref_update) {
-					ref->status = REF_STATUS_REJECT_NONFASTFORWARD;
-					continue;
-				}
-				ref->forced_update = 1;
-			}
 		}
 	}
 }
-- 
1.8.1.1.498.gfdee8be
