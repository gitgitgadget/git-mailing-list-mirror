Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 667101F4CC
	for <e@80x24.org>; Sun,  6 Oct 2019 23:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfJFXap (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 19:30:45 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38992 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbfJFXap (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 19:30:45 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 823001F4BD;
        Sun,  6 Oct 2019 23:30:43 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 00/20] hashmap bug/safety/ease-of-use fixes
Date:   Sun,  6 Oct 2019 23:30:23 +0000
Message-Id: <20191006233043.3516-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3 changes:
- use __typeof__ to avoid invalid clang warning on uninitialized var
- formatting fixes recommended by Stolee
- add Reviewed-by for Stolee
- add patch 20 to update docs to drop first member requirement

v2 here:
  https://public-inbox.org/git/20190924010324.22619-1-e@80x24.org/

The following changes since commit 745f6812895b31c02b29bdfe4ae8e5498f776c26:

  First batch after Git 2.23 (2019-08-22 12:41:04 -0700)

are available in the Git repository at:

  https://80x24.org/git-svn.git hashmap-wip-v3

for you to fetch changes up to 4ec5200646d6b9363e64e2002eb374aa888a6c88:

  hashmap_entry: remove first member requirement from docs (2019-10-06 23:05:22 +0000)

----------------------------------------------------------------
Eric Wong (20):
      diff: use hashmap_entry_init on moved_entry.ent
      coccicheck: detect hashmap_entry.hash assignment
      packfile: use hashmap_entry in delta_base_cache_entry
      hashmap_entry_init takes "struct hashmap_entry *"
      hashmap_get_next takes "const struct hashmap_entry *"
      hashmap_add takes "struct hashmap_entry *"
      hashmap_get takes "const struct hashmap_entry *"
      hashmap_remove takes "const struct hashmap_entry *"
      hashmap_put takes "struct hashmap_entry *"
      introduce container_of macro
      hashmap_get_next returns "struct hashmap_entry *"
      hashmap: use *_entry APIs to wrap container_of
      hashmap_get{,_from_hash} return "struct hashmap_entry *"
      hashmap_cmp_fn takes hashmap_entry params
      hashmap: use *_entry APIs for iteration
      hashmap: hashmap_{put,remove} return hashmap_entry *
      hashmap: introduce hashmap_free_entries
      OFFSETOF_VAR macro to simplify hashmap iterators
      hashmap: remove type arg from hashmap_{get,put,remove}_entry
      hashmap_entry: remove first member requirement from docs

 attr.c                              |  24 ++---
 blame.c                             |  25 ++---
 builtin/describe.c                  |  21 +++--
 builtin/difftool.c                  |  56 +++++++-----
 builtin/fast-export.c               |  15 ++-
 builtin/fetch.c                     |  32 ++++---
 config.c                            |  24 ++---
 contrib/coccinelle/hashmap.cocci    |  16 ++++
 diff.c                              |  31 ++++---
 diffcore-rename.c                   |  15 ++-
 git-compat-util.h                   |  38 ++++++++
 hashmap.c                           |  58 +++++++-----
 hashmap.h                           | 176 +++++++++++++++++++++++++++++-------
 merge-recursive.c                   |  87 ++++++++++--------
 merge-recursive.h                   |   4 +-
 name-hash.c                         |  57 ++++++------
 oidmap.c                            |  20 ++--
 oidmap.h                            |   6 +-
 packfile.c                          |  22 +++--
 patch-ids.c                         |  18 ++--
 range-diff.c                        |  10 +-
 ref-filter.c                        |  33 ++++---
 refs.c                              |  25 +++--
 remote.c                            |  21 +++--
 remote.h                            |   2 +-
 revision.c                          |  28 +++---
 sequencer.c                         |  44 ++++++---
 sub-process.c                       |  20 ++--
 sub-process.h                       |   6 +-
 submodule-config.c                  |  52 ++++++-----
 t/helper/test-hashmap.c             |  50 +++++-----
 t/helper/test-lazy-init-name-hash.c |  12 +--
 32 files changed, 667 insertions(+), 381 deletions(-)
 create mode 100644 contrib/coccinelle/hashmap.cocci

Range-diff against v2:
 1:  51ba91d2f9 !  1:  0f530552de diff: use hashmap_entry_init on moved_entry.ent
    @@ -10,6 +10,7 @@
         hashmap_add callers to take "struct hashmap_entry *".
     
         Signed-off-by: Eric Wong <e@80x24.org>
    +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
     
      diff --git a/diff.c b/diff.c
      --- a/diff.c
 2:  be4071d33d !  2:  d12ddb4327 coccicheck: detect hashmap_entry.hash assignment
    @@ -8,6 +8,7 @@
         hashmap_entry_init, instead.
     
         Signed-off-by: Eric Wong <e@80x24.org>
    +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
     
      diff --git a/contrib/coccinelle/hashmap.cocci b/contrib/coccinelle/hashmap.cocci
      new file mode 100644
 3:  ff40a39bad !  3:  624b89fbb4 packfile: use hashmap_entry in delta_base_cache_entry
    @@ -15,6 +15,7 @@
         systems.
     
         Signed-off-by: Eric Wong <e@80x24.org>
    +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
     
      diff --git a/packfile.c b/packfile.c
      --- a/packfile.c
 4:  d1db0f6472 !  4:  7512f2f2f7 hashmap_entry_init takes "struct hashmap_entry *"
    @@ -8,6 +8,7 @@
         safety and readability.
     
         Signed-off-by: Eric Wong <e@80x24.org>
    +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
     
      diff --git a/attr.c b/attr.c
      --- a/attr.c
    @@ -212,8 +213,8 @@
       * and if it is on stack, you can just let it go out of scope).
       */
     -static inline void hashmap_entry_init(void *entry, unsigned int hash)
    -+static inline void
    -+hashmap_entry_init(struct hashmap_entry *e, unsigned int hash)
    ++static inline void hashmap_entry_init(struct hashmap_entry *e,
    ++					unsigned int hash)
      {
     -	struct hashmap_entry *e = entry;
      	e->hash = hash;
 5:  a293445e97 !  5:  dd167a1113 hashmap_get_next takes "const struct hashmap_entry *"
    @@ -6,6 +6,7 @@
         now detects invalid types being passed.
     
         Signed-off-by: Eric Wong <e@80x24.org>
    +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
     
      diff --git a/diff.c b/diff.c
      --- a/diff.c
 6:  beabdab6fe !  6:  53f429ef6f hashmap_add takes "struct hashmap_entry *"
    @@ -6,6 +6,7 @@
         detects invalid types being passed.
     
         Signed-off-by: Eric Wong <e@80x24.org>
    +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
     
      diff --git a/attr.c b/attr.c
      --- a/attr.c
 7:  99970934c7 !  7:  87739268dc hashmap_get takes "const struct hashmap_entry *"
    @@ -6,6 +6,7 @@
         now detects invalid types being passed.
     
         Signed-off-by: Eric Wong <e@80x24.org>
    +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
     
      diff --git a/attr.c b/attr.c
      --- a/attr.c
 8:  8148ed70eb !  8:  22226b3bb4 hashmap_remove takes "const struct hashmap_entry *"
    @@ -6,6 +6,7 @@
         now detects invalid types being passed.
     
         Signed-off-by: Eric Wong <e@80x24.org>
    +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
     
      diff --git a/blame.c b/blame.c
      --- a/blame.c
 9:  3756dcc34e !  9:  0b64282a1f hashmap_put takes "struct hashmap_entry *"
    @@ -6,6 +6,7 @@
         detects invalid types being passed.
     
         Signed-off-by: Eric Wong <e@80x24.org>
    +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
     
      diff --git a/builtin/fast-export.c b/builtin/fast-export.c
      --- a/builtin/fast-export.c
10:  ff586aa43c ! 10:  c2e9201838 introduce container_of macro
    @@ -7,15 +7,16 @@
         and chained hash tables while allowing the compiler to do
         type checking.
     
    -    I intend to use this to remove the limitation of "hashmap_entry"
    -    being location-dependent and to allow more compile-time type
    -    checking.
    +    Later patches will use container_of() to remove the limitation
    +    of "hashmap_entry" being location-dependent. This will complete
    +    the transition to compile-time type checking for the hashmap API.
     
         This macro already exists in our source as "list_entry" in
         list.h and making "list_entry" an alias to "container_of"
         as the Linux kernel has done is a possibility.
     
         Signed-off-by: Eric Wong <e@80x24.org>
    +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
     
      diff --git a/git-compat-util.h b/git-compat-util.h
      --- a/git-compat-util.h
11:  931356f061 ! 11:  c709e607b1 hashmap_get_next returns "struct hashmap_entry *"
    @@ -6,6 +6,7 @@
         hashmap_entry being the first field of a struct.
     
         Signed-off-by: Eric Wong <e@80x24.org>
    +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
     
      diff --git a/diff.c b/diff.c
      --- a/diff.c
    @@ -14,10 +15,10 @@
      {
      	int i;
      	char *got_match = xcalloc(1, pmb_nr);
    -+	struct hashmap_entry *ent = &match->ent;
    ++	struct hashmap_entry *ent;
      
     -	for (; match; match = hashmap_get_next(hm, &match->ent)) {
    -+	for (; ent; ent = hashmap_get_next(hm, ent)) {
    ++	for (ent = &match->ent; ent; ent = hashmap_get_next(hm, ent)) {
     +		match = container_of(ent, struct moved_entry, ent);
      		for (i = 0; i < pmb_nr; i++) {
      			struct moved_entry *prev = pmb[i].match;
12:  a748b9b0c4 ! 12:  27ba68a7b8 hashmap: use *_entry APIs to wrap container_of
    @@ -11,6 +11,7 @@
         extra parameter to specify the type.
     
         Signed-off-by: Eric Wong <e@80x24.org>
    +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
     
      diff --git a/diff.c b/diff.c
      --- a/diff.c
    @@ -19,9 +20,9 @@
      {
      	int i;
      	char *got_match = xcalloc(1, pmb_nr);
    --	struct hashmap_entry *ent = &match->ent;
    +-	struct hashmap_entry *ent;
      
    --	for (; ent; ent = hashmap_get_next(hm, ent)) {
    +-	for (ent = &match->ent; ent; ent = hashmap_get_next(hm, ent)) {
     -		match = container_of(ent, struct moved_entry, ent);
     +	hashmap_for_each_entry_from(hm, match, struct moved_entry, ent) {
      		for (i = 0; i < pmb_nr; i++) {
    @@ -125,7 +126,6 @@
      #define container_of(ptr, type, member) \
      	((type *) ((char *)(ptr) - offsetof(type, member)))
      
    -+
     +/*
     + * helper function for `container_of_or_null' to avoid multiple
     + * evaluation of @ptr
13:  e8faa5e12e ! 13:  222b1f07f3 hashmap_get{,_from_hash} return "struct hashmap_entry *"
    @@ -9,6 +9,7 @@
         hashmap_entry being the first field in a struct.
     
         Signed-off-by: Eric Wong <e@80x24.org>
    +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
     
      diff --git a/attr.c b/attr.c
      --- a/attr.c
    @@ -152,11 +153,13 @@
      }
      
     -void *hashmap_get(const struct hashmap *map, const struct hashmap_entry *key,
    -+struct hashmap_entry *
    -+hashmap_get(const struct hashmap *map, const struct hashmap_entry *key,
    - 		const void *keydata)
    +-		const void *keydata)
    ++struct hashmap_entry *hashmap_get(const struct hashmap *map,
    ++				const struct hashmap_entry *key,
    ++				const void *keydata)
      {
      	return *find_entry_ptr(map, key, keydata);
    + }
     @@
      	/* lookup interned string in pool */
      	hashmap_entry_init(&key.ent, memhash(data, len));
    @@ -175,21 +178,27 @@
       * to `hashmap_cmp_fn` to decide whether the entry matches the key.
       */
     -void *hashmap_get(const struct hashmap *map, const struct hashmap_entry *key,
    -+struct hashmap_entry *
    -+hashmap_get(const struct hashmap *map, const struct hashmap_entry *key,
    - 			 const void *keydata);
    +-			 const void *keydata);
    ++struct hashmap_entry *hashmap_get(const struct hashmap *map,
    ++				const struct hashmap_entry *key,
    ++				const void *keydata);
      
      /*
    +  * Returns the hashmap entry for the specified hash code and key data,
     @@
       * `entry_or_key` parameter of `hashmap_cmp_fn` points to a hashmap_entry
       * structure that should not be used in the comparison.
       */
     -static inline void *hashmap_get_from_hash(const struct hashmap *map,
    -+static inline struct hashmap_entry *
    -+hashmap_get_from_hash(const struct hashmap *map,
    - 					  unsigned int hash,
    - 					  const void *keydata)
    +-					  unsigned int hash,
    +-					  const void *keydata)
    ++static inline struct hashmap_entry *hashmap_get_from_hash(
    ++					const struct hashmap *map,
    ++					unsigned int hash,
    ++					const void *keydata)
      {
    + 	struct hashmap_entry key;
    + 	hashmap_entry_init(&key, hash);
     
      diff --git a/merge-recursive.c b/merge-recursive.c
      --- a/merge-recursive.c
14:  f84bd96b8e ! 14:  c789f98c81 hashmap_cmp_fn takes hashmap_entry params
    @@ -6,6 +6,7 @@
         being the first member of a struct.
     
         Signed-off-by: Eric Wong <e@80x24.org>
    +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
     
      diff --git a/attr.c b/attr.c
      --- a/attr.c
15:  23fbd888d9 ! 15:  57ae5b5142 hashmap: use *_entry APIs for iteration
    @@ -7,6 +7,7 @@
         by compilers lacking __typeof__ support.
     
         Signed-off-by: Eric Wong <e@80x24.org>
    +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
     
      diff --git a/attr.c b/attr.c
      --- a/attr.c
16:  6908364381 ! 16:  f1e35ba094 hashmap: hashmap_{put,remove} return hashmap_entry *
    @@ -6,6 +6,7 @@
         to simplify most callers.
     
         Signed-off-by: Eric Wong <e@80x24.org>
    +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
     
      diff --git a/hashmap.c b/hashmap.c
      --- a/hashmap.c
    @@ -15,18 +16,20 @@
      }
      
     -void *hashmap_remove(struct hashmap *map, const struct hashmap_entry *key,
    -+struct hashmap_entry *
    -+hashmap_remove(struct hashmap *map, const struct hashmap_entry *key,
    - 		const void *keydata)
    +-		const void *keydata)
    ++struct hashmap_entry *hashmap_remove(struct hashmap *map,
    ++					const struct hashmap_entry *key,
    ++					const void *keydata)
      {
      	struct hashmap_entry *old;
    + 	struct hashmap_entry **e = find_entry_ptr(map, key, keydata);
     @@
      	return old;
      }
      
     -void *hashmap_put(struct hashmap *map, struct hashmap_entry *entry)
    -+struct hashmap_entry *
    -+hashmap_put(struct hashmap *map, struct hashmap_entry *entry)
    ++struct hashmap_entry *hashmap_put(struct hashmap *map,
    ++				struct hashmap_entry *entry)
      {
      	struct hashmap_entry *old = hashmap_remove(map, entry, NULL);
      	hashmap_add(map, entry);
    @@ -39,8 +42,8 @@
       * Returns the replaced entry, or NULL if not found (i.e. the entry was added).
       */
     -void *hashmap_put(struct hashmap *map, struct hashmap_entry *entry);
    -+struct hashmap_entry *
    -+hashmap_put(struct hashmap *map, struct hashmap_entry *entry);
    ++struct hashmap_entry *hashmap_put(struct hashmap *map,
    ++				struct hashmap_entry *entry);
     +
     +#define hashmap_put_entry(map, keyvar, type, member) \
     +	container_of_or_null(hashmap_put(map, &(keyvar)->member), type, member)
    @@ -52,17 +55,17 @@
       * Argument explanation is the same as in `hashmap_get`.
       */
     -void *hashmap_remove(struct hashmap *map, const struct hashmap_entry *key,
    -+struct hashmap_entry *
    -+hashmap_remove(struct hashmap *map, const struct hashmap_entry *key,
    - 		const void *keydata);
    - 
    +-		const void *keydata);
    ++struct hashmap_entry *hashmap_remove(struct hashmap *map,
    ++					const struct hashmap_entry *key,
    ++					const void *keydata);
    ++
     +#define hashmap_remove_entry(map, keyvar, keydata, type, member) \
     +	container_of_or_null(hashmap_remove(map, &(keyvar)->member, keydata), \
     +				type, member)
    -+
    + 
      /*
       * Returns the `bucket` an entry is stored in.
    -  * Useful for multithreaded read access.
     
      diff --git a/range-diff.c b/range-diff.c
      --- a/range-diff.c
17:  150944128b ! 17:  adc7cb5516 hashmap: introduce hashmap_free_entries
    @@ -12,6 +12,7 @@
         the hashmap itself.
     
         Signed-off-by: Eric Wong <e@80x24.org>
    +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
     
      diff --git a/blame.c b/blame.c
      --- a/blame.c
18:  de212aa6d6 ! 18:  1a68e1645d OFFSETOF_VAR macro to simplify hashmap iterators
    @@ -5,7 +5,7 @@
         While we cannot rely on a `__typeof__' operator being portable
         to use with `offsetof'; we can calculate the pointer offset
         using an existing pointer and the address of a member using
    -    pointer arithmetic.
    +    pointer arithmetic for compilers without `__typeof__'.
     
         This allows us to simplify usage of hashmap iterator macros
         by not having to specify a type when a pointer of that type
    @@ -16,7 +16,10 @@
         trouble of using container_of/list_entry macros and without
         relying on non-portable `__typeof__'.
     
    +    v3: use `__typeof__' to avoid clang warnings
    +
         Signed-off-by: Eric Wong <e@80x24.org>
    +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
     
      diff --git a/attr.c b/attr.c
      --- a/attr.c
    @@ -141,11 +144,17 @@
      	(type *)container_of_or_null_offset(ptr, offsetof(type, member))
      
     +/*
    -+ * like offsetof(), but takes a pointer to type instead of the type
    -+ * @ptr is subject to multiple evaluation since we can't rely on TYPEOF()
    ++ * like offsetof(), but takes a pointer to a a variable of type which
    ++ * contains @member, instead of a specified type.
    ++ * @ptr is subject to multiple evaluation since we can't rely on __typeof__
    ++ * everywhere.
     + */
    ++#if defined(__GNUC__) /* clang sets this, too */
    ++#define OFFSETOF_VAR(ptr, member) offsetof(__typeof__(*ptr), member)
    ++#else /* !__GNUC__ */
     +#define OFFSETOF_VAR(ptr, member) \
     +	((uintptr_t)&(ptr)->member - (uintptr_t)(ptr))
    ++#endif /* !__GNUC__ */
     +
      #endif
     
19:  212a596edd ! 19:  fe02b9f839 hashmap: remove type arg from hashmap_{get,put,remove}_entry
    @@ -10,6 +10,7 @@
         sequential as they are used as: `keyvar->member'
     
         Signed-off-by: Eric Wong <e@80x24.org>
    +    Reviewed-by: Derrick Stolee <stolee@gmail.com>
     
      diff --git a/attr.c b/attr.c
      --- a/attr.c
    @@ -147,8 +148,8 @@
       *                 printf("first: %ld %s\n", e->key, e->value);
       *                 while ((e = hashmap_get_next_entry(&map, e,
     @@
    - struct hashmap_entry *
    - hashmap_put(struct hashmap *map, struct hashmap_entry *entry);
    + struct hashmap_entry *hashmap_put(struct hashmap *map,
    + 				struct hashmap_entry *entry);
      
     -#define hashmap_put_entry(map, keyvar, type, member) \
     -	container_of_or_null(hashmap_put(map, &(keyvar)->member), type, member)
    @@ -167,8 +168,8 @@
      /*
       * Removes a hashmap entry matching the specified key. If the hashmap contains
     @@
    - hashmap_remove(struct hashmap *map, const struct hashmap_entry *key,
    - 		const void *keydata);
    + 					const struct hashmap_entry *key,
    + 					const void *keydata);
      
     -#define hashmap_remove_entry(map, keyvar, keydata, type, member) \
     -	container_of_or_null(hashmap_remove(map, &(keyvar)->member, keydata), \
 -:  ---------- > 20:  4ec5200646 hashmap_entry: remove first member requirement from docs
