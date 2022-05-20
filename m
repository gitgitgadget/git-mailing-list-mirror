Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDB5C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 23:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354041AbiETXSZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 19:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354063AbiETXSR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 19:18:17 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D871A35B9
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:18:05 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id c1so8889362qkf.13
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BXixUV7Y+Re89VIvjgoU+sWdvkG3/EPOIMYzR86V9Q8=;
        b=HTT/hEjI+PGLLv49IJqPqr/VFN3yKON7AjkcG2F9TlUyFL9pPKZp+KQkYsSh3nQ0xT
         F8Lzki9u+roB0mBMSSjkF+5jaXuAtn5cXjoDUYgYWPbzxhxAyY9Wk/wK8RqQZBZ2RiGN
         dRY0v19aAsWJz1ruBPxwFhdYbSTY4znWZha9jaCU7jaogY3HMHka7MmO8w5JwMu1+Dqi
         45LE2YcJ+v35pw1NtJxtRDtsNqD3ITyL708RP1SUwfDc1ExPChVRWgpJSlkxVivA3lnn
         rL79DW0K13Ew56Fclisy/Zm/tmCETvc1hTGNNqHdzd5UgMhwIFJi+3pZ/B3Qq4KovSaP
         +fEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BXixUV7Y+Re89VIvjgoU+sWdvkG3/EPOIMYzR86V9Q8=;
        b=z+426bdikooQqxmuyZFo46TZdu5BV39WJcqrin9xxvDXoeShn5Dhfp5wjyI2WIDmmI
         ghN0Sb0VWtGpK3kBIHroDDhrbMUOgZUc03+N6SlUfKU1diJvHfi9NbfHKIQFc+gmRRRC
         Nsg1RbccHGHevDoEZjI/jIaDSdMyGVsmfADNZkukN7kQAgqay54d9HJoefQu+XIgzEiX
         /4tvUBQQ5gu3bpHjE+gnquClpSUtT+oN7cMr32HsLz9AhmNAnXhfCv2G1xCCEI7NvrTS
         zk0S78YrXWS3rAoD8AzcZiTl3MaIQ/kys58eQzr+1sovi1A0RitQYZydggNs2AUt0Q/x
         cJTQ==
X-Gm-Message-State: AOAM530x403lvVNyNbQ26oo8Hq19j9rzR23KtcabzWy99h1SWyjqOfnj
        nGnRjUNSvCqI8T8PS2QBxA06gjkh+odCk2H5
X-Google-Smtp-Source: ABdhPJz9fbnFn0oF6iwWKkVIpUCQL2wJP+bGph+7qHW5iTYxJ6hOEcYFkaZD2R5utNgaRFchnmZYag==
X-Received: by 2002:a37:55c7:0:b0:69b:f3fd:4fde with SMTP id j190-20020a3755c7000000b0069bf3fd4fdemr7743955qkb.101.1653088684328;
        Fri, 20 May 2022 16:18:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g26-20020ac8469a000000b002f39b99f67bsm484061qto.21.2022.05.20.16.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 16:18:03 -0700 (PDT)
Date:   Fri, 20 May 2022 19:18:03 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: [PATCH v5 12/17] builtin/repack.c: support generating a cruft pack
Message-ID: <0d3555d595523dc3e8d4c064038ed11040f2a383.1653088640.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1653088640.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1653088640.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Expose a way to split the contents of a repository into a main and cruft
pack when doing an all-into-one repack with `git repack --cruft -d`, and
a complementary configuration variable.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-repack.txt            |  11 ++
 Documentation/technical/cruft-packs.txt |   2 +-
 builtin/repack.c                        | 105 +++++++++++-
 t/t5329-pack-objects-cruft.sh           | 207 ++++++++++++++++++++++++
 4 files changed, 319 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index ee30edc178..0bf13893d8 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -63,6 +63,17 @@ to the new separate pack will be written.
 	Also run  'git prune-packed' to remove redundant
 	loose object files.
 
+--cruft::
+	Same as `-a`, unless `-d` is used. Then any unreachable objects
+	are packed into a separate cruft pack. Unreachable objects can
+	be pruned using the normal expiry rules with the next `git gc`
+	invocation (see linkgit:git-gc[1]). Incompatible with `-k`.
+
+--cruft-expiration=<approxidate>::
+	Expire unreachable objects older than `<approxidate>`
+	immediately instead of waiting for the next `git gc` invocation.
+	Only useful with `--cruft -d`.
+
 -l::
 	Pass the `--local` option to 'git pack-objects'. See
 	linkgit:git-pack-objects[1].
diff --git a/Documentation/technical/cruft-packs.txt b/Documentation/technical/cruft-packs.txt
index c0f583cd48..d81f3a8982 100644
--- a/Documentation/technical/cruft-packs.txt
+++ b/Documentation/technical/cruft-packs.txt
@@ -17,7 +17,7 @@ pruned according to normal expiry rules with the next 'git gc' invocation.
 
 Unreachable objects aren't removed immediately, since doing so could race with
 an incoming push which may reference an object which is about to be deleted.
-Instead, those unreachable objects are stored as loose object and stay that way
+Instead, those unreachable objects are stored as loose objects and stay that way
 until they are older than the expiration window, at which point they are removed
 by linkgit:git-prune[1].
 
diff --git a/builtin/repack.c b/builtin/repack.c
index e7a3920c6d..593c18d4e8 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -18,12 +18,18 @@
 #include "pack-bitmap.h"
 #include "refs.h"
 
+#define ALL_INTO_ONE 1
+#define LOOSEN_UNREACHABLE 2
+#define PACK_CRUFT 4
+
+static int pack_everything;
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
 static int write_bitmaps = -1;
 static int use_delta_islands;
 static int run_update_server_info = 1;
 static char *packdir, *packtmp_name, *packtmp;
+static char *cruft_expiration;
 
 static const char *const git_repack_usage[] = {
 	N_("git repack [<options>]"),
@@ -305,9 +311,6 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 		die(_("could not finish pack-objects to repack promisor objects"));
 }
 
-#define ALL_INTO_ONE 1
-#define LOOSEN_UNREACHABLE 2
-
 struct pack_geometry {
 	struct packed_git **pack;
 	uint32_t pack_nr, pack_alloc;
@@ -344,6 +347,8 @@ static void init_pack_geometry(struct pack_geometry **geometry_p)
 	for (p = get_all_packs(the_repository); p; p = p->next) {
 		if (!pack_kept_objects && p->pack_keep)
 			continue;
+		if (p->is_cruft)
+			continue;
 
 		ALLOC_GROW(geometry->pack,
 			   geometry->pack_nr + 1,
@@ -605,6 +610,67 @@ static int write_midx_included_packs(struct string_list *include,
 	return finish_command(&cmd);
 }
 
+static int write_cruft_pack(const struct pack_objects_args *args,
+			    const char *pack_prefix,
+			    struct string_list *names,
+			    struct string_list *existing_packs,
+			    struct string_list *existing_kept_packs)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct strbuf line = STRBUF_INIT;
+	struct string_list_item *item;
+	FILE *in, *out;
+	int ret;
+
+	prepare_pack_objects(&cmd, args);
+
+	strvec_push(&cmd.args, "--cruft");
+	if (cruft_expiration)
+		strvec_pushf(&cmd.args, "--cruft-expiration=%s",
+			     cruft_expiration);
+
+	strvec_push(&cmd.args, "--honor-pack-keep");
+	strvec_push(&cmd.args, "--non-empty");
+	strvec_push(&cmd.args, "--max-pack-size=0");
+
+	cmd.in = -1;
+
+	ret = start_command(&cmd);
+	if (ret)
+		return ret;
+
+	/*
+	 * names has a confusing double use: it both provides the list
+	 * of just-written new packs, and accepts the name of the cruft
+	 * pack we are writing.
+	 *
+	 * By the time it is read here, it contains only the pack(s)
+	 * that were just written, which is exactly the set of packs we
+	 * want to consider kept.
+	 */
+	in = xfdopen(cmd.in, "w");
+	for_each_string_list_item(item, names)
+		fprintf(in, "%s-%s.pack\n", pack_prefix, item->string);
+	for_each_string_list_item(item, existing_packs)
+		fprintf(in, "-%s.pack\n", item->string);
+	for_each_string_list_item(item, existing_kept_packs)
+		fprintf(in, "%s.pack\n", item->string);
+	fclose(in);
+
+	out = xfdopen(cmd.out, "r");
+	while (strbuf_getline_lf(&line, out) != EOF) {
+		if (line.len != the_hash_algo->hexsz)
+			die(_("repack: Expecting full hex object ID lines only "
+			      "from pack-objects."));
+		string_list_append(names, line.buf);
+	}
+	fclose(out);
+
+	strbuf_release(&line);
+
+	return finish_command(&cmd);
+}
+
 int cmd_repack(int argc, const char **argv, const char *prefix)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -621,7 +687,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	int show_progress;
 
 	/* variables to be filled by option parsing */
-	int pack_everything = 0;
 	int delete_redundant = 0;
 	const char *unpack_unreachable = NULL;
 	int keep_unreachable = 0;
@@ -636,6 +701,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		OPT_BIT('A', NULL, &pack_everything,
 				N_("same as -a, and turn unreachable objects loose"),
 				   LOOSEN_UNREACHABLE | ALL_INTO_ONE),
+		OPT_BIT(0, "cruft", &pack_everything,
+				N_("same as -a, pack unreachable cruft objects separately"),
+				   PACK_CRUFT),
+		OPT_STRING(0, "cruft-expiration", &cruft_expiration, N_("approxidate"),
+				N_("with -C, expire objects older than this")),
 		OPT_BOOL('d', NULL, &delete_redundant,
 				N_("remove redundant packs, and run git-prune-packed")),
 		OPT_BOOL('f', NULL, &po_args.no_reuse_delta,
@@ -688,6 +758,15 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	    (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE)))
 		die(_("options '%s' and '%s' cannot be used together"), "--keep-unreachable", "-A");
 
+	if (pack_everything & PACK_CRUFT) {
+		pack_everything |= ALL_INTO_ONE;
+
+		if (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE))
+			die(_("options '%s' and '%s' cannot be used together"), "--cruft", "-A");
+		if (keep_unreachable)
+			die(_("options '%s' and '%s' cannot be used together"), "--cruft", "-k");
+	}
+
 	if (write_bitmaps < 0) {
 		if (!write_midx &&
 		    (!(pack_everything & ALL_INTO_ONE) || !is_bare_repository()))
@@ -771,7 +850,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (pack_everything & ALL_INTO_ONE) {
 		repack_promisor_objects(&po_args, &names);
 
-		if (existing_nonkept_packs.nr && delete_redundant) {
+		if (existing_nonkept_packs.nr && delete_redundant &&
+		    !(pack_everything & PACK_CRUFT)) {
 			for_each_string_list_item(item, &names) {
 				strvec_pushf(&cmd.args, "--keep-pack=%s-%s.pack",
 					     packtmp_name, item->string);
@@ -833,6 +913,21 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (!names.nr && !po_args.quiet)
 		printf_ln(_("Nothing new to pack."));
 
+	if (pack_everything & PACK_CRUFT) {
+		const char *pack_prefix;
+		if (!skip_prefix(packtmp, packdir, &pack_prefix))
+			die(_("pack prefix %s does not begin with objdir %s"),
+			    packtmp, packdir);
+		if (*pack_prefix == '/')
+			pack_prefix++;
+
+		ret = write_cruft_pack(&po_args, pack_prefix, &names,
+				       &existing_nonkept_packs,
+				       &existing_kept_packs);
+		if (ret)
+			return ret;
+	}
+
 	for_each_string_list_item(item, &names) {
 		item->util = (void *)(uintptr_t)populate_pack_exts(item->string);
 	}
diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
index 939cdc297a..067c50af38 100755
--- a/t/t5329-pack-objects-cruft.sh
+++ b/t/t5329-pack-objects-cruft.sh
@@ -358,4 +358,211 @@ test_expect_success 'expired objects are pruned' '
 	)
 '
 
+test_expect_success 'repack --cruft generates a cruft pack' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit reachable &&
+		git branch -M main &&
+		git checkout --orphan other &&
+		test_commit unreachable &&
+
+		git checkout main &&
+		git branch -D other &&
+		git tag -d unreachable &&
+		# objects are not cruft if they are contained in the reflogs
+		git reflog expire --all --expire=all &&
+
+		git rev-list --objects --all --no-object-names >reachable.raw &&
+		git cat-file --batch-all-objects --batch-check="%(objectname)" >objects &&
+		sort <reachable.raw >reachable &&
+		comm -13 reachable objects >unreachable &&
+
+		git repack --cruft -d &&
+
+		cruft=$(basename $(ls $packdir/pack-*.mtimes) .mtimes) &&
+		pack=$(basename $(ls $packdir/pack-*.pack | grep -v $cruft) .pack) &&
+
+		git show-index <$packdir/$pack.idx >actual.raw &&
+		cut -f2 -d" " actual.raw | sort >actual &&
+		test_cmp reachable actual &&
+
+		git show-index <$packdir/$cruft.idx >actual.raw &&
+		cut -f2 -d" " actual.raw | sort >actual &&
+		test_cmp unreachable actual
+	)
+'
+
+test_expect_success 'loose objects mtimes upsert others' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit reachable &&
+		git repack -Ad &&
+		git branch -M main &&
+
+		git checkout --orphan other &&
+		test_commit cruft &&
+		# incremental repack, leaving existing objects loose (so
+		# they can be "freshened")
+		git repack &&
+
+		tip="$(git rev-parse cruft)" &&
+		path="$objdir/$(test_oid_to_path "$tip")" &&
+		test-tool chmtime --get +1000 "$path" >expect &&
+
+		git checkout main &&
+		git branch -D other &&
+		git tag -d cruft &&
+		git reflog expire --all --expire=all &&
+
+		git repack --cruft -d &&
+
+		mtimes="$(basename $(ls $packdir/pack-*.mtimes))" &&
+		test-tool pack-mtimes "$mtimes" >actual.raw &&
+		grep "$tip" actual.raw | cut -d" " -f2 >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'cruft packs are not included in geometric repack' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit reachable &&
+		git repack -Ad &&
+		git branch -M main &&
+
+		git checkout --orphan other &&
+		test_commit cruft &&
+		git repack -d &&
+
+		git checkout main &&
+		git branch -D other &&
+		git tag -d cruft &&
+		git reflog expire --all --expire=all &&
+
+		git repack --cruft &&
+
+		find $packdir -type f | sort >before &&
+		git repack --geometric=2 -d &&
+		find $packdir -type f | sort >after &&
+
+		test_cmp before after
+	)
+'
+
+test_expect_success 'repack --geometric collects once-cruft objects' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit reachable &&
+		git repack -Ad &&
+		git branch -M main &&
+
+		git checkout --orphan other &&
+		git rm -rf . &&
+		test_commit --no-tag cruft &&
+		cruft="$(git rev-parse HEAD)" &&
+
+		git checkout main &&
+		git branch -D other &&
+		git reflog expire --all --expire=all &&
+
+		# Pack the objects created in the previous step into a cruft
+		# pack. Intentionally leave loose copies of those objects
+		# around so we can pick them up in a subsequent --geometric
+		# reapack.
+		git repack --cruft &&
+
+		# Now make those objects reachable, and ensure that they are
+		# packed into the new pack created via a --geometric repack.
+		git update-ref refs/heads/other $cruft &&
+
+		# Without this object, the set of unpacked objects is exactly
+		# the set of objects already in the cruft pack. Tweak that set
+		# to ensure we do not overwrite the cruft pack entirely.
+		test_commit reachable2 &&
+
+		find $packdir -name "pack-*.idx" | sort >before &&
+		git repack --geometric=2 -d &&
+		find $packdir -name "pack-*.idx" | sort >after &&
+
+		{
+			git rev-list --objects --no-object-names $cruft &&
+			git rev-list --objects --no-object-names reachable..reachable2
+		} >want.raw &&
+		sort want.raw >want &&
+
+		pack=$(comm -13 before after) &&
+		git show-index <$pack >objects.raw &&
+
+		cut -d" " -f2 objects.raw | sort >got &&
+
+		test_cmp want got
+	)
+'
+
+test_expect_success 'cruft repack with no reachable objects' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit base &&
+		git repack -ad &&
+
+		base="$(git rev-parse base)" &&
+
+		git for-each-ref --format="delete %(refname)" >in &&
+		git update-ref --stdin <in &&
+		git reflog expire --all --expire=all &&
+		rm -fr .git/index &&
+
+		git repack --cruft -d &&
+
+		git cat-file -t $base
+	)
+'
+
+test_expect_success 'cruft repack ignores --max-pack-size' '
+	git init max-pack-size &&
+	(
+		cd max-pack-size &&
+		test_commit base &&
+		# two cruft objects which exceed the maximum pack size
+		test-tool genrandom foo 1048576 | git hash-object --stdin -w &&
+		test-tool genrandom bar 1048576 | git hash-object --stdin -w &&
+		git repack --cruft --max-pack-size=1M &&
+		find $packdir -name "*.mtimes" >cruft &&
+		test_line_count = 1 cruft &&
+		test-tool pack-mtimes "$(basename "$(cat cruft)")" >objects &&
+		test_line_count = 2 objects
+	)
+'
+
+test_expect_success 'cruft repack ignores pack.packSizeLimit' '
+	(
+		cd max-pack-size &&
+		# repack everything back together to remove the existing cruft
+		# pack (but to keep its objects)
+		git repack -adk &&
+		git -c pack.packSizeLimit=1M repack --cruft &&
+		# ensure the same post condition is met when --max-pack-size
+		# would otherwise be inferred from the configuration
+		find $packdir -name "*.mtimes" >cruft &&
+		test_line_count = 1 cruft &&
+		test-tool pack-mtimes "$(basename "$(cat cruft)")" >objects &&
+		test_line_count = 2 objects
+	)
+'
+
 test_done
-- 
2.36.1.94.gb0d54bedca

