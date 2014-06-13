From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 6/6] gpg-interface: provide clear helper for struct signature_check
Date: Fri, 13 Jun 2014 12:42:48 +0200
Message-ID: <8227d9b69bd6f8e8c318908f49bd52b9379f01ba.1402655839.git.git@drmicha.warpmail.net>
References: <cover.1402063795.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 12:43:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvOx9-0007vU-Hn
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 12:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193AbaFMKnD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 06:43:03 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35610 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753179AbaFMKnA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jun 2014 06:43:00 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 0F3A92087A
	for <git@vger.kernel.org>; Fri, 13 Jun 2014 06:43:00 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Fri, 13 Jun 2014 06:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=VD
	t1xBVZXAS5YkwJaCjMrTRwpzA=; b=F2NdSDKeiDqigYU87qcm6m5UdyaWONC5IT
	Mrx94X0wIS/vY1PDK11504WDt+1vZoQ31Aox8iaYGu0iAgGZHVcN3IFELDnDS+48
	FiRwKwCLBGRKv4DsqCyCql6L8CzcEMu4weDm00WdMoO3IMBP/YtdLClUyBn7Tq/3
	xWq7fDVPA=
X-Sasl-enc: EPP5HNAPIALkKz7dGKB+xRtoF4KM36upnMxmBCilvfi0 1402656179
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id B09D6C007AA;
	Fri, 13 Jun 2014 06:42:59 -0400 (EDT)
X-Mailer: git-send-email 2.0.0.426.g37dbf84
In-Reply-To: <cover.1402063795.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1402655838.git.git@drmicha.warpmail.net>
References: <cover.1402655838.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251544>

The struct has been growing members whose malloced memory needs to be
freed. Do this with one helper function so that no malloced memory shall
be left unfreed.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/merge.c         |  6 +-----
 builtin/verify-commit.c |  5 +----
 gpg-interface.c         | 14 ++++++++++++++
 gpg-interface.h         |  1 +
 pretty.c                |  5 +----
 5 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 6a9812a..e50323d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1282,11 +1282,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 				printf(_("Commit %s has a good GPG signature by %s\n"),
 				       hex, signature_check.signer);
 
-			free(signature_check.payload);
-			free(signature_check.gpg_output);
-			free(signature_check.gpg_status);
-			free(signature_check.signer);
-			free(signature_check.key);
+			signature_check_clear(&signature_check);
 		}
 	}
 
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index 69b7c6d..d254fcf 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -32,10 +32,7 @@ static int run_gpg_verify(const unsigned char *sha1, const char *buf, unsigned l
 	if (signature_check.gpg_output)
 		fputs(signature_check.gpg_output, stderr);
 
-	free(signature_check.gpg_output);
-	free(signature_check.gpg_status);
-	free(signature_check.signer);
-	free(signature_check.key);
+	signature_check_clear(&signature_check);
 	return signature_check.result != 'G';
 }
 
diff --git a/gpg-interface.c b/gpg-interface.c
index 8b0e874..ff07012 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -7,6 +7,20 @@
 static char *configured_signing_key;
 static const char *gpg_program = "gpg";
 
+void signature_check_clear(struct signature_check *sigc)
+{
+	free(sigc->payload);
+	free(sigc->gpg_output);
+	free(sigc->gpg_status);
+	free(sigc->signer);
+	free(sigc->key);
+	sigc->payload = NULL;
+	sigc->gpg_output = NULL;
+	sigc->gpg_status = NULL;
+	sigc->signer = NULL;
+	sigc->key = NULL;
+}
+
 void set_signing_key(const char *key)
 {
 	free(configured_signing_key);
diff --git a/gpg-interface.h b/gpg-interface.h
index d727c25..37c23da 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -14,6 +14,7 @@ struct signature_check {
 	char *key;
 };
 
+extern void signature_check_clear(struct signature_check *sigc);
 extern int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key);
 extern int verify_signed_buffer(const char *payload, size_t payload_size, const char *signature, size_t signature_size, struct strbuf *gpg_output, struct strbuf *gpg_status);
 extern int git_gpg_config(const char *, const char *, void *);
diff --git a/pretty.c b/pretty.c
index 24fb877..ac901b8 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1537,10 +1537,7 @@ void format_commit_message(const struct commit *commit,
 
 	free(context.commit_encoding);
 	logmsg_free(context.message, commit);
-	free(context.signature_check.payload);
-	free(context.signature_check.gpg_output);
-	free(context.signature_check.gpg_status);
-	free(context.signature_check.signer);
+	signature_check_clear(&context.signature_check);
 }
 
 static void pp_header(struct pretty_print_context *pp,
-- 
2.0.0.426.g37dbf84
