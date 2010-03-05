From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] t7406: Fix submodule init config tests
Date: Fri,  5 Mar 2010 00:20:38 -0800
Message-ID: <1267777238-2646-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 05 09:46:42 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnSuF-0003ye-VL
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 09:29:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754347Ab0CEI24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Mar 2010 03:28:56 -0500
Received: from mail-yx0-f185.google.com ([209.85.210.185]:56823 "EHLO
	mail-yx0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754214Ab0CEI2z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 03:28:55 -0500
Received: by yxe15 with SMTP id 15so1971304yxe.25
        for <git@vger.kernel.org>; Fri, 05 Mar 2010 00:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=P08gQVDP35NA+p3gxdaj20MndFAPWtwQlKemYEJWUMo=;
        b=lbQ42pb845seXEJ0UwxEvvwZ7Onel9YtVA5dWFjGyicl4sZhVbJl0VPmhgblGplt9u
         wkVaOd2eVxVf11JQw0Fp3wPCKSUgdimC+BVW0VjB5DPg7qUqkGMHxNybtyN/s4yqUxQw
         iOYTcQEwxG/OAYVk0DU1khS5ym1EEHtB2y1WA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=fakYEdVzjgchsGUJ+8tL6Nx+6z9643NEKJoq/ET9MpeqA5BXn5aTcckOdRgwL8ON8y
         gk9XJcsJDYGhbm7LJbCZZmtg9lyKCzYqEuCIpmRJGDNrEC0a3iyQDysME7215MJHbQpk
         M4w24JiaUBoAHJaaBTSTAUZQ5xJXIjbcXYuhA=
Received: by 10.150.25.22 with SMTP id 22mr824952yby.106.1267777241185;
        Fri, 05 Mar 2010 00:20:41 -0800 (PST)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 34sm480394yxf.29.2010.03.05.00.20.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Mar 2010 00:20:40 -0800 (PST)
X-Mailer: git-send-email 1.7.0.1.138.ga75b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141563>

These tests have been broken since they were introduced in commits
ca2cedb (git-submodule: add support for --rebase., 2009-04-24) and
42b4917 (git-submodule: add support for --merge., 2009-06-03).
'git submodule init' expects the submodules to exist in the index.
In this case, the submodules don't exist and therefore looking for
the submodules will always fail. To make matters worse, git submodule
fails visibly to the user by saying:

error: pathspec 'rebasing' did not match any file(s) known to git.
Did you forget to 'git add'?

but doesn't return an error code. This allows the test to fail silently.
Fix it by adding the submodules first.

Cc: Johan Herland <johan@herland.net>
Cc: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

The documentation for submodule init is a bit misleading too. It sounds
like submodule init will just read the .gitmodules file and copy settings
to the .git/config, but it actually needs the submodules in the index to
copy anything.

Should the behavior of submodule init should change to match the docs?

 t/t7406-submodule-update.sh |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 8e2449d..1382a8e 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -28,6 +28,8 @@ test_expect_success 'setup a submodule tree' '
 	git commit -m upstream
 	git clone . super &&
 	git clone super submodule &&
+	git clone super rebasing &&
+	git clone super merging &&
 	(cd super &&
 	 git submodule add ../submodule submodule &&
 	 test_tick &&
@@ -45,6 +47,16 @@ test_expect_success 'setup a submodule tree' '
 	 ) &&
 	 git add submodule &&
 	 git commit -m "submodule update"
+	) &&
+	(cd super &&
+	 git submodule add ../rebasing rebasing &&
+	 test_tick &&
+	 git commit -m "rebasing"
+	) &&
+	(cd super &&
+	 git submodule add ../merging merging &&
+	 test_tick &&
+	 git commit -m "rebasing"
 	)
 '
 
@@ -177,21 +189,17 @@ test_expect_success 'submodule update - checkout in .git/config' '
 
 test_expect_success 'submodule init picks up rebase' '
 	(cd super &&
-	 git config submodule.rebasing.url git://non-existing/git &&
-	 git config submodule.rebasing.path does-not-matter &&
-	 git config submodule.rebasing.update rebase &&
+	 git config -f .gitmodules submodule.rebasing.update rebase &&
 	 git submodule init rebasing &&
-	 test "rebase" = $(git config submodule.rebasing.update)
+	 test "rebase" = "$(git config submodule.rebasing.update)"
 	)
 '
 
 test_expect_success 'submodule init picks up merge' '
 	(cd super &&
-	 git config submodule.merging.url git://non-existing/git &&
-	 git config submodule.merging.path does-not-matter &&
-	 git config submodule.merging.update merge &&
+	 git config -f .gitmodules submodule.merging.update merge &&
 	 git submodule init merging &&
-	 test "merge" = $(git config submodule.merging.update)
+	 test "merge" = "$(git config submodule.merging.update)"
 	)
 '
 
-- 
1.7.0.1.138.ga75b
