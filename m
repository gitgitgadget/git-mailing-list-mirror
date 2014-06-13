From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 2/6] gpg-interface: provide access to the payload
Date: Fri, 13 Jun 2014 12:42:44 +0200
Message-ID: <c774a7be8ccef5c459a6d593cdf2d706a6283f91.1402655839.git.git@drmicha.warpmail.net>
References: <cover.1402063795.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 12:43:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvOx9-0007vU-1K
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 12:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151AbaFMKm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 06:42:59 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60798 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753119AbaFMKm5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jun 2014 06:42:57 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 4B4C420BFB
	for <git@vger.kernel.org>; Fri, 13 Jun 2014 06:42:53 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 13 Jun 2014 06:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=aL
	OovXFAaDRZO4Qg22BPOQjHOK4=; b=BquNyJY8GvPiX5Fxb5ZsP+TkStmUUSBxOL
	gNP+SitAhOfibJFoswHYVfjKS3JGZpx+QemDFZHe3fAxOFHeUBBV7fsm7zsEbZF9
	/lvbeHHCFiXTS8B4bPuQuYl9dIsjpSW9ylCSwcEx9f7CLVaSETCzxug7xxeExTRT
	zc+72Kwbg=
X-Sasl-enc: o0Fc9mqUSfcrQVt/YMPZIqVbiSrzoBpnbZqIXSVAZYAW 1402656173
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 22C4AC007AB;
	Fri, 13 Jun 2014 06:42:53 -0400 (EDT)
X-Mailer: git-send-email 2.0.0.426.g37dbf84
In-Reply-To: <cover.1402063795.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1402655838.git.git@drmicha.warpmail.net>
References: <cover.1402655838.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251542>

In contrast to tag signatures, commit signatures are put into the
header, that is between the other header parts and commit messages.

Provide access to the commit content sans the signature, which is the
payload that is actually signed. Commit signature verification does the
parsing anyways, and callers may wish to act on or display the commit
object sans the signature.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/merge.c | 1 +
 commit.c        | 1 +
 gpg-interface.h | 1 +
 pretty.c        | 1 +
 4 files changed, 4 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index 428ca24..6a9812a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1282,6 +1282,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 				printf(_("Commit %s has a good GPG signature by %s\n"),
 				       hex, signature_check.signer);
 
+			free(signature_check.payload);
 			free(signature_check.gpg_output);
 			free(signature_check.gpg_status);
 			free(signature_check.signer);
diff --git a/commit.c b/commit.c
index 881be3b..d0ad7f0 100644
--- a/commit.c
+++ b/commit.c
@@ -1219,6 +1219,7 @@ void check_commit_signature(const struct commit* commit, struct signature_check
 				      &gpg_output, &gpg_status);
 	if (status && !gpg_output.len)
 		goto out;
+	sigc->payload = strbuf_detach(&payload, NULL);
 	sigc->gpg_output = strbuf_detach(&gpg_output, NULL);
 	sigc->gpg_status = strbuf_detach(&gpg_status, NULL);
 	parse_gpg_output(sigc);
diff --git a/gpg-interface.h b/gpg-interface.h
index a85cb5b..d727c25 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -2,6 +2,7 @@
 #define GPG_INTERFACE_H
 
 struct signature_check {
+	char *payload;
 	char *gpg_output;
 	char *gpg_status;
 	char result; /* 0 (not checked),
diff --git a/pretty.c b/pretty.c
index f1e8a70..24fb877 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1537,6 +1537,7 @@ void format_commit_message(const struct commit *commit,
 
 	free(context.commit_encoding);
 	logmsg_free(context.message, commit);
+	free(context.signature_check.payload);
 	free(context.signature_check.gpg_output);
 	free(context.signature_check.gpg_status);
 	free(context.signature_check.signer);
-- 
2.0.0.426.g37dbf84
