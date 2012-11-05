From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v2 2/5] push: add advice for rejected tag reference
Date: Sun,  4 Nov 2012 21:08:25 -0600
Message-ID: <1352084908-32333-3-git-send-email-chris@rorvick.com>
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
X-From: git-owner@vger.kernel.org Mon Nov 05 04:09:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVD3g-0002cf-QO
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 04:09:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750Ab2KEDIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 22:08:41 -0500
Received: from [38.98.186.242] ([38.98.186.242]:36653 "HELO burner.cogcap.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with SMTP
	id S1752423Ab2KEDIk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2012 22:08:40 -0500
Received: by burner.cogcap.com (Postfix, from userid 10028)
	id 84A7B2B09C5; Sun,  4 Nov 2012 21:08:39 -0600 (CST)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1352084908-32333-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209047>

Advising the user to fetch and merge only makes sense if the rejected
reference is a branch.  If none of the rejections were for branches,
tell the user they need to force the update(s).

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 builtin/push.c |   16 ++++++++++++++--
 cache.h        |    1 +
 remote.c       |    7 +++++++
 transport.c    |    6 ++++--
 transport.h    |    5 +++--
 5 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index eaeaf7e..77340c0 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -220,6 +220,11 @@ static const char message_advice_checkout_pull_push[] =
 	   "(e.g. 'git pull') before pushing again.\n"
 	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
 
+static const char message_advice_ref_already_exists[] =
+	N_("Updates were rejected because a matching reference already exists in\n"
+	   "the remote and the update is not a fast-forward.  Use git push -f if\n"
+	   "you really want to make this update.");
+
 static void advise_pull_before_push(void)
 {
 	if (!advice_push_non_ff_current || !advice_push_nonfastforward)
@@ -241,6 +246,11 @@ static void advise_checkout_pull_push(void)
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
@@ -265,13 +275,15 @@ static int push_with_options(struct transport *transport, int flags)
 	if (!err)
 		return 0;
 
-	if (reject_mask & NON_FF_HEAD) {
+	if (reject_mask & REJECT_NON_FF_HEAD) {
 		advise_pull_before_push();
-	} else if (reject_mask & NON_FF_OTHER) {
+	} else if (reject_mask & REJECT_NON_FF_OTHER) {
 		if (default_matching_used)
 			advise_use_upstream();
 		else
 			advise_checkout_pull_push();
+	} else if (reject_mask & REJECT_ALREADY_EXISTS) {
+		advise_ref_already_exists();
 	}
 
 	return 1;
diff --git a/cache.h b/cache.h
index a58df84..bc2fc9a 100644
--- a/cache.h
+++ b/cache.h
@@ -1002,6 +1002,7 @@ struct ref {
 	unsigned int force:1,
 		merge:1,
 		nonfastforward:1,
+		forwardable:1,
 		deletion:1;
 	enum {
 		REF_STATUS_NONE = 0,
diff --git a/remote.c b/remote.c
index 04fd9ea..5ecd58d 100644
--- a/remote.c
+++ b/remote.c
@@ -1316,6 +1316,13 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		 *     always allowed.
 		 */
 
+		if (prefixcmp(ref->name, "refs/tags/")) {
+			struct object *old = parse_object(ref->old_sha1);
+			struct object *new = parse_object(ref->new_sha1);
+			ref->forwardable = (old && new &&
+			  old->type == OBJ_COMMIT && new->type == OBJ_COMMIT);
+		}
+
 		ref->nonfastforward =
 			!ref->deletion &&
 			!is_null_sha1(ref->old_sha1) &&
diff --git a/transport.c b/transport.c
index ae9fda8..1657798 100644
--- a/transport.c
+++ b/transport.c
@@ -740,10 +740,12 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 		    ref->status != REF_STATUS_OK)
 			n += print_one_push_status(ref, dest, n, porcelain);
 		if (ref->status == REF_STATUS_REJECT_NONFASTFORWARD) {
+			if (!ref->forwardable)
+				*reject_mask |= REJECT_ALREADY_EXISTS;
 			if (!strcmp(head, ref->name))
-				*reject_mask |= NON_FF_HEAD;
+				*reject_mask |= REJECT_NON_FF_HEAD;
 			else
-				*reject_mask |= NON_FF_OTHER;
+				*reject_mask |= REJECT_NON_FF_OTHER;
 		}
 	}
 }
diff --git a/transport.h b/transport.h
index b9e124a..30b88e8 100644
--- a/transport.h
+++ b/transport.h
@@ -140,8 +140,9 @@ int transport_set_option(struct transport *transport, const char *name,
 void transport_set_verbosity(struct transport *transport, int verbosity,
 	int force_progress);
 
-#define NON_FF_HEAD     0x01
-#define NON_FF_OTHER    0x02
+#define REJECT_NON_FF_HEAD     0x01
+#define REJECT_NON_FF_OTHER    0x02
+#define REJECT_ALREADY_EXISTS  0x04
 
 int transport_push(struct transport *connection,
 		   int refspec_nr, const char **refspec, int flags,
-- 
1.7.1
