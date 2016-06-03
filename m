From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 07/10] fast-import.c: convert trivial snprintf calls to xsnprintf
Date: Fri,  3 Jun 2016 07:47:21 +0000
Message-ID: <20160603074724.12173-7-gitter.spiros@gmail.com>
References: <20160603074724.12173-1-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 09:48:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8jqd-0000YP-HH
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 09:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbcFCHsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 03:48:46 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33358 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbcFCHso (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 03:48:44 -0400
Received: by mail-wm0-f66.google.com with SMTP id a136so21580512wme.0
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 00:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=14Z8ofWMOBVDeyyP01P7xtLnvmkLix2ru9XEyHmvuSs=;
        b=LhPpXIeiAJekL6PEyDxYoqDlbhkefdFHY7mkPr0WyqGHh+MEE77Kp7K/+P8z7nMOTh
         0uF/N+vqOqQ1ztKzOOlPWPYctS7EeugHqxubg2Jpv8ofT3UXIT444WA9Qc0CJt/CObfF
         lk5eGt4B7od2O0IaYdobow5A5a4tev/1lwpYXOpTDYFx6QVjB7wKlx70QnUlXXSi+cAh
         sHxXIuqpT7+vNBWuSb/8VDCBHTgo//B5mad7jvx5ND/DKVuo5k2xodOW7wfSm6q7MgBP
         4wKc0oX93cYpkLGH/K2pzKfDPmgRwjAoxH56Ci+ZGCskh68oITFcMdzzz8/zTNnUxTNy
         nlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=14Z8ofWMOBVDeyyP01P7xtLnvmkLix2ru9XEyHmvuSs=;
        b=P3a3hUmmalqke9IUG3tkpWTWoFMZme+Yf56ii+1GJbWUi9EmOze4Lqg4n9hRPNlt3w
         aFLOzQZPRkuhmQ+xJ/NX54cu/bmOUqu+rNek4yMnKpSdNMZfrY7gWA/EJsZr3hnyswpi
         8XZjiLBOpmNGQRmZ/uwtn/OBAyJ50HF1UnvK+HBHRowOeMLVXBbaj05INqhYaVtuJk07
         juO0xYvQd2pubJB4L4Cf7gw3mcRSXo5kgc5MT02rfDUbMLaC2INfIuixfc6wUiHFumVv
         4Jc0kmluCxc61XNJuL/Rl8/U/i2kggjgTNF4h89qpQdK4ny17wK9Ysa+eq/cAM/48OZx
         X//g==
X-Gm-Message-State: ALyK8tKlXBW8h88XdrhtxwTPelIJrEhLp2Ecm9+rO9FyWK+GtlkvYwzdefz3WpzYAdmkIw==
X-Received: by 10.28.158.85 with SMTP id h82mr29271151wme.60.1464940122924;
        Fri, 03 Jun 2016 00:48:42 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id o10sm4307311wjz.37.2016.06.03.00.48.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jun 2016 00:48:42 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc1.265.geb5d750
In-Reply-To: <20160603074724.12173-1-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296279>

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
 fast-import.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 59630ce..5beb63d 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1240,10 +1240,7 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 	sha1file_checkpoint(pack_file, &checkpoint);
 	offset = checkpoint.offset;
 
-	hdrlen = snprintf((char *)out_buf, out_sz, "blob %" PRIuMAX, len) + 1;
-	if (out_sz <= hdrlen)
-		die("impossibly large object header");
-
+	hdrlen = xsnprintf((char *)out_buf, out_sz, "blob %" PRIuMAX, len) + 1;
 	git_SHA1_Init(&c);
 	git_SHA1_Update(&c, out_buf, hdrlen);
 
-- 
2.9.0.rc1.265.geb5d750
