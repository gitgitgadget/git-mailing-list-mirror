Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21AB620133
	for <e@80x24.org>; Mon,  6 Mar 2017 21:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754444AbdCFVHO (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 16:07:14 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36725 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754398AbdCFVHH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 16:07:07 -0500
Received: by mail-pf0-f180.google.com with SMTP id o126so17910109pfb.3
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 13:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NlstRGmIyknOza+YsTvdD6UGW3fC4qnUSfzWLcmQkuw=;
        b=b5owFfZCz8bKjqM/UgZao//WdwyXXI2I5SsH8XkZ0JArp6X6/cImY14Y519hOxJ2WP
         36/LeloHm85zqW6yacQbmy1PbjMzgQV3n4Rjrf0rFzZAwqbzFgtftC+y8zm9h2ARcb9k
         Gq2e3uqlER92YKx35sOOpfNCzzU+PTGNFq0T/YCM4IMHX/8rXivcj0mEu9lUo3uPSZug
         0CvKkgQaBILcQvqbMLZXoTRo3SBMGSEsdQwe5my/ipGB94+bj+/FVvIjmHpQpqNc3S5E
         RTq66Z4nvnI7Vuj34Zj7VOWiWYyoWbuOMJjrK142ZBBu/zu5Gk+P/3zRYHRgc1eBJLHd
         icww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NlstRGmIyknOza+YsTvdD6UGW3fC4qnUSfzWLcmQkuw=;
        b=Zxyi23fzFJZRIK0ocwztUkx1HxOyKaURyvGpMcr+bKszrN7yLJIY2iuTZk68chagqs
         ZcTfNmHuYQ+pm4Tut+k2hW2papfdZiSX+sG7DhmHYQDIVIDZXzHDp6PFb+a9XrsnJ0LT
         8HDEuW96uv1EOJnLCtIiAGCYG+5K9Dwv9aP/Ga3a2HSCDLrLhv5EBSZB3bm7CMfKO/fE
         CCF+/W6NOZYDjPQ688Xk3xImIpG59iJPoxJRvKd7obOyq1WIW/JKjaUZJwV9SGhp2lG2
         jsXtii87nGe0+cJr3guOR2DCjCNbKkxQZ2bL2adsPLfzmwvqpxIvwZ90pyAjeGVg24dq
         0Q2w==
X-Gm-Message-State: AMke39nDVOIbFUP77p3b1LRP+sQau7X1QmftVpdtQuIXEQ08yY0sglb17kkgt4H3esGPGAFB
X-Received: by 10.84.150.129 with SMTP id h1mr29360786plh.86.1488833966240;
        Mon, 06 Mar 2017 12:59:26 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:44ae:633a:9d1d:6402])
        by smtp.gmail.com with ESMTPSA id c22sm41641801pgn.43.2017.03.06.12.59.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 12:59:25 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 02/18] lib-submodule-update.sh: do not use ./. as submodule remote
Date:   Mon,  6 Mar 2017 12:59:03 -0800
Message-Id: <20170306205919.9713-3-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.52.ge239d7e709.dirty
In-Reply-To: <20170306205919.9713-1-sbeller@google.com>
References: <20170302004759.27852-1-sbeller@google.com>
 <20170306205919.9713-1-sbeller@google.com>
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

