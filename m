From: Vasily Titskiy <qehgt0@gmail.com>
Subject: [PATCH v2] Ignore dirty submodule states during stash
Date: Tue, 17 May 2016 13:16:35 +0000
Message-ID: <20160517131635.GA5299@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 15:16:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2era-0003HV-EP
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 15:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897AbcEQNQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 09:16:38 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:32871 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbcEQNQh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 09:16:37 -0400
Received: by mail-yw0-f194.google.com with SMTP id y6so2079190ywe.0
        for <git@vger.kernel.org>; Tue, 17 May 2016 06:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=GK2mEhYFPzICZ4HA4wxVi3atiAZqdxx7gaRlo7w6Ahc=;
        b=pOY9u4Je/nt3MQY6TPmuq+HmrxzU6RSuLogA4lsySh/IYd8egnONcbbpGwt9HzB2IW
         /Ukq+C2IpaWY27y9obsoVWZu0b9atOI2Mt4MvWST+a3PlSGbnsZlva71AlfTYyjo9kB/
         o2rVx5QPhoCDfZ+2v6OHC2guW3OE6SPBrWzYIXf5ua442yPaW4PtMXVna9eAYCScD1qZ
         WfbaCS2fwg8R2F3ISMis+w/WN0kNT5b+7b4wxf135oiuc+EmSffvUvUVpe6otUKFf5zw
         BYeaMbRH/CAw5wnAI4ivzY90CUaq7nxDISPi6c1x9YAdIzs06+hZw/jvSDeSn+z26Fgl
         d1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GK2mEhYFPzICZ4HA4wxVi3atiAZqdxx7gaRlo7w6Ahc=;
        b=FpJNKLTHWn5B7mGB4Ied+kwt1GrzAH8qYphFW+/8D3t1jr/EIZqIjKFJOAjlntsNf0
         +LJm74UDOriXyXJ/zu7IsgV8PxU8of+YJw27BgVEah0iAtsgNrxc0oEw8owFLqsiHVki
         tYnXJEAISkjexWHa7oed8i4sjRJdoxcwsAuq9WbAoEytTSF3cQTe19yEfpDNtcORamlX
         D4sqB1jm4IaF/z/SP7CU7qNwNRwO/dKW144Jr3ShPr+pSiZ0jrXTfdkEVY1dj/+1okxE
         ppz8C2v5cLxuMEN8Zl/WvqLsHypchm1fEkvTq+XB09ivQNk3SNlXeMLnGLIxR2V1whco
         go5w==
X-Gm-Message-State: AOPr4FX8mu76jsYkAc7QeveAH8f6RJVkeFjIBotn/3JQmqH8vkTkH9sQgRSwj+8X023R2A==
X-Received: by 10.37.208.75 with SMTP id h72mr570287ybg.137.1463490996928;
        Tue, 17 May 2016 06:16:36 -0700 (PDT)
Received: from gmail.com ([2600:3c02::f03c:91ff:fe96:da77])
        by smtp.gmail.com with ESMTPSA id x9sm1514254ywg.56.2016.05.17.06.16.36
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 May 2016 06:16:36 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294867>

As stash does not know how to deal with submodules,
it should not try to save/restore their states
as it leads to redundant merge conflicts.

Added test checks if 'stash pop' does not trigger merge conflics
in submodules.

Signed-off-by: Vasily Titskiy <qehgt0@gmail.com>
---
 git-stash.sh     |  2 +-
 t/t3903-stash.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

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
index 2142c1f..1be62f3 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -731,4 +731,38 @@ test_expect_success 'stash list --cc shows combined diff' '
 	test_cmp expect actual
 '
 
+test_expect_success 'stash ignores changes in submodules' '
+	git submodule init &&
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
