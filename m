From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] git-apply: apply submodule changes
Date: Mon, 13 Aug 2007 13:26:04 -0700
Message-ID: <7vmywvfag3.fsf@assigned-by-dhcp.cox.net>
References: <20070810093049.GA868MdfPADPa@greensroom.kotnet.org>
	<20070812142340.GA10399MdfPADPa@greensroom.kotnet.org>
	<7vwsw0ipp2.fsf@assigned-by-dhcp.cox.net>
	<20070812185006.GG999MdfPADPa@greensroom.kotnet.org>
	<7vr6m8imj6.fsf@assigned-by-dhcp.cox.net>
	<20070813093740.GA4684@liacs.nl>
	<20070813171349.GL999MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>,
	Johannes.Schindelin@gmx.de
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Mon Aug 13 22:26:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKgUS-0002W0-PX
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 22:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934681AbXHMU0J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 16:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933046AbXHMU0I
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 16:26:08 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:47058 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731AbXHMU0F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 16:26:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070813202604.ZSRA5405.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 13 Aug 2007 16:26:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id bYS31X00U1kojtg0000000; Mon, 13 Aug 2007 16:26:04 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55781>

Sven Verdoolaege <skimo@kotnet.org> writes:

> +static int read_gitlink_or_skip(struct patch *patch, struct cache_entry *ce,
> +				char *buf, unsigned long alloc)
> +{
> +	if (ce)
> +		return snprintf(buf, alloc,
> +				"Subproject commit %s\n", sha1_to_hex(ce->sha1));
> +
> +	/* We can't apply the submodule change without an index, so just
> +	 * skip the patch itself and only create/remove directory.
> +	 */
> +	patch->fragments = NULL;
> +	return 0;
> +}
> @@ -1994,20 +2029,17 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
>  	alloc = 0;
>  	buf = NULL;
>  	if (cached) {
> +		if (read_file_or_gitlink(ce, &buf, &size))
> +			return error("read of %s failed", patch->old_name);
> +		alloc = size;
> ...
>  	else if (patch->old_name) {
>  		size = xsize_t(st->st_size);
>  		alloc = size + 8192;
>  		buf = xmalloc(alloc);
> -		if (read_old_data(st, patch->old_name, &buf, &alloc, &size))
> +		if (S_ISGITLINK(patch->old_mode))
> +			size = read_gitlink_or_skip(patch, ce, buf, alloc);
> +		else if (read_old_data(st, patch->old_name, &buf, &alloc, &size))
>  			return error("read of %s failed", patch->old_name);
>  	}

I think the logic here sounds sane.  The read_file_or_gitlink()
abstraction in the first if() part was so nice that I was hoping
we could do something similar in this "else if" part, without
hiding the assignment to patch->fragments as an obscure side
effect of calling read_gitlink_or_skip().  That assignment is a
gitlink specific hack so it might be easier to read if this part
is written like:

	} else if (patch->old_name && S_ISGITLINK(patch->old_mode)) {
		if (ce)
                	size = snprintf(....)
		else {
                	/* we cannot apply gitlink mods without index */
			size = 0;
			patch->fragments = NULL;
		}
        } else if (patch->old_name) {
		... original code here ...

> @@ -2055,6 +2087,20 @@ static int check_to_create_blob(const char *new_name, int ok_if_exists)
>  	return 0;
>  }
>  
> +/* Check that the directory corresponding to a gitlink is either
> + * empty or a git repo.
> + */
> +static int verify_gitlink_clean(const char *path)
> +{
> +	unsigned char sha1[20];
> +
> +	if (!rmdir(path)) {
> +		mkdir(path, 0777);
> +		return 0;
> +	}
> +	return resolve_gitlink_ref(path, "HEAD", sha1);
> +}

Is it the responsibility of the caller of this function to make
sure that path is either absent or is a directory?  Can there be
a regular file at path, which would cause rmdir to fail?  I do
not think it is sensible to call resolve_gitlink_ref() on such a
path, so let's say the caller will make sure that path is
gitlink in the current (i.e. in index) tree before calling this
function.

>  static int check_patch(struct patch *patch, struct patch *prev_patch)
>  {
>  	struct stat st;
> @@ -2096,8 +2142,15 @@ static int check_patch(struct patch *patch, struct patch *prev_patch)
>  				    lstat(old_name, &st))
>  					return -1;
>  			}
> -			if (!cached)
> +			if (!cached) {
>  				changed = ce_match_stat(ce, &st, 1);

Here, ce_match_stat() sees if the index and work tree match.
You could have a regular file there but you haven't checked
(which is not a crime, yet).

> +				if (S_ISGITLINK(patch->old_mode)) {

I think the rmdir/mkdir sequence should be done only when ce is
a gitlink.  Perhaps it is just the matter of:

                                if (S_ISGITLINK(patch->old_mode) &&
                                    S_ISGITLINK(ntohl(ce->ce_mode))) {
                                        ...
                                }

> +					changed &= TYPE_CHANGED;
> +					if (!changed &&
> +					    verify_gitlink_clean(patch->old_name))
> +						changed |= TYPE_CHANGED;
> +				}
> +			}

This part is very confusing.  You discard all changes other than
TYPE_CHANGED, and give TYPE_CHANGED and nothing else if gitlink
is not clean.  I suspect "changed &= ~TYPE_CHANGED" might be
what you meant, but I do not know what you are trying to do
here.
