From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 8/8] t5520: check reflog action in fast-forward merge
Date: Mon, 18 May 2015 21:32:58 +0800
Message-ID: <1431955978-17890-9-git-send-email-pyokagan@gmail.com>
References: <1431955978-17890-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 15:33:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuLB2-0001A5-OZ
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 15:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754218AbbERNdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 09:33:50 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36753 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753946AbbERNdl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 09:33:41 -0400
Received: by pabts4 with SMTP id ts4so152649710pab.3
        for <git@vger.kernel.org>; Mon, 18 May 2015 06:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KkPWyL6fMHNoTyxe2qLU/spssc7078n1Vi4+JUUE30s=;
        b=zq8TZ51GmTSzTTrowXbovTLhbedJw7VePifbz2qJqYvA0FHIG4Nj28qKThDrJDxnn3
         eS2fJ0KVIQYLa6COqqXRTkbzZSMoe22MY37U9vZwDlHjPZtpY6vTr5Zh7OXtpGbSrBn5
         pkVMkpLGPesxn+knMZdu5gjXU0onM+ECk3ttJUDHUDZDPnbP1twXXsz7fi7ZCNV/jFj2
         J7okCARcPOH1WGZK21Jh7vcyVwIsdZtOKz1ufmbDzDH7/rkj6Ea/87tETtE491RgJFFw
         JsP43Kwye9BbvWfKcwjUqm9UqZW7a8/rcjLonLuNb6sMkl3TzQbzaqpq2mr8rhdzGRfy
         yuoQ==
X-Received: by 10.70.101.200 with SMTP id fi8mr43967425pdb.161.1431956021141;
        Mon, 18 May 2015 06:33:41 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id da2sm10119540pbb.57.2015.05.18.06.33.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 06:33:39 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431955978-17890-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269240>

When testing a fast-forward merge with git-pull, check to see if the
reflog action is "pull" with the arguments passed to git-pull.

While we are in the vicinity, remove the empty line as well.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
* Removed use of "verbose".

 t/t5520-pull.sh | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 4d649a5..62dbfb5 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -86,7 +86,6 @@ test_expect_success 'pulling into void must not create an octopus' '
 '
 
 test_expect_success 'test . as a remote' '
-
 	git branch copy master &&
 	git config branch.copy.remote . &&
 	git config branch.copy.merge refs/heads/master &&
@@ -95,7 +94,11 @@ test_expect_success 'test . as a remote' '
 	git checkout copy &&
 	test "$(cat file)" = file &&
 	git pull &&
-	test "$(cat file)" = updated
+	test "$(cat file)" = updated &&
+	git reflog -1 >reflog.actual &&
+	sed "s/$_x05[0-9a-f]*/OBJID/g" reflog.actual >reflog.fuzzy &&
+	echo "OBJID HEAD@{0}: pull: Fast-forward" >reflog.expected &&
+	test_cmp reflog.expected reflog.fuzzy
 '
 
 test_expect_success 'the default remote . should not break explicit pull' '
@@ -106,7 +109,11 @@ test_expect_success 'the default remote . should not break explicit pull' '
 	git reset --hard HEAD^ &&
 	test "$(cat file)" = file &&
 	git pull . second &&
-	test "$(cat file)" = modified
+	test "$(cat file)" = modified &&
+	git reflog -1 >reflog.actual &&
+	sed "s/$_x05[0-9a-f]*/OBJID/g" reflog.actual >reflog.fuzzy &&
+	echo "OBJID HEAD@{0}: pull . second: Fast-forward" >reflog.expected &&
+	test_cmp reflog.expected reflog.fuzzy
 '
 
 test_expect_success 'fail if wildcard spec does not match any refs' '
-- 
2.1.4
