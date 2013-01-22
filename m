From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] push: further reduce "struct ref" and simplify the logic
Date: Mon, 21 Jan 2013 21:53:47 -0800
Message-ID: <1358834027-32039-4-git-send-email-gitster@pobox.com>
References: <20130121234002.GE17156@sigill.intra.peff.net>
 <1358834027-32039-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Chris Rorvick <chris@rorvick.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 22 06:54:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxWoR-0003dd-Gl
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 06:54:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239Ab3AVFx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 00:53:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53952 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753235Ab3AVFx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 00:53:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76A7472CB;
	Tue, 22 Jan 2013 00:53:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=yhdx
	o9QET/rnFq3g9K3Va5RriP4=; b=tMAeDEtPaqvPPcVSiFHG4ouXiHYElYarra7X
	dZNk1GW4hvThWFs8eh0PnieDqqRv5B+x1edRMvnHFdqoAxO4KJCPheLHF7H6k4lk
	XyuMmppFehvpHtXIVLJzbAdKbznJJOFBhO+D5kSfmlOkoU+UcULWv4r1npTNJkAH
	MnTI2FY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	pkO0TYyadCznPt5G+e4YMqjYmsljjNkJROjU9+u94GRmJNzngWqhzHa3LbVzg4DB
	5HVQKoaJaB7Erygu9eYKWbzMgIP7cnMDtRhQxBbw0q2XJTdrTcoQBihWZkyYnlHd
	K/RZcZbL0A7qp3C3VJJOfOrHAuj2bOTz5PRI8AHm/Z4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BF2472CA;
	Tue, 22 Jan 2013 00:53:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D509172C9; Tue, 22 Jan 2013
 00:53:55 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.498.gfdee8be
In-Reply-To: <1358834027-32039-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1BAD8502-6458-11E2-8BB2-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214197>

The "update" field in "struct ref" is only used in a very narrow
scope in a single function.  Remove it.

Also simplify the code that rejects an attempted push by first
checking if the proposed update is forced (in which case we do not
need any check on our end).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h  |  1 -
 remote.c | 42 +++++++++++++-----------------------------
 2 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/cache.h b/cache.h
index 360bba5..377a3df 100644
--- a/cache.h
+++ b/cache.h
@@ -1003,7 +1003,6 @@ struct ref {
 		force:1,
 		forced_update:1,
 		merge:1,
-		update:1,
 		deletion:1;
 	enum {
 		REF_STATUS_NONE = 0,
diff --git a/remote.c b/remote.c
index 689dcf7..248910f 100644
--- a/remote.c
+++ b/remote.c
@@ -1317,37 +1317,21 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		 *     passing the --force argument
 		 */
 
-		ref->update =
-			!ref->deletion &&
-			!is_null_sha1(ref->old_sha1);
-
-		if (ref->update) {
-			if (!prefixcmp(ref->name, "refs/tags/")) {
-				if (!force_ref_update) {
-					ref->status = REF_STATUS_REJECT_ALREADY_EXISTS;
-					continue;
-				}
-				ref->forced_update = 1;
-			} else if (!has_sha1_file(ref->old_sha1) ||
-				   !lookup_commit_reference_gently(ref->old_sha1, 1)) {
-				if (!force_ref_update) {
-					ref->status = REF_STATUS_REJECT_FETCH_FIRST;
-					continue;
-				}
-				ref->forced_update = 1;
-			} else if (!lookup_commit_reference_gently(ref->new_sha1, 1)) {
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
+		if (!ref->deletion && !is_null_sha1(ref->old_sha1)) {
+			if (force_ref_update) {
 				ref->forced_update = 1;
+				continue;
 			}
+
+			if (!prefixcmp(ref->name, "refs/tags/"))
+				ref->status = REF_STATUS_REJECT_ALREADY_EXISTS;
+			else if (!has_sha1_file(ref->old_sha1) ||
+				 !lookup_commit_reference_gently(ref->old_sha1, 1))
+				ref->status = REF_STATUS_REJECT_FETCH_FIRST;
+			else if (!lookup_commit_reference_gently(ref->new_sha1, 1))
+				ref->status = REF_STATUS_REJECT_NEEDS_FORCE;
+			else if (!ref_newer(ref->new_sha1, ref->old_sha1))
+				ref->status = REF_STATUS_REJECT_NONFASTFORWARD;
 		}
 	}
 }
-- 
1.8.1.1.498.gfdee8be
