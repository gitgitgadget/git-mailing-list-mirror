Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="dXQRAjS1"
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EE910FB
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:18 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-67a42549764so14889936d6.1
        for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701198497; x=1701803297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4IxPIRJ5+f4FdzHV3JPmJVntgL2kpL2TSGZ7bDzH3iY=;
        b=dXQRAjS196hWaueofLs3CRaZwF+JVbguAFCTVAhhGQKZgRO5FFA3wZc7p3/7/+cGjV
         C6LMZUCS1k6FyaPqNSS+5NtpqTN9clb0j2K67+bnGlOzUNQ+7ZLugQoDfjb//idxN3XY
         mNPYWnaa49MomioNxk7/SO/IQGZrS4X3OP0FMoviwmkQva/vij5bBZA+knb1jfaq0X8O
         UBrvPZAxPxeF5Wx3jEMYeJQgiPpSUIXjVy4ueWJbPrHsymtcjz+0silu6euMYt5hr7kl
         WHTNQfyqNmXeHq/jUuF0LmTOG9wi96pVj0GbAEUbuR749HQMcmY0KfYB8i0eFw7CagB+
         ynrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198497; x=1701803297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IxPIRJ5+f4FdzHV3JPmJVntgL2kpL2TSGZ7bDzH3iY=;
        b=MLaquVk2OQ4fCPdp8RamumWOBN+yRRydQH2MX7d3YlzxZylEaz5HPofEDJ+DvbqCq2
         ce6WNxlsTzHZ4D+oo9fy5NaMyKBLLyGWnP9qa4WQZLJiRMebTCawTxqpnbfmA3QsnyNq
         0r1hQYLJtLH/momutwyR4HsDKDqLHdKzklDdE6MHVu3aZwI33LlVbxCidRlwOdiu7v05
         Od0l0otZu8VKIiouDt+K5WL4PDcl/zRfL6qfA1h6+kS0uMzqD2t+eK22Zy6ywJq8L215
         N1i34sSpcJOnaMlBkDK/nEoNro9jtos9u642X+P+UgyF1yo5gFfhBQEcFBBI9j4s0qe4
         j1bg==
X-Gm-Message-State: AOJu0YyJod9m1aZYYIEQwd7sjWWUjtlDKTxweX/RaA1BnfyiPGO6l3YQ
	jcMishJv7jfbCYw3nawF4H0IJuzsVnwo8eHlUow=
X-Google-Smtp-Source: AGHT+IE9PFFszQ0tdmoya3hoLm/zpF+WKxo1hcUIZw8EoUWuQ1JySZ2PdrjQ/FY7z5g6HooqZbiTKw==
X-Received: by 2002:a0c:e950:0:b0:67a:35f5:bdea with SMTP id n16-20020a0ce950000000b0067a35f5bdeamr10814242qvo.43.1701198497172;
        Tue, 28 Nov 2023 11:08:17 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h17-20020a0cedb1000000b0067a3ad49979sm2562517qvr.96.2023.11.28.11.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 11:08:16 -0800 (PST)
Date: Tue, 28 Nov 2023 14:08:16 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 08/24] pack-objects: implement `--ignore-disjoint` mode
Message-ID: <0368f7ab37669163b50b82185725935bde5bc946.1701198172.git.me@ttaylorr.com>
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

Before multi-pack reachability bitmaps learn how to perform pack reuse
over the set of disjoint packs, we will need a way to generate packs
that are known to be disjoint with respect to the currently marked set
of disjoint packs.

In other words, we want a way to make a pack which does not have any
objects contained in the union of the set of packs which are currently
marked as disjoint.

There are a various ways that we could go about this, for example:

  - passing `--unpacked`, which would exclude all packed objects (and
    thus would not contain any objects from the disjoint pack)

  - passing `--stdin-packs` with the set of packs currently marked as
    disjoint as "excluded", indicating that `pack-objects` should
    discard any objects present in any of the excluded packs (thus
    producing a disjoint pack)

  - marking each of the disjoint packs as kept in-core with the
    `--keep-pack` flag, and then passing `--honor-pack-keep` to
    similarly ignore any object(s) from kept packs (thus also producing
    a pack which is disjoint with respect to the current set)

`git repack` is the main entry-point to generating a new pack, by
invoking `pack-objects` and then adding the new pack to the set of
disjoint packs if generating a new MIDX. However, `repack` has a number
of ways to invoke `pack-objects` (e.g., all-into-one repacks, geometric
repacks, incremental repacks, etc.), all of which would require careful
reasoning in order to prove that the resulting set of packs is disjoint.

The most appealing option of the above would be to pass the set of
disjoint packs as kept (via `--keep-pack`) and then ignore their
contents (with `--honor-pack-keep`), doing so for all kinds of
`pack-objects` invocations. But there may be more disjoint packs than we
can easily fit into the command-line arguments.

Instead, teach `pack-objects` a special `--ignore-disjoint` which is the
moral equivalent of marking the set of disjoint packs as kept, and
ignoring their contents, even if it would have otherwise been packed. In
fact, this similarity extends down to the implementation, where each
disjoint pack is first loaded, then has its `pack_keep_in_core` bit set.

With this in place, we can use the kept-pack cache from 20b031fede
(packfile: add kept-pack cache for find_kept_pack_entry(), 2021-02-22),
which looks up objects first in a cache containing just the set of kept
(in this case, disjoint) packs. Assuming that the set of disjoint packs
is a relatively small portion of the entire repository (which should be
a safe assumption to make), each object lookup will be very inexpensive.

The only place we want to avoid using `--ignore-disjoint` is in
conjunction with `--cruft`, since doing so may cause us to omit an
object which would have been included in a new cruft pack in order to
freshen it. In other words, failing to do so might cause that object to
be pruned from the repository earlier than expected.

Otherwise, `--ignore-disjoint` is compatible with most other modes of
`pack-objects`. These various combinations are tested below. As a
result, `repack` will be able to unconditionally (except for the cruft
pack) pass `--ignore-disjoint` when trying to add a new pack to the
disjoint set, and the result will be usable, without having to carefully
consider and reason about each individual case.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-pack-objects.txt |   8 ++
 builtin/pack-objects.c             |  31 +++++-
 t/lib-disjoint.sh                  |  11 ++
 t/t5331-pack-objects-stdin.sh      | 156 +++++++++++++++++++++++++++++
 4 files changed, 203 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index e32404c6aa..592c4ce742 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -96,6 +96,14 @@ base-name::
 Incompatible with `--revs`, or options that imply `--revs` (such as
 `--all`), with the exception of `--unpacked`, which is compatible.
 
+--ignore-disjoint::
+	This flag causes an object that appears in any pack marked as
+	"disjoint" by the multi-pack index to be ignored, even if it
+	would have otherwise been packed. When used with
+	`--stdin-packs`, objects from disjoint packs may be included if
+	and only if a disjoint pack is explicitly given as an input pack
+	to `--stdin-packs`. Incompatible with `--cruft`.
+
 --cruft::
 	Packs unreachable objects into a separate "cruft" pack, denoted
 	by the existence of a `.mtimes` file. Typically used by `git
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index bfa60359d4..107154db34 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -207,6 +207,7 @@ static int have_non_local_packs;
 static int incremental;
 static int ignore_packed_keep_on_disk;
 static int ignore_packed_keep_in_core;
+static int ignore_midx_disjoint_packs;
 static int allow_ofs_delta;
 static struct pack_idx_option pack_idx_opts;
 static const char *base_name;
@@ -1403,7 +1404,8 @@ static int want_found_object(const struct object_id *oid, int exclude,
 	/*
 	 * Then handle .keep first, as we have a fast(er) path there.
 	 */
-	if (ignore_packed_keep_on_disk || ignore_packed_keep_in_core) {
+	if (ignore_packed_keep_on_disk || ignore_packed_keep_in_core ||
+	    ignore_midx_disjoint_packs) {
 		/*
 		 * Set the flags for the kept-pack cache to be the ones we want
 		 * to ignore.
@@ -1415,7 +1417,7 @@ static int want_found_object(const struct object_id *oid, int exclude,
 		unsigned flags = 0;
 		if (ignore_packed_keep_on_disk)
 			flags |= ON_DISK_KEEP_PACKS;
-		if (ignore_packed_keep_in_core)
+		if (ignore_packed_keep_in_core || ignore_midx_disjoint_packs)
 			flags |= IN_CORE_KEEP_PACKS;
 
 		if (ignore_packed_keep_on_disk && p->pack_keep)
@@ -3389,6 +3391,7 @@ static void read_packs_list_from_stdin(void)
 			die(_("could not find pack '%s'"), item->string);
 		if (!is_pack_valid(p))
 			die(_("packfile %s cannot be accessed"), p->pack_name);
+		p->pack_keep_in_core = 0;
 	}
 
 	/*
@@ -4266,6 +4269,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("create packs suitable for shallow fetches")),
 		OPT_BOOL(0, "honor-pack-keep", &ignore_packed_keep_on_disk,
 			 N_("ignore packs that have companion .keep file")),
+		OPT_BOOL(0, "ignore-disjoint", &ignore_midx_disjoint_packs,
+			 N_("ignore packs that are marked disjoint in the MIDX")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
 				N_("ignore this pack")),
 		OPT_INTEGER(0, "compression", &pack_compression_level,
@@ -4412,7 +4417,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		if (use_internal_rev_list)
 			die(_("cannot use internal rev list with --cruft"));
 		if (stdin_packs)
-			die(_("cannot use --stdin-packs with --cruft"));
+			die(_("cannot use %s with %s"), "--stdin-packs", "--cruft");
+		if (ignore_midx_disjoint_packs)
+			die(_("cannot use %s with %s"), "--ignore-disjoint", "--cruft");
 	}
 
 	/*
@@ -4452,6 +4459,24 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		if (!p) /* no keep-able packs found */
 			ignore_packed_keep_on_disk = 0;
 	}
+	if (ignore_midx_disjoint_packs) {
+		struct multi_pack_index *m = get_multi_pack_index(the_repository);
+		struct bitmapped_pack pack;
+		unsigned any_disjoint = 0;
+		uint32_t i;
+
+		for (i = 0; m && m->chunk_disjoint_packs && i < m->num_packs; i++) {
+			if (nth_bitmapped_pack(the_repository, m, &pack, i) < 0)
+				die(_("could not load bitmapped pack %i"), i);
+			if (pack.disjoint) {
+				pack.p->pack_keep_in_core = 1;
+				any_disjoint = 1;
+			}
+		}
+
+		if (!any_disjoint) /* no disjoint packs to ignore */
+			ignore_midx_disjoint_packs = 0;
+	}
 	if (local) {
 		/*
 		 * unlike ignore_packed_keep_on_disk above, we do not
diff --git a/t/lib-disjoint.sh b/t/lib-disjoint.sh
index c6c6e74aba..c802ca6940 100644
--- a/t/lib-disjoint.sh
+++ b/t/lib-disjoint.sh
@@ -36,3 +36,14 @@ test_must_be_disjoint () {
 test_must_not_be_disjoint () {
 	test_disjoint_1 "$1" "no"
 }
+
+# packed_contents </path/to/pack-$XYZ.idx [...]>
+#
+# Prints the set of objects packed in the given pack indexes.
+packed_contents () {
+	for idx in "$@"
+	do
+		git show-index <$idx || return 1
+	done >tmp &&
+	cut -d" " -f2 <tmp | sort -u
+}
diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
index 2dcf1eecee..e522aa3f7d 100755
--- a/t/t5331-pack-objects-stdin.sh
+++ b/t/t5331-pack-objects-stdin.sh
@@ -6,6 +6,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-disjoint.sh
 
 packed_objects () {
 	git show-index <"$1" >tmp-object-list &&
@@ -237,4 +238,159 @@ test_expect_success 'pack-objects --stdin with packfiles from main and alternate
 	test_cmp expected-objects actual-objects
 '
 
+objdir=.git/objects
+packdir=$objdir/pack
+
+test_expect_success 'loose objects also in disjoint packs are ignored' '
+	test_when_finished "rm -fr repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		# create a pack containing the objects in each commit below, but
+		# do not delete their loose copies
+		test_commit base &&
+		base_pack="$(echo base | git pack-objects --revs $packdir/pack)" &&
+
+		test_commit other &&
+		other_pack="$(echo base..other | git pack-objects --revs $packdir/pack)" &&
+
+		cat >in <<-EOF &&
+		pack-$base_pack.idx
+		+pack-$other_pack.idx
+		EOF
+		git multi-pack-index write --stdin-packs --bitmap <in &&
+
+		test_commit more &&
+		out="$(git pack-objects --all --ignore-disjoint $packdir/pack)" &&
+
+		# gather all objects in "all", and objects from the disjoint
+		# pack in "disjoint"
+		git cat-file --batch-all-objects --batch-check="%(objectname)" >all &&
+		packed_contents "$packdir/pack-$other_pack.idx" >disjoint &&
+
+		# make sure that the set of objects we just generated matches
+		# "all \ disjoint"
+		packed_contents "$packdir/pack-$out.idx" >got &&
+		comm -23 all disjoint >want &&
+		test_cmp want got
+	)
+'
+
+test_expect_success 'objects in disjoint packs are ignored (--unpacked)' '
+	test_when_finished "rm -fr repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		for c in A B
+		do
+			test_commit "$c" || return 1
+		done &&
+
+		A="$(echo "A" | git pack-objects --revs $packdir/pack)" &&
+		B="$(echo "A..B" | git pack-objects --revs $packdir/pack)" &&
+
+		cat >in <<-EOF &&
+		pack-$A.idx
+		+pack-$B.idx
+		EOF
+		git multi-pack-index write --stdin-packs --bitmap <in &&
+
+		test_must_not_be_disjoint "pack-$A.pack" &&
+		test_must_be_disjoint "pack-$B.pack" &&
+
+		test_commit C &&
+
+		got="$(git pack-objects --all --unpacked --ignore-disjoint $packdir/pack)" &&
+		packed_contents "$packdir/pack-$got.idx" >actual &&
+
+		git rev-list --objects --no-object-names B..C >expect.raw &&
+		sort <expect.raw >expect &&
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'objects in disjoint packs are ignored (--stdin-packs)' '
+	# Create objects in three separate packs:
+	#
+	#   - pack A (midx, non disjoint)
+	#   - pack B (midx, disjoint)
+	#   - pack C (non-midx)
+	#
+	# Then create a new pack with `--stdin-packs` and `--ignore-disjoint`
+	# including packs A, B, and C. The resulting pack should contain
+	# only the objects from packs A, and C, excluding those from
+	# pack B as it is marked as disjoint.
+	test_when_finished "rm -fr repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		for c in A B C
+		do
+			test_commit "$c" || return 1
+		done &&
+
+		A="$(echo "A" | git pack-objects --revs $packdir/pack)" &&
+		B="$(echo "A..B" | git pack-objects --revs $packdir/pack)" &&
+		C="$(echo "B..C" | git pack-objects --revs $packdir/pack)" &&
+
+		cat >in <<-EOF &&
+		pack-$A.idx
+		+pack-$B.idx
+		EOF
+		git multi-pack-index write --stdin-packs --bitmap <in &&
+
+		test_must_not_be_disjoint "pack-$A.pack" &&
+		test_must_be_disjoint "pack-$B.pack" &&
+
+		# Generate a pack with `--stdin-packs` using packs "A" and "C",
+		# but excluding objects from "B". The objects from pack "B" are
+		# expected to be omitted from the generated pack for two
+		# reasons:
+		#
+		#   - because it was specified as a negated tip via
+		#     `--stdin-packs`
+		#   - because it is a disjoint pack.
+		cat >in <<-EOF &&
+		pack-$A.pack
+		^pack-$B.pack
+		pack-$C.pack
+		EOF
+		got="$(git pack-objects --stdin-packs --ignore-disjoint $packdir/pack <in)" &&
+
+		packed_contents "$packdir/pack-$got.idx" >actual &&
+		packed_contents "$packdir/pack-$A.idx" \
+				"$packdir/pack-$C.idx" >expect &&
+		test_cmp expect actual &&
+
+		# Generate another pack with `--stdin-packs`, this time
+		# using packs "B" and "C". The objects from pack "B" are
+		# expected to be in the final pack, despite it being a
+		# disjoint pack, because "B" was mentioned explicitly
+		# via `stdin-packs`.
+		cat >in <<-EOF &&
+		pack-$B.pack
+		pack-$C.pack
+		EOF
+		got="$(git pack-objects --stdin-packs --ignore-disjoint $packdir/pack <in)" &&
+
+		packed_contents "$packdir/pack-$got.idx" >actual &&
+		packed_contents "$packdir/pack-$B.idx" \
+				"$packdir/pack-$C.idx" >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--cruft is incompatible with --ignore-disjoint' '
+	test_must_fail git pack-objects --cruft --ignore-disjoint --stdout \
+		</dev/null >/dev/null 2>actual &&
+	cat >expect <<-\EOF &&
+	fatal: cannot use --ignore-disjoint with --cruft
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.43.0.24.g980b318f98

