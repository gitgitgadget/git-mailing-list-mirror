From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 13/15] compat: die when unable to set core.precomposeunicode
Date: Tue,  2 Feb 2016 12:51:54 +0100
Message-ID: <1454413916-31984-14-git-send-email-ps@pks.im>
References: <1454413916-31984-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 12:53:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQZWU-0007bl-26
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 12:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755030AbcBBLxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 06:53:25 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54478 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754995AbcBBLxW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2016 06:53:22 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 77DEB202C7
	for <git@vger.kernel.org>; Tue,  2 Feb 2016 06:53:22 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Tue, 02 Feb 2016 06:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=2Fun
	b/qgndfaXc0i4aMkIw5RaEo=; b=A4jL9T0UGelxJDvV/aaOUl12ObyXgREQX06b
	iKdV2Uy4tM1iLBWFOGMIl0z3iaceBeqK2JyQ5pBy8A3ZM24PlN0yteDJLqYcoykq
	nbc9F4g7B5x6DbKWXFNB6BLK0FhuHSiWDpWKx+qRtqQAMrLBwdGyU3cI9QoS3qJo
	4LFeZSI=
X-Sasl-enc: VHDmkvEqlndU7NAOp+BsKVDOFBd+LzRvBgiFQ7QgOhMN 1454414002
Received: from localhost (f052008117.adsl.alicedsl.de [78.52.8.117])
	by mail.messagingengine.com (Postfix) with ESMTPA id 0B8B5680176;
	Tue,  2 Feb 2016 06:53:21 -0500 (EST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454413916-31984-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285261>

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
2.7.0
