From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [RFC 1/2] test whether push checks for unpushed remotes in submodules
Date: Sun, 26 Jun 2011 20:29:46 +0200
Message-ID: <1309112987-3185-2-git-send-email-iveqy@iveqy.com>
References: <1309112987-3185-1-git-send-email-iveqy@iveqy.com>
Cc: gitster@pobox.com, iveqy@iveqy.com, hvoigt@hvoigt.net,
	jens.lehmann@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 26 20:32:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qau83-0000xI-LK
	for gcvg-git-2@lo.gmane.org; Sun, 26 Jun 2011 20:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151Ab1FZSbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jun 2011 14:31:03 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59071 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754659Ab1FZS3f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2011 14:29:35 -0400
Received: by bwd5 with SMTP id 5so775661bwd.19
        for <git@vger.kernel.org>; Sun, 26 Jun 2011 11:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:cc:subject:date:message-id
         :x-mailer:in-reply-to:references;
        bh=idr9JsoULUi6K7A94iIRKCgfyPnkqovkGsrb6Oo5orQ=;
        b=Rs3+RFYLrEKkH7O3eLYYG5sKwZnZKFpgqEug7lrNQVwdXR8U65vXzaSQxiqwzPLE6S
         FF57ieHUuZXb189CxwmKh2vMHRYjMBFJNt7LNighfnTh6/24mNS0rGT/N/hdCA6Mhnhc
         yBQ7b/DREmmkJWODRtZ130jJAE5bGgdXvAc5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=Wl+QqjSqdJFMksmaJIEVuN3QWVlNqKeHFnzH5du5hNaXsWQxrzhfxZz5GJiae8FEmE
         sSz+QJ8pAfil3OiM6+xusfHyX3p6zj6dJKlKof8gz9tQ7hb040vzuUy4qJD9VN1ZDIoY
         miHNZ3xWQsxqQhnYXJIl6H9AztTvYipW9mLgM=
Received: by 10.204.103.2 with SMTP id i2mr115956bko.7.1309112974441;
        Sun, 26 Jun 2011 11:29:34 -0700 (PDT)
Received: from kolya (h-185-240.A189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id v6sm3473774bkf.11.2011.06.26.11.29.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 26 Jun 2011 11:29:33 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1Qau5h-0000q5-FV; Sun, 26 Jun 2011 20:29:53 +0200
X-Mailer: git-send-email 1.7.6.rc3.2.g0185a
In-Reply-To: <1309112987-3185-1-git-send-email-iveqy@iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176326>

From: Heiko Voigt <hvoigt@hvoigt.net>

These tests are used to extend push to check whether all recorded
submodule commits have also been pushed.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 t/t5531-deep-submodule-push.sh |   46 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index faa2e96..0b55466 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -28,8 +28,52 @@ test_expect_success setup '
 test_expect_success push '
 	(
 		cd work &&
-		git push ../pub.git master
+		git push -f ../pub.git master
 	)
 '
 
+test_expect_failure 'push fails if submodule has no remote' '
+	(
+		cd work/gar/bage &&
+		>junk2 &&
+		git add junk2 &&
+		git commit -m "Second junk"
+	) &&
+	(
+		cd work &&
+		git add gar/bage &&
+		git commit -m "Second commit for gar/bage" &&
+		test_must_fail git push ../pub.git master
+	)
+'
+
+test_expect_failure 'push fails if submodule commit not on remote' '
+	(
+		cd work/gar &&
+		git clone --bare bage ../../submodule.git &&
+		cd bage &&
+		git remote add origin ../../../submodule.git &&
+		git fetch &&
+		>junk3 &&
+		git add junk3 &&
+		git commit -m "Third junk"
+	) &&
+	(
+		cd work &&
+		git add gar/bage &&
+		git commit -m "Third commit for gar/bage" &&
+		test_must_fail git push ../pub.git master
+	)
+'
+
+test_expect_failure 'push succeeds after commit was pushed to remote' '
+	(
+		cd work/gar/bage &&
+		git push origin master
+	) &&
+	(
+		cd work &&
+		git push ../pub.git master
+	)
+'
 test_done
-- 
1.7.6.rc3.2.g0185a
