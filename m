From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 3/7] t5520: test for failure if index has unresolved entries
Date: Sat,  2 May 2015 23:37:11 +0800
Message-ID: <1430581035-29464-4-git-send-email-pyokagan@gmail.com>
References: <1430581035-29464-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 02 17:37:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoZUA-00037G-E9
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 17:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbbEBPhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2015 11:37:35 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34357 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435AbbEBPhd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2015 11:37:33 -0400
Received: by pacyx8 with SMTP id yx8so119397014pac.1
        for <git@vger.kernel.org>; Sat, 02 May 2015 08:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nD2oF8/B9y2FZAx2SSBsDIbmTysvwGdLNI4JzguHhSU=;
        b=tl695xEAvwe2j12lOoOXdJDSx7+dOEorps3mLetsYK84RsLRvZ7/e7KjL7XOExD4lD
         +bUleiZUYDjKi0yhkfRMPWWjU4bEsPB3TJ27sx+1y8l42izfQI4qOuwzZoXUyoBR+lb3
         k9IJddp01YmhHpqZ6AeUFTWMk596jlO897Yktt0gW4gCzVmVFBQ/lBBCiBrXY36ZXhNw
         LfC3iztjoPOYnaPoX+/JeuAIw6lmqid+Ms8lhHuX/EgC5nwimMSXwWqHWCEswScgbGFr
         fAlVni9vLl4SGUd0E9n6txTCDNdTgNYZJtHyrNnul225zTj6JJJUeQ6mnbK4tadSaggp
         tz8Q==
X-Received: by 10.68.167.162 with SMTP id zp2mr27440371pbb.105.1430581052976;
        Sat, 02 May 2015 08:37:32 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.172.217])
        by mx.google.com with ESMTPSA id tk9sm7925072pbc.35.2015.05.02.08.37.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 May 2015 08:37:31 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430581035-29464-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268235>

Commit d38a30df (Be more user-friendly when refusing to do something
because of conflict) introduced code paths to git-pull which will error
out with user-friendly advices if the user is in the middle of a merge
or has unmerged files.

Implement tests to ensure that git-pull will not run, and will print
these advices, if the user is in the middle of a merge or has unmerged
files in the index.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t5520-pull.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 635ec02..9f57e0d 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -174,6 +174,21 @@ test_expect_success 'fail if wildcard spec does not match any refs' "
 	test_i18ngrep 'There are no candidates for merging' out
 "
 
+test_expect_success 'fail if the index has unresolved entries' '
+	git checkout -b third master^ &&
+	test_when_finished "git checkout -f copy && git branch -D third" &&
+	echo file >expected &&
+	test_cmp expected file &&
+	echo modified2 >file &&
+	git commit -a -m modified2 &&
+	test_must_fail git pull . second &&
+	test_must_fail git pull . second 2>out &&
+	test_i18ngrep "Pull is not possible because you have unmerged files" out &&
+	git add file &&
+	test_must_fail git pull . second 2>out &&
+	test_i18ngrep "You have not concluded your merge" out
+'
+
 test_expect_success '--rebase' '
 	git branch to-rebase &&
 	echo modified again > file &&
-- 
2.1.4
