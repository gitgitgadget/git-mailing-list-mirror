Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01367C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 23:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347492AbiETXTK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 19:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354104AbiETXSl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 19:18:41 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4FB1A077A
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:18:18 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 190so2337329qkj.8
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TO70jr9rzedrZWeM+KmyeO0J+S6jY0bck1zLwDugc+w=;
        b=umMLOhJzs4SddB4wju7WVe4ORm5e1bkyrAdR6lj3r5QQSUYmqCwl0WKt5jgXm7App2
         /knIbB2FlOnB5a2BNCJJC+NAbIEEiX72s+iSlP0HaY2enVFrMFeZOr4xeNMdEOxi6OrJ
         hQtZPrh5DATRepc3RyylKXEfap5tiums0yJz9waQXela6sCFjDAwzBt7GRwjDWV7+wmd
         8+mdA5xiRhTwNArvVCOnMx/THEOrMNo48LkCsGQ+rYrtrJD9fRzDoT7T9xul0EgrltPL
         kBOzdbwY8livSL9kTzGgvdWlbq+z46tz3pC8AOaudJzbfeNcOOUI3GK2++ejXhPCWNRc
         7dBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TO70jr9rzedrZWeM+KmyeO0J+S6jY0bck1zLwDugc+w=;
        b=y3bL1eYR+jDq7jZkIzcBaUUtTPqhvslJ9si8/0Ppp/jgBDf4hI+15bBISd9GDLh78z
         b5hIQVhC3MPKHsHRiErbYMj/wO/ew+RQK/8wwArcAjnGpu9AMqb0aCTbtBmhOR4WySSB
         EazhwZ70xQwNtme6SxHLfl8FJfS0wqsEd0N16tMSWdnuCqP1C93dRn0RcPnlUjk2Cz3P
         dkncubE1emc//5Pktww+0ZwEgaCVmXcRHgUAjuNjU5WD7aYI+/HFVvwujYFHt07HbQ4S
         jbAg46FceCkdN6MpJF3HUg4Xq6MMxecJY2vTc0FEfPZynoM7Zhm4W/vU1urPEpX6AKsG
         Ebeg==
X-Gm-Message-State: AOAM533MeRKrkmquYg4D+HIyuf1ULJ9bD9dXR/mOFbyzaL5boA/mrrQx
        DdOaMKtzDTMryYQk6v0StRRxO593W9471F/x
X-Google-Smtp-Source: ABdhPJySqOcqIi12B80b4pOckGXigVOgqhRTs/YTCvXxp2cdfY44mCqHtJaaeL+0vHqt1Uff4+Bnog==
X-Received: by 2002:a37:62cd:0:b0:6a3:4cbe:e74e with SMTP id w196-20020a3762cd000000b006a34cbee74emr3150984qkb.550.1653088698307;
        Fri, 20 May 2022 16:18:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cm26-20020a05622a251a00b002f39b99f6a6sm459669qtb.64.2022.05.20.16.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 16:18:17 -0700 (PDT)
Date:   Fri, 20 May 2022 19:18:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: [PATCH v5 17/17] sha1-file.c: don't freshen cruft packs
Message-ID: <1e313b89e85ce0a5cc6fa6cb93127c13ae1e9e19.1653088640.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1653088640.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1653088640.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't bother to freshen objects stored in a cruft pack individually
by updating the `.mtimes` file. This is because we can't portably `mmap`
and write into the middle of a file (i.e., to update the mtime of just
one object). Instead, we would have to rewrite the entire `.mtimes` file
which may incur some wasted effort especially if there a lot of cruft
objects and they are freshened infrequently.

Instead, force the freshening code to avoid an optimizing write by
writing out the object loose and letting it pick up a current mtime.

This works because we prefer the mtime of the loose copy of an object
when both a loose and packed one exist (whether or not the packed copy
comes from a cruft pack or not).

This could certainly do with a test and/or be included earlier in this
series/PR, but I want to wait until after I have a chance to clean up
the overly-repetitive nature of the cruft pack tests in general.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 object-file.c                 |  2 ++
 t/t5329-pack-objects-cruft.sh | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/object-file.c b/object-file.c
index ff0cffe68e..495a359200 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2035,6 +2035,8 @@ static int freshen_packed_object(const struct object_id *oid)
 	struct pack_entry e;
 	if (!find_pack_entry(the_repository, oid, &e))
 		return 0;
+	if (e.p->is_cruft)
+		return 0;
 	if (e.p->freshened)
 		return 1;
 	if (!freshen_file(e.p->pack_name))
diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
index 70a6a9553c..b481224b93 100755
--- a/t/t5329-pack-objects-cruft.sh
+++ b/t/t5329-pack-objects-cruft.sh
@@ -711,4 +711,29 @@ test_expect_success 'MIDX bitmaps tolerate reachable cruft objects' '
 	)
 '
 
+test_expect_success 'cruft objects are freshend via loose' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		echo "cruft" >contents &&
+		blob="$(git hash-object -w -t blob contents)" &&
+		loose="$objdir/$(test_oid_to_path $blob)" &&
+
+		test_commit base &&
+
+		git repack --cruft -d &&
+
+		test_path_is_missing "$loose" &&
+		test-tool pack-mtimes "$(basename "$(ls $packdir/pack-*.mtimes)")" >cruft &&
+		grep "$blob" cruft &&
+
+		# write the same object again
+		git hash-object -w -t blob contents &&
+
+		test_path_is_file "$loose"
+	)
+'
+
 test_done
-- 
2.36.1.94.gb0d54bedca
