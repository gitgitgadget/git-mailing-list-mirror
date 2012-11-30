From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v6 5/8] push: require force for refs under refs/tags/
Date: Thu, 29 Nov 2012 19:41:37 -0600
Message-ID: <1354239700-3325-6-git-send-email-chris@rorvick.com>
References: <1354239700-3325-1-git-send-email-chris@rorvick.com>
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
X-From: git-owner@vger.kernel.org Fri Nov 30 02:44:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeFds-0007Rx-N8
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 02:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755479Ab2K3BnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 20:43:22 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:41967 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755465Ab2K3BnU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 20:43:20 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so11433874iay.19
        for <git@vger.kernel.org>; Thu, 29 Nov 2012 17:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=gUzwYf8cwjQQjQY16FxzR2f5NBeejptk6vH2hcxdC/I=;
        b=E0pnmX1wQj2M8o7DTva+usCNsfLJLWwXVu6l8S3RHLTJBaVCrqz62PHWuJOodmcSCd
         XRPx20C/ewmyQVWu5rAHOJbLxbDNDVcSuhP2CGGnGtO0smNcnFV6KCRjWsKcMnvdLsRi
         ULYfOuBJF/hkJLB4d+dai9vixKpFIqP1is41VtUi/HE32qsBc05JzwPOgB3lgNdEh94h
         TjjKNVJTNvrK/KTCloXBoAKBlZGIY82r6OfCWw/1W4wNdK1xq28qI60pptiCgPm59guL
         5HxVCp/zquJltyy6K56jCVS9mvhnCIdqosx7wZ677/GeIsNsprFgHZMeQNshO5PNIXIE
         30EQ==
Received: by 10.50.7.135 with SMTP id j7mr24620447iga.34.1354239800023;
        Thu, 29 Nov 2012 17:43:20 -0800 (PST)
Received: from marlin.localdomain ([70.131.98.170])
        by mx.google.com with ESMTPS id c3sm8955228igj.1.2012.11.29.17.43.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Nov 2012 17:43:19 -0800 (PST)
X-Mailer: git-send-email 1.8.0.158.g0c4328c
In-Reply-To: <1354239700-3325-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210895>

References are allowed to update from one commit-ish to another if the
former is an ancestor of the latter.  This behavior is oriented to
branches which are expected to move with commits.  Tag references are
expected to be static in a repository, though, thus an update to
something under refs/tags/ should be rejected unless the update is
forced.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 Documentation/git-push.txt | 11 ++++++-----
 builtin/push.c             |  2 +-
 builtin/send-pack.c        |  5 +++++
 cache.h                    |  1 +
 remote.c                   | 18 ++++++++++++++----
 send-pack.c                |  1 +
 t/t5516-fetch-push.sh      | 23 ++++++++++++++++++++++-
 transport-helper.c         |  6 ++++++
 transport.c                |  8 ++++++--
 9 files changed, 62 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index fe46c42..09bdec7 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -51,11 +51,12 @@ be named. If `:`<dst> is omitted, the same ref as <src> will be
 updated.
 +
 The object referenced by <src> is used to update the <dst> reference
-on the remote side, but by default this is only allowed if the
-update can fast-forward <dst>.  By having the optional leading `+`,
-you can tell git to update the <dst> ref even when the update is not a
-fast-forward.  This does *not* attempt to merge <src> into <dst>.  See
-EXAMPLES below for details.
+on the remote side.  By default this is only allowed if <dst> is not
+under refs/tags/, and then only if it can fast-forward <dst>.  By having
+the optional leading `+`, you can tell git to update the <dst> ref even
+if it is not allowed by default (e.g., it is not a fast-forward.)  This
+does *not* attempt to merge <src> into <dst>.  See EXAMPLES below for
+details.
 +
 `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
 +
diff --git a/builtin/push.c b/builtin/push.c
index e08485d..83a3cc8 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -222,7 +222,7 @@ static const char message_advice_checkout_pull_push[] =
 
 static const char message_advice_ref_already_exists[] =
 	N_("Updates were rejected because the destination reference already exists\n"
-	   "in the remote and the update is not a fast-forward.");
+	   "in the remote.");
 
 static void advise_pull_before_push(void)
 {
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 9f98607..f849e0a 100644
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
index b7ab4ac..a32a0ea 100644
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
index 4a6f822..012b52f 100644
--- a/remote.c
+++ b/remote.c
@@ -1315,14 +1315,18 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		 *
 		 * (1) if the old thing does not exist, it is OK.
 		 *
-		 * (2) if you do not have the old thing, you are not allowed
+		 * (2) if the destination is under refs/tags/ you are
+		 *     not allowed to overwrite it; tags are expected
+		 *     to be static once created
+		 *
+		 * (3) if you do not have the old thing, you are not allowed
 		 *     to overwrite it; you would not know what you are losing
 		 *     otherwise.
 		 *
-		 * (3) if both new and old are commit-ish, and new is a
+		 * (4) if both new and old are commit-ish, and new is a
 		 *     descendant of old, it is OK.
 		 *
-		 * (4) regardless of all of the above, removing :B is
+		 * (5) regardless of all of the above, removing :B is
 		 *     always allowed.
 		 */
 
@@ -1337,7 +1341,13 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 				!has_sha1_file(ref->old_sha1)
 				  || !ref_newer(ref->new_sha1, ref->old_sha1);
 
-			if (ref->nonfastforward) {
+			if (ref->not_forwardable) {
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
index b5417cc..8f024a0 100755
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
 
@@ -929,6 +929,27 @@ test_expect_success 'push into aliased refs (inconsistent)' '
 	)
 '
 
+test_expect_success 'push requires --force to update lightweight tag' '
+	mk_test heads/master &&
+	mk_child child1 &&
+	mk_child child2 &&
+	(
+		cd child1 &&
+		git tag Tag &&
+		git push ../child2 Tag &&
+		git push ../child2 Tag &&
+		>file1 &&
+		git add file1 &&
+		git commit -m "file1" &&
+		git tag -f Tag &&
+		test_must_fail git push ../child2 Tag &&
+		git push --force ../child2 Tag &&
+		git tag -f Tag &&
+		test_must_fail git push ../child2 Tag HEAD~ &&
+		git push --force ../child2 Tag
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
index f3160b1..2673d27 100644
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
-			if (ref->not_forwardable)
-				*reject_reasons |= REJECT_ALREADY_EXISTS;
 			if (!strcmp(head, ref->name))
 				*reject_reasons |= REJECT_NON_FF_HEAD;
 			else
 				*reject_reasons |= REJECT_NON_FF_OTHER;
+		} else if (ref->status == REF_STATUS_REJECT_ALREADY_EXISTS) {
+			*reject_reasons |= REJECT_ALREADY_EXISTS;
 		}
 	}
 }
-- 
1.8.0.158.g0c4328c
