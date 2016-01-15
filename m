From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 01/11] dir: free untracked cache when removing it
Date: Fri, 15 Jan 2016 07:59:42 +0100
Message-ID: <1452841192-620-2-git-send-email-chriscool@tuxfamily.org>
References: <1452841192-620-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 08:00:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJyN5-0004mG-SE
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 08:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876AbcAOHA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 02:00:27 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37814 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932AbcAOHAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 02:00:25 -0500
Received: by mail-wm0-f45.google.com with SMTP id f206so10160387wmf.0
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 23:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uZeUAUxr3hBLKGngTpqJvbKv8at3TcW+QtyzD6onkYo=;
        b=CiW7yCViqRFcqMY5M1U8td0a6Hb36jzAsGwQp8/w8kjwqTRm5aV9DVXFeVGz7PLibS
         /5DiBZlEuwYcy6+Qjo/skIZr4Zh5er4HB/BNj5M5w/Q6YQopp/+BRknyJ2VLsiu8w9Dd
         pqprfMXuWU0LNZadrXRgHTJZoScc5JxGrBh1IDURXfjMCiL1Wg/aXAXXWE0W5efN87Je
         yaHe8aU4xPfN48zIEKvQSyDIA25GXFaldUYjB9P6pUccyAksa3k59hWy+4ajUjf95zvj
         j3bofXnXQCCvUOEtIcnsKKvAu3WQVSivFCiFq7qLPV8+/F/XmK9yrVmAP7rNiuAXUJfR
         OAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uZeUAUxr3hBLKGngTpqJvbKv8at3TcW+QtyzD6onkYo=;
        b=Cwb1Ew/mHCg099ubBcHimh/PKiKUGeBn2aCuQYikw20ZR8PJ4WHUDyLVBAXG6Q+dX5
         iMQtEtjqm6TnLuWgfT4ri5elbsgvYn5ZbHR0HdJCdAdBBrpH7lV1dmp9hpurz8m9+zz7
         UzlSp80QR0h+Kkw6QDAOOi2MR8viiz63zEGlOkTeQriRUx/qz7RpONwy7PxDYL1cvubj
         uXTMxkSCI8oUkC488fYaLfYiIfbMv3GlbQnA1rw3InQS2tjOZOGlw7eVE/eqi/Zs/G70
         eaf/5FbDZZ3fOuOEqa7l7vulu4eMPAooUFpug1zqBfp94iS/fwPHCxCloiQGTf8eEHHp
         lK9w==
X-Gm-Message-State: ALoCoQlfnm+YMykAXsjZnnRAWVwNzZYsHA68afOCXUoKlp2oqNFElHauEDKKycXIqoFxjq3e7FItWvkzHAPGoozJ5lvIh1pW2w==
X-Received: by 10.194.243.6 with SMTP id wu6mr7931779wjc.14.1452841224697;
        Thu, 14 Jan 2016 23:00:24 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id f205sm1169733wme.4.2016.01.14.23.00.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jan 2016 23:00:23 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.36.g20612a7
In-Reply-To: <1452841192-620-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284141>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 7431938..a6fff87 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1123,6 +1123,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		add_untracked_ident(the_index.untracked);
 		the_index.cache_changed |= UNTRACKED_CHANGED;
 	} else if (!untracked_cache && the_index.untracked) {
+		free_untracked_cache(the_index.untracked);
 		the_index.untracked = NULL;
 		the_index.cache_changed |= UNTRACKED_CHANGED;
 	}
-- 
2.7.0.36.g20612a7
