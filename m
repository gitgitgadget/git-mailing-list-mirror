From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv4 1/4] gpg-interface: provide clear helper for struct signature_check
Date: Fri, 27 Jun 2014 16:13:23 +0200
Message-ID: <0a49d22936ffa4ffea1fa25b09b829b7b64d2e51.1403877430.git.git@drmicha.warpmail.net>
References: <xmqqoaxjb9rr.fsf@gitster.dls.corp.google.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 27 16:13:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0WuO-0007Si-AB
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 16:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731AbaF0ONh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 10:13:37 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57062 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753613AbaF0ONf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jun 2014 10:13:35 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 8744020EA8;
	Fri, 27 Jun 2014 10:13:29 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Fri, 27 Jun 2014 10:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=cR
	zI7D4ti549d+PE7ndm0B/GkzI=; b=HXx1yuFzvJXk1EMuwC5kSjsGjcfxjZq/O/
	IL5kg9yxXKC90ntZaWKjmxz4QUkOieL5+Yw0d3iamZWjThgjJ5JV/iybULXUkSK7
	8MK2Hsh3L1JGOjMb8PUiMmIcL0EExrpQLvOOOlgxBWuXIB7W5bDS5yfNiSGQJbrB
	/bgerWiXA=
X-Sasl-enc: wOc35B+823No0bmaD/ahel0Tt0I/Ze1pRLEo1kyBlVmj 1403878409
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7D783680097;
	Fri, 27 Jun 2014 10:13:29 -0400 (EDT)
X-Mailer: git-send-email 2.0.1.563.g162087b.dirty
In-Reply-To: <xmqqoaxjb9rr.fsf@gitster.dls.corp.google.com>
In-Reply-To: <cover.1403877430.git.git@drmicha.warpmail.net>
References: <cover.1403877430.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252556>

The struct has been growing members whose malloced memory needs to be
freed. Do this with one helper function so that no malloced memory shall
be left unfreed.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/merge.c |  5 +----
 gpg-interface.c | 12 ++++++++++++
 gpg-interface.h |  1 +
 pretty.c        |  3 +--
 4 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index b49c310..86e9c61 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1282,10 +1282,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 				printf(_("Commit %s has a good GPG signature by %s\n"),
 				       hex, signature_check.signer);
 
-			free(signature_check.gpg_output);
-			free(signature_check.gpg_status);
-			free(signature_check.signer);
-			free(signature_check.key);
+			signature_check_clear(&signature_check);
 		}
 	}
 
diff --git a/gpg-interface.c b/gpg-interface.c
index 8b0e874..e71b59d 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -7,6 +7,18 @@
 static char *configured_signing_key;
 static const char *gpg_program = "gpg";
 
+void signature_check_clear(struct signature_check *sigc)
+{
+	free(sigc->gpg_output);
+	free(sigc->gpg_status);
+	free(sigc->signer);
+	free(sigc->key);
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
index a85cb5b..9f0784a 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -13,6 +13,7 @@ struct signature_check {
 	char *key;
 };
 
+extern void signature_check_clear(struct signature_check *sigc);
 extern int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key);
 extern int verify_signed_buffer(const char *payload, size_t payload_size, const char *signature, size_t signature_size, struct strbuf *gpg_output, struct strbuf *gpg_status);
 extern int git_gpg_config(const char *, const char *, void *);
diff --git a/pretty.c b/pretty.c
index ce3bbaa..353af81 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1520,8 +1520,7 @@ void format_commit_message(const struct commit *commit,
 
 	free(context.commit_encoding);
 	unuse_commit_buffer(commit, context.message);
-	free(context.signature_check.gpg_output);
-	free(context.signature_check.signer);
+	signature_check_clear(&context.signature_check);
 }
 
 static void pp_header(struct pretty_print_context *pp,
-- 
2.0.1.563.g162087b.dirty
