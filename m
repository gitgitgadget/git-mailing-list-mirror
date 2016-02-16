From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 13/15] compat: die when unable to set core.precomposeunicode
Date: Tue, 16 Feb 2016 13:56:40 +0100
Message-ID: <1455627402-752-14-git-send-email-ps@pks.im>
References: <1455627402-752-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	ps@pks.im, Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 13:59:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfDz-0003ZE-Ub
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 13:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbcBPM7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 07:59:18 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53032 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932216AbcBPM5I (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 07:57:08 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id E633220A17
	for <git@vger.kernel.org>; Tue, 16 Feb 2016 07:57:07 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Tue, 16 Feb 2016 07:57:07 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=4zTb
	HqqwcEMkIlMklsKv8kNphOc=; b=RBhtpic/rG4nz3lhCxsQFwwIR7HxlbFjDad+
	2l4jt7QfDJxnTCm9XufKF0gaVwsVce8Bz7QlKFfqyr4j++CswcTjlSZvA4gZ++uQ
	R3SCq202u2v55IycBNMzxvrxnuv0ODLHvAuXKROG/1AutQlmD+9p8rHkW87S/Ht5
	AHQ7XmI=
X-Sasl-enc: 9qf+IGDO9YSlcyk8DDpVpkLDvHKrzLCMe5YWXn+GORIr 1455627427
Received: from localhost (unknown [46.189.27.162])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5C16468015C;
	Tue, 16 Feb 2016 07:57:07 -0500 (EST)
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1455627402-752-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286349>

When calling `git_config_set` to set 'core.precomposeunicode' we
ignore the return value of the function, which may indicate that
we were unable to write the value back to disk. As the function
is only called by init-db we can and should die when an error
occurs.

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
2.7.1
