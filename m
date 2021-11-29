Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3083BC433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhK2W3k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhK2W24 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:28:56 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD421C09676F
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:25:24 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id e8so19081155ilu.9
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lDsFe1jBg/drSQVHnwBdv3PUnKButsbHCmsHsdEdiYY=;
        b=uPPEYTFG85cmOw+Z+mVFxWhKcFoJVsk+HeIeK2QyBDWvewpyG475lIJThZBiqQQgq0
         PQGv8auzKOucoz7CTecBzmM7PU8B3PCbVDB8VGuFFYySMQ+T3evTQqFTrYg74DCEEqbl
         +rPSK+rd6kAiUFguQReHpWQ0RUhIH0gVnY8vcxmppr4o4bKT877VogEla6ltTkM9KbtZ
         HRtSYMnz3gxxlAPItiNCAQcUiixJ9BEVmmQOqt1Fp7YbS8fLQmutrHKVyJ8MfCWnHi0s
         8qbjcy0q+bYxq6ipwfV9VQGO76s/pBmBPlooTIRTa5xIGo2vVDzT0f5leBoOSkUwu/Cq
         orTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lDsFe1jBg/drSQVHnwBdv3PUnKButsbHCmsHsdEdiYY=;
        b=P8eKN7vDqE36V6bBLBR1FMePC5JOvpmol/aTr9IbLiqhU4Clvwuh4OXfEZPQZZWBWi
         v+672+qhtUZZ4enlEJqXM3/JTQYHBI3uDSSvb71RI+CJTYLwrpr4Ux5f9TR7QgzdBdIG
         UnoHdEw1tZGt4QcC3lerjxct8Ds3cxVGR0jBShyWzeG5oLLPBd6iscs33wEcrBedPZpA
         vn6XkNkC7u+yFmRHaQuSx2VhN3MZEL81J9Ag3zqdUcDOqokb4lK/dbPrkEk53ZCSMnIf
         OP66DN6v7RJdXhg9j/66UpVzJPvmdXNCbY6Zf7IlCByDvWbbIMTr7F685uwD59up854w
         i1hA==
X-Gm-Message-State: AOAM531l3ZU+fbcCLvOpao4Qv4XqifL9bNZDnTXH+GOL63UHoGZpVQiG
        H8c5UoaURjRlfYNVKAr9o/PveUI1kPVJOmI1
X-Google-Smtp-Source: ABdhPJxuRZ2TBP38R4O2jw0SCIYIg14B69EucRAeY69qggoLtmcx8tdP/gHDsqhlMUFyhPRA32HiPA==
X-Received: by 2002:a92:2811:: with SMTP id l17mr14527321ilf.149.1638224723869;
        Mon, 29 Nov 2021 14:25:23 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g7sm7469205iln.67.2021.11.29.14.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:25:23 -0800 (PST)
Date:   Mon, 29 Nov 2021 17:25:22 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com, peff@peff.net,
        tytso@mit.edu
Subject: [PATCH 08/17] builtin/pack-objects.c: --cruft without expiration
Message-ID: <66165917a4660f63ce60b820d178d52a51304d20.1638224692.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1638224692.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach `pack-objects` how to generate a cruft pack when no objects are
dropped (i.e., `--cruft-expiration=never`). Later patches will teach
`pack-objects` how to generate a cruft pack that prunes objects.

When generating a cruft pack which does not prune objects, we want to
collect all unreachable objects into a single pack (noting and updating
their mtimes as we accumulate them). Ordinary use will pass the result
of a `git repack -A` as a kept pack, so when this patch says "kept
pack", readers should think "reachable objects".

Generating a non-expiring cruft packs works as follows:

  - Callers provide a list of every pack they know about, and indicate
    which packs are about to be removed.

  - All packs which are going to be removed (we'll call these the
    redundant ones) are marked as kept in-core, as well as any packs
    that `pack-objects` found but the caller did not specify.

    These packs are presumed to have entered the repository between
    the caller collecting packs and invoking `pack-objects`. Since we
    do not want to include objects in these packs (because we don't know
    which of their objects are or aren't reachable), these are also
    marked as kept in-core.

  - Then, we enumerate all objects in the repository, and add them to
    our packing list if they do not appear in an in-core kept pack.

This results in a new cruft pack which contains all known objects that
aren't included in the kept packs. When the kept pack is the result of
`git repack -A`, the resulting pack contains all unreachable objects.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-pack-objects.txt |  23 +++
 builtin/pack-objects.c             | 203 ++++++++++++++++++++++++++-
 object-file.c                      |   2 +-
 object-store.h                     |   2 +
 t/t5327-pack-objects-cruft.sh      | 218 +++++++++++++++++++++++++++++
 5 files changed, 442 insertions(+), 6 deletions(-)
 create mode 100755 t/t5327-pack-objects-cruft.sh

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index dbfd1f9017..573c18afcd 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 	[--no-reuse-delta] [--delta-base-offset] [--non-empty]
 	[--local] [--incremental] [--window=<n>] [--depth=<n>]
 	[--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
+	[--cruft] [--cruft-expiration=<time>]
 	[--stdout [--filter=<filter-spec>] | base-name]
 	[--shallow] [--keep-true-parents] [--[no-]sparse] < object-list
 
@@ -95,6 +96,28 @@ base-name::
 Incompatible with `--revs`, or options that imply `--revs` (such as
 `--all`), with the exception of `--unpacked`, which is compatible.
 
+--cruft::
+	Packs unreachable objects into a separate "cruft" pack, denoted
+	by the existence of a `.mtimes` file. Pack names provided over
+	stdin indicate which packs will remain after a `git repack`.
+	Pack names prefixed with a `-` indicate those which will be
+	removed. The contents of the cruft pack are all objects not
+	contained in the surviving packs specified by `--keep-pack`)
+	which have not exceeded the grace period (see
+	`--cruft-expiration` below), or which have exceeded the grace
+	period, but are reachable from an other object which hasn't.
++
+Incompatible with `--unpack-unreachable`, `--keep-unreachable`,
+`--pack-loose-unreachable`, `--stdin-packs`, as well as any other
+options which imply `--revs`. Also incompatible with `--max-pack-size`;
+when this option is set, the maximum pack size is not inferred from
+`pack.packSizeLimit`.
+
+--cruft-expiration=<approxidate>::
+	If specified, objects are eliminated from the cruft pack if they
+	have an mtime older than `<approxidate>`. If unspecified (and
+	given `--cruft`), then no objects are eliminated.
+
 --window=<n>::
 --depth=<n>::
 	These two options affect how the objects contained in
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3fb10529ba..b12e79e4b1 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -36,6 +36,7 @@
 #include "trace2.h"
 #include "shallow.h"
 #include "promisor-remote.h"
+#include "pack-mtimes.h"
 
 /*
  * Objects we are going to pack are collected in the `to_pack` structure.
@@ -194,6 +195,8 @@ static int reuse_delta = 1, reuse_object = 1;
 static int keep_unreachable, unpack_unreachable, include_tag;
 static timestamp_t unpack_unreachable_expiration;
 static int pack_loose_unreachable;
+static int cruft;
+static timestamp_t cruft_expiration;
 static int local;
 static int have_non_local_packs;
 static int incremental;
@@ -1252,6 +1255,9 @@ static void write_pack_file(void)
 					&to_pack, written_list, nr_written);
 			}
 
+			if (cruft)
+				pack_idx_opts.flags |= WRITE_MTIMES;
+
 			stage_tmp_packfiles(&tmpname, pack_tmp_name,
 					    written_list, nr_written,
 					    &to_pack, &pack_idx_opts, hash,
@@ -3389,6 +3395,135 @@ static void read_packs_list_from_stdin(void)
 	string_list_clear(&exclude_packs, 0);
 }
 
+static int add_cruft_object_entry(const struct object_id *oid, enum object_type type,
+				  struct packed_git *pack, off_t offset,
+				  const char *name, uint32_t mtime)
+{
+	struct object_entry *entry;
+
+	display_progress(progress_state, ++nr_seen);
+
+	entry = packlist_find(&to_pack, oid);
+	if (entry) {
+		if (name) {
+			entry->hash = pack_name_hash(name);
+			entry->no_try_delta = name && no_try_delta(name);
+		}
+	} else {
+		if (!want_object_in_pack(oid, 0, &pack, &offset))
+			return 0;
+		if (!pack && type == OBJ_BLOB && !has_loose_object(oid)) {
+			/*
+			 * If a traversed tree has a missing blob then we want
+			 * to avoid adding that missing object to our pack.
+			 *
+			 * This only applies to missing blobs, not trees,
+			 * because the traversal needs to parse sub-trees but
+			 * not blobs.
+			 *
+			 * Note we only perform this check when we couldn't
+			 * already find the object in a pack, so we're really
+			 * limited to "ensure non-tip blobs which don't exist in
+			 * packs do exist via loose objects". Confused?
+			 */
+			return 0;
+		}
+
+		entry = create_object_entry(oid, type, pack_name_hash(name),
+					    0, name && no_try_delta(name),
+					    pack, offset);
+	}
+
+	if (mtime > oe_cruft_mtime(&to_pack, entry))
+		oe_set_cruft_mtime(&to_pack, entry, mtime);
+	return 1;
+}
+
+static void mark_pack_kept_in_core(struct string_list *packs, unsigned keep)
+{
+	struct string_list_item *item = NULL;
+	for_each_string_list_item(item, packs) {
+		struct packed_git *p = item->util;
+		if (!p)
+			die(_("could not find pack '%s'"), item->string);
+		p->pack_keep_in_core = keep;
+	}
+}
+
+static void add_unreachable_loose_objects(void);
+static void add_objects_in_unpacked_packs(void);
+
+static void enumerate_cruft_objects(void)
+{
+	if (progress)
+		progress_state = start_progress(_("Enumerating cruft objects"), 0);
+
+	add_objects_in_unpacked_packs();
+	add_unreachable_loose_objects();
+
+	stop_progress(&progress_state);
+}
+
+static void read_cruft_objects(void)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct string_list discard_packs = STRING_LIST_INIT_DUP;
+	struct string_list fresh_packs = STRING_LIST_INIT_DUP;
+	struct packed_git *p;
+
+	ignore_packed_keep_in_core = 1;
+
+	while (strbuf_getline(&buf, stdin) != EOF) {
+		if (!buf.len)
+			continue;
+
+		if (*buf.buf == '-')
+			string_list_append(&discard_packs, buf.buf + 1);
+		else
+			string_list_append(&fresh_packs, buf.buf);
+		strbuf_reset(&buf);
+	}
+
+	string_list_sort(&discard_packs);
+	string_list_sort(&fresh_packs);
+
+	for (p = get_all_packs(the_repository); p; p = p->next) {
+		const char *pack_name = pack_basename(p);
+		struct string_list_item *item;
+
+		item = string_list_lookup(&fresh_packs, pack_name);
+		if (!item)
+			item = string_list_lookup(&discard_packs, pack_name);
+
+		if (item) {
+			item->util = p;
+		} else {
+			/*
+			 * This pack wasn't mentioned in either the "fresh" or
+			 * "discard" list, so the caller didn't know about it.
+			 *
+			 * Mark it as kept so that its objects are ignored by
+			 * add_unseen_recent_objects_to_traversal(). We'll
+			 * unmark it before starting the traversal so it doesn't
+			 * halt the traversal early.
+			 */
+			p->pack_keep_in_core = 1;
+		}
+	}
+
+	mark_pack_kept_in_core(&fresh_packs, 1);
+	mark_pack_kept_in_core(&discard_packs, 0);
+
+	if (cruft_expiration)
+		die("--cruft-expiration not yet implemented");
+	else
+		enumerate_cruft_objects();
+
+	strbuf_release(&buf);
+	string_list_clear(&discard_packs, 0);
+	string_list_clear(&fresh_packs, 0);
+}
+
 static void read_object_list_from_stdin(void)
 {
 	char line[GIT_MAX_HEXSZ + 1 + PATH_MAX + 2];
@@ -3521,7 +3656,24 @@ static int add_object_in_unpacked_pack(const struct object_id *oid,
 				       uint32_t pos,
 				       void *_data)
 {
-	add_object_entry(oid, OBJ_NONE, "", 0);
+	if (cruft) {
+		off_t offset;
+		time_t mtime;
+
+		if (pack->is_cruft) {
+			if (load_pack_mtimes(pack) < 0)
+				die(_("could not load cruft pack .mtimes"));
+			mtime = nth_packed_mtime(pack, pos);
+		} else {
+			mtime = pack->mtime;
+		}
+		offset = nth_packed_object_offset(pack, pos);
+
+		add_cruft_object_entry(oid, OBJ_NONE, pack, offset,
+				       NULL, mtime);
+	} else {
+		add_object_entry(oid, OBJ_NONE, "", 0);
+	}
 	return 0;
 }
 
@@ -3545,7 +3697,19 @@ static int add_loose_object(const struct object_id *oid, const char *path,
 		return 0;
 	}
 
-	add_object_entry(oid, type, "", 0);
+	if (cruft) {
+		struct stat st;
+		if (stat(path, &st) < 0) {
+			if (errno == ENOENT)
+				return 0;
+			return error_errno("unable to stat %s", oid_to_hex(oid));
+		}
+
+		add_cruft_object_entry(oid, type, NULL, 0, NULL,
+				       st.st_mtime);
+	} else {
+		add_object_entry(oid, type, "", 0);
+	}
 	return 0;
 }
 
@@ -3864,6 +4028,20 @@ static int option_parse_unpack_unreachable(const struct option *opt,
 	return 0;
 }
 
+static int option_parse_cruft_expiration(const struct option *opt,
+					 const char *arg, int unset)
+{
+	if (unset) {
+		cruft = 0;
+		cruft_expiration = 0;
+	} else {
+		cruft = 1;
+		if (arg)
+			cruft_expiration = approxidate(arg);
+	}
+	return 0;
+}
+
 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 {
 	int use_internal_rev_list = 0;
@@ -3936,6 +4114,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK_F(0, "unpack-unreachable", NULL, N_("time"),
 		  N_("unpack unreachable objects newer than <time>"),
 		  PARSE_OPT_OPTARG, option_parse_unpack_unreachable),
+		OPT_BOOL(0, "cruft", &cruft, N_("create a cruft pack")),
+		OPT_CALLBACK_F(0, "cruft-expiration", NULL, N_("time"),
+		  N_("expire cruft objects older than <time>"),
+		  PARSE_OPT_OPTARG, option_parse_cruft_expiration),
 		OPT_BOOL(0, "sparse", &sparse,
 			 N_("use the sparse reachability algorithm")),
 		OPT_BOOL(0, "thin", &thin,
@@ -4060,7 +4242,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 
 	if (!HAVE_THREADS && delta_search_threads != 1)
 		warning(_("no threads support, ignoring --threads"));
-	if (!pack_to_stdout && !pack_size_limit)
+	if (!pack_to_stdout && !pack_size_limit && !cruft)
 		pack_size_limit = pack_size_limit_cfg;
 	if (pack_to_stdout && pack_size_limit)
 		die(_("--max-pack-size cannot be used to build a pack for transfer"));
@@ -4087,6 +4269,15 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (stdin_packs && use_internal_rev_list)
 		die(_("cannot use internal rev list with --stdin-packs"));
 
+	if (cruft) {
+		if (use_internal_rev_list)
+			die(_("cannot use internal rev list with --cruft"));
+		if (stdin_packs)
+			die(_("cannot use --stdin-packs with --cruft"));
+		if (pack_size_limit)
+			die(_("cannot use --max-pack-size with --cruft"));
+	}
+
 	/*
 	 * "soft" reasons not to use bitmaps - for on-disk repack by default we want
 	 *
@@ -4143,7 +4334,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			    the_repository);
 	prepare_packing_data(the_repository, &to_pack);
 
-	if (progress)
+	if (progress && !cruft)
 		progress_state = start_progress(_("Enumerating objects"), 0);
 	if (stdin_packs) {
 		/* avoids adding objects in excluded packs */
@@ -4151,7 +4342,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		read_packs_list_from_stdin();
 		if (rev_list_unpacked)
 			add_unreachable_loose_objects();
-	} else if (!use_internal_rev_list)
+	} else if (cruft)
+		read_cruft_objects();
+	else if (!use_internal_rev_list)
 		read_object_list_from_stdin();
 	else {
 		get_object_list(rp.nr, rp.v);
diff --git a/object-file.c b/object-file.c
index c3d866a287..7ddb38b64a 100644
--- a/object-file.c
+++ b/object-file.c
@@ -956,7 +956,7 @@ int has_loose_object_nonlocal(const struct object_id *oid)
 	return check_and_freshen_nonlocal(oid, 0);
 }
 
-static int has_loose_object(const struct object_id *oid)
+int has_loose_object(const struct object_id *oid)
 {
 	return check_and_freshen(oid, 0);
 }
diff --git a/object-store.h b/object-store.h
index d87481f101..a79c1c91ab 100644
--- a/object-store.h
+++ b/object-store.h
@@ -308,6 +308,8 @@ int repo_has_object_file_with_flags(struct repository *r,
  */
 int has_loose_object_nonlocal(const struct object_id *);
 
+int has_loose_object(const struct object_id *);
+
 void assert_oid_type(const struct object_id *oid, enum object_type expect);
 
 /*
diff --git a/t/t5327-pack-objects-cruft.sh b/t/t5327-pack-objects-cruft.sh
new file mode 100755
index 0000000000..543a80e9bf
--- /dev/null
+++ b/t/t5327-pack-objects-cruft.sh
@@ -0,0 +1,218 @@
+#!/bin/sh
+
+test_description='cruft pack related pack-objects tests'
+. ./test-lib.sh
+
+objdir=.git/objects
+packdir=$objdir/pack
+
+basic_cruft_pack_tests () {
+	expire="$1"
+
+	test_expect_success "unreachable loose objects are packed (expire $expire)" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+
+			test_commit base &&
+			git repack -Ad &&
+			test_commit loose &&
+
+			test-tool chmtime +2000 "$objdir/$(test_oid_to_path \
+				$(git rev-parse loose:loose.t))" &&
+			test-tool chmtime +1000 "$objdir/$(test_oid_to_path \
+				$(git rev-parse loose^{tree}))" &&
+
+			(
+				git rev-list --objects --no-object-names base..loose |
+				while read oid
+				do
+					path="$objdir/$(test_oid_to_path "$oid")" &&
+					printf "%s %d\n" "$oid" "$(test-tool chmtime --get "$path")"
+				done |
+				sort -k1
+			) >expect &&
+
+			keep="$(basename "$(ls $packdir/pack-*.pack)")" &&
+			cruft="$(echo $keep | git pack-objects --cruft \
+				--cruft-expiration="$expire" $packdir/pack)" &&
+			test-tool pack-mtimes "pack-$cruft.mtimes" >actual &&
+
+			test_cmp expect actual
+		)
+	'
+
+	test_expect_success "unreachable packed objects are packed (expire $expire)" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+
+			test_commit packed &&
+			git repack -Ad &&
+			test_commit other &&
+
+			git rev-list --objects --no-object-names packed.. >objects &&
+			keep="$(basename "$(ls $packdir/pack-*.pack)")" &&
+			other="$(git pack-objects --delta-base-offset \
+				$packdir/pack <objects)" &&
+			git prune-packed &&
+
+			test-tool chmtime --get -100 "$packdir/pack-$other.pack" >expect &&
+
+			cruft="$(git pack-objects --cruft --cruft-expiration="$expire" $packdir/pack <<-EOF
+			$keep
+			-pack-$other.pack
+			EOF
+			)" &&
+			test-tool pack-mtimes "pack-$cruft.mtimes" >actual.raw &&
+
+			cut -d" " -f2 <actual.raw | sort -u >actual &&
+
+			test_cmp expect actual
+		)
+	'
+
+	test_expect_success "unreachable cruft objects are repacked (expire $expire)" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+
+			test_commit packed &&
+			git repack -Ad &&
+			test_commit other &&
+
+			git rev-list --objects --no-object-names packed.. >objects &&
+			keep="$(basename "$(ls $packdir/pack-*.pack)")" &&
+
+			cruft_a="$(echo $keep | git pack-objects --cruft --cruft-expiration="$expire" $packdir/pack)" &&
+			git prune-packed &&
+			cruft_b="$(git pack-objects --cruft --cruft-expiration="$expire" $packdir/pack <<-EOF
+			$keep
+			-pack-$cruft_a.pack
+			EOF
+			)" &&
+
+			test-tool pack-mtimes "pack-$cruft_a.mtimes" >expect.raw &&
+			test-tool pack-mtimes "pack-$cruft_b.mtimes" >actual.raw &&
+
+			sort <expect.raw >expect &&
+			sort <actual.raw >actual &&
+
+			test_cmp expect actual
+		)
+	'
+
+	test_expect_success "multiple cruft packs (expire $expire)" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+
+			test_commit reachable &&
+			git repack -Ad &&
+			keep="$(basename "$(ls $packdir/pack-*.pack)")" &&
+
+			test_commit cruft &&
+			loose="$objdir/$(test_oid_to_path $(git rev-parse cruft))" &&
+
+			# generate three copies of the cruft object in different
+			# cruft packs, each with a unique mtime:
+			#   - one expired (1000 seconds ago)
+			#   - two non-expired (one 1000 seconds in the future,
+			#     one 1500 seconds in the future)
+			test-tool chmtime =-1000 "$loose" &&
+			git pack-objects --cruft $packdir/pack-A <<-EOF &&
+			$keep
+			EOF
+			test-tool chmtime =+1000 "$loose" &&
+			git pack-objects --cruft $packdir/pack-B <<-EOF &&
+			$keep
+			-$(basename $(ls $packdir/pack-A-*.pack))
+			EOF
+			test-tool chmtime =+1500 "$loose" &&
+			git pack-objects --cruft $packdir/pack-C <<-EOF &&
+			$keep
+			-$(basename $(ls $packdir/pack-A-*.pack))
+			-$(basename $(ls $packdir/pack-B-*.pack))
+			EOF
+
+			# ensure the resulting cruft pack takes the most recent
+			# mtime among all copies
+			cruft="$(git pack-objects --cruft \
+				--cruft-expiration="$expire" \
+				$packdir/pack <<-EOF
+			$keep
+			-$(basename $(ls $packdir/pack-A-*.pack))
+			-$(basename $(ls $packdir/pack-B-*.pack))
+			-$(basename $(ls $packdir/pack-C-*.pack))
+			EOF
+			)" &&
+
+			test-tool pack-mtimes "$(basename $(ls $packdir/pack-C-*.mtimes))" >expect.raw &&
+			test-tool pack-mtimes "pack-$cruft.mtimes" >actual.raw &&
+
+			sort expect.raw >expect &&
+			sort actual.raw >actual &&
+			test_cmp expect actual
+		)
+	'
+
+	test_expect_success "cruft packs tolerate missing trees (expire $expire)" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+
+			test_commit reachable &&
+			test_commit cruft &&
+
+			tree="$(git rev-parse cruft^{tree})" &&
+
+			git reset --hard reachable &&
+			git tag -d cruft &&
+			rm -fr .git/logs &&
+
+			# remove the unreachable tree, but leave the commit
+			# which has it as its root tree in-tact
+			rm -fr "$objdir/$(test_oid_to_path "$tree")" &&
+
+			git repack -Ad &&
+			basename $(ls $packdir/pack-*.pack) >in &&
+			git pack-objects --cruft --cruft-expiration="$expire" \
+				$packdir/pack <in
+		)
+	'
+
+	test_expect_success "cruft packs tolerate missing blobs (expire $expire)" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+
+			test_commit reachable &&
+			test_commit cruft &&
+
+			blob="$(git rev-parse cruft:cruft.t)" &&
+
+			git reset --hard reachable &&
+			git tag -d cruft &&
+			rm -fr .git/logs &&
+
+			# remove the unreachable blob, but leave the commit (and
+			# the root tree of that commit) in-tact
+			rm -fr "$objdir/$(test_oid_to_path "$blob")" &&
+
+			git repack -Ad &&
+			basename $(ls $packdir/pack-*.pack) >in &&
+			git pack-objects --cruft --cruft-expiration="$expire" \
+				$packdir/pack <in
+		)
+	'
+}
+
+basic_cruft_pack_tests never
+
+test_done
-- 
2.34.1.25.gb3157a20e6

