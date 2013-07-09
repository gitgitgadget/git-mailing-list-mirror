From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/7] push: beginning of compare-and-swap "force/delete safety"
Date: Tue,  9 Jul 2013 12:53:26 -0700
Message-ID: <1373399610-8588-4-git-send-email-gitster@pobox.com>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
 <1373399610-8588-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 09 21:53:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwdz1-00068J-1l
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 21:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753131Ab3GITxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 15:53:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46315 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753067Ab3GITxi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 15:53:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D54A2F3C5
	for <git@vger.kernel.org>; Tue,  9 Jul 2013 19:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=a9Cw
	zeJpxvhLLwQZFhwoL+2HP/o=; b=mS3i2xL62xvsEjFwY0AUgPDfNF1JTGyNDDGQ
	LvUDVpmQfHLmkWOyJc7lrxuiy+fSqGpCYFhK2aKm96D0s+TQYToUXHuAXxUEM7la
	67dnxCe1VcgJOrCx4MQB2fzWYEF2D8KvgT+4ILqTp6YVgnQvz1bYXFbc4zdNHblL
	NXzlIyw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=RKhNYL
	hQ2k1gQD4ROb8oOQutjlYClZA926KedcmEO3bsm5O1zUg5zHFTHA3w0SC7MWtDjf
	aIKqsWVOkWmDWLo1xHgv1YmpEDNdUTNRRTvcO99DAwSlXhSUtiEJhsL2WSEMB5wD
	XYQuFK0/IYLirje8E/xo1s8+e28itrm3MelOE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6532B2F3C4
	for <git@vger.kernel.org>; Tue,  9 Jul 2013 19:53:38 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 90C052F3C3
	for <git@vger.kernel.org>; Tue,  9 Jul 2013 19:53:37 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2-875-g76c723c
In-Reply-To: <1373399610-8588-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 3EEC4B04-E8D1-11E2-8F83-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229991>

This teaches the deepest part of the callchain for "git push" (and
"git send-pack") to optionally allow "the old value of the ref must
be this, otherwise fail this push" we discussed earlier.

Nobody sets the new "expect_old_sha1" and "expect_old_no_trackback"
bitfields yet, so this is still a no-op.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/send-pack.c |  5 +++++
 remote.c            | 21 +++++++++++++++++++--
 remote.h            |  4 ++++
 send-pack.c         |  1 +
 transport-helper.c  |  6 ++++++
 transport.c         |  5 +++++
 6 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index e86d3b5..c86c556 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -55,6 +55,11 @@ static void print_helper_status(struct ref *ref)
 			msg = "needs force";
 			break;
 
+		case REF_STATUS_REJECT_STALE:
+			res = "error";
+			msg = "stale info";
+			break;
+
 		case REF_STATUS_REJECT_ALREADY_EXISTS:
 			res = "error";
 			msg = "already exists";
diff --git a/remote.c b/remote.c
index b1ff7a2..81bc876 100644
--- a/remote.c
+++ b/remote.c
@@ -1416,13 +1416,30 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		}
 
 		/*
+		 * If we know what the old value of the remote ref
+		 * should be, reject any push, even forced ones,
+		 * if they do not match.
+		 *
+		 * It also is an error if the user told us to check
+		 * with the remote-tracking branch to find the value
+		 * to expect, but we did not have such a tracking
+		 * branch.
+		 */
+		if (ref->expect_old_sha1 &&
+		    (ref->expect_old_no_trackback ||
+		     hashcmp(ref->old_sha1, ref->old_sha1_expect))) {
+			ref->status = REF_STATUS_REJECT_STALE;
+			continue;
+		}
+
+		/*
 		 * Decide whether an individual refspec A:B can be
 		 * pushed.  The push will succeed if any of the
 		 * following are true:
 		 *
-		 * (1) the remote reference B does not exist
+		 * (1) the remote reference B does not exist (i.e. create)
 		 *
-		 * (2) the remote reference B is being removed (i.e.,
+		 * (2) the remote reference B is being removed (i.e. delete;
 		 *     pushing :B where no source is specified)
 		 *
 		 * (3) the destination is not under refs/tags/, and
diff --git a/remote.h b/remote.h
index a850059..7ad37e6 100644
--- a/remote.h
+++ b/remote.h
@@ -75,10 +75,13 @@ struct ref {
 	struct ref *next;
 	unsigned char old_sha1[20];
 	unsigned char new_sha1[20];
+	unsigned char old_sha1_expect[20]; /* used by expect-old */
 	char *symref;
 	unsigned int
 		force:1,
 		forced_update:1,
+		expect_old_sha1:1,
+		expect_old_no_trackback:1,
 		deletion:1,
 		matched:1;
 
@@ -102,6 +105,7 @@ struct ref {
 		REF_STATUS_REJECT_NODELETE,
 		REF_STATUS_REJECT_FETCH_FIRST,
 		REF_STATUS_REJECT_NEEDS_FORCE,
+		REF_STATUS_REJECT_STALE,
 		REF_STATUS_UPTODATE,
 		REF_STATUS_REMOTE_REJECT,
 		REF_STATUS_EXPECTING_REPORT
diff --git a/send-pack.c b/send-pack.c
index 9a9908c..b228d65 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -227,6 +227,7 @@ int send_pack(struct send_pack_args *args,
 		case REF_STATUS_REJECT_ALREADY_EXISTS:
 		case REF_STATUS_REJECT_FETCH_FIRST:
 		case REF_STATUS_REJECT_NEEDS_FORCE:
+		case REF_STATUS_REJECT_STALE:
 		case REF_STATUS_UPTODATE:
 			continue;
 		default:
diff --git a/transport-helper.c b/transport-helper.c
index db9bd18..95d22f8 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -683,6 +683,11 @@ static int push_update_ref_status(struct strbuf *buf,
 			free(msg);
 			msg = NULL;
 		}
+		else if (!strcmp(msg, "stale info")) {
+			status = REF_STATUS_REJECT_STALE;
+			free(msg);
+			msg = NULL;
+		}
 	}
 
 	if (*ref)
@@ -756,6 +761,7 @@ static int push_refs_with_push(struct transport *transport,
 		/* Check for statuses set by set_ref_status_for_push() */
 		switch (ref->status) {
 		case REF_STATUS_REJECT_NONFASTFORWARD:
+		case REF_STATUS_REJECT_STALE:
 		case REF_STATUS_REJECT_ALREADY_EXISTS:
 		case REF_STATUS_UPTODATE:
 			continue;
diff --git a/transport.c b/transport.c
index b84dbf0..98f5270 100644
--- a/transport.c
+++ b/transport.c
@@ -709,6 +709,10 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count, i
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
 						 "needs force", porcelain);
 		break;
+	case REF_STATUS_REJECT_STALE:
+		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
+						 "stale info", porcelain);
+		break;
 	case REF_STATUS_REMOTE_REJECT:
 		print_ref_status('!', "[remote rejected]", ref,
 						 ref->deletion ? NULL : ref->peer_ref,
@@ -1078,6 +1082,7 @@ static int run_pre_push_hook(struct transport *transport,
 	for (r = remote_refs; r; r = r->next) {
 		if (!r->peer_ref) continue;
 		if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) continue;
+		if (r->status == REF_STATUS_REJECT_STALE) continue;
 		if (r->status == REF_STATUS_UPTODATE) continue;
 
 		strbuf_reset(&buf);
-- 
1.8.3.2-875-g76c723c
