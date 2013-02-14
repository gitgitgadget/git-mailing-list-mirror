From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 4/5] pretty: parse the gpg status lines rather than the output
Date: Thu, 14 Feb 2013 17:04:45 +0100
Message-ID: <0e78892fa82498b67ef6cf9316f2dcc73d42c892.1360857415.git.git@drmicha.warpmail.net>
References: <CAJ9Ak2pLqUesOWKNtjwG7P_BW7-EqJP4Kaj0FF_+72Wn=oGoew@mail.gmail.com>
Cc: Mariusz Gronczewski <xani666@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 14 17:05:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U61JE-0004kJ-Qh
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 17:05:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414Ab3BNQEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2013 11:04:53 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40584 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758047Ab3BNQEv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Feb 2013 11:04:51 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id D08A520A21;
	Thu, 14 Feb 2013 11:04:50 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute5.internal (MEProxy); Thu, 14 Feb 2013 11:04:50 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=Sa
	2luIt5eU+f0pnfUgjD+fxIRnw=; b=l+Ksku/AOxH+EHVYjx06E/cN4/8EvPAqto
	8Mzbq5y9k3EpN2q8oOQs+EeQDkBSaZxNEaQNfHMLqoLVoNPnlfsB7MZTuucLxjFR
	/+h+d3ikIsBEWumcs4Ac0KN6YuNUueo9nMxveuNrx4s4ns/de99uQaHXNnaG621W
	PyEs1+R4o=
X-Sasl-enc: IQ623IF5HJkG4B97s6UNgBtCOIWNtja/SNSPwZPBcsGB 1360857890
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 805648E01E8;
	Thu, 14 Feb 2013 11:04:50 -0500 (EST)
X-Mailer: git-send-email 1.8.1.3.797.ge0260c7
In-Reply-To: <CAJ9Ak2pLqUesOWKNtjwG7P_BW7-EqJP4Kaj0FF_+72Wn=oGoew@mail.gmail.com>
In-Reply-To: <cover.1360857415.git.git@drmicha.warpmail.net>
References: <cover.1360857415.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216312>

Currently, parse_signature_lines() parses the gpg output for strings
which depend on LANG so it fails to recognize good commit signatures
(and thus does not fill in %G? and the like) in most locales.

Make it parse the status lines from gpg instead, which are the proper
machine interface. This fixes the problem described above.

There is a change in behavior for "%GS" which we intentionally do not
work around: "%GS" used to put quotes around the signer's uid (or
rather: it inherited from the gpg user output). We output the uid
without quotes now, just like author and committer names.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 pretty.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/pretty.c b/pretty.c
index 2a1e174..973b912 100644
--- a/pretty.c
+++ b/pretty.c
@@ -759,6 +759,7 @@ struct format_commit_context {
 	unsigned commit_signature_parsed:1;
 	struct {
 		char *gpg_output;
+		char *gpg_status;
 		char good_bad;
 		char *signer;
 	} signature;
@@ -948,13 +949,13 @@ static struct {
 	char result;
 	const char *check;
 } signature_check[] = {
-	{ 'G', ": Good signature from " },
-	{ 'B', ": BAD signature from " },
+	{ 'G', "\n[GNUPG:] GOODSIG " },
+	{ 'B', "\n[GNUPG:] BADSIG " },
 };
 
 static void parse_signature_lines(struct format_commit_context *ctx)
 {
-	const char *buf = ctx->signature.gpg_output;
+	const char *buf = ctx->signature.gpg_status;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(signature_check); i++) {
@@ -963,7 +964,7 @@ static void parse_signature_lines(struct format_commit_context *ctx)
 		if (!found)
 			continue;
 		ctx->signature.good_bad = signature_check[i].result;
-		found += strlen(signature_check[i].check);
+		found += strlen(signature_check[i].check)+17;
 		next = strchrnul(found, '\n');
 		ctx->signature.signer = xmemdupz(found, next - found);
 		break;
@@ -975,6 +976,7 @@ static void parse_commit_signature(struct format_commit_context *ctx)
 	struct strbuf payload = STRBUF_INIT;
 	struct strbuf signature = STRBUF_INIT;
 	struct strbuf gpg_output = STRBUF_INIT;
+	struct strbuf gpg_status = STRBUF_INIT;
 	int status;
 
 	ctx->commit_signature_parsed = 1;
@@ -984,13 +986,15 @@ static void parse_commit_signature(struct format_commit_context *ctx)
 		goto out;
 	status = verify_signed_buffer(payload.buf, payload.len,
 				      signature.buf, signature.len,
-				      &gpg_output, NULL);
+				      &gpg_output, &gpg_status);
 	if (status && !gpg_output.len)
 		goto out;
 	ctx->signature.gpg_output = strbuf_detach(&gpg_output, NULL);
+	ctx->signature.gpg_status = strbuf_detach(&gpg_status, NULL);
 	parse_signature_lines(ctx);
 
  out:
+	strbuf_release(&gpg_status);
 	strbuf_release(&gpg_output);
 	strbuf_release(&payload);
 	strbuf_release(&signature);
-- 
1.8.1.3.797.ge0260c7
