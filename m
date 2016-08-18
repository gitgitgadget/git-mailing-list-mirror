Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A69CD1FD99
	for <e@80x24.org>; Fri, 19 Aug 2016 06:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754335AbcHSG2y (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 02:28:54 -0400
Received: from mout.gmx.net ([212.227.17.21]:58084 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750806AbcHSG2y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 02:28:54 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lxdfb-1b7uJd23vn-017GP6; Thu, 18 Aug 2016 16:51:14
 +0200
Date:   Thu, 18 Aug 2016 16:51:12 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Ben Wijen <ben@wijen.net>, Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/2] t6026-merge-attr: child processes must not inherit
 index.lock handles
In-Reply-To: <cover.1471531799.git.johannes.schindelin@gmx.de>
Message-ID: <1678936297177e29db6253b09d75ec53ca6ad668.1471531799.git.johannes.schindelin@gmx.de>
References: <cover.1471437637.git.johannes.schindelin@gmx.de> <cover.1471531799.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:g5NE668kI+r8CdzrbBJQoFKo24jwC0T92nBE50bjMKpIaikCuyy
 ntU2AWxAccuuus8ZwV+ji+4ewMy6yLCdxJmd8ktBJK7p9UiMMHO/XiVY2lVr/VZ4PSU3JOQ
 RgkK6ABRj2JgWlUM6QDH3xTGc/JOw96nym2MR9YLpgwvkFxodxiTd5xmPvqu2U63egqH+K9
 6E+ZmIHFGNcVFtRJtKBCQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:At/yJ77TTVE=:qWCIAYfrDq+N88Dj/qc2yn
 j2IYR+/6bjO6vpecjzNxYDHqSpQN+T/Q8hyyvSkNb6y22l6IO/WEr6aYLVR7+w3b0CU7Y/mvl
 uhyFPH9VXYmH6VRPfELbDfDZhHTLbeF38gkzsezwkR47MSoihkRMy9WLS51fTpoaTPQkrwhUC
 CQw++s8FFfZjyskJW0FDTvh5rTx5VGaFBVj5mdmvsCtHt0cGl+VIgIVddmEOQaySwPSqbreI7
 jxeTgNJwbY8suWeyjyfueS7g40IhKmB5SULUxQnOVCr9pAHXttJrFJQ2eQk24MyhUaFy4By/S
 5cefqLzZ8XLtBtUbKVdi3OJEqCaaheAfJkhUTEEdL/FDU7rashbRxy9lzlA8N/vsobeE+fpD0
 k1dqRFFZm+yS6bgplw8gBctQJxd7ji+26lJ+BS+50NQ++LPaFIwr80PzySKBUn+rc78Qf5TVJ
 umTkmnsZHN6NPcgwnXsbVdHTD09MZ7nzElptIZwEMn3sKcccxLJFxYdSPwO4DP27weaxWfV8X
 JUfDYrgcczWfsYEx4W71418jflLNRhAmVkG8NcVZsQnxXKncwj3sr0azTiVBIblUmqTo5JA+3
 j8csXXUIFT7LYb0ZECE3fbd6GU3nd92IuSXAAc5a6CM12a+H1uDe6DbgQTLkvPmovG2qbX4lh
 Mz3MM9/Qr69rslYKG5v5EdhDz5rSlLaSt4zxXELggcHQANa3ADVeyBWdzQzcODloUPfAWIf9d
 E0HFZeacL1lnetqR6ln6yJOpksqr7zHrD0qMnTlb1OElpkG80hFZIP6ZKKm/vLaf75Z1Bn+1F
 0b8WIV0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Wijen <ben@wijen.net>

On Windows, a file cannot be removed unless all file handles to it have
been released. Hence it is particularly important to close handles when
spawning children (which would probably not even know that they hold on
to those handles).

The example chosen for this test is a custom merge driver that indeed
has no idea that it blocks the deletion of index.lock. The full use case
is a daemon that lives on after the merge, with subsequent invocations
handing off to the daemon, thereby avoiding hefty start-up costs. We
simulate this behavior by simply sleeping one second.

Note that the test only fails on Windows, due to the file locking issue.
Since we have no way to say "expect failure with MINGW, success
otherwise", we simply skip this test on Windows for now.

Signed-off-by: Ben Wijen <ben@wijen.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6026-merge-attr.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
index ef0cbce..3d28c78 100755
--- a/t/t6026-merge-attr.sh
+++ b/t/t6026-merge-attr.sh
@@ -181,4 +181,17 @@ test_expect_success 'up-to-date merge without common ancestor' '
 	)
 '
 
+test_expect_success !MINGW 'custom merge does not lock index' '
+	git reset --hard anchor &&
+	write_script sleep-one-second.sh <<-\EOF &&
+		sleep 1 &
+	EOF
+
+	test_write_lines >.gitattributes \
+		"* merge=ours" "text merge=sleep-one-second" &&
+	test_config merge.ours.driver true &&
+	test_config merge.sleep-one-second.driver ./sleep-one-second.sh &&
+	git merge master
+'
+
 test_done
-- 
2.9.2.691.g78954f3


