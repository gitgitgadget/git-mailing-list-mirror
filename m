From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH 2/7] push: add advice for rejected tag reference
Date: Thu, 22 Nov 2012 22:21:50 -0600
Message-ID: <1353644515-17349-3-git-send-email-chris@rorvick.com>
References: <1353644515-17349-1-git-send-email-chris@rorvick.com>
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
X-From: git-owner@vger.kernel.org Fri Nov 23 05:23:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbknd-0001OK-Kw
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 05:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756080Ab2KWEXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 23:23:16 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35469 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756033Ab2KWEXP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 23:23:15 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so2857476iea.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 20:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=5OZubYEnhUovJeq4qcV5rEMk0YiLVy1qone84RH3p70=;
        b=cZU5Aw7mhpky7LcfFxqQkPlHeZjr0IByZsbJClNBSEYlPpmD6GGJzMbG//CEQVrLSC
         PZ+rkgi9KSYDkMj/Vk89XQLII9i2azrgR2ff9nVJ6pIuvlP1sdiSqBQEYd9qyXemLv06
         +GMsu+rCpBVP07vzH9SAJJYRKIQh0Od9Oz7aOLmOLMhahYX/Ld1My5D8p+WATymAWSri
         mvfjibY78FwrceGc4OqGeXKe8J+wtl0RMsvlSvGQay9VDwqweT0oxD6wpiJAEHn84vi6
         F1LFjeElerFlf04IABwpqS3sXVT2Kypqm52B+xyPdLDRonOtBdQxOsJvcYGl8xADS2Md
         SGDg==
Received: by 10.50.150.174 with SMTP id uj14mr2505518igb.19.1353644595040;
        Thu, 22 Nov 2012 20:23:15 -0800 (PST)
Received: from marlin.localdomain (adsl-70-131-98-170.dsl.emhril.sbcglobal.net. [70.131.98.170])
        by mx.google.com with ESMTPS id l8sm3909944igo.13.2012.11.22.20.23.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Nov 2012 20:23:14 -0800 (PST)
X-Mailer: git-send-email 1.8.0.209.gf3828dc
In-Reply-To: <1353644515-17349-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210228>

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
index 4a0e7ef..1391983 100644
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
+	} else if (reject_mask & REJECT_ALREADY_EXISTS) {
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
index b0c9f1b..271965e 100644
--- a/transport.c
+++ b/transport.c
@@ -740,6 +740,8 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 		    ref->status != REF_STATUS_OK)
 			n += print_one_push_status(ref, dest, n, porcelain);
 		if (ref->status == REF_STATUS_REJECT_NONFASTFORWARD) {
+			if (ref->not_forwardable)
+				*reject_mask |= REJECT_ALREADY_EXISTS;
 			if (!strcmp(head, ref->name))
 				*reject_mask |= REJECT_NON_FF_HEAD;
 			else
diff --git a/transport.h b/transport.h
index 5f76ca2..7e86352 100644
--- a/transport.h
+++ b/transport.h
@@ -142,6 +142,7 @@ void transport_set_verbosity(struct transport *transport, int verbosity,
 
 #define REJECT_NON_FF_HEAD     0x01
 #define REJECT_NON_FF_OTHER    0x02
+#define REJECT_ALREADY_EXISTS  0x04
 
 int transport_push(struct transport *connection,
 		   int refspec_nr, const char **refspec, int flags,
-- 
1.8.0.209.gf3828dc
