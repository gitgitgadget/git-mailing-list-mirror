Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EC7B207D6
	for <e@80x24.org>; Thu,  4 May 2017 13:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755517AbdEDN71 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 09:59:27 -0400
Received: from mout.gmx.net ([212.227.17.22]:55950 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755182AbdEDN7M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 09:59:12 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LiWzQ-1deWdh21Iy-00cfRz; Thu, 04
 May 2017 15:58:57 +0200
Date:   Thu, 4 May 2017 15:58:42 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 21/25] add_reflog_for_walk: avoid memory leak
In-Reply-To: <cover.1493906084.git.johannes.schindelin@gmx.de>
Message-ID: <6b8ebc4c43b4912fac7dc52c1a62727b2e8f57b3.1493906085.git.johannes.schindelin@gmx.de>
References: <cover.1493740497.git.johannes.schindelin@gmx.de> <cover.1493906084.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:AGFQoP5GUJgEeg+IYW1frAjm6CnPk3/pCduLDMnYSDeok41VT1i
 77iV4x2TrtxHZYZ/5va+s794Y8wO5MY2YOCOg43uYrfmfyNZIV3mnQp5We97qbnpIrUlYmV
 zyaD/lSCgq6yaR/Wb3t/O42kWv8sz8Sq9JsjbVoxr01+nU9eZVGr5NpkjRqZf7wyUChSoUa
 zlaVyLX6GGCUbm6044vmw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:m1Xofm1qL74=:pFayF6fCGrO1EJXS9ObNze
 o7gfaQ1k2PBAGrvjVdrIcP/p0PWcILnwpO2jM+FqrYVF7EkBD9VfLlKPkqHtY/in7+SYFdrfv
 k95ToxUgxk5sz2Do+2sarpYTNXxkCkSInkgveDaGyMk6aOZ8Dk7ybuJ/2iTC6FSVwMQzecn3b
 Tqdm0KLmUkHQItJACR5IB9DF1tiCTZxqhRbL3Xt1ccGYtrSDknAFtwZwB0I5KEVLa66W8elbN
 uuNFwgSzBJ+lpch71cjWDt59mS85PsDw8Vl0TXryzKCXa15S6HmmRUAWGTJxjtl89tfLTy7eF
 RteHiOFKq9sU7nCGSKRWHZwfU2fkJjQmlTIPBZYuZTjBOLozXK9w/Y7vU46PgXy073k6alpVe
 4ay1CqxytQfjZ3u7Wzwfh2DuDgqTNX0qkLRJHpEnyfaQbBcVNGAHTKOgBsslkrvsvEVIhffYr
 eSoBRCbIsjy99GcOUflslRfuHolIRm/K3l64iISNtTnoxguAf9sKabQ0XIyV29KPYhWR5N05+
 lCFSEn3jFsWfrc8oXsDpwZeNnVS1V1eapFVLQjDQubsDeXvpGajh0uD8gXizKvsJ/5RnJMRV7
 jBY0+p+TTy3OafUab4lII7s4I6aIk3AaBtw8+3rq+TtGs4j7YHPSy3J0nl+0j64JjrwO4ZOGD
 UCvpWoVFqEw6x6GSKQsxxzIJQhMZiUxCGo831Q1bfq7LRTg2vm4MkdNo/bov51e22lSDgAOf6
 sLfCmv1GpfaRuObi2wmhLlZNbZsqRtzZtVe4XKW8E3x5D7QwMLHUuamO5hE1rPGmu8QFZnseC
 EFTtWYx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We free()d the `log` buffer when dwim_log() returned 1, but not when it
returned a larger value (which meant that it still allocated the buffer
but we simply ignored it).

While in the vicinity, make sure that the `reflogs` structure as well as
the `branch` variable are released properly, too.

Identified by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 reflog-walk.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index 99679f58255..c63eb1a3fd7 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -183,7 +183,11 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 		if (!reflogs || reflogs->nr == 0) {
 			struct object_id oid;
 			char *b;
-			if (dwim_log(branch, strlen(branch), oid.hash, &b) == 1) {
+			int ret = dwim_log(branch, strlen(branch),
+					   oid.hash, &b);
+			if (ret > 1)
+				free(b);
+			else if (ret == 1) {
 				if (reflogs) {
 					free(reflogs->ref);
 					free(reflogs);
@@ -193,17 +197,27 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 				reflogs = read_complete_reflog(branch);
 			}
 		}
-		if (!reflogs || reflogs->nr == 0)
+		if (!reflogs || reflogs->nr == 0) {
+			if (reflogs) {
+				free(reflogs->ref);
+				free(reflogs);
+			}
+			free(branch);
 			return -1;
+		}
 		string_list_insert(&info->complete_reflogs, branch)->util
 			= reflogs;
 	}
+	free(branch);
 
 	commit_reflog = xcalloc(1, sizeof(struct commit_reflog));
 	if (recno < 0) {
 		commit_reflog->recno = get_reflog_recno_by_time(reflogs, timestamp);
 		if (commit_reflog->recno < 0) {
-			free(branch);
+			if (reflogs) {
+				free(reflogs->ref);
+				free(reflogs);
+			}
 			free(commit_reflog);
 			return -1;
 		}
-- 
2.12.2.windows.2.800.gede8f145e06


