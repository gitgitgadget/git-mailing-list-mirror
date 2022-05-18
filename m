Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF07C433F5
	for <git@archiver.kernel.org>; Wed, 18 May 2022 23:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiERXME (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 19:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiERXLj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 19:11:39 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B68AF304
        for <git@vger.kernel.org>; Wed, 18 May 2022 16:11:26 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id m6so4031580iob.4
        for <git@vger.kernel.org>; Wed, 18 May 2022 16:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zl+yPtMLJP1vXjYflL3YckLB8rWVFVGZP0cAbonuavI=;
        b=AZi5EOpJPXV4fISkwd0oErJFTWrwiIgBn9oVNiGxyws9qKWOGw94ovpebuADkf9ykR
         2wvelZ4WI1vQGxt8xwJ8JpCtObaJlCrLstkQxkocPczj48IEodYogTs+lPaHxGfYE4hN
         e0ny64otLc/yXFOkaZ+XzyhFzja0BX3qM1NVej6pVefOlZyDDl9ZR1YY46YREcyax8pT
         txw+Gd/l76dc7zOxDULx94jKggJmB5g0chHd0Jrn5RUomRNCsWFLMlIEKAuqp6n+4ieP
         H5iX8q0Sqb+2EeC+huqfslBnfTv0VZgw3sIYq24ngVKowiAO9+UKWKS8icZivgYj0UxR
         ihtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zl+yPtMLJP1vXjYflL3YckLB8rWVFVGZP0cAbonuavI=;
        b=0X9saTEXCAlL6Hlt84HvS/S+5UZqhvta/cXezYwAzfkU9hDnv13vPzsyliAdUUPlLS
         cwE0nXMlvzm4tmYNWBpdrBnkOY3LWcl2Dps+71k3GAq8v4vSFRWnSmHLIGtUNAY3xywN
         ukqXzT9H5RBzKlwcN3crsADNitgenQtyCWOKobuVGOv/MpstJ0Z9oAsR2+q5ytX+Pzlx
         yjufwZq86htEyVnXY9UcFgfvmDDIAcU6UqJwJVh7RcQIio/0XqBRBOrix8xf/fMJnyHJ
         kgiV2dCtAvKeCwWJB/vrWhRAynVrH6LcLPVkOh3Fade+0o/d8LriK5YVHwv5xWUYNWg2
         KI/Q==
X-Gm-Message-State: AOAM533PbVyoLkMD0xm/MEUr436yHcnCyrWZXDPZjKpRqP+p13kyk3ke
        cQlxcK6vhAuO6n+MXEC2x0wh4dPMYvCUWaqg
X-Google-Smtp-Source: ABdhPJxkNj/8WFBSw4Gqd5aslhZhKPKVhoeOAJlIhSLKMJsDLUKvhzYxjep4i12+a65lBDxVpoWLvw==
X-Received: by 2002:a05:6638:2116:b0:32e:1f06:ceba with SMTP id n22-20020a056638211600b0032e1f06cebamr1065304jaj.129.1652915486022;
        Wed, 18 May 2022 16:11:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d2-20020a928742000000b002cde6e352fasm867472ilm.68.2022.05.18.16.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 16:11:25 -0700 (PDT)
Date:   Wed, 18 May 2022 19:11:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: [PATCH v4 13/17] builtin/repack.c: allow configuring cruft pack
 generation
Message-ID: <1b241f8f91a5ea22ae9509b90ffdc596a1216a08.1652915424.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1652915424.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1652915424.git.me@ttaylorr.com>
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
 builtin/repack.c                | 49 +++++++++++++------
 t/t5329-pack-objects-cruft.sh   | 83 +++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+), 14 deletions(-)

diff --git a/Documentation/config/repack.txt b/Documentation/config/repack.txt
index 41ac6953c8..c79af6d7b8 100644
--- a/Documentation/config/repack.txt
+++ b/Documentation/config/repack.txt
@@ -30,3 +30,12 @@ repack.updateServerInfo::
 	If set to false, linkgit:git-repack[1] will not run
 	linkgit:git-update-server-info[1]. Defaults to true. Can be overridden
 	when true by the `-n` option of linkgit:git-repack[1].
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
index 593c18d4e8..b85483a148 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -41,9 +41,21 @@ static const char incremental_bitmap_conflict_error[] = N_(
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
@@ -65,6 +77,14 @@ static int repack_config(const char *var, const char *value, void *cb)
 		run_update_server_info = git_config_bool(var, value);
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
 	return git_default_config(var, value, cb);
 }
 
@@ -157,18 +177,6 @@ static void remove_redundant_pack(const char *dir_name, const char *base_name)
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
@@ -692,6 +700,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	int keep_unreachable = 0;
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
 	struct pack_objects_args po_args = {NULL};
+	struct pack_objects_args cruft_po_args = {NULL};
 	int geometric_factor = 0;
 	int write_midx = 0;
 
@@ -746,7 +755,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(repack_config, NULL);
+	git_config(repack_config, &cruft_po_args);
 
 	argc = parse_options(argc, argv, prefix, builtin_repack_options,
 				git_repack_usage, 0);
@@ -921,7 +930,19 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
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
diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
index 06c550c958..e4744e4465 100755
--- a/t/t5329-pack-objects-cruft.sh
+++ b/t/t5329-pack-objects-cruft.sh
@@ -565,4 +565,87 @@ test_expect_success 'cruft repack ignores pack.packSizeLimit' '
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
2.36.1.94.gb0d54bedca

