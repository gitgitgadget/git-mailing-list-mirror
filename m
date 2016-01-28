From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 9/9] compat: die when unable to set core.precomposeunicode
Date: Thu, 28 Jan 2016 10:00:37 +0100
Message-ID: <1453971637-22273-10-git-send-email-ps@pks.im>
References: <1453971637-22273-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 10:01:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOiS6-0007A6-LI
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 10:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934355AbcA1JBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 04:01:05 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55805 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755230AbcA1JAx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2016 04:00:53 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 1774921F05
	for <git@vger.kernel.org>; Thu, 28 Jan 2016 04:00:53 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Thu, 28 Jan 2016 04:00:53 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=hfoh
	lfHpdNWT5WAWcRc2JAatWCo=; b=gLeT03ebT+RMCGn9G6hk0EFOZ8KoNYzJiMur
	kmHja7W2a3wrXhnuHXLgNQK6PHvXMbDr+FobHn+YZfow4/r8S6W7F5dKPZD2ocL+
	oC1bXM+i88rAW0Bm9oYzUiHMxixzBQvTaHJQLKGDpLAJSerTDI6K214Y967BFsX0
	o/3Qccs=
X-Sasl-enc: ljUqbNJwzKHcb62QJwFqj73pulmU46rW33VSi+weGFb3 1453971652
Received: from localhost (f052174253.adsl.alicedsl.de [78.52.174.253])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7CAB5C0001D;
	Thu, 28 Jan 2016 04:00:52 -0500 (EST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1453971637-22273-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284998>

When calling `git_config_set` to set 'core.precomposeunicode' we
ignore the return value of the function, which may indicate that
we were unable to write the value back to disk.

As surrounding code is already dying when an error occurs we
simply die and print an error message when we are unable to write
the config value.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/precompose_utf8.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 079070f..9ff1ebe 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -50,7 +50,8 @@ void probe_utf8_pathname_composition(void)
 		close(output_fd);
 		git_path_buf(&path, "%s", auml_nfd);
 		precomposed_unicode = access(path.buf, R_OK) ? 0 : 1;
-		git_config_set("core.precomposeunicode", precomposed_unicode ? "true" : "false");
+		git_config_set_or_die("core.precomposeunicode",
+				      precomposed_unicode ? "true" : "false");
 		git_path_buf(&path, "%s", auml_nfc);
 		if (unlink(path.buf))
 			die_errno(_("failed to unlink '%s'"), path.buf);
-- 
2.7.0
