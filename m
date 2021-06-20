Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C4AC48BDF
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 15:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9650610CD
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 15:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhFTPOZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 11:14:25 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:7234 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229875AbhFTPOY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 11:14:24 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 7AF6FED6
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 17:12:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1624201929; x=1626016330;
         bh=Y+UnCjy/Ao+yHBYhkwGq/aWbwO2UMnj/gzeQRubH48w=; b=Tc1YLASdEFIG
        2DjJpeA/2fE6YsnRpT1zXTbmCBB/1dWyQMmUMV88VnsubaQztyl0TDL5KT0Ov49o
        G4HQI6tiwJqy65jITXVstquWIsFfAcq1scKOdCBPgczq+AK3gyfcNvIWsZMQVtei
        KdWtSBVHDtRGkeRkCD3q0P5T0VAZ1d/1OaRYS/Cw+asXypTFaMUV7oRC/NZb/Vma
        bmq+Cpc81DCuhn49NuivV4SUBn2l4HEA1Bp6RPg5ejVxqfMS+/uDm2ZLbJt/vZy4
        aO0LjOv47YdUs8SqdFn1YleIbCAbLfmDgQ43cLjQcYWpEi5XuFtMcCRbe70M0Gyh
        cUpsdui7T8mrhjVIvVxWo2A+u0KzicWNeLbYNXbpQx9KRu7f0enSDBP5gq4VmoS4
        zO6SSX6p3JXxRJWOC4vz5uGGbROQaTY/MV97Eq4mEPInCMvCrq8u7zF0cQwnUK7C
        RRnGNs65aOfvXT1aDBBD0P5e+LEHqCV+Vbl7ErsUsBQDt6mBjJR7jO6Ur4CwUutJ
        FmEOaP1wEicOdZGW6JbmY83qlw+bO1w9sbgjbXSqBC7ztr/cqmwOQo2oxn6e+5+/
        PkfbhhohK6oSnihkLPyHtNZofB7HuT7/uBs84+hTK+e8/CnCWExOPh8f66jvX2Rf
        Ddxl0/CWtPyIOpRxDNlQfH8LaKvAt64=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ozz3GORrSlMS for <git@vger.kernel.org>;
        Sun, 20 Jun 2021 17:12:09 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 92CD7660
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 17:12:09 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 2FB21A2E;
        Sun, 20 Jun 2021 17:12:08 +0200 (CEST)
From:   andrzej@ahunt.org
To:     git@vger.kernel.org
Cc:     andrzej@ahunt.org
Subject: [PATCH 01/12] fmt-merge-msg: free newly allocated temporary strings when done
Date:   Sun, 20 Jun 2021 17:11:53 +0200
Message-Id: <20210620151204.19260-2-andrzej@ahunt.org>
In-Reply-To: <20210620151204.19260-1-andrzej@ahunt.org>
References: <20210620151204.19260-1-andrzej@ahunt.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

origin starts off pointing to somewhere within line, which is owned by
the caller. Later we might allocate a new string using xmemdupz() or
xstrfmt(). To avoid leaking these new strings, we introduce a to_free
pointer - which allows us to safely free the newly allocated string when
we're done (we cannot just free origin directly as it might still be
pointing to line).

LSAN output from t0090:

Direct leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x49a82d in malloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:145:3
    #1 0xa71f49 in do_xmalloc wrapper.c:41:8
    #2 0xa720b0 in do_xmallocz wrapper.c:75:8
    #3 0xa720b0 in xmallocz wrapper.c:83:9
    #4 0xa720b0 in xmemdupz wrapper.c:99:16
    #5 0x8092ba in handle_line fmt-merge-msg.c:187:23
    #6 0x8092ba in fmt_merge_msg fmt-merge-msg.c:666:7
    #7 0x5ce2e6 in prepare_merge_message builtin/merge.c:1119:2
    #8 0x5ce2e6 in collect_parents builtin/merge.c:1215:3
    #9 0x5c9c1e in cmd_merge builtin/merge.c:1454:16
    #10 0x4ce83e in run_builtin git.c:475:11
    #11 0x4ccafe in handle_builtin git.c:729:3
    #12 0x4cb01c in run_argv git.c:818:4
    #13 0x4cb01c in cmd_main git.c:949:19
    #14 0x6b3fad in main common-main.c:52:11
    #15 0x7fb929620349 in __libc_start_main (/lib64/libc.so.6+0x24349)

SUMMARY: AddressSanitizer: 8 byte(s) leaked in 1 allocation(s).

Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
---
 fmt-merge-msg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 0f66818e0f..b969dc6ebb 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -105,90 +105,92 @@ static void add_merge_parent(struct merge_parents *table,
 static int handle_line(char *line, struct merge_parents *merge_parents)
 {
 	int i, len = strlen(line);
 	struct origin_data *origin_data;
 	char *src;
 	const char *origin, *tag_name;
+	char *to_free = NULL;
 	struct src_data *src_data;
 	struct string_list_item *item;
 	int pulling_head = 0;
 	struct object_id oid;
 	const unsigned hexsz = the_hash_algo->hexsz;
 
 	if (len < hexsz + 3 || line[hexsz] != '\t')
 		return 1;
 
 	if (starts_with(line + hexsz + 1, "not-for-merge"))
 		return 0;
 
 	if (line[hexsz + 1] != '\t')
 		return 2;
 
 	i = get_oid_hex(line, &oid);
 	if (i)
 		return 3;
 
 	if (!find_merge_parent(merge_parents, &oid, NULL))
 		return 0; /* subsumed by other parents */
 
 	CALLOC_ARRAY(origin_data, 1);
 	oidcpy(&origin_data->oid, &oid);
 
 	if (line[len - 1] == '\n')
 		line[len - 1] = 0;
 	line += hexsz + 2;
 
 	/*
 	 * At this point, line points at the beginning of comment e.g.
 	 * "branch 'frotz' of git://that/repository.git".
 	 * Find the repository name and point it with src.
 	 */
 	src = strstr(line, " of ");
 	if (src) {
 		*src = 0;
 		src += 4;
 		pulling_head = 0;
 	} else {
 		src = line;
 		pulling_head = 1;
 	}
 
 	item = unsorted_string_list_lookup(&srcs, src);
 	if (!item) {
 		item = string_list_append(&srcs, src);
 		item->util = xcalloc(1, sizeof(struct src_data));
 		init_src_data(item->util);
 	}
 	src_data = item->util;
 
 	if (pulling_head) {
 		origin = src;
 		src_data->head_status |= 1;
 	} else if (skip_prefix(line, "branch ", &origin)) {
 		origin_data->is_local_branch = 1;
 		string_list_append(&src_data->branch, origin);
 		src_data->head_status |= 2;
 	} else if (skip_prefix(line, "tag ", &tag_name)) {
 		origin = line;
 		string_list_append(&src_data->tag, tag_name);
 		src_data->head_status |= 2;
 	} else if (skip_prefix(line, "remote-tracking branch ", &origin)) {
 		string_list_append(&src_data->r_branch, origin);
 		src_data->head_status |= 2;
 	} else {
 		origin = src;
 		string_list_append(&src_data->generic, line);
 		src_data->head_status |= 2;
 	}
 
 	if (!strcmp(".", src) || !strcmp(src, origin)) {
 		int len = strlen(origin);
 		if (origin[0] == '\'' && origin[len - 1] == '\'')
-			origin = xmemdupz(origin + 1, len - 2);
+			origin = to_free = xmemdupz(origin + 1, len - 2);
 	} else
-		origin = xstrfmt("%s of %s", origin, src);
+		origin = to_free = xstrfmt("%s of %s", origin, src);
 	if (strcmp(".", src))
 		origin_data->is_local_branch = 0;
 	string_list_append(&origins, origin)->util = origin_data;
+	free(to_free);
 	return 0;
 }
 
-- 
2.26.2

