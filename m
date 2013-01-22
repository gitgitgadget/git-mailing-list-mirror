From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] push: introduce REJECT_FETCH_FIRST and
 REJECT_NEEDS_FORCE
Date: Mon, 21 Jan 2013 22:30:29 -0800
Message-ID: <1358836230-9197-3-git-send-email-gitster@pobox.com>
References: <20130121234002.GE17156@sigill.intra.peff.net>
 <1358836230-9197-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Chris Rorvick <chris@rorvick.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 22 07:31:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxXO0-0002C0-62
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 07:31:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752273Ab3AVGak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 01:30:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40710 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751466Ab3AVGah (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 01:30:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A68C68FB;
	Tue, 22 Jan 2013 01:30:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=p8TT
	osHFV1W2/RIRBMc6U+3jepc=; b=HAr/x6nACC9FT6v/qORy7TXK6om0MhF42Wcu
	9/2upugMJLfDWfRvxi4/6umUMEkE+7GaJJ5qJbCPg55pla9wmipRGX6F+0QEAXDM
	aUcVo8NOh5zdCjQ2ejLde8bBNmJwonANdefqdvHLKwJ9K8UzESdYJ+csAl2gftNY
	Ms5Vusg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	QGjQaquIQXwGQu6u4ziQ7d/4w2/AXFhC1sgIZt+xtSY/9wVoeFSWoTcxa7Cra8cJ
	iuhhiJWDK2fzdFw9OX1AW260jFh8RTJlI9xW4mWWrWKrxyGPbTkIvO1KCh7GGqza
	orLGHsSeejOtPt0UAOTCgO8MdHVvm3LJ2bhDNoWnmXU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FAAF68FA;
	Tue, 22 Jan 2013 01:30:37 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6229568F9; Tue, 22 Jan 2013
 01:30:36 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.498.gfdee8be
In-Reply-To: <1358836230-9197-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 3B4BBC26-645D-11E2-B1B2-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214203>

When we push to update an existing ref, if:

 * we do not have the object at the tip of the remote; or
 * the object at the tip of the remote is not a commit; or
 * the object we are pushing is not a commit,

there is no point suggesting to fetch, integrate and push again.

If we do not have the current object at the tip of the remote, we
should tell the user to fetch first and evaluate the situation
before deciding what to do next.

Otherwise, if the current object is not a commit, or if we are
trying to push an object that is not a commit, then the user does
not have to fetch first (we already have the object), but it still
does not make sense to suggest to integrate and re-push.  Just tell
them that such a push requires a force in such a case.

In these cases, the push was locally rejected on the client end, but
we used the same error and advice messages as the ones used when
rejecting a non-fast-forward push, i.e. pull from there and
integrate before pushing again.  This did not make much sense.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Updated log message and fixed the logic to decide "fetch first";
   we should say "fetch first" only when we do not have the current
   tip of the remote end.

   send-pack.c has style violation that "else" is not on the same
   line as closing brace of its corresponding "if", but I followed
   the existing style of surrounding code.  Cleaning them up is for
   a separate topic.

 advice.c            |  4 ++++
 advice.h            |  2 ++
 builtin/push.c      | 25 +++++++++++++++++++++++++
 builtin/send-pack.c | 10 ++++++++++
 cache.h             |  2 ++
 remote.c            | 22 ++++++++++++++++------
 send-pack.c         |  2 ++
 transport-helper.c  | 10 ++++++++++
 transport.c         | 12 ++++++++++++
 transport.h         |  2 ++
 10 files changed, 85 insertions(+), 6 deletions(-)

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
index 8491e43..da928fa 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -224,6 +224,13 @@ static const char message_advice_ref_already_exists[] =
 	N_("Updates were rejected because the destination reference already exists\n"
 	   "in the remote.");
 
+static const char message_advice_ref_fetch_first[] =
+	N_("Updates were rejected; you need to fetch the destination reference\n"
+	   "to decide what to do.\n");
+
+static const char message_advice_ref_needs_force[] =
+	N_("Updates were rejected; you need to force update.\n");
+
 static void advise_pull_before_push(void)
 {
 	if (!advice_push_non_ff_current || !advice_push_update_rejected)
@@ -252,6 +259,20 @@ static void advise_ref_already_exists(void)
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
@@ -285,6 +306,10 @@ static int push_with_options(struct transport *transport, int flags)
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
index 3375914..c991915 100644
--- a/remote.c
+++ b/remote.c
@@ -1318,17 +1318,26 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		 */
 
 		if (!ref->deletion && !is_null_sha1(ref->old_sha1)) {
-			int nonfastforward =
-				!has_sha1_file(ref->old_sha1)
-				|| !ref_newer(ref->new_sha1, ref->old_sha1);
-
 			if (!prefixcmp(ref->name, "refs/tags/")) {
 				if (!force_ref_update) {
 					ref->status = REF_STATUS_REJECT_ALREADY_EXISTS;
 					continue;
 				}
 				ref->forced_update = 1;
-			} else if (nonfastforward) {
+			} else if (!has_sha1_file(ref->old_sha1)) {
+				if (!force_ref_update) {
+					ref->status = REF_STATUS_REJECT_FETCH_FIRST;
+					continue;
+				}
+				ref->forced_update = 1;
+			} else if (!lookup_commit_reference_gently(ref->old_sha1, 1) ||
+				   !lookup_commit_reference_gently(ref->new_sha1, 1)) {
+				if (!force_ref_update) {
+					ref->status = REF_STATUS_REJECT_NEEDS_FORCE;
+					continue;
+				}
+				ref->forced_update = 1;
+			} else if (!ref_newer(ref->new_sha1, ref->old_sha1)) {
 				if (!force_ref_update) {
 					ref->status = REF_STATUS_REJECT_NONFASTFORWARD;
 					continue;
@@ -1517,7 +1526,8 @@ int ref_newer(const unsigned char *new_sha1, const unsigned char *old_sha1)
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
1.8.1.1.498.gfdee8be
