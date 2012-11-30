From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v6 1/8] push: return reject reasons as a bitset
Date: Thu, 29 Nov 2012 19:41:33 -0600
Message-ID: <1354239700-3325-2-git-send-email-chris@rorvick.com>
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
X-From: git-owner@vger.kernel.org Fri Nov 30 02:44:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeFdf-0006sW-KR
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 02:43:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755415Ab2K3BnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 20:43:14 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:41967 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303Ab2K3BnL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 20:43:11 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so11433874iay.19
        for <git@vger.kernel.org>; Thu, 29 Nov 2012 17:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=1H9+m+q1KiOPCFzh4drBV4K9qzx15kT2iaBymstH77Q=;
        b=GtmwNyRrUOHfvGlugoVMejAMwt+bbsirrKaxBJbHoblaYeLVnbvaw/J/vCnSM0pVa8
         76jjOjiviCUJpC8fYVF+vLQNfuP7aHwF78MOj6AIqcawacDMiiKHQkxcVQOAA761Lv4D
         Ei6ljWojBnwzCZ7DE6KwF27DfSGgRsVcYvEsR0BLvGGkKHo8MIXQA5QhOYW+B3WB7/az
         P/z3G33HCGFJUxME7moaNtd1cZ+T4pxXDVxxRPkaCJoTi2BbjyFq9FpE5g3CZ/9S3eMK
         LjP1TE6E9bykdFh9uzfY486DnoQ0JoOdtRdIihNL04lQBtUjA+5uGaHzAgYDnTDtI0D0
         9lNA==
Received: by 10.42.54.211 with SMTP id s19mr21839282icg.34.1354239791590;
        Thu, 29 Nov 2012 17:43:11 -0800 (PST)
Received: from marlin.localdomain ([70.131.98.170])
        by mx.google.com with ESMTPS id c3sm8955228igj.1.2012.11.29.17.43.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Nov 2012 17:43:10 -0800 (PST)
X-Mailer: git-send-email 1.8.0.158.g0c4328c
In-Reply-To: <1354239700-3325-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210894>

Pass all rejection reasons back from transport_push().  The logic is
simpler and more flexible with regard to providing useful feedback.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 builtin/push.c      | 13 ++++---------
 builtin/send-pack.c |  4 ++--
 transport.c         | 17 ++++++++---------
 transport.h         |  9 +++++----
 4 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index db9ba30..9d17fc7 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -244,7 +244,7 @@ static void advise_checkout_pull_push(void)
 static int push_with_options(struct transport *transport, int flags)
 {
 	int err;
-	int nonfastforward;
+	unsigned int reject_reasons;
 
 	transport_set_verbosity(transport, verbosity, progress);
 
@@ -257,7 +257,7 @@ static int push_with_options(struct transport *transport, int flags)
 	if (verbosity > 0)
 		fprintf(stderr, _("Pushing to %s\n"), transport->url);
 	err = transport_push(transport, refspec_nr, refspec, flags,
-			     &nonfastforward);
+			     &reject_reasons);
 	if (err != 0)
 		error(_("failed to push some refs to '%s'"), transport->url);
 
@@ -265,18 +265,13 @@ static int push_with_options(struct transport *transport, int flags)
 	if (!err)
 		return 0;
 
-	switch (nonfastforward) {
-	default:
-		break;
-	case NON_FF_HEAD:
+	if (reject_reasons & REJECT_NON_FF_HEAD) {
 		advise_pull_before_push();
-		break;
-	case NON_FF_OTHER:
+	} else if (reject_reasons & REJECT_NON_FF_OTHER) {
 		if (default_matching_used)
 			advise_use_upstream();
 		else
 			advise_checkout_pull_push();
-		break;
 	}
 
 	return 1;
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index d342013..9f98607 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -85,7 +85,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	int send_all = 0;
 	const char *receivepack = "git-receive-pack";
 	int flags;
-	int nonfastforward = 0;
+	unsigned int reject_reasons;
 	int progress = -1;
 
 	argv++;
@@ -223,7 +223,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	ret |= finish_connect(conn);
 
 	if (!helper_status)
-		transport_print_push_status(dest, remote_refs, args.verbose, 0, &nonfastforward);
+		transport_print_push_status(dest, remote_refs, args.verbose, 0, &reject_reasons);
 
 	if (!args.dry_run && remote) {
 		struct ref *ref;
diff --git a/transport.c b/transport.c
index 9932f40..d4568e7 100644
--- a/transport.c
+++ b/transport.c
@@ -714,7 +714,7 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count, i
 }
 
 void transport_print_push_status(const char *dest, struct ref *refs,
-				  int verbose, int porcelain, int *nonfastforward)
+				  int verbose, int porcelain, unsigned int *reject_reasons)
 {
 	struct ref *ref;
 	int n = 0;
@@ -733,18 +733,17 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 		if (ref->status == REF_STATUS_OK)
 			n += print_one_push_status(ref, dest, n, porcelain);
 
-	*nonfastforward = 0;
+	*reject_reasons = 0;
 	for (ref = refs; ref; ref = ref->next) {
 		if (ref->status != REF_STATUS_NONE &&
 		    ref->status != REF_STATUS_UPTODATE &&
 		    ref->status != REF_STATUS_OK)
 			n += print_one_push_status(ref, dest, n, porcelain);
-		if (ref->status == REF_STATUS_REJECT_NONFASTFORWARD &&
-		    *nonfastforward != NON_FF_HEAD) {
+		if (ref->status == REF_STATUS_REJECT_NONFASTFORWARD) {
 			if (!strcmp(head, ref->name))
-				*nonfastforward = NON_FF_HEAD;
+				*reject_reasons |= REJECT_NON_FF_HEAD;
 			else
-				*nonfastforward = NON_FF_OTHER;
+				*reject_reasons |= REJECT_NON_FF_OTHER;
 		}
 	}
 }
@@ -1031,9 +1030,9 @@ static void die_with_unpushed_submodules(struct string_list *needs_pushing)
 
 int transport_push(struct transport *transport,
 		   int refspec_nr, const char **refspec, int flags,
-		   int *nonfastforward)
+		   unsigned int *reject_reasons)
 {
-	*nonfastforward = 0;
+	*reject_reasons = 0;
 	transport_verify_remote_names(refspec_nr, refspec);
 
 	if (transport->push) {
@@ -1099,7 +1098,7 @@ int transport_push(struct transport *transport,
 		if (!quiet || err)
 			transport_print_push_status(transport->url, remote_refs,
 					verbose | porcelain, porcelain,
-					nonfastforward);
+					reject_reasons);
 
 		if (flags & TRANSPORT_PUSH_SET_UPSTREAM)
 			set_upstreams(transport, remote_refs, pretend);
diff --git a/transport.h b/transport.h
index 4a61c0c..404b113 100644
--- a/transport.h
+++ b/transport.h
@@ -140,11 +140,12 @@ int transport_set_option(struct transport *transport, const char *name,
 void transport_set_verbosity(struct transport *transport, int verbosity,
 	int force_progress);
 
-#define NON_FF_HEAD 1
-#define NON_FF_OTHER 2
+#define REJECT_NON_FF_HEAD     0x01
+#define REJECT_NON_FF_OTHER    0x02
+
 int transport_push(struct transport *connection,
 		   int refspec_nr, const char **refspec, int flags,
-		   int * nonfastforward);
+		   unsigned int * reject_reasons);
 
 const struct ref *transport_get_remote_refs(struct transport *transport);
 
@@ -170,7 +171,7 @@ void transport_update_tracking_ref(struct remote *remote, struct ref *ref, int v
 int transport_refs_pushed(struct ref *ref);
 
 void transport_print_push_status(const char *dest, struct ref *refs,
-		  int verbose, int porcelain, int *nonfastforward);
+		  int verbose, int porcelain, unsigned int *reject_reasons);
 
 typedef void alternate_ref_fn(const struct ref *, void *);
 extern void for_each_alternate_ref(alternate_ref_fn, void *);
-- 
1.8.0.158.g0c4328c
