From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add `git diff2`, a GNU diff workalike
Date: Fri, 16 Feb 2007 00:06:25 -0800
Message-ID: <7v1wkq8r26.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702160500280.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 16 09:07:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHy7W-00012e-Ne
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 09:07:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966184AbXBPIG1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 03:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966176AbXBPIG1
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 03:06:27 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:46893 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966184AbXBPIG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 03:06:26 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070216080627.TKTC21177.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Fri, 16 Feb 2007 03:06:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Q86R1W00m1kojtg0000000; Fri, 16 Feb 2007 03:06:26 -0500
In-Reply-To: <Pine.LNX.4.63.0702160500280.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 16 Feb 2007 05:01:19 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39901>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Git does have a wonderful diff engine. For example, colored diffs
> really shine, and there are other useful options like --check,
> --patch-with-stat, etc. I always dreamt of using this diff engine
> also outside of a git repository.
>
> With this commit, you can say
>
> 	git diff2 file1 file2

Why diff2?  I would have expected this to be a new low-level
sibling of diff-files and diff-index, which in turn hook into
the overall "diff" driver.

> +static int queue_diff(struct diff_options *o,
> +		const char *name1, const char *name2)
> +{
> +	struct stat st;
> +	int mode1 = 0, mode2 = 0;
> +
> +	if (name1) {
> +		if (stat(name1, &st))
> +			return error("Could not access '%s'", name1);
> +		mode1 = st.st_mode;
> +	}
> +	if (name2) {
> +		if (stat(name2, &st))
> +			return error("Could not access '%s'", name1);
> +		mode2 = st.st_mode;
> +	}

I am still debating myself if these should be lstat(2) instead
of stat(2).  The former is more consistent with what git does.

> +	if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2))
> +		return error("file/directory conflict: %s, %s", name1, name2);

If a/frotz is a file and b/frotz/nitfol is there, I do not think
we show an error; we say "a/frotz" was removed (see notes below,
though).

> +	if (S_ISDIR(mode1) || S_ISDIR(mode2)) {
> +		char buffer1[PATH_MAX], buffer2[PATH_MAX];
> +		struct path_list p1 = {NULL, 0, 0, 1}, p2 = {NULL, 0, 0, 1};
> +		int len1 = 0, len2 = 0, i1, i2, ret = 0;
> +
> +		if (name1 && read_directory(name1, &p1))
> +			return -1;
> +		if (name2 && read_directory(name2, &p2)) {
> +			path_list_clear(&p1, 0);
> +			return -1;
> +		}

I suspect your favorite path-list might not be optimal for this
kind of codeflow; wouldn't reading everything in an expanding
array and sorting them with a single qsort() after reading one
directory more efficient?

> +		for (i1 = i2 = 0; !ret && (i1 < p1.nr || i2 < p2.nr); ) {
> +			const char *n1, *n2;
> +			int comp;
> +
> +			if (i1 == p1.nr)
> +				comp = 1;
> +			else if (i2 == p2.nr)
> +				comp = -1;
> +			else
> +				comp = strcmp(p1.items[i1].path,
> +					p2.items[i2].path);

I think you would want to be consistent with how git sorts paths
here.  In particular, you can always pretend that a path that is
a directory has '/' at the end.  Which (as a side effect) means
that you do not have to worry about a/frotz and b/frotz/nitfol,
because element from p1 will be "frotz" and the one from p2 will
be "frotz/" in this case.  You will never feed queue_diff() with
the same name with d/f conflicts that way.

> +int cmd_diff2(int argc, char **argv, char **envp)
> +{

The rest looks quite straightforward use of diffcore API, done
very cleanly.

> diff --git a/diff.c b/diff.c
> index c2d9abe..be73621 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2443,7 +2443,8 @@ static void diff_resolve_rename_copy(void)
>  				p->status = DIFF_STATUS_RENAMED;
>  		}
>  		else if (hashcmp(p->one->sha1, p->two->sha1) ||
> -			 p->one->mode != p->two->mode)
> +			 p->one->mode != p->two->mode ||
> +			 is_null_sha1(p->one->sha1))
>  			p->status = DIFF_STATUS_MODIFIED;

I didn't look, but you might also need to teach diffcore-rename
that two objects both with null object names are not equal.
