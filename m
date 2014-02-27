From: Sun He <sunheehnus@gmail.com>
Subject: [PATCH] Rewrite bulk-checkin.c:finish_bulk_checkin() to use a strbuf for handling packname
Date: Thu, 27 Feb 2014 22:00:01 +0800
Message-ID: <1393509601-31312-1-git-send-email-sunheehnus@gmail.com>
Cc: mhagger@alum.mit.edu, Sun He <sunheehnus@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 27 15:01:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ1X2-0002Tn-7a
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 15:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960AbaB0OBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 09:01:43 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:48006 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbaB0OBl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 09:01:41 -0500
Received: by mail-pa0-f51.google.com with SMTP id kq14so2376605pab.10
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 06:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/F0WvkiwMT2KHY7tY/EbPwnIb3sXkuXyyKN3fGqFZhE=;
        b=mTThYqwIDzNVxp5ZrPfBacVTZZLmii7t+xScYIK6u9lbGLv9lH5POUShYRIj4L2GfG
         ngfiRTRwsnII9vx9gk0LGeDEGKl52mW09dw3E7V2CAn2OM5xbw9wEUCYtpKAM17UtR/q
         /xkz0OahnQ1KzBaDSZXTwNvNoxqaTANLcFEWH0LKQO0FBrzv1LWyoTjgOTshKoHStUBL
         Q9Jg3iVTPSD0syZzCmfOLwIEp0k+/ezJBQgasMTaFHbtvS2xg6cHS3npzb5OG7r0wiCv
         ZYfQGE2euB6FODPqHFrtkgOMKVYk+53kqoMhDUufFmdxAzPdLCJCcnyWgc+UB8sAjOH0
         8ziw==
X-Received: by 10.68.89.162 with SMTP id bp2mr13176253pbb.151.1393509696890;
        Thu, 27 Feb 2014 06:01:36 -0800 (PST)
Received: from localhost.localdomain ([61.150.43.99])
        by mx.google.com with ESMTPSA id oa3sm13864818pbb.15.2014.02.27.06.01.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2014 06:01:35 -0800 (PST)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242825>


Signed-off-by: Sun He <sunheehnus@gmail.com>
---
 bulk-checkin.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 118c625..8c47d71 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -23,7 +23,8 @@ static struct bulk_checkin_state {
 static void finish_bulk_checkin(struct bulk_checkin_state *state)
 {
 	unsigned char sha1[20];
-	char packname[PATH_MAX];
+	char *packname;
+    struct strbuf sb;
 	int i;
 
 	if (!state->f)
@@ -43,6 +44,10 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
 		close(fd);
 	}
 
+    /* 64-1 is more than the sum of len(sha1_to_hex(sha1)) and len(".pack") */
+    strbuf_init(&sb,strlen(get_object_directory())+64);
+    packname = sb.buf;
+
 	sprintf(packname, "%s/pack/pack-", get_object_directory());
 	finish_tmp_packfile(packname, state->pack_tmp_name,
 			    state->written, state->nr_written,
@@ -54,6 +59,9 @@ clear_exit:
 	free(state->written);
 	memset(state, 0, sizeof(*state));
 
+    /* release sb space */
+    strbuf_release(&sb);
+
 	/* Make objects we just wrote available to ourselves */
 	reprepare_packed_git();
 }
-- 
1.7.1
