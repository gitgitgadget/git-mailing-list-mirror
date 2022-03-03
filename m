Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA07C433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 00:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiCCAWQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiCCAWI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 19:22:08 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE4013CA05
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 16:21:17 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id j78so2765221qke.2
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 16:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EN4m9m33+QWVF/0GRkO+k7hH2n3BPLrRIUUUFoOpbLI=;
        b=6B3qWEq9CgEaiKxK1obhjIZJNd4E5Bvjdc2Yle1vd+L0SvK5n6Ro7bbQ9om5HG0wrp
         xTYJSuRnu0TgNKkAi2i3tmb5DTJmnFK9JfOjBL3c+fyhjfUUqbRZ+OJkWh0m/KQmhKc3
         SG5XoCWdjbAhvH+gg2I0AG97YFSdRXsMW4UpcxGTQXvA1Y4uCADk8H87f4rFgftgjqom
         SF6thK9f66Sy945LY0A+cPFED+To/lHwi92XrgQ7ArBgAzY/SIUKrNJAr1UxcVAA4gKk
         bRx8h1mtIsDGjPa2f6WqndssqVJ6zYhanhtUQvGMOui7jmM9pomgpAHglbZIGVFy/g/C
         5ZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EN4m9m33+QWVF/0GRkO+k7hH2n3BPLrRIUUUFoOpbLI=;
        b=32LmiAbQ3oq90QMOXawmY1xMyWPpLGku02VS80fj9zVdimpRixFg6CcuqUx/dQTk4t
         aCeGMhbvoB3t8O7ilM1kN4IGwUWNs0i46J/QDF/igaZ/UWGje8SIzcKrBjtF4DXbFO0U
         5JWM6WcXL7hGbGTLCK25QI2FfgPk1NMstUip+ypzrcGmq/7LPfWP/clqjOazFxljoYHi
         BZCHq5G+YlXkQ0Pvw5dyh96la5ukzB7G0EHCC57RAd8nem90f38hK2tvyaQhfjdCoMaQ
         6btwmBna/O3uAdyOFpi+xCkv1b9zmZfNIVV2+bi2bxz/cIlqZepv1/B0+hMSSOh68ENR
         Vjeg==
X-Gm-Message-State: AOAM530qC7H0xcTiZNmYEebE0UVhwnFasswSLS8XfPXKypeZMFXJmpq+
        59XED1FK59w4FNka74lN21/py4Dm8bDQEy6r
X-Google-Smtp-Source: ABdhPJzKYjTvmyxYkCojAJ35vIp7YOA+OsGZMDhh2JUOGYnCtQcL2kK1qFKutCwKg/Km0QmTx9Z1PA==
X-Received: by 2002:a37:67d0:0:b0:646:d4fd:9217 with SMTP id b199-20020a3767d0000000b00646d4fd9217mr17622690qkc.198.1646266876345;
        Wed, 02 Mar 2022 16:21:16 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b13-20020ac85bcd000000b002d6a901ad4csm364152qtb.73.2022.03.02.16.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 16:21:16 -0800 (PST)
Date:   Wed, 2 Mar 2022 19:21:15 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     tytso@mit.edu, derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com
Subject: [PATCH v3 13/17] builtin/repack.c: allow configuring cruft pack
 generation
Message-ID: <9cfcd123bd107357bf36652976cad16a56c9e366.1646266835.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646266835.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1646266835.git.me@ttaylorr.com>
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
 t/t5329-pack-objects-cruft.sh   | 83 +++++++++++++++++++++++++++++++++
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
index f7fb88bcf1..d61c78e94e 100644
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
@@ -689,6 +698,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
 	int no_update_server_info = 0;
 	struct pack_objects_args po_args = {NULL};
+	struct pack_objects_args cruft_po_args = {NULL};
 	int geometric_factor = 0;
 	int write_midx = 0;
 
@@ -743,7 +753,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(repack_config, NULL);
+	git_config(repack_config, &cruft_po_args);
 
 	argc = parse_options(argc, argv, prefix, builtin_repack_options,
 				git_repack_usage, 0);
@@ -918,7 +928,19 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
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
2.35.1.73.gccc5557600

