Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E729F1494D6
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 22:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724453200; cv=none; b=BWeDHe92SX3uU4ENNx4mfy/6Ku6I+Wu25oZWY4RKxjEz2ZQafwKe11Rozhy08r8tTLbNBucPrrG99UZDiJgEqjgvTL4mkbBdteAGPnK9SnM9ntfP+Hl/hWI8/G7sXAXUqyMPPd9duOYxiG9D+PXgvXGJObcRPIi8xR87ahswurc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724453200; c=relaxed/simple;
	bh=WKLCJspcil65kshPlJENapJe5zbxHDynqgOLiFuQa40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEGOjMNRjkcmXvfNYJ6mkf6oMw4fHKtj2qoFbcaFCm6+ui2p+nK1ItdDKdP+XVT1wNxq2L/vGMhar8TVvygQYh3i+TDpLOEY+TrEB8EVU3JlVjrA0CeCNlNaZMYH9UB/Qq8m4Ld+wsqF0ixRHKiG84tzwL75R36xrjrEraHwCBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=e1lBr8/D; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="e1lBr8/D"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6FEB1F47A;
	Fri, 23 Aug 2024 22:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1724453191;
	bh=WKLCJspcil65kshPlJENapJe5zbxHDynqgOLiFuQa40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e1lBr8/DDHNOmT6KwsOiNXSglPzSXklM2bOG+a41bkPRtRX9NP94smqPyALfcDXKs
	 VE5q0VtX5wKmt864fVQG/cebm1gNuYPNXbSMRkhLqDwbUb3aXB4kYh9ZTM6RkgPhRW
	 nhKTA1Kln1I8TpsYbcbzcz3VqOZw62xOD6jObFs4=
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/10] cat-file speedups
Date: Fri, 23 Aug 2024 22:46:20 +0000
Message-ID: <20240823224630.1180772-1-e@80x24.org>
In-Reply-To: <20240715003519.2671385-1-e@80x24.org>
References: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This continues the work of Jeff King and my initial work to
speed up cat-file --batch(-contents)? users in
https://lore.kernel.org/git/20240621062915.GA2105230@coredump.intra.peff.net/T/

v1 is here:
https://lore.kernel.org/git/20240715003519.2671385-1-e@80x24.org/T/

v2 changes:

- attempts to improve various commit messages
  (the human language part of my brain has been pretty broken
  for a few years, now :<)
- expand comments around delta_base_cache_lock
- remove DIRECT_CACHE knob since it's always on
- move `else' arm removal in print_object_or_die from 7/10 to
  8/10 to fix t1006 under bisect

I've kept the assert() calls rather than using BUG() since they're
in easily tested code paths and the tests they perform aren't
useful in release builds.  The assertions should remain useful for
future development if we introduce more caching.

Thanks to Patrick for reviewing v1 and Jeff for the
content_limit work.

Eric Wong (8):
  packfile: fix off-by-one in content_limit comparison
  packfile: inline cache_or_unpack_entry
  cat-file: use delta_base_cache entries directly
  packfile: packed_object_info avoids packed_to_object_type
  object_info: content_limit only applies to blobs
  cat-file: batch-command uses content_limit
  cat-file: batch_write: use size_t for length
  cat-file: use writev(2) if available

Jeff King (2):
  packfile: move sizep computation
  packfile: allow content-limit for cat-file

 Makefile            |   3 ++
 builtin/cat-file.c  | 124 +++++++++++++++++++++++++++++++-------------
 config.mak.uname    |   5 ++
 git-compat-util.h   |  10 ++++
 object-file.c       |  12 +++++
 object-store-ll.h   |   9 ++++
 packfile.c          | 122 ++++++++++++++++++++++++++++---------------
 packfile.h          |   4 ++
 t/t1006-cat-file.sh |  19 +++++--
 wrapper.c           |  18 +++++++
 wrapper.h           |   1 +
 write-or-die.c      |  66 +++++++++++++++++++++++
 write-or-die.h      |   2 +
 13 files changed, 312 insertions(+), 83 deletions(-)

Range-diff against v1:
 1:  36b799ab67 !  1:  b4025cee1f packfile: move sizep computation
    @@ Metadata
      ## Commit message ##
         packfile: move sizep computation
     
    -    This makes the next commit to avoid redundant object info
    -    lookups easier to understand.
    +    Moving the sizep computation now makes the next commit to avoid
    +    redundant object info lookups easier to understand.  There is
    +    no user-visible change, here.
     
         [ew: commit message]
     
    @@ Commit message
     
      ## packfile.c ##
     @@ packfile.c: int packed_object_info(struct repository *r, struct packed_git *p,
    - 
    - 	/*
    - 	 * We always get the representation type, but only convert it to
    --	 * a "real" type later if the caller is interested.
    -+	 * a "real" type later if the caller is interested. Likewise...
    -+	 * tbd.
    - 	 */
    - 	if (oi->contentp) {
    - 		*oi->contentp = cache_or_unpack_entry(r, p, obj_offset, oi->sizep,
    -@@ packfile.c: int packed_object_info(struct repository *r, struct packed_git *p,
      			type = OBJ_BAD;
      	} else {
      		type = unpack_object_header(p, &w_curs, &curpos, &size);
 2:  50f576ab16 !  2:  bdf6f57fae packfile: allow content-limit for cat-file
    @@ Metadata
      ## Commit message ##
         packfile: allow content-limit for cat-file
     
    -    This avoids unnecessary round trips to the object store to speed
    +    Avoid unnecessary round trips to the object store to speed
         up cat-file contents retrievals.  The majority of packed objects
         don't benefit from the streaming interface at all and we end up
         having to load them in core anyways to satisfy our streaming
         API.
     
         This drops the runtime of
    -    `git cat-file --batch-all-objects --unordered --batch' from
    -    ~7.1s to ~6.1s on Jeff's machine.
    +    `git cat-file --batch-all-objects --unordered --batch' on
    +    git.git from ~7.1s to ~6.1s on Jeff's machine.
     
         [ew: commit message]
     
    @@ object-store-ll.h: struct object_info {
     
      ## packfile.c ##
     @@ packfile.c: int packed_object_info(struct repository *r, struct packed_git *p,
    - 	 * a "real" type later if the caller is interested. Likewise...
    - 	 * tbd.
    + 	 * We always get the representation type, but only convert it to
    + 	 * a "real" type later if the caller is interested.
      	 */
     -	if (oi->contentp) {
     +	if (oi->contentp && !oi->content_limit) {
 3:  6eb732401a !  3:  7e762e3481 packfile: fix off-by-one in content_limit comparison
    @@ Commit message
         slurping objects which match loose object handling and slurp
         objects with size matching the content_limit exactly.
     
    +    This change is merely for consistency with the majority of
    +    existing code and there is no user visible change in nearly all
    +    cases.  The only exception being the corner case when the object
    +    size matches content_limit exactly where users will see a
    +    speedup from avoiding an extra lookup.
    +
         Signed-off-by: Eric Wong <e@80x24.org>
     
      ## packfile.c ##
 4:  9476824ac7 !  4:  a558101b85 packfile: inline cache_or_unpack_entry
    @@ Commit message
         packfile: inline cache_or_unpack_entry
     
         We need to check delta_base_cache anyways to fill in the
    -    `whence' field in `struct object_info'.  Inlining
    -    cache_or_unpack_entry() makes it easier to only do the hashmap
    -    lookup once and avoid a redundant lookup later on.
    +    `whence' field in `struct object_info'.  Inlining (and getting
    +    rid of) cache_or_unpack_entry() makes it easier to only do the
    +    hashmap lookup once and avoid a redundant lookup later on.
     
         This code reorganization will also make an optimization to
    -    use the cache entry directly easier to implement.
    +    use the cache entry directly easier to implement in the next
    +    commit.
     
         Signed-off-by: Eric Wong <e@80x24.org>
     
    @@ packfile.c: int packed_object_info(struct repository *r, struct packed_git *p,
      
      	/*
      	 * We always get the representation type, but only convert it to
    - 	 * a "real" type later if the caller is interested. Likewise...
    - 	 * tbd.
    + 	 * a "real" type later if the caller is interested.
      	 */
     -	if (oi->contentp && !oi->content_limit) {
     -		*oi->contentp = cache_or_unpack_entry(r, p, obj_offset, oi->sizep,
 5:  c99dfb84d4 !  5:  74d21ac89d cat-file: use delta_base_cache entries directly
    @@ Commit message
         cat-file: use delta_base_cache entries directly
     
         For objects already in the delta_base_cache, we can safely use
    -    them directly to avoid the malloc+memcpy+free overhead.
    +    one entry at-a-time directly to avoid the malloc+memcpy+free
    +    overhead.  For a 1MB delta base object, this eliminates the
    +    speed penalty of duplicating large objects into memory and
    +    speeds up those 1MB delta base cached content retrievals by
    +    roughly 30%.
     
         While only 2-7% of objects are delta bases in repos I've looked
         at, this avoids up to 96MB of duplicated memory in the worst
    -    case with the default git config.  For a more reasonable 1MB
    -    delta base object, this eliminates the speed penalty of
    -    duplicating large objects into memory and speeds up those 1MB
    -    delta base cached content retrievals by roughly 30%.
    +    case with the default git config.
     
         The new delta_base_cache_lock is a simple single-threaded
    -    assertion to ensure cat-file is the exclusive user of the
    -    delta_base_cache.
    +    assertion to ensure cat-file (and similar) is the exclusive user
    +    of the delta_base_cache.  In other words, we cannot have diff
    +    or similar commands using two or more entries directly from the
    +    delta base cache.  The new lock has nothing to do with parallel
    +    access via multiple threads at the moment.
     
         Signed-off-by: Eric Wong <e@80x24.org>
     
      ## builtin/cat-file.c ##
    -@@
    - #include "promisor-remote.h"
    - #include "mailmap.h"
    - #include "write-or-die.h"
    -+#define USE_DIRECT_CACHE 1
    - 
    - enum batch_mode {
    - 	BATCH_MODE_CONTENTS,
     @@ builtin/cat-file.c: static void print_object_or_die(struct batch_options *opt, struct expand_data *d
      
      	if (data->content) {
      		batch_write(opt, data->content, data->size);
     -		FREE_AND_NULL(data->content);
     +		switch (data->info.whence) {
    -+		case OI_CACHED: BUG("FIXME OI_CACHED support not done");
    ++		case OI_CACHED:
    ++			/*
    ++			 * only blame uses OI_CACHED atm, so it's unlikely
    ++			 * we'll ever hit this path
    ++			 */
    ++			BUG("TODO OI_CACHED support not done");
     +		case OI_LOOSE:
     +		case OI_PACKED:
     +			FREE_AND_NULL(data->content);
     +			break;
     +		case OI_DBCACHED:
    -+			if (USE_DIRECT_CACHE)
    -+				unlock_delta_base_cache();
    -+			else
    -+				FREE_AND_NULL(data->content);
    ++			unlock_delta_base_cache();
     +		}
      	} else if (data->type == OBJ_BLOB) {
      		if (opt->buffer_output)
    @@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt)
      			data.info.sizep = &data.size;
      			data.info.contentp = &data.content;
      			data.info.content_limit = big_file_threshold;
    -+			data.info.direct_cache = USE_DIRECT_CACHE;
    ++			data.info.direct_cache = 1;
      		}
      	}
      
    @@ object-store-ll.h: struct object_info {
      	} whence;
     +
     +	/*
    -+	 * set if caller is able to use OI_DBCACHED entries without copying
    -+	 * TODO OI_CACHED if its use goes beyond blame
    ++	 * Set if caller is able to use OI_DBCACHED entries without copying.
    ++	 * This only applies to OI_DBCACHED entries at the moment,
    ++	 * not OI_CACHED or any other type of entry.
     +	 */
     +	unsigned direct_cache:1;
     +
    @@ packfile.c: static enum object_type packed_to_object_type(struct repository *r,
      static struct hashmap delta_base_cache;
      static size_t delta_base_cached;
      
    -+/* ensures oi->direct_cache is used properly */
    ++/*
    ++ * Ensures only a single object is used at-a-time via oi->direct_cache.
    ++ * Using two objects directly at once (e.g. diff) would cause corruption
    ++ * since populating the cache may invalidate existing entries.
    ++ * This lock has nothing to do with parallelism at the moment.
    ++ */
     +static int delta_base_cache_lock;
     +
      static LIST_HEAD(delta_base_cache_lru);
 6:  79a84221b2 !  6:  83b6367950 packfile: packed_object_info avoids packed_to_object_type
    @@ Metadata
      ## Commit message ##
         packfile: packed_object_info avoids packed_to_object_type
     
    -    For calls the delta base cache, packed_to_object_type calls
    +    For entries in the delta base cache, packed_to_object_type calls
         can be omitted.  This prepares us to bypass content_limit for
         non-blob types in the following commit.
     
 7:  63b36d759d !  7:  7e0f8c0cf6 object_info: content_limit only applies to blobs
    @@ builtin/cat-file.c: static void print_object_or_die(struct batch_options *opt, s
     +					data->type == OBJ_TAG)) {
     +			size_t s = size;
     +
    -+			if (USE_DIRECT_CACHE &&
    -+					data->info.whence == OI_DBCACHED) {
    ++			if (data->info.whence == OI_DBCACHED) {
     +				content = xmemdupz(content, s);
     +				data->info.whence = OI_PACKED;
     +			}
    @@ builtin/cat-file.c: static void print_object_or_die(struct batch_options *opt, s
     +
     +		batch_write(opt, content, size);
      		switch (data->info.whence) {
    - 		case OI_CACHED: BUG("FIXME OI_CACHED support not done");
    + 		case OI_CACHED:
    + 			/*
    +@@ builtin/cat-file.c: static void print_object_or_die(struct batch_options *opt, struct expand_data *d
    + 			BUG("TODO OI_CACHED support not done");
      		case OI_LOOSE:
      		case OI_PACKED:
     -			FREE_AND_NULL(data->content);
     +			free(content);
      			break;
      		case OI_DBCACHED:
    - 			if (USE_DIRECT_CACHE)
    - 				unlock_delta_base_cache();
    - 			else
    --				FREE_AND_NULL(data->content);
    -+				free(content);
    - 		}
    --	} else if (data->type == OBJ_BLOB) {
    -+	} else {
    -+		assert(data->type == OBJ_BLOB);
    - 		if (opt->buffer_output)
    - 			fflush(stdout);
    - 		if (opt->transform_mode) {
    -@@ builtin/cat-file.c: static void print_object_or_die(struct batch_options *opt, struct expand_data *d
    - 			stream_blob(oid);
    - 		}
    - 	}
    --	else {
    --		enum object_type type;
    --		unsigned long size;
    --		void *contents;
    --
    --		contents = repo_read_object_file(the_repository, oid, &type,
    --						 &size);
    --		if (!contents)
    --			die("object %s disappeared", oid_to_hex(oid));
    --
    --		if (use_mailmap) {
    --			size_t s = size;
    --			contents = replace_idents_using_mailmap(contents, &s);
    --			size = cast_size_t_to_ulong(s);
    --		}
    --
    --		if (type != data->type)
    --			die("object %s changed type!?", oid_to_hex(oid));
    --		if (data->info.sizep && size != data->size && !use_mailmap)
    --			die("object %s changed size!?", oid_to_hex(oid));
    --
    --		batch_write(opt, contents, size);
    --		free(contents);
    --	}
    - }
    - 
    - static void print_default_format(struct strbuf *scratch, struct expand_data *data,
    + 			unlock_delta_base_cache();
     
      ## object-file.c ##
     @@ object-file.c: static int loose_object_info(struct repository *r,
    @@ packfile.c: int packed_object_info(struct repository *r, struct packed_git *p,
      				if (!*oi->contentp)
      					type = OBJ_BAD;
      			} else {
    +
    + ## t/t1006-cat-file.sh ##
    +@@ t/t1006-cat-file.sh: test_expect_success 'confirm that neither loose blob is a delta' '
    + 	test_cmp expect actual
    + '
    + 
    ++test_expect_success 'setup delta base tests' '
    ++	foo="$(git rev-parse HEAD:foo)" &&
    ++	foo_plus="$(git rev-parse HEAD:foo-plus)" &&
    ++	git repack -ad
    ++'
    ++
    + # To avoid relying too much on the current delta heuristics,
    + # we will check only that one of the two objects is a delta
    + # against the other, but not the order. We can do so by just
    + # asking for the base of both, and checking whether either
    + # oid appears in the output.
    + test_expect_success '%(deltabase) reports packed delta bases' '
    +-	git repack -ad &&
    + 	git cat-file --batch-check="%(deltabase)" <blobs >actual &&
    + 	{
    +-		grep "$(git rev-parse HEAD:foo)" actual ||
    +-		grep "$(git rev-parse HEAD:foo-plus)" actual
    ++		grep "$foo" actual || grep "$foo_plus" actual
    + 	}
    + '
    + 
    ++test_expect_success 'delta base direct cache use succeeds w/o asserting' '
    ++	commands="info $foo
    ++info $foo_plus
    ++contents $foo_plus
    ++contents $foo" &&
    ++	echo "$commands" >in &&
    ++	git cat-file --batch-command <in >out
    ++'
    ++
    + test_expect_success 'setup bogus data' '
    + 	bogus_short_type="bogus" &&
    + 	bogus_short_content="bogus" &&
 8:  271f6241bd !  8:  ef83e8b426 cat-file: batch-command uses content_limit
    @@ Commit message
         Signed-off-by: Eric Wong <e@80x24.org>
     
      ## builtin/cat-file.c ##
    +@@ builtin/cat-file.c: static void print_object_or_die(struct batch_options *opt, struct expand_data *d
    + 		case OI_DBCACHED:
    + 			unlock_delta_base_cache();
    + 		}
    +-	} else if (data->type == OBJ_BLOB) {
    ++	} else {
    ++		assert(data->type == OBJ_BLOB);
    + 		if (opt->buffer_output)
    + 			fflush(stdout);
    + 		if (opt->transform_mode) {
    +@@ builtin/cat-file.c: static void print_object_or_die(struct batch_options *opt, struct expand_data *d
    + 			stream_blob(oid);
    + 		}
    + 	}
    +-	else {
    +-		enum object_type type;
    +-		unsigned long size;
    +-		void *contents;
    +-
    +-		contents = repo_read_object_file(the_repository, oid, &type,
    +-						 &size);
    +-		if (!contents)
    +-			die("object %s disappeared", oid_to_hex(oid));
    +-
    +-		if (use_mailmap) {
    +-			size_t s = size;
    +-			contents = replace_idents_using_mailmap(contents, &s);
    +-			size = cast_size_t_to_ulong(s);
    +-		}
    +-
    +-		if (type != data->type)
    +-			die("object %s changed type!?", oid_to_hex(oid));
    +-		if (data->info.sizep && size != data->size && !use_mailmap)
    +-			die("object %s changed size!?", oid_to_hex(oid));
    +-
    +-		batch_write(opt, contents, size);
    +-		free(contents);
    +-	}
    + }
    + 
    + static void print_default_format(struct strbuf *scratch, struct expand_data *data,
     @@ builtin/cat-file.c: static void parse_cmd_contents(struct batch_options *opt,
      			     struct expand_data *data)
      {
    @@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt)
      		data.info.typep = &data.type;
      		if (!opt->transform_mode) {
      			data.info.sizep = &data.size;
    -
    - ## t/t1006-cat-file.sh ##
    -@@ t/t1006-cat-file.sh: test_expect_success 'confirm that neither loose blob is a delta' '
    - 	test_cmp expect actual
    - '
    - 
    -+test_expect_success 'setup delta base tests' '
    -+	foo="$(git rev-parse HEAD:foo)" &&
    -+	foo_plus="$(git rev-parse HEAD:foo-plus)" &&
    -+	git repack -ad
    -+'
    -+
    - # To avoid relying too much on the current delta heuristics,
    - # we will check only that one of the two objects is a delta
    - # against the other, but not the order. We can do so by just
    - # asking for the base of both, and checking whether either
    - # oid appears in the output.
    - test_expect_success '%(deltabase) reports packed delta bases' '
    --	git repack -ad &&
    - 	git cat-file --batch-check="%(deltabase)" <blobs >actual &&
    - 	{
    --		grep "$(git rev-parse HEAD:foo)" actual ||
    --		grep "$(git rev-parse HEAD:foo-plus)" actual
    -+		grep "$foo" actual || grep "$foo_plus" actual
    - 	}
    - '
    - 
    -+test_expect_success 'delta base direct cache use succeeds w/o asserting' '
    -+	commands="info $foo
    -+info $foo_plus
    -+contents $foo_plus
    -+contents $foo" &&
    -+	echo "$commands" >in &&
    -+	git cat-file --batch-command <in >out
    -+'
    -+
    - test_expect_success 'setup bogus data' '
    - 	bogus_short_type="bogus" &&
    - 	bogus_short_content="bogus" &&
 9:  d91030b69c =  9:  6a94452e54 cat-file: batch_write: use size_t for length
10:  c356b9e1ce ! 10:  1442e43ec7 cat-file: use writev(2) if available
    @@ Metadata
      ## Commit message ##
         cat-file: use writev(2) if available
     
    -    Using writev here is can be 20-40% faster than three write
    -    syscalls in succession for smaller (1-10k) objects in the delta
    -    base cache.  This advantage decreases as object sizes approach
    -    pipe size (64k on Linux).  This reduces wakeups and syscalls on
    -    the read side, as well, especially if the reader is relying on
    -    non-blocking I/O.
    +    Using writev here is 20-40% faster than three write syscalls in
    +    succession for smaller (1-10k) objects in the delta base cache.
    +    This advantage decreases as object sizes approach pipe size (64k
    +    on Linux).
    +
    +    writev reduces wakeups and syscalls on the read side as well:
    +    each write(2) syscall may trigger one or more corresponding
    +    read(2) syscalls in the reader.  Attempting atomicity in the
    +    writer via writev also reduces the likelyhood of non-blocking
    +    readers failing with EAGAIN and having to call poll||select
    +    before attempting to read again.
     
         Unfortunately, this turns into a small (1-3%) slowdown for
         gigantic objects of a megabyte or more even with after
    @@ Commit message
         defaults to being compatible with non-blocking stdout and able
         to poll(2) after hitting EAGAIN on write(2).  Using stdio on
         files with the O_NONBLOCK flag is (AFAIK) unspecified and likely
    -    subject to portability problems.
    +    subject to portability problems and thus avoided.
     
         Signed-off-by: Eric Wong <e@80x24.org>
     
    @@ builtin/cat-file.c: static void print_object_or_die(struct batch_options *opt, s
     -		batch_write(opt, content, size);
     +		batch_writev(opt, data, hdr, size);
      		switch (data->info.whence) {
    - 		case OI_CACHED: BUG("FIXME OI_CACHED support not done");
    - 		case OI_LOOSE:
    + 		case OI_CACHED:
    + 			/*
     @@ builtin/cat-file.c: static void print_object_or_die(struct batch_options *opt, struct expand_data *d
      		}
      	} else {
    @@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt)
     -			data.info.contentp = &data.content;
     +			data.info.contentp = &data.iov[1].iov_base;
      			data.info.content_limit = big_file_threshold;
    - 			data.info.direct_cache = USE_DIRECT_CACHE;
    + 			data.info.direct_cache = 1;
      		}
     
      ## config.mak.uname ##

base-commit: a7dae3bdc8b516d36f630b12bb01e853a667e0d9
