From: Johan Herland <johan@herland.net>
Subject: [PATCH 2/5] t3200: Minor fix when preparing for tracking failure
Date: Fri,  6 Sep 2013 12:40:39 +0200
Message-ID: <1378464042-17476-3-git-send-email-johan@herland.net>
References: <1378464042-17476-1-git-send-email-johan@herland.net>
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Per Cederqvist <cederp@opera.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 06 12:41:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHtTs-00009X-HD
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 12:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253Ab3IFKlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 06:41:19 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:38649 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138Ab3IFKlR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 06:41:17 -0400
Received: by mail-lb0-f171.google.com with SMTP id u14so2740938lbd.30
        for <git@vger.kernel.org>; Fri, 06 Sep 2013 03:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GhziPahJDpgdPeGy0NSRi+VD3uBq/tt4xaCWxKKuU4U=;
        b=XEkUD5t1ghYKgcovp3d5CCw5qedGXnJqrY0Hb28jBY1IDt9JTFqnYh7wEsM9Vzr3p4
         /h6vFWpaKZs1HKTRBuyN2n/4Ib2G+L+uw8kMWaV9CofJBhu8VFKZi/EVrIXgbwSK2c6B
         MSNqtujSaAJxidtZMcUTTSa3DU8coN8RbE4vD5eG8BqZxWtly742+ilz9eH5YFMi5VFK
         DxcPSbTgoiq/mUUz7cL17SOJo7vat7zEFHClCHfMWxTrTfdm5HCtyC4jzuVDa6ThbpUG
         29LOHHEHMkeBso6rLaGkllC7ajdLszvYlxwEwhwqTIr/Mgq0h6W04mivcXTYXymyFngw
         J9TA==
X-Received: by 10.112.14.102 with SMTP id o6mr2337218lbc.28.1378464075809;
        Fri, 06 Sep 2013 03:41:15 -0700 (PDT)
Received: from localhost.localdomain (c80-216-222-129.bredband.comhem.se. [80.216.222.129])
        by mx.google.com with ESMTPSA id vs11sm1000794lac.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Sep 2013 03:41:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1378464042-17476-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234034>

We're testing that trying to --track a ref that is not covered by any remote
refspec should fail. For that, we want to have refs/remotes/local/master
present, but we also want the remote.local.fetch refspec to NOT match
refs/remotes/local/master (so that the tracking setup will fail, as intended).
However, when doing "git fetch local" to ensure the existence of
refs/remotes/local/master, we must not already have changed remote.local.fetch
so as to cause refs/remotes/local/master not to be fetched. Therefore, set
remote.local.fetch to refs/heads/*:refs/remotes/local/* BEFORE we fetch, and
then reset it to refs/heads/s:refs/remotes/local/s AFTER we have fetched
(but before we test --track).

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t3200-branch.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 44ec6a4..8f6ab8e 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -319,8 +319,9 @@ test_expect_success 'test tracking setup (non-wildcard, matching)' '
 
 test_expect_success 'tracking setup fails on non-matching refspec' '
 	git config remote.local.url . &&
-	git config remote.local.fetch refs/heads/s:refs/remotes/local/s &&
+	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
+	git config remote.local.fetch refs/heads/s:refs/remotes/local/s &&
 	test_must_fail git branch --track my5 local/master &&
 	test_must_fail git config branch.my5.remote &&
 	test_must_fail git config branch.my5.merge
-- 
1.8.3.GIT
