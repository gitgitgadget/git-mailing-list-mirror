From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] create_delta_index: simplify condition always evaluating to true
Date: Thu, 15 Aug 2013 21:37:40 +0200
Message-ID: <1376595460-6546-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 15 21:37:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA3MZ-0004Vt-EJ
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 21:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759133Ab3HOThf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 15:37:35 -0400
Received: from mail-ea0-f173.google.com ([209.85.215.173]:44411 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758226Ab3HOThe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 15:37:34 -0400
Received: by mail-ea0-f173.google.com with SMTP id g10so569665eak.32
        for <git@vger.kernel.org>; Thu, 15 Aug 2013 12:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=LkRSnaSlYzkgYF/pourA0Ml/Dtr0JwzKVkYjkQoHxMA=;
        b=muQqL9dYl6qtXq0XoP8UGhMFi2xY8clUCtXGWvFywlJGBFikScE19s7WAI3eQNLhwH
         VcDMVkUCP3Gt1JPAygBBaso20Gu4iy+pYiOtXogqcNQsx0csR3FZr3xdE1dh6+nmUP41
         gkAUMPAkEAqBy9CuEofJgvZWIBBDZhhihSfqgUoxL42fcoZlbAGJ+aE10HvDw/NdtIS9
         a0k76wO+VgvE+k0+VUCLL2KmzvN7sbFPiVBaXwny6h+KEhYB5IkMwDtWTTt1GNBGN+ny
         L3RUX+DDrRasZZho/IcdheFmIg2Bybf8OjjC3Yuj8nDDg72HmuC4f7nKedzH1ITMeGbq
         I8Gw==
X-Received: by 10.14.9.72 with SMTP id 48mr24350532ees.42.1376595453715;
        Thu, 15 Aug 2013 12:37:33 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id n48sm1064257eeg.17.2013.08.15.12.37.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 Aug 2013 12:37:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc3.498.g5af1768
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232365>

When checking the previous lines in that function, we can deduct that
hsize must always be smaller than (1u<<31), since 506049c7df2c6
(fix >4GiB source delta assertion failure), because the entries is
capped at an upper bound of 0xfffffffeU, so hsize contains a maximum
value of 0x3fffffff, which is smaller than (1u<<31), so i will never
be larger than 31.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 diff-delta.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/diff-delta.c b/diff-delta.c
index 93385e1..54da95b 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -154,8 +154,15 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 		 */
 		entries = 0xfffffffeU / RABIN_WINDOW;
 	}
+
+	/*
+	 * Do not check i < 31 in the loop, because the assignement
+	 * previous to the loop makes sure, hsize is definitely
+	 * smaller than 1<<31, hence the loop will always stop
+	 * before i exceeds 31 resulting in an infinite loop.
+	 */
 	hsize = entries / 4;
-	for (i = 4; (1u << i) < hsize && i < 31; i++);
+	for (i = 4; (1u << i) < hsize; i++);
 	hsize = 1 << i;
 	hmask = hsize - 1;
 
-- 
1.8.4.rc3.498.g5af1768
