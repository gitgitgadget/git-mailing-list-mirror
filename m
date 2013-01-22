From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/3] push: further clean up fields of "struct ref"
Date: Mon, 21 Jan 2013 22:30:28 -0800
Message-ID: <1358836230-9197-2-git-send-email-gitster@pobox.com>
References: <20130121234002.GE17156@sigill.intra.peff.net>
 <1358836230-9197-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Chris Rorvick <chris@rorvick.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 22 07:30:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxXNp-00026J-AJ
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 07:30:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680Ab3AVGag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 01:30:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40685 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750889Ab3AVGaf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 01:30:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00D6568F8;
	Tue, 22 Jan 2013 01:30:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=7ilU
	2Uy26MRV28kqifqLaEznmLk=; b=CzgInj4iglu2TlJQtVHqLl9nnIxhjMVXfEBG
	GVjZrJPKPyT6VRuo8v7PBsh6NLCjwRp1/DXNpP5XbZMFvvaK5xKwA7c+PPgwAEUs
	aUw5XF1jUVD5gaPmMO3RKF/U2x6b0FUnCI8OkR2qkQaG9UUVm6vJw6+pF6UB+4/h
	WuaXaZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	jKt4XmvErXzs/E2J9gazxqD73/v3/OEqV0qXQvJYGfk+8YkZQ+LdAXFVb164fbJ4
	ZGzEuwV9ub6ogUkM0owOHYovxMYp0vRB2LC3XSp/DRDG6eR7BC0QYFslY9G0KRf2
	pHoYWrb8BkmtlcVo3ReoML07bJRnisUSohRykBH4UWA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB1D568F7;
	Tue, 22 Jan 2013 01:30:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31A4168F5; Tue, 22 Jan 2013
 01:30:34 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.498.gfdee8be
In-Reply-To: <1358836230-9197-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 39FC37EC-645D-11E2-A853-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214202>

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

 * The "update" removal in v1 has been moved to this.

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
1.8.1.1.498.gfdee8be
