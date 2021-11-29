Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A05C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbhK2W3m (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbhK2W3A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:29:00 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D63C096776
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:25:35 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id m5so19035594ilh.11
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EmV8GwhhrRCVvLoRNVoAAGu1pWxdevfh20CKtiY18p8=;
        b=zcMtv2nj/PTNmlZNSzCYpigejWguVstxe794soKjlbhjxTfKTzQxDGRkjv7sHEfPGO
         QELw0YT5lxQmP4QcLeI5ccf+UXzVS/mRzfIcZu7LaMbM4UizXxJPaAau16ObeVRDa0h8
         9MsxPv9VTj8dkqCi3hlZQlVzdcAUTodd3cNpdYR6Bn8z490wb3hZgUD3jB3P9CDAbDVP
         MRw7t0x7cRI1PPqzQqSCKRdX2j5Am3oIp23/TCBBgQ0c63HpG5f0g43UuaYgFK7LdkAH
         nFIlqvE8PDlK9ku3o7krJaFi5KEcCHm5odaTtPD7gY1jYnbor7kRKazKGBeSEdtHQ5c/
         5Hvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EmV8GwhhrRCVvLoRNVoAAGu1pWxdevfh20CKtiY18p8=;
        b=6nVth7CM5Gd2FIggdDqjARXhZeT+XeVi0pFFSDyO8kQivDUPs1m9wN8Jf6yz+JQxa2
         RMeP4O3MJsXMpXscSIBjlPKC5OXS+KQONmMo9MZtwBYKgc3EwA6+fOC4lEzin2mxliUa
         ncEXsWZw0yebP5Yw/n8FvEwMjiRRnt7XjWrzJck4qli3P6kKCrCnuHf/OhRlYWNde/u7
         w4abC/L9lgqAxaVUKaIVsm0n5Gx34NAXS50V7WQDtMMdphSY0vmfrytW40TWfMmmHhji
         9dr9Hbu/hMs3+kOF8xK/WgBTLRW9JGk+6wsJXggXJIMn8TcvXz9foyksnilY7iIcoDxC
         vtcQ==
X-Gm-Message-State: AOAM533/7ywMcqOXHJM3tK/ET2ec6ZSe0wBrh6WqqhAWbHSFiREHiJhL
        HeCdi5bxxwlxMX/+R7bk0gK9i+cu+Jingg81
X-Google-Smtp-Source: ABdhPJzPa6D8Oj0DGHQpbGo/Nd6jmKssmKSSxIizvKeQHyQFPIOBu+V2Rb2UI6sGoWh+Iu40sCXBrQ==
X-Received: by 2002:a05:6e02:1a01:: with SMTP id s1mr61885712ild.50.1638224734044;
        Mon, 29 Nov 2021 14:25:34 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x18sm9582023iow.53.2021.11.29.14.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:25:33 -0800 (PST)
Date:   Mon, 29 Nov 2021 17:25:33 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com, peff@peff.net,
        tytso@mit.edu
Subject: [PATCH 12/17] builtin/repack.c: support generating a cruft pack
Message-ID: <a05675ab834ac5e8bc3ab72847b0621a563e0e1b.1638224692.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1638224692.git.me@ttaylorr.com>
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
 builtin/repack.c                        | 112 ++++++++++++++++-
 t/t5327-pack-objects-cruft.sh           | 153 ++++++++++++++++++++++++
 4 files changed, 272 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 7183fb498f..4f8f4b5a1f 100644
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
index bb54cce1b1..b7daad2e3e 100644
--- a/Documentation/technical/cruft-packs.txt
+++ b/Documentation/technical/cruft-packs.txt
@@ -16,7 +16,7 @@ pruned according to normal expiry rules with the next 'git gc' invocation.
 
 Unreachable objects aren't removed immediately, since doing so could race with
 an incoming push which may reference an object which is about to be deleted.
-Instead, those unreachable objects are stored as loose object and stay that way
+Instead, those unreachable objects are stored as loose objects and stay that way
 until they are older than the expiration window, at which point they are removed
 by linkgit:git-prune[1].
 
diff --git a/builtin/repack.c b/builtin/repack.c
index acbb7b8c3b..68b4bdf06f 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -18,11 +18,17 @@
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
 static char *packdir, *packtmp_name, *packtmp;
+static char *cruft_expiration;
 
 static const char *const git_repack_usage[] = {
 	N_("git repack [<options>]"),
@@ -54,6 +60,7 @@ static int repack_config(const char *var, const char *value, void *cb)
 		use_delta_islands = git_config_bool(var, value);
 		return 0;
 	}
+
 	return git_default_config(var, value, cb);
 }
 
@@ -298,9 +305,6 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 		die(_("could not finish pack-objects to repack promisor objects"));
 }
 
-#define ALL_INTO_ONE 1
-#define LOOSEN_UNREACHABLE 2
-
 struct pack_geometry {
 	struct packed_git **pack;
 	uint32_t pack_nr, pack_alloc;
@@ -337,6 +341,8 @@ static void init_pack_geometry(struct pack_geometry **geometry_p)
 	for (p = get_all_packs(the_repository); p; p = p->next) {
 		if (!pack_kept_objects && p->pack_keep)
 			continue;
+		if (p->is_cruft)
+			continue;
 
 		ALLOC_GROW(geometry->pack,
 			   geometry->pack_nr + 1,
@@ -598,6 +604,67 @@ static int write_midx_included_packs(struct string_list *include,
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
@@ -614,7 +681,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	int show_progress = isatty(2);
 
 	/* variables to be filled by option parsing */
-	int pack_everything = 0;
 	int delete_redundant = 0;
 	const char *unpack_unreachable = NULL;
 	int keep_unreachable = 0;
@@ -630,6 +696,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		OPT_BIT('A', NULL, &pack_everything,
 				N_("same as -a, and turn unreachable objects loose"),
 				   LOOSEN_UNREACHABLE | ALL_INTO_ONE),
+		OPT_BIT(0, "cruft", &pack_everything,
+				N_("same as -a, pack unreachable cruft objects separately"),
+				   PACK_CRUFT | ALL_INTO_ONE),
+		OPT_STRING(0, "cruft-expiration", &cruft_expiration, N_("approxidate"),
+				N_("with -C, expire objects older than this")),
 		OPT_BOOL('d', NULL, &delete_redundant,
 				N_("remove redundant packs, and run git-prune-packed")),
 		OPT_BOOL('f', NULL, &po_args.no_reuse_delta,
@@ -681,6 +752,14 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (keep_unreachable &&
 	    (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE)))
 		die(_("--keep-unreachable and -A are incompatible"));
+	if (pack_everything & PACK_CRUFT && delete_redundant) {
+		if (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE))
+			die(_("--cruft and -A are incompatible"));
+		if (keep_unreachable)
+			die(_("--cruft and -k are incompatible"));
+		if (!(pack_everything & ALL_INTO_ONE))
+			die(_("--cruft must be combined with all-into-one"));
+	}
 
 	if (write_bitmaps < 0) {
 		if (!write_midx &&
@@ -763,7 +842,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (pack_everything & ALL_INTO_ONE) {
 		repack_promisor_objects(&po_args, &names);
 
-		if (existing_nonkept_packs.nr && delete_redundant) {
+		if (existing_nonkept_packs.nr && delete_redundant &&
+		    !(pack_everything & PACK_CRUFT)) {
 			for_each_string_list_item(item, &names) {
 				strvec_pushf(&cmd.args, "--keep-pack=%s-%s.pack",
 					     packtmp_name, item->string);
@@ -798,6 +878,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		return ret;
 
 	if (geometry) {
+		struct packed_git *p;
 		FILE *in = xfdopen(cmd.in, "w");
 		/*
 		 * The resulting pack should contain all objects in packs that
@@ -808,6 +889,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			fprintf(in, "%s\n", pack_basename(geometry->pack[i]));
 		for (i = geometry->split; i < geometry->pack_nr; i++)
 			fprintf(in, "^%s\n", pack_basename(geometry->pack[i]));
+
+		for (p = get_all_packs(the_repository); p; p = p->next) {
+			if (!p->is_cruft)
+				continue;
+			fprintf(in, "^%s\n", pack_basename(p));
+		}
 		fclose(in);
 	}
 
@@ -825,6 +912,21 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
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
diff --git a/t/t5327-pack-objects-cruft.sh b/t/t5327-pack-objects-cruft.sh
index 31d4a561fe..ed1a113ab6 100755
--- a/t/t5327-pack-objects-cruft.sh
+++ b/t/t5327-pack-objects-cruft.sh
@@ -358,4 +358,157 @@ test_expect_success 'expired objects are pruned' '
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
+		rm -fr .git/logs &&
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
+		path="$objdir/$(test_oid_to_path "$(git rev-parse cruft)")" &&
+		test-tool chmtime --get +1000 "$path" >expect &&
+
+		git checkout main &&
+		git branch -D other &&
+		git tag -d cruft &&
+		rm -fr .git/logs &&
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
+		rm -fr .git/logs &&
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
+		rm -fr .git/logs &&
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
2.34.1.25.gb3157a20e6

