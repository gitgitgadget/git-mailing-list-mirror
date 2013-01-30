From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 4/6] introduce a commit metapack
Date: Wed, 30 Jan 2013 20:56:07 +0700
Message-ID: <20130130135607.GA23154@lanh>
References: <20130129091434.GA6975@sigill.intra.peff.net>
 <20130129091610.GD9999@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 30 14:56:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0Y8y-00017L-9h
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 14:56:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754652Ab3A3Nzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 08:55:42 -0500
Received: from mail-pb0-f41.google.com ([209.85.160.41]:47990 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754433Ab3A3Nzk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 08:55:40 -0500
Received: by mail-pb0-f41.google.com with SMTP id ro12so987814pbb.0
        for <git@vger.kernel.org>; Wed, 30 Jan 2013 05:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=M8EKs8BT3dVYzokM9fNlcyJQ+CsQdWFY+8Rx2di8U4c=;
        b=OAHjvCWcY0+3NKF+M9rSLuA6BZy61XC6/IRS5iHsMRFW9oHOhNBd6GDhdnQHVcW6p5
         0byA9sAEC/Z3YXEw1HNFh+3f62e3Oi5wIOevOZg8QuBXfZEh+NGmakNNZr5mYHP4vNix
         775wR5LDXj0E8XKQqAMfQhWtpJPHiKslXY/TOpIeTENQjaQh0qDgo+rzimNbVrM7EBhg
         4KL+IAMU7s/VWgbR/8wDebE+l6FkFAG9mbMyLfuA9UAafMTUJ1hsvhGbqw90bqy8ivbG
         NWHij5h3AYwrRW8z/TeAduTtCqfJC7bTi8ctFAT6sONJf0kKIeRZRud+yjm8ejRTAu7f
         A6vg==
X-Received: by 10.68.228.164 with SMTP id sj4mr12723191pbc.126.1359554139558;
        Wed, 30 Jan 2013 05:55:39 -0800 (PST)
Received: from lanh ([115.74.36.51])
        by mx.google.com with ESMTPS id bi8sm2135675pab.15.2013.01.30.05.55.33
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Jan 2013 05:55:38 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 30 Jan 2013 20:56:07 +0700
Content-Disposition: inline
In-Reply-To: <20130129091610.GD9999@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215017>

On Tue, Jan 29, 2013 at 04:16:11AM -0500, Jeff King wrote:
> When we are doing a commit traversal that does not need to
> look at the commit messages themselves (e.g., rev-list,
> merge-base, etc), we spend a lot of time accessing,
> decompressing, and parsing the commit objects just to find
> the parent and timestamp information. We can make a
> space-time tradeoff by caching that information on disk in a
> compact, uncompressed format.

And this is a (messy) patch on top that avoids storing SHA-1
directly. On my linux-2.6.git (575 MB pack, 73 MB index), .commits
file is 5.2 MB and 27 MB with and without my patch respectively. Nice
shrinkage.

However, performance seems to suffer too. Maybe I do more lookups than
necessary, I don't know. I should probably measure the cost of
revindex separately.

git rev-list --all --quiet on vanilla git:

real    0m3.645s
user    0m3.556s
sys     0m0.080s

commit cache without my patch:

real    0m0.723s
user    0m0.677s
sys     0m0.045s

and with my patch:

real    0m1.338s
user    0m1.259s
sys     0m0.075s


Another point, but not really important at this stage, I think we have
memory leak somewhere (lookup_commit??). It used up to 800 MB RES on
linux-2.6.git while generating the cache.

-- 8< --
diff --git a/cache.h b/cache.h
index 1f96f65..8048d5b 100644
--- a/cache.h
+++ b/cache.h
@@ -1069,6 +1069,7 @@ extern struct packed_git *add_packed_git(const char *, int, int);
 extern const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t);
 extern off_t nth_packed_object_offset(const struct packed_git *, uint32_t);
 extern off_t find_pack_entry_one(const unsigned char *, struct packed_git *);
+extern int find_pack_entry_pos(const unsigned char *, struct packed_git *);
 extern int is_pack_valid(struct packed_git *);
 extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
 extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
diff --git a/commit-metapack.c b/commit-metapack.c
index 2c19f48..55f7ea9 100644
--- a/commit-metapack.c
+++ b/commit-metapack.c
@@ -3,11 +3,12 @@
 #include "metapack.h"
 #include "commit.h"
 #include "sha1-lookup.h"
+#include "pack-revindex.h"
 
 struct commit_metapack {
 	struct metapack mp;
-	uint32_t nr;
-	unsigned char *index;
+	struct packed_git *pack;
+	uint32_t first, last;
 	unsigned char *data;
 	struct commit_metapack *next;
 };
@@ -16,7 +17,7 @@ static struct commit_metapack *commit_metapacks;
 static struct commit_metapack *alloc_commit_metapack(struct packed_git *pack)
 {
 	struct commit_metapack *it = xcalloc(1, sizeof(*it));
-	uint32_t version;
+	uint32_t version, nr;
 
 	if (metapack_init(&it->mp, pack, "commits", &version) < 0) {
 		free(it);
@@ -39,22 +40,25 @@ static struct commit_metapack *alloc_commit_metapack(struct packed_git *pack)
 		free(it);
 		return NULL;
 	}
-	memcpy(&it->nr, it->mp.data, 4);
-	it->nr = ntohl(it->nr);
+	memcpy(&it->first, it->mp.data, 4);
+	it->first = ntohl(it->first);
+	memcpy(&it->last, it->mp.data + 4, 4);
+	it->last = ntohl(it->last);
+	nr = it->last - it->first + 1;
+	it->pack = pack;
 
 	/*
-	 * We need 84 bytes for each entry: sha1(20), date(4), tree(20),
-	 * parents(40).
+	 * We need 16 bytes for each entry: date(4), tree index(4),
+	 * parent indexes(8).
 	 */
-	if (it->mp.len < (84 * it->nr + 4)) {
+	if (it->mp.len < (16 * nr + 8)) {
 		warning("commit metapack for '%s' is truncated", pack->pack_name);
 		metapack_close(&it->mp);
 		free(it);
 		return NULL;
 	}
 
-	it->index = it->mp.data + 4;
-	it->data = it->index + 20 * it->nr;
+	it->data = it->mp.data + 8;
 
 	return it;
 }
@@ -81,31 +85,61 @@ static void prepare_commit_metapacks(void)
 	initialized = 1;
 }
 
+static const unsigned char *idx_to_sha1(struct packed_git *p,
+					uint32_t nth)
+{
+	struct revindex_entry *revindex = get_revindex(p);
+	if (!revindex)
+		return NULL;
+	return nth_packed_object_sha1(p, revindex[nth].nr);
+}
+
 int commit_metapack(unsigned char *sha1,
 		    uint32_t *timestamp,
-		    unsigned char **tree,
-		    unsigned char **parent1,
-		    unsigned char **parent2)
+		    const unsigned char **tree,
+		    const unsigned char **parent1,
+		    const unsigned char **parent2)
 {
 	struct commit_metapack *p;
 
 	prepare_commit_metapacks();
 	for (p = commit_metapacks; p; p = p->next) {
 		unsigned char *data;
-		int pos = sha1_entry_pos(p->index, 20, 0, 0, p->nr, p->nr, sha1);
-		if (pos < 0)
+		uint32_t p1, p2;
+		struct revindex_entry *re, *base;
+		off_t off;
+		uint32_t pos;
+
+		base = get_revindex(p->pack);
+		off = find_pack_entry_one(sha1, p->pack);
+		if (!off)
+			continue;
+		re = find_pack_revindex(p->pack, off);
+		if (!re)
+			continue;
+		pos = re - base;
+		if (pos < p->first || pos > p->last)
 			continue;
 
 		/* timestamp(4) + tree(20) + parents(40) */
-		data = p->data + 64 * pos;
+		data = p->data + 16 * (pos - p->first);
 		*timestamp = *(uint32_t *)data;
 		*timestamp = ntohl(*timestamp);
+		if (!*timestamp)
+			return -1;
 		data += 4;
-		*tree = data;
-		data += 20;
-		*parent1 = data;
-		data += 20;
-		*parent2 = data;
+		*tree = idx_to_sha1(p->pack, ntohl(*(uint32_t*)data));
+		data += 4;
+		p1 = ntohl(*(uint32_t*)data);
+		*parent1 = idx_to_sha1(p->pack, p1);
+		data += 4;
+		p2 = ntohl(*(uint32_t*)data);
+		if (p1 == p2)
+			*parent2 = null_sha1;
+		else
+			*parent2 = idx_to_sha1(p->pack, p2);
+		if (!*tree || !*parent1 || !*parent2)
+			return -1;
 
 		return 0;
 	}
@@ -113,63 +147,114 @@ int commit_metapack(unsigned char *sha1,
 	return -1;
 }
 
-static void get_commits(struct metapack_writer *mw,
-			const unsigned char *sha1,
-			void *data)
+static int get_commits(struct metapack_writer *mw,
+		       uint32_t nth,
+		       int dry_run)
 {
-	struct commit_list ***tail = data;
+	const unsigned char *sha1 = nth_packed_object_sha1(mw->pack, nth);
 	enum object_type type = sha1_object_info(sha1, NULL);
 	struct commit *c;
+	struct revindex_entry *revindex, *ridx;
+	int pt, p1, p2 = -1;
 
-	if (type != OBJ_COMMIT)
-		return;
+	if (type != OBJ_COMMIT) {
+		if (dry_run)
+			return -1;
+		metapack_writer_add_uint32(mw, 0); /* date */
+		metapack_writer_add_uint32(mw, 0); /* tree */
+		metapack_writer_add_uint32(mw, 0); /* 1st parent */
+		metapack_writer_add_uint32(mw, 0); /* 2nd tree */
+		return 0;
+	}
 
 	c = lookup_commit(sha1);
 	if (!c || parse_commit(c))
 		die("unable to read commit %s", sha1_to_hex(sha1));
 
+	if (c->buffer) {
+		free(c->buffer);
+		c->buffer = NULL;
+	}
+
 	/*
 	 * Our fixed-size parent list cannot represent root commits, nor
 	 * octopus merges. Just skip those commits, as we can fallback
 	 * in those rare cases to reading the actual commit object.
 	 */
 	if (!c->parents ||
-	    (c->parents && c->parents->next && c->parents->next->next))
-		return;
+	    (c->parents && c->parents->next && c->parents->next->next) ||
+	    /* edge commits are out too */
+	    (pt = find_pack_entry_pos(c->tree->object.sha1, mw->pack)) == -1 ||
+	    (p1 = find_pack_entry_pos(c->parents->item->object.sha1, mw->pack)) == -1 ||
+	    (c->parents->next &&
+	     (p2 = find_pack_entry_pos(c->parents->next->item->object.sha1, mw->pack)) == -1) ||
+	    /*
+	     * we set the 2nd parent the same as 1st parent as an
+	     * indication that 2nd parent does not exist. Normal
+	     * commits should never have two same parents, but just in
+	     * case..
+	     */
+	    p1 == p2 ||
+	    /* zero date is reserved to say this is not a valid entry */
+	    c->date == 0) {
+		if (dry_run)
+			return -1;
+		metapack_writer_add_uint32(mw, 0); /* date */
+		metapack_writer_add_uint32(mw, 0); /* tree */
+		metapack_writer_add_uint32(mw, 0); /* 1st parent */
+		metapack_writer_add_uint32(mw, 0); /* 2nd tree */
+		return 0;
+	}
+
+	if (dry_run)
+		return 0;
+
+	revindex = get_revindex(mw->pack);
 
-	*tail = &commit_list_insert(c, *tail)->next;
+	metapack_writer_add_uint32(mw, c->date);
+	ridx = find_pack_revindex(mw->pack,
+				  nth_packed_object_offset(mw->pack, pt));
+	metapack_writer_add_uint32(mw, ridx - revindex);
+	ridx = find_pack_revindex(mw->pack,
+				  nth_packed_object_offset(mw->pack, p1));
+	metapack_writer_add_uint32(mw, ridx - revindex);
+	if (p2 != -1)
+		ridx = find_pack_revindex(mw->pack,
+					  nth_packed_object_offset(mw->pack, p2));
+	metapack_writer_add_uint32(mw, ridx - revindex);
+	return 0;
 }
 
 void commit_metapack_write(const char *idx)
 {
 	struct metapack_writer mw;
-	struct commit_list *commits = NULL, *p;
-	struct commit_list **tail = &commits;
-	uint32_t nr = 0;
+	uint32_t i, first = 0xffffffff, last = 0;
+	struct revindex_entry *revidx;
 
 	metapack_writer_init(&mw, idx, "commits", 1);
 
-	/* Figure out how many eligible commits we've got in this pack. */
-	metapack_writer_foreach(&mw, get_commits, &tail);
-	for (p = commits; p; p = p->next)
-		nr++;
-	metapack_writer_add_uint32(&mw, nr);
+	packed_git = mw.pack;
+	revidx = get_revindex(mw.pack);
 
-	/* Then write an index of commit sha1s */
-	for (p = commits; p; p = p->next)
-		metapack_writer_add(&mw, p->item->object.sha1, 20);
+	/*
+	 * Figure out how many eligible commits we've got in this pack.
+	 */
+	for (i = 0; i < mw.pack->num_objects; i++) {
+		int ret = get_commits(&mw, revidx[i].nr, 1);
+		if (ret == -1)	/* not cached */
+			continue;
+		if (i < first)
+			first = i;
+		if (i > last)
+			last = i;
+	}
+
+	metapack_writer_add_uint32(&mw, first);
+	metapack_writer_add_uint32(&mw, last);
 
 	/* Followed by the actual date/tree/parents data */
-	for (p = commits; p; p = p->next) {
-		struct commit *c = p->item;
-		metapack_writer_add_uint32(&mw, c->date);
-		metapack_writer_add(&mw, c->tree->object.sha1, 20);
-		metapack_writer_add(&mw, c->parents->item->object.sha1, 20);
-		metapack_writer_add(&mw,
-				    c->parents->next ?
-				    c->parents->next->item->object.sha1 :
-				    null_sha1, 20);
-	}
+	for (i = first; i <= last; i++)
+		get_commits(&mw, revidx[i].nr, 0);
 
 	metapack_writer_finish(&mw);
 }
diff --git a/commit-metapack.h b/commit-metapack.h
index 4684573..caf85be 100644
--- a/commit-metapack.h
+++ b/commit-metapack.h
@@ -3,9 +3,9 @@
 
 int commit_metapack(unsigned char *sha1,
 		    uint32_t *timestamp,
-		    unsigned char **tree,
-		    unsigned char **parent1,
-		    unsigned char **parent2);
+		    const unsigned char **tree,
+		    const unsigned char **parent1,
+		    const unsigned char **parent2);
 
 void commit_metapack_write(const char *idx_file);
 
diff --git a/pack-revindex.c b/pack-revindex.c
index 77a0465..d58dd02 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -111,12 +111,10 @@ static void create_pack_revindex(struct pack_revindex *rix)
 	qsort(rix->revindex, num_ent, sizeof(*rix->revindex), cmp_offset);
 }
 
-struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs)
+struct revindex_entry *get_revindex(struct packed_git *p)
 {
 	int num;
-	int lo, hi;
 	struct pack_revindex *rix;
-	struct revindex_entry *revindex;
 
 	if (!pack_revindex_hashsz)
 		init_pack_revindex();
@@ -127,7 +125,13 @@ struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs)
 	rix = &pack_revindex[num];
 	if (!rix->revindex)
 		create_pack_revindex(rix);
-	revindex = rix->revindex;
+	return rix->revindex;
+}
+
+struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs)
+{
+	int lo, hi;
+	struct revindex_entry *revindex = get_revindex(p);
 
 	lo = 0;
 	hi = p->num_objects + 1;
diff --git a/pack-revindex.h b/pack-revindex.h
index 8d5027a..cea85db 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -6,6 +6,7 @@ struct revindex_entry {
 	unsigned int nr;
 };
 
+struct revindex_entry *get_revindex(struct packed_git *p);
 struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs);
 void discard_revindex(void);
 
diff --git a/sha1_file.c b/sha1_file.c
index 40b2329..1acab8c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1978,8 +1978,8 @@ off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
 	}
 }
 
-off_t find_pack_entry_one(const unsigned char *sha1,
-				  struct packed_git *p)
+int find_pack_entry_pos(const unsigned char *sha1,
+			struct packed_git *p)
 {
 	const uint32_t *level1_ofs = p->index_data;
 	const unsigned char *index = p->index_data;
@@ -1992,7 +1992,7 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 
 	if (!index) {
 		if (open_pack_index(p))
-			return 0;
+			return -1;
 		level1_ofs = p->index_data;
 		index = p->index_data;
 	}
@@ -2019,9 +2019,7 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 	if (use_lookup) {
 		int pos = sha1_entry_pos(index, stride, 0,
 					 lo, hi, p->num_objects, sha1);
-		if (pos < 0)
-			return 0;
-		return nth_packed_object_offset(p, pos);
+		return pos;
 	}
 
 	do {
@@ -2032,15 +2030,24 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 			printf("lo %u hi %u rg %u mi %u\n",
 			       lo, hi, hi - lo, mi);
 		if (!cmp)
-			return nth_packed_object_offset(p, mi);
+			return mi;
 		if (cmp > 0)
 			hi = mi;
 		else
 			lo = mi+1;
 	} while (lo < hi);
-	return 0;
+	return -1;
 }
 
+off_t find_pack_entry_one(const unsigned char *sha1,
+				  struct packed_git *p)
+{
+	int pos = find_pack_entry_pos(sha1, p);
+	if (pos < 0)
+		return 0;
+	else
+		return nth_packed_object_offset(p, pos);
+}
 int is_pack_valid(struct packed_git *p)
 {
 	/* An already open pack is known to be valid. */
-- 
1.8.1.1.459.g5970e58

-- 8< --
