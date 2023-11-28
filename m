Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="XnNqJjCj"
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF6C1733
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:15 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-77dc404d926so40329785a.2
        for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701198494; x=1701803294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EX8bDPgtUd9ApCe6VVDMhUFO7Vc2E735OK+M34xcrFw=;
        b=XnNqJjCj0cNFZwyJrS28rAfuJmSL624QDMfytSj04OTOoiCNbeXqDwsX0HXA3BSfqZ
         kiiiNtsFD629j9MYZ9ERAqQWhzs1MiJIxwFhTaJAdnWJKawieg+t5/Zxi57mhLIEoxhy
         fvhIH5nww0RB0IiZlFh5+4J35X3KhgUvseMZx8TFLhsTkBCCahAHK9DMyT0HZraNoN96
         +tIMiamTsqfUdM8ZgnfDoeNu6yrGgojqAKGlgnMHHqAn79G/lzwGOCQ7rs43fXH88bei
         MnBh1k0xlshiA7Fp9ItKgISywW2spzY/uU8S4o3uCKYjsm94/sdrHKrDdhYH7JScQmYT
         ZFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198494; x=1701803294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EX8bDPgtUd9ApCe6VVDMhUFO7Vc2E735OK+M34xcrFw=;
        b=XGzXvwbMfOyAtyPwPMOqBXBEtnz4axQ27WHh2z2cZwTEFauHdDvnMF7uzB4+fpCvh8
         T0MWTIAZRiJOte8tSU4EaIRJ1DbV6lFh2rlxYtSQxLtZya7C8PP7U3HnP4GsBDe64Ms5
         oQ1PSNvSAiqAsr4L75V3lUrHdWlurBhkPW+Slna/EGCT6RzWiVu0palttbShQptN69Oj
         WHPNaC3hyowhsiepQK9g12C0LIGARImu+FD1vWMyzpZqoThorRtWV63PP+hFnwYrcnN/
         H0Nko40ukXbVqgrsIYNaGXsTNKIE5fCEnmW41x4vZEgfOUqpAOzzOl3lkbYBsLLiVKYe
         r0Qg==
X-Gm-Message-State: AOJu0Yx8liD10RHY0wqNQjpO9yLzXMSUUkrDgkDDpQE5SU55HTsXGMJy
	uHkM2ppnKO1LAaeeSsh6Xlj+ycCJnJsWAf5+7Sg=
X-Google-Smtp-Source: AGHT+IHajgjVZCVwr941lGjjnUvUmlyMpYvVwBORCUNvSvfL/84ma088on1D16qLi0WCrVrRqnY+Xw==
X-Received: by 2002:a05:620a:a4e:b0:76e:ef17:d37e with SMTP id j14-20020a05620a0a4e00b0076eef17d37emr16183541qka.71.1701198494490;
        Tue, 28 Nov 2023 11:08:14 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f12-20020a05620a15ac00b0077dc395df88sm472205qkk.32.2023.11.28.11.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 11:08:14 -0800 (PST)
Date: Tue, 28 Nov 2023 14:08:13 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 07/24] midx: implement `--retain-disjoint` mode
Message-ID: <3019738b52ba8cd78ea696a3b800fa91e722eb66.1701198172.git.me@ttaylorr.com>
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

Once multi-pack reachability bitmaps learn how to perform pack reuse
over the set of disjoint packs, we will want to teach `git repack` to
evolve the set of disjoint packs over time.

To evolve the set of disjoint packs means any new packs made by `repack`
should be disjoint with respect to the existing set of disjoint packs so
as to be able to join that set when updating the multi-pack index.

The details of generating such packs will be left to future commits. But
any new pack(s) created by repack as disjoint will be marked as such by
passing them over `--stdin-packs` with the special '+' marker when
generating a new MIDX.

This patch, however, addresses the question of how we retain the
existing set of disjoint packs when updating the multi-pack index. One
option would be for `repack` to keep track of the set of disjoint packs
itself by querying the MIDX, and then adding the special '+' marker
appropriately when generating the input for `--stdin-packs`.

But this is verbose and error-prone, since two different parts of Git
would need to maintain the same notion of the set of disjoint packs.
When one disagrees with the other, the set of so-called disjoint packs
may actually contain two or more packs which have one or more object(s)
in common, making the set non-disjoint.

Instead, introduce a `--retain-disjoint` mode for the `git
multi-pack-index write` sub-command which keeps any packs which are:

  - marked as disjoint in the existing MIDX, and

  - not deleted (e.g., they are not excluded from the input for
    `--stdin-packs`).

This will allow the `repack` command to not have to keep track of the
set of currently-disjoint packs itself, reducing the number of lines of
code necessary to implement this feature, and making the resulting
implementation less error-prone.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.txt |  8 +++
 builtin/multi-pack-index.c             |  3 +
 midx.c                                 | 49 +++++++++++++++
 midx.h                                 |  1 +
 t/lib-disjoint.sh                      | 38 ++++++++++++
 t/t5319-multi-pack-index.sh            | 82 ++++++++++++++++++++++++++
 6 files changed, 181 insertions(+)
 create mode 100644 t/lib-disjoint.sh

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index d130e65b28..ac0c7b124b 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -54,6 +54,14 @@ write::
 		"disjoint". See the "`DISP` chunk and disjoint packs"
 		section in linkgit:gitformat-pack[5] for more.
 
+	--retain-disjoint::
+		When writing a multi-pack index with a reachability
+		bitmap, keep any packs marked as disjoint in the
+		existing MIDX (if any) as such in the new MIDX. Existing
+		disjoint packs which are removed (e.g., not listed via
+		`--stdin-packs`) are ignored. This option works in
+		addition to the '+' marker for `--stdin-packs`.
+
 	--refs-snapshot=<path>::
 		With `--bitmap`, optionally specify a file which
 		contains a "refs snapshot" taken prior to repacking.
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 0f1dd4651d..dcfabf2626 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -138,6 +138,9 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 			 N_("write multi-pack index containing only given indexes")),
 		OPT_FILENAME(0, "refs-snapshot", &opts.refs_snapshot,
 			     N_("refs snapshot for selecting bitmap commits")),
+		OPT_BIT(0, "retain-disjoint", &opts.flags,
+			N_("retain non-deleted disjoint packs"),
+			MIDX_WRITE_RETAIN_DISJOINT),
 		OPT_END(),
 	};
 
diff --git a/midx.c b/midx.c
index 65ba0c70fe..ce67da9f85 100644
--- a/midx.c
+++ b/midx.c
@@ -721,6 +721,12 @@ static void midx_fanout_add_midx_fanout(struct midx_fanout *fanout,
 					   &fanout->entries[fanout->nr],
 					   cur_object);
 		fanout->entries[fanout->nr].preferred = 0;
+		/*
+		 * It's OK to set disjoint to 0 here, even with
+		 * `--retain-disjoint`, since we will always see the disjoint
+		 * copy of some object below in get_sorted_entries(), causing us
+		 * to die().
+		 */
 		fanout->entries[fanout->nr].disjoint = 0;
 		fanout->nr++;
 	}
@@ -1362,6 +1368,37 @@ static struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
 	return result;
 }
 
+static int midx_retain_existing_disjoint(struct repository *r,
+					 struct multi_pack_index *from,
+					 struct write_midx_context *ctx)
+{
+	struct bitmapped_pack bp;
+	uint32_t i, midx_pos;
+
+	for (i = 0; i < ctx->nr; i++) {
+		struct pack_info *info = &ctx->info[i];
+		/*
+		 * Having to call `midx_locate_pack()` in a loop is
+		 * sub-optimal, since it is O(n*log(n)) in the number
+		 * of packs.
+		 *
+		 * When reusing an existing MIDX, we know that the first
+		 * 'n' packs appear in the same order, so we could avoid
+		 * this when reusing an existing MIDX. But we may be
+		 * instead relying on the order given to us by
+		 * for_each_file_in_pack_dir(), in which case we can't
+		 * make any such guarantees.
+		 */
+		if (!midx_locate_pack(from, info->pack_name, &midx_pos))
+			continue;
+
+		if (nth_bitmapped_pack(r, from, &bp, midx_pos) < 0)
+			return -1;
+		info->disjoint = bp.disjoint;
+	}
+	return 0;
+}
+
 static int write_midx_internal(const char *object_dir,
 			       struct string_list *packs_to_include,
 			       struct string_list *packs_to_drop,
@@ -1444,6 +1481,18 @@ static int write_midx_internal(const char *object_dir,
 	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &ctx);
 	stop_progress(&ctx.progress);
 
+	if (flags & MIDX_WRITE_RETAIN_DISJOINT) {
+		struct multi_pack_index *m = ctx.m;
+		if (!m)
+			m = lookup_multi_pack_index(the_repository, object_dir);
+
+		if (m) {
+			result = midx_retain_existing_disjoint(the_repository, m, &ctx);
+			if (result)
+				goto cleanup;
+		}
+	}
+
 	if ((ctx.m && ctx.nr == ctx.m->num_packs) &&
 	    !(packs_to_include || packs_to_drop)) {
 		struct bitmap_index *bitmap_git;
diff --git a/midx.h b/midx.h
index a6e969c2ea..d7ce52ff7b 100644
--- a/midx.h
+++ b/midx.h
@@ -54,6 +54,7 @@ struct multi_pack_index {
 #define MIDX_WRITE_BITMAP (1 << 2)
 #define MIDX_WRITE_BITMAP_HASH_CACHE (1 << 3)
 #define MIDX_WRITE_BITMAP_LOOKUP_TABLE (1 << 4)
+#define MIDX_WRITE_RETAIN_DISJOINT (1 << 5)
 
 const unsigned char *get_midx_checksum(struct multi_pack_index *m);
 void get_midx_filename(struct strbuf *out, const char *object_dir);
diff --git a/t/lib-disjoint.sh b/t/lib-disjoint.sh
new file mode 100644
index 0000000000..c6c6e74aba
--- /dev/null
+++ b/t/lib-disjoint.sh
@@ -0,0 +1,38 @@
+# Helpers for scripts testing disjoint packs; see t5319 for example usage.
+
+objdir=.git/objects
+
+test_disjoint_1 () {
+	local pack="$1"
+	local want="$2"
+
+	test-tool read-midx --bitmap $objdir >out &&
+	grep -A 3 "$pack" out >found &&
+
+	if ! test -s found
+	then
+		echo >&2 "could not find '$pack' in MIDX"
+		return 1
+	fi
+
+	if ! grep -q "disjoint: $want" found
+	then
+		echo >&2 "incorrect disjoint state for pack '$pack'"
+		return 1
+	fi
+	return 0
+}
+
+# test_must_be_disjoint <pack-$XYZ.pack>
+#
+# Ensures that the given pack is marked as disjoint.
+test_must_be_disjoint () {
+	test_disjoint_1 "$1" "yes"
+}
+
+# test_must_not_be_disjoint <pack-$XYZ.pack>
+#
+# Ensures that the given pack is not marked as disjoint.
+test_must_not_be_disjoint () {
+	test_disjoint_1 "$1" "no"
+}
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index fd24e0c952..02cfddf151 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -3,6 +3,7 @@
 test_description='multi-pack-indexes'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-chunk.sh
+. "$TEST_DIRECTORY"/lib-disjoint.sh
 
 GIT_TEST_MULTI_PACK_INDEX=0
 objdir=.git/objects
@@ -1215,4 +1216,85 @@ test_expect_success 'non-disjoint packs are detected' '
 	)
 '
 
+test_expect_success 'retain disjoint packs while writing' '
+	test_when_finished "rm -fr repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		for i in 1 2
+		do
+			test_commit "$i" && git repack -d || return 1
+		done &&
+
+		find $objdir/pack -type f -name "pack-*.idx" |
+		sed -e "s/^.*\/\(.*\)/\1/g" | sort >packs.old &&
+
+		test_line_count = 2 packs.old &&
+		disjoint="$(head -n 1 packs.old)" &&
+		non_disjoint="$(tail -n 1 packs.old)" &&
+
+		cat >in <<-EOF &&
+		+$disjoint
+		$non_disjoint
+		EOF
+		git multi-pack-index write --stdin-packs --bitmap <in &&
+
+		test_must_be_disjoint "${disjoint%.idx}.pack" &&
+		test_must_not_be_disjoint "${non_disjoint%.idx}.pack" &&
+
+		test_commit 3 &&
+		git repack -d &&
+
+		find $objdir/pack -type f -name "pack-*.idx" |
+		sed -e "s/^.*\/\(.*\)/\1/g" | sort >packs.new &&
+
+		new_disjoint="$(comm -13 packs.old packs.new)" &&
+		cat >in <<-EOF &&
+		$disjoint
+		$non_disjoint
+		+$new_disjoint
+		EOF
+		git multi-pack-index write --stdin-packs --bitmap \
+			--retain-disjoint <in &&
+
+		test_must_be_disjoint "${disjoint%.idx}.pack" &&
+		test_must_be_disjoint "${new_disjoint%.idx}.pack" &&
+		test_must_not_be_disjoint "${non_disjoint%.idx}.pack"
+
+	)
+'
+
+test_expect_success 'non-disjoint packs are detected via --retain-disjoint' '
+	test_when_finished "rm -fr repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		packdir=.git/objects/pack &&
+
+		test_commit base &&
+		base="$(echo base | git pack-objects --revs $packdir/pack)" &&
+
+		cat >in <<-EOF &&
+		+pack-$base.idx
+		EOF
+		git multi-pack-index write --stdin-packs --bitmap <in &&
+
+		test_must_be_disjoint "pack-$base.pack" &&
+
+		test_commit other &&
+		other="$(echo other | git pack-objects --revs $packdir/pack)" &&
+
+		cat >in <<-EOF &&
+		pack-$base.idx
+		+pack-$other.idx
+		EOF
+		test_must_fail git multi-pack-index write --stdin-packs --retain-disjoint --bitmap <in 2>err &&
+		grep "duplicate object.* among disjoint packs" err &&
+
+		test_must_fail git multi-pack-index write --retain-disjoint --bitmap 2>err &&
+		grep "duplicate object.* among disjoint packs" err
+	)
+'
+
 test_done
-- 
2.43.0.24.g980b318f98

