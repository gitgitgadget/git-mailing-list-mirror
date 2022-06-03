Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53904C43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 21:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345395AbiFCVzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 17:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348110AbiFCVzl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 17:55:41 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A415A5AA45
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 14:55:39 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id f35so6645068qtb.11
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 14:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=e36bNG+uU3yfnUQvY+SCxW2F+Lw1wJf4PY+061BqMyg=;
        b=AGmQwkN12LmXjdMnXhUkTB388mI9rX/cyv4lysH52KSu8tVxY+4PmuPgAk5z20gGT0
         sFdo1GkkuEISgTRh2r9QF+WFCmIawlDWFihdOqPJZvdt9IjuuGXa16ymYxyOFkaBpJlZ
         hNGrq/K5R5zWeuetvzuJReN3GXwULXWhEfZRar3NpQaAwEtaFPHpzAsavRZGbyCEiX70
         en0E02qWn71lbsDU8phQEeSQbVlL1W5sQGcayS6wfYb6f/YItTdyoG3dTdzpzwiiObfd
         kCUzw3j7KRLyOGjv0FrP2uLQhg3zs1pyBvszJ79h18pKFX8sKxM4W3LfFt5E+HSJj7Q5
         3HqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=e36bNG+uU3yfnUQvY+SCxW2F+Lw1wJf4PY+061BqMyg=;
        b=qzHru8zo8y9Cutq/WcF/OxZEy9hZVjeK5gmecKVfdDHtu7zfFka+1IgY0f/TNxU0L/
         50x3FdHuzNzfp80ATPYaKfE5s3myK1t2pRRwC2RUp7a2C5G2agXDlUezV8ICmeIcC/d7
         aCqDH7RCorMNwcq7EAXh1t+UYVU47S1f91DKp7fkYMwGzIZjlBcng8ou+ci8ibarOpDT
         2jj7a2Phf0mIvievL+8dDFf9XPdbWThLD0lHUd0Eb+rtcUsPj4WwVYlTtMsd2xhdcBQJ
         uSbIkdWW5irDyfiPRRyy8nMpzeJIc4RQzqRv21KAJ2FtzHNK+i5F0VeWBZAzZXMYi3rF
         Ux6Q==
X-Gm-Message-State: AOAM531XiiZeMc5dqaY7M9rQkamTAj7Gdva3FVauyPKDmKwyW72fnOXf
        nP9W2bT8uTqQ2Ugz2dcAp7kebd5NHwM3bgbb
X-Google-Smtp-Source: ABdhPJx/X7APd2hMtk+Xq9JceUI4GDUY/ajKmPjXxrnMk7Ws3+tQbLpLGixP9L4s0OzyqOkqe2dm3A==
X-Received: by 2002:a05:622a:40b:b0:304:e4be:65a with SMTP id n11-20020a05622a040b00b00304e4be065amr475314qtx.309.1654293338546;
        Fri, 03 Jun 2022 14:55:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g22-20020ac870d6000000b00304e0245d88sm1565960qtp.48.2022.06.03.14.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 14:55:38 -0700 (PDT)
Date:   Fri, 3 Jun 2022 17:55:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH] builtin/show-ref.c: avoid over-iterating with --heads, --tags
Message-ID: <3fa6932641f18d78156bbf60b1571383f2cb5046.1654293264.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When `show-ref` is combined with the `--heads` or `--tags` options, it
can avoid iterating parts of a repository's references that it doesn't
care about.

But it doesn't take advantage of this potential optimization. When this
command was introduced back in 358ddb62cf (Add "git show-ref" builtin
command, 2006-09-15), `for_each_ref_in()` did exist. But since most
repositories don't have many (any?) references that aren't branches or
tags already, this makes little difference in practice.

Though for repositories with a large imbalance of branches and tags (or,
more likely in the case of server operators, many hidden references),
this can make quite a difference. Take, for example, a repository with
500,000 "hidden" references (all of the form "refs/__hidden__/N"), and
a single branch:

    git commit --allow-empty -m "base" &&
    seq 1 500000 | sed 's,\(.*\),create refs/__hidden__/\1 HEAD,' |
      git update-ref --stdin &&
    git pack-refs --all

Outputting the existence of that single branch currently takes on the
order of ~50ms on my machine. The vast majority of this time is wasted
iterating through references that we know we're going to discard.

Instead, teach `show-ref` that it can iterate just "refs/heads" and/or
"refs/tags" when given `--heads` and/or `--tags`, respectively. A few
small interesting things to note:

  - When given either option, we can avoid the general-purpose
    for_each_ref() call altogether, since we know that it won't give us
    any references that we wouldn't filter out already.

  - We can make two separate calls to `for_each_fullref_in()` (and
    avoid, say, the more specialized `for_each_fullref_in_prefixes()`,
    since we know that the set of references enumerated by each is
    disjoint, so we'll never see the same reference appear in both
    calls.

  - We have to use the "fullref" variant (instead of just
    `for_each_branch_ref()` and `for_each_tag_ref()`), since we expect
    fully-qualified reference names to appear in `show-ref`'s output.

When either of `heads_only` or `tags_only` is set, we can eliminate the
strcmp() calls in `builtin/show-ref.c::show_ref()` altogether, since we
know that `show_ref()` will never see a non-branch or tag reference.

Unfortunately, we can't use `for_each_fullref_in_prefixes()` to enhance
`show-ref`'s pattern matching, since `show-ref` patterns match on the
_suffix_ (e.g., the pattern "foo" shows "refs/heads/foo",
"refs/tags/foo", and etc, not "foo/*").

Nonetheless, in our synthetic example above, this provides a significant
speed-up ("git" is roughly v2.36, "git.compile" is this patch):

    $ hyperfine -N 'git show-ref --heads' 'git.compile show-ref --heads'
    Benchmark 1: git show-ref --heads
      Time (mean ± σ):      49.9 ms ±   6.2 ms    [User: 45.6 ms, System: 4.1 ms]
      Range (min … max):    46.1 ms …  73.6 ms    43 runs

    Benchmark 2: git.compile show-ref --heads
      Time (mean ± σ):       2.8 ms ±   0.4 ms    [User: 1.4 ms, System: 1.2 ms]
      Range (min … max):     1.3 ms …   5.6 ms    957 runs

    Summary
      'git.compile show-ref --heads' ran
       18.03 ± 3.38 times faster than 'git show-ref --heads'

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
This is obviously a little extreme of an example for most use-cases,
but it does come up more often than not within GitHub, where we have
many repositories with lots of hidden references that we're wasting time
enumerating with `show-ref`.

 builtin/show-ref.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 7f8a5332f8..5fa207a044 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -52,14 +52,6 @@ static int show_ref(const char *refname, const struct object_id *oid,
 	if (show_head && !strcmp(refname, "HEAD"))
 		goto match;

-	if (tags_only || heads_only) {
-		int match;
-
-		match = heads_only && starts_with(refname, "refs/heads/");
-		match |= tags_only && starts_with(refname, "refs/tags/");
-		if (!match)
-			return 0;
-	}
 	if (pattern) {
 		int reflen = strlen(refname);
 		const char **p = pattern, *m;
@@ -216,7 +208,14 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)

 	if (show_head)
 		head_ref(show_ref, NULL);
-	for_each_ref(show_ref, NULL);
+	if (heads_only || tags_only) {
+		if (heads_only)
+			for_each_fullref_in("refs/heads/", show_ref, NULL);
+		if (tags_only)
+			for_each_fullref_in("refs/tags/", show_ref, NULL);
+	} else {
+		for_each_ref(show_ref, NULL);
+	}
 	if (!found_match) {
 		if (verify && !quiet)
 			die("No match");
--
2.36.1.94.gb0d54bedca
