Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3843F1F404
	for <e@80x24.org>; Sun,  2 Sep 2018 08:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbeIBNKG (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Sep 2018 09:10:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:36648 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725834AbeIBNKG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Sep 2018 09:10:06 -0400
Received: (qmail 15545 invoked by uid 109); 2 Sep 2018 08:55:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 02 Sep 2018 08:55:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17002 invoked by uid 111); 2 Sep 2018 08:55:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 02 Sep 2018 04:55:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Sep 2018 04:55:03 -0400
Date:   Sun, 2 Sep 2018 04:55:03 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        git@vger.kernel.org
Subject: Re: non-smooth progress  indication for git fsck and git gc
Message-ID: <20180902085503.GA25391@sigill.intra.peff.net>
References: <5B751FA1020000A10002CD2F@gwsmtp1.uni-regensburg.de>
 <20180816155714.GA22739@sigill.intra.peff.net>
 <87bma2qcba.fsf@evledraar.gmail.com>
 <87y3clbcqf.fsf@evledraar.gmail.com>
 <20180902074656.GB18787@sigill.intra.peff.net>
 <20180902075528.GC18787@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180902075528.GC18787@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 02, 2018 at 03:55:28AM -0400, Jeff King wrote:

> I still think the more interesting long-term thing here is to reuse the
> pack verification from index-pack, which actually hashes as it does the
> per-object countup.
> 
> That code isn't lib-ified enough to be run in process, but I think the
> patch below should give similar behavior to what fsck currently does.
> We'd need to tell index-pack to use our fsck.* config for its checks, I
> imagine. The progress here is still per-pack, but I think we could pass
> in sufficient information to have it do one continuous meter across all
> of the packs (see the in-code comment).
> 
> And it makes the result multi-threaded, and lets us drop a bunch of
> duplicate code.

Here's a little polish on that to pass enough progress data to
index-pack to let it have one nice continuous meter. I'm not sure if
it's worth all the hackery or not. The dual-meter that index-pack
generally uses is actually more informative (since it meters the initial
pass through the pack and the delta reconstruction separately).

And there are definitely a few nasty bits (like the way the progress is
ended). I'm not planning on taking this further for now, but maybe
you or somebody can find it interesting or useful.

---
 builtin/fsck.c       |  59 +++++++++------
 builtin/index-pack.c |  43 ++++++++++-
 pack-check.c         | 142 -----------------------------------
 pack.h               |   1 -
 4 files changed, 75 insertions(+), 170 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 250f5af118..2d774ea2e5 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -386,25 +386,6 @@ static int fsck_obj(struct object *obj, void *buffer, unsigned long size)
 	return err;
 }
 
-static int fsck_obj_buffer(const struct object_id *oid, enum object_type type,
-			   unsigned long size, void *buffer, int *eaten)
-{
-	/*
-	 * Note, buffer may be NULL if type is OBJ_BLOB. See
-	 * verify_packfile(), data_valid variable for details.
-	 */
-	struct object *obj;
-	obj = parse_object_buffer(the_repository, oid, type, size, buffer,
-				  eaten);
-	if (!obj) {
-		errors_found |= ERROR_OBJECT;
-		return error("%s: object corrupt or missing", oid_to_hex(oid));
-	}
-	obj->flags &= ~(REACHABLE | SEEN);
-	obj->flags |= HAS_OBJ;
-	return fsck_obj(obj, buffer, size);
-}
-
 static int default_refs;
 
 static void fsck_handle_reflog_oid(const char *refname, struct object_id *oid,
@@ -662,6 +643,32 @@ static int mark_packed_for_connectivity(const struct object_id *oid,
 	return 0;
 }
 
+static int verify_pack(struct packed_git *p,
+		       unsigned long count, unsigned long total)
+{
+	struct child_process index_pack = CHILD_PROCESS_INIT;
+
+	if (is_pack_valid(p) < 0)
+		return -1;
+	for_each_object_in_pack(p, mark_packed_for_connectivity, NULL, 0);
+
+	index_pack.git_cmd = 1;
+	argv_array_pushl(&index_pack.args,
+			 "index-pack",
+			 "--verify-fsck",
+			 NULL);
+	if (show_progress)
+		argv_array_pushf(&index_pack.args,
+				 "--fsck-progress=%lu,%lu,Checking pack %s",
+				 count, total, sha1_to_hex(p->sha1));
+	argv_array_push(&index_pack.args, p->pack_name);
+
+	if (run_command(&index_pack))
+		return -1;
+
+	return 0;
+}
+
 static char const * const fsck_usage[] = {
 	N_("git fsck [<options>] [<object>...]"),
 	NULL
@@ -737,7 +744,6 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		if (check_full) {
 			struct packed_git *p;
 			uint32_t total = 0, count = 0;
-			struct progress *progress = NULL;
 
 			if (show_progress) {
 				for (p = get_packed_git(the_repository); p;
@@ -746,18 +752,21 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 						continue;
 					total += p->num_objects;
 				}
-
-				progress = start_progress(_("Checking objects"), total);
 			}
 			for (p = get_packed_git(the_repository); p;
 			     p = p->next) {
 				/* verify gives error messages itself */
-				if (verify_pack(p, fsck_obj_buffer,
-						progress, count))
+				if (verify_pack(p, count, total))
 					errors_found |= ERROR_PACK;
 				count += p->num_objects;
 			}
-			stop_progress(&progress);
+			/*
+			 * Our child index-pack never calls stop_progress(),
+			 * which lets each child appear on the same line. Now
+			 * that we've finished all of them, we have to tie that
+			 * off.
+			 */
+			fprintf(stderr, "\n");
 		}
 
 		if (fsck_finish(&fsck_obj_options))
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 9582ead950..d03ec7bb89 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -85,6 +85,13 @@ static int show_resolving_progress;
 static int show_stat;
 static int check_self_contained_and_connected;
 
+static int verify_fsck_mode;
+/* unlike our normal 2-part progress, this counts up only total objects */
+struct progress *fsck_progress;
+static uint32_t fsck_progress_cur;
+static uint32_t fsck_progress_total;
+static const char *fsck_progress_title;
+
 static struct progress *progress;
 
 /* We always read in 4kB chunks. */
@@ -1100,6 +1107,8 @@ static void *threaded_second_pass(void *data)
 		int i;
 		counter_lock();
 		display_progress(progress, nr_resolved_deltas);
+		display_progress(fsck_progress,
+				 fsck_progress_cur + nr_resolved_deltas);
 		counter_unlock();
 		work_lock();
 		while (nr_dispatched < nr_objects &&
@@ -1145,18 +1154,23 @@ static void parse_pack_objects(unsigned char *hash)
 			nr_ofs_deltas++;
 			ofs_delta->obj_no = i;
 			ofs_delta++;
+			/* no fsck_progress; we only count it when we've resolved the delta */
 		} else if (obj->type == OBJ_REF_DELTA) {
 			ALLOC_GROW(ref_deltas, nr_ref_deltas + 1, ref_deltas_alloc);
 			oidcpy(&ref_deltas[nr_ref_deltas].oid, &ref_delta_oid);
 			ref_deltas[nr_ref_deltas].obj_no = i;
 			nr_ref_deltas++;
+			/* no fsck_progress; we only count it when we've resolved the delta */
 		} else if (!data) {
 			/* large blobs, check later */
 			obj->real_type = OBJ_BAD;
 			nr_delays++;
-		} else
+			display_progress(fsck_progress, ++fsck_progress_cur);
+		} else {
 			sha1_object(data, NULL, obj->size, obj->type,
 				    &obj->idx.oid);
+			display_progress(fsck_progress, ++fsck_progress_cur);
+		}
 		free(data);
 		display_progress(progress, i+1);
 	}
@@ -1238,6 +1252,8 @@ static void resolve_deltas(void)
 			continue;
 		resolve_base(obj);
 		display_progress(progress, nr_resolved_deltas);
+		display_progress(fsck_progress,
+				 fsck_progress_cur + nr_resolved_deltas);
 	}
 }
 
@@ -1391,6 +1407,8 @@ static void fix_unresolved_deltas(struct hashfile *f)
 					base_obj->data, base_obj->size, type);
 		find_unresolved_deltas(base_obj);
 		display_progress(progress, nr_resolved_deltas);
+		display_progress(fsck_progress,
+				 fsck_progress_cur + nr_resolved_deltas);
 	}
 	free(sorted_by_pos);
 }
@@ -1714,6 +1732,11 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 				verify = 1;
 				show_stat = 1;
 				stat_only = 1;
+			} else if (!strcmp(arg, "--verify-fsck")) {
+				verify_fsck_mode = 1;
+				verify = 1;
+				strict = 1;
+				do_fsck_object = 1;
 			} else if (skip_to_optional_arg(arg, "--keep", &keep_msg)) {
 				; /* nothing to do */
 			} else if (skip_to_optional_arg(arg, "--promisor", &promisor_msg)) {
@@ -1746,6 +1769,15 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 				verbose = 1;
 			} else if (!strcmp(arg, "--show-resolving-progress")) {
 				show_resolving_progress = 1;
+			} else if (skip_prefix(arg, "--fsck-progress=", &arg)) {
+				char *end;
+				fsck_progress_cur = strtoul(arg, &end, 10);
+				if (*end++ != ',')
+					die("bad fsck-progress arg: %s", arg);
+				fsck_progress_total = strtoul(end, &end, 10);
+				if (*end++ != ',')
+					die("bad fsck-progress arg: %s", arg);
+				fsck_progress_title = end;
 			} else if (!strcmp(arg, "--report-end-of-input")) {
 				report_end_of_input = 1;
 			} else if (!strcmp(arg, "-o")) {
@@ -1800,6 +1832,10 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	}
 #endif
 
+	if (fsck_progress_total)
+		fsck_progress = start_progress(fsck_progress_title,
+					       fsck_progress_total);
+
 	curr_pack = open_pack_file(pack_name);
 	parse_pack_header();
 	objects = xcalloc(st_add(nr_objects, 1), sizeof(struct object_entry));
@@ -1833,8 +1869,11 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	else
 		close(input_fd);
 
-	if (do_fsck_object && fsck_finish(&fsck_options))
+	if (do_fsck_object && fsck_finish(&fsck_options)) {
+		if (verify_fsck_mode)
+			return 1; /* quietly return error */
 		die(_("fsck error in pack objects"));
+	}
 
 	free(objects);
 	strbuf_release(&index_name_buf);
diff --git a/pack-check.c b/pack-check.c
index d3a57df34f..ea1457ce53 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -15,17 +15,6 @@ struct idx_entry {
 	unsigned int nr;
 };
 
-static int compare_entries(const void *e1, const void *e2)
-{
-	const struct idx_entry *entry1 = e1;
-	const struct idx_entry *entry2 = e2;
-	if (entry1->offset < entry2->offset)
-		return -1;
-	if (entry1->offset > entry2->offset)
-		return 1;
-	return 0;
-}
-
 int check_pack_crc(struct packed_git *p, struct pack_window **w_curs,
 		   off_t offset, off_t len, unsigned int nr)
 {
@@ -48,121 +37,6 @@ int check_pack_crc(struct packed_git *p, struct pack_window **w_curs,
 	return data_crc != ntohl(*index_crc);
 }
 
-static int verify_packfile(struct packed_git *p,
-			   struct pack_window **w_curs,
-			   verify_fn fn,
-			   struct progress *progress, uint32_t base_count)
-
-{
-	off_t index_size = p->index_size;
-	const unsigned char *index_base = p->index_data;
-	git_hash_ctx ctx;
-	unsigned char hash[GIT_MAX_RAWSZ], *pack_sig;
-	off_t offset = 0, pack_sig_ofs = 0;
-	uint32_t nr_objects, i;
-	int err = 0;
-	struct idx_entry *entries;
-
-	if (!is_pack_valid(p))
-		return error("packfile %s cannot be accessed", p->pack_name);
-
-	the_hash_algo->init_fn(&ctx);
-	do {
-		unsigned long remaining;
-		unsigned char *in = use_pack(p, w_curs, offset, &remaining);
-		offset += remaining;
-		if (!pack_sig_ofs)
-			pack_sig_ofs = p->pack_size - the_hash_algo->rawsz;
-		if (offset > pack_sig_ofs)
-			remaining -= (unsigned int)(offset - pack_sig_ofs);
-		the_hash_algo->update_fn(&ctx, in, remaining);
-	} while (offset < pack_sig_ofs);
-	the_hash_algo->final_fn(hash, &ctx);
-	pack_sig = use_pack(p, w_curs, pack_sig_ofs, NULL);
-	if (hashcmp(hash, pack_sig))
-		err = error("%s pack checksum mismatch",
-			    p->pack_name);
-	if (hashcmp(index_base + index_size - the_hash_algo->hexsz, pack_sig))
-		err = error("%s pack checksum does not match its index",
-			    p->pack_name);
-	unuse_pack(w_curs);
-
-	/* Make sure everything reachable from idx is valid.  Since we
-	 * have verified that nr_objects matches between idx and pack,
-	 * we do not do scan-streaming check on the pack file.
-	 */
-	nr_objects = p->num_objects;
-	ALLOC_ARRAY(entries, nr_objects + 1);
-	entries[nr_objects].offset = pack_sig_ofs;
-	/* first sort entries by pack offset, since unpacking them is more efficient that way */
-	for (i = 0; i < nr_objects; i++) {
-		entries[i].oid.hash = nth_packed_object_sha1(p, i);
-		if (!entries[i].oid.hash)
-			die("internal error pack-check nth-packed-object");
-		entries[i].offset = nth_packed_object_offset(p, i);
-		entries[i].nr = i;
-	}
-	QSORT(entries, nr_objects, compare_entries);
-
-	for (i = 0; i < nr_objects; i++) {
-		void *data;
-		enum object_type type;
-		unsigned long size;
-		off_t curpos;
-		int data_valid;
-
-		if (p->index_version > 1) {
-			off_t offset = entries[i].offset;
-			off_t len = entries[i+1].offset - offset;
-			unsigned int nr = entries[i].nr;
-			if (check_pack_crc(p, w_curs, offset, len, nr))
-				err = error("index CRC mismatch for object %s "
-					    "from %s at offset %"PRIuMAX"",
-					    oid_to_hex(entries[i].oid.oid),
-					    p->pack_name, (uintmax_t)offset);
-		}
-
-		curpos = entries[i].offset;
-		type = unpack_object_header(p, w_curs, &curpos, &size);
-		unuse_pack(w_curs);
-
-		if (type == OBJ_BLOB && big_file_threshold <= size) {
-			/*
-			 * Let check_object_signature() check it with
-			 * the streaming interface; no point slurping
-			 * the data in-core only to discard.
-			 */
-			data = NULL;
-			data_valid = 0;
-		} else {
-			data = unpack_entry(the_repository, p, entries[i].offset, &type, &size);
-			data_valid = 1;
-		}
-
-		if (data_valid && !data)
-			err = error("cannot unpack %s from %s at offset %"PRIuMAX"",
-				    oid_to_hex(entries[i].oid.oid), p->pack_name,
-				    (uintmax_t)entries[i].offset);
-		else if (check_object_signature(entries[i].oid.oid, data, size, type_name(type)))
-			err = error("packed %s from %s is corrupt",
-				    oid_to_hex(entries[i].oid.oid), p->pack_name);
-		else if (fn) {
-			int eaten = 0;
-			err |= fn(entries[i].oid.oid, type, size, data, &eaten);
-			if (eaten)
-				data = NULL;
-		}
-		if (((base_count + i) & 1023) == 0)
-			display_progress(progress, base_count + i);
-		free(data);
-
-	}
-	display_progress(progress, base_count + i);
-	free(entries);
-
-	return err;
-}
-
 int verify_pack_index(struct packed_git *p)
 {
 	off_t index_size;
@@ -185,19 +59,3 @@ int verify_pack_index(struct packed_git *p)
 			    p->pack_name);
 	return err;
 }
-
-int verify_pack(struct packed_git *p, verify_fn fn,
-		struct progress *progress, uint32_t base_count)
-{
-	int err = 0;
-	struct pack_window *w_curs = NULL;
-
-	err |= verify_pack_index(p);
-	if (!p->index_data)
-		return -1;
-
-	err |= verify_packfile(p, &w_curs, fn, progress, base_count);
-	unuse_pack(&w_curs);
-
-	return err;
-}
diff --git a/pack.h b/pack.h
index 34a9d458b4..0d346c5e31 100644
--- a/pack.h
+++ b/pack.h
@@ -80,7 +80,6 @@ typedef int (*verify_fn)(const struct object_id *, enum object_type, unsigned lo
 extern const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects, int nr_objects, const struct pack_idx_option *, const unsigned char *sha1);
 extern int check_pack_crc(struct packed_git *p, struct pack_window **w_curs, off_t offset, off_t len, unsigned int nr);
 extern int verify_pack_index(struct packed_git *);
-extern int verify_pack(struct packed_git *, verify_fn fn, struct progress *, uint32_t);
 extern off_t write_pack_header(struct hashfile *f, uint32_t);
 extern void fixup_pack_header_footer(int, unsigned char *, const char *, uint32_t, unsigned char *, off_t);
 extern char *index_pack_lockfile(int fd);
