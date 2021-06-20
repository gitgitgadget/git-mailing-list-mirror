Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95DFC49EA2
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 15:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0B4B610CD
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 15:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFTPPI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 11:15:08 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:7266 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230075AbhFTPOo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 11:14:44 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id E1BACED6
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 17:12:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1624201949; x=1626016350;
         bh=UDRNazhZu0xBcWUdwt7tGXsgsS8NzC9xF8uRW9jYJLA=; b=Y++Ke/9wI8sb
        DP3JN4z5FETRt0THhG8P8qZ4AAhY+8PKewhPanxHoIu6D0/kWZd9i3TEOWTVycK7
        4fAcLoaRvqOfcabikht2YjfjbMRkzRcQppSrBysaSVga318r8fwHSfRSarkZLf/F
        f4Txr9bd4sPLWMXXUzCZrF5wH7zL8aqJ2GJ7dzOEUyNGmLbGrDl3WAOmvismnWdw
        pGjp7FQT24sf6UqWLV7i6XdQXQCaiqvHqRASzD5lZe95bjjS4m6Sa9EeHdh3R+PX
        /UlNeG8DFoNQaI024gBV1q4I/g4chDzdUX85Vl0P/GhGmP2qDKgec+rXXaBpZbnp
        HYsXsB4o5TuYoRwLJeRC+yQ6hDSpp2umvW3OGTXJPSWw3GUhf069xG8uzMfyoRid
        BgbZl6+Y6GBEuhP/o55rPME8AIzGFSjBVsZX7iD4OVmuyz/LnzSURAhUWEvBMXRC
        9ahGr7eU9JiSWcK3OVogmYfoGojhM2aQ6qIkjHXA7Xlr7PPl1kz7fg/0SmxsNWum
        5ekgw6jl4XVjvXJbGeej15TL48hxNPkETZSCNHxnlWom/2ca5+4mzTSG0CYx+mgq
        V+4+/hm+JnqnoiIz2pLaCq1VEwW6yNhKVKMTPthQD719usGytbM63gcms2WnWdgo
        w48bsEBxfJNUNeVWhljG/B8ZFYFzIDg=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aCdfr1DsBoEN for <git@vger.kernel.org>;
        Sun, 20 Jun 2021 17:12:29 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 6746A660
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 17:12:29 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 20BD534B;
        Sun, 20 Jun 2021 17:12:28 +0200 (CEST)
From:   andrzej@ahunt.org
To:     git@vger.kernel.org
Cc:     andrzej@ahunt.org
Subject: [PATCH 10/12] builtin/merge: free found_ref when done
Date:   Sun, 20 Jun 2021 17:12:02 +0200
Message-Id: <20210620151204.19260-11-andrzej@ahunt.org>
In-Reply-To: <20210620151204.19260-1-andrzej@ahunt.org>
References: <20210620151204.19260-1-andrzej@ahunt.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

merge_name() calls dwim_ref(), which allocates a new string into
found_ref. Therefore add a free() to avoid leaking found_ref.

LSAN output from t0021:

Direct leak of 16 byte(s) in 1 object(s) allocated from:
    #0 0x486804 in strdup ../projects/compiler-rt/lib/asan/asan_interceptors.cpp:452:3
    #1 0xa8beb8 in xstrdup wrapper.c:29:14
    #2 0x954054 in expand_ref refs.c:671:12
    #3 0x953cb6 in repo_dwim_ref refs.c:644:22
    #4 0x5d3759 in dwim_ref refs.h:162:9
    #5 0x5d3759 in merge_name builtin/merge.c:517:6
    #6 0x5d3759 in collect_parents builtin/merge.c:1214:5
    #7 0x5cf60d in cmd_merge builtin/merge.c:1458:16
    #8 0x4ce83e in run_builtin git.c:475:11
    #9 0x4ccafe in handle_builtin git.c:729:3
    #10 0x4cb01c in run_argv git.c:818:4
    #11 0x4cb01c in cmd_main git.c:949:19
    #12 0x6bdbfd in main common-main.c:52:11
    #13 0x7f0430502349 in __libc_start_main (/lib64/libc.so.6+0x24349)

SUMMARY: AddressSanitizer: 16 byte(s) leaked in 1 allocation(s).

Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
---
 builtin/merge.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index a8a843b1f5..7ad85c044a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -503,7 +503,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 	struct strbuf bname = STRBUF_INIT;
 	struct merge_remote_desc *desc;
 	const char *ptr;
-	char *found_ref;
+	char *found_ref = NULL;
 	int len, early;
 
 	strbuf_branchname(&bname, remote, 0);
@@ -586,6 +586,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 	strbuf_addf(msg, "%s\t\tcommit '%s'\n",
 		oid_to_hex(&remote_head->object.oid), remote);
 cleanup:
+	free(found_ref);
 	strbuf_release(&buf);
 	strbuf_release(&bname);
 }
-- 
2.26.2

