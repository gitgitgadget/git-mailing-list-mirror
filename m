From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 04/10] combine-diff.c: convert trivial snprintf calls to xsnprintf
Date: Fri,  3 Jun 2016 07:47:18 +0000
Message-ID: <20160603074724.12173-4-gitter.spiros@gmail.com>
References: <20160603074724.12173-1-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 09:48:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8jqc-0000YP-Uo
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 09:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbcFCHso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 03:48:44 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34329 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbcFCHsl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 03:48:41 -0400
Received: by mail-wm0-f65.google.com with SMTP id n184so20992265wmn.1
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 00:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CywrdrdmmGgVlt346Pb7kTmQ3y7Er6mOpG1mCK35Rf4=;
        b=HJgomGrHrwUVyRX0e2u4v2Lk7OylH+SWdG2KLtz3JQe3j1itTRMGVmNyrQ7v5Ylt0j
         IUzyU4jGVlu7O7Sprmrc07+ie2/GF0aizNaC7zXFuDdjkAu7g/Oi1d9u1jfZjEuTXnBY
         qe/wrX4kaDF2UVC4arF/7dGbcz8QIX4Bbr9yGXlgY62j9E07glpI0RfLJjSLdlfPUt5b
         50BQpSw76ZIOB0FR6jSLPKy9xVV9x2yvSdhtVXQpWBbQ62YplXWzm7qxlBruR73nBugk
         BuiQYFgx3H/qCwbBe1j4itFPyFSBWYUVnlqUY/VBKyipbB7AJWQ5CmoqVojX1fxDhN81
         qhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CywrdrdmmGgVlt346Pb7kTmQ3y7Er6mOpG1mCK35Rf4=;
        b=KkC81W/8gNeqGVSlrgBmzLPRBu9UYsYoZ93eCN2LT1WwEUCeFs/OUYDExVBKq8bjYY
         LxcYWH7X7rzNzjfFPrG/fSXzbrNIIj2hBRX1Sv3lrGCjruMOo9K9gP23tbyV9sUDcFWL
         09SVp3I+PbtngBg4ZR6fkIoCZRVvCwOeRCEPjYd76XgJN0v7UeOUfEB8JPoTDHiSyPF+
         rAstw/yqIpmHZDu7Wv3U1G838HKTWfuhHt9Bo3arhLTO6vMc6f/intN6x1kNWW1vt1Xo
         FCf4VkXYScUP8UhoojssjNko/NNl7zNiUwM6lxhIAvZbwxJUN4KZVgAF7YIZX29Mo6PG
         1uwQ==
X-Gm-Message-State: ALyK8tL1OGDme1EzqJeJCrrGg4pq0jKGPG8b3ZUcZLLQDYlHuSZHw3Rv7Eho0ZFjPGeQGg==
X-Received: by 10.194.235.227 with SMTP id up3mr1955683wjc.77.1464940120459;
        Fri, 03 Jun 2016 00:48:40 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id o10sm4307311wjz.37.2016.06.03.00.48.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jun 2016 00:48:39 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc1.265.geb5d750
In-Reply-To: <20160603074724.12173-1-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296277>

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
 combine-diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/combine-diff.c b/combine-diff.c
index 8f2313d..a91d9b3 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -293,7 +293,7 @@ static char *grab_blob(const struct object_id *oid, unsigned int mode,
 
 	if (S_ISGITLINK(mode)) {
 		blob = xmalloc(100);
-		*size = snprintf(blob, 100,
+		*size = xsnprintf(blob, 100,
 				 "Subproject commit %s\n", oid_to_hex(oid));
 	} else if (is_null_oid(oid)) {
 		/* deleted blob */
-- 
2.9.0.rc1.265.geb5d750
