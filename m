From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v3 2/5] push: add advice for rejected tag reference
Date: Sun, 11 Nov 2012 22:08:05 -0600
Message-ID: <1352693288-7396-3-git-send-email-chris@rorvick.com>
References: <1352693288-7396-1-git-send-email-chris@rorvick.com>
Cc: Chris Rorvick <chris@rorvick.com>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 05:11:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXlMm-0000ok-TA
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 05:11:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109Ab2KLELE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 23:11:04 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:35517 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365Ab2KLELC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 23:11:02 -0500
Received: by mail-ia0-f174.google.com with SMTP id y32so4137837iag.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 20:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=9QEtyKX8YxeXBjO4TH2B9s7Vnm2vTOZ5551djdEfpok=;
        b=vXdsN7Svz/3AmDY45OW+UwyDyxCb+B2kex+v7tKxVt8crFS5Q+BIyMWS4Qr0qzKnIW
         im7fZ8ZWXufcsInbw0KCE83xh7XRHxMRsGWUGYXa/H0QYHr9Qrck99FL2de9K2a8joSL
         viMmEZtnZ0G+ADWjxB4vBZSggdF0LiTOxJVtbmtrPuJRtehUVB6JRjHyMzAk1ABuPtuX
         4/uZ0z+VhaUtrLTfMJX7B8IxJG+g3hWoqRKGN9aCcuYIL0+oNedmYoxzIc4pMoo+tD5x
         PB29DgOPK6CvUrwJtfIAvVQ7Z6V5Wk3TmQlcCsSDZ8nTIfy250htfsCRgo9iCS0dYDdm
         3c3A==
Received: by 10.50.33.169 with SMTP id s9mr6931307igi.19.1352693462114;
        Sun, 11 Nov 2012 20:11:02 -0800 (PST)
Received: from marlin.localdomain (adsl-70-131-98-170.dsl.emhril.sbcglobal.net. [70.131.98.170])
        by mx.google.com with ESMTPS id wm10sm7396117igc.2.2012.11.11.20.11.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 20:11:01 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352693288-7396-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209465>

Advising the user to fetch and merge only makes sense if the rejected
reference is a branch.  If none of the rejections were for branches,
tell the user they need to force the update(s).

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 builtin/push.c | 16 ++++++++++++++--
 cache.h        |  1 +
 remote.c       |  7 +++++++
 transport.c    |  6 ++++--
 transport.h    |  5 +++--
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
index dbd8018..4e25840 100644
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
index 1f9699c..7e86352 100644
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
1.8.0
