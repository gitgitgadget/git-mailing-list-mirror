From: David Turner <dturner@twopensource.com>
Subject: [PATCH] read-cache: increase write buffer size
Date: Fri, 18 Mar 2016 21:19:01 -0400
Message-ID: <1458350341-12276-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 19 02:19:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah5Xz-0006kz-6t
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 02:19:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575AbcCSBTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 21:19:15 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:34538 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243AbcCSBTO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 21:19:14 -0400
Received: by mail-qg0-f41.google.com with SMTP id w104so114805316qge.1
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 18:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=XGAUzDlnngJw9tt7CGYwHPVIc1CqozCbtCuBrM0/b2Y=;
        b=bewr1j6IqCeMWlQ4wKWe5FX3NS3sm0R4nmqHG+TjBQWIdfIXL4XGQfV34QY/TrrgUz
         RXPnNNN7wJLmQBoF2Hl9+4K3vW/T+BTAdnGr7aKxJ0ACqrFF1RKxTZIloNQbi5UGBQe4
         39NStx/+AmheT17yilcE7SiZHFzjrA0JbaycRzExfstslNj/ypgmNYC1meo19M+2wOGP
         o10CX22FectDI8nCRqj8Erp+mZidFQXqa4D4r75lrqpSuaOZr7Pt7eIgonTY9S2Nx5vh
         ULq4TZ717TQP+MxYvpRHmVvszBAV1LE6aaMDdFb4LTF/TFl0nQliQqruMIXNshzGLWQq
         bX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XGAUzDlnngJw9tt7CGYwHPVIc1CqozCbtCuBrM0/b2Y=;
        b=NiWW6PzfZ9zGczUW8nAJr1W42AUIZD6hjek9pQoHT0sGa/H+Quvrq7Gkb+MY6+FtPo
         +Xcg2cxtBRm+GjKpmbq+3nnjxyZN6fS90BHLGoHM7OoC59ogvanDX/xK3ErUYhnsecEu
         NqduQ2UcWNHvFiOhgUEIi9odLb+h6VVDilPvkWToguAupGB11SZbseC/lSs6ZechTCuM
         QQsUa4A/bThICkPWvlhEd8lj//rsaM2ZXCHLLl2SfrvselGOBPiJ7i5UrcFDCMZ7fvH1
         +XgIKaz92tGzBAZ7FO/nJDdl6KfP3YxYxUWiajHAiQ8Lt6kAoWQl+sBSN5pQInWjoc+G
         fvgQ==
X-Gm-Message-State: AD7BkJIOi3SBGvAioSOpSHyMlNbmPMD5TImi81z1blE41X3zdtN4cjRQTgkqGvd8CnxpMA==
X-Received: by 10.140.195.203 with SMTP id q194mr27757773qha.45.1458350353828;
        Fri, 18 Mar 2016 18:19:13 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id s188sm7173099qhc.35.2016.03.18.18.19.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2016 18:19:13 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289285>

Each write() has syscall overhead, and writing a large index entails
many such calls.  A larger write buffer reduces the overhead,
leading to increased performance.

On my repo, which has an index size of 30m, this saves about 10ms of
time writing the index.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index d9fb78b..09ebe08 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1714,7 +1714,7 @@ int unmerged_index(const struct index_state *istate)
 	return 0;
 }
 
-#define WRITE_BUFFER_SIZE 8192
+#define WRITE_BUFFER_SIZE 131072
 static unsigned char write_buffer[WRITE_BUFFER_SIZE];
 static unsigned long write_buffer_len;
 
-- 
2.4.2.767.g62658d5-twtrsrc
