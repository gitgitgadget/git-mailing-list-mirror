Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C183CC433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhK2W3t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbhK2W3L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:29:11 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9B6C09677D
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:25:47 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id m9so23675212iop.0
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U+RuYR2Pw0ym0l+fLgahbNraNp48pAA2bkwd1Ujm884=;
        b=5G+nTMk45tkC/m1ysd7jPy5q4wP8jESxmxuAVYWZ9YfCT7rgzFTlKAdd4nELOdBCjH
         VDyVUrQcPivgncrGJZXUVanbvyGTfDz9b1aSPH2807uGz6VBuON86V7EBsuk4/LFvD24
         JJLuegRm24j4SNgN7eU7MRILR7kW3NkyT6XG3OUTknSLB2SLyNvDQqIwIqyX1dOxImJp
         0a5ajJw4xw5dIF6oIq2vFj724iIGXf4TWrovTfwuXZ+nRXL9sLRyBUy2rr4EpV8TdGjT
         ag69xFVJb9YjHNiv+rF0/sD6f0Nc9kXCoCPI6en0OpG8dBU4k7W3HQMXx6DedLR5gWbU
         XC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U+RuYR2Pw0ym0l+fLgahbNraNp48pAA2bkwd1Ujm884=;
        b=CiHubyzFnSJ0vjwb/lLHA3nqpmiz4GNjB31fVZ8da46geX/bAH4W43wOc44sIPdEEv
         w3Ztt9v1CKA6xY1pFt6CQxqDgZVgVvdZeCM4Ykofeu1j+oaCQ6q+inniEiAjxkUz9jXX
         Qvrf7gySx7LMq1eZil1ZPdHozh8E9i5WRKfnnsReF7gSkOLhH0hxBr5CbSolhH3RCXm9
         FjjGAqFDNIuX87t78NySe3G6Lq7SxKKpK7E1e5E3Z3jg4AFoWCnoqHOPqhksHTf3CmX8
         MlUTP5gSJ9/F1ywOneVDtHue7mtIbdyQZf8hzrmrMj5vmJPkmOTkdjJp9DbUF+2z6yU5
         ssUw==
X-Gm-Message-State: AOAM533oBnmFemNw45p8Jq7cqz62y3AERrwHE5YfZKUzo/dnGBrNGCRf
        h+NO3lTnWeI93cOpqApRaumiVSRteKY1qnFG
X-Google-Smtp-Source: ABdhPJwrBhUfgi99i9RXdXtaUMEczck13RkffsUPrtb1cOyB8KbRzVsX19K11+O9RTE50fwEtd3muQ==
X-Received: by 2002:a05:6638:1607:: with SMTP id x7mr71247308jas.27.1638224747059;
        Mon, 29 Nov 2021 14:25:47 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h1sm3301811iow.31.2021.11.29.14.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:25:46 -0800 (PST)
Date:   Mon, 29 Nov 2021 17:25:46 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com, peff@peff.net,
        tytso@mit.edu
Subject: [PATCH 17/17] sha1-file.c: don't freshen cruft packs
Message-ID: <99aace8e16e4a2b36153e8aca7a6ab518065ff54.1638224692.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1638224692.git.me@ttaylorr.com>
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
 t/t5327-pack-objects-cruft.sh | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/object-file.c b/object-file.c
index 7ddb38b64a..dddc1bdd2c 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1946,6 +1946,8 @@ static int freshen_packed_object(const struct object_id *oid)
 	struct pack_entry e;
 	if (!find_pack_entry(the_repository, oid, &e))
 		return 0;
+	if (e.p->is_cruft)
+		return 0;
 	if (e.p->freshened)
 		return 1;
 	if (!freshen_file(e.p->pack_name))
diff --git a/t/t5327-pack-objects-cruft.sh b/t/t5327-pack-objects-cruft.sh
index 4cd0f0cf57..ff87701bbf 100755
--- a/t/t5327-pack-objects-cruft.sh
+++ b/t/t5327-pack-objects-cruft.sh
@@ -657,4 +657,29 @@ test_expect_success 'MIDX bitmaps tolerate reachable cruft objects' '
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
2.34.1.25.gb3157a20e6
