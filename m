From: david@lang.hm
Subject: RE:
Date: Thu, 7 May 2009 15:27:32 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0905071521130.15782@asgard>
References: <454B76988CBF42F5BCACA5061125D263@caottdt504> <81b0412b0905071013y241f7eas8417127e51ff52fa@mail.gmail.com> <D75C0FA80F7041FFAAC50B314788AD6F@caottdt504> <alpine.LFD.2.01.0905071148500.4983@localhost.localdomain> <A07C3E66E84D46ACB37EDC7D396CCA62@caottdt504>
 <alpine.LFD.2.01.0905071248250.4983@localhost.localdomain> <alpine.LFD.2.01.0905071312000.4983@localhost.localdomain> <alpine.LFD.2.01.0905071446500.4983@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Bevan Watkiss <bevan.watkiss@cloakware.com>,
	"'Alex Riesen'" <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 08 00:29:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2C5T-0004xA-2o
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 00:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763551AbZEGW2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 18:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763560AbZEGW2c
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 18:28:32 -0400
Received: from mail.lang.hm ([64.81.33.126]:36038 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763550AbZEGW2b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 18:28:31 -0400
Received: from asgard.local (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n47MRWHc025221;
	Thu, 7 May 2009 15:27:32 -0700
X-X-Sender: dlang@asgard
In-Reply-To: <alpine.LFD.2.01.0905071446500.4983@localhost.localdomain>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118531>

On Thu, 7 May 2009, Linus Torvalds wrote:

this patch is worthwhile in itself, but the use case that is presented 
here is slightly different, and I wonder if it's common enough to be worth 
having a config option for.

his use case (as I understand it) is that the working tree is never 
updated by anything other than git. it never recieves patches or manual 
edits.

as such _any_ lstats of the tree are a waste of time. if git knows what 
was checked out before and what is being checked out now, it can find what 
files need to be changed.

this situation is not common for most developers, but it would be 
reasonable for build farms, so it's not just a one-person issue.

David Lang


> On Thu, 7 May 2009, Linus Torvalds wrote:
>>
>> Hmm. The second pass comes from
>>
>> 	show_local_changes(&new->commit->object);
>>
>> (this is the "git checkout" without actual filenames), and is suppressed
>> if we ask for a quiet checkout. But it's sad how it re-loads the index. I
>> wonder where the CE_VALID bit got dropped.
>
> Ahh. It's not actually dropped, it's still there.
>
> It's just that 'get_stat_data()' doesn't check it, when asking for
> noncached data.
>
> The logic of 'get_stat_data()' is that it will return the stat data from
> the filesystem (unless we explicitly ask for just the cached case, in
> which case it will take it from the cache entry directly).
>
> However, the code doesn't realize that if ce_uptodate() is true, then we
> already know the stat data, so no need to do the lstat() again, and we
> can take it all from the cache entry regardless of whether we asked for
> filesystem data or cached data.
>
> So here's a better patch. It should cut down the 'lstat()' calls from "git
> checkout" a lot.
>
> It looks obvious enough, and it passes testing (and now "git checkout"
> only does about as many lstat's as there are files in the repository, and
> they seem to all be properly asynchronous if 'core.preloadindex' is set.
>
> Somebody should check. It would be interesting to hear about whether this
> makes a performance impact, especially with slow filesystems and/or other
> operating systems that have a relatively higher cost for 'lstat()'.
>
> 		Linus
>
> ---
> builtin-checkout.c |    4 ++--
> diff-lib.c         |    2 +-
> 2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin-checkout.c b/builtin-checkout.c
> index 15f0c32..3100ccd 100644
> --- a/builtin-checkout.c
> +++ b/builtin-checkout.c
> @@ -216,7 +216,7 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
> 	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
>
> 	newfd = hold_locked_index(lock_file, 1);
> -	if (read_cache() < 0)
> +	if (read_cache_preload(pathspec) < 0)
> 		return error("corrupt index file");
>
> 	if (source_tree)
> @@ -367,7 +367,7 @@ static int merge_working_tree(struct checkout_opts *opts,
> 	int newfd = hold_locked_index(lock_file, 1);
> 	int reprime_cache_tree = 0;
>
> -	if (read_cache() < 0)
> +	if (read_cache_preload(NULL) < 0)
> 		return error("corrupt index file");
>
> 	cache_tree_free(&active_cache_tree);
> diff --git a/diff-lib.c b/diff-lib.c
> index a310fb2..0aba6cd 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -214,7 +214,7 @@ static int get_stat_data(struct cache_entry *ce,
> 	const unsigned char *sha1 = ce->sha1;
> 	unsigned int mode = ce->ce_mode;
>
> -	if (!cached) {
> +	if (!cached && !ce_uptodate(ce)) {
> 		int changed;
> 		struct stat st;
> 		changed = check_removed(ce, &st);
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
