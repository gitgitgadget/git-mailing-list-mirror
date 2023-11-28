Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="AsSDdN3+"
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CCAC3
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:21 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-77d85cf1ff5so218532385a.0
        for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701198500; x=1701803300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lHpbPyq4Mhf3Mg0XIfRDWzZwaFUDI2lMyaTsUTp389w=;
        b=AsSDdN3+C3fuSPHUjpZVoWLBZPh7xfFa01Xd9kk6tHfxv3dMyI8F+zHRFlbCJSZVl4
         CGRaBROQoYiunQQrGMzcgVPzzKABtTVCkvYnVx28vCsIThGwywqxYhbcBUsORkRi5i5G
         VTvSdtNQEzKhwWLFWbp/8U4IoslAzwvv7uhnWJeODB8JIjXj8WCJ8Gnbw20bTOdY/118
         IyW4dt/y7I+Mu4MkK6jHFoqCwO4WdiIaw2Hh0NldWTJ9D5idae8vrtFZzeXVSUFIcqwQ
         pOfa77evzTS3fNJMV5N+KFdMkACuUZvH1ROuM4vlPrn3RG05V8PAVh/3xPeepwMIaXJ4
         YECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198500; x=1701803300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHpbPyq4Mhf3Mg0XIfRDWzZwaFUDI2lMyaTsUTp389w=;
        b=Zg7k4se8+K4syu7tKRAsbSCYPGRY3v0wbgPyA4rCwicr9nElL6mlveuP2CybZwrmrC
         w76Zy9we+2UyCtWB3TxSXD4EH/OklbjqIOtJHvD8sAyO9LNmQvVBWzIRvoR9CJVAkUHT
         xiavMLB6JDWNFF3JayCSmHXJWZCVTk97RxXixCdEapPJJpa/vOzJOGV89Q8jL83NmWGU
         A0oOKCo8tVHhqLVjIWZ46nTF4CZcsDwKxO8qx6rBDLSwXs9D7Yu2YwADUdJl2AszxKlj
         a7osItUrNiOcbhVouR1Rz250SudyXzeqwvpm6VE84440e+OMemTnoUOfxq3JYoQv76Dx
         oraA==
X-Gm-Message-State: AOJu0Yy2ybc6aVtKNctxgRWcl754fYOCwO74Q7ki+cWxuOhRgSz6n8UN
	ogfgBzYimByZ5iZN6qHW5XW7x0RwRJK9AD1S9M0=
X-Google-Smtp-Source: AGHT+IF45aEaCdR1d8KaKcrk9Hvu+vvrJsFNlVY4CFhhKxHQUr/qTk+pdY8OYzIXHUzUyPf/6Z8oOQ==
X-Received: by 2002:a05:620a:113b:b0:76c:da86:3169 with SMTP id p27-20020a05620a113b00b0076cda863169mr16573251qkk.40.1701198499963;
        Tue, 28 Nov 2023 11:08:19 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y25-20020a37e319000000b0077d74f884d9sm2147133qki.117.2023.11.28.11.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 11:08:19 -0800 (PST)
Date: Tue, 28 Nov 2023 14:08:18 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 09/24] repack: implement `--extend-disjoint` mode
Message-ID: <b75869befba26899d88d6c6d413cc756aeadbd80.1701198172.git.me@ttaylorr.com>
References: <cover.1701198172.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1701198172.git.me@ttaylorr.com>

Now that we can generate packs which are disjoint with respect to the
set of currently-disjoint packs, implement a mode of `git repack` which
extends the set of disjoint packs with any new (non-cruft) pack(s)
generated during the repack.

The idea is mostly straightforward, with a couple of gotcha's. The
straightforward part is to make sure that any new packs are disjoint
with respect to the set of currently disjoint packs which are _not_
being removed from the repository as a result of the repack.

If a pack which is currently marked as disjoint is, on the other hand,
about to be removed from the repository, it is OK (and expected) that
new pack(s) will contain some or all of its objects. Since the pack
originally marked as disjoint will be removed, it will necessarily leave
the disjoint set, making room for new packs with its same objects to
take its place. In other words, the resulting set of disjoint packs will
be disjoint with respect to one another.

The gotchas mostly have to do with making sure that we do not generate a
disjoint pack in the following scenarios:

  - promisor packs
  - cruft packs (which may necessarily need to include an object from a
    disjoint pack in order to freshen it in certain circumstances)
  - all-into-one repacks without '-d'
  - `--filter-to`, which conceptually could work with the new
    `--extend-disjoint` option, but only in limited circumstances

Otherwise, we mark which packs were created as disjoint by using a new
bit in the `generated_pack_data` struct, and then marking those pack(s)
as disjoint accordingly when generating the MIDX. Non-deleted packs
which are marked as disjoint are retained as such by passing the
equivalent of `--retain-disjoint` when calling the MIDX API to update
the MIDX.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-repack.txt      |  12 +++
 builtin/repack.c                  |  57 +++++++++---
 t/t7700-repack.sh                 |   4 +-
 t/t7705-repack-extend-disjoint.sh | 142 ++++++++++++++++++++++++++++++
 4 files changed, 203 insertions(+), 12 deletions(-)
 create mode 100755 t/t7705-repack-extend-disjoint.sh

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index c902512a9e..50ba5e7f9c 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -249,6 +249,18 @@ linkgit:git-multi-pack-index[1]).
 	Write a multi-pack index (see linkgit:git-multi-pack-index[1])
 	containing the non-redundant packs.
 
+--extend-disjoint::
+	Extends the set of disjoint packs. All new non-cruft pack(s)
+	generated are constructed to be disjoint with respect to the set
+	of currently disjoint packs, excluding any packs that will be
+	removed as a result of the repack operation. For more on
+	disjoint packs, see the details in linkgit:gitformat-pack[5],
+	under the section "`DISP` chunk and disjoint packs".
++
+Useful only with the combination of `--write-midx` and
+`--write-bitmap-index`. Incompatible with `--filter-to`. Incompatible
+with `-A`, `-a`, or `--cruft` unless `-d` is given.
+
 CONFIGURATION
 -------------
 
diff --git a/builtin/repack.c b/builtin/repack.c
index edaee4dbec..0601bd16c4 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -58,6 +58,7 @@ struct pack_objects_args {
 	int no_reuse_object;
 	int quiet;
 	int local;
+	int ignore_disjoint;
 	struct list_objects_filter_options filter_options;
 };
 
@@ -293,6 +294,8 @@ static void prepare_pack_objects(struct child_process *cmd,
 		strvec_push(&cmd->args,  "--local");
 	if (args->quiet)
 		strvec_push(&cmd->args,  "--quiet");
+	if (args->ignore_disjoint)
+		strvec_push(&cmd->args,  "--ignore-disjoint");
 	if (delta_base_offset)
 		strvec_push(&cmd->args,  "--delta-base-offset");
 	strvec_push(&cmd->args, out);
@@ -334,9 +337,11 @@ static struct {
 
 struct generated_pack_data {
 	struct tempfile *tempfiles[ARRAY_SIZE(exts)];
+	unsigned disjoint : 1;
 };
 
-static struct generated_pack_data *populate_pack_exts(const char *name)
+static struct generated_pack_data *populate_pack_exts(const char *name,
+						      unsigned disjoint)
 {
 	struct stat statbuf;
 	struct strbuf path = STRBUF_INIT;
@@ -353,6 +358,8 @@ static struct generated_pack_data *populate_pack_exts(const char *name)
 		data->tempfiles[i] = register_tempfile(path.buf);
 	}
 
+	data->disjoint = disjoint;
+
 	strbuf_release(&path);
 	return data;
 }
@@ -379,6 +386,8 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 	prepare_pack_objects(&cmd, args, packtmp);
 	cmd.in = -1;
 
+	strvec_pushf(&cmd.args, "--no-ignore-disjoint");
+
 	/*
 	 * NEEDSWORK: Giving pack-objects only the OIDs without any ordering
 	 * hints may result in suboptimal deltas in the resulting pack. See if
@@ -421,7 +430,7 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 					  line.buf);
 		write_promisor_file(promisor_name, NULL, 0);
 
-		item->util = populate_pack_exts(item->string);
+		item->util = populate_pack_exts(item->string, 0);
 
 		free(promisor_name);
 	}
@@ -731,8 +740,13 @@ static void midx_included_packs(struct string_list *include,
 
 	for_each_string_list_item(item, &existing->kept_packs)
 		string_list_insert(include, xstrfmt("%s.idx", item->string));
-	for_each_string_list_item(item, names)
-		string_list_insert(include, xstrfmt("pack-%s.idx", item->string));
+	for_each_string_list_item(item, names) {
+		const char *marker = "";
+		struct generated_pack_data *data = item->util;
+		if (data->disjoint)
+			marker = "+";
+		string_list_insert(include, xstrfmt("%spack-%s.idx", marker, item->string));
+	}
 	if (geometry->split_factor) {
 		struct strbuf buf = STRBUF_INIT;
 		uint32_t i;
@@ -788,7 +802,8 @@ static int write_midx_included_packs(struct string_list *include,
 				     struct pack_geometry *geometry,
 				     struct string_list *names,
 				     const char *refs_snapshot,
-				     int show_progress, int write_bitmaps)
+				     int show_progress, int write_bitmaps,
+				     int exclude_disjoint)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct string_list_item *item;
@@ -852,6 +867,9 @@ static int write_midx_included_packs(struct string_list *include,
 	if (refs_snapshot)
 		strvec_pushf(&cmd.args, "--refs-snapshot=%s", refs_snapshot);
 
+	if (exclude_disjoint)
+		strvec_push(&cmd.args, "--retain-disjoint");
+
 	ret = start_command(&cmd);
 	if (ret)
 		return ret;
@@ -895,7 +913,7 @@ static void remove_redundant_bitmaps(struct string_list *include,
 
 static int finish_pack_objects_cmd(struct child_process *cmd,
 				   struct string_list *names,
-				   int local)
+				   int local, int disjoint)
 {
 	FILE *out;
 	struct strbuf line = STRBUF_INIT;
@@ -913,7 +931,7 @@ static int finish_pack_objects_cmd(struct child_process *cmd,
 		 */
 		if (local) {
 			item = string_list_append(names, line.buf);
-			item->util = populate_pack_exts(line.buf);
+			item->util = populate_pack_exts(line.buf, disjoint);
 		}
 	}
 	fclose(out);
@@ -970,7 +988,7 @@ static int write_filtered_pack(const struct pack_objects_args *args,
 		fprintf(in, "%s%s.pack\n", caret, item->string);
 	fclose(in);
 
-	return finish_pack_objects_cmd(&cmd, names, local);
+	return finish_pack_objects_cmd(&cmd, names, local, 0);
 }
 
 static int existing_cruft_pack_cmp(const void *va, const void *vb)
@@ -1098,7 +1116,7 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 		fprintf(in, "%s.pack\n", item->string);
 	fclose(in);
 
-	return finish_pack_objects_cmd(&cmd, names, local);
+	return finish_pack_objects_cmd(&cmd, names, local, 0);
 }
 
 static const char *find_pack_prefix(const char *packdir, const char *packtmp)
@@ -1190,6 +1208,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			   N_("pack prefix to store a pack containing pruned objects")),
 		OPT_STRING(0, "filter-to", &filter_to, N_("dir"),
 			   N_("pack prefix to store a pack containing filtered out objects")),
+		OPT_BOOL(0, "extend-disjoint", &po_args.ignore_disjoint,
+			 N_("add new packs to the set of disjoint ones")),
 		OPT_END()
 	};
 
@@ -1255,6 +1275,16 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		strbuf_release(&path);
 	}
 
+	if (po_args.ignore_disjoint) {
+		if (filter_to)
+			die(_("options '%s' and '%s' cannot be used together"),
+			    "--filter-to", "--extend-disjoint");
+		if (pack_everything && !delete_redundant)
+			die(_("cannot use '--extend-disjoint' with '%s' but not '-d'"),
+			    pack_everything & LOOSEN_UNREACHABLE ? "-A" :
+			    pack_everything & PACK_CRUFT ? "--cruft" : "-a");
+	}
+
 	packdir = mkpathdup("%s/pack", get_object_directory());
 	packtmp_name = xstrfmt(".tmp-%d-pack", (int)getpid());
 	packtmp = mkpathdup("%s/%s", packdir, packtmp_name);
@@ -1308,6 +1338,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (pack_everything & ALL_INTO_ONE) {
 		repack_promisor_objects(&po_args, &names);
 
+		if (delete_redundant)
+			strvec_pushf(&cmd.args, "--no-ignore-disjoint");
+
 		if (has_existing_non_kept_packs(&existing) &&
 		    delete_redundant &&
 		    !(pack_everything & PACK_CRUFT)) {
@@ -1364,7 +1397,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		fclose(in);
 	}
 
-	ret = finish_pack_objects_cmd(&cmd, &names, 1);
+	ret = finish_pack_objects_cmd(&cmd, &names, 1, po_args.ignore_disjoint);
 	if (ret)
 		goto cleanup;
 
@@ -1387,6 +1420,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 		cruft_po_args.local = po_args.local;
 		cruft_po_args.quiet = po_args.quiet;
+		cruft_po_args.ignore_disjoint = 0;
 
 		ret = write_cruft_pack(&cruft_po_args, packtmp, pack_prefix,
 				       cruft_expiration, &names,
@@ -1487,7 +1521,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 		ret = write_midx_included_packs(&include, &geometry, &names,
 						refs_snapshot ? get_tempfile_path(refs_snapshot) : NULL,
-						show_progress, write_bitmaps > 0);
+						show_progress, write_bitmaps > 0,
+						po_args.ignore_disjoint);
 
 		if (!ret && write_bitmaps)
 			remove_redundant_bitmaps(&include, packdir);
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index d2975e6c93..277f1ff1d7 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -6,6 +6,7 @@ test_description='git repack works correctly'
 . "${TEST_DIRECTORY}/lib-bitmap.sh"
 . "${TEST_DIRECTORY}/lib-midx.sh"
 . "${TEST_DIRECTORY}/lib-terminal.sh"
+. "${TEST_DIRECTORY}/lib-disjoint.sh"
 
 commit_and_pack () {
 	test_commit "$@" 1>&2 &&
@@ -525,7 +526,8 @@ test_expect_success '--filter works with --max-pack-size' '
 '
 
 objdir=.git/objects
-midx=$objdir/pack/multi-pack-index
+packdir=$objdir/pack
+midx=$packdir/multi-pack-index
 
 test_expect_success 'setup for --write-midx tests' '
 	git init midx &&
diff --git a/t/t7705-repack-extend-disjoint.sh b/t/t7705-repack-extend-disjoint.sh
new file mode 100755
index 0000000000..0c8be1cb3f
--- /dev/null
+++ b/t/t7705-repack-extend-disjoint.sh
@@ -0,0 +1,142 @@
+#!/bin/sh
+
+test_description='git repack --extend-disjoint works correctly'
+
+. ./test-lib.sh
+. "${TEST_DIRECTORY}/lib-disjoint.sh"
+
+packdir=.git/objects/pack
+
+GIT_TEST_MULTI=0
+GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
+
+test_expect_success 'repack --extend-disjoint creates new disjoint packs' '
+	git init repo &&
+	(
+		cd repo &&
+
+		test_commit A &&
+		test_commit B &&
+
+		A="$(echo A | git pack-objects --revs $packdir/pack)" &&
+		B="$(echo A..B | git pack-objects --revs $packdir/pack)" &&
+
+		git prune-packed &&
+
+		cat >in <<-EOF &&
+		pack-$A.idx
+		+pack-$B.idx
+		EOF
+		git multi-pack-index write --bitmap --stdin-packs <in &&
+
+		test_must_not_be_disjoint "pack-$A.pack" &&
+		test_must_be_disjoint "pack-$B.pack" &&
+
+		test_commit C &&
+
+		find $packdir -type f -name "*.idx" | sort >packs.before &&
+		git repack --write-midx --write-bitmap-index --extend-disjoint &&
+		find $packdir -type f -name "*.idx" | sort >packs.after &&
+
+		comm -13 packs.before packs.after >packs.new &&
+
+		test_line_count = 1 packs.new &&
+
+		test_must_not_be_disjoint "pack-$A.pack" &&
+		test_must_be_disjoint "pack-$B.pack" &&
+		test_must_be_disjoint "$(basename $(cat packs.new) .idx).pack"
+	)
+'
+
+test_expect_success 'repack --extend-disjoint combines existing disjoint packs' '
+	(
+		cd repo &&
+
+		test_commit D &&
+
+		git repack -a -d --write-midx --write-bitmap-index --extend-disjoint &&
+
+		find $packdir -type f -name "*.pack" >packs &&
+		test_line_count = 1 packs &&
+
+		test_must_be_disjoint "$(basename $(cat packs))"
+
+	)
+'
+
+test_expect_success 'repack --extend-disjoint with --geometric' '
+	git init disjoint-geometric &&
+	(
+		cd disjoint-geometric &&
+
+		test_commit_bulk 8 &&
+		base="$(basename $(ls $packdir/pack-*.idx))" &&
+		echo "+$base" >>in &&
+
+		test_commit A &&
+		A="$(echo HEAD^.. | git pack-objects --revs $packdir/pack)" &&
+		test_commit B &&
+		B="$(echo HEAD^.. | git pack-objects --revs $packdir/pack)" &&
+
+		git prune-packed &&
+
+		cat >>in <<-EOF &&
+		+pack-$A.idx
+		+pack-$B.idx
+		EOF
+		git multi-pack-index write --bitmap --stdin-packs <in &&
+
+		test_must_be_disjoint "pack-$A.pack" &&
+		test_must_be_disjoint "pack-$B.pack" &&
+		test_must_be_disjoint "${base%.idx}.pack" &&
+
+		test_commit C &&
+
+		find $packdir -type f -name "*.pack" | sort >packs.before &&
+		git repack --geometric=2 -d --write-midx --write-bitmap-index --extend-disjoint &&
+		find $packdir -type f -name "*.pack" | sort >packs.after &&
+
+		comm -12 packs.before packs.after >packs.unchanged &&
+		comm -23 packs.before packs.after >packs.removed &&
+		comm -13 packs.before packs.after >packs.new &&
+
+		cat >expect <<-EOF &&
+		$packdir/${base%.idx}.pack
+		EOF
+		test_cmp expect packs.unchanged &&
+
+		sort >expect <<-EOF &&
+		$packdir/pack-$A.pack
+		$packdir/pack-$B.pack
+		EOF
+		test_cmp expect packs.removed &&
+
+		test_line_count = 1 packs.new &&
+
+		test_must_be_disjoint "$(basename $(cat packs.new))" &&
+		test_must_be_disjoint "${base%.idx}.pack"
+	)
+'
+
+for flag in "-A" "-a" "--cruft"
+do
+	test_expect_success "repack --extend-disjoint incompatible with $flag without -d" '
+		test_must_fail git repack $flag --extend-disjoint \
+			--write-midx --write-bitmap-index 2>actual &&
+		cat >expect <<-EOF &&
+		fatal: cannot use $SQ--extend-disjoint$SQ with $SQ$flag$SQ but not $SQ-d$SQ
+		EOF
+		test_cmp expect actual
+	'
+done
+
+test_expect_success 'repack --extend-disjoint is incompatible with --filter-to' '
+	test_must_fail git repack --extend-disjoint --filter-to=dir 2>actual &&
+
+	cat >expect <<-EOF &&
+	fatal: options $SQ--filter-to$SQ and $SQ--extend-disjoint$SQ cannot be used together
+	EOF
+	test_cmp expect actual
+'
+
+test_done
-- 
2.43.0.24.g980b318f98

