From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 4/6] introduce a commit metapack
Date: Thu, 31 Jan 2013 18:06:56 +0700
Message-ID: <20130131110656.GA28093@lanh>
References: <20130129091434.GA6975@sigill.intra.peff.net>
 <20130129091610.GD9999@sigill.intra.peff.net>
 <20130130135607.GA23154@lanh>
 <CACsJy8Bqg6knVtddwaGSqtiXzVDgbO1JjbFOPMbF_RqrxM2rFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 31 12:06:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0ryg-0000FZ-Ay
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 12:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566Ab3AaLGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 06:06:24 -0500
Received: from mail-pb0-f42.google.com ([209.85.160.42]:56143 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282Ab3AaLGW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 06:06:22 -0500
Received: by mail-pb0-f42.google.com with SMTP id wz17so1571300pbc.1
        for <git@vger.kernel.org>; Thu, 31 Jan 2013 03:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=aH+w+MtjSapzsto+QAY4uf4PMLOI4nyT3GLta20rBKw=;
        b=NXUEeaJ6eovMBd2N5mZrLnSS50OhW/kayhaiSNOlIxVa73HNalvIB7qxrA36nvHReS
         h9NhZBHUCEcL21X8H8DRbC6nIbcFoZLR27FEwnKokG3fQDAuNxwr4VrkrWggzZTC6bt5
         BCwENK038MX9Phsqur6WAmoJFeBNzp+EzcKtRKtQAOUVhVBUtxScZDdLc3CBzQdnhdN8
         uHn1v/2JbrKzWjmS/7CRF9Rvu74V52F+rjAHNnhD+yLr/v+v/pZZz4BMUNupsuJ1psfx
         2UiANPmfVpuLdq884JEjRPLgLUkXkRVGR2mSEqcpHDao5GV+in5XjQEQrYD3P7HkYjWP
         v2Fg==
X-Received: by 10.66.81.198 with SMTP id c6mr19550987pay.50.1359630381448;
        Thu, 31 Jan 2013 03:06:21 -0800 (PST)
Received: from lanh ([115.74.36.51])
        by mx.google.com with ESMTPS id vk5sm4710707pbc.34.2013.01.31.03.06.17
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 31 Jan 2013 03:06:20 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 31 Jan 2013 18:06:56 +0700
Content-Disposition: inline
In-Reply-To: <CACsJy8Bqg6knVtddwaGSqtiXzVDgbO1JjbFOPMbF_RqrxM2rFQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215112>

On Wed, Jan 30, 2013 at 09:16:29PM +0700, Duy Nguyen wrote:
> Perhaps we could store abbrev sha-1 instead of full sha-1. Nice
> space/time trade-off.

Following the on-disk format experiment yesterday, I changed the
format to:

 - a list a _short_ SHA-1 of cached commits
 - a list of cache entries, each (5 uint32_t) consists of:
   - uint32_t for the index in .idx sha-1 table to get full SHA-1 of
     the commit
   - uint32_t for timestamp
   - uint32_t for tree, 1st and 2nd parents for the index in .idx
     table

The length of SHA-1 is chosen to be able to unambiguously identify any
cached commits. Full SHA-1 check is done after to catch false
positives. For linux-2.6, SHA-1 length is 6 bytes, git and many
moderate-sized projects are 4 bytes. So it's 26 bytes per commit for
linux-2.6.git, or 8MB .commits file. Not as good as revindex approach
(5.5MB) but way better than the current one (27MB). And still good
enough for caching 2 parents unconditionally.

Performance seems to improve a tiny bit, probably because of more
compact search space: 0.6s with my patch vs 0.7s without (vs 3.4s
without cache).

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
index 2c19f48..c984b8e 100644
--- a/commit-metapack.c
+++ b/commit-metapack.c
@@ -4,11 +4,21 @@
 #include "commit.h"
 #include "sha1-lookup.h"
 
+struct commit_entry {
+	uint32_t commit;	/* nth_packed_object_sha1 to get own SHA-1 */
+	uint32_t timestamp;
+	uint32_t tree;		/* nth_packed_object_sha1 to get tree SHA-1 */
+	uint32_t parent1; /* nth_packed_object_sha1 to get 1st parent SHA-1 */
+	uint32_t parent2; /* nth_packed_object_sha1 to get 2nd parent SHA-1 */
+};
+
 struct commit_metapack {
 	struct metapack mp;
 	uint32_t nr;
+	uint32_t abbrev_len;
+	struct packed_git *pack;
 	unsigned char *index;
-	unsigned char *data;
+	struct commit_entry *data;
 	struct commit_metapack *next;
 };
 static struct commit_metapack *commit_metapacks;
@@ -41,20 +51,23 @@ static struct commit_metapack *alloc_commit_metapack(struct packed_git *pack)
 	}
 	memcpy(&it->nr, it->mp.data, 4);
 	it->nr = ntohl(it->nr);
+	memcpy(&it->abbrev_len, it->mp.data + 4, 4);
+	it->abbrev_len = ntohl(it->abbrev_len);
+	it->pack = pack;
 
 	/*
-	 * We need 84 bytes for each entry: sha1(20), date(4), tree(20),
-	 * parents(40).
+	 * We need 20+abbrev_len bytes for each entry: abbrev sha-1,
+	 * date(4), tree index(4), parent indexes(8).
 	 */
-	if (it->mp.len < (84 * it->nr + 4)) {
+	if (it->mp.len < ((sizeof(*it->data) + it->abbrev_len) * it->nr + 8)) {
 		warning("commit metapack for '%s' is truncated", pack->pack_name);
 		metapack_close(&it->mp);
 		free(it);
 		return NULL;
 	}
 
-	it->index = it->mp.data + 4;
-	it->data = it->index + 20 * it->nr;
+	it->index = it->mp.data + 8;
+	it->data = (struct commit_entry*)(it->index + it->abbrev_len * it->nr);
 
 	return it;
 }
@@ -83,29 +96,51 @@ static void prepare_commit_metapacks(void)
 
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
-		unsigned char *data;
-		int pos = sha1_entry_pos(p->index, 20, 0, 0, p->nr, p->nr, sha1);
+		struct commit_entry *data;
+		uint32_t p1, p2;
+		unsigned lo, hi, mi;
+		int pos;
+
+		/* sha1_entry_pos does not work with abbreviated sha-1 */
+		lo = 0;
+		hi = p->nr;
+		pos = -1;
+		do {
+			unsigned mi = (lo + hi) / 2;
+			int cmp = memcmp(p->index + mi * p->abbrev_len, sha1, p->abbrev_len);
+
+			if (!cmp) {
+				pos = mi;
+				break;
+			}
+			if (cmp > 0)
+				hi = mi;
+			else
+				lo = mi+1;
+		} while (lo < hi);
 		if (pos < 0)
 			continue;
 
-		/* timestamp(4) + tree(20) + parents(40) */
-		data = p->data + 64 * pos;
-		*timestamp = *(uint32_t *)data;
-		*timestamp = ntohl(*timestamp);
-		data += 4;
-		*tree = data;
-		data += 20;
-		*parent1 = data;
-		data += 20;
-		*parent2 = data;
+		data = p->data + pos;
+
+		/* full sha-1 check again */
+		if (hashcmp(nth_packed_object_sha1(p->pack, ntohl(data->commit)), sha1))
+			continue;
+
+		*timestamp = ntohl(data->timestamp);
+		*tree = nth_packed_object_sha1(p->pack, ntohl(data->tree));
+		p1 = ntohl(data->parent1);
+		*parent1 = nth_packed_object_sha1(p->pack, p1);
+		p2 = ntohl(data->parent2);
+		*parent2 = p1 == p2 ? null_sha1 : nth_packed_object_sha1(p->pack, p2);
 
 		return 0;
 	}
@@ -113,13 +148,20 @@ int commit_metapack(unsigned char *sha1,
 	return -1;
 }
 
+struct write_cb {
+	struct commit_list **tail;
+	int abbrev_len;
+	const unsigned char *last_sha1;
+};
+
 static void get_commits(struct metapack_writer *mw,
 			const unsigned char *sha1,
 			void *data)
 {
-	struct commit_list ***tail = data;
+	struct write_cb *write_cb = (struct write_cb *)data;
 	enum object_type type = sha1_object_info(sha1, NULL);
 	struct commit *c;
+	int p1, p2;
 
 	if (type != OBJ_COMMIT)
 		return;
@@ -128,47 +170,95 @@ static void get_commits(struct metapack_writer *mw,
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
+	    (c->parents && c->parents->next && c->parents->next->next) ||
+	    /* edge commits are out too */
+	    find_pack_entry_pos(c->tree->object.sha1, mw->pack) == -1 ||
+	    (p1 = find_pack_entry_pos(c->parents->item->object.sha1, mw->pack)) == -1 ||
+	    (c->parents->next &&
+	     (p2 = find_pack_entry_pos(c->parents->next->item->object.sha1, mw->pack)) == -1) ||
+	    /*
+	     * we set the 2nd parent the same as 1st parent as an
+	     * indication that 2nd parent does not exist. Normal
+	     * commits should never have two same parents, but just in
+	     * case..
+	     */
+	    p1 == p2)
 		return;
 
-	*tail = &commit_list_insert(c, *tail)->next;
+	/*
+	 * Make sure we store the abbr sha-1 long enough to
+	 * unambiguously identify any cached commits in the pack.
+	 */
+	while (write_cb->abbrev_len < 20 &&
+	       write_cb->last_sha1 &&
+	       !memcmp(write_cb->last_sha1, sha1, write_cb->abbrev_len))
+		write_cb->abbrev_len++;
+	/*
+	 * A bit sensitive to metapack_writer_foreach. "sha1" must not
+	 * be changed even after this function exits.
+	 */
+	write_cb->last_sha1 = sha1;
+
+	write_cb->tail = &commit_list_insert(c, write_cb->tail)->next;
 }
 
 void commit_metapack_write(const char *idx)
 {
 	struct metapack_writer mw;
 	struct commit_list *commits = NULL, *p;
-	struct commit_list **tail = &commits;
+	struct write_cb write_cb;
 	uint32_t nr = 0;
 
 	metapack_writer_init(&mw, idx, "commits", 1);
 
+	write_cb.tail = &commits;
+	write_cb.abbrev_len = 1;
+	write_cb.last_sha1 = NULL;
+
 	/* Figure out how many eligible commits we've got in this pack. */
-	metapack_writer_foreach(&mw, get_commits, &tail);
+	metapack_writer_foreach(&mw, get_commits, &write_cb);
 	for (p = commits; p; p = p->next)
 		nr++;
+
 	metapack_writer_add_uint32(&mw, nr);
+	metapack_writer_add_uint32(&mw, write_cb.abbrev_len);
 
 	/* Then write an index of commit sha1s */
 	for (p = commits; p; p = p->next)
-		metapack_writer_add(&mw, p->item->object.sha1, 20);
+		metapack_writer_add(&mw, p->item->object.sha1, write_cb.abbrev_len);
 
 	/* Followed by the actual date/tree/parents data */
 	for (p = commits; p; p = p->next) {
 		struct commit *c = p->item;
+		int pos;
+
+		pos = find_pack_entry_pos(c->object.sha1, mw.pack);
+		metapack_writer_add_uint32(&mw, pos);
+
 		metapack_writer_add_uint32(&mw, c->date);
-		metapack_writer_add(&mw, c->tree->object.sha1, 20);
-		metapack_writer_add(&mw, c->parents->item->object.sha1, 20);
-		metapack_writer_add(&mw,
-				    c->parents->next ?
-				    c->parents->next->item->object.sha1 :
-				    null_sha1, 20);
+
+		pos = find_pack_entry_pos(c->tree->object.sha1, mw.pack);
+		metapack_writer_add_uint32(&mw, pos);
+
+		pos = find_pack_entry_pos(c->parents->item->object.sha1, mw.pack);
+		metapack_writer_add_uint32(&mw, pos);
+
+		if (c->parents->next) {
+			struct object *o = &c->parents->next->item->object;
+			pos = find_pack_entry_pos(o->sha1, mw.pack);
+		}
+		metapack_writer_add_uint32(&mw, pos);
 	}
 
 	metapack_writer_finish(&mw);
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
-- 8< --
