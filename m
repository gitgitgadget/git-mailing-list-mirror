Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 719CF207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 14:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966333AbdD1OGa (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 10:06:30 -0400
Received: from mout.gmx.net ([212.227.17.22]:55036 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1165488AbdD1OEj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 10:04:39 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LzoSt-1e7OIU2CeZ-0154uL; Fri, 28
 Apr 2017 16:04:33 +0200
Date:   Fri, 28 Apr 2017 16:04:18 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v2 21/25] add_reflog_for_walk: avoid memory leak
In-Reply-To: <cover.1493387231.git.johannes.schindelin@gmx.de>
Message-ID: <8d0c58714830e7c4566382f94617848b411b5535.1493387231.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <cover.1493387231.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:iZcgzwJXU2WclmrhGfMQYh+kQqN18pdG08JzyJCWrHIiZRmAvHL
 1m8o0u/TZVko2WSOMyMMZO4yEAWpQYPp3VDPA200oO5tXQTLWs5PBtKEwfjolJuSZt8GAN8
 U6xI+NcO1uunKLmDNz6SRK0FV+e5vWxgZo6bDpXHrWkFD3JiC7x7FVuYck8zbhN06O6cxOo
 LUPZo+zZ6K0iHTfD360eQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:csgnVQnYNjQ=:j+SYHXBJf4QIgdUo0Sgll4
 UyVFNIE6uCPMpwPA4Z4GHxsgIuVWp0vAds382UDmTJKVx3M5v4SM8/fTVPRjTBfXJT4LdnAn2
 I4WYIEKLkwz0ttdRjVRVYJNrJ02WB3Q5BoNrfXMjudPV3bEBR9D7aKh64tfSeboAOBby7t8FP
 YUJZ/Mv4q9KndsWo7fqcFvE/KSOJBHuy1uyaPZTL6yhi+Twz47q8uzBNWSmSLSlYaZqpSARYS
 aYTmTQZWdpW5zIIM6JHJFM0s+1l2hbjYiOLlrp4NC6od+PwrXs5xc7ODZ37XeJJhuBuFfNOJY
 mDAtvJ2ZiK4vp3610FOzQ9ncK22FQgo6HhZ1AznULzEu4CCmSYOTHn9HKkYhqatL7uQfbJ4Ca
 rQtfO50wd5BVnZ9fQlFV9BIEwtbyhaXaci97BnwdJ2zle5C//Y688BtLQrzCVFm4PTfL9rxk4
 3eeNGl/ijkaprcfEPTUF2UCCLZVT9qKtZV77eCQhIxKGUT2lRL7YdS6TRb4aB2FNGFNHLmVDq
 pKAKNMtiKQXiLyhC0+N42JcIQBSKbKfcmMmsHjizP9LGyHzriBCzLBrxfEnsEQgyLhQ1sJrmb
 tp1KH27Co6Zn7dlMCtXrxDvaF1oYGGci+dxZvYBFiLMC3D1NT+HnJLr6LyOq6aNqHaDPsFaas
 YF7M4ZEt0rI/byRUGIjqKPhQPsw/zhRnScrVt+LIcELd8XawkbQivBxsx6i4pIJSHno4e+zZJ
 POPcbZy2i1wgAVOjybFeSED86YsI73aLWvtNm9BuYMP0KxFLZ58eFPsLtso9MwN6jZLtwAnhx
 cPCX/bm
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


