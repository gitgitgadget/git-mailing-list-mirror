From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v4 2/5] push: add advice for rejected tag reference
Date: Sat, 17 Nov 2012 14:16:34 -0600
Message-ID: <1353183397-17719-3-git-send-email-chris@rorvick.com>
References: <1353183397-17719-1-git-send-email-chris@rorvick.com>
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
X-From: git-owner@vger.kernel.org Sat Nov 17 21:17:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZop7-0007U8-Ps
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 21:17:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212Ab2KQUQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2012 15:16:54 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:41760 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171Ab2KQUQw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 15:16:52 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so5173856iea.19
        for <git@vger.kernel.org>; Sat, 17 Nov 2012 12:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=a5ywKecidVpLSvQuOhk8QZE2CKqBP3e0B1eTC+WgNUw=;
        b=qhoeH6/VH6USTiXFyn3nN1YywnveEyYvtStVE3Bk4vfSZgPvT8WyZq8cmKaYDyjQjL
         g3RDQ8xZMSxDxiqu+/6xljLcsskZ94LSji2n7/UHr/w+JcA2bAhHxuhdVMfkyW5og9BW
         +9RRtjVecloOlSG8iEuWydesOU4AqPJLgypubPks1IjYbjtCOwbBxDjaCcXeUE8rDsej
         ZYs8fgYygC4x59UmqtPODxGhZAZYsKPFs06HLOqzwnsz6sB7AY8DB0R4VXdBkTX08v66
         kU88mBBLqwfwoQgr9QMTl5/cdimn/8EXIKUuWRbPEcou1vnId3+z+Qv76IaoZrq+iNZ2
         q08g==
Received: by 10.50.163.99 with SMTP id yh3mr2727428igb.29.1353183412099;
        Sat, 17 Nov 2012 12:16:52 -0800 (PST)
Received: from marlin.localdomain (207-179-211-84.mtco.com. [207.179.211.84])
        by mx.google.com with ESMTPS id wm10sm3269004igc.2.2012.11.17.12.16.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 17 Nov 2012 12:16:51 -0800 (PST)
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1353183397-17719-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209975>

Advising the user to fetch and merge only makes sense if the rejected
reference is a branch.  If none of the rejections were for branches,
tell the user they need to force the update(s).

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 builtin/push.c | 15 +++++++++++++--
 cache.h        |  1 +
 remote.c       |  2 ++
 transport.c    |  6 ++++--
 transport.h    |  5 +++--
 5 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index eaeaf7e..0e13e11 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -220,6 +220,10 @@ static const char message_advice_checkout_pull_push[] =
 	   "(e.g. 'git pull') before pushing again.\n"
 	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
 
+static const char message_advice_ref_already_exists[] =
+	N_("Updates were rejected because a matching reference already exists in\n"
+	   "the remote and the update is not a fast-forward.");
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
@@ -265,13 +274,15 @@ static int push_with_options(struct transport *transport, int flags)
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
index dbd8018..82dead1 100644
--- a/cache.h
+++ b/cache.h
@@ -1002,6 +1002,7 @@ struct ref {
 	unsigned int force:1,
 		merge:1,
 		nonfastforward:1,
+		is_a_tag:1,
 		deletion:1;
 	enum {
 		REF_STATUS_NONE = 0,
diff --git a/remote.c b/remote.c
index 04fd9ea..186814d 100644
--- a/remote.c
+++ b/remote.c
@@ -1316,6 +1316,8 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		 *     always allowed.
 		 */
 
+		ref->is_a_tag = !prefixcmp(ref->name, "refs/tags/");
+
 		ref->nonfastforward =
 			!ref->deletion &&
 			!is_null_sha1(ref->old_sha1) &&
diff --git a/transport.c b/transport.c
index ae9fda8..5fcaea8 100644
--- a/transport.c
+++ b/transport.c
@@ -740,10 +740,12 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 		    ref->status != REF_STATUS_OK)
 			n += print_one_push_status(ref, dest, n, porcelain);
 		if (ref->status == REF_STATUS_REJECT_NONFASTFORWARD) {
+			if (!ref->is_a_tag)
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
1.8.0.155.g3a063ad.dirty
