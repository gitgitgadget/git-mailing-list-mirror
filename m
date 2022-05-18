Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B651C433EF
	for <git@archiver.kernel.org>; Wed, 18 May 2022 23:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiERXMo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 19:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiERXL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 19:11:58 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4835FF06
        for <git@vger.kernel.org>; Wed, 18 May 2022 16:11:37 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id 135so793891qkm.4
        for <git@vger.kernel.org>; Wed, 18 May 2022 16:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=beYgpiUSMYByF238APD21gzP2aiQvmYtnPxY8mzwXC4=;
        b=F7OK4aYE79k03+JUrpK6xa9uJWQV1ZAgaJ4EHVRgIcaRvIS1xsbBtkk04nD/N/clzE
         FTOCvtoacWrf3rDNVQ0LZg1Ttsxmxd1XVcgHqaNcKdgCl3QFZ5dHAc7uZYkqOUBM8e9H
         fMsrExyayYaJmKANy4/Tcmnhb3q9nXvXkmTkusolLud0uVlNsdPjFBtYjUcJUvOzW0NU
         ElxUGyY3kyq4qWhGFiXIzj/yzUjiWtAzoIZQKN8DcZyHgr3LHtKIAMnLjdzVLyM931FQ
         fkTO2iFH9EH3jFRK6rZi4D1a+erwnUz/WR4kxTDpztyCbYaQyqF8U7F62C+GPfQiqm2f
         nHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=beYgpiUSMYByF238APD21gzP2aiQvmYtnPxY8mzwXC4=;
        b=mRj/eS1OXrNcwSvBQbfPtKcR7OCtgI1vOx9p89iLEfHN+Lnqjf1MIrVRT5nOp6yvWs
         0NlJVyhdmsjUvUznPmjFoESganPWfhRCSBE0SrTAHmFoH6F4dlXyPKgKaW9OyyMhMqR0
         rczuLnflHiKoVXKxEo//wlgpHoXz+Wjst3cqGZ2Nl+RqxF29b6jKcKO2JiOu4i4+2hyP
         biJ7+Zvaanm5Ct78B3ilH6zPB7f4wDmKd69sRDnYbajBswrJ5qORVORoY5a0+PKHgYQH
         opsKzk4xJCs8qFvd7FkiLdCoUNsn6e+3LbcJvwsJTXZrAmgeGvB7/YN9INHdrwXGJxTk
         giaw==
X-Gm-Message-State: AOAM5304hu2TQ63+U9g4BWE/24uFQYjrwxd39JcwiNlkW5fkrT0cY5CL
        UA2AlWcX3CzARMCVj1c5koNjGzNpSCY0Oh7k
X-Google-Smtp-Source: ABdhPJzDP4Y/mJc20R5+zhcWYwgvXw0aNaaFRPUnzy1zbGUjYwdg8Xdk2mfArnrqy9G1jS/BCOBy9g==
X-Received: by 2002:a37:5347:0:b0:69f:842f:bfed with SMTP id h68-20020a375347000000b0069f842fbfedmr1337590qkb.303.1652915496218;
        Wed, 18 May 2022 16:11:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o67-20020a375a46000000b0069fc7108dcesm339430qkb.61.2022.05.18.16.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 16:11:35 -0700 (PDT)
Date:   Wed, 18 May 2022 19:11:35 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: [PATCH v4 17/17] sha1-file.c: don't freshen cruft packs
Message-ID: <07fa9d4b475d37189e978a42a3939b0a20834af3.1652915424.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1652915424.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1652915424.git.me@ttaylorr.com>
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
2.36.1.94.gb0d54bedca
