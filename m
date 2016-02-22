From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v6 13/15] compat: die when unable to set core.precomposeunicode
Date: Mon, 22 Feb 2016 12:23:34 +0100
Message-ID: <1456140216-24169-14-git-send-email-ps@pks.im>
References: <1456140216-24169-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	ps@pks.im, Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Michael Blume <blume.mike@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 12:25:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXoc6-0000ln-Gk
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 12:25:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697AbcBVLYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 06:24:55 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:33126 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754682AbcBVLYv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2016 06:24:51 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 1925E20C3A
	for <git@vger.kernel.org>; Mon, 22 Feb 2016 06:24:51 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 22 Feb 2016 06:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=4zTb
	HqqwcEMkIlMklsKv8kNphOc=; b=aqA58xswnIArSrDv6CD8dTPxSJ0zqS9NMala
	QfdFu1WHkVtto78iZ5H4r1e5XSkpnEtPfdC+ZX7mVeMIOSq4yZZiX+7YkeczpVlH
	KsFKajwGElOcuM/6XZTvjyscZ+vKW26+vhgBgd1VJwlK/3k06eWTFgL4E2V3yOTD
	K8G+zbc=
X-Sasl-enc: L7/Ftivc62zAi8zC9dmt19G1z/SUENh6kalkuSRb1+dv 1456140290
Received: from localhost (unknown [46.189.27.162])
	by mail.messagingengine.com (Postfix) with ESMTPA id 9A848C00016;
	Mon, 22 Feb 2016 06:24:50 -0500 (EST)
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1456140216-24169-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286919>

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
