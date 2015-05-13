From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 2/4] pull: make pull.ff=true override merge.ff
Date: Wed, 13 May 2015 17:52:18 +0800
Message-ID: <1431510740-9710-3-git-send-email-pyokagan@gmail.com>
References: <1431510740-9710-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>, David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 11:53:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsTM1-0004SS-2d
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 11:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbbEMJxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 05:53:24 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36699 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754451AbbEMJxW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 05:53:22 -0400
Received: by pabsx10 with SMTP id sx10so45475018pab.3
        for <git@vger.kernel.org>; Wed, 13 May 2015 02:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EZuIqFsqkm710TI5x9cOdm8Bi5uIYch7m6HHhbQdah0=;
        b=zY9Nc3v3U5TxO/VkOSYxDjLfPVmMfOSFd5MYXk4ogIOV4u99nq7OM/3+a38WH9g0Gl
         nSn/aMrSePxA8wo5L8CTrlg+42RqJoq4oMcit4EWJYeCE5PnkCAayaqW93qKM9JOyE0/
         /JwXfxqvnaljSodDB6iJm3KiOHnnPiT7M1l1agkkJki2nMFnhANwZX6Soxrk6FIlYDMY
         rR2EzegaQymYBO2asSRTLM4lfhN8rL3Mq8PWQBav7LF2I9tS5G1izYFx+jV2ta07c/4n
         23CFAXX46+AzSEtY4ZhPDKlRr/MZgXuM6ldf0geWPxRGSFjqUOd8l1Y7RKfb2Wmxd6w6
         bBBA==
X-Received: by 10.68.218.9 with SMTP id pc9mr35596523pbc.2.1431510801846;
        Wed, 13 May 2015 02:53:21 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id k3sm18777927pdr.50.2015.05.13.02.53.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 May 2015 02:53:20 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431510740-9710-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268974>

While since b814da8 (pull: add pull.ff configuration, 2014-01-15)
git-pull would set the --no-ff or --ff-only switch if pull.ff was false
and only respectively, it did not set the --ff switch if pull.ff was
true. This led to the inconsistent behavior that pull.ff=false and
pull.ff=only would override merge.ff, but pull.ff=true would not.

Fix this by adding the --ff switch if pull.ff=true.
---
 git-pull.sh                  | 3 +++
 t/t7601-merge-pull-config.sh | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/git-pull.sh b/git-pull.sh
index 9ed01fd..e51dd37 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -56,6 +56,9 @@ fi
 # Setup default fast-forward options via `pull.ff`
 pull_ff=$(git config pull.ff)
 case "$pull_ff" in
+true)
+	no_ff=--ff
+	;;
 false)
 	no_ff=--no-ff
 	;;
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index cef94e6..d16ef8b 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -45,7 +45,7 @@ test_expect_success 'fast-forward pull succeeds with "true" in pull.ff' '
 	test "$(git rev-parse HEAD)" = "$(git rev-parse c1)"
 '
 
-test_expect_failure 'pull.ff=true overrides merge.ff=false' '
+test_expect_success 'pull.ff=true overrides merge.ff=false' '
 	git reset --hard c0 &&
 	test_config merge.ff false &&
 	test_config pull.ff true &&
-- 
2.1.4
