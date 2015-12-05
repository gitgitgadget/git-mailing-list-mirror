From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] externalize is_git_repository
Date: Sat, 5 Dec 2015 01:58:39 -0500
Message-ID: <20151205065839.GA21639@sigill.intra.peff.net>
References: <1449252917-3877-1-git-send-email-a.krey@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Sat Dec 05 07:58:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a56nu-0007BA-I0
	for gcvg-git-2@plane.gmane.org; Sat, 05 Dec 2015 07:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807AbbLEG6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2015 01:58:42 -0500
Received: from cloud.peff.net ([50.56.180.127]:37684 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751575AbbLEG6m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2015 01:58:42 -0500
Received: (qmail 8750 invoked by uid 102); 5 Dec 2015 06:58:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Dec 2015 00:58:42 -0600
Received: (qmail 941 invoked by uid 107); 5 Dec 2015 06:58:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Dec 2015 01:58:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Dec 2015 01:58:39 -0500
Content-Disposition: inline
In-Reply-To: <1449252917-3877-1-git-send-email-a.krey@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282028>

On Fri, Dec 04, 2015 at 07:15:15PM +0100, Andreas Krey wrote:

> diff --git a/cache.h b/cache.h
> index 736abc0..6626e97 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -439,6 +439,7 @@ extern int is_inside_work_tree(void);
>  extern const char *get_git_dir(void);
>  extern const char *get_git_common_dir(void);
>  extern int is_git_directory(const char *path);
> +extern int is_git_repository(struct strbuf *sb);

I wonder if we need to give this a better name if it is going to be
globally available. Seeing these two functions defined next to each
other, I have to wonder: what is the difference?

The first one ("is_git_directory") is about testing whether a particular
path is a ".git" directory. The second is about looking for a ".git"
inside the path, and seeing if _that_ points to a valid repository.
That's one way for it to be a repository, but not all (a repository
could itself simply be a bare repo that passes is_git_directory(), after
all).

So maybe a better name for the new function would be
"directory_contains_dotgit_repo" or something?

>  /*
> + * Return 1 if the given path is the root of a git repository or
> + * submodule else 0. Will not return 1 for bare repositories with the
> + * exception of creating a bare repository in "foo/.git" and calling
> + * is_git_repository("foo").
> + */
> +int is_git_repository(struct strbuf *path)

I think it's more useful to put a descriptive comment like this in the
header, where the interface is defined (I know you are just cutting and
pasting this, but in the prior version the declaration and the
definition were in the same place).

> +{
> +	int ret = 0;
> +	int gitfile_error;
> +	size_t orig_path_len = path->len;
> +	assert(orig_path_len != 0);
> +	strbuf_complete(path, '/');
> +	strbuf_addstr(path, ".git");
> +	if (read_gitfile_gently(path->buf, &gitfile_error) || is_git_directory(path->buf))
> +		ret = 1;
> +	if (gitfile_error == READ_GITFILE_ERR_OPEN_FAILED ||
> +	    gitfile_error == READ_GITFILE_ERR_READ_FAILED)
> +		ret = 1;  /* This could be a real .git file, take the
> +			   * safe option and avoid cleaning */

This comment is somewhat stale; we don't know we're cleaning.

Is it always going to be appropriate to err on the side of "yes, this
could be a repository?". My hunch is "yes", because we generally
consider sub-repos to be precious, so that's the safer thing to do.

-Peff
