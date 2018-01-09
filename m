Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EB501F404
	for <e@80x24.org>; Tue,  9 Jan 2018 11:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932382AbeAILMR (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 06:12:17 -0500
Received: from sodcd-04p2-40.ppp11.odn.ad.jp ([203.139.65.40]:62516 "EHLO
        sv-prius.atmark-techno.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932327AbeAILMP (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Jan 2018 06:12:15 -0500
X-Greylist: delayed 495 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jan 2018 06:12:15 EST
Received: from leno.local-network (unknown [192.168.10.190])
        by sv-prius.atmark-techno.com (Postfix) with ESMTP id 23D2DBF6C9
        for <git@vger.kernel.org>; Tue,  9 Jan 2018 20:03:56 +0900 (JST)
From:   Yasushi SHOJI <yasushi.shoji@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] bisect: debug: convert struct object to object_id
Date:   Tue,  9 Jan 2018 20:03:56 +0900
Message-Id: <20180109110356.25824-1-yasushi.shoji@gmail.com>
X-Mailer: git-send-email 2.15.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit f2fd0760f62e79609fef7bfd7ecebb002e8e4ced converted struct
object to object_id but a debug function show_list(), which is
ifdef'ed to noop, in bisect.c wasn't.

So fix it.

Signed-off-by: Yasushi SHOJI <Yasushi.SHOJI@gmail.com>
---
 bisect.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bisect.c b/bisect.c
index 3756f127b..0dd0f289a 100644
--- a/bisect.c
+++ b/bisect.c
@@ -132,7 +132,7 @@ static void show_list(const char *debug, int counted, int nr,
 		unsigned flags = commit->object.flags;
 		enum object_type type;
 		unsigned long size;
-		char *buf = read_sha1_file(commit->object.sha1, &type, &size);
+		char *buf = read_sha1_file(commit->object.oid.hash, &type, &size);
 		const char *subject_start;
 		int subject_len;
 
@@ -144,10 +144,10 @@ static void show_list(const char *debug, int counted, int nr,
 			fprintf(stderr, "%3d", weight(p));
 		else
 			fprintf(stderr, "---");
-		fprintf(stderr, " %.*s", 8, sha1_to_hex(commit->object.sha1));
+		fprintf(stderr, " %.*s", 8, sha1_to_hex(commit->object.oid.hash));
 		for (pp = commit->parents; pp; pp = pp->next)
 			fprintf(stderr, " %.*s", 8,
-				sha1_to_hex(pp->item->object.sha1));
+				sha1_to_hex(pp->item->object.oid.hash));
 
 		subject_len = find_commit_subject(buf, &subject_start);
 		if (subject_len)
-- 
2.15.1

