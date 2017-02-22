Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFC9E201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 16:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932685AbdBVQUC (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 11:20:02 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:34789 "EHLO
        hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932334AbdBVQTx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 11:19:53 -0500
Received: from homiemail-a1.g.dreamhost.com (homie.mail.dreamhost.com [208.97.132.208])
        by hapkido.dreamhost.com (Postfix) with ESMTP id 7F224C1D0A
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 08:19:22 -0800 (PST)
Received: from homiemail-a1.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id D077A348077
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 08:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:in-reply-to:references:from:date:subject:to
        :content-transfer-encoding:mime-version; s=mattmccutchen.net;
         bh=SRQ7wS+ZfCmNVxwZtaWYwFb0xcs=; b=P8swQVbo5VpGpHsw1hv2wznxODkY
        43hVgNYH++BFQzdKb6fOo7gvwuUFiYejiqInT9n6EHk8a8r/ojylDu1cxpN/zGWX
        WrUOHGm/N0u+EyuZV+yfDmtxGjLqqzKYhbgamkAUeQuShzE4/5WWFtxJZ34NZbnl
        IRPj+Z6AVC1UrFM=
Received: from main (30-86-202.dynamic.csail.mit.edu [128.30.86.202])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a1.g.dreamhost.com (Postfix) with ESMTPSA id 90B96348076
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 08:18:21 -0800 (PST)
Message-Id: <b9b52233e84a7f5bd0526f9625e4be06cbbd0ace.1487779910.git.matt@mattmccutchen.net>
In-Reply-To: <xmqqvas4gie9.fsf@gitster.mtv.corp.google.com>
References: <xmqqvas4gie9.fsf@gitster.mtv.corp.google.com>
From:   Matt McCutchen <matt@mattmccutchen.net>
Date:   Wed, 22 Feb 2017 11:01:22 -0500
Subject: [PATCH 1/3] fetch-pack: move code to report unmatched refs to a
 function
To:     git@vger.kernel.org
X-Mailer: Evolution 3.22.4 (3.22.4-2.fc25) 
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We're preparing to reuse this code in transport.c for "git fetch".

While I'm here, internationalize the existing error message.
---
 builtin/fetch-pack.c  |  7 +------
 fetch-pack.c          | 13 +++++++++++++
 fetch-pack.h          |  9 +++++++++
 t/t5500-fetch-pack.sh |  6 +++---
 4 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index cfe9e44..2a1c1c2 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -219,12 +219,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	 * remote no-such-ref' would silently succeed without issuing
 	 * an error.
 	 */
-	for (i = 0; i < nr_sought; i++) {
-		if (!sought[i] || sought[i]->matched)
-			continue;
-		error("no such remote ref %s", sought[i]->name);
-		ret = 1;
-	}
+	ret |= report_unmatched_refs(sought, nr_sought);
 
 	while (ref) {
 		printf("%s %s\n",
diff --git a/fetch-pack.c b/fetch-pack.c
index 601f077..7c8d44c 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1094,3 +1094,16 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 	clear_shallow_info(&si);
 	return ref_cpy;
 }
+
+int report_unmatched_refs(struct ref **sought, int nr_sought)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < nr_sought; i++) {
+		if (!sought[i] || sought[i]->matched)
+			continue;
+		error(_("no such remote ref %s"), sought[i]->name);
+		ret = 1;
+	}
+	return ret;
+}
diff --git a/fetch-pack.h b/fetch-pack.h
index c912e3d..fd4d80e 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -45,4 +45,13 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		       struct sha1_array *shallow,
 		       char **pack_lockfile);
 
+/*
+ * Print an appropriate error message for each sought ref that wasn't
+ * matched.  Return 0 if all sought refs were matched, otherwise 1.
+ *
+ * The type of "sought" should be "const struct ref *const *" but for
+ * http://stackoverflow.com/questions/5055655/double-pointer-const-correctness-warnings-in-c .
+ */
+int report_unmatched_refs(struct ref **sought, int nr_sought);
+
 #endif
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 505e1b4..b5865b3 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -484,7 +484,7 @@ test_expect_success 'test lonely missing ref' '
 		cd client &&
 		test_must_fail git fetch-pack --no-progress .. refs/heads/xyzzy
 	) >/dev/null 2>error-m &&
-	test_cmp expect-error error-m
+	test_i18ncmp expect-error error-m
 '
 
 test_expect_success 'test missing ref after existing' '
@@ -492,7 +492,7 @@ test_expect_success 'test missing ref after existing' '
 		cd client &&
 		test_must_fail git fetch-pack --no-progress .. refs/heads/A refs/heads/xyzzy
 	) >/dev/null 2>error-em &&
-	test_cmp expect-error error-em
+	test_i18ncmp expect-error error-em
 '
 
 test_expect_success 'test missing ref before existing' '
@@ -500,7 +500,7 @@ test_expect_success 'test missing ref before existing' '
 		cd client &&
 		test_must_fail git fetch-pack --no-progress .. refs/heads/xyzzy refs/heads/A
 	) >/dev/null 2>error-me &&
-	test_cmp expect-error error-me
+	test_i18ncmp expect-error error-me
 '
 
 test_expect_success 'test --all, --depth, and explicit head' '
-- 
2.9.3


