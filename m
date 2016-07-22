Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14F2020195
	for <e@80x24.org>; Fri, 22 Jul 2016 12:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754026AbcGVMZb (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 08:25:31 -0400
Received: from mout.gmx.net ([212.227.15.18]:54940 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753981AbcGVMZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 08:25:29 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LiDnn-1avek03qWx-00nTky; Fri, 22 Jul 2016 14:25:20
 +0200
Date:	Fri, 22 Jul 2016 14:25:16 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v4 06/16] merge_recursive: abort properly upon errors
In-Reply-To: <cover.1469187652.git.johannes.schindelin@gmx.de>
Message-ID: <26f12ac5a5b8e722d81c782b32585531521c98d4.1469187653.git.johannes.schindelin@gmx.de>
References: <cover.1467902082.git.johannes.schindelin@gmx.de> <cover.1469187652.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:mpy6mySIqZj8wXrAkpVG+cOPaKfqGZEQU3/A/F11A2FISbH1RZe
 6bHun0XSmnbRngE/ktmCRK09JfTfJMr/9uK0Qrk+pAJ13LFQWm92mMNiOEmHbdWbivq3RCY
 FbDLMEbfz6rxrKxtwrBrsEcfzcMnhilBqP5/5RfA2uxJAPVWfsIL8ybCuOwhz+PkcZPz5Ih
 W2fO8h55c8JhU6h+GdXgw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:gauwNRacNk8=:HPoLX+vA2xf7fbuZxFWrWy
 RpFO0BwI2n46hcee6hW6Vq8Wa7U4T0kZoUYHu2is67Qe7HOhhCQbi35GQY4qgqUTo4/zsKXot
 L6JEmboy6rjGMpWJwGavpQCCUSo6WjzpTWrBjFIeoxiT+us9J2z9RNucRuN+rUOCiarN/f7On
 +Y7/yel1H2FIaslEnqa7tl4tLJbvvWPkyLF/04dNC6KY1MJTb4MmyTOjQ1odN3s64gZO5Hml+
 Wz3PmcaTZJPepKvSdd1lJq6Ze+6YMy9TzDjYSXcLpts5pj+tC0HcnZmD/cNes5DkmpVM/pBU1
 iEero3vcJV09Mzcq/VgJoEzzq6Z/GW39wkBynQy2BIAvMTZKMBxYiPaNcJt/Nqr6q4enACOHf
 f4uQQlIRqmPdaK4ONnwFbo2V58X9Em9hf2LuRNnURuECk9LDZOnulIMKKZDRw1F/j0WbkqgHK
 BOK1pqWICgfjIdv2bzUnA8W6Z8YaAETsIz5Kz/SlHXFGH1bR1ob2q4S9uiAXlJ+F62qE6Z0mW
 spVuLXLvwCXfhBSXWWdlJQAUNzw1K1aNh0vFcdyD54U3MkS7bUJNUkACg8qsRBPWlC1MacgN4
 QHy2E09Aq6z2VOMvcK3H7nX1Bz/bHRvK7dhYv+fbAcRzPWqq6/w9mJRih794+JOOU8sjgVw1s
 4gD/46l4YF6Vu0aAkcE9pN/gCBzU6/ZH5uRU72NLLDLwlUkAqkAYpolbOxG5/wORtZDXzZuMq
 39iom4afa4u79+YO0LGzn/P6KcmD79b0l23XfVLBH7DMn/DbLxA4fpmC6LvrCFpJvbDd28JAG
 MPZM5W+
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

There are a couple of places where return values indicating errors
are ignored. Let's teach them manners.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index dc3182b..2d4cb80 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1949,8 +1949,9 @@ int merge_recursive(struct merge_options *o,
 		saved_b2 = o->branch2;
 		o->branch1 = "Temporary merge branch 1";
 		o->branch2 = "Temporary merge branch 2";
-		merge_recursive(o, merged_common_ancestors, iter->item,
-				NULL, &merged_common_ancestors);
+		if (merge_recursive(o, merged_common_ancestors, iter->item,
+				    NULL, &merged_common_ancestors) < 0)
+			return -1;
 		o->branch1 = saved_b1;
 		o->branch2 = saved_b2;
 		o->call_depth--;
@@ -1966,6 +1967,8 @@ int merge_recursive(struct merge_options *o,
 	o->ancestor = "merged common ancestors";
 	clean = merge_trees(o, h1->tree, h2->tree, merged_common_ancestors->tree,
 			    &mrtree);
+	if (clean < 0)
+		return clean;
 
 	if (o->call_depth) {
 		*result = make_virtual_commit(mrtree, "merged tree");
@@ -2022,6 +2025,9 @@ int merge_recursive_generic(struct merge_options *o,
 	hold_locked_index(lock, 1);
 	clean = merge_recursive(o, head_commit, next_commit, ca,
 			result);
+	if (clean < 0)
+		return clean;
+
 	if (active_cache_changed &&
 	    write_locked_index(&the_index, lock, COMMIT_LOCK))
 		return error(_("Unable to write index."));
-- 
2.9.0.281.g286a8d9


