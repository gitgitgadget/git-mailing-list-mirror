From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 2/5] t3200: Minor fix when preparing for tracking failure
Date: Sun,  8 Sep 2013 22:58:12 +0200
Message-ID: <1378673895-23127-3-git-send-email-johan@herland.net>
References: <1378464042-17476-1-git-send-email-johan@herland.net>
 <1378673895-23127-1-git-send-email-johan@herland.net>
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Per Cederqvist <cederp@opera.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 08 22:58:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIm46-00039V-M7
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 22:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295Ab3IHU6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 16:58:32 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:49466 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211Ab3IHU62 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 16:58:28 -0400
Received: by mail-la0-f46.google.com with SMTP id eh20so4234495lab.19
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 13:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GhziPahJDpgdPeGy0NSRi+VD3uBq/tt4xaCWxKKuU4U=;
        b=BJBC0BnD7pwvi0LIXQEgokSSaWdOrcfzK/FxXmXsEGno/zUS6kIpHzNdENtrAH3O1I
         xTXBuKC/YXxh53jHAbyjjMq6QjhMvAhl4pLYm1zpJgXzilkbum0W6iEfKuxu08LFcEtV
         v8I/qeoFynoxPuM3MRl3Kna37H0gUmFiN37smiH+poyjbN4IXCU3CxZYxG8R5fYMkdeI
         FXkVukq9q0gzlPNVbRvuAV9W26Lh2wyYnsnOrr1Vyp2fPDYyVtwn4/yMDL5ExA7xnmLE
         cxmw8qelSpa3QJ5DtAn60HB58TvU3uHcBbQT//LMQMhsPdVprjR4dNTttVoBbkzX1kcg
         W7cg==
X-Received: by 10.112.0.173 with SMTP id 13mr13155752lbf.8.1378673907366;
        Sun, 08 Sep 2013 13:58:27 -0700 (PDT)
Received: from beta.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPSA id vo1sm4292384lbb.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 13:58:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1378673895-23127-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234269>

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
