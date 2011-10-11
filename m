From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Improving performance with pthreads in refresh_index().
Date: Tue, 11 Oct 2011 12:46:47 +0200
Message-ID: <4E941E97.2070906@viscovery.net>
References: <1318325521-23262-1-git-send-email-klinkert@webgods.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: klinkert@webgods.de
X-From: git-owner@vger.kernel.org Tue Oct 11 12:47:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDZrR-0004n1-9E
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 12:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754506Ab1JKKq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 06:46:56 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:64559 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754265Ab1JKKqz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 06:46:55 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RDZrE-0005p6-1Z; Tue, 11 Oct 2011 12:46:48 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id B3D841660F;
	Tue, 11 Oct 2011 12:46:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.23) Gecko/20110920 Thunderbird/3.1.15
In-Reply-To: <1318325521-23262-1-git-send-email-klinkert@webgods.de>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183290>

First of all, thanks for your contribution!

When you submit a patch, you should make sure that the "From:" line of
your mail includes your full name. You included it in the Signed-off-by
line and that is a good start.

Am 10/11/2011 11:32, schrieb klinkert@webgods.de:
> Git performs for every file in a repository at least one (with a cold cache)
> lstat().

It doesn't do the lstat() when the cache is warm? I doubt it.

> In larger repositories operations like git status take a
> long time. In case your local repository is located on a remote server
> (e. g. mounted via nfs) it ends up in an *incredible* slow git.

"Incredible" is very subjective. You should back your claim with benchmarks.

> With this patch you're able to determine a number of threads (maxthreads)
> in your config file to run these tons of lstats in threads. There
> won't be created any pthreads if you haven't set maxthreads. In my
> test cases a git status with this patch performs enormously faster (over
> two minutes before and approximately 25 seconds now).

Ok, so here you have something that you can turn into a benchmark. Just
replace the hand-waving by hard facts.

You report an improvement by a factor 4. How many threads did you use? How
does the number of threads change the improvement. How does the number of
threads influence the performance on a repository that is not on a network
partition? Can I set it to 25 even on a dual core machine without
noticable degradation?

> Of course, it
> has a positive impact on other git commands, too.

What other commands? Benchmarks?

> diff --git a/attr.c b/attr.c
> index 33cb4e4..d296fe8 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -8,10 +8,14 @@
>   */
>  
>  #define NO_THE_INDEX_COMPATIBILITY_MACROS
> +#include <pthread.h>

This and all pthread usages should be bracketed by NO_PTHREADS, or you
could use thread-utils.h instead. And it should be included *after* cache.h.

> +#undef _FILE_OFFSET_BITS

What is this good for?

>  #include "cache.h"
>  #include "exec_cmd.h"
>  #include "attr.h"
>  
> +pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;

This should be static, no? Otherwise, the name is *WAY* too generic for a
global variable.

What does the mutex protect? Please write some comment. It is not obvious.
Or perhaps it is sufficient to move the variable near the data that it
protects.

PTHREAD_MUTEX_INITIALIZER does not work on Windows. Please call
pthread_mutex_init() from a suitable place.

> +
>  const char git_attr__true[] = "(builtin)true";
>  const char git_attr__false[] = "\0(builtin)false";
>  static const char git_attr__unknown[] = "(builtin)unknown";
> @@ -748,6 +752,9 @@ int git_check_attr(const char *path, int num, struct git_attr_check *check)
>  {
>  	int i;
>  
> +	if (max_threads)
> +		pthread_mutex_lock(&mutex);

As I said, this should be bracketed by #ifndef NO_PTHREADS. But since you
also bracket all mutex uses by max_threads anyway, you should factor this
into a small helper function.

> --- a/cache.h
> +++ b/cache.h
> @@ -600,6 +600,7 @@ extern int read_replace_refs;
>  extern int fsync_object_files;
>  extern int core_preload_index;
>  extern int core_apply_sparse_checkout;
> +extern int max_threads;

This name is *WAY* too generic for a global variable. Please choose a more
specific name.

> --- a/config.c
> +++ b/config.c
> @@ -466,6 +466,11 @@ int git_config_pathname(const char **dest, const char *var, const char *value)
>  
>  static int git_default_core_config(const char *var, const char *value)
>  {
> +	if (!strcmp(var, "core.maxthreads")) {

Same here. core.maxthreads is *WAY* too generic for its current use.
Please paint the bikeshed in a more distiguishing color. ;)

> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -5,6 +5,8 @@
>   */
>  #define NO_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
> +#undef _FILE_OFFSET_BITS

Again: why this?

> +#include <pthread.h>
>  #include "cache-tree.h"
>  #include "refs.h"
>  #include "dir.h"
> @@ -13,6 +15,8 @@
>  #include "blob.h"
>  #include "resolve-undo.h"
>  
> +pthread_mutex_t mutex_refresh_index = PTHREAD_MUTEX_INITIALIZER;

Should be static, no?

>  static void show_file(const char * fmt, const char * name, int in_porcelain,
> -		      int * first, const char *header_msg)
> +		      int * first, char *header_msg)

Why?

> -int refresh_index(struct index_state *istate, unsigned int flags, const char **pathspec,
> -		  char *seen, const char *header_msg)
> +struct t_ctx {
> +	int flags;
> +	int has_errors;
> +	struct index_state *istate;
> +	const char **pathspec;
> +	char *seen, header_msg;
> +
> +	int tasks_done;
> +} ctx;

Should this be static? Is this the only global data that is protected by
the mutex?

> +
> +int
> +thread_manager(void)

Style: the type is on the same line as the function name.

> +void *
> +thread_refresh_index(void *p)
>  {
> +	struct cache_entry *ce, *new;
> +	int cache_errno = 0;
>  	int i;
> -	int has_errors = 0;
> +
> +	while ((i = thread_manager()) != -1) {
> +		struct index_state *istate = ctx.istate;
> +		int flags = ctx.flags;
> +
>  	int really = (flags & REFRESH_REALLY) != 0;
>  	int allow_unmerged = (flags & REFRESH_UNMERGED) != 0;
>  	int quiet = (flags & REFRESH_QUIET) != 0;
>  	int not_new = (flags & REFRESH_IGNORE_MISSING) != 0;
> -	int ignore_submodules = (flags & REFRESH_IGNORE_SUBMODULES) != 0;
> +		int ignore_submodules =
> +			 (flags & REFRESH_IGNORE_SUBMODULES) != 0;

Indentation?

Perhaps it is worthwhile to factor the body of the loop into a helper
function in a preparatory patch to reduce churn in the "real" patch.

>  		ce = istate->cache[i];
> -		if (ignore_submodules && S_ISGITLINK(ce->ce_mode))
> +		if (ignore_submodules && S_ISGITLINK(ce->ce_mode)) {
>  			continue;
> +		}

Style: do not add braces unnecessarily.

> +
> +		if (max_threads)
> +			pthread_mutex_lock(&mutex_refresh_index);
>  
>  		if (ce_stage(ce)) {
>  			while ((i < istate->cache_nr) &&
>  			       ! strcmp(istate->cache[i]->name, ce->name))
>  				i++;
>  			i--;
> -			if (allow_unmerged)
> +			if (allow_unmerged) {
> +				if (max_threads)
> +					pthread_mutex_unlock(&mutex_refresh_index);
>  				continue;
> -			show_file(needs_merge_fmt, ce->name, in_porcelain, &first, header_msg);
> -			has_errors = 1;
> +			}
> +			show_file(needs_merge_fmt, ce->name, in_porcelain,
> +				 &first, &ctx.header_msg);

You are calling show_file() from the thread. Does that mean that the
output is not in index order anymore? Are there guarantees that the output
of different threads does not overlap?

> +			ctx.has_errors = 1;
> +			if (max_threads)
> +				pthread_mutex_unlock(&mutex_refresh_index);

So, at least the second worry is unfounded since output is produced while
the mutex is held.

BTW, would it be possible to use a different mutex for this purpose?

> +		/* create threads */
> +		for (i = 0; i < max_threads; i++) {
> +			ret = pthread_create(&threads[created_threads], NULL,
> +					     thread_refresh_index, NULL);
> +			if (ret) {
> +				printf("pthread_create failed ret=%d\n", ret);

We have warning() to write warnings.

-- Hannes
