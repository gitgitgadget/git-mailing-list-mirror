Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8ED6C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 22:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiJLWFL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 18:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiJLWE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 18:04:27 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C88459BF
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 15:01:54 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id d14so85892ilf.2
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 15:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CGw1o+/lUVje47aRWmFO+gWu/rY1GqHjq2CWRyTfyWU=;
        b=DsDInTBpDBmsTPbUo8r4R8QJq9pnv5qiUFOK7fyFZh8c+u5CSnoaVUQf0lOTo7LhZq
         cPnFJ4JbaVQrZYMDVHdG3Nw5vo08QnsCtjzph58zAoUCVCrmc+GcOlZZDKlwvGr9sAFu
         j7/IwfrICzIur/j3reSA5cSqOHTIXBOvw5rFEBnmy2k/wCi4S8DNu2fJ6ponwIDlUIk+
         r36QHYoM2qnoFV7HhWk/oremrllfORfC/gGtlOMAQCC/9pUacbFy8Uyki6sQw773To17
         rsi5ZoUPzZ51GfDlqZXLoI2gcKWSmagBauQ4T3FyfDjsy1zuaxM64ZOGpTXJMbpFl1VU
         WWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGw1o+/lUVje47aRWmFO+gWu/rY1GqHjq2CWRyTfyWU=;
        b=wfN1L0mKua/QGbNCsIcOJz3dRtEW8bV//AGSsD6NNeSWU1nrdapSHtN4if+djQ4xyx
         p0h9ne2QM78WGGQNFMXz2RqzbsnDLs1qoyKZzaF/pAn1izX2feYkDmjD8xnMoNb86Lp5
         2fjFmqQV6p67yT3nDwHcKI6Y6M6xEDewCl21yfTid+6LLYg+1KBJgnfl87xK2HckCnvU
         kEaL83H06I0XctBd7t/Mp9TQuySyQchzpWMOURIkDiBq8mUyy1cFwJbYvSmmeQkX37e6
         u//gCztohFK1cDzagIuN7AQvrcyNQkfK5LCzo5QLau07YxNouKRNGSuQHgmvdgqfXObv
         pg0Q==
X-Gm-Message-State: ACrzQf14lVJzli4+sj+E0FmUtFoElw7BT0tMMX6i828Liwz/MUwMBOAJ
        Y4YQkasAbfvp+Jgda8cov1qVbdJMIKmHwahR
X-Google-Smtp-Source: AMsMyM6AH/5LKO157YELt2wRdo7u07rdR/Dks9WpqyjTUdoQY4tgablHWME5BlELR7oGCybm3zibNg==
X-Received: by 2002:a05:6e02:1563:b0:2fb:6601:80d9 with SMTP id k3-20020a056e02156300b002fb660180d9mr11776974ilu.71.1665612113664;
        Wed, 12 Oct 2022 15:01:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r17-20020a92d991000000b002e8ea827aafsm6213729iln.74.2022.10.12.15.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 15:01:53 -0700 (PDT)
Date:   Wed, 12 Oct 2022 18:01:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, derrickstolee@github.com, vdye@github.com,
        gitster@pobox.com
Subject: [PATCH 2/4] midx.c: consider annotated tags during bitmap selection
Message-ID: <b646c9d841aee066c57562a439ac59da47220a93.1665612094.git.me@ttaylorr.com>
References: <cover.1665612094.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1665612094.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When generating a multi-pack bitmap without a `--refs-snapshot` (e.g.,
by running `git multi-pack-index write --bitmap` directly), we determine
the set of bitmap-able commits by enumerating each reference, and adding
the referrent as the tip of a reachability traversal when it appears
somewhere in the MIDX. (Any commit we encounter during the reachability
traversal then becomes a candidate for bitmap selection).

But we incorrectly avoid peeling the object at the tip of each
reference. So if we see some reference that points at an annotated tag
(which in turn points through zero or more additional annotated tags at
a commit), that we will not add it as a tip for the reachability
traversal. This means that if some commit C is only referenced through
one or more annotated tag(s), then C won't become a bitmap candidate.

Correct this by peeling the reference tips as we enumerate them to
ensure that we consider commits which are the targets of annotated tags,
in addition to commits which are referenced directly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c                        |  4 ++++
 t/t5326-multi-pack-bitmaps.sh | 24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/midx.c b/midx.c
index a9df753220..d41dfd8174 100644
--- a/midx.c
+++ b/midx.c
@@ -980,6 +980,7 @@ static int add_ref_to_pending(const char *refname,
 			      int flag, void *cb_data)
 {
 	struct rev_info *revs = (struct rev_info*)cb_data;
+	struct object_id peeled;
 	struct object *object;
 
 	if ((flag & REF_ISSYMREF) && (flag & REF_ISBROKEN)) {
@@ -987,6 +988,9 @@ static int add_ref_to_pending(const char *refname,
 		return 0;
 	}
 
+	if (!peel_iterated_oid(oid, &peeled))
+		oid = &peeled;
+
 	object = parse_object_or_die(oid, refname);
 	if (object->type != OBJ_COMMIT)
 		return 0;
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index ad6eea5fa0..0882cbb6e4 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -410,4 +410,28 @@ test_expect_success 'preferred pack change with existing MIDX bitmap' '
 	)
 '
 
+test_expect_success 'tagged commits are selected for bitmapping' '
+	rm -fr repo &&
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit --annotate base &&
+		git repack -d &&
+
+		# Remove refs/heads/main which points at the commit directly,
+		# leaving only a reference to the annotated tag.
+		git branch -M main &&
+		git checkout base &&
+		git branch -d main &&
+
+		git multi-pack-index write --bitmap &&
+
+		git rev-parse HEAD >want &&
+		test-tool bitmap list-commits >actual &&
+		grep $(cat want) actual
+	)
+'
+
 test_done
-- 
2.38.0.16.g393fd4c6db

