From: szager@chromium.org
Subject: [PATCH] Make the global packed_git variable static to
 sha1_file.c.
Date: Thu, 13 Feb 2014 15:09:26 -0800
Message-ID: <52fd50a6.YVFbMjecmzjN0Jej%szager@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 14 00:34:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WE5n8-0002ei-To
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 00:34:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507AbaBMXd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Feb 2014 18:33:57 -0500
Received: from mail-vc0-f202.google.com ([209.85.220.202]:56599 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbaBMXdy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Feb 2014 18:33:54 -0500
Received: by mail-vc0-f202.google.com with SMTP id hu8so1415578vcb.5
        for <git@vger.kernel.org>; Thu, 13 Feb 2014 15:33:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=HD5qUNNSnpkgCi/1a7/JftK/Mxa2iPYpDX36ak1URRM=;
        b=aRsm6bannodOWQyqllpfAnddLQmgMznXzt0y9jDDAvmLWLk/VIp/nsnE81HpJdYlds
         oEGX0ialU9E+ihH3uEQ9uCXjh3QS7dfb/srzqrr9jWcGLs823pr/uo2xr76HC/UsjWBQ
         1tEDv7nDkuR4zHrh/tzJE+9oS0uyf3pE301DDHT2pyiw6NR1c/+SRP3ADI5GC3jUpn7G
         bTv6eu/ccbJYmwHRVUqAyMJOHqTU2uE7uu0Hipj1rWDvnygFxGv5CImhxFThkg125S1C
         3rOoZE71SVZNR9xWsOD33PAoIL6bnHfs+teEPchumyOvR/Y6E/bfRxTBvVexGxZH1J5t
         +HQA==
X-Gm-Message-State: ALoCoQnv4BmrlLR8QpGiOlCxhbLBfK8SnqswUhXoEfIozCIgz3sAo1IFU2EiR24ndIiq+X4FvbO6
X-Received: by 10.236.41.234 with SMTP id h70mr1324286yhb.42.1392332967163;
        Thu, 13 Feb 2014 15:09:27 -0800 (PST)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id o30si550725yhn.1.2014.02.13.15.09.27
        for <git@vger.kernel.org>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Feb 2014 15:09:27 -0800 (PST)
Received: from wince.sfo.corp.google.com (wince.sfo.corp.google.com [172.31.53.43])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id DCB6F5A42B7
	for <git@vger.kernel.org>; Thu, 13 Feb 2014 15:09:26 -0800 (PST)
Received: by wince.sfo.corp.google.com (Postfix, from userid 138314)
	id 5369640735; Thu, 13 Feb 2014 15:09:26 -0800 (PST)
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242088>

This is a first step in making the codebase thread-safe.  By and
large, the operations which might benefit from threading are those
that work with pack files (e.g., checkout, blame), so the focus of
this patch is stop leaking the global list of pack files outside of
sha1_file.c.

The next step will be to control access to the list of pack files
with a mutex.  However, that alone is not enough to make pack file
access thread safe.  Even in a read-only operation, the window list
associated with each pack file will need to be controlled.
Additionally, the global counters in sha1_file.c will need to be
controlled.

This patch is a pure refactor with no functional changes, so it
shouldn't require any additional tests.  Adding the actual locks
will be a functional change, and will require additional tests.

Signed-off-by: Stefan Zager <szager@chromium.org>
---
 builtin/count-objects.c  |  44 ++++++-----
 builtin/fsck.c           |  46 +++++++-----
 builtin/gc.c             |  26 +++----
 builtin/pack-objects.c   | 189 ++++++++++++++++++++++++++++-------------------
 builtin/pack-redundant.c |  37 +++++++---
 cache.h                  |  18 ++++-
 fast-import.c            |   4 +-
 http-backend.c           |  28 ++++---
 http-push.c              |   4 +-
 http-walker.c            |   2 +-
 pack-revindex.c          |  20 ++---
 server-info.c            |  36 ++++-----
 sha1_file.c              |  52 ++++++++++---
 sha1_name.c              |  18 ++++-
 14 files changed, 327 insertions(+), 197 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index a7f70cb..a27c006 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -83,14 +83,32 @@ static char const * const count_objects_usage[] = {
 	NULL
 };
 
+struct pack_data {
+	unsigned long packed;
+	off_t size_pack;
+	unsigned long num_pack;
+};
+
+static int count_pack_objects(struct packed_git *p, void *data)
+{
+	struct pack_data *pd = (struct pack_data *) data;
+	if (p->pack_local && !open_pack_index(p)) {
+		pd->packed += p->num_objects;
+		pd->size_pack += p->pack_size + p->index_size;
+		pd->num_pack++;
+	}
+	return 0;
+}
+
 int cmd_count_objects(int argc, const char **argv, const char *prefix)
 {
 	int i, verbose = 0, human_readable = 0;
 	const char *objdir = get_object_directory();
 	int len = strlen(objdir);
 	char *path = xmalloc(len + 50);
-	unsigned long loose = 0, packed = 0, packed_loose = 0;
+	unsigned long loose = 0, packed_loose = 0;
 	off_t loose_size = 0;
+	struct pack_data pd = {0, 0, 0};
 	struct option opts[] = {
 		OPT__VERBOSE(&verbose, N_("be verbose")),
 		OPT_BOOL('H', "human-readable", &human_readable,
@@ -118,41 +136,29 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 		closedir(d);
 	}
 	if (verbose) {
-		struct packed_git *p;
-		unsigned long num_pack = 0;
-		off_t size_pack = 0;
 		struct strbuf loose_buf = STRBUF_INIT;
 		struct strbuf pack_buf = STRBUF_INIT;
 		struct strbuf garbage_buf = STRBUF_INIT;
-		if (!packed_git)
-			prepare_packed_git();
-		for (p = packed_git; p; p = p->next) {
-			if (!p->pack_local)
-				continue;
-			if (open_pack_index(p))
-				continue;
-			packed += p->num_objects;
-			size_pack += p->pack_size + p->index_size;
-			num_pack++;
-		}
+		prepare_packed_git();
+		foreach_packed_git(count_pack_objects, NULL, &pd);
 
 		if (human_readable) {
 			strbuf_humanise_bytes(&loose_buf, loose_size);
-			strbuf_humanise_bytes(&pack_buf, size_pack);
+			strbuf_humanise_bytes(&pack_buf, pd.size_pack);
 			strbuf_humanise_bytes(&garbage_buf, size_garbage);
 		} else {
 			strbuf_addf(&loose_buf, "%lu",
 				    (unsigned long)(loose_size / 1024));
 			strbuf_addf(&pack_buf, "%lu",
-				    (unsigned long)(size_pack / 1024));
+				    (unsigned long)(pd.size_pack / 1024));
 			strbuf_addf(&garbage_buf, "%lu",
 				    (unsigned long)(size_garbage / 1024));
 		}
 
 		printf("count: %lu\n", loose);
 		printf("size: %s\n", loose_buf.buf);
-		printf("in-pack: %lu\n", packed);
-		printf("packs: %lu\n", num_pack);
+		printf("in-pack: %lu\n", pd.packed);
+		printf("packs: %lu\n", pd.num_pack);
 		printf("size-pack: %s\n", pack_buf.buf);
 		printf("prune-packable: %lu\n", packed_loose);
 		printf("garbage: %lu\n", garbage);
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 1affdd5..1c77822 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -624,6 +624,29 @@ static struct option fsck_opts[] = {
 	OPT_END(),
 };
 
+struct verify_packs_data {
+	struct progress *progress;
+	uint32_t total;
+	uint32_t count;
+};
+
+static int count_pack(struct packed_git *p, void *data)
+{
+	struct verify_packs_data *vpd = (struct verify_packs_data *) data;
+	if (!open_pack_index(p))
+		vpd->total++;
+	return 0;
+}
+
+static int verify_one_pack(struct packed_git *p, void *data)
+{
+	struct verify_packs_data *vpd = (struct verify_packs_data *) data;
+	if (verify_pack(p, fsck_obj_buffer, vpd->progress, vpd->count))
+		errors_found |= ERROR_PACK;
+	vpd->count += p->num_objects;
+	return 0;
+}
+
 int cmd_fsck(int argc, const char **argv, const char *prefix)
 {
 	int i, heads;
@@ -657,29 +680,16 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	}
 
 	if (check_full) {
-		struct packed_git *p;
-		uint32_t total = 0, count = 0;
-		struct progress *progress = NULL;
+		struct verify_packs_data vpd = {0, 0, 0};
 
 		prepare_packed_git();
 
 		if (show_progress) {
-			for (p = packed_git; p; p = p->next) {
-				if (open_pack_index(p))
-					continue;
-				total += p->num_objects;
-			}
-
-			progress = start_progress("Checking objects", total);
-		}
-		for (p = packed_git; p; p = p->next) {
-			/* verify gives error messages itself */
-			if (verify_pack(p, fsck_obj_buffer,
-					progress, count))
-				errors_found |= ERROR_PACK;
-			count += p->num_objects;
+			foreach_packed_git(count_pack, NULL, &vpd);
+			vpd.progress = start_progress("Checking objects", vpd.total);
 		}
-		stop_progress(&progress);
+		foreach_packed_git(verify_one_pack, NULL, &vpd);
+		stop_progress(&vpd.progress);
 	}
 
 	heads = 0;
diff --git a/builtin/gc.c b/builtin/gc.c
index c19545d..cfeba37 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -125,26 +125,26 @@ static int too_many_loose_objects(void)
 	return needed;
 }
 
+static int count_pack(struct packed_git *p, void *data)
+{
+	/*
+	 * Perhaps check the size of the pack and count only
+	 * very small ones here?
+	 */
+	if (p->pack_local && !p->pack_keep)
+		(*((int *) data))++;
+	return 0;
+}
+
 static int too_many_packs(void)
 {
-	struct packed_git *p;
-	int cnt;
+	int cnt = 0;
 
 	if (gc_auto_pack_limit <= 0)
 		return 0;
 
 	prepare_packed_git();
-	for (cnt = 0, p = packed_git; p; p = p->next) {
-		if (!p->pack_local)
-			continue;
-		if (p->pack_keep)
-			continue;
-		/*
-		 * Perhaps check the size of the pack and count only
-		 * very small ones here?
-		 */
-		cnt++;
-	}
+	foreach_packed_git(count_pack, NULL, &cnt);
 	return gc_auto_pack_limit <= cnt;
 }
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 541667f..d5bbdfb 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -900,14 +900,48 @@ static int no_try_delta(const char *path)
 	return 0;
 }
 
+struct find_pack_data {
+	const unsigned char *sha1;
+	off_t offset;
+	struct packed_git *found_pack;
+	int exclude_or_incremental;
+	int found_non_local_pack;
+	int found_pack_keep;
+};
+
+static int search_pack(struct packed_git *p, void *data)
+{
+	struct find_pack_data *fpd = (struct find_pack_data *) data;
+	off_t offset = find_pack_entry_one(fpd->sha1, p);
+	if (offset) {
+		if (!fpd->found_pack) {
+			if (!is_pack_valid(p)) {
+				warning("packfile %s cannot be accessed", p->pack_name);
+				return 0;
+			}
+			fpd->offset = offset;
+			fpd->found_pack = p;
+		}
+		if (fpd->exclude_or_incremental)
+			return 1;
+		if (!p->pack_local) {
+			fpd->found_non_local_pack = 1;
+			return 1;
+		} else if (p->pack_keep) {
+			fpd->found_pack_keep = 1;
+			return 1;
+		}
+	}
+	return 0;
+}
+
 static int add_object_entry(const unsigned char *sha1, enum object_type type,
 			    const char *name, int exclude)
 {
 	struct object_entry *entry;
-	struct packed_git *p, *found_pack = NULL;
-	off_t found_offset = 0;
 	int ix;
 	uint32_t hash = name_hash(name);
+	struct find_pack_data fpd;
 
 	ix = nr_objects ? locate_object_entry_hash(sha1) : -1;
 	if (ix >= 0) {
@@ -923,27 +957,16 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 	if (!exclude && local && has_loose_object_nonlocal(sha1))
 		return 0;
 
-	for (p = packed_git; p; p = p->next) {
-		off_t offset = find_pack_entry_one(sha1, p);
-		if (offset) {
-			if (!found_pack) {
-				if (!is_pack_valid(p)) {
-					warning("packfile %s cannot be accessed", p->pack_name);
-					continue;
-				}
-				found_offset = offset;
-				found_pack = p;
-			}
-			if (exclude)
-				break;
-			if (incremental)
-				return 0;
-			if (local && !p->pack_local)
-				return 0;
-			if (ignore_packed_keep && p->pack_local && p->pack_keep)
-				return 0;
-		}
-	}
+	memset(&fpd, 0, sizeof(fpd));
+	fpd.sha1 = sha1;
+	fpd.exclude_or_incremental = exclude | incremental;
+
+	foreach_packed_git(search_pack, NULL, &fpd);
+	if (fpd.found_pack && !exclude &&
+	    (incremental ||
+	     (local && fpd.found_non_local_pack) ||
+	     (ignore_packed_keep && fpd.found_pack_keep)))
+		return 0;
 
 	if (nr_objects >= nr_alloc) {
 		nr_alloc = (nr_alloc  + 1024) * 3 / 2;
@@ -960,9 +983,9 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 		entry->preferred_base = 1;
 	else
 		nr_result++;
-	if (found_pack) {
-		entry->in_pack = found_pack;
-		entry->in_pack_offset = found_offset;
+	if (fpd.found_pack) {
+		entry->in_pack = fpd.found_pack;
+		entry->in_pack_offset = fpd.offset;
 	}
 
 	if (object_ix_hashsz * 3 <= nr_objects * 4)
@@ -2257,35 +2280,40 @@ static int ofscmp(const void *a_, const void *b_)
 		return hashcmp(a->object->sha1, b->object->sha1);
 }
 
-static void add_objects_in_unpacked_packs(struct rev_info *revs)
+static int add_objects_fn(struct packed_git *p, void *data)
 {
-	struct packed_git *p;
-	struct in_pack in_pack;
+	struct in_pack *ip = (struct in_pack *) data;
 	uint32_t i;
+	const unsigned char *sha1;
+	struct object *o;
 
-	memset(&in_pack, 0, sizeof(in_pack));
-
-	for (p = packed_git; p; p = p->next) {
-		const unsigned char *sha1;
-		struct object *o;
-
-		if (!p->pack_local || p->pack_keep)
-			continue;
+	if (p->pack_local && !p->pack_keep) {
 		if (open_pack_index(p))
 			die("cannot open pack index");
 
-		ALLOC_GROW(in_pack.array,
-			   in_pack.nr + p->num_objects,
-			   in_pack.alloc);
+		ALLOC_GROW(ip->array,
+			   ip->nr + p->num_objects,
+			   ip->alloc);
 
 		for (i = 0; i < p->num_objects; i++) {
 			sha1 = nth_packed_object_sha1(p, i);
 			o = lookup_unknown_object(sha1);
 			if (!(o->flags & OBJECT_ADDED))
-				mark_in_pack_object(o, p, &in_pack);
+				mark_in_pack_object(o, p, ip);
 			o->flags |= OBJECT_ADDED;
 		}
 	}
+	return 0;
+}
+
+static void add_objects_in_unpacked_packs(struct rev_info *revs)
+{
+	struct in_pack in_pack;
+	uint32_t i;
+
+	memset(&in_pack, 0, sizeof(in_pack));
+
+	foreach_packed_git(add_objects_fn, NULL, &in_pack);
 
 	if (in_pack.nr) {
 		qsort(in_pack.array, in_pack.nr, sizeof(in_pack.array[0]),
@@ -2298,54 +2326,63 @@ static void add_objects_in_unpacked_packs(struct rev_info *revs)
 	free(in_pack.array);
 }
 
+struct nonlocal_or_keep_data {
+	struct packed_git **last_found;
+	const unsigned char *sha1;
+	int found;
+};
+
+static int find_nonlocal_or_keep_fn(struct packed_git *p, void *data)
+{
+	struct nonlocal_or_keep_data *d = (struct nonlocal_or_keep_data *) data;
+	if ((!p->pack_local || p->pack_keep) &&
+	    find_pack_entry_one(d->sha1, p)) {
+		*d->last_found = p;
+		d->found = 1;
+		return 1;
+	}
+	return 0;
+}
+
 static int has_sha1_pack_kept_or_nonlocal(const unsigned char *sha1)
 {
 	static struct packed_git *last_found = (void *)1;
-	struct packed_git *p;
+	struct nonlocal_or_keep_data d;
+	struct packed_git *hint;
 
-	p = (last_found != (void *)1) ? last_found : packed_git;
+	d.last_found = &last_found;
+	d.sha1 = sha1;
+	d.found = 0;
 
-	while (p) {
-		if ((!p->pack_local || p->pack_keep) &&
-			find_pack_entry_one(sha1, p)) {
-			last_found = p;
-			return 1;
-		}
-		if (p == last_found)
-			p = packed_git;
-		else
-			p = p->next;
-		if (p == last_found)
-			p = p->next;
-	}
-	return 0;
+	hint = (last_found != (void *)1) ? last_found : NULL;
+
+	foreach_packed_git(find_nonlocal_or_keep_fn, hint, &d);
+	return d.found;
 }
 
-static void loosen_unused_packed_objects(struct rev_info *revs)
+static int loosen_unused_objects_fn(struct packed_git *p, void *data)
 {
-	struct packed_git *p;
+	const unsigned char *sha1 = (const unsigned char *) data;
 	uint32_t i;
-	const unsigned char *sha1;
 
-	for (p = packed_git; p; p = p->next) {
-		if (!p->pack_local || p->pack_keep)
-			continue;
+	if (!p->pack_local || p->pack_keep)
+		return 0;
 
-		if (unpack_unreachable_expiration &&
-		    p->mtime < unpack_unreachable_expiration)
-			continue;
+	if (unpack_unreachable_expiration &&
+		p->mtime < unpack_unreachable_expiration)
+		return 0;
 
-		if (open_pack_index(p))
-			die("cannot open pack index");
+	if (open_pack_index(p))
+		die("cannot open pack index");
 
-		for (i = 0; i < p->num_objects; i++) {
-			sha1 = nth_packed_object_sha1(p, i);
-			if (!locate_object_entry(sha1) &&
-				!has_sha1_pack_kept_or_nonlocal(sha1))
-				if (force_object_loose(sha1, p->mtime))
-					die("unable to force loose object");
-		}
+	for (i = 0; i < p->num_objects; i++) {
+		sha1 = nth_packed_object_sha1(p, i);
+		if (!locate_object_entry(sha1) &&
+			!has_sha1_pack_kept_or_nonlocal(sha1))
+			if (force_object_loose(sha1, p->mtime))
+				die("unable to force loose object");
 	}
+	return 0;
 }
 
 static void get_object_list(int ac, const char **av)
@@ -2383,7 +2420,7 @@ static void get_object_list(int ac, const char **av)
 	if (keep_unreachable)
 		add_objects_in_unpacked_packs(&revs);
 	if (unpack_unreachable)
-		loosen_unused_packed_objects(&revs);
+		foreach_packed_git(loosen_unused_objects_fn, NULL, NULL);
 }
 
 static int option_parse_index_version(const struct option *opt,
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 649c3aa..b318c24 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -567,29 +567,42 @@ static struct pack_list * add_pack(struct packed_git *p)
 		return pack_list_insert(&altodb_packs, &l);
 }
 
+struct add_pack_data {
+	const char *filename;
+	int found;
+	struct pack_list *added_pack;
+};
+
+static int add_found_pack(struct packed_git *p, void *data)
+{
+	struct add_pack_data *apd = (struct add_pack_data *) data;
+	if (apd->filename && strstr(p->pack_name, apd->filename)) {
+		apd->found = 1;
+		apd->added_pack = add_pack(p);
+		return 1;
+	} else if (!apd->filename) {
+		add_pack(p);
+	}
+	return 0;
+}
+
 static struct pack_list * add_pack_file(const char *filename)
 {
-	struct packed_git *p = packed_git;
+	struct add_pack_data apd = {filename, 0, NULL};
 
 	if (strlen(filename) < 40)
 		die("Bad pack filename: %s", filename);
 
-	while (p) {
-		if (strstr(p->pack_name, filename))
-			return add_pack(p);
-		p = p->next;
-	}
+	foreach_packed_git(add_found_pack, NULL, &apd);
+	if (apd.found)
+		return apd.added_pack;
 	die("Filename %s not found in packed_git", filename);
 }
 
 static void load_all(void)
 {
-	struct packed_git *p = packed_git;
-
-	while (p) {
-		add_pack(p);
-		p = p->next;
-	}
+	struct add_pack_data apd = {NULL, 0, NULL};
+	foreach_packed_git(add_found_pack, NULL, &apd);
 }
 
 int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
diff --git a/cache.h b/cache.h
index dc040fb..b6bb848 100644
--- a/cache.h
+++ b/cache.h
@@ -1044,7 +1044,7 @@ struct pack_window {
 	unsigned int inuse_cnt;
 };
 
-extern struct packed_git {
+struct packed_git {
 	struct packed_git *next;
 	struct pack_window *windows;
 	off_t pack_size;
@@ -1062,7 +1062,7 @@ extern struct packed_git {
 	unsigned char sha1[20];
 	/* something like ".git/objects/pack/xxxxx.pack" */
 	char pack_name[FLEX_ARRAY]; /* more */
-} *packed_git;
+};
 
 struct pack_entry {
 	off_t offset;
@@ -1070,6 +1070,20 @@ struct pack_entry {
 	struct packed_git *p;
 };
 
+/*
+ * packed_git_foreach_fn implementations must return zero
+ * to continue the traversal, non-zero to halt.
+ */
+typedef int (*packed_git_foreach_fn)(struct packed_git *, void *);
+
+/*
+ * The 'hint' argument is for the commonly-used 'last found pack' optimization.
+ * It can be NULL.
+ */
+extern void foreach_packed_git(packed_git_foreach_fn fn, struct packed_git *hint, void *data);
+
+extern size_t packed_git_count(void);
+extern size_t packed_git_local_count(void);
 extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
 
 /* A hook for count-objects to report invalid files in pack directory */
diff --git a/fast-import.c b/fast-import.c
index 4fd18a3..11d1f22 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1037,7 +1037,7 @@ static int store_object(
 	if (e->idx.offset) {
 		duplicate_count_by_type[type]++;
 		return 1;
-	} else if (find_sha1_pack(sha1, packed_git)) {
+	} else if (find_sha1_pack(sha1, NULL)) {
 		e->type = type;
 		e->pack_id = MAX_PACK_ID;
 		e->idx.offset = 1; /* just not zero! */
@@ -1238,7 +1238,7 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 		duplicate_count_by_type[OBJ_BLOB]++;
 		truncate_pack(&checkpoint);
 
-	} else if (find_sha1_pack(sha1, packed_git)) {
+	} else if (find_sha1_pack(sha1, NULL)) {
 		e->type = OBJ_BLOB;
 		e->pack_id = MAX_PACK_ID;
 		e->idx.offset = 1; /* just not zero! */
diff --git a/http-backend.c b/http-backend.c
index d2c0a62..35e1ace 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -438,25 +438,29 @@ static void get_head(char *arg)
 	strbuf_release(&buf);
 }
 
+struct pack_info_data {
+	struct strbuf *buf;
+	size_t objdirlen;
+};
+
+static int append_pack_info(struct packed_git *p, void *data)
+{
+	struct pack_info_data *d = (struct pack_info_data *) data;
+	if (p->pack_local)
+		strbuf_addf(d->buf, "P %s\n", p->pack_name + d->objdirlen + 6);
+	return 0;
+}
+
 static void get_info_packs(char *arg)
 {
 	size_t objdirlen = strlen(get_object_directory());
 	struct strbuf buf = STRBUF_INIT;
-	struct packed_git *p;
-	size_t cnt = 0;
+	struct pack_info_data d = {&buf, objdirlen};
 
 	select_getanyfile();
 	prepare_packed_git();
-	for (p = packed_git; p; p = p->next) {
-		if (p->pack_local)
-			cnt++;
-	}
-
-	strbuf_grow(&buf, cnt * 53 + 2);
-	for (p = packed_git; p; p = p->next) {
-		if (p->pack_local)
-			strbuf_addf(&buf, "P %s\n", p->pack_name + objdirlen + 6);
-	}
+	strbuf_grow(&buf, packed_git_local_count() * 53 + 2);
+	foreach_packed_git(append_pack_info, NULL, &d);
 	strbuf_addch(&buf, '\n');
 
 	hdr_nocache();
diff --git a/http-push.c b/http-push.c
index d4b40c9..f2c4256 100644
--- a/http-push.c
+++ b/http-push.c
@@ -304,7 +304,7 @@ static void start_fetch_packed(struct transfer_request *request)
 	struct transfer_request *check_request = request_queue_head;
 	struct http_pack_request *preq;
 
-	target = find_sha1_pack(request->obj->sha1, repo->packs);
+	target = repo->packs ? find_sha1_pack(request->obj->sha1, repo->packs) : NULL;
 	if (!target) {
 		fprintf(stderr, "Unable to fetch %s, will not be able to update server info refs\n", sha1_to_hex(request->obj->sha1));
 		repo->can_update_info_refs = 0;
@@ -677,7 +677,7 @@ static int add_send_request(struct object *obj, struct remote_lock *lock)
 		get_remote_object_list(obj->sha1[0]);
 	if (obj->flags & (REMOTE | PUSHING))
 		return 0;
-	target = find_sha1_pack(obj->sha1, repo->packs);
+	target = repo->packs ? find_sha1_pack(obj->sha1, repo->packs) : NULL;
 	if (target) {
 		obj->flags |= REMOTE;
 		return 0;
diff --git a/http-walker.c b/http-walker.c
index 1516c5e..d9d758a 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -405,7 +405,7 @@ static int http_fetch_pack(struct walker *walker, struct alt_base *repo, unsigne
 
 	if (fetch_indices(walker, repo))
 		return -1;
-	target = find_sha1_pack(sha1, repo->packs);
+	target = repo->packs ? find_sha1_pack(sha1, repo->packs) : NULL;
 	if (!target)
 		return -1;
 
diff --git a/pack-revindex.c b/pack-revindex.c
index b4d2b35..1f4d903 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -40,23 +40,25 @@ static int pack_revindex_ix(struct packed_git *p)
 	return -1 - i;
 }
 
+static int init_revindex(struct packed_git *p, void *data)
+{
+	/* revindex elements are lazily initialized */
+	int num = pack_revindex_ix(p);
+	num = - 1 - num;
+	pack_revindex[num].p = p;
+	return 0;
+}
+
 static void init_pack_revindex(void)
 {
 	int num;
-	struct packed_git *p;
 
-	for (num = 0, p = packed_git; p; p = p->next)
-		num++;
+	num = packed_git_count();
 	if (!num)
 		return;
 	pack_revindex_hashsz = num * 11;
 	pack_revindex = xcalloc(sizeof(*pack_revindex), pack_revindex_hashsz);
-	for (p = packed_git; p; p = p->next) {
-		num = pack_revindex_ix(p);
-		num = - 1 - num;
-		pack_revindex[num].p = p;
-	}
-	/* revindex elements are lazily initialized */
+	foreach_packed_git(init_revindex, NULL, NULL);
 }
 
 /*
diff --git a/server-info.c b/server-info.c
index 9ec744e..6286df1 100644
--- a/server-info.c
+++ b/server-info.c
@@ -151,9 +151,20 @@ static int compare_info(const void *a_, const void *b_)
 		return 1;
 }
 
+static int add_pack_info(struct packed_git *p, void *data)
+{
+	int *idx = (int *) data;
+	if (p->pack_local) {
+		info[*idx] = xcalloc(1, sizeof(struct pack_info));
+		info[*idx]->p = p;
+		info[*idx]->old_num = -1;
+		(*idx)++;
+	}
+	return 0;
+}
+
 static void init_pack_info(const char *infofile, int force)
 {
-	struct packed_git *p;
 	int stale;
 	int i = 0;
 
@@ -161,24 +172,13 @@ static void init_pack_info(const char *infofile, int force)
 	objdirlen = strlen(objdir);
 
 	prepare_packed_git();
-	for (p = packed_git; p; p = p->next) {
-		/* we ignore things on alternate path since they are
-		 * not available to the pullers in general.
-		 */
-		if (!p->pack_local)
-			continue;
-		i++;
-	}
-	num_pack = i;
+	/*
+	 * we ignore things on alternate path since they are
+	 * not available to the pullers in general.
+	 */
+	num_pack = packed_git_local_count();
 	info = xcalloc(num_pack, sizeof(struct pack_info *));
-	for (i = 0, p = packed_git; p; p = p->next) {
-		if (!p->pack_local)
-			continue;
-		info[i] = xcalloc(1, sizeof(struct pack_info));
-		info[i]->p = p;
-		info[i]->old_num = -1;
-		i++;
-	}
+	foreach_packed_git(add_pack_info, NULL, &i);
 
 	if (infofile && !force)
 		stale = read_pack_info_file(infofile);
diff --git a/sha1_file.c b/sha1_file.c
index 6e8c05d..1e2f5ad 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -60,7 +60,16 @@ static struct cached_object empty_tree = {
 	0
 };
 
+static struct packed_git *packed_git;
 static struct packed_git *last_found_pack;
+static unsigned int pack_used_ctr;
+static unsigned int pack_mmap_calls;
+static unsigned int peak_pack_open_windows;
+static unsigned int pack_open_windows;
+static unsigned int pack_open_fds;
+static unsigned int pack_max_fds;
+static size_t peak_pack_mapped;
+static size_t pack_mapped;
 
 static struct cached_object *find_cached_object(const unsigned char *sha1)
 {
@@ -460,16 +469,6 @@ static int has_loose_object(const unsigned char *sha1)
 	       has_loose_object_nonlocal(sha1);
 }
 
-static unsigned int pack_used_ctr;
-static unsigned int pack_mmap_calls;
-static unsigned int peak_pack_open_windows;
-static unsigned int pack_open_windows;
-static unsigned int pack_open_fds;
-static unsigned int pack_max_fds;
-static size_t peak_pack_mapped;
-static size_t pack_mapped;
-struct packed_git *packed_git;
-
 void pack_report(void)
 {
 	fprintf(stderr,
@@ -1091,6 +1090,37 @@ struct packed_git *add_packed_git(const char *path, int path_len, int local)
 	return p;
 }
 
+void foreach_packed_git(packed_git_foreach_fn fn, struct packed_git *hint, void *data)
+{
+	struct packed_git *p;
+	if (hint && ((*fn)(hint, data)))
+		return;
+	for (p = packed_git; p; p = p->next)
+		if (p != hint && (*fn)(p, data))
+			return;
+}
+
+size_t packed_git_count(void)
+{
+	size_t res = 0;
+	struct packed_git *p;
+
+	for (p = packed_git; p; p = p->next)
+		res++;
+	return res;
+}
+
+size_t packed_git_local_count(void)
+{
+	size_t res = 0;
+	struct packed_git *p;
+
+	for (p = packed_git; p; p = p->next)
+		if (p->pack_local)
+			res++;
+	return res;
+}
+
 struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path)
 {
 	const char *path = sha1_pack_name(sha1);
@@ -2474,6 +2504,8 @@ struct packed_git *find_sha1_pack(const unsigned char *sha1,
 {
 	struct packed_git *p;
 
+	if (!packs)
+		packs = packed_git;
 	for (p = packs; p; p = p->next) {
 		if (find_pack_entry_one(sha1, p))
 			return p;
diff --git a/sha1_name.c b/sha1_name.c
index 6fca869..b8fed76 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -176,14 +176,26 @@ static void unique_in_pack(int len,
 	}
 }
 
+struct disambiguate_data {
+	int len;
+	const unsigned char *bin_pfx;
+	struct disambiguate_state *ds;
+};
+
+static int collect_short_packed_object(struct packed_git *p, void *data)
+{
+	struct disambiguate_data *d = (struct disambiguate_data *) data;
+	unique_in_pack(d->len, d->bin_pfx, p, d->ds);
+	return 0;
+}
+
 static void find_short_packed_object(int len, const unsigned char *bin_pfx,
 				     struct disambiguate_state *ds)
 {
-	struct packed_git *p;
+	struct disambiguate_data d = {len, bin_pfx, ds};
 
 	prepare_packed_git();
-	for (p = packed_git; p && !ds->ambiguous; p = p->next)
-		unique_in_pack(len, bin_pfx, p, ds);
+	foreach_packed_git(collect_short_packed_object, NULL, &d);
 }
 
 #define SHORT_NAME_NOT_FOUND (-1)
-- 
1.9.0.rc3.10.gab4a22f.dirty
