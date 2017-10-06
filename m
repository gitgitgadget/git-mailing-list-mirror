Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 775B320373
	for <e@80x24.org>; Fri,  6 Oct 2017 22:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751782AbdJFWcj (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 18:32:39 -0400
Received: from smtprelay09.ispgateway.de ([134.119.228.119]:56810 "EHLO
        smtprelay09.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751418AbdJFWcj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 18:32:39 -0400
Received: from [89.246.212.34] (helo=sandbox)
        by smtprelay09.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1e0bAa-000732-06; Sat, 07 Oct 2017 00:32:36 +0200
Date:   Sat, 7 Oct 2017 00:32:34 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, Jens.Lehmann@web.de,
        bmwill@google.com
Subject: [RFC PATCH 2/4] change submodule push test to use proper repository
 setup
Message-ID: <20171006223234.GC26642@sandbox>
References: <20171006222544.GA26642@sandbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171006222544.GA26642@sandbox>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

NOTE: The argument in this message is not correct, see description in
cover letter.

The setup of the repositories in this test is using gitlinks without the
.gitmodules infrastructure. It is however testing convenience features
like --recurse-submodules=on-demand. These features are already not
supported by fetch without a .gitmodules file. This leads us to the
conclusion that it is not really used here as well.

Let's use the usual submodule commands to setup the repository in a
typical way. This also has the advantage that we are testing with a
repository structure that is more similar to one we could expect on a
users setup.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---

As mentioned in the cover letter. This seems to be the only test that
ensures that we stay compatible with setups without .gitmodules. Maybe
we should add/revive some?

Cheers Heiko

 t/t5531-deep-submodule-push.sh | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 39cb2c1..a4a2c6a 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -8,22 +8,26 @@ test_expect_success setup '
 	mkdir pub.git &&
 	GIT_DIR=pub.git git init --bare &&
 	GIT_DIR=pub.git git config receive.fsckobjects true &&
+	mkdir submodule &&
+	(
+		cd submodule &&
+		git init &&
+		git config push.default matching &&
+		>junk &&
+		git add junk &&
+		git commit -m "Initial junk"
+	) &&
+	git clone --bare submodule submodule.git &&
 	mkdir work &&
 	(
 		cd work &&
 		git init &&
 		git config push.default matching &&
-		mkdir -p gar/bage &&
-		(
-			cd gar/bage &&
-			git init &&
-			git config push.default matching &&
-			>junk &&
-			git add junk &&
-			git commit -m "Initial junk"
-		) &&
-		git add gar/bage &&
+		mkdir gar &&
+		git submodule add ../submodule.git gar/bage &&
 		git commit -m "Initial superproject"
+		cd gar/bage &&
+		git remote rm origin
 	)
 '
 
@@ -51,11 +55,10 @@ test_expect_success 'push if submodule has no remote' '
 
 test_expect_success 'push fails if submodule commit not on remote' '
 	(
-		cd work/gar &&
-		git clone --bare bage ../../submodule.git &&
-		cd bage &&
+		cd work/gar/bage &&
 		git remote add origin ../../../submodule.git &&
 		git fetch &&
+		git push --set-upstream origin master &&
 		>junk3 &&
 		git add junk3 &&
 		git commit -m "Third junk"
-- 
2.10.0.129.g35f6318

