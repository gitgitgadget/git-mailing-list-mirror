From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 03/10] builtin/tag.c: convert trivial snprintf calls to xsnprintf
Date: Fri,  3 Jun 2016 07:47:17 +0000
Message-ID: <20160603074724.12173-3-gitter.spiros@gmail.com>
References: <20160603074724.12173-1-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 09:49:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8jqs-0000fm-L4
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 09:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbcFCHsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 03:48:42 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33328 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926AbcFCHsl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 03:48:41 -0400
Received: by mail-wm0-f65.google.com with SMTP id a136so21580242wme.0
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 00:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=plIxmwSn8MOysryg7jk7JCuKoIp0T4JtkIoPlZBCLIo=;
        b=PE3VjT3crcwHB+a4xmfcOAYVM0X2mwokRin0ljQnjhppkT70otWD6okM0W1HWBAaUf
         YcEM085Ma53wBIKDz92emHNp+ce9kIFMkJYEO8hPBUTpyDIr3E+pJCQ0wbWxOQtoBcGG
         2B/fFy7hf+BkX+QM0pq7JlN3t5Xn6tD87Plih6ugfhMrc1CkVaUYzoJqTtKITDbC3xmY
         BU4GJq5mJ3CLOOC+/dows5CVTEX4qRjWfomAryLfgZTkAu7Wroc/fLpNAam0kKxzqasI
         6ezqSbi1lr5o+gDzj+E+dgcOUvZ0FKhINgSey+uzMOcNVOK2piZuk466i54Poc+IsGUk
         kZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=plIxmwSn8MOysryg7jk7JCuKoIp0T4JtkIoPlZBCLIo=;
        b=B9HTnC488N4JlGg1k/35ibP3TiZmPVuAwPqvQ3Cd++AsKrOL6i19oVSuUw21JK6vd8
         34bKsmjJYtlHVXeRMi4KQHv6B3CJUnGUlsp1o/cWYfND954QHjVuoPPLUame6832EWEV
         x7MfktwrEXBbg4V0Lag3l1hiQ3AhgEX2PwLMSga1JezNxVlGD16oRhXgO5fmZ2Sj8uJq
         MpJwSyu1QoKFknCso8EJujpUQx0cbHenwC6bBCzULCytnpIK+YQYrWVF0DhJ6Cws+svC
         4tEEjhk8DFdCdt2ixMtuFiADwjcKUFRPD6VodqIcL0XWUwPu4/rF27FCgQSY376l/H4l
         xp3w==
X-Gm-Message-State: ALyK8tIyq4HmldRibnhDs1r1Yj+pqDSAAdthFRKWBel6ZkqkaU0BY294MAa/jKiLkOmS8Q==
X-Received: by 10.194.23.1 with SMTP id i1mr2049907wjf.142.1464940119703;
        Fri, 03 Jun 2016 00:48:39 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id o10sm4307311wjz.37.2016.06.03.00.48.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jun 2016 00:48:39 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc1.265.geb5d750
In-Reply-To: <20160603074724.12173-1-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296285>

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
 builtin/tag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 50e4ae5..0345ca3 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -225,7 +225,7 @@ static void create_tag(const unsigned char *object, const char *tag,
 	if (type <= OBJ_NONE)
 	    die(_("bad object type."));
 
-	header_len = snprintf(header_buf, sizeof(header_buf),
+	header_len = xsnprintf(header_buf, sizeof(header_buf),
 			  "object %s\n"
 			  "type %s\n"
 			  "tag %s\n"
-- 
2.9.0.rc1.265.geb5d750
