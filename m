From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/3] gpg-interface: provide access to the payload
Date: Fri,  6 Jun 2014 16:15:27 +0200
Message-ID: <558044a975c940d19370394900bb44bf4fb2387d.1402063796.git.git@drmicha.warpmail.net>
References: <cover.1402063795.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 16:15:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wsuvx-0004Ls-0h
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 16:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbaFFOPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 10:15:44 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:52861 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751867AbaFFOPl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jun 2014 10:15:41 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 90561219C7
	for <git@vger.kernel.org>; Fri,  6 Jun 2014 10:15:38 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Fri, 06 Jun 2014 10:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=Ye3YlsRhDsUF9rbCCXkCs7qaI
	vQ=; b=exq0FHWHhxFDlYicC1gN/47B9AlgChwz+RheUrJwg4bgb4UyZVeHbGG/E
	SmZWuSnux2swTCZknAFxfzStaEAkssJAaPORMw0U45bU/YBz/aDls3RSXVblO8nx
	iotZ8pvreAvC5jz2fr6kD+f6rAcADbD9PbLHL9h0tY0DB+UFQ8=
X-Sasl-enc: E0yZ99sy166T6/AyR383RzNGlIlW6GkOnlMSOLV3Zlv5 1402064133
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id B9A1CC007AA;
	Fri,  6 Jun 2014 10:15:33 -0400 (EDT)
X-Mailer: git-send-email 2.0.0.533.gae2e602
In-Reply-To: <cover.1402063795.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250918>

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
index f479331..e9686b2 100644
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
2.0.0.533.gae2e602
