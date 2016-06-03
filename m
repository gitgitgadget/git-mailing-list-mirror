From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 10/10] wrapper.c: convert trivial snprintf calls to xsnprintf
Date: Fri,  3 Jun 2016 07:47:24 +0000
Message-ID: <20160603074724.12173-10-gitter.spiros@gmail.com>
References: <20160603074724.12173-1-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 09:49:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8jqs-0000fm-2z
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 09:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbcFCHsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 03:48:54 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34372 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926AbcFCHsv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 03:48:51 -0400
Received: by mail-wm0-f65.google.com with SMTP id n184so20992626wmn.1
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 00:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QosJbMu0ZhIePvaz8L2Vi9YZRK6iK+n8BK/FEo4+M1A=;
        b=tbxdEnwO3KvNU9mew1bxdXgGNs6pYIXiim/lbiNn41ygSeXmpNbMB0P9DOJHoIy7MT
         rei3Bmc4Obg4Lybm+yU1HQ4DwfCGrlN4B715py17jOgSc+IPgVvmCN7xaC7JztvtbTmw
         Cuhl8wC/I0Y0RaIBDhL5B5sj/HpR6YcFJ5gO2UaQqjzX7Xu9yqqAjjqX5SKdSEGYxqh0
         xW72zfRZMWPPuMt+xWR2IwU3tLQgIWJc6LoQjAMQO0ieNc0jMnokmsXnUWC+W1bwazT6
         +haPoI7DM1saIuv0KII5n3cfMks/ENCZskkBqfyZ6gbA0LF2WCy8UWFshRbZEmlPJ2Qp
         w+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QosJbMu0ZhIePvaz8L2Vi9YZRK6iK+n8BK/FEo4+M1A=;
        b=dy+bn4fnQTkQ4Iqdt8bVkZLuaWzce5NP46rKJzQhSdypZSEdtbj3gjmo8mOahWbXV1
         oX8y8uiqJqyz9dX3R4XdL/IK80FWXuhm/Wkdy8gxP7Igi2mqQjmIC8CLFEBi+E+NlytL
         SudES+kub/tbyh0YpIrkYB4IUvg0nyCDv7JNPEHgXhvBYnTxqGZvOiNQwbPwQ6hAzZDs
         yuHulesGmdoP7YXOe5aOHgZJwG8GXMULc6anNU5SMV+nZS8AacKS+XCzcbXUxifLdPrD
         yKipFIdmRmBbeBwBFp3yrnjnWPfMXC3VmUd2D1cd9KZO8OSLo71ag0OCaMxq7bVMaxaq
         toag==
X-Gm-Message-State: ALyK8tJJcVcpDwpAJcywVnS7g2Pc7oF24urnKS2QPn28CDgW471hTguOipgKesy9fXfi3w==
X-Received: by 10.28.7.69 with SMTP id 66mr2614337wmh.87.1464940125080;
        Fri, 03 Jun 2016 00:48:45 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id o10sm4307311wjz.37.2016.06.03.00.48.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jun 2016 00:48:44 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc1.265.geb5d750
In-Reply-To: <20160603074724.12173-1-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296281>

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
 wrapper.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index 5dc4e15..0d44835 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -433,16 +433,11 @@ int xmkstemp(char *template)
 int git_mkstemp(char *path, size_t len, const char *template)
 {
 	const char *tmp;
-	size_t n;
 
 	tmp = getenv("TMPDIR");
 	if (!tmp)
 		tmp = "/tmp";
-	n = snprintf(path, len, "%s/%s", tmp, template);
-	if (len <= n) {
-		errno = ENAMETOOLONG;
-		return -1;
-	}
+	(void)xsnprintf(path, len, "%s/%s", tmp, template);
 	return mkstemp(path);
 }
 
-- 
2.9.0.rc1.265.geb5d750
