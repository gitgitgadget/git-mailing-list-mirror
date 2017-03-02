Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78A042023D
	for <e@80x24.org>; Thu,  2 Mar 2017 00:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753705AbdCBAyu (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 19:54:50 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34706 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753574AbdCBAyr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 19:54:47 -0500
Received: by mail-pg0-f42.google.com with SMTP id p5so25792690pga.1
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 16:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NlstRGmIyknOza+YsTvdD6UGW3fC4qnUSfzWLcmQkuw=;
        b=WU5fmUJ7/z0VIS7Po7IoUx+uC82ifqF5pEZCfnuNijM3NmGpmxacIM26sC0LFpWnHs
         R/uSV6LAfYeMowo1v+UGwNZRFIuAqZgG91tGj99eJd8ijLFzTzw2N2DuY/p/OlYRXC9d
         V1je80+fFwQBpTkrNOGQENQvdzT9i13zTxYNvgqGZbSrI1AexK34FksNTG27nU/EWlkF
         cQwEdd9++31YXC/jlGKFN0ZBYrvFL+DhKuWj73QcFy7YEMQieSgLHbRedzSQjJ75Ycvy
         R6RLO6kQjwCWZRNxRLuXWkbQa7qKpFAE1l1UM5l+78kNtarurpIyttZBjbWAyvKlnIwf
         U5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NlstRGmIyknOza+YsTvdD6UGW3fC4qnUSfzWLcmQkuw=;
        b=EsXdSoSdx3GMq2GTZ/Oew2zd8uJEQWQSwGTJJ6M7V+xSjbI5XP7/3i5oMleDDngku+
         s6JvXb1w2MaAnXoJiHXlkeEGpbCdms5g3orN80BiPbjus4fPq6oKnYxDtXDyDSQad1EN
         I1aqkJAQ/ytNWPn5kpl4G7X1ao/8FsUtS10irgLcZoM/SYcPGaj5n43A0Ti6Mtqplzqw
         PiOymgspDRIYiBiAx/1axzG3PJu8eZokbbedIFe4e3K6aXipoOY3XxrIIgqnzvkJkfU1
         dtXXiSVLvTrMzgQP8Drohh7go8TDNC5XfGqu+PIF13Q6ZXzA159dm7ky0Lt2FbNAMm4Y
         lozg==
X-Gm-Message-State: AMke39mOKnxnl/G0OHA2OnoMX3+eok9lCIDhZFsKoDwCTEsLSKpyZglczcjiSYaR/azAsiku
X-Received: by 10.98.91.131 with SMTP id p125mr12208655pfb.165.1488415686755;
        Wed, 01 Mar 2017 16:48:06 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:695f:c2a1:ec60:5665])
        by smtp.gmail.com with ESMTPSA id g78sm12789237pfe.5.2017.03.01.16.48.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Mar 2017 16:48:06 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net, gitster@pobox.com,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 02/18] lib-submodule-update.sh: do not use ./. as submodule remote
Date:   Wed,  1 Mar 2017 16:47:43 -0800
Message-Id: <20170302004759.27852-3-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.52.ge239d7e709.dirty
In-Reply-To: <20170302004759.27852-1-sbeller@google.com>
References: <20170223225735.10994-1-sbeller@google.com/>
 <20170302004759.27852-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adding the repository itself as a submodule does not make sense in the
real world. In our test suite we used to do that out of convenience in
some tests as the current repository has easiest access for setting up
'just a submodule'.

However this doesn't quite test the real world, so let's do not follow
this pattern any further and actually create an independent repository
that we can use as a submodule.

When using './.' as the remote the superproject and submodule share the
same objects, such that testing if a given sha1 is a valid commit works
in either repository.  As running commands in an unpopulated submodule
fall back to the superproject, this happens in `reset_work_tree_to`
to determine if we need to populate the submodule. Fix this bug by
checking in the actual remote now.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/lib-submodule-update.sh | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 5df528ea81..c0d6325133 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -37,6 +37,17 @@
 #
 
 create_lib_submodule_repo () {
+	git init submodule_update_sub1 &&
+	(
+		cd submodule_update_sub1 &&
+		echo "expect" >>.gitignore &&
+		echo "actual" >>.gitignore &&
+		echo "x" >file1 &&
+		echo "y" >file2 &&
+		git add .gitignore file1 file2 &&
+		git commit -m "Base inside first submodule" &&
+		git branch "no_submodule"
+	) &&
 	git init submodule_update_repo &&
 	(
 		cd submodule_update_repo &&
@@ -49,7 +60,7 @@ create_lib_submodule_repo () {
 		git branch "no_submodule" &&
 
 		git checkout -b "add_sub1" &&
-		git submodule add ./. sub1 &&
+		git submodule add ../submodule_update_sub1 sub1 &&
 		git config -f .gitmodules submodule.sub1.ignore all &&
 		git config submodule.sub1.ignore all &&
 		git add .gitmodules &&
@@ -162,7 +173,7 @@ reset_work_tree_to () {
 		test_must_be_empty actual &&
 		sha1=$(git rev-parse --revs-only HEAD:sub1) &&
 		if test -n "$sha1" &&
-		   test $(cd "sub1" && git rev-parse --verify "$sha1^{commit}")
+		   test $(cd "../submodule_update_sub1" && git rev-parse --verify "$sha1^{commit}")
 		then
 			git submodule update --init --recursive "sub1"
 		fi
-- 
2.12.0.rc1.52.ge239d7e709.dirty

