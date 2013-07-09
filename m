From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [RFC/PATCH 0/1] cygwin: Remove the Win32 l/stat() functions
Date: Tue, 09 Jul 2013 13:02:07 +0200
Message-ID: <51DBEDAF.30708@web.de>
References: <51C5FD28.1070004@ramsay1.demon.co.uk> <51C6BC4B.9030905@web.de> <51C8BF2C.2050203@ramsay1.demon.co.uk> <7vy59y4w3r.fsf@alter.siamese.dyndns.org> <51C94425.7050006@alum.mit.edu> <51CB610C.7050501@ramsay1.demon.co.uk> <20130626223552.GA12785@sigill.intra.peff.net> <51CBD2FD.5070905@alum.mit.edu> <51CCC643.1050702@ramsay1.demon.co.uk> <51D06AC8.70206@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, mlevedahl@gmail.com,
	dpotapov@gmail.com, GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Jul 09 13:02:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwVgd-0004uR-W4
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 13:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914Ab3GILCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 07:02:17 -0400
Received: from mout.web.de ([212.227.15.4]:52442 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751488Ab3GILCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 07:02:16 -0400
Received: from birne.lan ([195.67.191.23]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0MNL6f-1UpdvN2ZZZ-006tL6; Tue, 09 Jul 2013 13:02:09 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <51D06AC8.70206@ramsay1.demon.co.uk>
X-Provags-ID: V03:K0:6mEbK4qC/ux4VJuqpUDq2jSnFsA+zZIj4Xt7UZlxRFgYLD+wb8l
 NJRSh8XU1KIqOa7m/fqoKAIeYjVfDgMVZCE3A7VvaDv2iN7RRVc0u+GEgZyjsx0/UJLxIYB
 R4bOsU7LGxV1qGSUS1yQ55vTjKEBwX+JGYg3PHdqqf2DCB81r097QHA/BqvQS4iY+qIis61
 YaTfuDzNhhuohiIMAnCNQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229944>

On 30.06.13 19:28, Ramsay Jones wrote:
> Ramsay Jones wrote:
>> Michael Haggerty wrote:
>>> On 06/27/2013 12:35 AM, Jeff King wrote:
>> [ ... ]
>>>> I think Michael's assessment above is missing one thing.
>>> Peff is absolutely right; for some unknown reason I was thinking of the
>>> consistency check as having been already fixed.
>> Well, the "cygwin: Remove the Win32 l/stat() functions" patch *does* fix
>> the problem. :-D It's just a pity we can't use it on performance grounds. :(
>>
>>>> [...#ifdef out consistency check on cygwin when lock is held...]
>>> Yes, this would work.
>>>
>>> But, taking a step back, I think it is a bad idea to have an unreliable
>>> stat() masquerading as a real stat().  If we want to allow the use of an
>>> unreliable stat for certain purposes, let's have two stat() interfaces:
>>>
>>> * the true stat() (in this case I guess cygwin's slow-but-correct
>>> implementation)
>>>
>>> * some fast_but_maybe_unreliable_stat(), which would map to stat() on
>>> most platforms but might map to the Windows stat() on cygwin when so
>>> configured.
>>>
>>> By default the true stat() would always be used.  It should have to be a
>>> conscious decision, taken only in specific, vetted scenarios, to use the
>>> unreliable stat.
>> You have just described my second patch! :D
> Unfortunately, I have not had any time to work on the patch this weekend.
> However, despite the patch being a bit rough around the edges, I decided
> to send it out (see below) to get some early feedback.
>
> Note that it passes the t3210, t3211, t5500, t3200, t3301, t7606 and t1301
> tests, but I have not run the full test suite.
>
> Comments welcome.
>
> ATB,
> Ramsay Jones
>
> -- >8 --
> Subject: [PATCH] cygwin: Add fast_[l]stat() functions
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>  builtin/apply.c        |  6 +++---
>  builtin/commit.c       |  2 +-
>  builtin/ls-files.c     |  2 +-
>  builtin/rm.c           |  2 +-
>  builtin/update-index.c |  2 +-
>  check-racy.c           |  2 +-
>  compat/cygwin.c        | 12 ------------
>  compat/cygwin.h        | 10 +++-------
>  diff-lib.c             |  2 +-
>  diff.c                 |  2 +-
>  entry.c                |  4 ++--
>  git-compat-util.h      | 13 +++++++++++--
>  help.c                 |  5 +----
>  path.c                 |  9 +--------
>  preload-index.c        |  2 +-
>  read-cache.c           |  6 +++---
>  unpack-trees.c         |  8 ++++----
>  17 files changed, 36 insertions(+), 53 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 0e9b631..ca26caa 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -3253,7 +3253,7 @@ static int load_current(struct image *image, struct patch *patch)
>  	if (pos < 0)
>  		return error(_("%s: does not exist in index"), name);
>  	ce = active_cache[pos];
> -	if (lstat(name, &st)) {
> +	if (fast_lstat(name, &st)) {
>  		if (errno != ENOENT)
>  			return error(_("%s: %s"), name, strerror(errno));
>  		if (checkout_target(ce, &st))
> @@ -3396,7 +3396,7 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
>  	if (previous) {
>  		st_mode = previous->new_mode;
>  	} else if (!cached) {
> -		stat_ret = lstat(old_name, st);
> +		stat_ret = fast_lstat(old_name, st);
>  		if (stat_ret && errno != ENOENT)
>  			return error(_("%s: %s"), old_name, strerror(errno));
>  	}
> @@ -3850,7 +3850,7 @@ static void add_index_file(const char *path, unsigned mode, void *buf, unsigned
>  			die(_("corrupt patch for subproject %s"), path);
>  	} else {
>  		if (!cached) {
> -			if (lstat(path, &st) < 0)
> +			if (fast_lstat(path, &st) < 0)
>  				die_errno(_("unable to stat newly created file '%s'"),
>  					  path);
>  			fill_stat_cache_info(ce, &st);
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 6b693c1..1d208c6 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -231,7 +231,7 @@ static void add_remove_files(struct string_list *list)
>  		if (p->util)
>  			continue;
>  
> -		if (!lstat(p->string, &st)) {
> +		if (!fast_lstat(p->string, &st)) {
>  			if (add_to_cache(p->string, &st, 0))
>  				die(_("updating files failed"));
>  		} else
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 08d9786..db66a0e 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -251,7 +251,7 @@ static void show_files(struct dir_struct *dir)
>  				continue;
>  			if (ce_skip_worktree(ce))
>  				continue;
> -			err = lstat(ce->name, &st);
> +			err = fast_lstat(ce->name, &st);
>  			if (show_deleted && err)
>  				show_ce_entry(tag_removed, ce);
>  			if (show_modified && ce_modified(ce, &st, 0))
> diff --git a/builtin/rm.c b/builtin/rm.c
> index 06025a2..4b783e7 100644
> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -143,7 +143,7 @@ static int check_local_mod(unsigned char *head, int index_only)
>  		}
>  		ce = active_cache[pos];
>  
> -		if (lstat(ce->name, &st) < 0) {
> +		if (fast_lstat(ce->name, &st) < 0) {
>  			if (errno != ENOENT && errno != ENOTDIR)
>  				warning("'%s': %s", ce->name, strerror(errno));
>  			/* It already vanished from the working tree */
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 5c7762e..4790e4c 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -206,7 +206,7 @@ static int process_path(const char *path)
>  	 * First things first: get the stat information, to decide
>  	 * what to do about the pathname!
>  	 */
> -	if (lstat(path, &st) < 0)
> +	if (fast_lstat(path, &st) < 0)
>  		return process_lstat_error(path, errno);
>  
>  	if (S_ISDIR(st.st_mode))
> diff --git a/check-racy.c b/check-racy.c
> index 00d92a1..6124355 100644
> --- a/check-racy.c
> +++ b/check-racy.c
> @@ -11,7 +11,7 @@ int main(int ac, char **av)
>  		struct cache_entry *ce = active_cache[i];
>  		struct stat st;
>  
> -		if (lstat(ce->name, &st)) {
> +		if (fast_lstat(ce->name, &st)) {
>  			error("lstat(%s): %s", ce->name, strerror(errno));
>  			continue;
>  		}
> diff --git a/compat/cygwin.c b/compat/cygwin.c
> index 91ce5d4..f07cbd3 100644
> --- a/compat/cygwin.c
> +++ b/compat/cygwin.c
> @@ -6,18 +6,6 @@
>  #include "../git-compat-util.h"
>  #include "../cache.h" /* to read configuration */
>  
> -/*
> - * Return POSIX permission bits, regardless of core.ignorecygwinfstricks
> - */
> -int cygwin_get_st_mode_bits(const char *path, int *mode)
> -{
> -	struct stat st;
> -	if (lstat(path, &st) < 0)
> -		return -1;
> -	*mode = st.st_mode;
> -	return 0;
> -}
> -
>  static inline void filetime_to_timespec(const FILETIME *ft, struct timespec *ts)
>  {
>  	long long winTime = ((long long)ft->dwHighDateTime << 32) +
> diff --git a/compat/cygwin.h b/compat/cygwin.h
> index c04965a..8299f58 100644
> --- a/compat/cygwin.h
> +++ b/compat/cygwin.h
> @@ -4,11 +4,7 @@
>  typedef int (*stat_fn_t)(const char*, struct stat*);
>  extern stat_fn_t cygwin_stat_fn;
>  extern stat_fn_t cygwin_lstat_fn;
> -int cygwin_get_st_mode_bits(const char *path, int *mode);
>  
> -#define get_st_mode_bits(p,m) cygwin_get_st_mode_bits((p),(m))
> -#ifndef CYGWIN_C
> -/* cygwin.c needs the original lstat() */
> -#define stat(path, buf) (*cygwin_stat_fn)(path, buf)
> -#define lstat(path, buf) (*cygwin_lstat_fn)(path, buf)
> -#endif
> +#define fast_stat(path, buf) (*cygwin_stat_fn)(path, buf)
> +#define fast_lstat(path, buf) (*cygwin_lstat_fn)(path, buf)
> +#define GIT_FAST_STAT
> diff --git a/diff-lib.c b/diff-lib.c
> index b6f4b21..401dab6 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -27,7 +27,7 @@
>   */
>  static int check_removed(const struct cache_entry *ce, struct stat *st)
>  {
> -	if (lstat(ce->name, st) < 0) {
> +	if (fast_lstat(ce->name, st) < 0) {
>  		if (errno != ENOENT && errno != ENOTDIR)
>  			return -1;
>  		return 1;
> diff --git a/diff.c b/diff.c
> index 208094f..212d3ff 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2642,7 +2642,7 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
>  	 * If ce matches the file in the work tree, we can reuse it.
>  	 */
>  	if (ce_uptodate(ce) ||
> -	    (!lstat(name, &st) && !ce_match_stat(ce, &st, 0)))
> +	    (!fast_lstat(name, &st) && !ce_match_stat(ce, &st, 0)))
>  		return 1;
>  
>  	return 0;
> diff --git a/entry.c b/entry.c
> index d7c131d..4d2ac73 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -210,7 +210,7 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
>  finish:
>  	if (state->refresh_cache) {
>  		if (!fstat_done)
> -			lstat(ce->name, &st);
> +			fast_lstat(ce->name, &st);
>  		fill_stat_cache_info(ce, &st);
>  	}
>  	return 0;
> @@ -230,7 +230,7 @@ static int check_path(const char *path, int len, struct stat *st, int skiplen)
>  		errno = ENOENT;
>  		return -1;
>  	}
> -	return lstat(path, st);
> +	return fast_lstat(path, st);
>  }
>  
>  int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath)
> diff --git a/git-compat-util.h b/git-compat-util.h
> index ff193f4..7997bdb 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -129,8 +129,6 @@
>  #include <poll.h>
>  #endif
>  
> -extern int get_st_mode_bits(const char *path, int *mode);
> -
>  #if defined(__MINGW32__)
>  /* pull in Windows compatibility stuff */
>  #include "compat/mingw.h"
> @@ -179,6 +177,17 @@ typedef unsigned long uintptr_t;
>  #endif
>  #endif
>  
> +#ifndef GIT_FAST_STAT
> +static inline int fast_stat(const char *path, struct stat *st)
> +{
> +	return stat(path, st);
> +}
> +static inline int fast_lstat(const char *path, struct stat *st)
> +{
> +	return lstat(path, st);
> +}
> +#endif
> +
>  /* used on Mac OS X */
>  #ifdef PRECOMPOSE_UNICODE
>  #include "compat/precompose_utf8.h"
> diff --git a/help.c b/help.c
> index 08c54ef..f068925 100644
> --- a/help.c
> +++ b/help.c
> @@ -107,10 +107,7 @@ static int is_executable(const char *name)
>  	    !S_ISREG(st.st_mode))
>  		return 0;
>  
> -#if defined(GIT_WINDOWS_NATIVE) || defined(__CYGWIN__)
> -#if defined(__CYGWIN__)
> -if ((st.st_mode & S_IXUSR) == 0)
> -#endif
> +#if defined(GIT_WINDOWS_NATIVE)
>  {	/* cannot trust the executable bit, peek into the file instead */
>  	char buf[3] = { 0 };
>  	int n;
> diff --git a/path.c b/path.c
> index 7f3324a..3d244d3 100644
> --- a/path.c
> +++ b/path.c
> @@ -5,13 +5,7 @@
>  #include "strbuf.h"
>  #include "string-list.h"
>  
> -#ifndef get_st_mode_bits
> -/*
> - * The replacement lstat(2) we use on Cygwin is incomplete and
> - * may return wrong permission bits. Most of the time we do not care,
> - * but the callsites of this wrapper do care.
> - */
> -int get_st_mode_bits(const char *path, int *mode)
> +static int get_st_mode_bits(const char *path, int *mode)
>  {
>  	struct stat st;
>  	if (lstat(path, &st) < 0)
> @@ -19,7 +13,6 @@ int get_st_mode_bits(const char *path, int *mode)
>  	*mode = st.st_mode;
>  	return 0;
>  }
> -#endif
>  
>  static char bad_path[] = "/bad-path/";
>  
> diff --git a/preload-index.c b/preload-index.c
> index 49cb08d..1bece91 100644
> --- a/preload-index.c
> +++ b/preload-index.c
> @@ -57,7 +57,7 @@ static void *preload_thread(void *_data)
>  			continue;
>  		if (threaded_has_symlink_leading_path(&cache, ce->name, ce_namelen(ce)))
>  			continue;
> -		if (lstat(ce->name, &st))
> +		if (fast_lstat(ce->name, &st))
>  			continue;
>  		if (ie_match_stat(index, ce, &st, CE_MATCH_RACY_IS_DIRTY))
>  			continue;
> diff --git a/read-cache.c b/read-cache.c
> index d5201f9..ed33d9e 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -689,7 +689,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
>  int add_file_to_index(struct index_state *istate, const char *path, int flags)
>  {
>  	struct stat st;
> -	if (lstat(path, &st))
> +	if (fast_lstat(path, &st))
>  		die_errno("unable to stat '%s'", path);
>  	return add_to_index(istate, path, &st, flags);
>  }
> @@ -1049,7 +1049,7 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
>  		return ce;
>  	}
>  
> -	if (lstat(ce->name, &st) < 0) {
> +	if (fast_lstat(ce->name, &st) < 0) {
>  		if (err)
>  			*err = errno;
>  		return NULL;
> @@ -1635,7 +1635,7 @@ static void ce_smudge_racily_clean_entry(struct cache_entry *ce)
>  	 */
>  	struct stat st;
>  
> -	if (lstat(ce->name, &st) < 0)
> +	if (fast_lstat(ce->name, &st) < 0)
>  		return;
>  	if (ce_match_stat_basic(ce, &st))
>  		return;
> diff --git a/unpack-trees.c b/unpack-trees.c
> index b27f2a6..1fe9b63 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1215,7 +1215,7 @@ static int verify_uptodate_1(const struct cache_entry *ce,
>  	else if (o->reset || ce_uptodate(ce))
>  		return 0;
>  
> -	if (!lstat(ce->name, &st)) {
> +	if (!fast_lstat(ce->name, &st)) {
>  		int flags = CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE;
>  		unsigned changed = ie_match_stat(o->src_index, ce, &st, flags);
>  		if (!changed)
> @@ -1432,13 +1432,13 @@ static int verify_absent_1(const struct cache_entry *ce,
>  		char path[PATH_MAX + 1];
>  		memcpy(path, ce->name, len);
>  		path[len] = 0;
> -		if (lstat(path, &st))
> +		if (fast_lstat(path, &st))
>  			return error("cannot stat '%s': %s", path,
>  					strerror(errno));
>  
>  		return check_ok_to_remove(path, len, DT_UNKNOWN, NULL, &st,
>  				error_type, o);
> -	} else if (lstat(ce->name, &st)) {
> +	} else if (fast_lstat(ce->name, &st)) {
>  		if (errno != ENOENT)
>  			return error("cannot stat '%s': %s", ce->name,
>  				     strerror(errno));
> @@ -1852,7 +1852,7 @@ int oneway_merge(const struct cache_entry * const *src,
>  		int update = 0;
>  		if (o->reset && o->update && !ce_uptodate(old) && !ce_skip_worktree(old)) {
>  			struct stat st;
> -			if (lstat(old->name, &st) ||
> +			if (fast_lstat(old->name, &st) ||
>  			    ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE))
>  				update |= CE_UPDATE;
>  		}
I managed to apply your patch on next, and run the test suite before and after
your patch.
The performance running "git status" on a linux kernel is the same as in v1.8.3.

Running test suite did not show new failures.
The following test cases had failed, and are fixed now:
< t1400-update-ref
< t3210-pack-refs
< t3211-peel-ref
< t3306-notes-prune
< t5304-prune
< t5404-tracking-branches
< t5500-fetch-pack
< t5505-remote
< t5514-fetch-multiple
< t5515-fetch-merge-logic
< t6030-bisect-porcelain
< t9300-fast-import
< t9903-bash-prompt

In short: Thanks, This looks good to me.
