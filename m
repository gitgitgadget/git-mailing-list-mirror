Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA7F51F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 21:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfJEVMW (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 17:12:22 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36304 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725789AbfJEVMU (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 5 Oct 2019 17:12:20 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AAC8E61C65;
        Sat,  5 Oct 2019 21:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1570309939;
        bh=KtiT5CidkjsFlDXBaQ/DpJldMHEGdvP6U+ynpDTh+Y0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=yXnpYYpnvoaGkIjAklH0IJfdaQwxJz+f9qLgIa8OlFHCSqvz1Acucr4bfTsJbtJ8A
         tqfbMcDlYduaIEZSDmmN55Gbczj+09haA5Lt2XC57Tl+eg/80PrAB8d9aK/wqZprRi
         bg5IegGSme34lDduJkOTwDvfoE4H1RNwR0nK1WRsR7tzJLMLeHNSV/p5gaZYvpY2hX
         zh6Np/FWAOATqMahC08Tp/r2deOCL0Ae4SwbZHjR06ZSAKaqDQ3x6LeY7dn6550sht
         FLPILadeHvGqchgj5NuSFn9Qaiuq8e7SM1lID8VKiIa494zwkNMApb8NUXZOVBjs9a
         +RgB05VLTKbmrVbjPd5IiCY1SLk1sbLstEJPNjRk+cU+U5U0bUvPThKGoTh1ulW3/7
         cEME/rD2QLwzQeFkDl3lq0N5DlpxJhgVEuOiWzkcFTsBF4qczFllJt6r/tLoLtBXuw
         H3IALAvi4HMPOJEQbFdFA2PQxN6Xftu36tcSN2vNJm93dDAyeLR
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 06/15] t4010: abstract away SHA-1-specific constants
Date:   Sat,  5 Oct 2019 21:12:00 +0000
Message-Id: <20191005211209.18237-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb
In-Reply-To: <20191005211209.18237-1-sandals@crustytoothpaste.net>
References: <20191005211209.18237-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for object IDs instead of
using hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4010-diff-pathspec.sh | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index 281f8fad0c..e5ca359edf 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -17,11 +17,15 @@ test_expect_success \
     'echo frotz >file0 &&
      mkdir path1 &&
      echo rezrov >path1/file1 &&
+     before0=$(git hash-object file0) &&
+     before1=$(git hash-object path1/file1) &&
      git update-index --add file0 path1/file1 &&
      tree=$(git write-tree) &&
      echo "$tree" &&
      echo nitfol >file0 &&
      echo yomin >path1/file1 &&
+     after0=$(git hash-object file0) &&
+     after1=$(git hash-object path1/file1) &&
      git update-index file0 path1/file1'
 
 cat >expected <<\EOF
@@ -31,32 +35,32 @@ test_expect_success \
     'git diff-index --cached $tree -- path >current &&
      compare_diff_raw current expected'
 
-cat >expected <<\EOF
-:100644 100644 766498d93a4b06057a8e49d23f4068f1170ff38f 0a41e115ab61be0328a19b29f18cdcb49338d516 M	path1/file1
+cat >expected <<EOF
+:100644 100644 $before1 $after1 M	path1/file1
 EOF
 test_expect_success \
     'limit to path1 should show path1/file1' \
     'git diff-index --cached $tree -- path1 >current &&
      compare_diff_raw current expected'
 
-cat >expected <<\EOF
-:100644 100644 766498d93a4b06057a8e49d23f4068f1170ff38f 0a41e115ab61be0328a19b29f18cdcb49338d516 M	path1/file1
+cat >expected <<EOF
+:100644 100644 $before1 $after1 M	path1/file1
 EOF
 test_expect_success \
     'limit to path1/ should show path1/file1' \
     'git diff-index --cached $tree -- path1/ >current &&
      compare_diff_raw current expected'
 
-cat >expected <<\EOF
-:100644 100644 766498d93a4b06057a8e49d23f4068f1170ff38f 0a41e115ab61be0328a19b29f18cdcb49338d516 M	path1/file1
+cat >expected <<EOF
+:100644 100644 $before1 $after1 M	path1/file1
 EOF
 test_expect_success \
     '"*file1" should show path1/file1' \
     'git diff-index --cached $tree -- "*file1" >current &&
      compare_diff_raw current expected'
 
-cat >expected <<\EOF
-:100644 100644 8e4020bb5a8d8c873b25de15933e75cc0fc275df dca6b92303befc93086aa025d90a5facd7eb2812 M	file0
+cat >expected <<EOF
+:100644 100644 $before0 $after0 M	file0
 EOF
 test_expect_success \
     'limit to file0 should show file0' \
