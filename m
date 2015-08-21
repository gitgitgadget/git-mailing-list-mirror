From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 1/3] t4151: demonstrate that builtin am corrupts index' stat data
Date: Fri, 21 Aug 2015 01:02:29 -0700
Message-ID: <1440144151-24026-1-git-send-email-davvid@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 10:02:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZShHn-0005dX-Nu
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 10:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbbHUICh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 04:02:37 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36497 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbbHUICe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 04:02:34 -0400
Received: by pawq9 with SMTP id q9so47424225paw.3
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 01:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=85Ryz+tWx1f9OVsHfrUiRAv6wNgn829YQt4z+mk7QRM=;
        b=XdH/daWEW416RJybxFhvHNAdQ9fD6gC4Bi2oFFgMhLw4fBPZFtJA5Gl2cSi5OqIvjV
         s/48+Xdqv5KCHH3N1Is5/b2EBeQp9yFMgA7hRV7qy42nwGK6ljxltaoOXeg2W6tNH07f
         Exio/Fw/fVhDZpXqegZJL1+aUDk/OSk/0pG/Afk6omI7lyF5FFA5+h5uFzr6oRT0qWjk
         Dek01Mkm4e9hDfIujVfbHip2P7DMCWgSdYn8+0jyPNVrq6HsZ4LPr3yFLoLmgtPtco16
         aNMqFra/4NzhmzCX4x1XMzOGfFp5Ail7WMjgRalIawkw5sP07RVbY8hpN+I04DjNuCMn
         5R/w==
X-Received: by 10.66.162.229 with SMTP id yd5mr15019081pab.102.1440144154012;
        Fri, 21 Aug 2015 01:02:34 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id ng13sm488238pdb.21.2015.08.21.01.02.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Aug 2015 01:02:33 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.403.gd17121e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276280>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Reported by Linus Torvalds.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t4151-am-abort.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index 05bdc3e..bf2e6f4 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -168,4 +168,16 @@ test_expect_success 'am --abort on unborn branch will keep local commits intact'
 	test_cmp expect actual
 '
 
+test_expect_failure 'am --abort leaves index stat info alone' '
+	git checkout -f --orphan stat-info &&
+	git reset &&
+	test_commit should-be-untouched &&
+	test-chmtime =0 should-be-untouched.t &&
+	git update-index --refresh &&
+	git diff-files --exit-code --quiet &&
+	test_must_fail git am 0001-*.patch &&
+	git am --abort &&
+	git diff-files --exit-code --quiet
+'
+
 test_done
-- 
2.5.0.403.gd17121e
