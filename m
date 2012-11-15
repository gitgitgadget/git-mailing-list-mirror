From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 3/5] sequencer.c: handle rfc2822 continuation lines correctly
Date: Wed, 14 Nov 2012 17:37:52 -0800
Message-ID: <1352943474-15573-3-git-send-email-drafnel@gmail.com>
References: <1352943474-15573-1-git-send-email-drafnel@gmail.com>
Cc: Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 02:45:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYoWY-0003Wh-DR
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 02:45:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992539Ab2KOBpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 20:45:32 -0500
Received: from mail-ye0-f174.google.com ([209.85.213.174]:38353 "EHLO
	mail-ye0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992516Ab2KOBpb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 20:45:31 -0500
Received: by mail-ye0-f174.google.com with SMTP id m12so244209yen.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 17:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Vo/94mzgES97phBKjW/BVFRzsG12VK6TdKEZqGnQgsU=;
        b=kHReEIp/zYDrdpVFW3MUaXCMtqduZh2goyjSWIqCmGDyfxCqkfCw3PMOLpOY4s6suu
         lUjEzYk0srQHN8xvzUL+KUUbOVj2ZDIxa1mI9nTCDR5Ie77h9j262TEv16VUj0aMk0l+
         TgXCyLdkSTnxPc3/TZ/7j1LFnOtbZpcHSrv1FeGISuSD3Ai99FytaziTVuujmmROl4Qp
         M5lNfP9jQyFd2rKfUy97uTfOr7dA9XLHtbbzlTytArkMHIWliniKdYKe2MrNmV8TxBqZ
         Mema5kFfIzQWJSuyzquc0kx20aZjF8jvOGkB9VVg4sz/0/865IHprhON4IVB62dYQWg1
         I6AQ==
Received: by 10.101.50.11 with SMTP id c11mr8118415ank.5.1352943492005;
        Wed, 14 Nov 2012 17:38:12 -0800 (PST)
Received: from charliebrown.corp.google.com ([216.239.55.194])
        by mx.google.com with ESMTPS id y9sm4775632anh.20.2012.11.14.17.38.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Nov 2012 17:38:11 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352943474-15573-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209786>

ends_rfc2822_footer() was incorrectly checking whether the current line
was a continuation of the previous line.  It was actually checking the
next line instead of the current line.  Let's fix this and mark the test
as expect_success.

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 sequencer.c              | 2 +-
 t/t3511-cherry-pick-x.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index be0cb8b..01edec2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1040,7 +1040,7 @@ static int ends_rfc2822_footer(struct strbuf *sb, int ignore_footer)
 			; /* do nothing */
 		k++;
 
-		if ((buf[k] == ' ' || buf[k] == '\t') && !first)
+		if ((buf[i] == ' ' || buf[i] == '\t') && !first)
 			continue;
 
 		first = 0;
diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
index b4e5c65..b2098e0 100755
--- a/t/t3511-cherry-pick-x.sh
+++ b/t/t3511-cherry-pick-x.sh
@@ -52,7 +52,7 @@ test_expect_success 'cherry-pick -s inserts blank line after non-rfc2822 footer'
 	test_cmp expect actual
 '
 
-test_expect_failure 'cherry-pick -s not confused by rfc2822 continuation line' '
+test_expect_success 'cherry-pick -s not confused by rfc2822 continuation line' '
 	pristine_detach initial &&
 	git cherry-pick -s rfc2822-base &&
 	cat <<-EOF >expect &&
-- 
1.8.0
