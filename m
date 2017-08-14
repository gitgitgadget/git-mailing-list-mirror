Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 631D420899
	for <e@80x24.org>; Mon, 14 Aug 2017 21:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752373AbdHNVoB (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 17:44:01 -0400
Received: from ikke.info ([178.21.113.177]:53004 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752339AbdHNVoB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 17:44:01 -0400
Received: by vps892.directvps.nl (Postfix, from userid 182)
        id BB7D0440121; Mon, 14 Aug 2017 23:43:59 +0200 (CEST)
Received: from epsilon.home (unknown [10.8.0.22])
        by vps892.directvps.nl (Postfix) with ESMTP id 3DFB3440118;
        Mon, 14 Aug 2017 23:43:58 +0200 (CEST)
From:   Kevin Daudt <me@ikke.info>
To:     git@vger.kernel.org
Cc:     "Junio C . Hamano" <gitster@pobox.com>, Kevin Daudt <me@ikke.info>
Subject: [PATCH v2] stash: prevent warning about null bytes in input
Date:   Mon, 14 Aug 2017 23:43:33 +0200
Message-Id: <20170814214333.12789-1-me@ikke.info>
X-Mailer: git-send-email 2.14.1.146.gfcbc02b1e
In-Reply-To: <20170814050801.7158-1-me@ikke.info>
References: <20170814050801.7158-1-me@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `no_changes` function calls the `untracked_files` function through
command substitution. `untracked_files` will return null bytes because it
runs ls-files with the '-z' option.

Bash since version 4.4 warns about these null bytes. As they are not
required for the test that is being done, make sure `untracked_files`
does not output null bytes when not required.

This is achieved by adding a parameter to the `untracked_files` function to
specify wither `-z` should be passed to ls-files or not.

This warning is triggered when running git stash save -u resulting in
two warnings:

    git-stash: line 43: warning: command substitution: ignored null byte
    in input

Signed-off-by: Kevin Daudt <me@ikke.info>
---
 git-stash.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 9b6c2da7b..5f09a47f0 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -43,9 +43,16 @@ no_changes () {
 }
 
 untracked_files () {
+	if test "$1" = "-z"
+	then
+		shift
+		z=-z
+	else
+		z=
+	fi
 	excl_opt=--exclude-standard
 	test "$untracked" = "all" && excl_opt=
-	git ls-files -o -z $excl_opt -- "$@"
+	git ls-files -o $z $excl_opt -- "$@"
 }
 
 clear_stash () {
@@ -114,7 +121,7 @@ create_stash () {
 		# Untracked files are stored by themselves in a parentless commit, for
 		# ease of unpacking later.
 		u_commit=$(
-			untracked_files "$@" | (
+			untracked_files -z "$@" | (
 				GIT_INDEX_FILE="$TMPindex" &&
 				export GIT_INDEX_FILE &&
 				rm -f "$TMPindex" &&
-- 
2.14.1.145.gb3622a4ee9

