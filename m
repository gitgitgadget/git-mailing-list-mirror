From: Jeff King <peff@peff.net>
Subject: [PATCH 57/68] avoid sprintf and strcpy with flex arrays
Date: Thu, 24 Sep 2015 17:08:12 -0400
Message-ID: <20150924210811.GB30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:08:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDkk-00028o-K6
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754437AbbIXVIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:08:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:36027 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754411AbbIXVIO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:08:14 -0400
Received: (qmail 12136 invoked by uid 102); 24 Sep 2015 21:08:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:08:14 -0500
Received: (qmail 29513 invoked by uid 107); 24 Sep 2015 21:08:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:08:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:08:12 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278602>

When we are allocating a struct with a FLEX_ARRAY member, we
generally compute the size of the array and then sprintf or
strcpy into it. Normally we could improve a dynamic allocation
like this by using xstrfmt, but it doesn't work here; we
have to account for the size of the rest of the struct.

But we can improve things a bit by storing the length that
we use for the allocation, and then feeding it to xsnprintf
or memcpy, which makes it more obvious that we are not
writing more than the allocated number of bytes.

It would be nice if we had some kind of helper for
allocating generic flex arrays, but it doesn't work that
well:

 - the call signature is a little bit unwieldy:

      d = flex_struct(sizeof(*d), offsetof(d, path), fmt, ...);

   You need offsetof here instead of just writing to the
   end of the base size, because we don't know how the
   struct is packed (partially this is because FLEX_ARRAY
   might not be zero, though we can account for that; but
   the size of the struct may actually be rounded up for
   alignment, and we can't know that).

 - some sites do clever things, like over-allocating because
   they know they will write larger things into the buffer
   later (e.g., struct packed_git here).

So we're better off to just write out each allocation (or
add type-specific helpers, though many of these are one-off
allocations anyway).

Signed-off-by: Jeff King <peff@peff.net>
---
 archive.c       | 5 +++--
 builtin/blame.c | 5 +++--
 fast-import.c   | 6 ++++--
 refs.c          | 8 ++++----
 sha1_file.c     | 5 +++--
 submodule.c     | 6 ++++--
 6 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/archive.c b/archive.c
index 01b0899..4ac86c8 100644
--- a/archive.c
+++ b/archive.c
@@ -171,13 +171,14 @@ static void queue_directory(const unsigned char *sha1,
 		unsigned mode, int stage, struct archiver_context *c)
 {
 	struct directory *d;
-	d = xmallocz(sizeof(*d) + base->len + 1 + strlen(filename));
+	size_t len = base->len + 1 + strlen(filename) + 1;
+	d = xmalloc(sizeof(*d) + len);
 	d->up	   = c->bottom;
 	d->baselen = base->len;
 	d->mode	   = mode;
 	d->stage   = stage;
 	c->bottom  = d;
-	d->len = sprintf(d->path, "%.*s%s/", (int)base->len, base->buf, filename);
+	d->len = xsnprintf(d->path, len, "%.*s%s/", (int)base->len, base->buf, filename);
 	hashcpy(d->oid.hash, sha1);
 }
 
diff --git a/builtin/blame.c b/builtin/blame.c
index e253ac0..e70fb6d 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -459,12 +459,13 @@ static void queue_blames(struct scoreboard *sb, struct origin *porigin,
 static struct origin *make_origin(struct commit *commit, const char *path)
 {
 	struct origin *o;
-	o = xcalloc(1, sizeof(*o) + strlen(path) + 1);
+	size_t pathlen = strlen(path) + 1;
+	o = xcalloc(1, sizeof(*o) + pathlen);
 	o->commit = commit;
 	o->refcnt = 1;
 	o->next = commit->util;
 	commit->util = o;
-	strcpy(o->path, path);
+	memcpy(o->path, path, pathlen); /* includes NUL */
 	return o;
 }
 
diff --git a/fast-import.c b/fast-import.c
index d0c2502..895c6b4 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -863,13 +863,15 @@ static void start_packfile(void)
 {
 	static char tmp_file[PATH_MAX];
 	struct packed_git *p;
+	int namelen;
 	struct pack_header hdr;
 	int pack_fd;
 
 	pack_fd = odb_mkstemp(tmp_file, sizeof(tmp_file),
 			      "pack/tmp_pack_XXXXXX");
-	p = xcalloc(1, sizeof(*p) + strlen(tmp_file) + 2);
-	strcpy(p->pack_name, tmp_file);
+	namelen = strlen(tmp_file) + 2;
+	p = xcalloc(1, sizeof(*p) + namelen);
+	xsnprintf(p->pack_name, namelen, "%s", tmp_file);
 	p->pack_fd = pack_fd;
 	p->do_not_close = 1;
 	pack_file = sha1fd(pack_fd, p->pack_name);
diff --git a/refs.c b/refs.c
index c2709de..9937a40 100644
--- a/refs.c
+++ b/refs.c
@@ -2695,7 +2695,7 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 		int namelen = strlen(entry->name) + 1;
 		struct ref_to_prune *n = xcalloc(1, sizeof(*n) + namelen);
 		hashcpy(n->sha1, entry->u.value.oid.hash);
-		strcpy(n->name, entry->name);
+		memcpy(n->name, entry->name, namelen); /* includes NUL */
 		n->next = cb->ref_to_prune;
 		cb->ref_to_prune = n;
 	}
@@ -3984,10 +3984,10 @@ void ref_transaction_free(struct ref_transaction *transaction)
 static struct ref_update *add_update(struct ref_transaction *transaction,
 				     const char *refname)
 {
-	size_t len = strlen(refname);
-	struct ref_update *update = xcalloc(1, sizeof(*update) + len + 1);
+	size_t len = strlen(refname) + 1;
+	struct ref_update *update = xcalloc(1, sizeof(*update) + len);
 
-	strcpy((char *)update->refname, refname);
+	memcpy((char *)update->refname, refname, len); /* includes NUL */
 	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
 	transaction->updates[transaction->nr++] = update;
 	return update;
diff --git a/sha1_file.c b/sha1_file.c
index 4211af1..cc3de24 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1180,9 +1180,10 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path)
 {
 	const char *path = sha1_pack_name(sha1);
-	struct packed_git *p = alloc_packed_git(strlen(path) + 1);
+	int alloc = strlen(path) + 1;
+	struct packed_git *p = alloc_packed_git(alloc);
 
-	strcpy(p->pack_name, path);
+	memcpy(p->pack_name, path, alloc); /* includes NUL */
 	hashcpy(p->sha1, sha1);
 	if (check_packed_git_idx(idx_path, p)) {
 		free(p);
diff --git a/submodule.c b/submodule.c
index 245ed4d..c480ed5 100644
--- a/submodule.c
+++ b/submodule.c
@@ -122,6 +122,7 @@ static int add_submodule_odb(const char *path)
 	struct strbuf objects_directory = STRBUF_INIT;
 	struct alternate_object_database *alt_odb;
 	int ret = 0;
+	int alloc;
 	const char *git_dir;
 
 	strbuf_addf(&objects_directory, "%s/.git", path);
@@ -142,9 +143,10 @@ static int add_submodule_odb(const char *path)
 					objects_directory.len))
 			goto done;
 
-	alt_odb = xmalloc(objects_directory.len + 42 + sizeof(*alt_odb));
+	alloc = objects_directory.len + 42; /* for "12/345..." sha1 */
+	alt_odb = xmalloc(sizeof(*alt_odb) + alloc);
 	alt_odb->next = alt_odb_list;
-	strcpy(alt_odb->base, objects_directory.buf);
+	xsnprintf(alt_odb->base, alloc, "%s", objects_directory.buf);
 	alt_odb->name = alt_odb->base + objects_directory.len;
 	alt_odb->name[2] = '/';
 	alt_odb->name[40] = '\0';
-- 
2.6.0.rc3.454.g204ad51
