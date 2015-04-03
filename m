From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 2/4] git-p4: small fix for locked-file-move-test
Date: Fri,  3 Apr 2015 19:53:36 +0100
Message-ID: <1428087218-8186-3-git-send-email-luke@diamand.org>
References: <1428087218-8186-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Junio C Hamano <gitster@pobox.com>,
	Blair Holloway <Blair_Holloway@playstation.sony.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 03 20:54:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye6jY-0001Fx-1T
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 20:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862AbbDCSyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 14:54:15 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:36149 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788AbbDCSyN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 14:54:13 -0400
Received: by wgra20 with SMTP id a20so117236393wgr.3
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 11:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6mRK5VNBwAqMrfy7JV96eQpgZ/m0Wse6oSm03/rCaN4=;
        b=MVES0+aggx4IagJYzb2GTZ/EsXH2rk3190YQN9Av8Je1fm7ELynIKUwrg/NEa+zdCh
         Qrfch4meEMGMljhZgTd2OHGtGmR18fq855v4NUY1yMyfiXvv+mFflI85YsRuRfgeECZj
         1bVDFD+D/IxboSKnnlZ0SmS3sUWvsv5ZFzdjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6mRK5VNBwAqMrfy7JV96eQpgZ/m0Wse6oSm03/rCaN4=;
        b=T0lCxzxVss3FHVYAEb32X4Qo9vI5l18I74Ce5PI8sSQEy7ghG3Zf98aDXUf949B1oh
         Mw6RiqQiDkgcabS2vJ/0T/ZOfJdtg7/V/EaZ0024vcpA7b8BlxnMZVIIkD6eQeZzzt78
         eWz4w3nX5XfKqYRQADd9TnvrOhYECVCCLnW8kRWXQJ1xTRqVPxx9PlZIj41gADxerUqM
         ZOikoWA7HaNxAP0FZkqKuyF88wI27QOqlKOQDdMN5Kidd6jtXRhWVLYKYqq7nR6IdUd5
         LTX0bdAV/0fLMFi9DCWk5rny+0xfE4wlZZEBFxrNxLBqpLKLybmGoUNOkwfBvnO0wc2o
         tYUQ==
X-Gm-Message-State: ALoCoQm5lbw24ODn9ENkvKxZqvV8TUMbCWYFwAG16EsCa5Fgd47KGk+1fsGLKkeaMnxK+BZvZitA
X-Received: by 10.194.171.100 with SMTP id at4mr7772049wjc.122.1428087252375;
        Fri, 03 Apr 2015 11:54:12 -0700 (PDT)
Received: from ethel.local.diamand.org (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id fy2sm3782967wic.15.2015.04.03.11.54.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2015 11:54:11 -0700 (PDT)
X-Mailer: git-send-email 2.3.4.48.g223ab37
In-Reply-To: <1428087218-8186-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266718>

The test for handling of failure when trying to move a file
that is locked by another client was not quite correct - it
failed early on because the target file in the move already
existed.

The test now fails because git-p4 does not properly detect
that p4 has rejected the move, and instead just crashes. At
present, git-p4 has no support for detecting that a file
has been locked and reporting it to the user, so this is
the expected outcome.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/t9816-git-p4-locked.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9816-git-p4-locked.sh b/t/t9816-git-p4-locked.sh
index ce0eb22..464f10b 100755
--- a/t/t9816-git-p4-locked.sh
+++ b/t/t9816-git-p4-locked.sh
@@ -130,8 +130,8 @@ test_expect_failure 'move with lock taken' '
 	git p4 clone --dest="$git" //depot &&
 	(
 		cd "$git" &&
-		git mv file1 file2 &&
-		git commit -m "mv file1 to file2" &&
+		git mv file1 file3 &&
+		git commit -m "mv file1 to file3" &&
 		git config git-p4.skipSubmitEdit true &&
 		git config git-p4.detectRenames true &&
 		git p4 submit --verbose
-- 
2.3.0.rc1.30.g76afe74
