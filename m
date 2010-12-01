From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: [PATCH] commit: Remove backward goto in read_craft_line()
Date: Wed,  1 Dec 2010 20:15:59 +0100
Message-ID: <1291230959-3894-1-git-send-email-ralf.thielow@googlemail.com>
Cc: Ralf Thielow <ralf.thielow@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 20:16:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNsAJ-0003T3-CL
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 20:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756476Ab0LATQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 14:16:24 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49882 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755644Ab0LATQX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 14:16:23 -0500
Received: by fxm20 with SMTP id 20so385575fxm.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 11:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ZOydfc1QefJg9lj1s8awErp5XCYPdQtmqvBaP+/licc=;
        b=MuBC5ZMEWz0xnQGxP/x4+y4tYKU7Vk86c9xiz+sMbnQozzYOiPYWuRI/FEzFm7n+yH
         o0HMGpsOxt+xxVD0h7mFQDg1SN0fUucYQG+oUAcctgqCpw0EziMCjnXdTkf64oaQqSPf
         qifsgzf7YffH9uJopaK3YoT3DY0Lltty1K8Is=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=jKK6EcukaAnukiDBebfq3ah3mZa/6403UIu6S1hZrspW7+zs+teuJ2Zcy3D7PaZMSg
         0xcJWqC8yD/UNpf667paI6SP5hZF5FKe5jZ9dDYMKgIoEVQ1vW7Rm0ot4miG7OeLJtF7
         EIxP9LifXJL0mfUXgiNwG49LswBF6jDnrz73A=
Received: by 10.223.98.198 with SMTP id r6mr423409fan.96.1291230981963;
        Wed, 01 Dec 2010 11:16:21 -0800 (PST)
Received: from localhost.localdomain (dslb-094-223-220-166.pools.arcor-ip.net [94.223.220.166])
        by mx.google.com with ESMTPS id n3sm153965fax.7.2010.12.01.11.16.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 11:16:21 -0800 (PST)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162576>

In case of bad graft data which is determine on many
places we go back to the first place of detection,
so move it to the end of the function.

Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---
 commit.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/commit.c b/commit.c
index 0094ec1..d86159a 100644
--- a/commit.c
+++ b/commit.c
@@ -137,12 +137,8 @@ struct commit_graft *read_graft_line(char *buf, int len)
 		buf[--len] = '\0';
 	if (buf[0] == '#' || buf[0] == '\0')
 		return NULL;
-	if ((len + 1) % 41) {
-	bad_graft_data:
-		error("bad graft data: %s", buf);
-		free(graft);
-		return NULL;
-	}
+	if ((len + 1) % 41) 
+		goto bad_graft_data;
 	i = (len + 1) / 41 - 1;
 	graft = xmalloc(sizeof(*graft) + 20 * i);
 	graft->nr_parent = i;
@@ -155,6 +151,11 @@ struct commit_graft *read_graft_line(char *buf, int len)
 			goto bad_graft_data;
 	}
 	return graft;
+
+bad_graft_data:
+	error("bad graft data: %s", buf);
+	free(graft);
+	return NULL;
 }
 
 static int read_graft_file(const char *graft_file)
-- 
1.7.1
