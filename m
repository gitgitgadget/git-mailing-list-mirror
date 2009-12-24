From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3 3/6] refactor ref status logic for pushing
Date: Thu, 24 Dec 2009 15:42:58 +0800
Message-ID: <20091224154258.08b4fe44.rctay89@gmail.com>
References: <20091224154158.15ba580f.rctay89@gmail.com>,
 <20091224154057.33611ae7.rctay89@gmail.com>,
 <20091224154005.a642c8ec.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 24 08:44:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNiM2-0006F2-0Q
	for gcvg-git-2@lo.gmane.org; Thu, 24 Dec 2009 08:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756872AbZLXHnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2009 02:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756846AbZLXHnJ
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Dec 2009 02:43:09 -0500
Received: from mail-gx0-f211.google.com ([209.85.217.211]:32971 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756783AbZLXHnI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2009 02:43:08 -0500
Received: by gxk3 with SMTP id 3so2074984gxk.1
        for <git@vger.kernel.org>; Wed, 23 Dec 2009 23:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=g8fd3ohFOzK+LpEt8lczc8dImW2OzvZX8l8WpeuW+iI=;
        b=MwCRaoEMV0MDvOI/QfJ5cdOIB9ufcPWMpHK5hMp2XvDC94WZO7M1etYrU6Eh8aFIQO
         gci+G6QerKlln61svowEJqvOXOEEOUE/mfU1jftWmk/f6bUNIxHKdAJOtbsh5vEAAVqW
         aHMnVGBrT7Et4xuZh4dCpqi7ttMokBjO13ddk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=tUSqLU9zQ2NT+02+sO8ne0tEdHbeOKFNJW5ZuMDjvDRvfUSLlptAOh4Xx6+ItYhjfx
         D1rGsotHh/WDP8nB9R8WEnf5c4+RuosophCZe/n6GtBO+c4F5E3RM0tqzAa1+hasKFbM
         gwRxZ81dfrXYz42m4x0Pdd43cGiLUZYWc0m3M=
Received: by 10.101.195.22 with SMTP id x22mr1450917anp.137.1261640585896;
        Wed, 23 Dec 2009 23:43:05 -0800 (PST)
Received: from your-cukc5e3z5n (cm133.zeta152.maxonline.com.sg [116.87.152.133])
        by mx.google.com with ESMTPS id 14sm4240445gxk.14.2009.12.23.23.43.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Dec 2009 23:43:05 -0800 (PST)
In-Reply-To: <20091224154158.15ba580f.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135646>

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

Changed nothing from v2 except tests and mentioning it in the commit
message.

 builtin-send-pack.c  |   50 +++++++++++---------------------------------------
 remote.c             |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 remote.h             |    2 ++
 t/t5541-http-push.sh |    4 ++--
 transport-helper.c   |   13 ++++++-------
 transport.c          |    4 ++++
 6 files changed, 75 insertions(+), 48 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 8fffdbf..38580c3 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -406,50 +406,19 @@ int send_pack(struct send_pack_args *args,
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

@@ -673,6 +642,9 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
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
index 5ebe04a..86dbcb2 100755
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
index 11f3d7e..6b1f778 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -329,16 +329,15 @@ static int push_refs(struct transport *transport,
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
1.6.6.rc1.249.g048b3
