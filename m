From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make Git accept absolute path names for files within the work tree
Date: Mon, 03 Dec 2007 15:03:10 -0800
Message-ID: <7vr6i3e5zl.fsf@gitster.siamese.dyndns.org>
References: <3665a1a00712021652tbdfe9d1tdc4575d225bfed36@mail.gmail.com>
	<20071203024916.GA11003@coredump.intra.peff.net>
	<200712030755.37038.robin.rosenberg@dewire.com>
	<200712032153.31322.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Anatol Pomozov <anatol.pomozov@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 00:03:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzKKB-0005py-Ki
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 00:03:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbXLCXDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 18:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbXLCXDU
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 18:03:20 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:50744 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbXLCXDT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 18:03:19 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id A513A2EF;
	Mon,  3 Dec 2007 18:03:39 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 9A3349C95F;
	Mon,  3 Dec 2007 18:03:33 -0500 (EST)
In-Reply-To: <200712032153.31322.robin.rosenberg.lists@dewire.com> (Robin
	Rosenberg's message of "Mon, 3 Dec 2007 21:53:30 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66973>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> I will not surrender to the fierce competion on this subject. Here is
> an update with hopefully correct test cases this time.

Yay, that's the spirit!

> ... Like Linus, this code does not resolve symlinks,
> but I forgot to state that it is by design.

Perhaps state it in the commit log message?

>  static const char *add_prefix(const char *prefix, const char *path)
>  {
> +	return prefix_path(prefix, prefix ? strlen(prefix) : 0, path);
>  }

Ok; prefix_path can get NULL prefix (not complaining; just a reminder in
the following discussion).

> diff --git a/setup.c b/setup.c
> index 2c7b5cb..1f0ec79 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -4,9 +4,62 @@
>  static int inside_git_dir = -1;
>  static int inside_work_tree = -1;
>  
> +static
> +const char *strip_work_tree_path(const char *prefix, int len, const char *path)

Style.  "static" not on its own line.

> +{
> +	const char *work_tree = get_git_work_tree();
> +	int n = strlen(work_tree);

Preconditions.

 * prefix could be NULL or path to the subdirectory the user's
   non-absolute path should be relative to, expressed as a relative path
   to the top of the work tree, including a trailing slash.  len is the
   length of the prefix string.

 * path was determined by the caller to be absolute.

 * It is assumed that get_git_work_tree() always gives absolute path,
   and without trailing slash.

 * Does prefix always NULL if we are at the top, and never "", I wonder.
   But lets assume that, too.

> +	if (strncmp(path, work_tree, n))
> +		return path;

If the given path is outside the work tree, return absolute as-is.
After this point we know path matches the work tree

> +	if (!prefix && !path[n])
> +		return path + n;

If we are at the top of the work tree and path names the top of the work
tree, then we return "".

> +	if (!prefix) {
> +		if (path[n] == '/')
> +			return path + n + 1;

If we are at the top of the work tree and the path names the top of the
work tree followed by a slash and then something, that is a path inside
the work tree.  Return relative to the top of the work tree.

> +		else
> +			if (path[n])
> +				return path;
> +			else
> +				return path + n;
> +	}

Style.  "else if" would give you shallower indentation.  We know path[n]
was not slash, and if it is not NUL then path is not inside the work
tree but is a neighbour (e.g. worktree is /a/b and path is /a/bc).
Return absolute.  Otherwise the path names the top of the work tree
itself so we return "".

Now at this point, we know we are in a subdirectory, because the above
if (!prefix) part always return.  So the test for prefix here is
unnecessary.

> +	if (prefix && !path[n])
> +		return path;

If we are in a subdirectory, and path names the top of the work tree, we
return it as-is (i.e. absolute).  This feels a bit inconsistent with the
part that follows, which tries to make things relative by using "../",
doesn't it?

> +	if (strncmp(path + n + 1, prefix, len - 1)) {

For !prefix case we have determined path is not merely a neighbour, but
we haven't checked that in this codepath.  If the parameters were like
this:

	path      = /axbc/e
        work_tree = /a
	n         = 2
        prefix    =    bc/
	len       = 3

this check says "fine, path is under prefix and we won't add ../
uplevels".  You need to have

	if (path[n] != '/')
        	return path;

before this strncmp() for it to work, don't you?

In addition, by comparing (len - 1) excluding the trailing slash of
prefix, I think you would let

	path      = /a/bcye

slip through as well.  That is inside the work_tree but outside of your
prefix.

> +		fprintf(stderr,"prefix mismatch\n");

Stray debugging fprintf.

> +		char *np;
> +		int i;
> +		int d=0;

Style "d = 0" (and "decl after statement").

> +		for (i = 0; i < len; ++i)

Style.  Distracts the reader by forcing him to wonder needlessly if
there is a particular reason for pre-increment of i instead of the usual
post-increment.

> +			if (prefix[i] == '/')
> +				d++;
> +		np = xmalloc(strlen(path + n) + d * 3 + 1);

At this point (assuming that the above if (strncmp()) rejected the path
outside the prefix correctly), we know that we would need to go d levels
up to reach the top of the work tree.

> +		for (i=0; i < d * 3; i += 3)

Style. "i = 0".

> +			strcpy(np + i, "../");
> +		strcpy(np + i, path + n + 1);

As path+n+1 is relative to the work tree, this will make it relative,
which is good.

> +		path = np;
> +		return np;
> +	}

Assuming the if (strncmp()) above correctly handled the path outside
prefix, we are dealing with the path that is inside prefix at this
point.  (len+n) is the length of the prefix directory expressed as an
absolute path.

> +	if (path[len + n] == '/')
> +		return path + len + n + 1;

So strip the absolute prefix would make the result relative to the
prefix directory.  Nice.

> +	else
> +		if (path[len + n])
> +			return path;

The same comment on "else if" applies.  path[len+n] was not slash so
path was not inside the prefix after all.  Oops?  The "if outside
prefix we uplevel with ../" logic above should have handled this case
and we should not be here.

> +		else
> +			return path + len + n;
> +}

path[len+n] was NUL, which means taht the user named the prefix
directory, and we return "".

Isn't this _overly_ complicated?  I think what this function wants to do
is:

 * See if path is outside the work tree, and return absolute if so.

 * Come up with the absolute path for the prefix (if NULL then that is
   the same as work tree) directory, without a trailing slash, and call
   it X.

 * Is path the same as the X?  If so, "" is what you want.

 * Is path a prefix of the "X/"?  If so strip "X/" and return.

 * Find the longuest common leading directory of path and "X/" and call
   it "C/".  Note that this is guaranteed to be inside work tree because
   we rejected paths outside work tree upfront.

 * Count slashes between "C/" and "X/" and come up with necessary
   uplevel "../".  Strip "C/" from path and prepend the uplevel.
