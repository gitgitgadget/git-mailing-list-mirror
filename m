From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv4 2/4] gpg-interface: provide access to the payload
Date: Fri, 27 Jun 2014 16:13:24 +0200
Message-ID: <c22945363b2ffdd69a66463c5bce851aba765b71.1403877431.git.git@drmicha.warpmail.net>
References: <xmqqoaxjb9rr.fsf@gitster.dls.corp.google.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 27 16:13:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0WuN-0007Si-Pu
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 16:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753711AbaF0ONf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 10:13:35 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54631 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753649AbaF0ONf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jun 2014 10:13:35 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5F61220FF3
	for <git@vger.kernel.org>; Fri, 27 Jun 2014 10:13:31 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Fri, 27 Jun 2014 10:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=Xk
	dBb6ZLD/il5QniGA2tXwiIxxA=; b=mjSSvUEqprxIIavYivRQjN9OLttwyPem5m
	r0zFAmkit4rj8N8KG8ip8PMSZHQYtv5f4aU/DKT6Dgoi+fQxklphODryn5tk8LFW
	DN6u/NEY6jhpDLeQcZ6SORF6mm/Bd0Tpe+XXZNzZ90DtxrFCuRinfYXNvGgd+Nxc
	ECe4S9NTk=
X-Sasl-enc: L8FdxVNA6Ict39hx/zIYAV7WP4jeKmPxUlOMwUfJ9WL4 1403878411
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 0A147C007AE;
	Fri, 27 Jun 2014 10:13:30 -0400 (EDT)
X-Mailer: git-send-email 2.0.1.563.g162087b.dirty
In-Reply-To: <xmqqoaxjb9rr.fsf@gitster.dls.corp.google.com>
In-Reply-To: <cover.1403877430.git.git@drmicha.warpmail.net>
References: <cover.1403877430.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252553>

In contrast to tag signatures, commit signatures are put into the
header, that is between the other header parts and commit messages.

Provide access to the commit content sans the signature, which is the
payload that is actually signed. Commit signature verification does the
parsing anyways, and callers may wish to act on or display the commit
object sans the signature.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 commit.c        | 1 +
 gpg-interface.c | 2 ++
 gpg-interface.h | 1 +
 3 files changed, 4 insertions(+)

diff --git a/commit.c b/commit.c
index fb7897c..acb74b5 100644
--- a/commit.c
+++ b/commit.c
@@ -1270,6 +1270,7 @@ void check_commit_signature(const struct commit* commit, struct signature_check
 				      &gpg_output, &gpg_status);
 	if (status && !gpg_output.len)
 		goto out;
+	sigc->payload = strbuf_detach(&payload, NULL);
 	sigc->gpg_output = strbuf_detach(&gpg_output, NULL);
 	sigc->gpg_status = strbuf_detach(&gpg_status, NULL);
 	parse_gpg_output(sigc);
diff --git a/gpg-interface.c b/gpg-interface.c
index e71b59d..ff07012 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -9,10 +9,12 @@ static const char *gpg_program = "gpg";
 
 void signature_check_clear(struct signature_check *sigc)
 {
+	free(sigc->payload);
 	free(sigc->gpg_output);
 	free(sigc->gpg_status);
 	free(sigc->signer);
 	free(sigc->key);
+	sigc->payload = NULL;
 	sigc->gpg_output = NULL;
 	sigc->gpg_status = NULL;
 	sigc->signer = NULL;
diff --git a/gpg-interface.h b/gpg-interface.h
index 9f0784a..37c23da 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -2,6 +2,7 @@
 #define GPG_INTERFACE_H
 
 struct signature_check {
+	char *payload;
 	char *gpg_output;
 	char *gpg_status;
 	char result; /* 0 (not checked),
-- 
2.0.1.563.g162087b.dirty
