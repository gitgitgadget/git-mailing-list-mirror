From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-apply: apply submodule changes
Date: Sun, 12 Aug 2007 11:16:09 -0700
Message-ID: <7vwsw0ipp2.fsf@assigned-by-dhcp.cox.net>
References: <20070810093049.GA868MdfPADPa@greensroom.kotnet.org>
	<20070812142340.GA10399MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>,
	Johannes.Schindelin@gmx.de
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sun Aug 12 20:16:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKHz5-0002IY-RE
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 20:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641AbXHLSQN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 14:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754945AbXHLSQM
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 14:16:12 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:35761 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753578AbXHLSQL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 14:16:11 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070812181610.ITER24055.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sun, 12 Aug 2007 14:16:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id b6G91X0121kojtg0000000; Sun, 12 Aug 2007 14:16:10 -0400
In-Reply-To: <20070812142340.GA10399MdfPADPa@greensroom.kotnet.org> (Sven
	Verdoolaege's message of "Sun, 12 Aug 2007 16:23:40 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55695>

Sven Verdoolaege <skimo@kotnet.org> writes:

> diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
> index f03f661..804fdc3 100644
> --- a/Documentation/git-apply.txt
> +++ b/Documentation/git-apply.txt
> @@ -171,6 +171,20 @@ apply.whitespace::
>  	When no `--whitespace` flag is given from the command
>  	line, this configuration item is used as the default.
>  
> +Submodules
> +----------
> +If the patch contains any changes to submodules then gitlink:git-apply[1]
> +behaves as follows.

perhaps "as follows wrt the submodules"...

> diff --git a/builtin-apply.c b/builtin-apply.c
> index da27075..eef596b 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -1984,6 +1984,40 @@ static int apply_fragments(struct buffer_desc *desc, struct patch *patch)
>  	return 0;
>  }
>  
> +static int read_file_or_gitlink(struct cache_entry *ce, char **buf_p,
> +				unsigned long *size_p)
> +{
> +	if (!ce)
> +		return 0;
> +
> +	if (S_ISGITLINK(ntohl(ce->ce_mode))) {
> +		*buf_p = xmalloc(100);
> +		*size_p = snprintf(*buf_p, 100,
> +			"Subproject commit %s\n", sha1_to_hex(ce->sha1));
> +	} else {
> +		enum object_type type;
> +		*buf_p = read_sha1_file(ce->sha1, &type, size_p);
> +		if (!*buf_p)
> +			return -1;
> +	}
> +
> +	return 0;
> +}

Ok, read_file_or_gitlink() expects ce taken from the current
index and fills *buf_p with the preimage to be patched from it.

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

Hmmmm...  see below.

>  static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *ce)
>  {
>  	char *buf;
> @@ -1994,20 +2028,17 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
>  	alloc = 0;
>  	buf = NULL;
>  	if (cached) {
> +		if (read_file_or_gitlink(ce, &buf, &size))
> +			return error("read of %s failed", patch->old_name);
> +		alloc = size;
>  	}

This part is consistent with the read_file_or_gitlink()
semantics above...

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

read_old_data() gets the lstat information from the current
filesystem data at old_name, and gives the preimage to be
patched, and naturally it bombs out if it is a directory, but
when we are applying a change to gitlink, the patch expects
old_name to be a directory.

So you introduced read_gitlink_or_skip() to work it around.  But
this makes me wonder...

 - what does ce have to do in this codepath?  read_old_data()
   does not care about what is in the index (in fact, in the
   index the entry can be a symlink when the path on the
   filesystem is a regular file, and it reads from the regular
   file as asked--it does not even look at ce by design).  
   if you have a regular file there in the current version, ce
   would say it is a regular file blob and you would not want
   read_gitlink_or_skip() to say "Subproject commit xyz...".

 - what is alloc at this point?  it is based on the size of
   directory st->st_size.

I think dropping fragments for a patch that tries to modify a
gitlink here is fine, but that can be done regardless of what ce
is.

The type-mismatch case to attempt to apply gitlink patch to a
regular blob is covered much earlier in check_patch().  It
complains if st_mode does not match patch->old_mode; I think you
need to adjust it a bit to:

 - allow gitlink patch to a path that currently has nothing (no
   submodule checked out) or a directory that has ".git/"
   (i.e. submodule checked out).

 - reject gitlink patch otherwise.
