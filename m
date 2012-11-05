From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v2 5/5] push: update remote tags only with force
Date: Sun,  4 Nov 2012 21:08:28 -0600
Message-ID: <1352084908-32333-6-git-send-email-chris@rorvick.com>
References: <1352084908-32333-1-git-send-email-chris@rorvick.com>
Cc: Chris Rorvick <chris@rorvick.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 05 04:09:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVD3i-0002cf-OG
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 04:09:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821Ab2KEDIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 22:08:53 -0500
Received: from [38.98.186.242] ([38.98.186.242]:17582 "HELO burner.cogcap.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with SMTP
	id S1752571Ab2KEDIl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2012 22:08:41 -0500
Received: by burner.cogcap.com (Postfix, from userid 10028)
	id DE80A2B09C8; Sun,  4 Nov 2012 21:08:39 -0600 (CST)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1352084908-32333-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209050>

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
 Documentation/git-push.txt |   10 +++++-----
 builtin/push.c             |    3 +--
 builtin/send-pack.c        |    6 ++++++
 cache.h                    |    1 +
 remote.c                   |    8 +++++++-
 t/t5516-fetch-push.sh      |   30 +++++++++++++++++++++++++++++-
 transport-helper.c         |    6 ++++++
 transport.c                |    8 ++++++--
 8 files changed, 61 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 22d2580..7107d76 100644
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
index 77340c0..d097348 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -222,8 +222,7 @@ static const char message_advice_checkout_pull_push[] =
 
 static const char message_advice_ref_already_exists[] =
 	N_("Updates were rejected because a matching reference already exists in\n"
-	   "the remote and the update is not a fast-forward.  Use git push -f if\n"
-	   "you really want to make this update.");
+	   "the remote.  Use git push -f if you really want to make this update.");
 
 static void advise_pull_before_push(void)
 {
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 7d05064..f159ec3 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -202,6 +202,11 @@ static void print_helper_status(struct ref *ref)
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
@@ -288,6 +293,7 @@ int send_pack(struct send_pack_args *args,
 		/* Check for statuses set by set_ref_status_for_push() */
 		switch (ref->status) {
 		case REF_STATUS_REJECT_NONFASTFORWARD:
+		case REF_STATUS_REJECT_ALREADY_EXISTS:
 		case REF_STATUS_UPTODATE:
 			continue;
 		default:
diff --git a/cache.h b/cache.h
index b74c744..77786b6 100644
--- a/cache.h
+++ b/cache.h
@@ -1011,6 +1011,7 @@ struct ref {
 		REF_STATUS_NONE = 0,
 		REF_STATUS_OK,
 		REF_STATUS_REJECT_NONFASTFORWARD,
+		REF_STATUS_REJECT_ALREADY_EXISTS,
 		REF_STATUS_REJECT_NODELETE,
 		REF_STATUS_UPTODATE,
 		REF_STATUS_REMOTE_REJECT,
diff --git a/remote.c b/remote.c
index 552afd0..3e04f47 100644
--- a/remote.c
+++ b/remote.c
@@ -1335,7 +1335,13 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 				(!has_sha1_file(ref->old_sha1)
 				  || !ref_newer(ref->new_sha1, ref->old_sha1));
 
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
index cfe0988..ef9a6f8 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -643,6 +643,11 @@ static void push_update_ref_status(struct strbuf *buf,
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
@@ -702,6 +707,7 @@ static int push_refs_with_push(struct transport *transport,
 		/* Check for statuses set by set_ref_status_for_push() */
 		switch (ref->status) {
 		case REF_STATUS_REJECT_NONFASTFORWARD:
+		case REF_STATUS_REJECT_ALREADY_EXISTS:
 		case REF_STATUS_UPTODATE:
 			continue;
 		default:
diff --git a/transport.c b/transport.c
index 632f8b0..c183971 100644
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
-			if (!ref->forwardable)
-				*reject_mask |= REJECT_ALREADY_EXISTS;
 			if (!strcmp(head, ref->name))
 				*reject_mask |= REJECT_NON_FF_HEAD;
 			else
 				*reject_mask |= REJECT_NON_FF_OTHER;
+		} else if (ref->status == REF_STATUS_REJECT_ALREADY_EXISTS) {
+				*reject_mask |= REJECT_ALREADY_EXISTS;
 		}
 	}
 }
-- 
1.7.1
