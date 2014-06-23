From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 1/5] gpg-interface: provide clear helper for struct signature_check
Date: Mon, 23 Jun 2014 09:05:47 +0200
Message-ID: <872a2ba85cc1d9e6c3be1cd4a882dbf08b7c656d.1403506792.git.git@drmicha.warpmail.net>
References: <cover.1402655838.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 09:06:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WyyKL-0000dg-Qv
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 09:06:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbaFWHF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 03:05:58 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60598 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751221AbaFWHFy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jun 2014 03:05:54 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 6A38F20C53;
	Mon, 23 Jun 2014 03:05:54 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 23 Jun 2014 03:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=FN
	/uMyZxP/AZA9LxS4WXmcDq8Jw=; b=jj2F7vH6jTWkBKv3IVtwmMEAKFPRLNZSKO
	0K4nbDACLaiS6aQJAh/bZY5OCVRqhe+YFZgM4jUu17Kw2oK+RJz/SHwn2D35A8LM
	S9tb/36cBvJvuaKMLlZr1dj6phQq4PV5DLTuYAV/oFa0ev1E4n142qZ9QiS75q58
	owXmFB39M=
X-Sasl-enc: gLZlYs6mp9ei53h4BWWDNM3ZZXylgQn7Qj0xqgXS0NdT 1403507154
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 05EFB6801C0;
	Mon, 23 Jun 2014 03:05:53 -0400 (EDT)
X-Mailer: git-send-email 2.0.0.426.g37dbf84
In-Reply-To: <cover.1402655838.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1403506792.git.git@drmicha.warpmail.net>
References: <cover.1403506792.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252320>

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
index 428ca24..e50323d 100644
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
index 4f51287..ac901b8 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1537,8 +1537,7 @@ void format_commit_message(const struct commit *commit,
 
 	free(context.commit_encoding);
 	logmsg_free(context.message, commit);
-	free(context.signature_check.gpg_output);
-	free(context.signature_check.signer);
+	signature_check_clear(&context.signature_check);
 }
 
 static void pp_header(struct pretty_print_context *pp,
-- 
2.0.0.426.g37dbf84
