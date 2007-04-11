From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow git-update-index work on subprojects
Date: Tue, 10 Apr 2007 19:55:51 -0700
Message-ID: <7vveg3r554.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704092133550.6730@woody.linux-foundation.org>
	<81b0412b0704100639y331864f9ne0306aa4bf8de663@mail.gmail.com>
	<20070410231900.GA4243@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 09:47:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbT00-0001YC-6V
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 04:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966101AbXDKCzx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 22:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161135AbXDKCzx
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 22:55:53 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:45958 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966101AbXDKCzw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 22:55:52 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070411025552.RTJH1268.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Apr 2007 22:55:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id levr1W00Z1kojtg0000000; Tue, 10 Apr 2007 22:55:52 -0400
In-Reply-To: <20070410231900.GA4243@steel.home> (Alex Riesen's message of
	"Wed, 11 Apr 2007 01:19:00 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44201>

Alex Riesen <raa.lkml@gmail.com> writes:

> Also, make "git commit -a" work with modifications of subproject HEADs.
>
> ---
>
> This one works with update-index --remove (which is what git-commit -a
> uses). It is ugly. I tried to keep the "F -> D/F" behaviour of
> update-index. Still have to check if "F -> Subproject" works.
>
>  builtin-update-index.c |   45 +++++++++++++++++++++++++--------------------
>  1 files changed, 25 insertions(+), 20 deletions(-)
>
> diff --git a/builtin-update-index.c b/builtin-update-index.c
> index eba756d..d075d50 100644
> --- a/builtin-update-index.c
> +++ b/builtin-update-index.c
> @@ -62,7 +62,7 @@ static int mark_valid(const char *path)
>  
>  static int process_file(const char *path)
>  {
> -	int size, namelen, option, status;
> +	int size, namelen = -1, option, status;
>  	struct cache_entry *ce;
>  	struct stat st;
>  
> @@ -73,7 +73,7 @@ static int process_file(const char *path)
>  	 */
>  	cache_tree_invalidate_path(active_cache_tree, path);
>  
> +	if (!status && S_ISDIR(st.st_mode)) {
>  		/* When we used to have "path" and now we want to add
>  		 * "path/file", we need a way to remove "path" before
>  		 * being able to add "path/file".  However,
> @@ -82,27 +82,32 @@ static int process_file(const char *path)
>  		 * friendly, especially since we can do the opposite
>  		 * case just fine without --force-remove.
>  		 */
> +		namelen = strlen(path);
> +		int pos = cache_name_pos(path, namelen);
> +		if (0 <= pos && S_ISREG(ntohl(active_cache[pos]->ce_mode)) &&
> +		    allow_remove) {
> +			if (remove_file_from_cache(path))
> +				return error("%s: cannot remove from the index", path);
> +			else
> +				return 0;
> +		}
> +	}

If I used to have a symlink S and now the filesystem has a file
S/F which I am running "update-index --add --remove" on, what
happens?

If I have a subproject at path P, and mistakenly try to add path
P/F with "update-index --add --remove P/F", it should be
refused, shouldn't it?
