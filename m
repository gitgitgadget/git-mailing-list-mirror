From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 1/3] push: further clean up fields of "struct ref"
Date: Wed, 23 Jan 2013 13:55:28 -0800
Message-ID: <1358978130-12216-2-git-send-email-gitster@pobox.com>
References: <20130121234002.GE17156@sigill.intra.peff.net>
 <1358978130-12216-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Chris Rorvick <chris@rorvick.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 23 22:56:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty8IZ-0002k4-Vq
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 22:56:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299Ab3AWVzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 16:55:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42305 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752044Ab3AWVzf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 16:55:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C143B7D5;
	Wed, 23 Jan 2013 16:55:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Nr7G
	fJPeXhj6F3vZbym8581ybQY=; b=jhBiXHrMdzFXwGaKPx4a0ORuHCvkD48wN84s
	wYpF+V1gB93GEqJCWuMWpRB1iIE9cOjBfumQ5waMlhH6mcImvzUrKpwL6G9c9nc0
	uRDvSWbnXNvmlm+KLqLBnoToxBgOwwGpd+ZKRnq4qx1nhHIyUU9U1GSmPdF47pAl
	U2GZ2ns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	fjZf92vZxP3xIx4WyPqr3kIjB63OVe6k8e/XCrnQ8oYpj0p1vij3/eCTd5tVFjtt
	OkP5viFzbV7m9y3OkDbC0IvWYGexqWWYFa6sUp1yOjxkLOZz3iaJdX7ywKooOiHF
	9XWkwXrrIKF3Bx+K53gwUkiPgFJdq+DZOFeEp6KgO8U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 921A6B7D4;
	Wed, 23 Jan 2013 16:55:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E55EDB7D0; Wed, 23 Jan 2013
 16:55:33 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.517.g0318d2b
In-Reply-To: <1358978130-12216-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9CD1A4F6-65A7-11E2-828D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214369>

The "nonfastforward" and "update" fields are only used while
deciding what value to assign to the "status" locally in a single
function.  Remove them from the "struct ref".

The "requires_force" field is not used to decide if the proposed
update requires a --force option to succeed, or to record such a
decision made elsewhere.  It is used by status reporting code that
the particular update was "forced".  Rename it to "forced_udpate",
and move the code to assign to it around to further clarify how it
is used and what it is used for.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h     |  4 +---
 remote.c    | 16 ++++++----------
 transport.c |  2 +-
 3 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/cache.h b/cache.h
index a942bbd..12631a1 100644
--- a/cache.h
+++ b/cache.h
@@ -1001,10 +1001,8 @@ struct ref {
 	char *symref;
 	unsigned int
 		force:1,
-		requires_force:1,
+		forced_update:1,
 		merge:1,
-		nonfastforward:1,
-		update:1,
 		deletion:1;
 	enum {
 		REF_STATUS_NONE = 0,
diff --git a/remote.c b/remote.c
index d3a1ca2..3375914 100644
--- a/remote.c
+++ b/remote.c
@@ -1317,27 +1317,23 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		 *     passing the --force argument
 		 */
 
-		ref->update =
-			!ref->deletion &&
-			!is_null_sha1(ref->old_sha1);
-
-		if (ref->update) {
-			ref->nonfastforward =
+		if (!ref->deletion && !is_null_sha1(ref->old_sha1)) {
+			int nonfastforward =
 				!has_sha1_file(ref->old_sha1)
-				  || !ref_newer(ref->new_sha1, ref->old_sha1);
+				|| !ref_newer(ref->new_sha1, ref->old_sha1);
 
 			if (!prefixcmp(ref->name, "refs/tags/")) {
-				ref->requires_force = 1;
 				if (!force_ref_update) {
 					ref->status = REF_STATUS_REJECT_ALREADY_EXISTS;
 					continue;
 				}
-			} else if (ref->nonfastforward) {
-				ref->requires_force = 1;
+				ref->forced_update = 1;
+			} else if (nonfastforward) {
 				if (!force_ref_update) {
 					ref->status = REF_STATUS_REJECT_NONFASTFORWARD;
 					continue;
 				}
+				ref->forced_update = 1;
 			}
 		}
 	}
diff --git a/transport.c b/transport.c
index 2673d27..585ebcd 100644
--- a/transport.c
+++ b/transport.c
@@ -659,7 +659,7 @@ static void print_ok_ref_status(struct ref *ref, int porcelain)
 		const char *msg;
 
 		strcpy(quickref, status_abbrev(ref->old_sha1));
-		if (ref->requires_force) {
+		if (ref->forced_update) {
 			strcat(quickref, "...");
 			type = '+';
 			msg = "forced update";
-- 
1.8.1.1.517.g0318d2b
