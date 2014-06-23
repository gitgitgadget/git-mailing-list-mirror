From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 2/5] gpg-interface: provide access to the payload
Date: Mon, 23 Jun 2014 09:05:48 +0200
Message-ID: <e021b30801f8e917c171643334feb66a2baf61b7.1403506792.git.git@drmicha.warpmail.net>
References: <cover.1402655838.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 09:06:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WyyKb-0000rM-1h
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 09:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbaFWHGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 03:06:04 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59509 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751550AbaFWHGB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jun 2014 03:06:01 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id E600020DAA
	for <git@vger.kernel.org>; Mon, 23 Jun 2014 03:05:55 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 23 Jun 2014 03:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=sC
	/eBdPoWbRXdGFHcHKVIlrRRxU=; b=ojFEcQyo2VBgsKhU+FrxU+ohTgFr7HB2kY
	QlybbsWvMp6ReiQ58uK6TC545vk8h5LCb6HU6RkSw2PhslaDf4hyDcQC1m4EA332
	2kGBU03a4Be81oiDbGS8tH7Cl+mOZqL4oqA9lGvoWkY0Emf9lG4TtdWMXA/JWytV
	rT707KYjQ=
X-Sasl-enc: KQlig1+ckRyN+Ip7+B5K/wVO7dv2iBR/ayYIjm1CWjqe 1403507155
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 77985C00005;
	Mon, 23 Jun 2014 03:05:55 -0400 (EDT)
X-Mailer: git-send-email 2.0.0.426.g37dbf84
In-Reply-To: <cover.1402655838.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1403506792.git.git@drmicha.warpmail.net>
References: <cover.1403506792.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252323>

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
2.0.0.426.g37dbf84
