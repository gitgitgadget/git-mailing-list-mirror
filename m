Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 706DA20988
	for <e@80x24.org>; Wed, 19 Oct 2016 04:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750783AbcJSEYI (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 00:24:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62666 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750977AbcJSEYD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 00:24:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A229A49EB3;
        Wed, 19 Oct 2016 00:24:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=Fqp9
        BdB1aBuk2j1p9CYdx3H6AmE=; b=R5eGrngnxx5aobX92vuBO1iO99qf+7WhsbL1
        Bj+ZR1+h/C6qf8aFeCksN7ZXu4X7gAAVcAz4qtjjtqMzqHPK0q77pQdVRyN9R2vv
        dCxQG2OctSw5MROqOe7L2qhAwe3wnnTpCbascTPp5p0i+Z5r2ualLjX0zRXb4iDF
        OOgHOsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=SxSTD8
        PUGqmX0/7dvpdAmC13AxKkNcRnRLzLosQGG4NkVBq5I0csE/R66QQFH97rxs9gie
        a/b+ZgeIMcDdn7yD7Lb3gVWZGXyZEp1SVe13u274Z/bpXPkVpoR8QIzmMwmM+JoY
        oNZV4HtlW+Sln/jGIbrAkqIQdMuP+ur9oeKPQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9961349EB2;
        Wed, 19 Oct 2016 00:24:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1863049EB1;
        Wed, 19 Oct 2016 00:24:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 6/7] merge-base: limit the output to bases that are on first-parent chain
Date:   Tue, 18 Oct 2016 21:23:44 -0700
Message-Id: <20161019042345.29766-7-gitster@pobox.com>
X-Mailer: git-send-email 2.10.1-631-gb2c64dcf30
In-Reply-To: <20161019042345.29766-1-gitster@pobox.com>
References: <xmqqmvi2sj8f.fsf@gitster.mtv.corp.google.com>
 <20161019042345.29766-1-gitster@pobox.com>
X-Pobox-Relay-ID: DD0525F8-95B3-11E6-AB23-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A new option "--fp-only" limits the output to the merge bases that
are on the first-parent chain from the branches being merged.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-merge-base.txt |  8 +++++++-
 builtin/merge-base.c             | 10 +++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index 808426faac..f99653f138 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -9,7 +9,7 @@ git-merge-base - Find as good common ancestors as possible for a merge
 SYNOPSIS
 --------
 [verse]
-'git merge-base' [-a|--all] <commit> <commit>...
+'git merge-base' [-a|--all] [--fp-only] <commit> <commit>...
 'git merge-base' [-a|--all] --octopus <commit>...
 'git merge-base' --is-ancestor <commit> <commit>
 'git merge-base' --independent <commit>...
@@ -72,6 +72,12 @@ OPTIONS
 --all::
 	Output all merge bases for the commits, instead of just one.
 
+--fp-only::
+	Limit the output to merge bases that are on the first-parent
+	chain from none of the commits given on the command line.
+
+
+
 DISCUSSION
 ----------
 
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index c0d1822eb3..42febb20ff 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -6,11 +6,12 @@
 #include "revision.h"
 #include "parse-options.h"
 
-static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
+static int show_merge_base(struct commit **rev, int rev_nr, int show_all, int fp_only)
 {
 	struct commit_list *result;
+	unsigned flags = fp_only ? MB_FPCHAIN : 0;
 
-	result = get_merge_bases_many_dirty(rev[0], rev_nr - 1, rev + 1);
+	result = get_merge_bases_opt(rev[0], rev_nr - 1, rev + 1, flags);
 
 	if (!result)
 		return 1;
@@ -208,10 +209,13 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 	struct commit **rev;
 	int rev_nr = 0;
 	int show_all = 0;
+	int fp_only = 0;
 	int cmdmode = 0;
 
 	struct option options[] = {
 		OPT_BOOL('a', "all", &show_all, N_("output all common ancestors")),
+		OPT_BOOL(0, "fp-only", &fp_only,
+			 N_("limit to bases that are on first-parent chain")),
 		OPT_CMDMODE(0, "octopus", &cmdmode,
 			    N_("find ancestors for a single n-way merge"), 'o'),
 		OPT_CMDMODE(0, "independent", &cmdmode,
@@ -255,5 +259,5 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 	ALLOC_ARRAY(rev, argc);
 	while (argc-- > 0)
 		rev[rev_nr++] = get_commit_reference(*argv++);
-	return show_merge_base(rev, rev_nr, show_all);
+	return show_merge_base(rev, rev_nr, show_all, fp_only);
 }
-- 
2.10.1-631-gb2c64dcf30

