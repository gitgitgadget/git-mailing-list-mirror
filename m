From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 04/10] push: support multiple levels of verbosity
Date: Thu, 18 Feb 2010 20:37:05 +0800
Message-ID: <1266496631-3980-5-git-send-email-rctay89@gmail.com>
References: <1266496631-3980-1-git-send-email-rctay89@gmail.com>
Cc: "Jeff King" <peff@peff.net>,
	"Sebastian Thiel" <byronimo@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 18 13:38:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni5e4-0004Ez-17
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 13:38:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758166Ab0BRMhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 07:37:47 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:60410 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758149Ab0BRMhp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 07:37:45 -0500
Received: by mail-yx0-f200.google.com with SMTP id 38so6323162yxe.4
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 04:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ZI3w9YCS6CXAC8W0H1HnEIfNomrRDuGpDmTH2zaki90=;
        b=cjMc4ibxaRN/XMzxw+53JZa9EXYONwPyFSizUXzCVBzeAXhtdIUmsEwWP8CXCPEtra
         FUyKUyWoBZqeFKm+nmibOZxTW5cc8CKAOGazPoHhyeA3LV19rNjBniJr/XbnmDQSQVTw
         UpJEbZJX8CmYPipAuVVQxcoF9qKe+rdnw+bQE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rdh0t23Zhpzd0ZP7LNx+xKpfeiJElJp2WimgCuXivmtKudZZTJg9OCRNlO1+5VFmCZ
         pxLq5nW2v52t7rpqTSfcdq35/1cmWvTpnEWYNBNAPNZ34tGXlG2teCWH9OIkOgT/OSE3
         QIbH4rKEhhRvHyys6EBN3HWFD9BqcaMPC6Rhs=
Received: by 10.101.132.8 with SMTP id j8mr9273593ann.44.1266496665122;
        Thu, 18 Feb 2010 04:37:45 -0800 (PST)
Received: from localhost.localdomain (cm91.zeta153.maxonline.com.sg [116.87.153.91])
        by mx.google.com with ESMTPS id 21sm381013ywh.17.2010.02.18.04.37.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 04:37:44 -0800 (PST)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <1266496631-3980-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140330>

Remove the flags TRANSPORT_PUSH_QUIET and TRANSPORT_PUSH_VERBOSE; use
transport->verbose instead to determine verbosity for pushing.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 builtin-push.c     |    9 ++++++---
 transport-helper.c |    1 -
 transport.c        |    8 ++++----
 transport.h        |    2 --
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 5633f0a..0082dad 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -17,6 +17,7 @@ static const char * const push_usage[] = {
 static int thin;
 static int deleterefs;
 static const char *receivepack;
+static int verbosity;
 
 static const char **refspec;
 static int refspec_nr;
@@ -105,13 +106,16 @@ static int push_with_options(struct transport *transport, int flags)
 {
 	int err;
 	int nonfastforward;
+
+	transport_set_verbosity(transport, verbosity);
+
 	if (receivepack)
 		transport_set_option(transport,
 				     TRANS_OPT_RECEIVEPACK, receivepack);
 	if (thin)
 		transport_set_option(transport, TRANS_OPT_THIN, "yes");
 
-	if (flags & TRANSPORT_PUSH_VERBOSE)
+	if (verbosity > 0)
 		fprintf(stderr, "Pushing to %s\n", transport->url);
 	err = transport_push(transport, refspec_nr, refspec, flags,
 			     &nonfastforward);
@@ -204,8 +208,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	int rc;
 	const char *repo = NULL;	/* default repository */
 	struct option options[] = {
-		OPT_BIT('q', "quiet", &flags, "be quiet", TRANSPORT_PUSH_QUIET),
-		OPT_BIT('v', "verbose", &flags, "be verbose", TRANSPORT_PUSH_VERBOSE),
+		OPT__VERBOSITY(&verbosity),
 		OPT_STRING( 0 , "repo", &repo, "repository", "repository"),
 		OPT_BIT( 0 , "all", &flags, "push all refs", TRANSPORT_PUSH_ALL),
 		OPT_BIT( 0 , "mirror", &flags, "mirror all refs",
diff --git a/transport-helper.c b/transport-helper.c
index 1077428..3d33697 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -576,7 +576,6 @@ static int push_refs(struct transport *transport,
 	if (buf.len == 0)
 		return 0;
 
-	transport->verbose = flags & TRANSPORT_PUSH_VERBOSE ? 1 : 0;
 	standard_options(transport);
 
 	if (flags & TRANSPORT_PUSH_DRY_RUN) {
diff --git a/transport.c b/transport.c
index 1632c4d..0655f65 100644
--- a/transport.c
+++ b/transport.c
@@ -788,8 +788,8 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	args.send_mirror = !!(flags & TRANSPORT_PUSH_MIRROR);
 	args.force_update = !!(flags & TRANSPORT_PUSH_FORCE);
 	args.use_thin_pack = data->options.thin;
-	args.verbose = !!(flags & TRANSPORT_PUSH_VERBOSE);
-	args.quiet = !!(flags & TRANSPORT_PUSH_QUIET);
+	args.verbose = (transport->verbose > 0);
+	args.quiet = (transport->verbose < 0);
 	args.dry_run = !!(flags & TRANSPORT_PUSH_DRY_RUN);
 
 	ret = send_pack(&args, data->fd, data->conn, remote_refs,
@@ -1039,8 +1039,8 @@ int transport_push(struct transport *transport,
 			transport->get_refs_list(transport, 1);
 		struct ref *local_refs = get_local_heads();
 		int match_flags = MATCH_REFS_NONE;
-		int verbose = flags & TRANSPORT_PUSH_VERBOSE;
-		int quiet = flags & TRANSPORT_PUSH_QUIET;
+		int verbose = (transport->verbose > 0);
+		int quiet = (transport->verbose < 0);
 		int porcelain = flags & TRANSPORT_PUSH_PORCELAIN;
 		int pretend = flags & TRANSPORT_PUSH_DRY_RUN;
 		int ret, err;
diff --git a/transport.h b/transport.h
index 7d1a0b6..c0743b1 100644
--- a/transport.h
+++ b/transport.h
@@ -88,9 +88,7 @@ struct transport {
 #define TRANSPORT_PUSH_FORCE 2
 #define TRANSPORT_PUSH_DRY_RUN 4
 #define TRANSPORT_PUSH_MIRROR 8
-#define TRANSPORT_PUSH_VERBOSE 16
 #define TRANSPORT_PUSH_PORCELAIN 32
-#define TRANSPORT_PUSH_QUIET 64
 #define TRANSPORT_PUSH_SET_UPSTREAM 128
 
 /* Returns a transport suitable for the url */
-- 
1.7.0.27.g5d71b
