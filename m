From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v4 3/6] refactor ref status logic for pushing
Date: Fri,  8 Jan 2010 10:12:42 +0800
Message-ID: <1262916765-3728-4-git-send-email-rctay89@gmail.com>
References: <1262916765-3728-1-git-send-email-rctay89@gmail.com>
 <1262916765-3728-2-git-send-email-rctay89@gmail.com>
 <1262916765-3728-3-git-send-email-rctay89@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 08 03:14:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NT4Mk-0005XW-8r
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 03:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753347Ab0AHCNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 21:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753302Ab0AHCNs
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 21:13:48 -0500
Received: from mail-gx0-f211.google.com ([209.85.217.211]:57251 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334Ab0AHCNq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 21:13:46 -0500
Received: by mail-gx0-f211.google.com with SMTP id 3so8201271gxk.1
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 18:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=WV44aaCedHIFfnay+1gcq3Y5t01qstHG0Mr06hlVHdg=;
        b=YzVJ5TBH2yIAnt6bqPD5gVirunhegQ+9bF+mXvSRJzYtu5pYzEXTAgSMg5uvGA1+TP
         Y6/+LQG9u/WrI0lk+MdKJzafRsShut5cshvcikBGZ9RKDsC/4emaj7t/f9SVA+OeGzd5
         x5sxtdmGDzxN+/PJaXUal6M6+eXglUtG3gI00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jI4HxShOsocjsmfzpUXn+uNM7IyB1bMidEnOBWKsDbSPG/zJw5Nh/cXNp0di4CId2o
         T6KozEIVkIiHma+TeGAuPpnk2eFrSOCfG68UswS2TEs8lpzRIxlhpHNMUTmQlXpCOj+u
         coMie+uJ1YWjcEKfu2RcPqfBsGFXi01TG0Giw=
Received: by 10.101.148.31 with SMTP id a31mr23928392ano.184.1262916826164;
        Thu, 07 Jan 2010 18:13:46 -0800 (PST)
Received: from localhost.localdomain (cm154.zeta152.maxonline.com.sg [116.87.152.154])
        by mx.google.com with ESMTPS id 14sm10999449gxk.10.2010.01.07.18.13.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 Jan 2010 18:13:45 -0800 (PST)
X-Mailer: git-send-email 1.6.6
In-Reply-To: <1262916765-3728-3-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136408>

Move the logic that detects up-to-date and non-fast-forward refs to a
new function in remote.[ch], set_ref_status_for_push().

Make transport_push() invoke set_ref_status_for_push() before invoking
the push_refs() implementation. (As a side-effect, the push_refs()
implementation in transport-helper.c now knows of non-fast-forward
pushes.)

Removed logic for detecting up-to-date refs from the push_refs()
implementation in transport-helper.c, as transport_push() has already
done so for it.

Make cmd_send_pack() invoke set_ref_status_for_push() before invoking
send_pack(), as transport_push() can't do it for send_pack() here.

Mark the test on the return status of non-fast-forward push to fail.
Git now exits with success, as transport.c::transport_push() does not
check for refs with status REF_STATUS_REJECT_NONFASTFORWARD nor does it
indicate rejected pushes with its return value.

Mark the test for ref status to succeed. As mentioned earlier, refs
might be marked as non-fast-forwards, triggering the push status
printing mechanism in transport.c.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 builtin-send-pack.c  |   51 +++++++++++--------------------------------------
 remote.c             |   50 +++++++++++++++++++++++++++++++++++++++++++++++++
 remote.h             |    2 +
 t/t5541-http-push.sh |    4 +-
 transport-helper.c   |   14 ++++++------
 transport.c          |    4 +++
 6 files changed, 77 insertions(+), 48 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 8fffdbf..76c7206 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -406,50 +406,20 @@ int send_pack(struct send_pack_args *args,
 	 */
 	new_refs = 0;
 	for (ref = remote_refs; ref; ref = ref->next) {
-
-		if (ref->peer_ref)
-			hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
-		else if (!args->send_mirror)
+		if (!ref->peer_ref && !args->send_mirror)
 			continue;
 
-		ref->deletion = is_null_sha1(ref->new_sha1);
-		if (ref->deletion && !allow_deleting_refs) {
-			ref->status = REF_STATUS_REJECT_NODELETE;
-			continue;
-		}
-		if (!ref->deletion &&
-		    !hashcmp(ref->old_sha1, ref->new_sha1)) {
-			ref->status = REF_STATUS_UPTODATE;
+		/* Check for statuses set by set_ref_status_for_push() */
+		switch (ref->status) {
+		case REF_STATUS_REJECT_NONFASTFORWARD:
+		case REF_STATUS_UPTODATE:
 			continue;
+		default:
+			; /* do nothing */
 		}
 
-		/* This part determines what can overwrite what.
-		 * The rules are:
-		 *
-		 * (0) you can always use --force or +A:B notation to
-		 *     selectively force individual ref pairs.
-		 *
-		 * (1) if the old thing does not exist, it is OK.
-		 *
-		 * (2) if you do not have the old thing, you are not allowed
-		 *     to overwrite it; you would not know what you are losing
-		 *     otherwise.
-		 *
-		 * (3) if both new and old are commit-ish, and new is a
-		 *     descendant of old, it is OK.
-		 *
-		 * (4) regardless of all of the above, removing :B is
-		 *     always allowed.
-		 */
-
-		ref->nonfastforward =
-		    !ref->deletion &&
-		    !is_null_sha1(ref->old_sha1) &&
-		    (!has_sha1_file(ref->old_sha1)
-		      || !ref_newer(ref->new_sha1, ref->old_sha1));
-
-		if (ref->nonfastforward && !ref->force && !args->force_update) {
-			ref->status = REF_STATUS_REJECT_NONFASTFORWARD;
+		if (ref->deletion && !allow_deleting_refs) {
+			ref->status = REF_STATUS_REJECT_NODELETE;
 			continue;
 		}
 
@@ -673,6 +643,9 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	if (match_refs(local_refs, &remote_refs, nr_refspecs, refspecs, flags))
 		return -1;
 
+	set_ref_status_for_push(remote_refs, args.send_mirror,
+		args.force_update);
+
 	ret = send_pack(&args, fd, conn, remote_refs, &extra_have);
 
 	if (helper_status)
diff --git a/remote.c b/remote.c
index e3afecd..c70181c 100644
--- a/remote.c
+++ b/remote.c
@@ -1247,6 +1247,56 @@ int match_refs(struct ref *src, struct ref **dst,
 	return 0;
 }
 
+void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
+	int force_update)
+{
+	struct ref *ref;
+
+	for (ref = remote_refs; ref; ref = ref->next) {
+		if (ref->peer_ref)
+			hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
+		else if (!send_mirror)
+			continue;
+
+		ref->deletion = is_null_sha1(ref->new_sha1);
+		if (!ref->deletion &&
+			!hashcmp(ref->old_sha1, ref->new_sha1)) {
+			ref->status = REF_STATUS_UPTODATE;
+			continue;
+		}
+
+		/* This part determines what can overwrite what.
+		 * The rules are:
+		 *
+		 * (0) you can always use --force or +A:B notation to
+		 *     selectively force individual ref pairs.
+		 *
+		 * (1) if the old thing does not exist, it is OK.
+		 *
+		 * (2) if you do not have the old thing, you are not allowed
+		 *     to overwrite it; you would not know what you are losing
+		 *     otherwise.
+		 *
+		 * (3) if both new and old are commit-ish, and new is a
+		 *     descendant of old, it is OK.
+		 *
+		 * (4) regardless of all of the above, removing :B is
+		 *     always allowed.
+		 */
+
+		ref->nonfastforward =
+			!ref->deletion &&
+			!is_null_sha1(ref->old_sha1) &&
+			(!has_sha1_file(ref->old_sha1)
+			  || !ref_newer(ref->new_sha1, ref->old_sha1));
+
+		if (ref->nonfastforward && !ref->force && !force_update) {
+			ref->status = REF_STATUS_REJECT_NONFASTFORWARD;
+			continue;
+		}
+	}
+}
+
 struct branch *branch_get(const char *name)
 {
 	struct branch *ret;
diff --git a/remote.h b/remote.h
index 8b7ecf9..6e13643 100644
--- a/remote.h
+++ b/remote.h
@@ -98,6 +98,8 @@ char *apply_refspecs(struct refspec *refspecs, int nr_refspec,
 
 int match_refs(struct ref *src, struct ref **dst,
 	       int nr_refspec, const char **refspec, int all);
+void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
+	int force_update);
 
 /*
  * Given a list of the remote refs and the specification of things to
diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index cc740fe..6d92196 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -88,7 +88,7 @@ test_expect_success 'used receive-pack service' '
 	test_cmp exp act
 '
 
-test_expect_success 'non-fast-forward push fails' '
+test_expect_failure 'non-fast-forward push fails' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	git checkout master &&
 	echo "changed" > path2 &&
@@ -100,7 +100,7 @@ test_expect_success 'non-fast-forward push fails' '
 	 test $HEAD != $(git rev-parse --verify HEAD))
 '
 
-test_expect_failure 'non-fast-forward push show ref status' '
+test_expect_success 'non-fast-forward push show ref status' '
 	grep "^ ! \[rejected\][ ]*master -> master (non-fast-forward)$" output
 '
 
diff --git a/transport-helper.c b/transport-helper.c
index 11f3d7e..7c9b569 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -329,16 +329,16 @@ static int push_refs(struct transport *transport,
 		return 1;
 
 	for (ref = remote_refs; ref; ref = ref->next) {
-		if (ref->peer_ref)
-			hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
-		else if (!mirror)
+		if (!ref->peer_ref && !mirror)
 			continue;
 
-		ref->deletion = is_null_sha1(ref->new_sha1);
-		if (!ref->deletion &&
-			!hashcmp(ref->old_sha1, ref->new_sha1)) {
-			ref->status = REF_STATUS_UPTODATE;
+		/* Check for statuses set by set_ref_status_for_push() */
+		switch (ref->status) {
+		case REF_STATUS_REJECT_NONFASTFORWARD:
+		case REF_STATUS_UPTODATE:
 			continue;
+		default:
+			; /* do nothing */
 		}
 
 		if (force_all)
diff --git a/transport.c b/transport.c
index 3eea836..12c4423 100644
--- a/transport.c
+++ b/transport.c
@@ -887,6 +887,10 @@ int transport_push(struct transport *transport,
 			return -1;
 		}
 
+		set_ref_status_for_push(remote_refs,
+			flags & TRANSPORT_PUSH_MIRROR,
+			flags & TRANSPORT_PUSH_FORCE);
+
 		ret = transport->push_refs(transport, remote_refs, flags);
 
 		if (!quiet || push_had_errors(remote_refs))
-- 
1.6.6.341.ga7aec
