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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F065C4346E
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 05:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07EBD235FD
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 05:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgIXF0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 01:26:06 -0400
Received: from mail001-2.aei.ca ([206.123.6.133]:55427 "EHLO mail001.aei.ca"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726683AbgIXF0G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 01:26:06 -0400
Received: (qmail 3584 invoked by uid 89); 24 Sep 2020 05:26:05 -0000
Received: by simscan 1.2.0 ppid: 3561, pid: 3571, t: 0.0895s
         scanners: regex: 1.2.0 attach: 1.2.0
Received: from mail002.aei.ca (HELO mta.aei.ca) (206.123.6.132)
  by mail001.aei.ca with (DHE-RSA-AES256-SHA encrypted) SMTP; 24 Sep 2020 05:26:05 -0000
Received: (qmail 21418 invoked by uid 89); 24 Sep 2020 05:26:04 -0000
Received: by simscan 1.2.0 ppid: 21406, pid: 21407, t: 5.1362s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.97.8/m: spam: 3.3.1
Received: from dsl-66-36-136-92.mtl.aei.ca (HELO dermoth.lan) (66.36.136.92)
  by mail.aei.ca with (AES256-SHA encrypted) SMTP; 24 Sep 2020 05:25:59 -0000
Received: from dermoth by dermoth.lan with local (Exim 4.92)
        (envelope-from <tguyot@gmail.com>)
        id 1kLJlX-00033X-JQ; Thu, 24 Sep 2020 01:25:59 -0400
From:   Thomas Guyot-Sionnest <tguyot@gmail.com>
To:     git@vger.kernel.org
Cc:     dermoth@aei.ca, me@ttaylorr.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, peff@peff.net,
        Thomas Guyot-Sionnest <tguyot@gmail.com>
Subject: [PATCH v3] diff: Fix modified lines stats with --stat and --numstat
Date:   Thu, 24 Sep 2020 01:24:07 -0400
Message-Id: <20200924052406.11349-1-tguyot@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1d0a60c3-d15e-bcbb-f042-2f8ae06f0de1@gmail.com>
References: <1d0a60c3-d15e-bcbb-f042-2f8ae06f0de1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Only skip diffstats when both oids are valid and identical. This check
was causing both false-positives (files included in diffstats with no
actual changes (0 lines modified) and false-negatives (showing 0 lines
modified in stats when files had actually changed).

Also renamed same_contents to same_file to avoid confusion.

Signed-off-by: Thomas Guyot-Sionnest <tguyot@gmail.com>
---
Interdiff:
  diff --git a/diff.c b/diff.c
  index 2e47bf824e..77e0bd772e 100644
  --- a/diff.c
  +++ b/diff.c
  @@ -3663,7 +3663,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
   {
   	mmfile_t mf1, mf2;
   	struct diffstat_file *data;
  -	int same_contents;
  +	int same_file;
   	int complete_rewrite = 0;
   
   	if (!DIFF_PAIR_UNMERGED(p)) {
  @@ -3681,19 +3681,14 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
   		return;
   	}
   
  -	/* What is_stdin really means is that the file's content is only
  -	 * in the filespec's buffer and its oid is zero. We can't compare
  -	 * oid's if both are null and we can just diff the buffers */
  -	if (one->is_stdin && two->is_stdin)
  -		same_contents = (one->size == two->size ?
  -			!memcmp(one->data, two->data, one->size) : 0);
  -	else
  -		same_contents = oideq(&one->oid, &two->oid);
  +	/* saves some reads if true, not a guarantee of diff outcome */
  +	same_file = one->oid_valid && two->oid_valid &&
  +		oideq(&one->oid, &two->oid);
   
   	if (diff_filespec_is_binary(o->repo, one) ||
   	    diff_filespec_is_binary(o->repo, two)) {
   		data->is_binary = 1;
  -		if (same_contents) {
  +		if (same_file) {
   			data->added = 0;
   			data->deleted = 0;
   		} else {
  @@ -3709,7 +3704,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
   		data->added = count_lines(two->data, two->size);
   	}
   
  -	else if (!same_contents) {
  +	else if (!same_file) {
   		/* Crazy xdl interfaces.. */
   		xpparam_t xpp;
   		xdemitconf_t xecfg;
  @@ -3734,7 +3729,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
   				diffstat->files[diffstat->nr - 1];
   			/*
   			 * Omit diffstats of modified files where nothing changed.
  -			 * Even if !same_contents, this might be the case due to
  +			 * Even if !same_file, this might be the case due to
   			 * ignoring whitespace changes, etc.
   			 *
   			 * But note that we special-case additions, deletions,
  diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
  index 4715e75b68..6eb344be03 100755
  --- a/t/t3206-range-diff.sh
  +++ b/t/t3206-range-diff.sh
  @@ -252,11 +252,7 @@ test_expect_success 'changed commit with --stat diff option' '
   	git range-diff --no-color --stat topic...changed >actual &&
   	cat >expect <<-EOF &&
   	1:  $(test_oid t1) = 1:  $(test_oid c1) s/5/A/
  -	     a => b | 0
  -	     1 file changed, 0 insertions(+), 0 deletions(-)
   	2:  $(test_oid t2) = 2:  $(test_oid c2) s/4/A/
  -	     a => b | 0
  -	     1 file changed, 0 insertions(+), 0 deletions(-)
   	3:  $(test_oid t3) ! 3:  $(test_oid c3) s/11/B/
   	     a => b | 2 +-
   	     1 file changed, 1 insertion(+), 1 deletion(-)

 diff.c                | 12 +++++++-----
 t/t3206-range-diff.sh | 12 ++++--------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/diff.c b/diff.c
index ee8e8189e9..77e0bd772e 100644
--- a/diff.c
+++ b/diff.c
@@ -3663,7 +3663,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 {
 	mmfile_t mf1, mf2;
 	struct diffstat_file *data;
-	int same_contents;
+	int same_file;
 	int complete_rewrite = 0;
 
 	if (!DIFF_PAIR_UNMERGED(p)) {
@@ -3681,12 +3681,14 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 		return;
 	}
 
-	same_contents = oideq(&one->oid, &two->oid);
+	/* saves some reads if true, not a guarantee of diff outcome */
+	same_file = one->oid_valid && two->oid_valid &&
+		oideq(&one->oid, &two->oid);
 
 	if (diff_filespec_is_binary(o->repo, one) ||
 	    diff_filespec_is_binary(o->repo, two)) {
 		data->is_binary = 1;
-		if (same_contents) {
+		if (same_file) {
 			data->added = 0;
 			data->deleted = 0;
 		} else {
@@ -3702,7 +3704,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 		data->added = count_lines(two->data, two->size);
 	}
 
-	else if (!same_contents) {
+	else if (!same_file) {
 		/* Crazy xdl interfaces.. */
 		xpparam_t xpp;
 		xdemitconf_t xecfg;
@@ -3727,7 +3729,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 				diffstat->files[diffstat->nr - 1];
 			/*
 			 * Omit diffstats of modified files where nothing changed.
-			 * Even if !same_contents, this might be the case due to
+			 * Even if !same_file, this might be the case due to
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

