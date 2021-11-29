Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9827C433FE
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhK2W33 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbhK2W24 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:28:56 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4287FC096777
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:25:37 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id v23so23545395iom.12
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QKsFqhn8hhdZST/q8eEopVp/HYQ9qjCDFXZLhJp0nz4=;
        b=DIw89fjrATLx4Vpr52n8yGbpmFV68cG5R7k08jfEpRPKC5Y5S6g/tlKFxtRNR9EXIw
         CRHtIkuay8GKJkSWC2ILS4VqpoHfusR2Px+LjJJlCnYlRbwe8Pk9/mSsw6R7YB/p2cF/
         /OhGKkC09P7LsiD0Vb050nlY0wI3g9VSz5OFIBRkvjg9WYwZuGbmOEHKXv91NP2zZJyM
         2PSMQM5AVlAi0Opx/fLSf4yeeEuTsgKe3mhgWjJdH5aredKzUIB0PymPYHXif96sYkGJ
         bkR9WoXJ05WTfsvUlQgY1CLbhIy6S2JvexltELLkc+Pt7zFCTCVeAm+GYAdqMTmo1XdA
         rPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QKsFqhn8hhdZST/q8eEopVp/HYQ9qjCDFXZLhJp0nz4=;
        b=h1Qee+z1YG0xVZdIkcF+b+XGT6sx8sLr78W18AdSdesGt/klyWCSp+HY/UcfalnvF9
         OrW48c5Hmb1PFzyjADq6md1wWG2Gm2+t9cIWaB97tfe6fUde+u3oDUb/ciW3V2n2szIC
         5nw1uu7vRjcmxt/7QAR6SblPndmgoIeasCi1Fsf+7rmI/kEe1VxxXua8dFsdLhteEzcq
         Mi1GgQtcOTuc/d/YwsRp92X2z9hKAq8fUTQHeL3ki07x01q4BDL0xNX1jfZuWFgWVyZG
         VDp7M87SS8LPc1/uKecdIqcgpPF/Wv7mMzNGxp8CCaKow9q8QKujf/Mp7gV4fLx9fhZ3
         M6lQ==
X-Gm-Message-State: AOAM5301PUByFgWPHK/8Oqc3W5lXol7wDeOr4lXCcw8Oa7g5k6KdE/bt
        E2ecX/2CEomaH26xKYEZTMFzLBvakECu0kCt
X-Google-Smtp-Source: ABdhPJxZ85xAnlVqFX0xbk9pw3LDS9MCma0qyjWUPu1ZHpwS6UmgRjmmEUX3YamD4qvJT4DsrYR5YA==
X-Received: by 2002:a05:6638:16c5:: with SMTP id g5mr73857836jat.11.1638224736539;
        Mon, 29 Nov 2021 14:25:36 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i2sm10317524ilv.54.2021.11.29.14.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:25:36 -0800 (PST)
Date:   Mon, 29 Nov 2021 17:25:35 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com, peff@peff.net,
        tytso@mit.edu
Subject: [PATCH 13/17] builtin/repack.c: allow configuring cruft pack
 generation
Message-ID: <0d2dfaa0620f6e29133aec6e3b87176fb2336ab2.1638224692.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1638224692.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In servers which set the pack.window configuration to a large value, we
can wind up spending quite a lot of time finding new bases when breaking
delta chains between reachable and unreachable objects while generating
a cruft pack.

Introduce a handful of `repack.cruft*` configuration variables to
control the parameters used by pack-objects when generating a cruft
pack.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/repack.txt |  9 ++++
 builtin/repack.c                | 50 ++++++++++++++------
 t/t5327-pack-objects-cruft.sh   | 83 +++++++++++++++++++++++++++++++++
 3 files changed, 128 insertions(+), 14 deletions(-)

diff --git a/Documentation/config/repack.txt b/Documentation/config/repack.txt
index 9c413e177e..fd18d1fb89 100644
--- a/Documentation/config/repack.txt
+++ b/Documentation/config/repack.txt
@@ -25,3 +25,12 @@ repack.writeBitmaps::
 	space and extra time spent on the initial repack.  This has
 	no effect if multiple packfiles are created.
 	Defaults to true on bare repos, false otherwise.
+
+repack.cruftWindow::
+repack.cruftWindowMemory::
+repack.cruftDepth::
+repack.cruftThreads::
+	Parameters used by linkgit:git-pack-objects[1] when generating
+	a cruft pack and the respective parameters are not given over
+	the command line. See similarly named `pack.*` configuration
+	variables for defaults and meaning.
diff --git a/builtin/repack.c b/builtin/repack.c
index 68b4bdf06f..cefa906344 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -40,9 +40,21 @@ static const char incremental_bitmap_conflict_error[] = N_(
 "--no-write-bitmap-index or disable the pack.writebitmaps configuration."
 );
 
+struct pack_objects_args {
+	const char *window;
+	const char *window_memory;
+	const char *depth;
+	const char *threads;
+	const char *max_pack_size;
+	int no_reuse_delta;
+	int no_reuse_object;
+	int quiet;
+	int local;
+};
 
 static int repack_config(const char *var, const char *value, void *cb)
 {
+	struct pack_objects_args *cruft_po_args = cb;
 	if (!strcmp(var, "repack.usedeltabaseoffset")) {
 		delta_base_offset = git_config_bool(var, value);
 		return 0;
@@ -61,6 +73,15 @@ static int repack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "repack.cruftwindow"))
+		return git_config_string(&cruft_po_args->window, var, value);
+	if (!strcmp(var, "repack.cruftwindowmemory"))
+		return git_config_string(&cruft_po_args->window_memory, var, value);
+	if (!strcmp(var, "repack.cruftdepth"))
+		return git_config_string(&cruft_po_args->depth, var, value);
+	if (!strcmp(var, "repack.cruftthreads"))
+		return git_config_string(&cruft_po_args->threads, var, value);
+
 	return git_default_config(var, value, cb);
 }
 
@@ -153,18 +174,6 @@ static void remove_redundant_pack(const char *dir_name, const char *base_name)
 	strbuf_release(&buf);
 }
 
-struct pack_objects_args {
-	const char *window;
-	const char *window_memory;
-	const char *depth;
-	const char *threads;
-	const char *max_pack_size;
-	int no_reuse_delta;
-	int no_reuse_object;
-	int quiet;
-	int local;
-};
-
 static void prepare_pack_objects(struct child_process *cmd,
 				 const struct pack_objects_args *args)
 {
@@ -687,6 +696,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
 	int no_update_server_info = 0;
 	struct pack_objects_args po_args = {NULL};
+	struct pack_objects_args cruft_po_args = {NULL};
 	int geometric_factor = 0;
 	int write_midx = 0;
 
@@ -741,7 +751,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(repack_config, NULL);
+	git_config(repack_config, &cruft_po_args);
 
 	argc = parse_options(argc, argv, prefix, builtin_repack_options,
 				git_repack_usage, 0);
@@ -920,7 +930,19 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		if (*pack_prefix == '/')
 			pack_prefix++;
 
-		ret = write_cruft_pack(&po_args, pack_prefix, &names,
+		if (!cruft_po_args.window)
+			cruft_po_args.window = po_args.window;
+		if (!cruft_po_args.window_memory)
+			cruft_po_args.window_memory = po_args.window_memory;
+		if (!cruft_po_args.depth)
+			cruft_po_args.depth = po_args.depth;
+		if (!cruft_po_args.threads)
+			cruft_po_args.threads = po_args.threads;
+
+		cruft_po_args.local = po_args.local;
+		cruft_po_args.quiet = po_args.quiet;
+
+		ret = write_cruft_pack(&cruft_po_args, pack_prefix, &names,
 				       &existing_nonkept_packs,
 				       &existing_kept_packs);
 		if (ret)
diff --git a/t/t5327-pack-objects-cruft.sh b/t/t5327-pack-objects-cruft.sh
index ed1a113ab6..750e9d6d6f 100755
--- a/t/t5327-pack-objects-cruft.sh
+++ b/t/t5327-pack-objects-cruft.sh
@@ -511,4 +511,87 @@ test_expect_success 'cruft repack ignores pack.packSizeLimit' '
 	)
 '
 
+test_expect_success 'cruft repack respects repack.cruftWindow' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit base &&
+
+		GIT_TRACE2_EVENT=$(pwd)/event.trace \
+		git -c pack.window=1 -c repack.cruftWindow=2 repack \
+		       --cruft --window=3 &&
+
+		grep "pack-objects.*--window=2.*--cruft" event.trace
+	)
+'
+
+test_expect_success 'cruft repack respects --window by default' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit base &&
+
+		GIT_TRACE2_EVENT=$(pwd)/event.trace \
+		git -c pack.window=2 repack --cruft --window=3 &&
+
+		grep "pack-objects.*--window=3.*--cruft" event.trace
+	)
+'
+
+test_expect_success 'cruft repack respects --quiet' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit base &&
+		GIT_PROGRESS_DELAY=0 git repack --cruft --quiet 2>err &&
+		test_must_be_empty err
+	)
+'
+
+test_expect_success 'cruft --local drops unreachable objects' '
+	git init alternate &&
+	git init repo &&
+	test_when_finished "rm -fr alternate repo" &&
+
+	test_commit -C alternate base &&
+	# Pack all objects in alterate so that the cruft repack in "repo" sees
+	# the object it dropped due to `--local` as packed. Otherwise this
+	# object would not appear packed anywhere (since it is not packed in
+	# alternate and likewise not part of the cruft pack in the other repo
+	# because of `--local`).
+	git -C alternate repack -ad &&
+
+	(
+		cd repo &&
+
+		object="$(git -C ../alternate rev-parse HEAD:base.t)" &&
+		git -C ../alternate cat-file -p $object >contents &&
+
+		# Write some reachable objects and two unreachable ones: one
+		# that the alternate has and another that is unique.
+		test_commit other &&
+		git hash-object -w -t blob contents &&
+		cruft="$(echo cruft | git hash-object -w -t blob --stdin)" &&
+
+		( cd ../alternate/.git/objects && pwd ) \
+		       >.git/objects/info/alternates &&
+
+		test_path_is_file $objdir/$(test_oid_to_path $cruft) &&
+		test_path_is_file $objdir/$(test_oid_to_path $object) &&
+
+		git repack -d --cruft --local &&
+
+		test-tool pack-mtimes "$(basename $(ls $packdir/pack-*.mtimes))" \
+		       >objects &&
+		! grep $object objects &&
+		grep $cruft objects
+	)
+'
+
 test_done
-- 
2.34.1.25.gb3157a20e6

