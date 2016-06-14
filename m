From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] gpg-interface: check gpg signature for correct header
Date: Tue, 14 Jun 2016 13:11:19 +0200
Message-ID: <2f473a993b6bc951dec76d38c11d0e600b59b8d3.1465902530.git.git@drmicha.warpmail.net>
References: <e129da8e-4e1d-c535-ca62-d2a4c2e23799@drmicha.warpmail.net>
Cc: Jeff King <peff@peff.net>, ZhenTian <loooseleaves@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 13:11:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCmFr-0006y4-2R
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 13:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbcFNLLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 07:11:25 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45310 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751140AbcFNLLW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2016 07:11:22 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 0633822098;
	Tue, 14 Jun 2016 07:11:20 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute7.internal (MEProxy); Tue, 14 Jun 2016 07:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:date:from:in-reply-to:message-id:references:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=ZuQKzbSZGUqS8hF03WSdHFTmTMo
	=; b=B36crNTS2AxVa5ND5ifZp6om7cdJWmkHvF0pqr77v8OYPLOzoj7Iy0/1FWB
	Gt8vFC8j29Z0RDO0SwTc46krSt5lE4wwLECFPKw/k+HDSAkbWjYh3UpmT7oyCIfA
	dJd5ZzZ4JhiOQM33bhBo6pMonluu6s8RY9efkSjlSAKHSvvs=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=ZuQK
	zbSZGUqS8hF03WSdHFTmTMo=; b=eLuoJ2BUHaJA0UaT+T7UvEnyVK6wbu4tkOJF
	YNAdHk0pojGDc55aouTdfrlbcTSi962qmETxYsRSpCueMEGMT/rPVqBFvH8uu7Hn
	qSGCLMUXXHqofxyFj47FB21fYJUHPxhI4fqBuviezQPa9RuNVe8WtmJPwSW/NteF
	cTnY6oQ=
X-Sasl-enc: +mNVo7+RNH4FSL1vyC6JwZdxUGP0Xm5h2cmDeqoVds4p 1465902680
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7B58AF29EE;
	Tue, 14 Jun 2016 07:11:20 -0400 (EDT)
X-Mailer: git-send-email 2.9.0.382.g87fd384
In-Reply-To: <e129da8e-4e1d-c535-ca62-d2a4c2e23799@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297286>

When we create a signature, it may happen that gpg returns with
"success" but not with an actual detached signature on stdout.

Check for the correct header to catch these cases better.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
This catches at least my echo example.

We could do a full blown gpg signature check, of course.

 gpg-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index c4b1e8c..664796f 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -185,7 +185,7 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
 
 	sigchain_pop(SIGPIPE);
 
-	if (finish_command(&gpg) || !len || len < 0)
+	if (finish_command(&gpg) || !len || len < 0 || strncmp(signature->buf, PGP_SIGNATURE, strlen(PGP_SIGNATURE)))
 		return error(_("gpg failed to sign the data"));
 
 	/* Strip CR from the line endings, in case we are on Windows. */
-- 
2.9.0.382.g87fd384
