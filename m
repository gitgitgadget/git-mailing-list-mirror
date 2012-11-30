From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v6 2/8] push: add advice for rejected tag reference
Date: Thu, 29 Nov 2012 19:41:34 -0600
Message-ID: <1354239700-3325-3-git-send-email-chris@rorvick.com>
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
X-From: git-owner@vger.kernel.org Fri Nov 30 02:44:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeFdg-0006sW-Am
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 02:43:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755420Ab2K3BnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 20:43:16 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:43897 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755202Ab2K3BnO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 20:43:14 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so13169118iea.19
        for <git@vger.kernel.org>; Thu, 29 Nov 2012 17:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=V0jGSOp6DGawebnBjDX4VgG0xhoryi31VtAJxPuN7hI=;
        b=j70bjhZjbq3WpgLjIHhSEA9PwaVlmL+zpJNT0GFHzFZIkNrTmq34K1ezDfmmG/F7Vq
         wZVslleaNBGkvwhOuw+7o6+P1e0RmLXAZr+Ptt4X7Aw1ALg4ZTaKtUOF+8o4vT4RPmOY
         bxtXUhNF0t+YMjN7yJEQ+xVkwYrRi4fqX+cssG36fV4LUbVigRC1QxvyStwZsH53sDCu
         kJZFlza1w99+uP1OCn11TQaZtLpmWaf8Q9F+rdc2nQjEjRCAZKukCpTJJ3SM401ibIws
         qantO0dMihSGkNZO8sQGGIpTR+CHKwLovwx9W/nAJHP2iVQaQpNg7ouq9gmvLOqtZiEE
         EluA==
Received: by 10.43.1.65 with SMTP id np1mr21831611icb.23.1354239793901;
        Thu, 29 Nov 2012 17:43:13 -0800 (PST)
Received: from marlin.localdomain ([70.131.98.170])
        by mx.google.com with ESMTPS id c3sm8955228igj.1.2012.11.29.17.43.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Nov 2012 17:43:12 -0800 (PST)
X-Mailer: git-send-email 1.8.0.158.g0c4328c
In-Reply-To: <1354239700-3325-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210891>

Advising the user to fetch and merge only makes sense if the rejected
reference is a branch.  If none of the rejections are for branches, just
tell the user the reference already exists.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 builtin/push.c | 11 +++++++++++
 cache.h        |  1 +
 remote.c       | 10 ++++++++++
 transport.c    |  2 ++
 transport.h    |  1 +
 5 files changed, 25 insertions(+)

diff --git a/builtin/push.c b/builtin/push.c
index 9d17fc7..e08485d 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -220,6 +220,10 @@ static const char message_advice_checkout_pull_push[] =
 	   "(e.g. 'git pull') before pushing again.\n"
 	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
 
+static const char message_advice_ref_already_exists[] =
+	N_("Updates were rejected because the destination reference already exists\n"
+	   "in the remote and the update is not a fast-forward.");
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
@@ -272,6 +281,8 @@ static int push_with_options(struct transport *transport, int flags)
 			advise_use_upstream();
 		else
 			advise_checkout_pull_push();
+	} else if (reject_reasons & REJECT_ALREADY_EXISTS) {
+		advise_ref_already_exists();
 	}
 
 	return 1;
diff --git a/cache.h b/cache.h
index dbd8018..d72b64d 100644
--- a/cache.h
+++ b/cache.h
@@ -1002,6 +1002,7 @@ struct ref {
 	unsigned int force:1,
 		merge:1,
 		nonfastforward:1,
+		not_forwardable:1,
 		deletion:1;
 	enum {
 		REF_STATUS_NONE = 0,
diff --git a/remote.c b/remote.c
index 04fd9ea..5101683 100644
--- a/remote.c
+++ b/remote.c
@@ -1279,6 +1279,14 @@ int match_push_refs(struct ref *src, struct ref **dst,
 	return 0;
 }
 
+static inline int is_forwardable(struct ref* ref)
+{
+	if (!prefixcmp(ref->name, "refs/tags/"))
+		return 0;
+
+	return 1;
+}
+
 void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 	int force_update)
 {
@@ -1316,6 +1324,8 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		 *     always allowed.
 		 */
 
+		ref->not_forwardable = !is_forwardable(ref);
+
 		ref->nonfastforward =
 			!ref->deletion &&
 			!is_null_sha1(ref->old_sha1) &&
diff --git a/transport.c b/transport.c
index d4568e7..bc31e8e 100644
--- a/transport.c
+++ b/transport.c
@@ -740,6 +740,8 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 		    ref->status != REF_STATUS_OK)
 			n += print_one_push_status(ref, dest, n, porcelain);
 		if (ref->status == REF_STATUS_REJECT_NONFASTFORWARD) {
+			if (ref->not_forwardable)
+				*reject_reasons |= REJECT_ALREADY_EXISTS;
 			if (!strcmp(head, ref->name))
 				*reject_reasons |= REJECT_NON_FF_HEAD;
 			else
diff --git a/transport.h b/transport.h
index 404b113..bfd2df5 100644
--- a/transport.h
+++ b/transport.h
@@ -142,6 +142,7 @@ void transport_set_verbosity(struct transport *transport, int verbosity,
 
 #define REJECT_NON_FF_HEAD     0x01
 #define REJECT_NON_FF_OTHER    0x02
+#define REJECT_ALREADY_EXISTS  0x04
 
 int transport_push(struct transport *connection,
 		   int refspec_nr, const char **refspec, int flags,
-- 
1.8.0.158.g0c4328c
