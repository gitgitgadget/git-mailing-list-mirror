Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549FDC43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 11:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EF932311C
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 11:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgIRLjq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 07:39:46 -0400
Received: from mail001-2.aei.ca ([206.123.6.133]:36793 "EHLO mail001.aei.ca"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726533AbgIRLjq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 07:39:46 -0400
Received: (qmail 32117 invoked by uid 89); 18 Sep 2020 11:33:04 -0000
Received: by simscan 1.2.0 ppid: 32103, pid: 32115, t: 0.0181s
         scanners: regex: 1.2.0 attach: 1.2.0
Received: from mail002.aei.ca (HELO mta.aei.ca) (206.123.6.132)
  by mail001.aei.ca with (DHE-RSA-AES256-SHA encrypted) SMTP; 18 Sep 2020 11:33:04 -0000
Received: (qmail 1901 invoked by uid 89); 18 Sep 2020 11:33:04 -0000
Received: by simscan 1.2.0 ppid: 1889, pid: 1893, t: 0.5454s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.97.8/m: spam: 3.3.1
Received: from dsl-216-221-52-235.mtl.contact.net (HELO dermoth.lan) (216.221.52.235)
  by mail.aei.ca with (AES256-SHA encrypted) SMTP; 18 Sep 2020 11:33:04 -0000
Received: from dermoth by dermoth.lan with local (Exim 4.92)
        (envelope-from <tguyot@gmail.com>)
        id 1kJEdS-0004YC-TW; Fri, 18 Sep 2020 07:33:02 -0400
From:   Thomas Guyot-Sionnest <tguyot@gmail.com>
To:     git@vger.kernel.org
Cc:     dermoth@aei.ca, Thomas Guyot-Sionnest <tguyot@gmail.com>
Subject: [PATCH 1/2] diff: Fix modified lines stats with --stat and --numstat
Date:   Fri, 18 Sep 2020 07:32:55 -0400
Message-Id: <20200918113256.8699-2-tguyot@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200918113256.8699-1-tguyot@gmail.com>
References: <20200918113256.8699-1-tguyot@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In builtin_diffstat(), when both files are coming from "stdin" (which
could be better described as the file's content being written directly
into the file object), oideq() compares two null hashes and ignores the
actual differences for the statistics.

This patch checks if is_stdin flag is set on both sides and compare
contents directly.

Signed-off-by: Thomas Guyot-Sionnest <tguyot@gmail.com>
---
 diff.c                | 5 ++++-
 t/t3206-range-diff.sh | 8 ++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index a5114fa864..2995527896 100644
--- a/diff.c
+++ b/diff.c
@@ -3681,7 +3681,10 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 		return;
 	}
 
-	same_contents = oideq(&one->oid, &two->oid);
+	if (one->is_stdin && two->is_stdin)
+		same_contents = !strcmp(one->data, two->data);
+	else
+		same_contents = oideq(&one->oid, &two->oid);
 
 	if (diff_filespec_is_binary(o->repo, one) ||
 	    diff_filespec_is_binary(o->repo, two)) {
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index e024cff65c..4715e75b68 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -258,11 +258,11 @@ test_expect_success 'changed commit with --stat diff option' '
 	     a => b | 0
 	     1 file changed, 0 insertions(+), 0 deletions(-)
 	3:  $(test_oid t3) ! 3:  $(test_oid c3) s/11/B/
-	     a => b | 0
-	     1 file changed, 0 insertions(+), 0 deletions(-)
+	     a => b | 2 +-
+	     1 file changed, 1 insertion(+), 1 deletion(-)
 	4:  $(test_oid t4) ! 4:  $(test_oid c4) s/12/B/
-	     a => b | 0
-	     1 file changed, 0 insertions(+), 0 deletions(-)
+	     a => b | 2 +-
+	     1 file changed, 1 insertion(+), 1 deletion(-)
 	EOF
 	test_cmp expect actual
 '
-- 
2.20.1

