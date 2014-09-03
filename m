From: Chris Packham <judge.packham@gmail.com>
Subject: [RFC PATCHv2 2/2] am: avoid re-directing stdin twice
Date: Thu,  4 Sep 2014 10:21:58 +1200
Message-ID: <1409782918-26133-3-git-send-email-judge.packham@gmail.com>
References: <1409736919-22341-1-git-send-email-judge.packham@gmail.com>
 <1409782918-26133-1-git-send-email-judge.packham@gmail.com>
Cc: Chris Packham <judge.packham@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 00:23:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPIxC-0000hP-J8
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 00:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934114AbaICWWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 18:22:40 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:53025 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933907AbaICWWh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 18:22:37 -0400
Received: by mail-pa0-f46.google.com with SMTP id eu11so18537156pac.19
        for <git@vger.kernel.org>; Wed, 03 Sep 2014 15:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HXrEPR8oMX0Zpdf0HIetx6PPI+Zb62vU3jo+0PG0Pkc=;
        b=VH/8gfqRce95avhCsEqKCB3nNlNgI6fO3Ggnb10/LjGiZ/kAQKoRCLdTRhSHhcl1kk
         7fSnl8AJFz5RCb5Um+U0LxR1QY/YfyVKn3+3pScXv/BPuatkw99nkc8useCx427+rR38
         PEt/Kixtj7XIO7tR7/YqymO6HC7bWt7Tm81dvMLNp1B5cUDS/QaKjaRVJZvt2zpcmdil
         bNz/QbyE+SKGhoTDqkUi3WFo6MeS/CkphBirpZoVS30xNn3DEQhc1xyfLHGdCla6pnvQ
         BO56PXMIUni0rUmUuLLhsYmTVZUcys1I2X4JGaVzmb9lwP1NzC8mGRODQhSFcVQfKO6k
         vgFQ==
X-Received: by 10.70.36.239 with SMTP id t15mr500053pdj.83.1409782955195;
        Wed, 03 Sep 2014 15:22:35 -0700 (PDT)
Received: from chrisp3-dl.ws.atlnz.lc (2-163-36-202-static.alliedtelesis.co.nz. [202.36.163.2])
        by mx.google.com with ESMTPSA id we5sm20099548pab.28.2014.09.03.15.22.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 03 Sep 2014 15:22:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1409782918-26133-1-git-send-email-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256425>

In check_patch_format we feed $1 to a block that attempts to determine
the patch format. Since we've already redirected $1 to stdin there is no
need to redirect it again when we invoke tr. This prevents the following
errors when invoking git am

  $ git am patch.patch
  tr: write error: Broken pipe
  tr: write error
  Patch format detection failed.

Cc: Stephen Boyd <bebarino@gmail.com>
Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
 git-am.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-am.sh b/git-am.sh
index f979925..5d69c89 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -253,7 +253,7 @@ check_patch_format () {
 			# discarding the indented remainder of folded lines,
 			# and see if it looks like that they all begin with the
 			# header field names...
-			tr -d '\015' <"$1" |
+			tr -d '\015' |
 			sed -n -e '/^$/q' -e '/^[ 	]/d' -e p |
 			sane_egrep -v '^[!-9;-~]+:' >/dev/null ||
 			patch_format=mbox
-- 
2.0.4.2.gadd452d
