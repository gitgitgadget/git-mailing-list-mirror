Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F71C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 00:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiCCAWi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiCCAWO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 19:22:14 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F361910874F
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 16:21:26 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id q8so3985626iod.2
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 16:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BTYa17rZzgf9C/0npq6pFSWMvMS9WYKnXyY21gTMAdQ=;
        b=O4QEd8ZSflgs8i2Cme6LEcU0tKVpc3doHZt2nAnITcOeuEW4PLOzTegyPRWVv2FXtm
         n97TFxtw7A+s74qATDawZu3SXGxWzOWA+aVzNRKvbUdHWLLZleGWfO7lqQxxVtDqxWZO
         IfiS1F35JgrESgG0VS/l4j4h57DISglk86qIPYQ1laZTUc16jFR0ixDOLzlD2daxaz7v
         PMcEcIE/vyaWKcJUOaHnoGYaDC4zl+WbxtgKktGVW/xxS3Hm7Xq2TL5yJdY76K20DD4v
         rln6dHU3nHb3wG3KCu3DxiyvkIjhqFXr1DOGzPKWqHTYdT4FIS32FLT+6bh1/uUmGn3v
         4Vzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BTYa17rZzgf9C/0npq6pFSWMvMS9WYKnXyY21gTMAdQ=;
        b=EkW5mxBXGaj3A4iH4tEVTPdHWtr9JSi3GNkZTd7EWrwgOEctTSSKnDdV3zxgLiPKUD
         U3b/9UZaIjoQwdQ5oACvffHeKTJFP77qML9IFcJuY81+OnsCcmeegYr8CGK12mzfoGre
         dgL3e5few9jYQggsFToDA6zUsZQQSDxphEwC4lqV2tVU1D/w5xM0ACDwJX68zpd4RgvG
         uhLc1sdV8hojcDTcM7xFZ7lv946I6tTlZKTDlfKnJ2+jyg5BmZsAY9FkHmFGiNBnltYn
         G0bI5k4zf2VuxyhYcF0ELN2NXaeEJOQ76rLz1G/DwpOBK4uX/TlWYzw4BoEk+focKWlj
         Fh7A==
X-Gm-Message-State: AOAM533eB9J9Rqz5VBs+bbas32/eyfxSmCBt5W3Nx7vBOWZ0E6UcFBsc
        KF0qBoiRYfcdf3IXxWPDK9wPIGwOlubbxoRa
X-Google-Smtp-Source: ABdhPJzaQX2PwbfDuuj/A3ZjHg3ML/DI4BdVIvZ7NCujS8eLrboD85oN9GqOXuKkAVsNoOQPDQqlJQ==
X-Received: by 2002:a5d:9da2:0:b0:645:6c2f:bebf with SMTP id ay34-20020a5d9da2000000b006456c2fbebfmr41163iob.91.1646266886266;
        Wed, 02 Mar 2022 16:21:26 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o7-20020a056e02092700b002bdf00b573esm336009ilt.6.2022.03.02.16.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 16:21:26 -0800 (PST)
Date:   Wed, 2 Mar 2022 19:21:25 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     tytso@mit.edu, derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com
Subject: [PATCH v3 17/17] sha1-file.c: don't freshen cruft packs
Message-ID: <f74b42587208da364e647cc4847541cacc842753.1646266835.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646266835.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1646266835.git.me@ttaylorr.com>
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
diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
index 3910e186ef..4681558612 100755
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
2.35.1.73.gccc5557600
