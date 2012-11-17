From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v4 5/5] push: update remote tags only with force
Date: Sat, 17 Nov 2012 14:16:37 -0600
Message-ID: <1353183397-17719-6-git-send-email-chris@rorvick.com>
References: <1353183397-17719-1-git-send-email-chris@rorvick.com>
Cc: Chris Rorvick <chris@rorvick.com>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 17 21:17:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZopL-0007jb-Cz
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 21:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242Ab2KQUQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2012 15:16:59 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:48904 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233Ab2KQUQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 15:16:57 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so2483200iay.19
        for <git@vger.kernel.org>; Sat, 17 Nov 2012 12:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=TI5xSoz491w1UohUZNVbCnrrE4maAWx3wgXUGuUx9pw=;
        b=UElKb303fJ6SOZ4T4W0ve2bsiXK9ftbc3Ve6Spi3w10H0nCMh/0lOU8JO3LnbIbSba
         E7srpDtNOiKN8gAEWejR/eXNjw1gETj2qDsv7ETXy14F0Ct3RnUO0jp0z/HEgzwnnQ7v
         xbMT9CUepafjFCjKdNkeohZ19T+D0mDAiEBLnhJply7W6vIZABzK57SELaQ3ODW/q7Mm
         oN4QH4LdLzlocTAfHNb/Zvk8cr4ceiTx4Eo5tiUhpWEAh+iJQKxb5Eswto93aYBXcbUB
         PxqPPnvglsUIVmH5THQgcGh8wkc1yOw3ogurQaLyaUPqVDylKQuMgyxfBojlFZMrf4OY
         4PiQ==
Received: by 10.50.57.225 with SMTP id l1mr2720012igq.37.1353183417039;
        Sat, 17 Nov 2012 12:16:57 -0800 (PST)
Received: from marlin.localdomain (207-179-211-84.mtco.com. [207.179.211.84])
        by mx.google.com with ESMTPS id wm10sm3269004igc.2.2012.11.17.12.16.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 17 Nov 2012 12:16:56 -0800 (PST)
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1353183397-17719-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209978>

References are allowed to update from one commit-ish to another if the
former is a ancestor of the latter.  This behavior is oriented to
branches which are expected to move with commits.  Tag references are
expected to be static in a repository, though, thus an update to a
tag (lightweight and annotated) should be rejected unless the update is
forced.

To enable this functionality, the following checks have been added to
set_ref_status_for_push() for updating refs (i.e, not new or deletion)
to restrict fast-forwarding in pushes:

  1) The old and new references must be commits.  If this fails,
     it is not a valid update for a branch.

  2) The reference name cannot start with "refs/tags/".  This
     catches lightweight tags which (usually) point to commits
     and therefore would not be caught by (1).

If either of these checks fails, then it is flagged (by default) with a
status indicating the update is being rejected due to the reference
already existing in the remote.  This can be overridden by passing
--force to git push.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 Documentation/git-push.txt | 10 +++++-----
 builtin/push.c             |  2 +-
 builtin/send-pack.c        |  5 +++++
 cache.h                    |  3 ++-
 remote.c                   | 23 +++++++++++++++++++----
 send-pack.c                |  1 +
 t/t5516-fetch-push.sh      | 30 +++++++++++++++++++++++++++++-
 transport-helper.c         |  6 ++++++
 transport.c                |  8 ++++++--
 9 files changed, 74 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index fe46c42..479e25f 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -51,11 +51,11 @@ be named. If `:`<dst> is omitted, the same ref as <src> will be
 updated.
 +
 The object referenced by <src> is used to update the <dst> reference
-on the remote side, but by default this is only allowed if the
-update can fast-forward <dst>.  By having the optional leading `+`,
-you can tell git to update the <dst> ref even when the update is not a
-fast-forward.  This does *not* attempt to merge <src> into <dst>.  See
-EXAMPLES below for details.
+on the remote side.  By default this is only allowed if the update is
+a branch, and then only if it can fast-forward <dst>.  By having the
+optional leading `+`, you can tell git to update the <dst> ref even when
+the update is not a branch or it is not a fast-forward.  This does *not*
+attempt to merge <src> into <dst>.  See EXAMPLES below for details.
 +
 `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
 +
diff --git a/builtin/push.c b/builtin/push.c
index 0e13e11..cd7aa3f 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -222,7 +222,7 @@ static const char message_advice_checkout_pull_push[] =
 
 static const char message_advice_ref_already_exists[] =
 	N_("Updates were rejected because a matching reference already exists in\n"
-	   "the remote and the update is not a fast-forward.");
+	   "the remote.");
 
 static void advise_pull_before_push(void)
 {
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index fda28bc..1eabf42 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -44,6 +44,11 @@ static void print_helper_status(struct ref *ref)
 			msg = "non-fast forward";
 			break;
 
+		case REF_STATUS_REJECT_ALREADY_EXISTS:
+			res = "error";
+			msg = "already exists";
+			break;
+
 		case REF_STATUS_REJECT_NODELETE:
 		case REF_STATUS_REMOTE_REJECT:
 			res = "error";
diff --git a/cache.h b/cache.h
index f410d94..127e504 100644
--- a/cache.h
+++ b/cache.h
@@ -1004,13 +1004,14 @@ struct ref {
 		requires_force:1,
 		merge:1,
 		nonfastforward:1,
-		is_a_tag:1,
+		forwardable:1,
 		update:1,
 		deletion:1;
 	enum {
 		REF_STATUS_NONE = 0,
 		REF_STATUS_OK,
 		REF_STATUS_REJECT_NONFASTFORWARD,
+		REF_STATUS_REJECT_ALREADY_EXISTS,
 		REF_STATUS_REJECT_NODELETE,
 		REF_STATUS_UPTODATE,
 		REF_STATUS_REMOTE_REJECT,
diff --git a/remote.c b/remote.c
index 1e263b0..4fcd22c 100644
--- a/remote.c
+++ b/remote.c
@@ -1311,14 +1311,23 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		 *     to overwrite it; you would not know what you are losing
 		 *     otherwise.
 		 *
-		 * (3) if both new and old are commit-ish, and new is a
-		 *     descendant of old, it is OK.
+		 * (3) if new is commit-ish and old is a commit, new is a
+		 *     descendant of old, and the reference is not of the
+		 *     refs/tags/ hierarchy it is OK.
 		 *
 		 * (4) regardless of all of the above, removing :B is
 		 *     always allowed.
 		 */
 
-		ref->is_a_tag = !prefixcmp(ref->name, "refs/tags/");
+		if (prefixcmp(ref->name, "refs/tags/")) {
+			// Additionally, disallow fast-forwarding if
+			// the old object is not a commit.  This kicks
+			// out annotated tags that might pass the
+			// is_newer() test but dangle if the reference
+			// is updated.
+			struct object *obj = parse_object(ref->old_sha1);
+			ref->forwardable = !obj || obj->type == OBJ_COMMIT;
+		}
 
 		ref->update =
 			!ref->deletion &&
@@ -1329,7 +1338,13 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 				!has_sha1_file(ref->old_sha1)
 				  || !ref_newer(ref->new_sha1, ref->old_sha1);
 
-			if (ref->nonfastforward) {
+			if (!ref->forwardable) {
+				ref->requires_force = 1;
+				if (!force_ref_update) {
+					ref->status = REF_STATUS_REJECT_ALREADY_EXISTS;
+					continue;
+				}
+			} else if (ref->nonfastforward) {
 				ref->requires_force = 1;
 				if (!force_ref_update) {
 					ref->status = REF_STATUS_REJECT_NONFASTFORWARD;
diff --git a/send-pack.c b/send-pack.c
index f50dfd9..1c375f0 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -229,6 +229,7 @@ int send_pack(struct send_pack_args *args,
 		/* Check for statuses set by set_ref_status_for_push() */
 		switch (ref->status) {
 		case REF_STATUS_REJECT_NONFASTFORWARD:
+		case REF_STATUS_REJECT_ALREADY_EXISTS:
 		case REF_STATUS_UPTODATE:
 			continue;
 		default:
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index b5417cc..afb9b1b 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -368,7 +368,7 @@ test_expect_success 'push with colon-less refspec (2)' '
 		git branch -D frotz
 	fi &&
 	git tag -f frotz &&
-	git push testrepo frotz &&
+	git push -f testrepo frotz &&
 	check_push_result $the_commit tags/frotz &&
 	check_push_result $the_first_commit heads/frotz
 
@@ -929,6 +929,34 @@ test_expect_success 'push into aliased refs (inconsistent)' '
 	)
 '
 
+test_expect_success 'push tag requires --force to update remote tag' '
+	mk_test heads/master &&
+	mk_child child1 &&
+	mk_child child2 &&
+	(
+		cd child1 &&
+		git tag lw_tag &&
+		git tag -a -m "message 1" ann_tag &&
+		git push ../child2 lw_tag &&
+		git push ../child2 ann_tag &&
+		>file1 &&
+		git add file1 &&
+		git commit -m "file1" &&
+		git tag -f lw_tag &&
+		git tag -f -a -m "message 2" ann_tag &&
+		test_must_fail git push ../child2 lw_tag &&
+		test_must_fail git push ../child2 ann_tag &&
+		git push --force ../child2 lw_tag &&
+		git push --force ../child2 ann_tag &&
+		git tag -f lw_tag HEAD~ &&
+		git tag -f -a -m "message 3" ann_tag &&
+		test_must_fail git push ../child2 lw_tag &&
+		test_must_fail git push ../child2 ann_tag &&
+		git push --force ../child2 lw_tag &&
+		git push --force ../child2 ann_tag
+	)
+'
+
 test_expect_success 'push --porcelain' '
 	mk_empty &&
 	echo >.git/foo  "To testrepo" &&
diff --git a/transport-helper.c b/transport-helper.c
index 4713b69..965b778 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -661,6 +661,11 @@ static void push_update_ref_status(struct strbuf *buf,
 			free(msg);
 			msg = NULL;
 		}
+		else if (!strcmp(msg, "already exists")) {
+			status = REF_STATUS_REJECT_ALREADY_EXISTS;
+			free(msg);
+			msg = NULL;
+		}
 	}
 
 	if (*ref)
@@ -720,6 +725,7 @@ static int push_refs_with_push(struct transport *transport,
 		/* Check for statuses set by set_ref_status_for_push() */
 		switch (ref->status) {
 		case REF_STATUS_REJECT_NONFASTFORWARD:
+		case REF_STATUS_REJECT_ALREADY_EXISTS:
 		case REF_STATUS_UPTODATE:
 			continue;
 		default:
diff --git a/transport.c b/transport.c
index 60a7421..a380ad7 100644
--- a/transport.c
+++ b/transport.c
@@ -695,6 +695,10 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count, i
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
 						 "non-fast-forward", porcelain);
 		break;
+	case REF_STATUS_REJECT_ALREADY_EXISTS:
+		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
+						 "already exists", porcelain);
+		break;
 	case REF_STATUS_REMOTE_REJECT:
 		print_ref_status('!', "[remote rejected]", ref,
 						 ref->deletion ? NULL : ref->peer_ref,
@@ -740,12 +744,12 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 		    ref->status != REF_STATUS_OK)
 			n += print_one_push_status(ref, dest, n, porcelain);
 		if (ref->status == REF_STATUS_REJECT_NONFASTFORWARD) {
-			if (!ref->is_a_tag)
-				*reject_mask |= REJECT_ALREADY_EXISTS;
 			if (!strcmp(head, ref->name))
 				*reject_mask |= REJECT_NON_FF_HEAD;
 			else
 				*reject_mask |= REJECT_NON_FF_OTHER;
+		} else if (ref->status == REF_STATUS_REJECT_ALREADY_EXISTS) {
+			*reject_mask |= REJECT_ALREADY_EXISTS;
 		}
 	}
 }
-- 
1.8.0.155.g3a063ad.dirty
