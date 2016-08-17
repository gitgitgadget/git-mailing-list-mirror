Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E81961FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 12:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168AbcHQMmA (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 08:42:00 -0400
Received: from mout.gmx.net ([212.227.15.18]:57852 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753135AbcHQMl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 08:41:58 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LrvWY-1bBLkq1FmQ-013d2a; Wed, 17 Aug 2016 14:41:14
 +0200
Date:	Wed, 17 Aug 2016 14:40:59 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Ben Wijen <ben@wijen.net>, Junio C Hamano <gitster@pobox.com>,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 1/2] t6026-merge-attr: child processes must not inherit
 index.lock handles
In-Reply-To: <cover.1471437637.git.johannes.schindelin@gmx.de>
Message-ID: <742a0bc524ac20bf10ccdf9ac51bb01a30efee16.1471437637.git.johannes.schindelin@gmx.de>
References: <cover.1471437637.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ol7FDYq0AzvcVuE75stWZCnKyZeOz//4Q4URbQHo2CjRsx4tVnF
 Yt1qZTe6XlO/qLZezNznjm+42Ozv2VEYaYHr838hYb/gb+1cn1VWmxr93tfhbXNyTJoJHSu
 Jtec1xRtepUzDA1ir7lZPu2SQ8vfbzYqWfD+mXilDEVChWuXBB6oEMN5BkWR8u1+MU4wTPT
 0eAnaM7NEe3a7fwIBBbKg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:QmE4YSKYyK0=:S32KTRuyEISdCiXBtD9+3a
 JiJ+Eta+2b3/JnosQxDqsTwmd6KZ0NR02nkG2MpKA40GZeZFP8GahaMHa9Msn1xfp1aKP3hrj
 dgKwdLsgrWz5Kw8IJYY+UFIAYYC8eTo7S6DvnPfpgKj5ONWqDTwrV56Y4pSJZA+RQWX09Kj68
 l2Z1yZn9gA4U9VGYI/Yc45/PxEd3FfKcEuhIl0CKESeAQzcrCTedLk7HE5++/L5RCXX5pWMHW
 Tt19cy1N5OjhlCXYa3RXLCProo2d9EMu8kvKCr6w7+BxRg/3ckO91xYkNgTDhQpIvCmanmQDG
 nAoNfxopHN5Oymjs3BebtdzVCV6MChbNTFlQqMwghs9qX0YPZpwTVe3WW4hQ8JOupHaP4QTwl
 CPFH6+PfvlZosYQbn2tmdkS5gQKoM3v7VTIYmtHL8DDezV8OQvirxxZEXejjzBzkvypZsz7Bo
 Y46zQAw8gpCAXsvqTMNTni3hBC2GO3kUUIYEUMQ8GXl/e9jwlPs91NhHwtRckQn35AgiafOJ0
 1RK5P+lyKYZH1rGGfIN2SbCBgZC0pK+obKyLyj+Gdu5ltjArj/FncRLrLl1wrB31WMe5eABrn
 lceUQ/MTn2zoYLUYix+YPqrKG6uIz7gXaTJM1CdbhLHL7KJ9vAYUz/CoIpXjZg69NyJ9FHHGS
 h5+HgOk+XRiPuGNAA5eg0IRJM0ZMKd7GEX0oF3IIqRlBn1paQVn7Jq7B2mvdwaSctDctVyCfr
 Mmai6mSBBVWLLUT2Zh3jFCCL7W7xQameM2xoWpR/jbpMFqUeOKWYBGvfP10zDUF//Pla3/1Cp
 o4KsLSa
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Ben Wijen <ben@wijen.net>

On Windows, files cannot be removed unless all file handles to it have
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


