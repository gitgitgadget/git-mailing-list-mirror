Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9214C4346E
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 07:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C80D2376F
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 07:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgIXHmC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 03:42:02 -0400
Received: from mail001-2.aei.ca ([206.123.6.133]:55969 "EHLO mail001.aei.ca"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726896AbgIXHmC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 03:42:02 -0400
Received: (qmail 5239 invoked by uid 89); 24 Sep 2020 07:42:01 -0000
Received: by simscan 1.2.0 ppid: 5229, pid: 5235, t: 0.0707s
         scanners: regex: 1.2.0 attach: 1.2.0
Received: from mail002.aei.ca (HELO mta.aei.ca) (206.123.6.132)
  by mail001.aei.ca with (DHE-RSA-AES256-SHA encrypted) SMTP; 24 Sep 2020 07:42:01 -0000
Received: (qmail 9368 invoked by uid 89); 24 Sep 2020 07:42:01 -0000
Received: by simscan 1.2.0 ppid: 9360, pid: 9362, t: 5.1105s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.97.8/m: spam: 3.3.1
Received: from dsl-66-36-136-92.mtl.aei.ca (HELO dermoth.lan) (66.36.136.92)
  by mail.aei.ca with (AES256-SHA encrypted) SMTP; 24 Sep 2020 07:41:56 -0000
Received: from dermoth by dermoth.lan with local (Exim 4.92)
        (envelope-from <tguyot@gmail.com>)
        id 1kLLt5-000882-N5; Thu, 24 Sep 2020 03:41:55 -0400
From:   Thomas Guyot-Sionnest <tguyot@gmail.com>
To:     git@vger.kernel.org
Cc:     dermoth@aei.ca, me@ttaylorr.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, peff@peff.net,
        Thomas Guyot-Sionnest <tguyot@gmail.com>
Subject: [PATCH v4] diff: Fix modified lines stats with --stat and --numstat
Date:   Thu, 24 Sep 2020 03:41:41 -0400
Message-Id: <20200924074140.31153-1-tguyot@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200924052406.11349-1-tguyot@gmail.com>
References: <20200924052406.11349-1-tguyot@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Only skip diffstats when both oids are valid and identical. This check
was causing both false-positives (files included in diffstats with no
actual changes (0 lines modified) and false-negatives (showing 0 lines
modified in stats when files had actually changed).

Also replaced same_contents with may_differ to avoid confusion.

Signed-off-by: Thomas Guyot-Sionnest <tguyot@gmail.com>
---
Interdiff:
  diff --git a/diff.c b/diff.c
  index 77e0bd772e..2bb2f8f57e 100644
  --- a/diff.c
  +++ b/diff.c
  @@ -3663,7 +3663,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
   {
   	mmfile_t mf1, mf2;
   	struct diffstat_file *data;
  -	int same_file;
  +	int may_differ;
   	int complete_rewrite = 0;
   
   	if (!DIFF_PAIR_UNMERGED(p)) {
  @@ -3682,13 +3682,13 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
   	}
   
   	/* saves some reads if true, not a guarantee of diff outcome */
  -	same_file = one->oid_valid && two->oid_valid &&
  -		oideq(&one->oid, &two->oid);
  +	may_differ = !(one->oid_valid && two->oid_valid &&
  +			oideq(&one->oid, &two->oid));
   
   	if (diff_filespec_is_binary(o->repo, one) ||
   	    diff_filespec_is_binary(o->repo, two)) {
   		data->is_binary = 1;
  -		if (same_file) {
  +		if (!may_differ) {
   			data->added = 0;
   			data->deleted = 0;
   		} else {
  @@ -3704,7 +3704,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
   		data->added = count_lines(two->data, two->size);
   	}
   
  -	else if (!same_file) {
  +	else if (may_differ) {
   		/* Crazy xdl interfaces.. */
   		xpparam_t xpp;
   		xdemitconf_t xecfg;
  @@ -3729,7 +3729,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
   				diffstat->files[diffstat->nr - 1];
   			/*
   			 * Omit diffstats of modified files where nothing changed.
  -			 * Even if !same_file, this might be the case due to
  +			 * Even if may_differ, this might be the case due to
   			 * ignoring whitespace changes, etc.
   			 *
   			 * But note that we special-case additions, deletions,

 diff.c                | 12 +++++++-----
 t/t3206-range-diff.sh | 12 ++++--------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/diff.c b/diff.c
index ee8e8189e9..2bb2f8f57e 100644
--- a/diff.c
+++ b/diff.c
@@ -3663,7 +3663,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 {
 	mmfile_t mf1, mf2;
 	struct diffstat_file *data;
-	int same_contents;
+	int may_differ;
 	int complete_rewrite = 0;
 
 	if (!DIFF_PAIR_UNMERGED(p)) {
@@ -3681,12 +3681,14 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 		return;
 	}
 
-	same_contents = oideq(&one->oid, &two->oid);
+	/* saves some reads if true, not a guarantee of diff outcome */
+	may_differ = !(one->oid_valid && two->oid_valid &&
+			oideq(&one->oid, &two->oid));
 
 	if (diff_filespec_is_binary(o->repo, one) ||
 	    diff_filespec_is_binary(o->repo, two)) {
 		data->is_binary = 1;
-		if (same_contents) {
+		if (!may_differ) {
 			data->added = 0;
 			data->deleted = 0;
 		} else {
@@ -3702,7 +3704,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 		data->added = count_lines(two->data, two->size);
 	}
 
-	else if (!same_contents) {
+	else if (may_differ) {
 		/* Crazy xdl interfaces.. */
 		xpparam_t xpp;
 		xdemitconf_t xecfg;
@@ -3727,7 +3729,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 				diffstat->files[diffstat->nr - 1];
 			/*
 			 * Omit diffstats of modified files where nothing changed.
-			 * Even if !same_contents, this might be the case due to
+			 * Even if may_differ, this might be the case due to
 			 * ignoring whitespace changes, etc.
 			 *
 			 * But note that we special-case additions, deletions,
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index e024cff65c..6eb344be03 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -252,17 +252,13 @@ test_expect_success 'changed commit with --stat diff option' '
 	git range-diff --no-color --stat topic...changed >actual &&
 	cat >expect <<-EOF &&
 	1:  $(test_oid t1) = 1:  $(test_oid c1) s/5/A/
-	     a => b | 0
-	     1 file changed, 0 insertions(+), 0 deletions(-)
 	2:  $(test_oid t2) = 2:  $(test_oid c2) s/4/A/
-	     a => b | 0
-	     1 file changed, 0 insertions(+), 0 deletions(-)
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

