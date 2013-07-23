From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 5/6] push --force-with-lease: tie it all together
Date: Mon, 22 Jul 2013 23:43:19 -0700
Message-ID: <1374561800-938-6-git-send-email-gitster@pobox.com>
References: <1374561800-938-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 23 08:43:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1WK6-0002Yj-GF
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 08:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753954Ab3GWGnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 02:43:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46057 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752620Ab3GWGnd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 02:43:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 454ED24A1E
	for <git@vger.kernel.org>; Tue, 23 Jul 2013 06:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=tN+v
	qB6iuPNR/H/6Bqe3sZMAws4=; b=IeZvT37I8YiQYHeLk1C78CFJQ1CgI0AlHFKv
	y0llZf7WnwugyUz1baN2gKliZdgCsO+4XgLHdhk2VgohysmsA+g8tH8G1gjdoodv
	jb75FkpmQCRvziysATs57kxcJhgMvnQBIggPMR6zSG4tohnED2dK6xTzlr7WU8lN
	btYNq90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=rqNPal
	HczyENOA8bKK7E4OZn4dnHj7F7y2hamJ6VSgdHr22D7k3Xy4Wd+v4sbOexqb+v6X
	MytQc7HYrHCrotAb3nt8ZOnTjSYyf0GA8eNyaySOdBYtPp77AsQ2jpw+AXoi240i
	M0idzyVpNQTwPHwnKv+gkTxH5pl3M4TTMRLzw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3942724A1D
	for <git@vger.kernel.org>; Tue, 23 Jul 2013 06:43:33 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B26F24A19
	for <git@vger.kernel.org>; Tue, 23 Jul 2013 06:43:32 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.4-985-g5661af8
In-Reply-To: <1374561800-938-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 30FE8E66-F363-11E2-AD9F-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231023>

This teaches the deepest part of the callchain for "git push" (and
"git send-pack") to enforce "the old value of the ref must be this,
otherwise fail this push" (aka "compare-and-swap" / "--lockref").

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/send-pack.c |  5 +++++
 remote.c            | 49 ++++++++++++++++++++++++++++++++++++-------------
 remote.h            |  1 +
 send-pack.c         |  1 +
 transport-helper.c  |  6 ++++++
 transport.c         |  5 +++++
 6 files changed, 54 insertions(+), 13 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 6027ead..41dc512 100644
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
index 52e3a12..922822c 100644
--- a/remote.c
+++ b/remote.c
@@ -1396,12 +1396,13 @@ int match_push_refs(struct ref *src, struct ref **dst,
 }
 
 void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
-	int force_update)
+			     int force_update)
 {
 	struct ref *ref;
 
 	for (ref = remote_refs; ref; ref = ref->next) {
 		int force_ref_update = ref->force || force_update;
+		int reject_reason = 0;
 
 		if (ref->peer_ref)
 			hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
@@ -1416,6 +1417,26 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		}
 
 		/*
+		 * Bypass the usual "must fast-forward" check but
+		 * replace it with a weaker "the old value must be
+		 * this value we observed".  If the remote ref has
+		 * moved and is now different from what we expect,
+		 * reject any push.
+		 *
+		 * It also is an error if the user told us to check
+		 * with the remote-tracking branch to find the value
+		 * to expect, but we did not have such a tracking
+		 * branch.
+		 */
+		if (ref->expect_old_sha1) {
+			if (ref->expect_old_no_trackback ||
+			    hashcmp(ref->old_sha1, ref->old_sha1_expect))
+				reject_reason = REF_STATUS_REJECT_STALE;
+		}
+
+		/*
+		 * The usual "must fast-forward" rules.
+		 *
 		 * Decide whether an individual refspec A:B can be
 		 * pushed.  The push will succeed if any of the
 		 * following are true:
@@ -1433,24 +1454,26 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		 *     passing the --force argument
 		 */
 
-		if (!ref->deletion && !is_null_sha1(ref->old_sha1)) {
-			int why = 0; /* why would this push require --force? */
-
+		else if (!ref->deletion && !is_null_sha1(ref->old_sha1)) {
 			if (!prefixcmp(ref->name, "refs/tags/"))
-				why = REF_STATUS_REJECT_ALREADY_EXISTS;
+				reject_reason = REF_STATUS_REJECT_ALREADY_EXISTS;
 			else if (!has_sha1_file(ref->old_sha1))
-				why = REF_STATUS_REJECT_FETCH_FIRST;
+				reject_reason = REF_STATUS_REJECT_FETCH_FIRST;
 			else if (!lookup_commit_reference_gently(ref->old_sha1, 1) ||
 				 !lookup_commit_reference_gently(ref->new_sha1, 1))
-				why = REF_STATUS_REJECT_NEEDS_FORCE;
+				reject_reason = REF_STATUS_REJECT_NEEDS_FORCE;
 			else if (!ref_newer(ref->new_sha1, ref->old_sha1))
-				why = REF_STATUS_REJECT_NONFASTFORWARD;
-
-			if (!force_ref_update)
-				ref->status = why;
-			else if (why)
-				ref->forced_update = 1;
+				reject_reason = REF_STATUS_REJECT_NONFASTFORWARD;
 		}
+
+		/*
+		 * "--force" will defeat any rejection implemented
+		 * by the rules above.
+		 */
+		if (!force_ref_update)
+			ref->status = reject_reason;
+		else if (reject_reason)
+			ref->forced_update = 1;
 	}
 }
 
diff --git a/remote.h b/remote.h
index ca3c8c8..6c42554 100644
--- a/remote.h
+++ b/remote.h
@@ -107,6 +107,7 @@ struct ref {
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
index 5dd92b7..b321d6a 100644
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
1.8.3.4-980-g8decd39
