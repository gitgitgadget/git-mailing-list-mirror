Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D59C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 16:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351251AbiCUQcP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 12:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351240AbiCUQbx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 12:31:53 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1151550E23
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 09:30:20 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id r2so17311608iod.9
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 09:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=PF2KGpSmvGdom8PTfBMo4BuokOtsKqa7LU2soIu5aHM=;
        b=mSzRNiSZJLCnPD/aLJfmD2kqhf/DW8ZzfckCweS76MHsqJ1PqE1P3BgJ53bwcxZw7Y
         sGgTv8RctYzSKyNjUbTrN8T1ANtQJT9IpMrKOmvo9NV8HqQ1GyqELzjUdF7edDYsXq96
         MIUDRwiH4Nb3goC+2LHnqpMjn/BGYyS8UQD8OALSdJPR8lgYFgLVQ07SwaTEK7cGjuD0
         JPO7I2qTgwKDF4pa/J3y8XQ0EGkszte7GzkSNtp271Mzakibflfz8gOXAIMGy3EBxmqN
         iVXYuKN5i+VWUCVXQDlZDpU0q7w+1vwQyUyd+Ce+CMahaVFPOXHrki5JlZK/dp24tOF+
         q7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=PF2KGpSmvGdom8PTfBMo4BuokOtsKqa7LU2soIu5aHM=;
        b=odPyTdrNOggVCOr/yLfw9MkLRiIJzfnVY+lA4P36mzNdTS/wG2MyzUCtnp78y9RYZ2
         S4HQLPMga13+E8qKPODNJ671MRJapAY/e0v/V+LAzfSdNGZDJgxbgRS/xJm8xgcnEmil
         Mb84Q5Yr1pH4ZZnidZWJgryYpkysh9iFiWzeis/4Sc0DZ0YqKVg/VLIc+wlz5fa3qZ/Q
         wPLQ0Flk99QCUtJt4nUbMGfD7ehMac5mre8ye5o/jGD+ABMyKQ+3hzfuCQk19kwq0B87
         Bekl1LTLIJN6iYVbg6fMHPbcAXe3UJMuHeseb9CUZaz9y7qhwNKWbw4dXI7JYa8qefvi
         3h6Q==
X-Gm-Message-State: AOAM530op9+j14BE2qLTidf6EtRU4OPyFMzp/jc5uVk2XQs3ssSwzk2h
        9A8/p6lsMALOr7uGyA9J+9gcLSi5bJQ/+qtM
X-Google-Smtp-Source: ABdhPJzq2RjfLdku/U1MkjQs3hXCxnyHTG4LNuri15Md3MpNAigDgtbU0epmuO59InbuEkb6DdFN3g==
X-Received: by 2002:a05:6638:1511:b0:319:fde7:501c with SMTP id b17-20020a056638151100b00319fde7501cmr11034248jat.13.1647880219074;
        Mon, 21 Mar 2022 09:30:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d14-20020a056602328e00b006494aa126c2sm7262717ioz.11.2022.03.21.09.30.18
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 09:30:18 -0700 (PDT)
Date:   Mon, 21 Mar 2022 12:30:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: [RFC PATCH] for-each-ref: respect GIT_REF_PARANOIA setting
Message-ID: <7283f826198aaec94c847f0b26e228ace9a38433.1647880211.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When setting GIT_REF_PARANOIA=1 (which became the default in 968f12fdac
(refs: turn on GIT_REF_PARANOIA by default, 2021-09-24)), `git
for-each-ref` will display a warning when it encounters a broken ref,
but does not terminate the program.

This can result in somewhat surprising behavior like:

    $ echo bogus >.git/refs/heads/bogus
    $ GIT_REF_PARANOIA=1 git for-each-ref; echo "==> $?"
    warning: ignoring broken ref refs/heads/bogus
    ==> 0

This seems to be the case even before the introduction of the ref-filter
code via 7ebc8cbedd (Merge branch 'kn/for-each-ref', 2015-08-03).
Looking at 8afc493d11 (for-each-ref: report broken references correctly,
2015-06-02) when this was last addressed, the fix at the time was to
report any broken references, but this warning did not affect the
command's success.

It seems that `git for-each-ref` should exit non-zero in the case of a
broken reference when GIT_REF_PARANOIA is set to 1. This patch does
that, but there are a couple of open questions (hence its status as an
RFC):

  - First, there are a handful of other `filter_refs()` calls throughout
    the builtin tree that lack similar error handling. I suspect that
    these will need similar treatment, but I haven't looked at them
    deeply yet.

  - More pressing, though, is that there is some test fallout as a
    result of this change. Namely, t6301 expects that `git for-each-ref`
    should list out all of the non-broken references to stdout _even
    when broken references exist_.

    This patch changes that behavior and causes us to exit immediately,
    without printing out any of the non-broken references (since we are
    still building up the list of references to sort, and thus haven't
    printed anything out by the time we're in the ref_filter_handler
    callback).

    The test fallout can be seen in the changes to t6301, namely that we
    expect `for-each-ref` to fail in certain cases where it didn't
    before, and that in those cases we no longer guarantee the contents
    of stdout.

The second point gives me serious pause about whether or not this change
is the right one. So I'm curious if or how we should handle this case.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/for-each-ref.c         |  9 ++++++---
 ref-filter.c                   |  2 +-
 t/t6301-for-each-ref-errors.sh | 10 ++++------
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 6f62f40d12..e1937b7e53 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -19,7 +19,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	int i;
 	struct ref_sorting *sorting;
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
-	int maxcount = 0, icase = 0;
+	int maxcount = 0, icase = 0, ret = 0;
 	struct ref_array array;
 	struct ref_filter filter;
 	struct ref_format format = REF_FORMAT_INIT;
@@ -77,7 +77,9 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 
 	filter.name_patterns = argv;
 	filter.match_as_path = 1;
-	filter_refs(&array, &filter, FILTER_REFS_ALL);
+	ret = filter_refs(&array, &filter, FILTER_REFS_ALL);
+	if (ret)
+		goto cleanup;
 	ref_array_sort(sorting, &array);
 
 	if (!maxcount || array.nr < maxcount)
@@ -91,11 +93,12 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		putchar('\n');
 	}
 
+cleanup:
 	strbuf_release(&err);
 	strbuf_release(&output);
 	ref_array_clear(&array);
 	free_commit_list(filter.with_commit);
 	free_commit_list(filter.no_commit);
 	ref_sorting_release(sorting);
-	return 0;
+	return ret;
 }
diff --git a/ref-filter.c b/ref-filter.c
index 7838bd22b8..f9667f6ca4 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2249,7 +2249,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 
 	if (flag & REF_ISBROKEN) {
 		warning(_("ignoring broken ref %s"), refname);
-		return 0;
+		return 1;
 	}
 
 	/* Obtain the current ref kind from filter_ref_kind() and ignore unwanted refs. */
diff --git a/t/t6301-for-each-ref-errors.sh b/t/t6301-for-each-ref-errors.sh
index 40edf9dab5..2a5895c124 100755
--- a/t/t6301-for-each-ref-errors.sh
+++ b/t/t6301-for-each-ref-errors.sh
@@ -19,8 +19,7 @@ test_expect_success 'Broken refs are reported correctly' '
 	: >.git/$r &&
 	test_when_finished "rm -f .git/$r" &&
 	echo "warning: ignoring broken ref $r" >broken-err &&
-	git for-each-ref >out 2>err &&
-	test_cmp full-list out &&
+	test_must_fail git for-each-ref 2>err &&
 	test_cmp broken-err err
 '
 
@@ -29,11 +28,10 @@ test_expect_success 'NULL_SHA1 refs are reported correctly' '
 	echo $ZEROS >.git/$r &&
 	test_when_finished "rm -f .git/$r" &&
 	echo "warning: ignoring broken ref $r" >zeros-err &&
-	git for-each-ref >out 2>err &&
-	test_cmp full-list out &&
+	test_must_fail git for-each-ref 2>err &&
 	test_cmp zeros-err err &&
-	git for-each-ref --format="%(objectname) %(refname)" >brief-out 2>brief-err &&
-	test_cmp brief-list brief-out &&
+	test_must_fail git for-each-ref --format="%(objectname) %(refname)" \
+		2>brief-err &&
 	test_cmp zeros-err brief-err
 '
 
-- 
2.35.1.73.gccc5557600
