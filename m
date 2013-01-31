From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH 1/3] gpg: Close stderr once finished with it in verify_signed_buffer()
Date: Wed, 30 Jan 2013 18:01:04 -0800
Message-ID: <1359597666-10108-2-git-send-email-sboyd@codeaurora.org>
References: <1359597666-10108-1-git-send-email-sboyd@codeaurora.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 31 03:01:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0jTO-0008G0-M8
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 03:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754325Ab3AaCBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 21:01:19 -0500
Received: from wolverine01.qualcomm.com ([199.106.114.254]:30435 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755476Ab3AaCBP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 21:01:15 -0500
X-IronPort-AV: E=Sophos;i="4.84,573,1355126400"; 
   d="scan'208";a="23137432"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine01.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Jan 2013 18:01:09 -0800
Received: from sboyd-linux.qualcomm.com (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 20B5810004DC
	for <git@vger.kernel.org>; Wed, 30 Jan 2013 18:01:09 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.439.g50a6b54
In-Reply-To: <1359597666-10108-1-git-send-email-sboyd@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215084>

Failing to close the stderr pipe in verify_signed_buffer() causes
git to run out of file descriptors if there are many calls to
verify_signed_buffer(). An easy way to trigger this is to run

 git log --show-signature --merges | grep "key"

on the linux kernel git repo. Eventually it will fail with

 error: cannot create pipe for gpg: Too many open files
 error: could not run gpg.

Close the stderr pipe so that this can't happen.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 gpg-interface.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/gpg-interface.c b/gpg-interface.c
index 0863c61..2c0bed3 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -133,6 +133,8 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 	if (gpg_output)
 		strbuf_read(gpg_output, gpg.err, 0);
 	ret = finish_command(&gpg);
+	if (gpg_output)
+		close(gpg.err);
 
 	unlink_or_warn(path);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
