From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add core.symlinks to mark filesystems that do not support symbolic links.
Date: Fri, 02 Mar 2007 16:05:58 -0800
Message-ID: <7vvehjchsp.fsf@assigned-by-dhcp.cox.net>
References: <200703022211.30322.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Mar 03 01:06:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNHlD-0006eT-1W
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 01:06:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992782AbXCCAGA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 19:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992783AbXCCAGA
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 19:06:00 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:33897 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992782AbXCCAF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 19:05:59 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070303000558.ZRYE26279.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 2 Mar 2007 19:05:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id W05y1W00T1kojtg0000000; Fri, 02 Mar 2007 19:05:59 -0500
In-Reply-To: <200703022211.30322.johannes.sixt@telecom.at> (Johannes Sixt's
	message of "Fri, 2 Mar 2007 22:11:30 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41259>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> Some file systems that can host git repositories and their working copies
> do not support symbolic links. But then if the repository contains a symbolic
> link, it is impossible to check out the working copy.

Overall the patch looks good.  Thanks.

> Of course, this does not magically make symbolic links work on such defective
> file systems; hence, this solution does not help if the working copy relies
> on that an entry is a real symbolic link.

Probably defective is too strong a word here, but I'll apply
your patch as-is anyway.  We may need a few fix-ups, but it is
easier to deal with such small updates on top of it once it is
in-tree.

> --- a/Documentation/git-update-index.txt
> +++ b/Documentation/git-update-index.txt
> @@ -295,6 +295,11 @@ in the index and the file mode on the filesystem if they differ only on
>  executable bit.   On such an unfortunate filesystem, you may
>  need to use `git-update-index --chmod=`.
>  
> +Quite similarly, if `core.symlinks` configuration variable is set
> +to 'false' (see gitlink:git-config[1]), symbolic links are checked out
> +as plain files, and this command does not modify a recorded file mode
> +from symbolic link to regular file.
> +
>  The command looks at `core.ignorestat` configuration variable.  See
>  'Using "assume unchanged" bit' section above.

This is off-topic, but I am having this nagging feeling that we
may want to revisit the ignorestat stuff to ignore more than
what it currently does.  For example, if we make it to not even
care if the path is missing from the working tree, I think it
would help working in a narrowly checked out repository.

> diff --git a/cache.h b/cache.h
> index 04f8e63..6f932fe 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -108,7 +108,10 @@ static inline unsigned int create_ce_mode(unsigned int mode)
>  }
>  static inline unsigned int ce_mode_from_stat(struct cache_entry *ce, unsigned int mode)
>  {
> -	extern int trust_executable_bit;
> +	extern int trust_executable_bit, has_symlinks;
> +	if (!has_symlinks && S_ISREG(mode) &&
> +	    ce && S_ISLNK(ntohl(ce->ce_mode)))
> +		return ce->ce_mode;
>  	if (!trust_executable_bit && S_ISREG(mode)) {
>  		if (ce && S_ISREG(ntohl(ce->ce_mode)))
>  			return ce->ce_mode;

This code (I am the guilty one before your change above) always
confused me.  How about doing something like this instead?

    static inline unsigned int ce_mode_from_stat(struct cache_entry *ce,...
    {
        /*
         * A regular file that appears on the filesystem can have
         * a "wrong" st_mode information.  A few repository config
         * variables can tell us to trust the mode recorded in the
         * index more than what we get from the filesystem.
         */
        if (ce && S_ISREG(mode)) {
            extern int trust_executable_bit, has_symlinks;

            if (!has_symlinks && S_ISLNK(ntohl(ce->ce_mode)))
                return ce->ce_mode;
            if (!trust_executable_bit && S_ISREG(ntohl(ce->ce_mode)))
                return ce->ce_mode;
            return create_ce_mode(0666);
        }
        return create_ce_mode(mode);
    }

> diff --git a/diff-lib.c b/diff-lib.c
> index 60c0fa6..2c121d2 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -134,6 +134,9 @@ int run_diff_files(struct rev_info *revs, int silent_on_removed)
>  		    S_ISREG(newmode) && S_ISREG(oldmode) &&
>  		    ((newmode ^ oldmode) == 0111))
>  			newmode = oldmode;
> +		else if (!has_symlinks &&
> +		    S_ISREG(newmode) && S_ISLNK(oldmode))
> +			newmode = oldmode;
>  		diff_change(&revs->diffopt, oldmode, newmode,
>  			    ce->sha1, (changed ? null_sha1 : ce->sha1),
>  			    ce->name, NULL);

I suspect that this part becomes clearer if we rewrite it like
this:

 		changed = ce_match_stat(ce, &st, 0);
 		if (!changed && !revs->diffopt.find_copies_harder)
 			continue;
 		oldmode = ntohl(ce->ce_mode);
-
-		newmode = canon_mode(st.st_mode);
-		if (!trust_executable_bit &&
-		    S_ISREG(newmode) && S_ISREG(oldmode) &&
-		    ((newmode ^ oldmode) == 0111))
-			newmode = oldmode;
-		else if (!has_symlinks &&
-		    S_ISREG(newmode) && S_ISLNK(oldmode))
-			newmode = oldmode;
+		newmode = ntohl(ce_mode_from_stat(ce, st.st_mode));
 		diff_change(&revs->diffopt, oldmode, newmode,
 			    ce->sha1, (changed ? null_sha1 : ce->sha1),
 			    ce->name, NULL);
