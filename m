Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6604E2B9D7
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 18:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718044612; cv=none; b=rMRVdHdkYV6JNqZmagA3q2mQZcmt1+NZz6J9Rvwu+rwvIBNdCK403PWOSiUnz9xQFJJKTAXBXTpdOF022al3EJYnEJt1JnFEuKYvpFmv1L0TZu4LKTwyQ4tCR0mTpyaFegW6aLyDgPEChVWA5ukvIZzv8QBUQB7AAQhLjaIS6Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718044612; c=relaxed/simple;
	bh=ompV5LebwYvVDYNQCsY+LdbE//uFqBIj/pDJ+/0hrus=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N7iqTS/wn065L2psN1W8ynbLUrTjR5PpxsuFA1T1uHgElhdXuh1uExf5jvZZTKV/cYN1qJ4AcaGY3vCROykY45Uft43470Fmt9IAyHtx6lhnUnr3ofGuqjtQsUfV9HGMEyHmVgUhDvwBSRfXeT8VVGfZlp81RzgvQg+zcVzSwbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=O4fc4oXN; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="O4fc4oXN"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D0FEC30181;
	Mon, 10 Jun 2024 14:36:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ompV5LebwYvVDYNQCsY+LdbE//uFqBIj/pDJ+/
	0hrus=; b=O4fc4oXNcsFqVs3RjVY8hHM5Te3IpIh/N24OWKr6gcWmgncpjAcfk1
	Xm6iN85/IPSu6SeEP9qiCTVq0z1+V8XPpBEo4WIIDQNhJhC82/43TE5niNoIgRrV
	r/7uFsjOaUGyIZI9p8QWeetGTFMIgvdyizv3+fZqYyxUSsR8f/XzE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C9AB230180;
	Mon, 10 Jun 2024 14:36:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 12ABC3017F;
	Mon, 10 Jun 2024 14:36:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: [PATCH 1/2] DONTAPPLY: -Og fallout workaround
In-Reply-To: <xmqqed946auc.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	10 Jun 2024 09:06:51 -0700")
References: <cover.1717655210.git.ps@pks.im> <cover.1718001244.git.ps@pks.im>
	<03270d3414117ae7229d87127cff81e349557039.1718001244.git.ps@pks.im>
	<xmqqed946auc.fsf@gitster.g>
Date: Mon, 10 Jun 2024 11:36:40 -0700
Message-ID: <xmqqjziw3arr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 61AA9AA2-2758-11EF-A869-8F8B087618E4-77302942!pb-smtp21.pobox.com

These "workarounds" are to mark variables that are used after
initialized, but some compilers with lower optimization levels
cannot see and report "used uninitialized".

This set targets "gcc-12 -Og".  For the reason why this is a wrong
thing to do for longer-term code health, see

  https://lore.kernel.org/git/xmqqed946auc.fsf@gitster.g/

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Even though I said I won't do the actual patch, since I had to
   gauge the extent of damage, I ended up doing so anyways.

   As I explained already, the size of this patch, i.e. number of
   places that need the workaround, does not really matter.  What
   is horrible is how each of these workaround will hide real bugs
   we may introduce in the future from the compilers.

 builtin/branch.c          | 2 +-
 builtin/fast-import.c     | 4 ++--
 builtin/repack.c          | 2 +-
 fetch-pack.c              | 2 +-
 http-backend.c            | 2 +-
 http.c                    | 2 +-
 pack-mtimes.c             | 2 +-
 pack-revindex.c           | 2 +-
 refs/packed-backend.c     | 2 +-
 reftable/stack.c          | 2 +-
 remote-curl.c             | 4 ++--
 t/helper/test-ref-store.c | 2 +-
 trailer.c                 | 4 ++--
 13 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 48cac74f97..1f4de92e05 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -504,7 +504,7 @@ static void print_current_branch_name(void)
 	int flags;
 	const char *refname = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
 						      "HEAD", 0, NULL, &flags);
-	const char *shortname;
+	const char *shortname = shortname;
 	if (!refname)
 		die(_("could not resolve HEAD"));
 	else if (!(flags & REF_ISSYMREF))
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index ea5ae5196d..6d53e42011 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1866,7 +1866,7 @@ static void parse_original_identifier(void)
 
 static int parse_data(struct strbuf *sb, uintmax_t limit, uintmax_t *len_res)
 {
-	const char *data;
+	const char *data = data;
 	strbuf_reset(sb);
 
 	if (!skip_prefix(command_buf.buf, "data ", &data))
@@ -2807,7 +2807,7 @@ static void parse_new_commit(const char *arg)
 static void parse_new_tag(const char *arg)
 {
 	static struct strbuf msg = STRBUF_INIT;
-	const char *from;
+	const char *from = from;
 	char *tagger;
 	struct branch *s;
 	struct tag *t;
diff --git a/builtin/repack.c b/builtin/repack.c
index 7608430a37..e4752aae3f 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1106,7 +1106,7 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 
 static const char *find_pack_prefix(const char *packdir, const char *packtmp)
 {
-	const char *pack_prefix;
+	const char *pack_prefix = pack_prefix;
 	if (!skip_prefix(packtmp, packdir, &pack_prefix))
 		die(_("pack prefix %s does not begin with objdir %s"),
 		    packtmp, packdir);
diff --git a/fetch-pack.c b/fetch-pack.c
index eba9e420ea..f8f318742f 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1517,7 +1517,7 @@ static void receive_shallow_info(struct fetch_pack_args *args,
 
 	process_section_header(reader, "shallow-info", 0);
 	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
-		const char *arg;
+		const char *arg = arg;
 		struct object_id oid;
 
 		if (skip_prefix(reader->line, "shallow ", &arg)) {
diff --git a/http-backend.c b/http-backend.c
index 5b4dca65ed..eecba3b44f 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -259,7 +259,7 @@ static void http_config(void)
 
 static struct rpc_service *select_service(struct strbuf *hdr, const char *name)
 {
-	const char *svc_name;
+	const char *svc_name = svc_name;
 	struct rpc_service *svc = NULL;
 	int i;
 
diff --git a/http.c b/http.c
index 2dea2d03da..c45f91fa4e 100644
--- a/http.c
+++ b/http.c
@@ -2156,7 +2156,7 @@ static int update_url_from_redirect(struct strbuf *base,
 				    const char *asked,
 				    const struct strbuf *got)
 {
-	const char *tail;
+	const char *tail = tail;
 	size_t new_len;
 
 	if (!strcmp(asked, got->buf))
diff --git a/pack-mtimes.c b/pack-mtimes.c
index cdf30b8d2b..49598d4749 100644
--- a/pack-mtimes.c
+++ b/pack-mtimes.c
@@ -29,7 +29,7 @@ static int load_pack_mtimes_file(char *mtimes_file,
 	int fd, ret = 0;
 	struct stat st;
 	uint32_t *data = NULL;
-	size_t mtimes_size, expected_size;
+	size_t mtimes_size = mtimes_size, expected_size;
 	struct mtimes_header header;
 
 	fd = git_open(mtimes_file);
diff --git a/pack-revindex.c b/pack-revindex.c
index fc63aa76a2..7120bed5b1 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -206,7 +206,7 @@ static int load_revindex_from_disk(char *revindex_name,
 	int fd, ret = 0;
 	struct stat st;
 	void *data = NULL;
-	size_t revindex_size;
+	size_t revindex_size = revindex_size;
 	struct revindex_header *hdr;
 
 	if (git_env_bool(GIT_TEST_REV_INDEX_DIE_ON_DISK, 0))
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index c4c1e36aa2..25321a5758 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -677,7 +677,7 @@ static struct snapshot *create_snapshot(struct packed_ref_store *refs)
 
 	/* If the file has a header line, process it: */
 	if (snapshot->buf < snapshot->eof && *snapshot->buf == '#') {
-		char *tmp, *p, *eol;
+		char *tmp, *p = p, *eol;
 		struct string_list traits = STRING_LIST_INIT_NODUP;
 
 		eol = memchr(snapshot->buf, '\n',
diff --git a/reftable/stack.c b/reftable/stack.c
index 737591125e..aa1851fd73 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1231,7 +1231,7 @@ struct segment suggest_compaction_segment(uint64_t *sizes, size_t n,
 					  uint8_t factor)
 {
 	struct segment seg = { 0 };
-	uint64_t bytes;
+	uint64_t bytes = bytes;
 	size_t i;
 
 	if (!factor)
diff --git a/remote-curl.c b/remote-curl.c
index 827bd848ae..4f9808c63f 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1265,7 +1265,7 @@ static void parse_fetch(struct strbuf *buf)
 	int alloc_heads = 0, nr_heads = 0;
 
 	do {
-		const char *p;
+		const char *p = p;
 		if (skip_prefix(buf->buf, "fetch ", &p)) {
 			const char *name;
 			struct ref *ref;
@@ -1428,7 +1428,7 @@ static void parse_push(struct strbuf *buf)
 	int ret;
 
 	do {
-		const char *arg;
+		const char *arg = arg;
 		if (skip_prefix(buf->buf, "push ", &arg))
 			strvec_push(&specs, arg);
 		else
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index ad24300170..7d3870fe76 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -66,7 +66,7 @@ static unsigned int arg_flags(const char *arg, const char *name,
 
 static const char **get_store(const char **argv, struct ref_store **refs)
 {
-	const char *gitdir;
+	const char *gitdir = gitdir;
 
 	if (!argv[0]) {
 		die("ref store required");
diff --git a/trailer.c b/trailer.c
index 72e5136c73..5056c16644 100644
--- a/trailer.c
+++ b/trailer.c
@@ -508,11 +508,11 @@ static int git_trailer_config(const char *conf_key, const char *value,
 			      const struct config_context *ctx UNUSED,
 			      void *cb UNUSED)
 {
-	const char *trailer_item, *variable_name;
+	const char *trailer_item = trailer_item, *variable_name;
 	struct arg_item *item;
 	struct conf_info *conf;
 	char *name = NULL;
-	enum trailer_info_type type;
+	enum trailer_info_type type = type;
 	int i;
 
 	if (!skip_prefix(conf_key, "trailer.", &trailer_item))
-- 
2.45.2-445-g1b76f06508

