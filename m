Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C50C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 23:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354108AbiETXSl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 19:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354045AbiETXSS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 19:18:18 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E0C1A449E
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:18:08 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 190so2337329qkj.8
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nmE21GSg05hcfDXrW7hSlcdw4d4W7gejKwhmP2VjV7c=;
        b=fYh08kAoe64oIFJZsnYd82eNkf0thSsj0fPhebyxUIE8fzcGf9cnauntPRXem2LfbI
         vhHSPbz6MRFx39LkPelsF6b9Pc44+1/uBAxoEoHGIa+ouHBiAdSYhZyF3RaqAqfBmkng
         mqDYN60KD//QKuFFhkqu5DvVS58x/2XerpGZOaQPybPj+wurF5WO5Gf3UsVye0CIvKiE
         TRmrEB8WFmQSW/KuXRnNXVfcIb0COaxyJGLFEMv+X1UnuEMmUISu4djyfyxU7cV+YA1I
         H790OifApOTr3MhLcQLEM/mFL2VS02ZR8Ewy/IfdmSM1PptWqGym7vRllenyUStoTPNn
         wS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nmE21GSg05hcfDXrW7hSlcdw4d4W7gejKwhmP2VjV7c=;
        b=Uz5hPEOjfitttc4tPGuZvP3i+gOO6QyPFXtSDIjaWtY91xB1RQTar+La0fDOSld7Ue
         p0wBR7ZiU/rpMMEoR/Ry/8/uoQ2wf3L5jkeB+4E0ZMmcAzh4nF3LVZvHSVLpbaTlMvM6
         fv45DIqDHPeL5EPxoNLvvunYKp8EJ01Nic9LUl5BfFgqDNCMuzlmYisj9BfxklUiAYsG
         aJ7SNlsuMVyMx88A90NjVNwFCPw2SJU0aKJU6uU4sXxjffhLNEdtnOB46XMINDhw3C4c
         +rRr3aycshU+Y9DdL6ZO0Xj5bgpm+mu809EPmVpmz4koxq0ZcmPltKoCkjCgIpGy7W7d
         DifA==
X-Gm-Message-State: AOAM532Bhhc36AtzPywcFgOL2JmzrE6JRBJg0SzMEyHLFEnFSvbYNzOv
        ZAqh/f+WI1Hdkp7x1Sw/Uq+xwstgSUcl9veA
X-Google-Smtp-Source: ABdhPJxFd3wOMpxaWFoayQlyhX4W9GzoTHNsIwcbhQ309eXzU/3dG4BTSzty8AQATs942RGJDNThhg==
X-Received: by 2002:a37:d245:0:b0:69b:f153:9c38 with SMTP id f66-20020a37d245000000b0069bf1539c38mr7858676qkj.692.1653088687287;
        Fri, 20 May 2022 16:18:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i6-20020a378606000000b0069fc13ce23esm429610qkd.111.2022.05.20.16.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 16:18:06 -0700 (PDT)
Date:   Fri, 20 May 2022 19:18:06 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: [PATCH v5 13/17] builtin/repack.c: allow configuring cruft pack
 generation
Message-ID: <4b721d3ee962257fa28ac07fde6456895a7beae9.1653088640.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1653088640.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1653088640.git.me@ttaylorr.com>
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
index 067c50af38..c82f973b41 100755
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

