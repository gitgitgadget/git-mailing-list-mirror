From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v3 4/9] stash: teach git stash pop to fail early if the argument is not a stash ref
Date: Sun,  8 Aug 2010 14:46:06 +1000
Message-ID: <1281242771-24764-5-git-send-email-jon.seymour@gmail.com>
References: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, ams@toroid.org, nanako3@bluebottle.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 08 06:47:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ohxne-0007rb-M8
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 06:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113Ab0HHErr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 00:47:47 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:37021 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925Ab0HHErq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 00:47:46 -0400
Received: by mail-px0-f174.google.com with SMTP id 14so3342990pxi.19
        for <git@vger.kernel.org>; Sat, 07 Aug 2010 21:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=wNc9661QwgoUTQCYGX8AOMqD5CTj7TP24nWFsDci/Cg=;
        b=F0FaosawIhU51mo43+ITwteWDGY39pBnPmNHOu9gCLh5Wind/ykwBS2ouGKgixs5pV
         w0xkeGDth/23ip2Fy+WIWWdnqoULJCDve/mEk86+bRob53jsD/I+w5r9doP5Y+4FJ6ur
         tgLsJ/+K1CM6m+cmuoVQ+GQZtA6cxb3WcUtxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=apamO2+5kQRA+xoXbGlkmNzOpLXVo2q+nQfC4702MOU4ucsl1d8EXl8AmuMMbFFSHu
         yjaMIhNV3KEnAbtV5uMyIzvoEFO+dn1Vv+nkH2tyNMzoOybvaBojvgEvTunukv6QHDIM
         pPMe/4A0usdvrW8Wvxdae7OUIAzLEDp//P/sA=
Received: by 10.143.27.18 with SMTP id e18mr12052019wfj.339.1281242865861;
        Sat, 07 Aug 2010 21:47:45 -0700 (PDT)
Received: from localhost.localdomain ([120.16.216.92])
        by mx.google.com with ESMTPS id n2sm4295884wfl.13.2010.08.07.21.47.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Aug 2010 21:47:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.47.gc532
In-Reply-To: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152887>

With this change, git stash pop will fail early if a specified
revision argument is not a valid stash reference.

This fixes the case where the apply succeeds, but the drop fails which
caused git stash pop to exit with a non-zero exit code and a dirty tree.

Now, git stash pop fails with a non-zero exit code, but the tree is not
modified.


Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-stash.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 41a9359..4f28c09 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -351,10 +351,10 @@ apply_stash () {
 }
 
 pop_stash() {
-	if apply_stash "$@"
-	then
-		drop_stash "$applied_stash"
-	fi
+	assert_stash_ref "$@"
+
+	apply_stash "$@" &&
+	drop_stash "$applied_stash"
 }
 
 drop_stash () {
-- 
1.7.2.1.51.g82c0c0
