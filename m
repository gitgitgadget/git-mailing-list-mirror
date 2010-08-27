From: Dave Olszewski <cxreg@pobox.com>
Subject: [PATCH] push: disallow fast-forwarding tags without --force
Date: Fri, 27 Aug 2010 00:14:44 -0700
Message-ID: <1282893284-17829-1-git-send-email-cxreg@pobox.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 27 09:22:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OotGD-0004Ub-7W
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 09:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673Ab0H0HVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 03:21:54 -0400
Received: from 62.f9.1243.static.theplanet.com ([67.18.249.98]:57619 "EHLO
	62.f9.1243.static.theplanet.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752517Ab0H0HVw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Aug 2010 03:21:52 -0400
X-Envelope-From: count@genericorp.net
Received: from bokonon.genericorp.net (c-98-232-94-200.hsd1.wa.comcast.net [98.232.94.200])
	(authenticated bits=0)
	by 62.f9.1243.static.theplanet.com (8.13.8/8.13.8/Debian-3) with ESMTP id o7R7EqpS000621
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT);
	Fri, 27 Aug 2010 02:14:58 -0500
Received: from count by bokonon.genericorp.net with local (Exim 4.72)
	(envelope-from <count@bokonon.genericorp.net>)
	id 1Oot9C-0004e6-RG; Fri, 27 Aug 2010 00:14:46 -0700
X-Mailer: git-send-email 1.7.2.2.176.g3e15d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154586>

Generally, tags are considered a write-once ref (or object), and updates
to them are the exception to the rule.  This is evident from the
behavior of "git fetch", which will not update a tag it already has
unless --tags is specified, and from the --force option to "git tag".

However, there is presently nothing preventing a tag from being
fast-forwarded, which can happen intentionally or accidentally.  In both
cases, the user should be aware that they are changing something that is
expected to be immutable and stable.

This change forces a user to specify "git push --force" to push a tag
which points to a different object than it does on the upstream
repository, regardless of whether it's a fast-forward or not.

The config option receive.denyMovingTags can be set on the upstream
repository to disallow this, even with --force.

Signed-off-by: Dave Olszewski <cxreg@pobox.com>
---
 Documentation/config.txt               |    8 ++++++++
 Documentation/git-push.txt             |   21 ++++++++++++++++++---
 Documentation/git-receive-pack.txt     |    3 ++-
 advice.c                               |    2 ++
 advice.h                               |    1 +
 builtin/push.c                         |   10 ++++++++--
 builtin/receive-pack.c                 |   14 ++++++++++++++
 builtin/send-pack.c                    |    9 ++++++++-
 cache.h                                |    1 +
 contrib/completion/git-completion.bash |    1 +
 remote.c                               |   13 +++++++++++++
 t/t5400-send-pack.sh                   |   13 +++++++++++++
 transport-helper.c                     |    6 ++++++
 transport.c                            |   15 ++++++++++++---
 transport.h                            |    4 ++--
 15 files changed, 109 insertions(+), 12 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 05ec3fe..587cccd 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -122,6 +122,9 @@ advice.*::
 	pushNonFastForward::
 		Advice shown when linkgit:git-push[1] refuses
 		non-fast-forward refs. Default: true.
+	pushMovingTag::
+		Advice shown when linkgit:git-push[1] refuses
+		to push a changed tag. Default: true.
 	statusHints::
 		Directions on how to stage/unstage/add shown in the
 		output of linkgit:git-status[1] and the template shown
@@ -1593,6 +1596,11 @@ receive.denyNonFastForwards::
 	even if that push is forced. This configuration variable is
 	set when initializing a shared repository.
 
+receive.denyMovingTags::
+	If set to true, git-receive-pack will deny an update to a tag which
+	already points to a different object.  Use this to prevent such an
+	update via a push, even if that push is forced.
+
 receive.updateserverinfo::
 	If set to true, git-receive-pack will run git-update-server-info
 	after receiving data from git-push and updating refs.
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 658ff2f..f7f8f17 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -112,7 +112,9 @@ nor in any Push line of the corresponding remotes file---see below).
 	Usually, the command refuses to update a remote ref that is
 	not an ancestor of the local ref used to overwrite it.
 	This flag disables the check.  This can cause the
-	remote repository to lose commits; use it with care.
+	remote repository to lose commits; use it with care.  This
+	flag will also allow a previously pushed tag to be updated
+	to point to a new commit, which is refused by default.
 
 --repo=<repository>::
 	This option is only relevant if no <repository> argument is
@@ -215,8 +217,9 @@ remote rejected::
 	of the following safety options in effect:
 	`receive.denyCurrentBranch` (for pushes to the checked out
 	branch), `receive.denyNonFastForwards` (for forced
-	non-fast-forward updates), `receive.denyDeletes` or
-	`receive.denyDeleteCurrent`.  See linkgit:git-config[1].
+	non-fast-forward updates), `receive.denyDeletes`,
+	`receive.denyDeleteCurrent`, or `receive.denyMovingTags`.  See
+	linkgit:git-config[1].
 
 remote failure::
 	The remote end did not report the successful update of the ref,
@@ -324,6 +327,18 @@ overwrite it. In other words, "git push --force" is a method reserved for
 a case where you do mean to lose history.
 
 
+Note about moving tags
+----------------------
+
+Tags are widely considered 'read-only', and are not expected to change.
+See the 'On Re-tagging' section of linkgit:git-tag[1] to learn more about
+why this is so.
+
+If you really need to change an already-propagated tag, you must force it
+with "git push --force".  This can be overridden on the upstream repository
+with receive.denyMovingTags.
+
+
 Examples
 --------
 
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 2790eeb..55f2830 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -30,7 +30,8 @@ post-update hooks found in the Documentation/howto directory.
 
 'git-receive-pack' honours the receive.denyNonFastForwards config
 option, which tells it if updates to a ref should be denied if they
-are not fast-forwards.
+are not fast-forwards, and the receive.denyMovingTags config option,
+which disallows updating a tag to point to a new object.
 
 OPTIONS
 -------
diff --git a/advice.c b/advice.c
index 0be4b5f..51021d8 100644
--- a/advice.c
+++ b/advice.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 
 int advice_push_nonfastforward = 1;
+int advice_push_moving_tag = 1;
 int advice_status_hints = 1;
 int advice_commit_before_merge = 1;
 int advice_resolve_conflict = 1;
@@ -12,6 +13,7 @@ static struct {
 	int *preference;
 } advice_config[] = {
 	{ "pushnonfastforward", &advice_push_nonfastforward },
+	{ "pushmovingtag", &advice_push_moving_tag},
 	{ "statushints", &advice_status_hints },
 	{ "commitbeforemerge", &advice_commit_before_merge },
 	{ "resolveconflict", &advice_resolve_conflict },
diff --git a/advice.h b/advice.h
index 3244ebb..8b1a33c 100644
--- a/advice.h
+++ b/advice.h
@@ -4,6 +4,7 @@
 #include "git-compat-util.h"
 
 extern int advice_push_nonfastforward;
+extern int advice_push_moving_tag;
 extern int advice_status_hints;
 extern int advice_commit_before_merge;
 extern int advice_resolve_conflict;
diff --git a/builtin/push.c b/builtin/push.c
index e655eb7..8547554 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -106,7 +106,7 @@ static void setup_default_push_refspecs(void)
 static int push_with_options(struct transport *transport, int flags)
 {
 	int err;
-	int nonfastforward;
+	int nonfastforward, moving_tag;
 
 	transport_set_verbosity(transport, verbosity, progress);
 
@@ -119,7 +119,7 @@ static int push_with_options(struct transport *transport, int flags)
 	if (verbosity > 0)
 		fprintf(stderr, "Pushing to %s\n", transport->url);
 	err = transport_push(transport, refspec_nr, refspec, flags,
-			     &nonfastforward);
+			     &nonfastforward, &moving_tag);
 	if (err != 0)
 		error("failed to push some refs to '%s'", transport->url);
 
@@ -134,6 +134,12 @@ static int push_with_options(struct transport *transport, int flags)
 				"'Note about fast-forwards' section of 'git push --help' for details.\n");
 	}
 
+	if (moving_tag && advice_push_moving_tag) {
+		fprintf(stderr, "A tag which already exists upstream was attempted to be pushed while\n"
+				"pointing to a different object.  This is unsafe, and disabled by default.\n"
+				"See the 'Note about moving tags' section of 'git push --help' for details.\n");
+	}
+
 	return 1;
 }
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 760817d..1a96e55 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -22,6 +22,7 @@ enum deny_action {
 
 static int deny_deletes;
 static int deny_non_fast_forwards;
+static int deny_moving_tags;
 static enum deny_action deny_current_branch = DENY_UNCONFIGURED;
 static enum deny_action deny_delete_current = DENY_UNCONFIGURED;
 static int receive_fsck_objects;
@@ -63,6 +64,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.denymovingtags") == 0) {
+		deny_moving_tags = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (strcmp(var, "receive.unpacklimit") == 0) {
 		receive_unpack_limit = git_config_int(var, value);
 		return 0;
@@ -416,6 +422,14 @@ static const char *update(struct command *cmd)
 			return "non-fast-forward";
 		}
 	}
+	if (deny_moving_tags && !is_null_sha1(new_sha1) &&
+	    !is_null_sha1(old_sha1) &&
+	    hashcmp(old_sha1, new_sha1) &&
+	    !prefixcmp(name, "refs/tags/")) {
+		rp_error("denying moving tag %s", name);
+		return "moving tag";
+	}
+
 	if (run_update_hook(cmd)) {
 		rp_error("hook declined to update %s", name);
 		return "hook declined";
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 481602d..c41a455 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -198,6 +198,11 @@ static void print_helper_status(struct ref *ref)
 			msg = "non-fast forward";
 			break;
 
+		case REF_STATUS_REJECT_MOVING_TAG:
+			res = "error";
+			msg = "moving tag";
+			break;
+
 		case REF_STATUS_REJECT_NODELETE:
 		case REF_STATUS_REMOTE_REJECT:
 			res = "error";
@@ -275,6 +280,7 @@ int send_pack(struct send_pack_args *args,
 		/* Check for statuses set by set_ref_status_for_push() */
 		switch (ref->status) {
 		case REF_STATUS_REJECT_NONFASTFORWARD:
+		case REF_STATUS_REJECT_MOVING_TAG:
 		case REF_STATUS_UPTODATE:
 			continue;
 		default:
@@ -395,6 +401,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	const char *receivepack = "git-receive-pack";
 	int flags;
 	int nonfastforward = 0;
+	int moving_tag = 0;
 
 	argv++;
 	for (i = 1; i < argc; i++, argv++) {
@@ -516,7 +523,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	ret |= finish_connect(conn);
 
 	if (!helper_status)
-		transport_print_push_status(dest, remote_refs, args.verbose, 0, &nonfastforward);
+		transport_print_push_status(dest, remote_refs, args.verbose, 0, &nonfastforward, &moving_tag);
 
 	if (!args.dry_run && remote) {
 		struct ref *ref;
diff --git a/cache.h b/cache.h
index eb77e1d..cca7499 100644
--- a/cache.h
+++ b/cache.h
@@ -913,6 +913,7 @@ struct ref {
 		REF_STATUS_NONE = 0,
 		REF_STATUS_OK,
 		REF_STATUS_REJECT_NONFASTFORWARD,
+		REF_STATUS_REJECT_MOVING_TAG,
 		REF_STATUS_REJECT_NODELETE,
 		REF_STATUS_UPTODATE,
 		REF_STATUS_REMOTE_REJECT,
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6756990..dc29e0b 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1964,6 +1964,7 @@ _git_config ()
 		receive.denyCurrentBranch
 		receive.denyDeletes
 		receive.denyNonFastForwards
+		receive.denyMovingTags
 		receive.fsckObjects
 		receive.unpackLimit
 		repack.usedeltabaseoffset
diff --git a/remote.c b/remote.c
index 9143ec7..cc7ce93 100644
--- a/remote.c
+++ b/remote.c
@@ -1266,6 +1266,19 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 			continue;
 		}
 
+		/* If a tag already exists on the remote and points to
+		 * a different object, we don't want to push it again
+		 * without requiring the user to indicate that they know
+		 * what they are doing.
+		 */
+		if (!prefixcmp(ref->name, "refs/tags/") &&
+		    !ref->deletion &&
+		    !is_null_sha1(ref->old_sha1) &&
+		    !ref->force &&
+		    !force_update) {
+			ref->status = REF_STATUS_REJECT_MOVING_TAG;
+		}
+
 		/* This part determines what can overwrite what.
 		 * The rules are:
 		 *
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index c718253..573eb20 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -106,6 +106,19 @@ test_expect_success 'denyNonFastforwards trumps --force' '
 	test "$victim_orig" = "$victim_head"
 '
 
+test_expect_success 'denyMovingTags trumps --force' '
+	(
+	    cd victim &&
+	    ( git tag moving_tag master^ || : ) &&
+	    git config receive.denyMovingTags true
+	) &&
+	git tag moving_tag &&
+	victim_orig=$(cd victim && git rev-parse --verify moving_tag) &&
+	test_must_fail git send-pack --force ./victim moving_tag &&
+	victim_tag=$(cd victim && git rev-parse --verify moving_tag) &&
+	test "$victim_orig" = "$victim_tag"
+'
+
 test_expect_success 'push --all excludes remote tracking hierarchy' '
 	mkdir parent &&
 	(
diff --git a/transport-helper.c b/transport-helper.c
index acfc88e..e9730a0 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -575,6 +575,7 @@ static int push_refs_with_push(struct transport *transport,
 		/* Check for statuses set by set_ref_status_for_push() */
 		switch (ref->status) {
 		case REF_STATUS_REJECT_NONFASTFORWARD:
+		case REF_STATUS_REJECT_MOVING_TAG:
 		case REF_STATUS_UPTODATE:
 			continue;
 		default:
@@ -655,6 +656,11 @@ static int push_refs_with_push(struct transport *transport,
 				free(msg);
 				msg = NULL;
 			}
+			else if (!strcmp(msg, "moving tag")) {
+				status = REF_STATUS_REJECT_MOVING_TAG;
+				free(msg);
+				msg = NULL;
+			}
 		}
 
 		if (ref)
diff --git a/transport.c b/transport.c
index 4dba6f8..e3b2ee8 100644
--- a/transport.c
+++ b/transport.c
@@ -692,6 +692,10 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count, i
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
 						 "non-fast-forward", porcelain);
 		break;
+	case REF_STATUS_REJECT_MOVING_TAG:
+		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
+						 "moving tag", porcelain);
+		break;
 	case REF_STATUS_REMOTE_REJECT:
 		print_ref_status('!', "[remote rejected]", ref,
 						 ref->deletion ? NULL : ref->peer_ref,
@@ -711,7 +715,8 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count, i
 }
 
 void transport_print_push_status(const char *dest, struct ref *refs,
-				  int verbose, int porcelain, int *nonfastforward)
+				  int verbose, int porcelain,
+				  int *nonfastforward, int *moving_tag)
 {
 	struct ref *ref;
 	int n = 0;
@@ -727,6 +732,7 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 			n += print_one_push_status(ref, dest, n, porcelain);
 
 	*nonfastforward = 0;
+	*moving_tag = 0;
 	for (ref = refs; ref; ref = ref->next) {
 		if (ref->status != REF_STATUS_NONE &&
 		    ref->status != REF_STATUS_UPTODATE &&
@@ -734,6 +740,8 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 			n += print_one_push_status(ref, dest, n, porcelain);
 		if (ref->status == REF_STATUS_REJECT_NONFASTFORWARD)
 			*nonfastforward = 1;
+		if (ref->status == REF_STATUS_REJECT_MOVING_TAG)
+			*moving_tag = 1;
 	}
 }
 
@@ -1004,9 +1012,10 @@ void transport_set_verbosity(struct transport *transport, int verbosity,
 
 int transport_push(struct transport *transport,
 		   int refspec_nr, const char **refspec, int flags,
-		   int *nonfastforward)
+		   int *nonfastforward, int *moving_tag)
 {
 	*nonfastforward = 0;
+	*moving_tag = 0;
 	transport_verify_remote_names(refspec_nr, refspec);
 
 	if (transport->push) {
@@ -1047,7 +1056,7 @@ int transport_push(struct transport *transport,
 		if (!quiet || err)
 			transport_print_push_status(transport->url, remote_refs,
 					verbose | porcelain, porcelain,
-					nonfastforward);
+					nonfastforward, moving_tag);
 
 		if (flags & TRANSPORT_PUSH_SET_UPSTREAM)
 			set_upstreams(transport, remote_refs, pretend);
diff --git a/transport.h b/transport.h
index c59d973..8e95e09 100644
--- a/transport.h
+++ b/transport.h
@@ -138,7 +138,7 @@ void transport_set_verbosity(struct transport *transport, int verbosity,
 
 int transport_push(struct transport *connection,
 		   int refspec_nr, const char **refspec, int flags,
-		   int * nonfastforward);
+		   int *nonfastforward, int *moving_tag);
 
 const struct ref *transport_get_remote_refs(struct transport *transport);
 
@@ -163,6 +163,6 @@ void transport_update_tracking_ref(struct remote *remote, struct ref *ref, int v
 int transport_refs_pushed(struct ref *ref);
 
 void transport_print_push_status(const char *dest, struct ref *refs,
-		  int verbose, int porcelain, int *nonfastforward);
+		  int verbose, int porcelain, int *nonfastforward, int *moving_tag);
 
 #endif
-- 
1.7.2.2.176.g3e15d
