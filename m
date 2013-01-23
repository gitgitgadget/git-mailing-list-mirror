From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 3/3] push: introduce REJECT_FETCH_FIRST and
 REJECT_NEEDS_FORCE
Date: Wed, 23 Jan 2013 13:55:30 -0800
Message-ID: <1358978130-12216-4-git-send-email-gitster@pobox.com>
References: <20130121234002.GE17156@sigill.intra.peff.net>
 <1358978130-12216-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Chris Rorvick <chris@rorvick.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 23 22:56:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty8Im-00036b-Lk
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 22:56:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522Ab3AWVzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 16:55:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42347 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421Ab3AWVzo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 16:55:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AF82B7E0;
	Wed, 23 Jan 2013 16:55:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=OFIr
	iAlyaOPF5250vGFch00QAUk=; b=RPy2OdGwX0AclKXSheSZ34q/oEY7hWfb6DcH
	dk1/GowlxQltRUoi+eAJc2pWlE5W9sNNtpc46GZfhpe6/waED+VuG8EBjNO16F2J
	7hpGQtxlvwCVTBKJe6d0eI2NCAUjyYTvN5j9zVjn4MjWQWVX3C6dLk5ONqQhdJ1i
	+0azU6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	i02CW18wzYUnSFL0jocjtexPk5TTJzgoElub1v4H7Nh0xZ+EMKKnLDx97iYYK41e
	0MpVIZoeNxwJHXK5I66ABDoRyDxPdH67z7BqA0fvkE6JRTA8RBz3egvZ59Mvr1Cz
	r/kQRVI3audU9E+ZsCUnJkw4QIx8fE6wq+jHBWRbLZY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1069BB7DF;
	Wed, 23 Jan 2013 16:55:39 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 04A6BB7DB; Wed, 23 Jan 2013
 16:55:37 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.517.g0318d2b
In-Reply-To: <1358978130-12216-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9F4021A4-65A7-11E2-9E25-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214371>

When we push to update an existing ref, if:

 * the object at the tip of the remote is not a commit; or
 * the object we are pushing is not a commit,

it won't be correct to suggest to fetch, integrate and push again,
as the old and new objects will not "merge".

If we do not have the current object at the tip of the remote, we do
not even know that object, when fetched, is something that can be
merged.  In such a case, suggesting to pull first just like
non-fast-forward case may not be technically correct, but in
practice, most such failures are seen when you try to push your work
to a branch without knowing that somebody else already pushed to
update the same branch since you forked, so "pull first" would work
as a suggestion most of the time.

In these cases, the current code already rejects such a push on the
client end, but we used the same error and advice messages as the
ones used when rejecting a non-fast-forward push, i.e. pull from
there and integrate before pushing again.  Introduce new
rejection reasons and reword the messages appropriately.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt | 12 +++++++++++-
 advice.c                 |  4 ++++
 advice.h                 |  2 ++
 builtin/push.c           | 29 +++++++++++++++++++++++++++++
 builtin/send-pack.c      | 10 ++++++++++
 cache.h                  |  2 ++
 remote.c                 | 11 ++++++++---
 send-pack.c              |  2 ++
 transport-helper.c       | 10 ++++++++++
 transport.c              | 12 ++++++++++++
 transport.h              |  2 ++
 11 files changed, 92 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 90e7d10..1f47761 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -143,7 +143,8 @@ advice.*::
 	pushUpdateRejected::
 		Set this variable to 'false' if you want to disable
 		'pushNonFFCurrent', 'pushNonFFDefault',
-		'pushNonFFMatching', and 'pushAlreadyExists'
+		'pushNonFFMatching', 'pushAlreadyExists',
+		'pushFetchFirst', and 'pushNeedsForce'
 		simultaneously.
 	pushNonFFCurrent::
 		Advice shown when linkgit:git-push[1] fails due to a
@@ -162,6 +163,15 @@ advice.*::
 	pushAlreadyExists::
 		Shown when linkgit:git-push[1] rejects an update that
 		does not qualify for fast-forwarding (e.g., a tag.)
+	pushFetchFirst::
+		Shown when linkgit:git-push[1] rejects an update that
+		tries to overwrite a remote ref that points at an
+		object we do not have.
+	pushNeedsForce::
+		Shown when linkgit:git-push[1] rejects an update that
+		tries to overwrite a remote ref that points at an
+		object that is not a committish, or make the remote
+		ref point at an object that is not a committish.
 	statusHints::
 		Show directions on how to proceed from the current
 		state in the output of linkgit:git-status[1] and in
diff --git a/advice.c b/advice.c
index d287927..780f58d 100644
--- a/advice.c
+++ b/advice.c
@@ -5,6 +5,8 @@ int advice_push_non_ff_current = 1;
 int advice_push_non_ff_default = 1;
 int advice_push_non_ff_matching = 1;
 int advice_push_already_exists = 1;
+int advice_push_fetch_first = 1;
+int advice_push_needs_force = 1;
 int advice_status_hints = 1;
 int advice_commit_before_merge = 1;
 int advice_resolve_conflict = 1;
@@ -20,6 +22,8 @@ static struct {
 	{ "pushnonffdefault", &advice_push_non_ff_default },
 	{ "pushnonffmatching", &advice_push_non_ff_matching },
 	{ "pushalreadyexists", &advice_push_already_exists },
+	{ "pushfetchfirst", &advice_push_fetch_first },
+	{ "pushneedsforce", &advice_push_needs_force },
 	{ "statushints", &advice_status_hints },
 	{ "commitbeforemerge", &advice_commit_before_merge },
 	{ "resolveconflict", &advice_resolve_conflict },
diff --git a/advice.h b/advice.h
index 8bf6356..fad36df 100644
--- a/advice.h
+++ b/advice.h
@@ -8,6 +8,8 @@ extern int advice_push_non_ff_current;
 extern int advice_push_non_ff_default;
 extern int advice_push_non_ff_matching;
 extern int advice_push_already_exists;
+extern int advice_push_fetch_first;
+extern int advice_push_needs_force;
 extern int advice_status_hints;
 extern int advice_commit_before_merge;
 extern int advice_resolve_conflict;
diff --git a/builtin/push.c b/builtin/push.c
index 8491e43..92ca3d7 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -220,10 +220,21 @@ static const char message_advice_checkout_pull_push[] =
 	   "(e.g. 'git pull') before pushing again.\n"
 	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
 
+static const char message_advice_ref_fetch_first[] =
+	N_("Updates were rejected because you do not have the object at the tip\n"
+	   "of the remote. You may want to first merge the remote changes (e.g.\n"
+	   " 'git pull') before pushing again.\n"
+	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
+
 static const char message_advice_ref_already_exists[] =
 	N_("Updates were rejected because the destination reference already exists\n"
 	   "in the remote.");
 
+static const char message_advice_ref_needs_force[] =
+	N_("You cannot update a remote ref that points at a non-commit object,\n"
+	   "or update a remote ref to make it point at a non-commit object,\n"
+	   "without using the '--force' option.\n");
+
 static void advise_pull_before_push(void)
 {
 	if (!advice_push_non_ff_current || !advice_push_update_rejected)
@@ -252,6 +263,20 @@ static void advise_ref_already_exists(void)
 	advise(_(message_advice_ref_already_exists));
 }
 
+static void advise_ref_fetch_first(void)
+{
+	if (!advice_push_fetch_first || !advice_push_update_rejected)
+		return;
+	advise(_(message_advice_ref_fetch_first));
+}
+
+static void advise_ref_needs_force(void)
+{
+	if (!advice_push_needs_force || !advice_push_update_rejected)
+		return;
+	advise(_(message_advice_ref_needs_force));
+}
+
 static int push_with_options(struct transport *transport, int flags)
 {
 	int err;
@@ -285,6 +310,10 @@ static int push_with_options(struct transport *transport, int flags)
 			advise_checkout_pull_push();
 	} else if (reject_reasons & REJECT_ALREADY_EXISTS) {
 		advise_ref_already_exists();
+	} else if (reject_reasons & REJECT_FETCH_FIRST) {
+		advise_ref_fetch_first();
+	} else if (reject_reasons & REJECT_NEEDS_FORCE) {
+		advise_ref_needs_force();
 	}
 
 	return 1;
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index f849e0a..57a46b2 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -44,6 +44,16 @@ static void print_helper_status(struct ref *ref)
 			msg = "non-fast forward";
 			break;
 
+		case REF_STATUS_REJECT_FETCH_FIRST:
+			res = "error";
+			msg = "fetch first";
+			break;
+
+		case REF_STATUS_REJECT_NEEDS_FORCE:
+			res = "error";
+			msg = "needs force";
+			break;
+
 		case REF_STATUS_REJECT_ALREADY_EXISTS:
 			res = "error";
 			msg = "already exists";
diff --git a/cache.h b/cache.h
index 12631a1..377a3df 100644
--- a/cache.h
+++ b/cache.h
@@ -1010,6 +1010,8 @@ struct ref {
 		REF_STATUS_REJECT_NONFASTFORWARD,
 		REF_STATUS_REJECT_ALREADY_EXISTS,
 		REF_STATUS_REJECT_NODELETE,
+		REF_STATUS_REJECT_FETCH_FIRST,
+		REF_STATUS_REJECT_NEEDS_FORCE,
 		REF_STATUS_UPTODATE,
 		REF_STATUS_REMOTE_REJECT,
 		REF_STATUS_EXPECTING_REPORT
diff --git a/remote.c b/remote.c
index 969aa11..a772e74 100644
--- a/remote.c
+++ b/remote.c
@@ -1322,8 +1322,12 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 
 			if (!prefixcmp(ref->name, "refs/tags/"))
 				why = REF_STATUS_REJECT_ALREADY_EXISTS;
-			else if (!has_sha1_file(ref->old_sha1)
-				 || !ref_newer(ref->new_sha1, ref->old_sha1))
+			else if (!has_sha1_file(ref->old_sha1))
+				why = REF_STATUS_REJECT_FETCH_FIRST;
+			else if (!lookup_commit_reference_gently(ref->old_sha1, 1) ||
+				 !lookup_commit_reference_gently(ref->new_sha1, 1))
+				why = REF_STATUS_REJECT_NEEDS_FORCE;
+			else if (!ref_newer(ref->new_sha1, ref->old_sha1))
 				why = REF_STATUS_REJECT_NONFASTFORWARD;
 
 			if (!force_ref_update)
@@ -1512,7 +1516,8 @@ int ref_newer(const unsigned char *new_sha1, const unsigned char *old_sha1)
 	struct commit_list *list, *used;
 	int found = 0;
 
-	/* Both new and old must be commit-ish and new is descendant of
+	/*
+	 * Both new and old must be commit-ish and new is descendant of
 	 * old.  Otherwise we require --force.
 	 */
 	o = deref_tag(parse_object(old_sha1), NULL, 0);
diff --git a/send-pack.c b/send-pack.c
index 1c375f0..97ab336 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -230,6 +230,8 @@ int send_pack(struct send_pack_args *args,
 		switch (ref->status) {
 		case REF_STATUS_REJECT_NONFASTFORWARD:
 		case REF_STATUS_REJECT_ALREADY_EXISTS:
+		case REF_STATUS_REJECT_FETCH_FIRST:
+		case REF_STATUS_REJECT_NEEDS_FORCE:
 		case REF_STATUS_UPTODATE:
 			continue;
 		default:
diff --git a/transport-helper.c b/transport-helper.c
index 965b778..cb3ef7d 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -666,6 +666,16 @@ static void push_update_ref_status(struct strbuf *buf,
 			free(msg);
 			msg = NULL;
 		}
+		else if (!strcmp(msg, "fetch first")) {
+			status = REF_STATUS_REJECT_FETCH_FIRST;
+			free(msg);
+			msg = NULL;
+		}
+		else if (!strcmp(msg, "needs force")) {
+			status = REF_STATUS_REJECT_NEEDS_FORCE;
+			free(msg);
+			msg = NULL;
+		}
 	}
 
 	if (*ref)
diff --git a/transport.c b/transport.c
index 585ebcd..5105562 100644
--- a/transport.c
+++ b/transport.c
@@ -699,6 +699,14 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count, i
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
 						 "already exists", porcelain);
 		break;
+	case REF_STATUS_REJECT_FETCH_FIRST:
+		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
+						 "fetch first", porcelain);
+		break;
+	case REF_STATUS_REJECT_NEEDS_FORCE:
+		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
+						 "needs force", porcelain);
+		break;
 	case REF_STATUS_REMOTE_REJECT:
 		print_ref_status('!', "[remote rejected]", ref,
 						 ref->deletion ? NULL : ref->peer_ref,
@@ -750,6 +758,10 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 				*reject_reasons |= REJECT_NON_FF_OTHER;
 		} else if (ref->status == REF_STATUS_REJECT_ALREADY_EXISTS) {
 			*reject_reasons |= REJECT_ALREADY_EXISTS;
+		} else if (ref->status == REF_STATUS_REJECT_FETCH_FIRST) {
+			*reject_reasons |= REJECT_FETCH_FIRST;
+		} else if (ref->status == REF_STATUS_REJECT_NEEDS_FORCE) {
+			*reject_reasons |= REJECT_NEEDS_FORCE;
 		}
 	}
 }
diff --git a/transport.h b/transport.h
index bfd2df5..c818763 100644
--- a/transport.h
+++ b/transport.h
@@ -143,6 +143,8 @@ void transport_set_verbosity(struct transport *transport, int verbosity,
 #define REJECT_NON_FF_HEAD     0x01
 #define REJECT_NON_FF_OTHER    0x02
 #define REJECT_ALREADY_EXISTS  0x04
+#define REJECT_FETCH_FIRST     0x08
+#define REJECT_NEEDS_FORCE     0x10
 
 int transport_push(struct transport *connection,
 		   int refspec_nr, const char **refspec, int flags,
-- 
1.8.1.1.517.g0318d2b
