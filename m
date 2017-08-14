Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79BBC1F667
	for <e@80x24.org>; Mon, 14 Aug 2017 05:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751122AbdHNFJM (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 01:09:12 -0400
Received: from ikke.info ([178.21.113.177]:35616 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750876AbdHNFJL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 01:09:11 -0400
Received: by vps892.directvps.nl (Postfix, from userid 182)
        id 895BA4400AE; Mon, 14 Aug 2017 07:09:10 +0200 (CEST)
Received: from epsilon.home (unknown [10.8.0.22])
        by vps892.directvps.nl (Postfix) with ESMTP id CEC66440084;
        Mon, 14 Aug 2017 07:09:08 +0200 (CEST)
From:   Kevin Daudt <me@ikke.info>
To:     git@vger.kernel.org
Cc:     Kevin Daudt <me@ikke.info>
Subject: [PATCH] stash: prevent warning about null bytes in input
Date:   Mon, 14 Aug 2017 07:08:01 +0200
Message-Id: <20170814050801.7158-1-me@ikke.info>
X-Mailer: git-send-email 2.14.1.146.gfcbc02b1e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The no_changes function calls the untracked_files function through
command substitution. untracked_files will return null bytes because it
runs ls-files with the '-z' option.

Bash since version 4.4 warns about these null bytes. As they are not
required for the test that is being done, remove null bytes from the
input.

This warning is triggered when running git stash save -u resulting in
two warnings:

    git-stash: line 43: warning: command substitution: ignored null byte
    in input

Signed-off-by: Kevin Daudt <me@ikke.info>
---
 git-stash.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index 9b6c2da7b..0dcca3cd6 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -39,7 +39,7 @@ fi
 no_changes () {
 	git diff-index --quiet --cached HEAD --ignore-submodules -- "$@" &&
 	git diff-files --quiet --ignore-submodules -- "$@" &&
-	(test -z "$untracked" || test -z "$(untracked_files)")
+	(test -z "$untracked" || test -z "$(untracked_files | tr -d '\0')")
 }
 
 untracked_files () {
-- 
2.14.0.rc1.33.g384a8b271c

