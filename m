From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 05/10] compat/inet_ntop.c: convert trivial snprintf calls to xsnprintf
Date: Fri,  3 Jun 2016 07:47:19 +0000
Message-ID: <20160603074724.12173-5-gitter.spiros@gmail.com>
References: <20160603074724.12173-1-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 09:49:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8jqt-0000fm-7W
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 09:49:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211AbcFCHtB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 03:49:01 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36165 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbcFCHsm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 03:48:42 -0400
Received: by mail-wm0-f66.google.com with SMTP id a20so9968891wma.3
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 00:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MWR3Jzno8SGlnSsSN8UcXLE/l3J3Z99+q1B6uOQe/QI=;
        b=HvLUX+6WoX8BYIvXljcYnpJHaWlkCg11gK30zDzBVgIadfv+ApbNLYZkcdZdQvNlEn
         lECWm95KSiiTuGFk1OLDGwH2Ik8xxbiUDEFw8iMF41tHjyMBC6r7gVvCBtfRdRjT3Efh
         TPBiRkJ6dY0HqHgXQy3+/XmEO52bh4cP5xDjC+LvO06KCxwa01cZP7FPstq9a7o/arqz
         wfUbMQEiCMj53BuQUKewVpPu+3MR2PdlPwuC+qoO9OLst6ZUGDEKKXt75FaiHcsJFgsA
         TfxuS+GcfqKuWFSYfkY8iBpgbnJNcLZXGvEZj7ItmyeWxm+O6o91yoTgV8vadd5mqx3i
         dmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MWR3Jzno8SGlnSsSN8UcXLE/l3J3Z99+q1B6uOQe/QI=;
        b=OVV8sCI/cHiWw1dKT3jFObCOB5vmTdu1SosWiTTxmxFUB5AH5rj1AINd/2l0ZAzVE4
         W+ZuTvQFA9hwUwXYP/gldXVBqaOmeEzXA/Jx0TXadCE+hPv1aNl3q6GwhklfLNZRcqBX
         OefkeTe4qfAxLcFm/+nLo5aKI1c++X4tNKxDjgG10dxQSq07vhscRPHF3UK3NFkdSzLi
         4QipzSyo71YCZSHaJtJW37t9TFEebJZup6tKitObVHZ4ihulKmj/V8sO0WFv51kC2Eog
         PJmD6Q3U4jLbzUGSlnMpbqdhhLy0kbM7bWnm6sUW0W155W+KnrpyO8YRQGUkRGTFbcax
         ds1w==
X-Gm-Message-State: ALyK8tJ4IqRKBhxAuBi6mDnhBN039SbM8Ki2PkXDLHyIupnmPQUDjRa15dLNhd8Lg6TIfA==
X-Received: by 10.28.19.210 with SMTP id 201mr2591969wmt.49.1464940121182;
        Fri, 03 Jun 2016 00:48:41 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id o10sm4307311wjz.37.2016.06.03.00.48.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jun 2016 00:48:40 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc1.265.geb5d750
In-Reply-To: <20160603074724.12173-1-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296284>

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
 compat/inet_ntop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/inet_ntop.c b/compat/inet_ntop.c
index 6830726..a4a6546 100644
--- a/compat/inet_ntop.c
+++ b/compat/inet_ntop.c
@@ -139,7 +139,7 @@ inet_ntop6(const u_char *src, char *dst, size_t size)
 			tp += strlen(tp);
 			break;
 		}
-		tp += snprintf(tp, sizeof tmp - (tp - tmp), "%x", words[i]);
+		tp += xsnprintf(tp, sizeof tmp - (tp - tmp), "%x", words[i]);
 	}
 	/* Was it a trailing run of 0x00's? */
 	if (best.base != -1 && (best.base + best.len) ==
-- 
2.9.0.rc1.265.geb5d750
