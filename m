From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: Re: Re* [PATCH] Make git add -u honor --dry-run
Date: Tue, 20 May 2008 00:14:48 +0200
Message-ID: <4831FBD8.3050402@isy.liu.se>
References: <482C5FF8.1060200@isy.liu.se> <1210868459-9511-1-git-send-email-vmiklos@frugalware.org> <7vmymrf81x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 20 00:15:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyDe8-0007CA-2X
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 00:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765644AbYESWO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 18:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765695AbYESWO4
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 18:14:56 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:52867 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765688AbYESWOy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 18:14:54 -0400
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 1D5D0259B1;
	Tue, 20 May 2008 00:14:52 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 20458-09; Thu,  8 May 2008 07:37:08 +0200 (MEST)
Received: from [192.168.13.13] (85.8.6.119.static.se.wasadata.net [85.8.6.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bogotron.isy.liu.se (Postfix) with ESMTP id 8556524F8F;
	Tue, 20 May 2008 00:14:50 +0200 (MEST)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <7vmymrf81x.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82454>

On 2008-05-16 01:42, Junio C Hamano wrote:
> Miklos Vajna <vmiklos@frugalware.org> writes:
>> On Thu, May 15, 2008 at 06:08:24PM +0200, Gustaf Hendeby <hendeby@isy.liu.se> wrote:
>>> I'm not familiar enough with the code to see how to best fix it.
> 
> That makes the whole thing noop, doesn't it?  We could do the surgery at a
> bit lower layer, I guess.

What is the status on this one?  I've been away for a while and when I 
got back I didn't see any more than this suggestion.  I'm really in over 
my head here, but I think (judging from a compiler warning) the 
following needs to be amended:

diff --git a/builtin-checkout.c b/builtin-checkout.c
index cf9875c..39fef84 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -282,7 +282,7 @@ static int merge_working_tree(struct checkout_opts 
*opts,
                          * entries in the index.
                          */

-                       add_files_to_cache(0, NULL, NULL);
+                       add_files_to_cache(NULL, NULL, 0);
                         work = write_tree_from_memory();

                         ret = reset_to_new(new->commit->tree, opts->quiet);


I had started to think about a much less intrusive solution limited to 
builtin-add.c but, without really understanding all that is going on 
here, this seems to be a more flexible and better solution for the long run.

/Gustaf

> 
> 
>  cache.h          |    8 +++++---
>  builtin-add.c    |   22 +++++++++++++---------
>  builtin-commit.c |    2 +-
>  builtin-mv.c     |    2 +-
>  read-cache.c     |   20 ++++++++++++++++----
>  5 files changed, 36 insertions(+), 18 deletions(-)
> 
> diff --git a/cache.h b/cache.h
> index 98cfed6..cf30e53 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -173,7 +173,7 @@ extern struct index_state the_index;
>  #define add_cache_entry(ce, option) add_index_entry(&the_index, (ce), (option))
>  #define remove_cache_entry_at(pos) remove_index_entry_at(&the_index, (pos))
>  #define remove_file_from_cache(path) remove_file_from_index(&the_index, (path))
> -#define add_file_to_cache(path, verbose) add_file_to_index(&the_index, (path), (verbose))
> +#define add_file_to_cache(path, flags) add_file_to_index(&the_index, (path), (flags))
>  #define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL)
>  #define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
>  #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
> @@ -272,7 +272,9 @@ extern int add_index_entry(struct index_state *, struct cache_entry *ce, int opt
>  extern struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int really);
>  extern int remove_index_entry_at(struct index_state *, int pos);
>  extern int remove_file_from_index(struct index_state *, const char *path);
> -extern int add_file_to_index(struct index_state *, const char *path, int verbose);
> +#define ADD_CACHE_VERBOSE 1
> +#define ADD_CACHE_PRETEND 2
> +extern int add_file_to_index(struct index_state *, const char *path, int flags);
>  extern struct cache_entry *make_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage, int refresh);
>  extern int ce_same_name(struct cache_entry *a, struct cache_entry *b);
>  
> @@ -640,7 +642,7 @@ extern int convert_to_git(const char *path, const char *src, size_t len, struct
>  extern int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst);
>  
>  /* add */
> -void add_files_to_cache(int verbose, const char *prefix, const char **pathspec);
> +void add_files_to_cache(const char *prefix, const char **pathspec, int flags);
>  
>  /* diff.c */
>  extern int diff_auto_refresh_index;
> diff --git a/builtin-add.c b/builtin-add.c
> index 4a91e3e..cb61366 100644
> --- a/builtin-add.c
> +++ b/builtin-add.c
> @@ -82,9 +82,9 @@ static void fill_directory(struct dir_struct *dir, const char **pathspec,
>  static void update_callback(struct diff_queue_struct *q,
>  			    struct diff_options *opt, void *cbdata)
>  {
> -	int i, verbose;
> +	int i, flags;
>  
> -	verbose = *((int *)cbdata);
> +	flags = *((int *)cbdata);
>  	for (i = 0; i < q->nr; i++) {
>  		struct diff_filepair *p = q->queue[i];
>  		const char *path = p->one->path;
> @@ -94,18 +94,19 @@ static void update_callback(struct diff_queue_struct *q,
>  		case DIFF_STATUS_UNMERGED:
>  		case DIFF_STATUS_MODIFIED:
>  		case DIFF_STATUS_TYPE_CHANGED:
> -			add_file_to_cache(path, verbose);
> +			add_file_to_cache(path, flags);
>  			break;
>  		case DIFF_STATUS_DELETED:
> -			remove_file_from_cache(path);
> -			if (verbose)
> +			if (!(flags & ADD_CACHE_PRETEND))
> +				remove_file_from_cache(path);
> +			if (flags)
>  				printf("remove '%s'\n", path);
>  			break;
>  		}
>  	}
>  }
>  
> -void add_files_to_cache(int verbose, const char *prefix, const char **pathspec)
> +void add_files_to_cache(const char *prefix, const char **pathspec, int flags)
>  {
>  	struct rev_info rev;
>  	init_revisions(&rev, prefix);
> @@ -113,7 +114,7 @@ void add_files_to_cache(int verbose, const char *prefix, const char **pathspec)
>  	rev.prune_data = pathspec;
>  	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
>  	rev.diffopt.format_callback = update_callback;
> -	rev.diffopt.format_callback_data = &verbose;
> +	rev.diffopt.format_callback_data = &flags;
>  	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
>  }
>  
> @@ -209,10 +210,13 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  
>  	if (take_worktree_changes) {
>  		const char **pathspec;
> +		int flags = ((verbose ? ADD_CACHE_VERBOSE : 0) |
> +			     (show_only ? ADD_CACHE_PRETEND : 0));
> +
>  		if (read_cache() < 0)
>  			die("index file corrupt");
>  		pathspec = get_pathspec(prefix, argv);
> -		add_files_to_cache(verbose, prefix, pathspec);
> +		add_files_to_cache(prefix, pathspec, flags);
>  		goto finish;
>  	}
>  
> @@ -254,7 +258,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	for (i = 0; i < dir.nr; i++)
> -		add_file_to_cache(dir.entries[i]->name, verbose);
> +		add_file_to_cache(dir.entries[i]->name, ADD_CACHE_VERBOSE);
>  
>   finish:
>  	if (active_cache_changed) {
> diff --git a/builtin-commit.c b/builtin-commit.c
> index 2f4d6cc..f31bf59 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -239,7 +239,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
>  	 */
>  	if (all || (also && pathspec && *pathspec)) {
>  		int fd = hold_locked_index(&index_lock, 1);
> -		add_files_to_cache(0, also ? prefix : NULL, pathspec);
> +		add_files_to_cache(also ? prefix : NULL, pathspec, 0);
>  		refresh_cache(REFRESH_QUIET);
>  		if (write_cache(fd, active_cache, active_nr) ||
>  		    close_lock_file(&index_lock))
> diff --git a/builtin-mv.c b/builtin-mv.c
> index 990e213..1ad3178 100644
> --- a/builtin-mv.c
> +++ b/builtin-mv.c
> @@ -256,7 +256,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  
>  		for (i = 0; i < added.nr; i++) {
>  			const char *path = added.items[i].path;
> -			add_file_to_cache(path, verbose);
> +			add_file_to_cache(path, verbose ? ADD_CACHE_VERBOSE : 0);
>  		}
>  
>  		for (i = 0; i < deleted.nr; i++)
> diff --git a/read-cache.c b/read-cache.c
> index 7db5588..a95861b 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -384,12 +384,14 @@ static int index_name_pos_also_unmerged(struct index_state *istate,
>  	return pos;
>  }
>  
> -int add_file_to_index(struct index_state *istate, const char *path, int verbose)
> +int add_file_to_index(struct index_state *istate, const char *path, int flags)
>  {
> -	int size, namelen, pos;
> +	int size, namelen, pos, was_same;
>  	struct stat st;
>  	struct cache_entry *ce;
>  	unsigned ce_option = CE_MATCH_IGNORE_VALID|CE_MATCH_RACY_IS_DIRTY;
> +	int verbose = flags & (ADD_CACHE_VERBOSE|ADD_CACHE_PRETEND);
> +	int pretend = flags & ADD_CACHE_PRETEND;
>  
>  	if (lstat(path, &st))
>  		die("%s: unable to stat (%s)", path, strerror(errno));
> @@ -432,9 +434,19 @@ int add_file_to_index(struct index_state *istate, const char *path, int verbose)
>  
>  	if (index_path(ce->sha1, path, &st, 1))
>  		die("unable to index file %s", path);
> -	if (add_index_entry(istate, ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE))
> +
> +	/* It was suspected to be racily clean but it turns out to be Ok */
> +	was_same = (0 <= pos &&
> +		    !ce_stage(istate->cache[pos]) &&
> +		    !hashcmp(ce->sha1, istate->cache[pos]->sha1) &&
> +		    ce->ce_mode == istate->cache[pos]->ce_mode);
> +
> +	if (pretend)
> +		;
> +	else if (add_index_entry(istate, ce,
> +				 ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE))
>  		die("unable to add %s to index",path);
> -	if (verbose)
> +	if (verbose && !was_same)
>  		printf("add '%s'\n", path);
>  	return 0;
>  }
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
