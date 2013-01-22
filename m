From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] push: further clean up fields of "struct ref"
Date: Mon, 21 Jan 2013 21:53:45 -0800
Message-ID: <1358834027-32039-2-git-send-email-gitster@pobox.com>
References: <20130121234002.GE17156@sigill.intra.peff.net>
 <1358834027-32039-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Chris Rorvick <chris@rorvick.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 22 06:54:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxWoG-0003Ym-W3
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 06:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030Ab3AVFxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 00:53:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53888 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752817Ab3AVFxw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 00:53:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F31C872C4;
	Tue, 22 Jan 2013 00:53:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=X2al
	AXu+d8MDZqq0us51NDQlDM4=; b=A7QGCMd4cKK/KN81t91I4ThKa94h7IQhpiQe
	R2J0hClDsEErubhyKORrWvsPtumG/hdz2ukuXYfRvIf5aSI9ktFSL9shQGW4ZmxP
	EFvUOSrC/hJhb38A24rsumUaeWdbv6EM+/bwC4PZLqYRT24HWvRmGjzp0oadSDLa
	WZrsU5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	BBvZPh3gcnfdJQI9Vi7J41phuTeWPHo7NA9dP7q1JpBz3jKpg8DeWL6HTdfyvQuW
	ZS7vAcqD8gjoMFQToPyvI94DSoz/sTW0Digy/mJJbB/uRyIlZ46vTjdacwp1Rf6i
	/li9/I6WuTXAccM5sii9E74/YDrjekoCzPO0A72rmaE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E81F272C3;
	Tue, 22 Jan 2013 00:53:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4982D72C1; Tue, 22 Jan 2013
 00:53:51 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.498.gfdee8be
In-Reply-To: <1358834027-32039-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 18F3FD64-6458-11E2-9666-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214195>

The "nonfastforward" field is only used to decide what value to
assign to the "status" locally in a single function.  Remove it from
the "struct ref" and make it into a local variable.

The "requires_force" field is not used to decide if the proposed
update requires a --force option to succeed, or to record such a
decision made elsewhere.  It is used by status reporting code that
the particular update was "forced".  Rename it to "forced_udpate",
and move the code to assign to it around to further clarify how it
is used and what it is used for.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h     |  3 +--
 remote.c    | 10 +++++-----
 transport.c |  2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index a942bbd..baa47b4 100644
--- a/cache.h
+++ b/cache.h
@@ -1001,9 +1001,8 @@ struct ref {
 	char *symref;
 	unsigned int
 		force:1,
-		requires_force:1,
+		forced_update:1,
 		merge:1,
-		nonfastforward:1,
 		update:1,
 		deletion:1;
 	enum {
diff --git a/remote.c b/remote.c
index d3a1ca2..875296c 100644
--- a/remote.c
+++ b/remote.c
@@ -1322,22 +1322,22 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 			!is_null_sha1(ref->old_sha1);
 
 		if (ref->update) {
-			ref->nonfastforward =
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
