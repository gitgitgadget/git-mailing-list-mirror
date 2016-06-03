From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 06/10] diff.c: convert trivial snprintf calls to xsnprintf
Date: Fri,  3 Jun 2016 07:47:20 +0000
Message-ID: <20160603074724.12173-6-gitter.spiros@gmail.com>
References: <20160603074724.12173-1-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 09:48:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8jqe-0000YP-Vj
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 09:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbcFCHsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 03:48:50 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35487 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926AbcFCHsn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 03:48:43 -0400
Received: by mail-wm0-f65.google.com with SMTP id e3so21459589wme.2
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 00:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=heW60xOs+NAG5zuGCPqocOiwTJT+/7W5Bwu5lUdNocE=;
        b=x21tu/yPIJA4bzm5XIQklMntArCWuooRW7G3lmawMvNDMwY+miv9FvAs/5CsDllHQH
         ku+tqNP0OkLm0xF2dP8gqKBUMpUrQwejkTNBs8YGNJ7tYC3D2gF9F5vtAzuEKrtWk4UO
         VeKb6FxwadXmjnTQcs2dcqatQxnCAfkUKWbM5GOH1pQk1LYL5UiPdPLq32bNvIXrskd5
         XOPHthkE3SQ9fJStr9zWyfN27F2b2QCtCxYJRSWTfR217u5RA10nZSd7MiiMPKxa+yr6
         F8TE7gahc6/VckOYyj/uu/qanmICkFSml83/eVbrYtQg1tCb4pHwlvBTIeP6UxtgONu5
         nyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=heW60xOs+NAG5zuGCPqocOiwTJT+/7W5Bwu5lUdNocE=;
        b=Bs20ogA4dgmDpqhthMI4SIe7gbrMVqYymwnsEXVjl62lKn/yuTKhVfbiCJVfRGvSOA
         R1E9qipYmvHPag9sfm7k1ep07Vrwt45+Q1/+iae91X8sZMuSbUbsDv6d5qIl5q4PtQhH
         i0JWMGGMv7nTaArg/8VOsqfqZ6h7MCLbLWExrUJo+VzPdvBWlpqgmy+86s7JDi+oEleH
         21uSuYhVXixQam5Jpn/tm/ZJMT8xd9mfCfyfGV7xVMOSPQDb1EISBiRTiPXpnBZDWv8q
         3wNK8YeAruhhwNFI6MFTDJKYQHd4epME52GMMjeIEwjLA2Fk58WZhg2erVRJoL4TJuQH
         4Q8w==
X-Gm-Message-State: ALyK8tIhY6xjXGQwWgvJfsn9pA78e56u5MUznzgBGFVCMJM5FDfoVBLXethGwVbjv/RQ9w==
X-Received: by 10.194.120.135 with SMTP id lc7mr1961979wjb.34.1464940121882;
        Fri, 03 Jun 2016 00:48:41 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id o10sm4307311wjz.37.2016.06.03.00.48.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jun 2016 00:48:41 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc1.265.geb5d750
In-Reply-To: <20160603074724.12173-1-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296280>

With the commits f2f02675 and 5096d490 we have been converted in some files the call
from snprintf/sprintf/strcpy to xsnprintf. This patch converts the remaining calls
to snprintf with xsnprintf under the following conditions:

- The call to snprintf does not control the outcome of the command
  or the presence of truncation errors.
- A call to snprintf can generate a fatal error, directly or indirectly.

The other few remaining cases in which a call to snprintf can generate a soft error
have not been changed.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 diff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index d3734d3..fb61539 100644
--- a/diff.c
+++ b/diff.c
@@ -4491,7 +4491,7 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 		len1 = remove_space(p->one->path, strlen(p->one->path));
 		len2 = remove_space(p->two->path, strlen(p->two->path));
 		if (p->one->mode == 0)
-			len1 = snprintf(buffer, sizeof(buffer),
+			len1 = xsnprintf(buffer, sizeof(buffer),
 					"diff--gita/%.*sb/%.*s"
 					"newfilemode%06o"
 					"---/dev/null"
@@ -4501,7 +4501,7 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 					p->two->mode,
 					len2, p->two->path);
 		else if (p->two->mode == 0)
-			len1 = snprintf(buffer, sizeof(buffer),
+			len1 = xsnprintf(buffer, sizeof(buffer),
 					"diff--gita/%.*sb/%.*s"
 					"deletedfilemode%06o"
 					"---a/%.*s"
@@ -4511,7 +4511,7 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 					p->one->mode,
 					len1, p->one->path);
 		else
-			len1 = snprintf(buffer, sizeof(buffer),
+			len1 = xsnprintf(buffer, sizeof(buffer),
 					"diff--gita/%.*sb/%.*s"
 					"---a/%.*s"
 					"+++b/%.*s",
-- 
2.9.0.rc1.265.geb5d750
