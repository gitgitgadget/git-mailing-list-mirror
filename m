From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH] git-push: update remote tags only with force
Date: Wed, 31 Oct 2012 00:37:55 -0500
Message-ID: <1351661875-4307-1-git-send-email-chris@rorvick.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 31 06:38:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTR0F-0001uV-UG
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 06:38:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330Ab2JaFh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 01:37:58 -0400
Received: from [38.98.186.242] ([38.98.186.242]:39336 "HELO burner.cogcap.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with SMTP
	id S1751858Ab2JaFh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 01:37:57 -0400
Received: by burner.cogcap.com (Postfix, from userid 10028)
	id C87242B09BF; Wed, 31 Oct 2012 00:37:55 -0500 (CDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208790>

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

The new status has the added benefit of being able to provide accurate
feedback as to why the ref update failed and what can be done.
Currently all ref update rejections are assumed to be for branches.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 Documentation/git-push.txt | 10 +++++-----
 builtin/push.c             | 12 ++++++++++++
 builtin/send-pack.c        |  6 ++++++
 cache.h                    |  3 +++
 remote.c                   | 34 +++++++++++++++++++++++++++-------
 t/t5516-fetch-push.sh      | 30 +++++++++++++++++++++++++++++-
 transport-helper.c         |  6 ++++++
 transport.c                | 25 ++++++++++++++++---------
 transport.h                |  3 ++-
 9 files changed, 106 insertions(+), 23 deletions(-)

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
index db9ba30..fabcea0 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -220,6 +220,10 @@ static const char message_advice_checkout_pull_push[] =
 	   "(e.g. 'git pull') before pushing again.\n"
 	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
 
+static const char message_advice_ref_already_exists[] =
+	N_("Updates were rejected because a matching reference already exists in\n"
+	   "the remote.  Use git push -f if you really want to make this update.");
+
 static void advise_pull_before_push(void)
 {
 	if (!advice_push_non_ff_current || !advice_push_nonfastforward)
@@ -241,6 +245,11 @@ static void advise_checkout_pull_push(void)
 	advise(_(message_advice_checkout_pull_push));
 }
 
+static void advise_ref_already_exists(void)
+{
+	advise(_(message_advice_ref_already_exists));
+}
+
 static int push_with_options(struct transport *transport, int flags)
 {
 	int err;
@@ -277,6 +286,9 @@ static int push_with_options(struct transport *transport, int flags)
 		else
 			advise_checkout_pull_push();
 		break;
+	case ALREADY_EXISTS:
+		advise_ref_already_exists();
+		break;
 	}
 
 	return 1;
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
index a58df84..2d160a9 100644
--- a/cache.h
+++ b/cache.h
@@ -1002,11 +1002,14 @@ struct ref {
 	unsigned int force:1,
 		merge:1,
 		nonfastforward:1,
+		forwardable:1,
+		update:1,
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
index 04fd9ea..0d94888 100644
--- a/remote.c
+++ b/remote.c
@@ -1309,22 +1309,42 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		 *     to overwrite it; you would not know what you are losing
 		 *     otherwise.
 		 *
-		 * (3) if both new and old are commit-ish, and new is a
-		 *     descendant of old, it is OK.
+		 * (3) if both new and old are commits, the reference is not
+		 *     a tag, and new is a descendant of old, it is OK.
 		 *
 		 * (4) regardless of all of the above, removing :B is
 		 *     always allowed.
 		 */
 
-		ref->nonfastforward =
+		ref->update =
 			!ref->deletion &&
-			!is_null_sha1(ref->old_sha1) &&
+			!is_null_sha1(ref->old_sha1);
+
+		ref->nonfastforward =
+			ref->update &&
 			(!has_sha1_file(ref->old_sha1)
 			  || !ref_newer(ref->new_sha1, ref->old_sha1));
 
-		if (ref->nonfastforward && !ref->force && !force_update) {
-			ref->status = REF_STATUS_REJECT_NONFASTFORWARD;
-			continue;
+		if (prefixcmp(ref->name, "refs/tags/")) {
+			struct object *old = parse_object(ref->old_sha1);
+			struct object *new = parse_object(ref->new_sha1);
+			ref->forwardable = (old && new &&
+			  old->type == OBJ_COMMIT && new->type == OBJ_COMMIT);
+		} else
+			ref->forwardable = 0;
+
+		if (!ref->force && !force_update) {
+			if (ref->forwardable) {
+				if (ref->nonfastforward) {
+					ref->status = REF_STATUS_REJECT_NONFASTFORWARD;
+					continue;
+				}
+			} else {
+				if (ref->update) {
+					ref->status = REF_STATUS_REJECT_ALREADY_EXISTS;
+					continue;
+				}
+			}
 		}
 	}
 }
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index b5417cc..cff559f 100755
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
+		! git push ../child2 lw_tag &&
+		! git push ../child2 ann_tag &&
+		git push --force ../child2 lw_tag &&
+		git push --force ../child2 ann_tag &&
+		git tag -f lw_tag HEAD~ &&
+		git tag -f -a -m "message 3" ann_tag &&
+		! git push ../child2 lw_tag &&
+		! git push ../child2 ann_tag &&
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
index 9932f40..d218884 100644
--- a/transport.c
+++ b/transport.c
@@ -659,7 +659,7 @@ static void print_ok_ref_status(struct ref *ref, int porcelain)
 		const char *msg;
 
 		strcpy(quickref, status_abbrev(ref->old_sha1));
-		if (ref->nonfastforward) {
+		if (ref->nonfastforward || (!ref->forwardable && ref->update)) {
 			strcat(quickref, "...");
 			type = '+';
 			msg = "forced update";
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
@@ -714,7 +718,7 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count, i
 }
 
 void transport_print_push_status(const char *dest, struct ref *refs,
-				  int verbose, int porcelain, int *nonfastforward)
+				  int verbose, int porcelain, int *willnotupdate)
 {
 	struct ref *ref;
 	int n = 0;
@@ -733,18 +737,21 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 		if (ref->status == REF_STATUS_OK)
 			n += print_one_push_status(ref, dest, n, porcelain);
 
-	*nonfastforward = 0;
+	*willnotupdate = 0;
 	for (ref = refs; ref; ref = ref->next) {
 		if (ref->status != REF_STATUS_NONE &&
 		    ref->status != REF_STATUS_UPTODATE &&
 		    ref->status != REF_STATUS_OK)
 			n += print_one_push_status(ref, dest, n, porcelain);
 		if (ref->status == REF_STATUS_REJECT_NONFASTFORWARD &&
-		    *nonfastforward != NON_FF_HEAD) {
+		    *willnotupdate != NON_FF_HEAD) {
 			if (!strcmp(head, ref->name))
-				*nonfastforward = NON_FF_HEAD;
+				*willnotupdate = NON_FF_HEAD;
 			else
-				*nonfastforward = NON_FF_OTHER;
+				*willnotupdate = NON_FF_OTHER;
+		} else if (ref->status == REF_STATUS_REJECT_ALREADY_EXISTS &&
+		    *willnotupdate == 0) {
+				*willnotupdate = ALREADY_EXISTS;
 		}
 	}
 }
@@ -1031,9 +1038,9 @@ static void die_with_unpushed_submodules(struct string_list *needs_pushing)
 
 int transport_push(struct transport *transport,
 		   int refspec_nr, const char **refspec, int flags,
-		   int *nonfastforward)
+		   int *willnotupdate)
 {
-	*nonfastforward = 0;
+	*willnotupdate = 0;
 	transport_verify_remote_names(refspec_nr, refspec);
 
 	if (transport->push) {
@@ -1099,7 +1106,7 @@ int transport_push(struct transport *transport,
 		if (!quiet || err)
 			transport_print_push_status(transport->url, remote_refs,
 					verbose | porcelain, porcelain,
-					nonfastforward);
+					willnotupdate);
 
 		if (flags & TRANSPORT_PUSH_SET_UPSTREAM)
 			set_upstreams(transport, remote_refs, pretend);
diff --git a/transport.h b/transport.h
index 3b21c4a..326271e 100644
--- a/transport.h
+++ b/transport.h
@@ -142,6 +142,7 @@ void transport_set_verbosity(struct transport *transport, int verbosity,
 
 #define NON_FF_HEAD 1
 #define NON_FF_OTHER 2
+#define ALREADY_EXISTS 3
 int transport_push(struct transport *connection,
 		   int refspec_nr, const char **refspec, int flags,
 		   int * nonfastforward);
@@ -170,7 +171,7 @@ void transport_update_tracking_ref(struct remote *remote, struct ref *ref, int v
 int transport_refs_pushed(struct ref *ref);
 
 void transport_print_push_status(const char *dest, struct ref *refs,
-		  int verbose, int porcelain, int *nonfastforward);
+		  int verbose, int porcelain, int *willnotupdate);
 
 typedef void alternate_ref_fn(const struct ref *, void *);
 extern void for_each_alternate_ref(alternate_ref_fn, void *);
-- 
1.8.0.1.ga7c0bae
