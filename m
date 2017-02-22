Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11245201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 17:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932963AbdBVR3n (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 12:29:43 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:53030 "EHLO
        homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932663AbdBVR3l (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Feb 2017 12:29:41 -0500
Received: from homiemail-a1.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id 2D56C34806F
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 09:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:in-reply-to:references:from:date:subject:to
        :content-transfer-encoding:mime-version; s=mattmccutchen.net;
         bh=5RZK2AQj9Z5XrZFNIUS8sqbmNKk=; b=fKIAKAuNPPmDjQgGIZoLkSi5PGo/
        B1CJvtr8qE3qnNOYbsgU+XKChSz1ymueg6jgIxYBzEpXsLimgshvN3Rxje3tle72
        FmRYr9Qo28M/U55oNwoH+qOUmnaPga7e+jRyySNVf8nJC4uD5bGxU/gjJ7BOlBF8
        FpK/Bg6HmxTlflo=
Received: from main (30-86-202.dynamic.csail.mit.edu [128.30.86.202])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a1.g.dreamhost.com (Postfix) with ESMTPSA id CE079348070
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 09:29:40 -0800 (PST)
Message-Id: <714657fa0c515a174ef63dbdc7a3d37abffdf3e5.1487784184.git.matt@mattmccutchen.net>
In-Reply-To: <xmqqpoiacfqw.fsf@gitster.mtv.corp.google.com>
References: <xmqqpoiacfqw.fsf@gitster.mtv.corp.google.com>
From:   Matt McCutchen <matt@mattmccutchen.net>
Date:   Wed, 22 Feb 2017 11:01:22 -0500
Subject: [PATCH v2 1/3] fetch-pack: move code to report unmatched refs to a
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

Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
---
 builtin/fetch-pack.c  |  7 +------
 fetch-pack.c          | 13 +++++++++++++
 fetch-pack.h          |  6 ++++++
 t/t5500-fetch-pack.sh |  6 +++---
 4 files changed, 23 insertions(+), 9 deletions(-)

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
index c912e3d..a2d46e6 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -45,4 +45,10 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		       struct sha1_array *shallow,
 		       char **pack_lockfile);
 
+/*
+ * Print an appropriate error message for each sought ref that wasn't
+ * matched.  Return 0 if all sought refs were matched, otherwise 1.
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


