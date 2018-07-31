Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F7CB1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 16:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbeGaSPA (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 14:15:00 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:29161 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbeGaSPA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 14:15:00 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 41g27g5MhJz5tlQ;
        Tue, 31 Jul 2018 18:33:51 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 0A83CF9D;
        Tue, 31 Jul 2018 18:33:50 +0200 (CEST)
From:   Johannes Sixt <j6t@kdbg.org>
Subject: First test of t5552 fails on Windows
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Message-ID: <a91ec8ac-a9f3-ba87-f675-5196f859c2dc@kdbg.org>
Date:   Tue, 31 Jul 2018 18:33:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm testing origin/next on Windows with a few other topics on top.

The first test fails like this. Do you see what is wrong?
Where should I start looking? Is it perhaps that upload-pack
is responding too soon so that fetch does not send 'have c1'?

---- this is the console output
...(truncated)...
++ git -C client config fetch.negotiationalgorithm skipping
+++ pwd
+++ builtin pwd -W
+++ pwd
+++ builtin pwd -W
++ GIT_TRACE_PACKET='D:/Src/mingw-git/t/trash directory.t5552-skipping-fetch-negotiator/trace'
++ git -C client fetch 'D:/Src/mingw-git/t/trash directory.t5552-skipping-fetch-negotiator/server'
warning: no common commits
remote: Enumerating objects: 3, done.
remote: Counting objects: 100% (3/3), done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
From D:/Src/mingw-git/t/trash directory.t5552-skipping-fetch-negotiator/server
 * branch            HEAD       -> FETCH_HEAD
++ have_sent c7 c5 c2 c1
++ test 4 -ne 0
+++ git -C client rev-parse c7
++ grep 'fetch> have 9b13844ba1d52a28bb9487107b41cce9916b74c9' trace
packet:        fetch> have 9b13844ba1d52a28bb9487107b41cce9916b74c9
++ test 0 -ne 0
++ shift
++ test 3 -ne 0
+++ git -C client rev-parse c5
++ grep 'fetch> have 0abab022ac7e07f16265106cf36faf7cb5d87ab3' trace
packet:        fetch> have 0abab022ac7e07f16265106cf36faf7cb5d87ab3
++ test 0 -ne 0
++ shift
++ test 2 -ne 0
+++ git -C client rev-parse c2
++ grep 'fetch> have 0d7e994c092abbb0a21e7d243114efa5ba452b8c' trace
packet:        fetch> have 0d7e994c092abbb0a21e7d243114efa5ba452b8c
++ test 0 -ne 0
++ shift
++ test 1 -ne 0
+++ git -C client rev-parse c1
++ grep 'fetch> have 9e22a6c1b441ee1bcd54b8da801261ba8b15eac9' trace
++ test 1 -ne 0
+++ git -C client rev-parse c1
++ echo 'No have 9e22a6c1b441ee1bcd54b8da801261ba8b15eac9 (c1)'
No have 9e22a6c1b441ee1bcd54b8da801261ba8b15eac9 (c1)
++ return 1
error: last command exited with $?=1
not ok 1 - commits with no parents are sent regardless of skip distance
#
#               git init server &&
#               test_commit -C server to_fetch &&
#
#               git init client &&
#               for i in $(seq 7)
#               do
#                       test_commit -C client c$i
#               done &&
#
#               # We send: "c7" (skip 1) "c5" (skip 2) "c2" (skip 4). After that, since
#               # "c1" has no parent, it is still sent as "have" even though it would
#               # normally be skipped.
#               test_config -C client fetch.negotiationalgorithm skipping &&
#               GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "$(pwd)/server" &&
#               have_sent c7 c5 c2 c1 &&
#               have_not_sent c6 c4 c3
#

---- trace file

packet:  upload-pack> 92dc17da106e837e66a07e4815c474bf4fe99dce HEAD\0multi_ack thin-pack side-band side-band-64k ofs-delta shallow deepen-since deepen-not deepen-relative no-progress include-tag multi_ack_detailed symref=HEAD:refs/heads/master agent=git/2.18.0.721.g75e0872d82
packet:        fetch< 92dc17da106e837e66a07e4815c474bf4fe99dce HEAD\0multi_ack thin-pack side-band side-band-64k ofs-delta shallow deepen-since deepen-not deepen-relative no-progress include-tag multi_ack_detailed symref=HEAD:refs/heads/master agent=git/2.18.0.721.g75e0872d82
packet:  upload-pack> 92dc17da106e837e66a07e4815c474bf4fe99dce refs/heads/master
packet:  upload-pack> 92dc17da106e837e66a07e4815c474bf4fe99dce refs/tags/to_fetch
packet:        fetch< 92dc17da106e837e66a07e4815c474bf4fe99dce refs/heads/master
packet:  upload-pack> 0000
7da106e837e66a07e4815c474bf4fe99dce refs/tags/to_fetch
packet:        fetch< 0000
packet:        fetch> want 92dc17da106e837e66a07e4815c474bf4fe99dce multi_ack_detailed side-band-64k thin-pack ofs-delta deepen-since deepen-not agent=git/2.18.0.721.g75e0872d82
packet:        fetch> 0000
packet:        fetch> have 9b13844ba1d52a28bb9487107b41cce9916b74c9
packet:        fetch> have 0abab022ac7e07f16265106cf36faf7cb5d87ab3
packet:        fetch> have 0d7e994c092abbb0a21e7d243114efa5ba452b8c
packet:  upload-pack< want 92dc17da106e837e66a07e4815c474bf4fe99dce multi_ack_detailed side-band-64k thin-pack ofs-delta deepen-since deepen-not agent=git/2.18.0.721.g75e0872d82
packet:        fetch> done
packet:  upload-pack< 0000
packet:  upload-pack< have 9b13844ba1d52a28bb9487107b41cce9916b74c9
packet:  upload-pack< have 0abab022ac7e07f16265106cf36faf7cb5d87ab3
packet:  upload-pack< have 0d7e994c092abbb0a21e7d243114efa5ba452b8c
packet:  upload-pack< have 9e22a6c1b441ee1bcd54b8da801261ba8b15eac9
packet:  upload-pack< done
packet:  upload-pack> NAK
packet:        fetch< NAK
packet:     sideband< \2Enumerating objects: 3, done.Counting objects:  33% (1/3)   \15Counting objects:  66% (2/3)   \15Counting objects: 100% (3/3)   \15Co
packet:     sideband< \2unting objects: 100% (3/3), done.Total 3 (delta 0), reused 0 (delta 0)
packet:     sideband< PACK ...
packet:  upload-pack> 0000
packet:     sideband< 0000

