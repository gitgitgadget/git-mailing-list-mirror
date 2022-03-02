Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54F2C433FE
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 00:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238901AbiCBA7q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 19:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238868AbiCBA7X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 19:59:23 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0AB9D0E2
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 16:58:40 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id r8so136109ioj.9
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 16:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XeJi2emNlfZLogjdPJcWi0pnf3BGqaD8AqKJE3DeuBY=;
        b=gLVy7I+aFZGo8NezLuQy42ENDJpYNAQ7fZtgFnemN/qL4DlbKLLA6HvJ+QMlVH32CQ
         vHpiiktDgJD6fHhoa5Dk1V+HlNiGD3FFkRlzSDWR23IRhhbGzLKzW5DLpEhZa6Wk7VLf
         MgOiT1fStkazVokNlympnMv260Z8nIAIZ8xYSLaba/q2q3DMueO/3d1fT1sf1trAGCZF
         aCbGdibEt/TbuluX0vgAETQ1Wg2b+BSBvPNgspJKrAR9JMkfFx5kET5BQA9iIUA1Vn5O
         ig4WLP4mGGwqcrqxdQS6ekhuCHV150YYBFFflIDsh0XTY7lBu6DJwBUPmUQG4SHMw9aN
         fq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XeJi2emNlfZLogjdPJcWi0pnf3BGqaD8AqKJE3DeuBY=;
        b=141RT9YlZe2fNHZ5WDq3SJlXUCN0w7tClT1xx/M6mJItbZYl/UGQPwie4UOFfCOh2V
         pCUdYQO2uaWBtUBTTIaI1k+6zeux6oq3ABqEclWIcrHusjcODEQuMri/yoIIzA0zfBuE
         sacCvyLC5YUXDJvDA37V4YlAkBcG6pHsxWdnvhlzEULrEsEI6rtncJ74w38zB3eS5g4q
         36G3VLyj/V1+r1VqG27BV4iKoWKnqgwJo1tz8Rb80pGfRvaCNRqvb3/5yYzfZoHIdfcX
         SFgcoJp8q00Wd7/QUSmQsCp6ecdgotOoTuOejAdrWzkKtMYQ3U80aCOmxnQfxBhzFZ5b
         hGmw==
X-Gm-Message-State: AOAM533MIkCVDpcoaChrbDg6wnLXpKMnYY5pdjsVq4b/cRKg98d9D1lK
        jSzOrcafimQPTX5qSib7ith6Zxak3VIDEULe
X-Google-Smtp-Source: ABdhPJzRGEL7ghDUogkcABN2oqK4cfie5cOcf/tn06ezAzSBeWQV3v4PbrBVaLEzEcxDc4aQp5mSVg==
X-Received: by 2002:a5d:8981:0:b0:641:6292:bead with SMTP id m1-20020a5d8981000000b006416292beadmr21572630iol.170.1646182719600;
        Tue, 01 Mar 2022 16:58:39 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m1-20020a056e021c2100b002c2ec1c8012sm4356200ilh.53.2022.03.01.16.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 16:58:39 -0800 (PST)
Date:   Tue, 1 Mar 2022 19:58:38 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     tytso@mit.edu, derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com
Subject: [PATCH v2 17/17] sha1-file.c: don't freshen cruft packs
Message-ID: <b729b8096313e44d988db735218d4bc98ce5b6fb.1646182671.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646182671.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1646182671.git.me@ttaylorr.com>
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
 t/t5328-pack-objects-cruft.sh | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/object-file.c b/object-file.c
index e80da1368d..65b8df7fb6 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1989,6 +1989,8 @@ static int freshen_packed_object(const struct object_id *oid)
 	struct pack_entry e;
 	if (!find_pack_entry(the_repository, oid, &e))
 		return 0;
+	if (e.p->is_cruft)
+		return 0;
 	if (e.p->freshened)
 		return 1;
 	if (!freshen_file(e.p->pack_name))
diff --git a/t/t5328-pack-objects-cruft.sh b/t/t5328-pack-objects-cruft.sh
index 3910e186ef..4681558612 100755
--- a/t/t5328-pack-objects-cruft.sh
+++ b/t/t5328-pack-objects-cruft.sh
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
2.35.1.73.gccc5557600
