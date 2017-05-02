Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2839D1F790
	for <e@80x24.org>; Tue,  2 May 2017 16:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbdEBQDA (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 12:03:00 -0400
Received: from mout.gmx.net ([212.227.15.15]:54861 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750929AbdEBQC5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 12:02:57 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MLfLH-1d6PTU3X2R-000t5v; Tue, 02
 May 2017 18:02:51 +0200
Date:   Tue, 2 May 2017 18:02:51 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 21/25] add_reflog_for_walk: avoid memory leak
In-Reply-To: <cover.1493740497.git.johannes.schindelin@gmx.de>
Message-ID: <ba954872659d96aec305836b32a3adbb2c1c2a07.1493740497.git.johannes.schindelin@gmx.de>
References: <cover.1493387231.git.johannes.schindelin@gmx.de> <cover.1493740497.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:kSuHaRxcS89yaOmqm8u+PGu7kc//izQkTyjcRfK/y4/m0qFs3aa
 aRLpE97RBE8JVa2PCO5jc1ABhFR9njZL72lj1arrLMuw7HI9Zy1awhyNrWxZMb2qMs73ZAY
 KQtrE37TDPtJc45o4x+nYXxIN6tXObzXqrVQcIICmW1B6165wLLngQdzPcw5HlsSICKy95a
 ycc1xBi6WyIgoRM6ZTUew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aqchCl8X3dA=:oGYBedw1Ob3BukjVW1wsZP
 kExuXlLTcvXOkWMnmdlBSF1idTt9cszg1FVLFuFc/jEbJXuMctoduM+7rpDb6bTklQRuAz4HY
 ZCpFSAqQDinSTrJ1dVTbSruwhTpwOyOBMuFBs56GmqJXaDDoZ0s5dF/AXoWz82exRWXxP8dJ5
 zZogz+21mEehcMNr7xB0fKn1OApE6WpB8ii/BQE1fKNXfsmA8NN8qI+6y8Laj7wNmnzkipiCc
 c+jYd6WFSHQmp1nIrT7NCJvqo3jM1YkxKrJu5axJEj7KorKTtwxtJxkQC+4d+hE8w0ihcF4Wo
 d/aXKI+9oH/YAcXJ0Rnm+TcehA5SluF6Jy4BoC/u+EWfwkD9YElnb/YHuH7hFmkG+3s+idDsl
 +zfyb3Ci78NaMEGW3RechSM0PGwYGbTNKXX3SXGFJfkruVm+xLuyLqjGyDZsTsCtdPk23h8VN
 y8WdPJ/Exqq1UffVHRvR+pjZKynClMbCelJZhdjp1PPUGYb+dFUV6jVWLxzg2VBpU3BaxfRUK
 IVp5jhDd1rf7rc+dz9mScCgIsfl4oAAfvGs/hbagEnIDDTxsd7qv6Vb7akPVnl9WIJlNyh6SC
 gT+ZyHdAxRb51afH+OoWu5NDxzC8YENPkL6LdnKz6Yquw+u9gxY5+oWtBsoGlIBnTwfQmXOIn
 0AopSK8z04Iht0D40G7djGguFaSNJ8wz54F2EZRQK9fI/fYiwErnDnboMoKfzkRJE0ZMT6zEa
 WV+cxTCFauOH0ImFpuGB4TZDm8gi8F0s6VtoJ9GmAk6Kw1HJafuTmutaLZJFTB/+aCS6jNfol
 SnyJiol
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


