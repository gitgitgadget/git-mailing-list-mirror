From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCHv2 1/3] gpg: Close stderr once finished with it in verify_signed_buffer()
Date: Thu, 31 Jan 2013 10:18:40 -0800
Message-ID: <1359656320-4434-1-git-send-email-sboyd@codeaurora.org>
References: <20130131055053.GA11912@sigill.intra.peff.net>
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 31 19:19:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0yj2-0002QB-TD
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 19:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754942Ab3AaSSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 13:18:43 -0500
Received: from wolverine01.qualcomm.com ([199.106.114.254]:16998 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752Ab3AaSSm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 13:18:42 -0500
X-IronPort-AV: E=Sophos;i="4.84,578,1355126400"; 
   d="scan'208";a="23265115"
Received: from pdmz-ns-snip_114_130.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine01.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Jan 2013 10:18:42 -0800
Received: from sboyd-linux.qualcomm.com (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 019BA10004C7;
	Thu, 31 Jan 2013 10:18:41 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.442.gfb9beb5
In-reply-to: <20130131055053.GA11912@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215139>

Failing to close the stderr pipe in verify_signed_buffer() causes
git to run out of file descriptors if there are many calls to
verify_signed_buffer(). An easy way to trigger this is to run

 git log --show-signature --merges | grep "key"

on the linux kernel git repo. Eventually it will fail with

 error: cannot create pipe for gpg: Too many open files
 error: could not run gpg.

Close the stderr pipe so that this can't happen.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 gpg-interface.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 0863c61..5f142f6 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -130,8 +130,10 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 	write_in_full(gpg.in, payload, payload_size);
 	close(gpg.in);
 
-	if (gpg_output)
+	if (gpg_output) {
 		strbuf_read(gpg_output, gpg.err, 0);
+		close(gpg.err);
+	}
 	ret = finish_command(&gpg);
 
 	unlink_or_warn(path);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
