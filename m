Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24306C6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 01:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiITBz7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 21:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiITBzw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 21:55:52 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002F649B7D
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 18:55:47 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id mi14so983156qvb.12
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 18:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ZsdT1tZNAc0Jr35FLzyCRkzbD79iVHHjIKPyPxodyN4=;
        b=hvLs9FatoJwGV4m+oAubf8aeg0XrBCwn4trnfVAx3TI58y1t2350YDmMIaB9GR993r
         2h+lnNytX+SmegjZoTXS+dENgvdYUTrN25XRSPQQXuayP9SM1xi8PJABQ/wNOWlo2hJ/
         QFd30X0KwbCNWooyc7oER2Yx08lzG3odHIzPWarf5O0rTaBzQAGOXboAwkl0Xael5bAe
         1ZqtqVYMjm2+IMiImmMM7odIfBvAfJoYhieMqbfXYs9Q1qugGGEvcIqDXlH1zLcr9jDC
         GZeamQUKp71xeC5rLbDXsjrpJdhjAPcq8nNEX6s3aDji6LTnzMdEctJnZKixZJUHx5Q3
         1lfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ZsdT1tZNAc0Jr35FLzyCRkzbD79iVHHjIKPyPxodyN4=;
        b=XnaHqKIqDao5fdOBjrTxXOox4UAXnqvyIl870eMA4AO6Z1rf8nqqvqAbRlmG6RRPRR
         5bkjIEXT+IAnHGOkmE9JAvZOZRE1mY5SN4ZQ6iH5bVJPFY46OBJn6K9USizFt42AkwmI
         2O8XnZ2c/WhS4u9u7RoY4Ni5hREBolytKYv9PRLaHSAL75gJHalPlG7ZG+qYncfVQ5RV
         H01cY/epAQpAxViDiJqKg3lBacpW0HJWlEBGYFDFuLJcL+V+9Iyn5mf081n3K7pzp4h4
         Ss++RsrUBmTh5KzQsGNBroZPlTYQJyPlCwXUAjebQqGzClLYFBZwxuBuQ2kxNwhv8RNa
         nSIA==
X-Gm-Message-State: ACrzQf1ldVF/5+DK43kFV1SMNddOX11J/32kaanvQsVetuF1NFFaHQE3
        OJHPHd/8NrLi9+7EvEZ8PYaEWHBkx6IhxQ==
X-Google-Smtp-Source: AMsMyM44xxtAm6QJ36s39a77OsrLbESp5eMXCsc0mCtafR/zehCgOvLdunKz93/GLm0e4UrfmdqGZA==
X-Received: by 2002:a0c:a950:0:b0:4aa:e2ac:922a with SMTP id z16-20020a0ca950000000b004aae2ac922amr17452624qva.119.1663638946634;
        Mon, 19 Sep 2022 18:55:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s19-20020a05620a29d300b006ce515196a7sm111105qkp.8.2022.09.19.18.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 18:55:46 -0700 (PDT)
Date:   Mon, 19 Sep 2022 21:55:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com,
        gregory.szorc@gmail.com
Subject: [PATCH 3/7] midx.c: prevent `expire` from removing the cruft pack
Message-ID: <3ae9903d2df491e291ab975c56ec78aa13d95655.1663638929.git.me@ttaylorr.com>
References: <cover.1663638929.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1663638929.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `expire` sub-command unlinks any packs that are (a) contained in the
MIDX, but (b) have no objects referenced by the MIDX.

This sub-command ignores `.keep` packs, which remain on-disk even if
they have no objects referenced by the MIDX. Cruft packs, however,
aren't given the same treatment: if none of the objects contained in the
cruft pack are selected from the cruft pack by the MIDX, then the cruft
pack is eligible to be expired.

This is less than desireable, since the cruft pack has important
metadata about the individual object mtimes, which is useful to
determine how quickly an object should age out of the repository when
pruning.

Ordinarily, we wouldn't expect the contents of a cruft pack to
duplicated across non-cruft packs (and we'd expect to see the MIDX
select all cruft objects from other sources even less often). But
nonetheless, it is still possible to trick the `expire` sub-command into
removing the `.mtimes` file in this circumstance.

Teach the `expire` sub-command to ignore cruft packs in the same manner
as it does `.keep` packs, in order to keep their metadata around, even
when they are unreferenced by the MIDX.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.txt |  4 ++--
 midx.c                                 |  2 +-
 t/t5319-multi-pack-index.sh            | 30 ++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index 11e6dc53e3..3696506eb3 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -72,8 +72,8 @@ verify::
 expire::
 	Delete the pack-files that are tracked by the MIDX file, but
 	have no objects referenced by the MIDX (with the exception of
-	`.keep` packs). Rewrite the MIDX file afterward to remove all
-	references to these pack-files.
+	`.keep` packs and cruft packs). Rewrite the MIDX file afterward
+	to remove all references to these pack-files.
 
 repack::
 	Create a new pack-file containing objects in small pack-files
diff --git a/midx.c b/midx.c
index c27d0e5f15..bff5b99933 100644
--- a/midx.c
+++ b/midx.c
@@ -1839,7 +1839,7 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 		if (prepare_midx_pack(r, m, i))
 			continue;
 
-		if (m->packs[i]->pack_keep)
+		if (m->packs[i]->pack_keep || m->packs[i]->is_cruft)
 			continue;
 
 		pack_name = xstrdup(m->packs[i]->pack_name);
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index afbe93f162..2d51b09680 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -847,6 +847,36 @@ test_expect_success 'expire respects .keep files' '
 	)
 '
 
+test_expect_success 'expiring unreferenced cruft pack retains pack' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit base &&
+		test_commit --no-tag unreachable &&
+		unreachable=$(git rev-parse HEAD) &&
+
+		git reset --hard base &&
+		git reflog expire --all --expire=all &&
+		git repack --cruft -d &&
+		mtimes="$(ls $objdir/pack/pack-*.mtimes)" &&
+
+		echo "base..$unreachable" >in &&
+		pack="$(git pack-objects --revs --delta-base-offset \
+			$objdir/pack/pack <in)" &&
+
+		# Preferring the contents of "$pack" will leave the
+		# cruft pack unreferenced (ie., none of the objects
+		# contained in the cruft pack will have their MIDX copy
+		# selected from the cruft pack).
+		git multi-pack-index write --preferred-pack="pack-$pack.pack" &&
+		git multi-pack-index expire &&
+
+		test_path_is_file "$mtimes"
+	)
+'
+
 test_expect_success 'repack --batch-size=0 repacks everything' '
 	cp -r dup dup2 &&
 	(
-- 
2.37.0.1.g1379af2e9d

