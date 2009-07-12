From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: [PATCH 6/3] Export thread-safe version of
 'has_symlink_leading_path()'
Date: Sun, 12 Jul 2009 02:09:56 +0200
Organization: private
Message-ID: <86r5wmvk17.fsf@broadpark.no>
References: <20090707000500.GA5594@dpotapov.dyndns.org>
 <alpine.LFD.2.01.0907081902371.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081933530.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081936470.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081940220.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081942380.3352@localhost.localdomain>
 <7vskh646bw.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907090832200.3352@localhost.localdomain>
 <7vws6h3ji4.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907091011280.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907091013540.3352@localhost.localdomain>
 <7vab3d3dpc.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907091153130.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907091344340.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907091344530.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907091347080.3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jul 12 02:11:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPmfQ-00041B-Kc
	for gcvg-git-2@gmane.org; Sun, 12 Jul 2009 02:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbZGLAL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2009 20:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751709AbZGLAL1
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jul 2009 20:11:27 -0400
Received: from bgo1smout1.broadpark.no ([217.13.4.94]:37202 "EHLO
	bgo1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbZGLAL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2009 20:11:27 -0400
Received: from bgo1sminn1.broadpark.no ([217.13.4.93])
 by bgo1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KMN00E7G770GK20@bgo1smout1.broadpark.no> for
 git@vger.kernel.org; Sun, 12 Jul 2009 02:11:24 +0200 (CEST)
Received: from localhost ([80.203.106.150]) by bgo1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KMN00B9T76Y4181@bgo1sminn1.broadpark.no> for
 git@vger.kernel.org; Sun, 12 Jul 2009 02:11:24 +0200 (CEST)
In-reply-to: <alpine.LFD.2.01.0907091347080.3352@localhost.localdomain>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123134>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Thu, 9 Jul 2009 13:35:31 -0700
> Subject: [PATCH 6/3] Export thread-safe version of 'has_symlink_leading_path()'
>
> The threaded index preloading will want it, so that it can avoid
> locking by simply using a per-thread symlink/directory cache.
>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
> This just exposes a thread-safe version of the symlink checking by 
> allowing a caller to pass in its own local 'struct cache_def' to the 
> function.
>
> No users of this yet, but the next step is trivial and obvious..
>
>  cache.h    |   10 ++++++++++
>  symlinks.c |   21 ++++++++++-----------
>  2 files changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 871c984..f1e5ede 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -744,7 +744,17 @@ struct checkout {
>  };
>  
>  extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath);
> +
> +struct cache_def {
> +	char path[PATH_MAX + 1];
> +	int len;
> +	int flags;
> +	int track_flags;
> +	int prefix_len_stat_func;
> +};
> +
>  extern int has_symlink_leading_path(const char *name, int len);
> +extern int threaded_has_symlink_leading_path(struct cache_def *, const char *, int);
>  extern int has_symlink_or_noent_leading_path(const char *name, int len);
>  extern int has_dirs_only_path(const char *name, int len, int prefix_len);
>  extern void invalidate_lstat_cache(const char *name, int len);
> diff --git a/symlinks.c b/symlinks.c
> index 08ad353..4bdded3 100644
> --- a/symlinks.c
> +++ b/symlinks.c
> @@ -32,13 +32,7 @@ static int longest_path_match(const char *name_a, int len_a,
>  	return match_len;
>  }
>  
> -static struct cache_def {
> -	char path[PATH_MAX + 1];
> -	int len;
> -	int flags;
> -	int track_flags;
> -	int prefix_len_stat_func;
> -} default_cache;
> +static struct cache_def default_cache;
>  
>  static inline void reset_lstat_cache(struct cache_def *cache)
>  {
> @@ -217,12 +211,17 @@ void clear_lstat_cache(void)
>  /*
>   * Return non-zero if path 'name' has a leading symlink component
>   */
> +int threaded_has_symlink_leading_path(struct cache_def *cache, const char *name, int len)
> +{
> +	return lstat_cache(cache, name, len, FL_SYMLINK|FL_DIR, USE_ONLY_LSTAT) & FL_SYMLINK;

  OK, to follow the style the 3 previous lstat_cache() calls was made
  with (and also let the line length be less than 80), it should have
  been written like this:

     	return lstat_cache(cache, name, len,
			   FL_SYMLINK|FL_DIR, USE_ONLY_LSTAT) &
		FL_SYMLINK;

  Notice that the parmeters which is just copied as arguments to l_c()
  is in the same order and on the first line for it self.  The next line
  contains the rest of the arguments, and the &-part is also on it
  a separate line.

  Stylefix only, so not a big deal.

> +}
> +
> +/*
> + * Return non-zero if path 'name' has a leading symlink component
> + */
>  int has_symlink_leading_path(const char *name, int len)
>  {
> -	struct cache_def *cache = &default_cache;	/* FIXME */

   This would make it inconsistent with the 2 has_*_() functions below,
   which both have such a line.  Only stylefix, no change in semantics.

   I personally liked this line, since it will then be easier to
   "threadify" the function with an extra parameter named "cache".

> -	return lstat_cache(cache, name, len,
> -			   FL_SYMLINK|FL_DIR, USE_ONLY_LSTAT) &
> -		FL_SYMLINK;
> +	return threaded_has_symlink_leading_path(&default_cache, name, len);
>  }
>  
>  /*

  I have looked at and tested (the version from the origin/pu branch, so
  it contains the memset() line squashed in) patch 5/3, 6/3 and 7/3, and
  all 3 patches looks correct, so you can add

     Reviewed-and-tested-by: Kjetil Barvik

  if you want to.

  But, I guess it is me which is a litle late to comment things, since I
  already see that all 3 patches is in the pu, next and master branches
  already, less than 3 days after beeing posted to the malinglist.

  But, would'nt it be a good thing to let all patches at least be in the
  pu branch for minimum x days before entering next and master?  Or: let
  it go minimum x days after beeing posted to the list before entering
  the next and master branch?  x = 4?

  Since the patches is already in master and next, I guess it is not as
  easy as if the patche(es) has been in pu to make a new version of a
  patch, since both master and next is expected to be fast-forward
  branches.

  -- kjetil, which was too late this time, too  :-)
