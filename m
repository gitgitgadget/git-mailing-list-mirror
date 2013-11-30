From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 23/24] POC for partial writing
Date: Sat, 30 Nov 2013 16:58:55 +0700
Message-ID: <CACsJy8Bti465Lv9U+m=VnqvGQAFk=WxCsmcGmdB0=NLesF5Mtw@mail.gmail.com>
References: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com> <1385553659-9928-24-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, tr@thomasrast.ch,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 30 10:59:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmhKo-0002KI-My
	for gcvg-git-2@plane.gmane.org; Sat, 30 Nov 2013 10:59:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033Ab3K3J7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Nov 2013 04:59:30 -0500
Received: from mail-qe0-f53.google.com ([209.85.128.53]:59854 "EHLO
	mail-qe0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998Ab3K3J70 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Nov 2013 04:59:26 -0500
Received: by mail-qe0-f53.google.com with SMTP id nc12so9632932qeb.40
        for <git@vger.kernel.org>; Sat, 30 Nov 2013 01:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aIndwZ/SZcBc1zhp4X8F80U389aadDOfeNFSDmyREq4=;
        b=cRFdJRB84ZU+ftajDRsmAoyc/ICc/LplDn4Xv6MruGhyFDlm4RrU3w8UJ4yOQpZJEc
         hGvxaXxf3T8T2OYUjouvBDVF22Ho2DwBwrkMbh2Yf6MQ0Pty2lAXIc2ddnEHlYjrSgaM
         KUuHc5k2tj8vUhCFZRwOt81xAf3K7SJwsnnOz+vbEO0cHRiHxtyflTjXbhSpDgPiH/wC
         dRssnRnEGiVNd+wiY9KSns+9RDnbl6PQmRoMPFA+GoxI/t2Hw49AjEpkA72Wu6XnoV/e
         G8Hfp5iLqX0/3IoCbPIz9ApiXJOhsZ8ldqfacPo+rf8xgcQV+k856vAK6fPvhhgFArmK
         WGwQ==
X-Received: by 10.224.114.81 with SMTP id d17mr94532324qaq.18.1385805565189;
 Sat, 30 Nov 2013 01:59:25 -0800 (PST)
Received: by 10.96.134.68 with HTTP; Sat, 30 Nov 2013 01:58:55 -0800 (PST)
In-Reply-To: <1385553659-9928-24-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238552>

On Wed, Nov 27, 2013 at 7:00 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> This makes update-index use both partial reading and partial writing.
> Partial reading is only used no option other than the paths is passed to
> the command.
>
> This passes the test suite,

Just checking, the test suite was run with TEST_GIT_INDEX_VERSION=5, right?

> but doesn't behave correctly when a write
> fails.  A log should be written to the lock file, in order to be able to
> recover if a write fails.

>From the API point of view this looks nice (you should have hidden
needs_write = 1 in cache_invalidate_path and change_cache_version
though)  We could support partial file removal too by marking removed
files "removed", but that impacts the reading code and may have bad
interaction with cache_invalidate_path/needs_rewrite. Probably not
worth the effort until someone shows us they remove stuff often.

> ---
>  builtin/update-index.c |  43 +++++++++++---
>  cache-tree.c           |  13 +++++
>  cache-tree.h           |   1 +
>  cache.h                |  27 ++++++++-
>  lockfile.c             |   2 +-
>  read-cache-v2.c        |   2 +
>  read-cache-v5.c        | 154 ++++++++++++++++++++++++++++++++++++++++---------
>  read-cache.c           |  30 ++++++++++
>  read-cache.h           |   1 +
>  resolve-undo.c         |   1 +
>  10 files changed, 237 insertions(+), 37 deletions(-)
>
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 8b3f7a0..69f0949 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -56,6 +56,7 @@ static int mark_ce_flags(const char *path, int flag, int mark)
>                 else
>                         active_cache[pos]->ce_flags &= ~flag;
>                 cache_tree_invalidate_path(active_cache_tree, path);
> +               the_index.needs_rewrite = 1;
>                 active_cache_changed = 1;
>                 return 0;
>         }
> @@ -99,6 +100,8 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
>         memcpy(ce->name, path, len);
>         ce->ce_flags = create_ce_flags(0);
>         ce->ce_namelen = len;
> +       if (old)
> +               ce->entry_pos = old->entry_pos;
>         fill_stat_cache_info(ce, st);
>         ce->ce_mode = ce_mode_from_stat(old, st->st_mode);
>
> @@ -268,6 +271,7 @@ static void chmod_path(int flip, const char *path)
>                 goto fail;
>         }
>         cache_tree_invalidate_path(active_cache_tree, path);
> +       the_index.needs_rewrite = 1;
>         active_cache_changed = 1;
>         report("chmod %cx '%s'", flip, path);
>         return;
> @@ -706,15 +710,18 @@ static int reupdate_callback(struct parse_opt_ctx_t *ctx,
>
>  int cmd_update_index(int argc, const char **argv, const char *prefix)
>  {
> -       int newfd, entries, has_errors = 0, line_termination = '\n';
> +       int newfd, has_errors = 0, line_termination = '\n';
>         int read_from_stdin = 0;
>         int prefix_length = prefix ? strlen(prefix) : 0;
>         int preferred_index_format = 0;
>         char set_executable_bit = 0;
>         struct refresh_params refresh_args = {0, &has_errors};
>         int lock_error = 0;
> +       struct filter_opts opts;
> +       struct pathspec pathspec;
>         struct lock_file *lock_file;
>         struct parse_opt_ctx_t ctx;
> +       int i, needs_full_read = 0;
>         int parseopt_state = PARSE_OPT_UNKNOWN;
>         struct option options[] = {
>                 OPT_BIT('q', NULL, &refresh_args.flags,
> @@ -810,9 +817,23 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>         if (newfd < 0)
>                 lock_error = errno;
>
> -       entries = read_cache();
> -       if (entries < 0)
> -               die("cache corrupted");
> +       for (i = 0; i < argc; i++) {
> +               if (!prefixcmp(argv[i], "--"))
> +                       needs_full_read = 1;
> +       }
> +       if (!needs_full_read) {
> +               memset(&opts, 0, sizeof(struct filter_opts));
> +               parse_pathspec(&pathspec, 0,
> +                              PATHSPEC_PREFER_CWD |
> +                              PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
> +                              prefix, argv + 1);
> +               opts.pathspec = &pathspec;
> +               if (read_cache_filtered(&opts) < 0)
> +                       die("cache corrupted");
> +       } else {
> +               if (read_cache() < 0)
> +                       die("cache corrupted");
> +       }
>
>         /*
>          * Custom copy of parse_options() because we want to handle
> @@ -862,6 +883,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>                             preferred_index_format,
>                             INDEX_FORMAT_LB, INDEX_FORMAT_UB);
>
> +               the_index.needs_rewrite = 1;
>                 active_cache_changed = 1;
>                 change_cache_version(preferred_index_format);
>         }
> @@ -890,17 +912,22 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>         }
>
>         if (active_cache_changed) {
> +               int r;
>                 if (newfd < 0) {
>                         if (refresh_args.flags & REFRESH_QUIET)
>                                 exit(128);
>                         unable_to_lock_index_die(get_index_file(), lock_error);
>                 }
> -               if (write_cache(newfd, active_cache, active_nr) ||
> -                   commit_locked_index(lock_file))
> +               r = write_cache_partial(newfd);
> +               if (r < 0)
>                         die("Unable to write new index file");
> +               else if (r == 0)
> +                       commit_lock_file(lock_file);
> +               else
> +                       remove_lock_file();
> +       } else {
> +               rollback_lock_file(lock_file);
>         }
>
> -       rollback_lock_file(lock_file);
> -
>         return has_errors ? 1 : 0;
>  }
> diff --git a/cache-tree.c b/cache-tree.c
> index 1209732..a3d18bb 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -123,6 +123,15 @@ void cache_tree_invalidate_path(struct cache_tree *it, const char *path)
>                 return;
>         slash = strchr(path, '/');
>         it->entry_count = -1;
> +       /*
> +        * Mark the cache_tree directory entry as invalid too. The
> +        * entry_count defines if the tree is valid, so we don't need
> +        * to reset any other field.
> +        */
> +       if (it->de_ref) {
> +               it->de_ref->de_nentries = -1;
> +               it->de_ref->changed = 1;
> +       }
>         if (!slash) {
>                 int pos;
>                 namelen = strlen(path);
> @@ -140,6 +149,10 @@ void cache_tree_invalidate_path(struct cache_tree *it, const char *path)
>                                 sizeof(struct cache_tree_sub *) *
>                                 (it->subtree_nr - pos - 1));
>                         it->subtree_nr--;
> +                       if (it->de_ref) {
> +                               it->de_ref->de_nsubtrees--;
> +                               it->de_ref->changed = 1;
> +                       }
>                 }
>                 return;
>         }
> diff --git a/cache-tree.h b/cache-tree.h
> index 9818926..eaf14a9 100644
> --- a/cache-tree.h
> +++ b/cache-tree.h
> @@ -18,6 +18,7 @@ struct cache_tree {
>         unsigned char sha1[20];
>         int subtree_nr;
>         int subtree_alloc;
> +       struct directory_entry *de_ref;
>         struct cache_tree_sub **down;
>  };
>
> diff --git a/cache.h b/cache.h
> index 71b98cf..1a634dc 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -137,11 +137,31 @@ struct cache_entry {
>         unsigned int ce_namelen;
>         unsigned char sha1[20];
>         uint32_t ce_stat_crc;
> +       unsigned int entry_pos;
> +       unsigned int changed;
>         struct cache_entry *next; /* used by name_hash */
>         struct cache_entry *next_ce;
>         char name[FLEX_ARRAY]; /* more */
>  };
>
> +struct directory_entry {
> +       struct directory_entry **sub;
> +       struct directory_entry *next;
> +       struct directory_entry *next_hash;
> +       struct cache_entry *ce;
> +       struct cache_entry *ce_last;
> +       uint32_t de_foffset;
> +       uint32_t de_nsubtrees;
> +       uint32_t de_nfiles;
> +       uint32_t de_nentries;
> +       unsigned char sha1[20];
> +       uint16_t de_flags;
> +       uint32_t de_pathlen;
> +       uint32_t entry_pos;
> +       unsigned int changed;
> +       char pathname[FLEX_ARRAY];
> +};
> +
>  #define CE_NAMEMASK  (0x0fff)
>  #define CE_STAGEMASK (0x3000)
>  #define CE_EXTENDED  (0x4000)
> @@ -317,13 +337,15 @@ struct filter_opts {
>
>  struct index_state {
>         struct cache_entry **cache;
> +       struct directory_entry *root_directory;
>         unsigned int version;
>         unsigned int cache_nr, cache_alloc, cache_changed;
>         struct string_list *resolve_undo;
>         struct cache_tree *cache_tree;
>         struct cache_time timestamp;
>         unsigned name_hash_initialized : 1,
> -                initialized : 1;
> +                initialized : 1,
> +                needs_rewrite : 1;
>         struct hash_table name_hash;
>         struct hash_table dir_hash;
>         struct index_ops *ops;
> @@ -353,6 +375,7 @@ extern void free_name_hash(struct index_state *istate);
>  #define is_cache_unborn() is_index_unborn(&the_index)
>  #define read_cache_unmerged() read_index_unmerged(&the_index)
>  #define write_cache(newfd, cache, entries) write_index(&the_index, (newfd))
> +#define write_cache_partial(newfd) write_index_partial(&the_index, (newfd))
>  #define discard_cache() discard_index(&the_index)
>  #define unmerged_cache() unmerged_index(&the_index)
>  #define cache_name_pos(name, namelen) index_name_pos(&the_index,(name),(namelen))
> @@ -529,6 +552,7 @@ extern int read_index_from(struct index_state *, const char *path);
>  extern int is_index_unborn(struct index_state *);
>  extern int read_index_unmerged(struct index_state *);
>  extern int write_index(struct index_state *, int newfd);
> +extern int write_index_partial(struct index_state *, int newfd);
>  extern int discard_index(struct index_state *);
>  extern int unmerged_index(const struct index_state *);
>  extern int verify_path(const char *path);
> @@ -613,6 +637,7 @@ extern NORETURN void unable_to_lock_index_die(const char *path, int err);
>  extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
>  extern int hold_lock_file_for_append(struct lock_file *, const char *path, int);
>  extern int commit_lock_file(struct lock_file *);
> +extern void remove_lock_file(void);
>  extern void update_index_if_able(struct index_state *, struct lock_file *);
>
>  extern int hold_locked_index(struct lock_file *, int);
> diff --git a/lockfile.c b/lockfile.c
> index 8fbcb6a..c150e5c 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -7,7 +7,7 @@
>  static struct lock_file *lock_file_list;
>  static const char *alternate_index_output;
>
> -static void remove_lock_file(void)
> +void remove_lock_file(void)
>  {
>         pid_t me = getpid();
>
> diff --git a/read-cache-v2.c b/read-cache-v2.c
> index f884c10..1fec892 100644
> --- a/read-cache-v2.c
> +++ b/read-cache-v2.c
> @@ -555,5 +555,7 @@ struct index_ops v2_ops = {
>         match_stat_basic,
>         verify_hdr,
>         read_index_v2,
> +       write_index_v2,
> +       /* Partial writing is the same as writing the full index for v2 */
>         write_index_v2
>  };
> diff --git a/read-cache-v5.c b/read-cache-v5.c
> index a5e9b5a..13436a3 100644
> --- a/read-cache-v5.c
> +++ b/read-cache-v5.c
> @@ -20,22 +20,6 @@ struct extension_header {
>         uint32_t crc;
>  };
>
> -struct directory_entry {
> -       struct directory_entry **sub;
> -       struct directory_entry *next;
> -       struct directory_entry *next_hash;
> -       struct cache_entry *ce;
> -       struct cache_entry *ce_last;
> -       uint32_t de_foffset;
> -       uint32_t de_nsubtrees;
> -       uint32_t de_nfiles;
> -       uint32_t de_nentries;
> -       unsigned char sha1[20];
> -       uint16_t de_flags;
> -       uint32_t de_pathlen;
> -       char pathname[FLEX_ARRAY];
> -};
> -
>  struct conflict_part {
>         struct conflict_part *next;
>         uint16_t flags;
> @@ -246,7 +230,7 @@ static struct directory_entry *read_directories(unsigned int *dir_offset,
>                 offsetof(struct ondisk_directory_entry, name) - 5;
>         disk_de = ptr_add(mmap, *dir_offset);
>         de = directory_entry_from_ondisk(disk_de, len);
> -
> +       de->entry_pos = *dir_offset;
>         data_len = len + 1 + offsetof(struct ondisk_directory_entry, name);
>         filecrc = ptr_add(mmap, *dir_offset + data_len);
>         if (!check_crc32(0, ptr_add(mmap, *dir_offset), data_len, ntoh_l(*filecrc)))
> @@ -281,6 +265,7 @@ static int read_entry(struct cache_entry **ce, char *pathname, size_t pathlen,
>         entry_offset = first_entry_offset + ntoh_l(*beginning);
>         disk_ce = ptr_add(mmap, entry_offset);
>         *ce = cache_entry_from_ondisk(disk_ce, pathname, len, pathlen);
> +       (*ce)->entry_pos = entry_offset;
>         filecrc = ptr_add(mmap, entry_offset + len + 1 + sizeof(*disk_ce));
>         if (!check_crc32(0,
>                 ptr_add(mmap, entry_offset), len + 1 + sizeof(*disk_ce),
> @@ -439,6 +424,7 @@ static struct cache_tree *convert_one(struct directory_entry *de)
>
>         it = cache_tree();
>         it->entry_count = de->de_nentries;
> +       it->de_ref = de;
>         if (0 <= it->entry_count)
>                 hashcpy(it->sha1, de->sha1);
>
> @@ -523,14 +509,6 @@ static int read_entries(struct index_state *istate, struct directory_entry *de,
>         return 0;
>  }
>
> -static void free_directory_tree(struct directory_entry *de) {
> -       int i;
> -
> -       for (i = 0; i < de->de_pathlen; i++)
> -               free_directory_tree(de->sub[i]);
> -       free(de);
> -}
> -
>  /*
>   * Read an index-v5 file filtered by the filter_opts.   If opts is NULL,
>   * everything will be read.
> @@ -626,7 +604,7 @@ static int read_index_v5(struct index_state *istate, void *mmap,
>                 }
>         }
>         istate->cache_tree = cache_tree_convert_v5(root_directory);
> -       free_directory_tree(root_directory);
> +       istate->root_directory = root_directory;
>         istate->cache_nr = nr;
>         return 0;
>  }
> @@ -696,6 +674,7 @@ static void ce_smudge_racily_clean_entry(struct cache_entry *ce)
>          * that hasn't changed checking the sha1.
>          */
>         ce->ce_flags |= CE_SMUDGED;
> +       ce->changed = 1;
>  }
>
>  static char *super_directory(char *filename)
> @@ -1231,6 +1210,103 @@ static int write_resolve_undo(struct index_state *istate,
>         return 0;
>  }
>
> +static int write_ce_if_necessary(struct cache_entry *ce, void *cb_data)
> +{
> +       int *fdx = cb_data, pathlen, size;
> +       int fd = *fdx;
> +       char *dir;
> +       struct ondisk_cache_entry *ondisk;
> +       uint32_t crc;
> +
> +       assert(ce->entry_pos != 0);
> +       /* TODO I'm just using the_index out of lazyness here */
> +       if (!ce_uptodate(ce) && is_racy_timestamp(&the_index, ce))
> +               ce_smudge_racily_clean_entry(ce);
> +       if (!ce->changed)
> +               return 0;
> +       if (is_null_sha1(ce->sha1)) {
> +               static const char msg[] = "cache entry has null sha1: %s";
> +               static int allow = -1;
> +
> +               if (allow < 0)
> +                       allow = git_env_bool("GIT_ALLOW_NULL_SHA1", 0);
> +               if (allow)
> +                       warning(msg, ce->name);
> +               else
> +                       return error(msg, ce->name);
> +       }
> +       dir = super_directory(ce->name);
> +       pathlen = dir ? strlen(dir) + 1 : 0;
> +       size = offsetof(struct ondisk_cache_entry, name) +
> +               ce_namelen(ce) - pathlen + 1;
> +       ondisk = xmalloc(size);
> +
> +       crc = 0;
> +       ondisk_from_cache_entry(ce, ondisk, pathlen);
> +       if (lseek(fd, ce->entry_pos, SEEK_SET) < ce->entry_pos)
> +               die("eror ce seeking");
> +       if (ce_write(&crc, fd, ondisk, size) < 0)
> +               return -1;
> +       crc = htonl(crc);
> +       if (ce_write(NULL, fd, &crc, 4) < 0)
> +               return -1;
> +       return ce_flush(fd);
> +}
> +
> +static void ondisk_from_directory_entry_partial(struct directory_entry *de,
> +                                               struct ondisk_directory_entry *ondisk)
> +{
> +       ondisk->foffset   = htonl(de->de_foffset);
> +       ondisk->nsubtrees = htonl(de->de_nsubtrees);
> +       ondisk->nfiles    = htonl(de->de_nfiles);
> +       ondisk->nentries  = htonl(de->de_nentries);
> +       hashcpy(ondisk->sha1, de->sha1);
> +       ondisk->flags     = htons(de->de_flags);
> +       if (de->de_pathlen == 0) {
> +               memcpy(ondisk->name, "\0", 1);
> +       } else {
> +               memcpy(ondisk->name, de->pathname, de->de_pathlen);
> +               memcpy(ondisk->name + de->de_pathlen - 1, "/\0", 2);
> +       }
> +}
> +
> +static int write_directories_partial(struct directory_entry *de, int fd)
> +{
> +       int ondisk_size = offsetof(struct ondisk_directory_entry, name);
> +       int size = ondisk_size + de->de_pathlen + 1;
> +       int i;
> +       uint32_t crc;
> +       struct ondisk_directory_entry *ondisk;
> +
> +       if (de->changed) {
> +               crc = 0;
> +               ondisk = xmalloc(size);
> +               ondisk_from_directory_entry_partial(de, ondisk);
> +               if (lseek(fd, de->entry_pos, SEEK_SET) < de->entry_pos)
> +                       die("error directory seeking");;
> +               if (ce_write(&crc, fd, ondisk, size) < 0)
> +                       return -1;
> +               crc = htonl(crc);
> +               if (ce_write(NULL, fd, &crc, 4) < 0)
> +                       return -1;
> +               free(ondisk);
> +               if (ce_flush(fd) < 0)
> +                       return -1;
> +       }
> +       for (i = 0; i < de->de_nsubtrees; i++) {
> +               if (write_directories_partial(de->sub[i], fd) < 0)
> +                       return -1;
> +       }
> +       return 0;
> +}
> +
> +static int write_partial(struct index_state *istate, int fd)
> +{
> +       write_directories_partial(istate->root_directory, fd);
> +
> +       return for_each_index_entry(istate, write_ce_if_necessary, &fd);
> +}
> +
>  static int write_index_v5(struct index_state *istate, int newfd)
>  {
>         struct cache_header hdr;
> @@ -1296,9 +1372,33 @@ static int write_index_v5(struct index_state *istate, int newfd)
>         return ce_flush(newfd);
>  }
>
> +static int write_index_partial_v5(struct index_state *istate, int newfd)
> +{
> +       int fd;
> +       char *path = get_index_file();
> +
> +       if (istate->needs_rewrite || istate->cache_nr == 0)
> +               return write_index_v5(istate, newfd);
> +       if (istate->filter_opts && istate->needs_rewrite)
> +               die("BUG: cannot write a partially read index");
> +       fd = open(path, O_RDWR, 0666);
> +       if (fd < 0) {
> +               if (errno == ENOENT)
> +                       die("no index file exists cannot do a partial write");
> +               die_errno("index file opening for writing failed");
> +       }
> +
> +       if (write_partial(istate, fd) < 0)
> +               return -1;
> +       if (ce_flush(fd) < 0)
> +               return -1;
> +       return 1;
> +}
> +
>  struct index_ops v5_ops = {
>         match_stat_basic,
>         verify_hdr,
>         read_index_v5,
> -       write_index_v5
> +       write_index_v5,
> +       write_index_partial_v5
>  };
> diff --git a/read-cache.c b/read-cache.c
> index 04430e5..1cad0e2 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -32,6 +32,9 @@ static void replace_index_entry(struct index_state *istate, int nr, struct cache
>
>         remove_name_hash(istate, old);
>         set_index_entry(istate, nr, ce);
> +       ce->changed = 1;
> +       if (ce->entry_pos == 0)
> +               istate->needs_rewrite = 1;
>         istate->cache_changed = 1;
>  }
>
> @@ -494,6 +497,7 @@ int remove_index_entry_at(struct index_state *istate, int pos)
>
>         record_resolve_undo(istate, ce);
>         remove_name_hash(istate, ce);
> +       istate->needs_rewrite = 1;
>         istate->cache_changed = 1;
>         istate->cache_nr--;
>         if (pos >= istate->cache_nr)
> @@ -520,6 +524,7 @@ void remove_marked_cache_entries(struct index_state *istate)
>                 else
>                         ce_array[j++] = ce_array[i];
>         }
> +       istate->needs_rewrite = 1;
>         istate->cache_changed = 1;
>         istate->cache_nr = j;
>  }
> @@ -1024,6 +1029,7 @@ int add_index_entry(struct index_state *istate, struct cache_entry *ce, int opti
>                         istate->cache + pos,
>                         (istate->cache_nr - pos - 1) * sizeof(ce));
>         set_index_entry(istate, pos, ce);
> +       istate->needs_rewrite = 1;
>         istate->cache_changed = 1;
>         return 0;
>  }
> @@ -1108,6 +1114,8 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
>         size = ce_size(ce);
>         updated = xmalloc(size);
>         memcpy(updated, ce, size);
> +       updated->changed = 1;
> +       updated->entry_pos = ce->entry_pos;
>         fill_stat_cache_info(updated, &st);
>         /*
>          * If ignore_valid is not set, we should leave CE_VALID bit
> @@ -1201,6 +1209,8 @@ int refresh_index(struct index_state *istate, unsigned int flags,
>                                  * means the index is not valid anymore.
>                                  */
>                                 ce->ce_flags &= ~CE_VALID;
> +                               /* TODO: remove this maybe? */
> +                               istate->needs_rewrite = 1;
>                                 istate->cache_changed = 1;
>                         }
>                         if (quiet)
> @@ -1241,6 +1251,8 @@ void initialize_index(struct index_state *istate, int version)
>                         version = atoi(envversion);
>         }
>         istate->version = version;
> +       istate->needs_rewrite = 0;
> +       istate->root_directory = NULL;
>         set_istate_ops(istate);
>  }
>
> @@ -1427,6 +1439,16 @@ int is_index_unborn(struct index_state *istate)
>         return (!istate->cache_nr && !istate->timestamp.sec);
>  }
>
> +static void free_directory_tree(struct directory_entry *de) {
> +       int i;
> +
> +       if (!de)
> +               return;
> +       for (i = 0; i < de->de_pathlen; i++)
> +               free_directory_tree(de->sub[i]);
> +       free(de);
> +}
> +
>  int discard_index(struct index_state *istate)
>  {
>         int i;
> @@ -1435,6 +1457,7 @@ int discard_index(struct index_state *istate)
>                 free(istate->cache[i]);
>         resolve_undo_clear_index(istate);
>         istate->cache_nr = 0;
> +       istate->needs_rewrite = 0;
>         istate->cache_changed = 0;
>         istate->timestamp.sec = 0;
>         istate->timestamp.nsec = 0;
> @@ -1446,6 +1469,8 @@ int discard_index(struct index_state *istate)
>         istate->cache_alloc = 0;
>         istate->ops = NULL;
>         istate->filter_opts = NULL;
> +       free_directory_tree(istate->root_directory);
> +       istate->root_directory = NULL;
>         return 0;
>  }
>
> @@ -1491,6 +1516,11 @@ int write_index(struct index_state *istate, int newfd)
>         return istate->ops->write_index(istate, newfd);
>  }
>
> +int write_index_partial(struct index_state *istate, int newfd)
> +{
> +       return istate->ops->write_index_partial(istate, newfd);
> +}
> +
>  /*
>   * Read the index file that is potentially unmerged into given
>   * index_state, dropping any unmerged entries.  Returns true if
> diff --git a/read-cache.h b/read-cache.h
> index 9d66df6..e7f36ae 100644
> --- a/read-cache.h
> +++ b/read-cache.h
> @@ -31,6 +31,7 @@ struct index_ops {
>         int (*read_index)(struct index_state *istate, void *mmap, unsigned long mmap_size,
>                           struct filter_opts *opts);
>         int (*write_index)(struct index_state *istate, int newfd);
> +       int (*write_index_partial)(struct index_state *istate, int newfd);
>  };
>
>  extern struct index_ops v2_ops;
> diff --git a/resolve-undo.c b/resolve-undo.c
> index c09b006..c496c20 100644
> --- a/resolve-undo.c
> +++ b/resolve-undo.c
> @@ -110,6 +110,7 @@ void resolve_undo_clear_index(struct index_state *istate)
>         string_list_clear(resolve_undo, 1);
>         free(resolve_undo);
>         istate->resolve_undo = NULL;
> +       istate->needs_rewrite = 1;
>         istate->cache_changed = 1;
>  }
>
> --
> 1.8.4.2
>



-- 
Duy
