From: Vasily Titskiy <qehgt0@gmail.com>
Subject: [PATCH v3] Ignore dirty submodule states during stash
Date: Tue, 17 May 2016 18:07:05 +0000
Message-ID: <20160517180704.GA11769@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 20:07:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2jOl-0007Dm-Bp
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 20:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbcEQSHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 14:07:09 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34905 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbcEQSHI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 14:07:08 -0400
Received: by mail-yw0-f193.google.com with SMTP id v81so3300936ywa.2
        for <git@vger.kernel.org>; Tue, 17 May 2016 11:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bmNIfC/iBHXKckcar27ejCZQovTlYhF2VTOLTnU5cwA=;
        b=neZylpPWXT3Ea3Iq/t94vAlSTGKbmmUay97gA/rXEmtSxA8anKWBMeAk6zliDzC053
         UzN46Fi83S3fBZL0dn3Ka9dBIr+hxq9LczobjhVvBPSeesoiVypbw3oKHXC9dfgmCzK0
         exNk/b4gNHi3I2YesEr9z1C+QZEpsULuhQi7rWploio4iWqFp5bGNHtKkKa/AqYtYRo+
         sBdCbf0DCb671lnMKLSE9u09nm91Ybe3bkfISJX4WAowQBuc5f0M5qVgi8C+bm5Grd39
         MUJ1De6fboq7CjzU0j+euR6EZCXM01hiX8t4xj11vVkDgOovCkYkQvCLH5G4vkWH0z+Z
         iYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bmNIfC/iBHXKckcar27ejCZQovTlYhF2VTOLTnU5cwA=;
        b=LJ/BkJ9d2Q/NrNDLpMviReNe3b8XoviSG1QV+1gk5bLJ6ANc7xjYx4EXm1IR8D3Lqo
         MOGWAY0xRFGSxjb3LCJ3XScOuuqUlrrETFdKSwzQIK/SLvKb3bdkyV9VQx6O0eMvONYa
         IRrC0SSjpOMJAEqMgVkCP7/ZM+1NV+mtn9aAU4Dd2M/eBodvlPAhVeQ2t+fO871nrTZ7
         g4kAYfC7Kdh/1pd/EkWOqehLusMDhYBvbKqdfCPAfWom0dnxdFvFBFm8wFbKqT2/wUHB
         PGv1ynibHi/W88kNX8DE2rSQKWtF+e4XekXm/on83DLLdXAnKwSU735hBTEYLjknP/iY
         vBFQ==
X-Gm-Message-State: AOPr4FXQohtHi51gtq+J3ZCoJrClbrzO6FrkJCDcA1nMiZg/fB+esAtMmzorxIipXNalWA==
X-Received: by 10.13.230.65 with SMTP id p62mr1522744ywe.187.1463508427408;
        Tue, 17 May 2016 11:07:07 -0700 (PDT)
Received: from gmail.com ([2600:3c02::f03c:91ff:fe96:da77])
        by smtp.gmail.com with ESMTPSA id m141sm2301337ywd.2.2016.05.17.11.07.06
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 May 2016 11:07:07 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294888>

As stash does not know how to deal with submodules,
it should not try to save/restore their states
as it leads to redundant merge conflicts.

Added test checks if 'stash pop' does not trigger merge conflicts
in submodules.

Signed-off-by: Vasily Titskiy <qehgt0@gmail.com>
---
 git-stash.sh     |  2 +-
 t/t3903-stash.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index c7c65e2..b500c44 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -116,7 +116,7 @@ create_stash () {
 			git read-tree --index-output="$TMPindex" -m $i_tree &&
 			GIT_INDEX_FILE="$TMPindex" &&
 			export GIT_INDEX_FILE &&
-			git diff --name-only -z HEAD -- >"$TMP-stagenames" &&
+			git diff --name-only --ignore-submodules -z HEAD -- >"$TMP-stagenames" &&
 			git update-index -z --add --remove --stdin <"$TMP-stagenames" &&
 			git write-tree &&
 			rm -f "$TMPindex"
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 2142c1f..dfe39a4 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -731,4 +731,37 @@ test_expect_success 'stash list --cc shows combined diff' '
 	test_cmp expect actual
 '
 
+test_expect_success 'stash ignores changes in submodules' '
+	git init sub1 &&
+	(
+		cd sub1 &&
+		echo "x" >file1 &&
+		git add file1 &&
+		git commit -a -m "initial sub1"
+	) &&
+	git submodule add ./. sub1 &&
+	echo "main" >file1 &&
+	git add file1 &&
+	git commit -a -m "initial main" &&
+	# make changes in submodule
+	(
+		cd sub1 &&
+		echo "y" >>file1 &&
+		git commit -a -m "change y"
+	) &&
+	git commit sub1 -m "update reference" &&
+	# switch submodule to another revision
+	(
+		cd sub1 &&
+		echo "z" >>file1 &&
+		git commit -a -m "change z"
+	) &&
+	# everything is prepared, check if changes in submodules are ignored
+	echo "local change" >>file1 &&
+	git stash save &&
+	git checkout HEAD~1 &&
+	git submodule update &&
+	git stash pop
+'
+
 test_done
-- 
2.1.4
