Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D87E75434
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 08:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239604AbjJCIYM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 04:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239932AbjJCIX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 04:23:59 -0400
X-Greylist: delayed 133 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Oct 2023 01:23:26 PDT
Received: from mail.smrk.net (mail.smrk.net [45.76.87.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC540DD
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 01:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smrk.net; s=20221002;
        t=1696321404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hc/0U96eglfvSqtCMHxTGgkr3HfQojv7zrZhluU7M84=;
        b=GU+OHxo23lnJUCb9TshWaCaHVqw43sNXyxY4d0sJdV9oYN1GBbzk0+HSJ3egeLBKcrGouq
        qCgD4y9NE/3v28CLwDNX8I8oEQPZFEOwXl43JYY6vzxY2j1+6Jh7G8fNjQusPJKZl6QUcP
        RBb0V57Xyet9fOy0iJBJjXQ5O/xXNl4ak0MG/g9JZjkgh1pF1y8IAV6R8Bo3bGygAbsilS
        xDbBgW/1SyGXfb/Kz7CpNoBMJJ2uHUZM7tkle6j/YBgAHE6f5jym3VBo2iWJXo06PZ0UXO
        4VLEvbl9eKfmmDHIGlBpqj0WsXpsic6tqAo0mp73n/KIgWHT5txgonwxH14Xaw==
Received: from localhost (<unknown> [192.168.5.2])
        by smrk (OpenSMTPD) with ESMTPSA id d3c55ada (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 3 Oct 2023 10:23:24 +0200 (CEST)
From:   =?UTF-8?q?=C5=A0t=C4=9Bp=C3=A1n=20N=C4=9Bmec?= <stepnem@smrk.net>
To:     git@vger.kernel.org
Subject: [PATCH] test-lib: make sure TEST_DIRECTORY has no trailing slash
Date:   Tue,  3 Oct 2023 10:23:23 +0200
Message-ID: <20231003082323.3002663-1-stepnem@smrk.net>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Turns out having `pwd` (which TEST_DIRECTORY defaults to) print $PWD
with a trailing slash isn't very difficult, in my case it went something
like

  ; tmux new-window -c ~/src/git/t/
  [in the new window]
  ; sh ./t0000-basic.sh
  PANIC: Running in a /home/stepnem/src/git/t/ that doesn't end in '/t'?
  ; pwd
  /home/stepnem/src/git/t/

(tmux(1) apparently sets PWD in the environment in addition to calling
chdir(2), which seems enough to make at least some shells preserve the
trailing slash in `pwd` output.)

Strip the trailing slash, if present, to prevent bailing out with the
PANIC message in such cases.

Signed-off-by: Štěpán Němec <stepnem@smrk.net>
---
 t/test-lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1656c9eed006..3b6f1a17e349 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -35,6 +35,7 @@ else
 	# needing to exist.
 	TEST_DIRECTORY=$(cd "$TEST_DIRECTORY" && pwd) || exit 1
 fi
+TEST_DIRECTORY="${TEST_DIRECTORY%/}"
 if test -z "$TEST_OUTPUT_DIRECTORY"
 then
 	# Similarly, override this to store the test-results subdir

base-commit: d0e8084c65cbf949038ae4cc344ac2c2efd77415
-- 
2.42.0

