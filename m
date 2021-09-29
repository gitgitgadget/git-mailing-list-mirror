Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACA4C433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 01:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A2CA61352
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 01:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243651AbhI2B4u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 21:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhI2B4t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 21:56:49 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8ABC06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 18:55:09 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id y197so1087191iof.11
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 18:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xomgPOqHvDExerKweyuwzFQWM/+HeysQdGLPTmXaLRM=;
        b=ny2yffJYha0bwPXmYOKI4my13ejitK5fA6HIxgjGM038Iu2WAm58Qw+5aMYCQgD4z4
         6gnc9UmWDHzITVi9HdD8//Letmx6QmYi4/7CySaSLzhntTw1T9v+4xrUKPUQYffPstTS
         EhRutis1i8mdmD+C3ukz9TA+mtjMS33UyMnCzn1k5pSW86c4fON0NWwAlE5DBaMLXGJt
         jmFWMn+FAFshC7QMfIZZOsiBzcaNUtaNVMY4EMCBXT8NP2DTSGijaB+kpPW1nbFn8s2/
         lIt+lkcQfVaqBteotYrSojpUfDPbkuIQDdc+hFKZaP0wpzPV8Zha2A0QytkSJmuSE0ai
         Jqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xomgPOqHvDExerKweyuwzFQWM/+HeysQdGLPTmXaLRM=;
        b=6GlNFsnCoYMAfSpnTI+lZVQFyj/921C5fnxCa6lmrmMxYiNrFnWCCx/0zwGfv/Kfcg
         +RBrJ9OvU+/52HlPpfVTLzxwOhdamAHIWDpoWn26ZZHcqtMCxN33ANVY0A5JWQ5KexAC
         48+DwLawYecKycKUirFOf0NBPTGeVQhDrer1D1oHze8JHJ7llrgiBkIEqUAwQKdJD9up
         pU/Msfiwenl7wiDC6SOPYmBhTwts+YxIgHJj+rPbj/mWSfqxl19U8zdThz3Gx8r6iiwj
         /9kQyy7w4nPefjhDC6C1zT5EpzaasHbgczjdg+9wIUXoucbeQ1Z94wJ6kWfkQVTQSbsu
         IA+w==
X-Gm-Message-State: AOAM531N9+x0376K0srUw8pIwm3A1qNIfl0lRkKZEpUWu6ysFfV+7IPk
        NtN5rGwC7XNq6Y6aJE33lgMUUYT6h4u2gg==
X-Google-Smtp-Source: ABdhPJzM9RPMkEvQJ0EUhkdr+QyTOnC69K3sCQGcQG0I5fxU34jKuOv4yVCZr5vHrFhSUwugq5k1XQ==
X-Received: by 2002:a02:a38f:: with SMTP id y15mr7246961jak.26.1632880508471;
        Tue, 28 Sep 2021 18:55:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r13sm487922ilh.80.2021.09.28.18.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 18:55:08 -0700 (PDT)
Date:   Tue, 28 Sep 2021 21:55:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, gitster@pobox.com,
        jonathantanmy@google.com, steadmon@google.com
Subject: [PATCH v3 3/9] midx: preliminary support for `--refs-snapshot`
Message-ID: <4e3769a4f39f78788be975adcb5b3b57143df2c7.1632880469.git.me@ttaylorr.com>
References: <cover.1631730270.git.me@ttaylorr.com>
 <cover.1632880469.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1632880469.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To figure out which commits we can write a bitmap for, the multi-pack
index/bitmap code does a reachability traversal, marking any commit
which can be found in the MIDX as eligible to receive a bitmap.

This approach will cause a problem when multi-pack bitmaps are able to
be generated from `git repack`, since the reference tips can change
during the repack. Even though we ignore commits that don't exist in
the MIDX (when doing a scan of the ref tips), it's possible that a
commit in the MIDX reaches something that isn't.

This can happen when a multi-pack index contains some pack which refers
to loose objects (e.g., if a pack was pushed after starting the repack
but before generating the MIDX which depends on an object which is
stored as loose in the repository, and by definition isn't included in
the multi-pack index).

By taking a snapshot of the references before we start repacking, we can
close that race window. In the above scenario (where we have a packed
object pointing at a loose one), we'll either (a) take a snapshot of the
references before seeing the packed one, or (b) take it after, at which
point we can guarantee that the loose object will be packed and included
in the MIDX.

This patch does just that. It writes a temporary "reference snapshot",
which is a list of OIDs that are at the ref tips before writing a
multi-pack bitmap. References that are "preferred" (i.e,. are a suffix
of at least one value of the 'pack.preferBitmapTips' configuration) are
marked with a special '+'.

The format is simple: one line per commit at each tip, with an optional
'+' at the beginning (for preferred references, as described above).

When provided, the reference snapshot is used to drive bitmap selection
instead of the MIDX code doing its own traversal. When it isn't
provided, the usual traversal takes place instead.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.txt | 15 +++++
 builtin/multi-pack-index.c             | 11 +++-
 builtin/repack.c                       |  2 +-
 midx.c                                 | 61 ++++++++++++++++---
 midx.h                                 |  6 +-
 t/t5326-multi-pack-bitmaps.sh          | 82 ++++++++++++++++++++++++++
 6 files changed, 164 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index 009c989ef8..27f83932e4 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -49,6 +49,21 @@ write::
 	--stdin-packs::
 		Write a multi-pack index containing only the set of
 		line-delimited pack index basenames provided over stdin.
+
+	--refs-snapshot=<path>::
+		With `--bitmap`, optionally specify a file which
+		contains a "refs snapshot" taken prior to repacking.
++
+A reference snapshot is composed of line-delimited OIDs corresponding to
+the reference tips, usually taken by `git repack` prior to generating a
+new pack. A line may optionally start with a `+` character to indicate
+that the reference which corresponds to that OID is "preferred" (see
+linkgit:git-config[1]'s `pack.preferBitmapTips`.)
++
+The file given at `<path>` is expected to be readable, and can contain
+duplicates. (If a given OID is given more than once, it is marked as
+preferred if at least one instance of it begins with the special `+`
+marker).
 --
 
 verify::
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 03aaf8e7fb..93869d58c5 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -7,7 +7,8 @@
 #include "object-store.h"
 
 #define BUILTIN_MIDX_WRITE_USAGE \
-	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>]")
+	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>]" \
+	   "[--refs-snapshot=<path>]")
 
 #define BUILTIN_MIDX_VERIFY_USAGE \
 	N_("git multi-pack-index [<options>] verify")
@@ -45,6 +46,7 @@ static char const * const builtin_multi_pack_index_usage[] = {
 static struct opts_multi_pack_index {
 	const char *object_dir;
 	const char *preferred_pack;
+	const char *refs_snapshot;
 	unsigned long batch_size;
 	unsigned flags;
 	int stdin_packs;
@@ -83,6 +85,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
 			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
 		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
 			 N_("write multi-pack index containing only given indexes")),
+		OPT_FILENAME(0, "refs-snapshot", &opts.refs_snapshot,
+			     N_("refs snapshot for selecting bitmap commits")),
 		OPT_END(),
 	};
 
@@ -106,7 +110,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
 		read_packs_from_stdin(&packs);
 
 		ret = write_midx_file_only(opts.object_dir, &packs,
-					   opts.preferred_pack, opts.flags);
+					   opts.preferred_pack,
+					   opts.refs_snapshot, opts.flags);
 
 		string_list_clear(&packs, 0);
 
@@ -114,7 +119,7 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
 
 	}
 	return write_midx_file(opts.object_dir, opts.preferred_pack,
-			       opts.flags);
+			       opts.refs_snapshot, opts.flags);
 }
 
 static int cmd_multi_pack_index_verify(int argc, const char **argv)
diff --git a/builtin/repack.c b/builtin/repack.c
index c1a209013b..dba83eede2 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -733,7 +733,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		unsigned flags = 0;
 		if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP, 0))
 			flags |= MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX;
-		write_midx_file(get_object_directory(), NULL, flags);
+		write_midx_file(get_object_directory(), NULL, NULL, flags);
 	}
 
 	string_list_clear(&names, 0);
diff --git a/midx.c b/midx.c
index 7ac97e66e0..984dea2dba 100644
--- a/midx.c
+++ b/midx.c
@@ -968,7 +968,43 @@ static void bitmap_show_commit(struct commit *commit, void *_data)
 	data->commits[data->commits_nr++] = commit;
 }
 
+static int read_refs_snapshot(const char *refs_snapshot,
+			      struct rev_info *revs)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct object_id oid;
+	FILE *f = xfopen(refs_snapshot, "r");
+
+	while (strbuf_getline(&buf, f) != EOF) {
+		struct object *object;
+		int preferred = 0;
+		char *hex = buf.buf;
+		const char *end = NULL;
+
+		if (buf.len && *buf.buf == '+') {
+			preferred = 1;
+			hex = &buf.buf[1];
+		}
+
+		if (parse_oid_hex(hex, &oid, &end) < 0)
+			die(_("could not parse line: %s"), buf.buf);
+		if (*end)
+			die(_("malformed line: %s"), buf.buf);
+
+		object = parse_object_or_die(&oid, NULL);
+		if (preferred)
+			object->flags |= NEEDS_BITMAP;
+
+		add_pending_object(revs, object, "");
+	}
+
+	fclose(f);
+	strbuf_release(&buf);
+	return 0;
+}
+
 static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr_p,
+						    const char *refs_snapshot,
 						    struct write_midx_context *ctx)
 {
 	struct rev_info revs;
@@ -977,8 +1013,12 @@ static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr
 	cb.ctx = ctx;
 
 	repo_init_revisions(the_repository, &revs, NULL);
-	setup_revisions(0, NULL, &revs, NULL);
-	for_each_ref(add_ref_to_pending, &revs);
+	if (refs_snapshot) {
+		read_refs_snapshot(refs_snapshot, &revs);
+	} else {
+		setup_revisions(0, NULL, &revs, NULL);
+		for_each_ref(add_ref_to_pending, &revs);
+	}
 
 	/*
 	 * Skipping promisor objects here is intentional, since it only excludes
@@ -1007,6 +1047,7 @@ static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr
 
 static int write_midx_bitmap(char *midx_name, unsigned char *midx_hash,
 			     struct write_midx_context *ctx,
+			     const char *refs_snapshot,
 			     unsigned flags)
 {
 	struct packing_data pdata;
@@ -1018,7 +1059,7 @@ static int write_midx_bitmap(char *midx_name, unsigned char *midx_hash,
 
 	prepare_midx_packing_data(&pdata, ctx);
 
-	commits = find_commits_for_midx_bitmap(&commits_nr, ctx);
+	commits = find_commits_for_midx_bitmap(&commits_nr, refs_snapshot, ctx);
 
 	/*
 	 * Build the MIDX-order index based on pdata.objects (which is already
@@ -1066,6 +1107,7 @@ static int write_midx_internal(const char *object_dir,
 			       struct string_list *packs_to_include,
 			       struct string_list *packs_to_drop,
 			       const char *preferred_pack_name,
+			       const char *refs_snapshot,
 			       unsigned flags)
 {
 	char *midx_name;
@@ -1359,7 +1401,8 @@ static int write_midx_internal(const char *object_dir,
 	if (flags & MIDX_WRITE_REV_INDEX)
 		write_midx_reverse_index(midx_name, midx_hash, &ctx);
 	if (flags & MIDX_WRITE_BITMAP) {
-		if (write_midx_bitmap(midx_name, midx_hash, &ctx, flags) < 0) {
+		if (write_midx_bitmap(midx_name, midx_hash, &ctx,
+				      refs_snapshot, flags) < 0) {
 			error(_("could not write multi-pack bitmap"));
 			result = 1;
 			goto cleanup;
@@ -1394,19 +1437,21 @@ static int write_midx_internal(const char *object_dir,
 
 int write_midx_file(const char *object_dir,
 		    const char *preferred_pack_name,
+		    const char *refs_snapshot,
 		    unsigned flags)
 {
 	return write_midx_internal(object_dir, NULL, NULL, preferred_pack_name,
-				   flags);
+				   refs_snapshot, flags);
 }
 
 int write_midx_file_only(const char *object_dir,
 			 struct string_list *packs_to_include,
 			 const char *preferred_pack_name,
+			 const char *refs_snapshot,
 			 unsigned flags)
 {
 	return write_midx_internal(object_dir, packs_to_include, NULL,
-				   preferred_pack_name, flags);
+				   preferred_pack_name, refs_snapshot, flags);
 }
 
 struct clear_midx_data {
@@ -1686,7 +1731,7 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 	free(count);
 
 	if (packs_to_drop.nr) {
-		result = write_midx_internal(object_dir, NULL, &packs_to_drop, NULL, flags);
+		result = write_midx_internal(object_dir, NULL, &packs_to_drop, NULL, NULL, flags);
 		m = NULL;
 	}
 
@@ -1877,7 +1922,7 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 		goto cleanup;
 	}
 
-	result = write_midx_internal(object_dir, NULL, NULL, NULL, flags);
+	result = write_midx_internal(object_dir, NULL, NULL, NULL, NULL, flags);
 	m = NULL;
 
 cleanup:
diff --git a/midx.h b/midx.h
index 3545e327ea..11ff094a8c 100644
--- a/midx.h
+++ b/midx.h
@@ -62,14 +62,18 @@ int fill_midx_entry(struct repository *r, const struct object_id *oid, struct pa
 int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name);
 int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, int local);
 
-int write_midx_file(const char *object_dir, const char *preferred_pack_name, unsigned flags);
 /*
  * Variant of write_midx_file which writes a MIDX containing only the packs
  * specified in packs_to_include.
  */
+int write_midx_file(const char *object_dir,
+		    const char *preferred_pack_name,
+		    const char *refs_snapshot,
+		    unsigned flags);
 int write_midx_file_only(const char *object_dir,
 			 struct string_list *packs_to_include,
 			 const char *preferred_pack_name,
+			 const char *refs_snapshot,
 			 unsigned flags);
 void clear_midx_file(struct repository *r);
 int verify_midx_file(struct repository *r, const char *object_dir, unsigned flags);
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 4ad7c2c969..069dab3e17 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -283,4 +283,86 @@ test_expect_success 'pack.preferBitmapTips' '
 	)
 '
 
+test_expect_success 'writing a bitmap with --refs-snapshot' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit one &&
+		test_commit two &&
+
+		git rev-parse one >snapshot &&
+
+		git repack -ad &&
+
+		# First, write a MIDX which see both refs/tags/one and
+		# refs/tags/two (causing both of those commits to receive
+		# bitmaps).
+		git multi-pack-index write --bitmap &&
+
+		test_path_is_file $midx &&
+		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
+
+		test-tool bitmap list-commits | sort >bitmaps &&
+		grep "$(git rev-parse one)" bitmaps &&
+		grep "$(git rev-parse two)" bitmaps &&
+
+		rm -fr $midx-$(midx_checksum $objdir).bitmap &&
+		rm -fr $midx-$(midx_checksum $objdir).rev &&
+		rm -fr $midx &&
+
+		# Then again, but with a refs snapshot which only sees
+		# refs/tags/one.
+		git multi-pack-index write --bitmap --refs-snapshot=snapshot &&
+
+		test_path_is_file $midx &&
+		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
+
+		test-tool bitmap list-commits | sort >bitmaps &&
+		grep "$(git rev-parse one)" bitmaps &&
+		! grep "$(git rev-parse two)" bitmaps
+	)
+'
+
+test_expect_success 'write a bitmap with --refs-snapshot (preferred tips)' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit_bulk --message="%s" 103 &&
+
+		git log --format="%H" >commits.raw &&
+		sort <commits.raw >commits &&
+
+		git log --format="create refs/tags/%s %H" HEAD >refs &&
+		git update-ref --stdin <refs &&
+
+		git multi-pack-index write --bitmap &&
+		test_path_is_file $midx &&
+		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
+
+		test-tool bitmap list-commits | sort >bitmaps &&
+		comm -13 bitmaps commits >before &&
+		test_line_count = 1 before &&
+
+		(
+			grep -vf before commits.raw &&
+			# mark missing commits as preferred
+			sed "s/^/+/" before
+		) >snapshot &&
+
+		rm -fr $midx-$(midx_checksum $objdir).bitmap &&
+		rm -fr $midx-$(midx_checksum $objdir).rev &&
+		rm -fr $midx &&
+
+		git multi-pack-index write --bitmap --refs-snapshot=snapshot &&
+		test-tool bitmap list-commits | sort >bitmaps &&
+		comm -13 bitmaps commits >after &&
+
+		! test_cmp before after
+	)
+'
+
 test_done
-- 
2.33.0.96.g73915697e6

