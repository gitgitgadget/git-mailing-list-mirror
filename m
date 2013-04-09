From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] add: refuse to add paths beyond repository boundaries
Date: Tue, 9 Apr 2013 12:50:32 -0400
Message-ID: <20130409165032.GB21972@sigill.intra.peff.net>
References: <CALkWK0m_82ThYKxcr=YHGBnOaHr9yBpYFHxx2KrnQkWD_zjp1A@mail.gmail.com>
 <1365499297-8667-1-git-send-email-artagnon@gmail.com>
 <1365499297-8667-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 18:50:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPbl1-0001Ch-Po
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 18:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880Ab3DIQul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 12:50:41 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36406 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934679Ab3DIQui (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 12:50:38 -0400
Received: (qmail 23768 invoked by uid 107); 9 Apr 2013 16:52:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 09 Apr 2013 12:52:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Apr 2013 12:50:32 -0400
Content-Disposition: inline
In-Reply-To: <1365499297-8667-3-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220585>

On Tue, Apr 09, 2013 at 02:51:37PM +0530, Ramkumar Ramachandra wrote:

> Currently, git add has the logic for refusing to add gitlinks using
> treat_path(), which in turn calls check_path_for_gitlink().  However,
> this only checks for an in-index submodule (or gitlink cache_entry).
> A path inside a git repository in the worktree still adds fine, and
> this is a bug.  The logic for denying it is very similar to denying
> adding paths beyond symbolic links: die_if_path_beyond_symlink().
> Follow its example and write a die_if_path_beyond_gitrepo() to fix
> this bug.

Thanks for working on this.

I think the direction is a good one. It does disallow Jakub's crazy
shared-directory setup. I am not too sad to see that disallowed, at
least by default, because there are so many ways to screw yourself while
using it if you are not careful (I tried something similar once, and
gave up because I kept running into problematic cases).

I am not opposed to having an escape hatch to operate in that mode, but
it should be triggered explicitly so it doesn't catch users unaware.

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  builtin/add.c  |  5 +++--
>  cache.h        |  2 ++
>  pathspec.c     | 12 ++++++++++++
>  pathspec.h     |  1 +
>  symlinks.c     | 43 +++++++++++++++++++++++++++++++++++++------
>  t/t3700-add.sh |  2 +-
>  6 files changed, 56 insertions(+), 9 deletions(-)

I am not super-familiar with this part of the code, but having worked on
it once two years ago for the same problem, your solution looks like the
right thing.

> @@ -142,8 +143,22 @@ static int lstat_cache_matchlen(struct cache_def *cache,
>  			if (errno == ENOENT)
>  				*ret_flags |= FL_NOENT;
>  		} else if (S_ISDIR(st.st_mode)) {
> -			last_slash_dir = last_slash;
> -			continue;
> +			/* Check to see if the directory contains a
> +			   git repository */
> +			struct stat st;
> +			struct strbuf dotgitentry = STRBUF_INIT;
> +			strbuf_addf(&dotgitentry, "%s/.git", cache->path);

Can we use mkpath here to avoid an allocation? Or even better,
cache->path is PATH_MAX+1 bytes, and we munge it earlier in the
function. Can we just check the length and stick "/.git" on the end?

> +			if (lstat(dotgitentry.buf, &st) < 0) {
> +				if (errno == ENOENT) {
> +					strbuf_release(&dotgitentry);
> +					last_slash_dir = last_slash;
> +					continue;
> +				}
> +				*ret_flags = FL_LSTATERR;
> +			}
> +			else
> +				*ret_flags = FL_GITREPO;
> +			strbuf_release(&dotgitentry);

In my original patch long ago, Junio asked if we should be checking
is_git_directory() when we find a ".git" entry, to make sure it is not a
false positive. I don't have a strong opinion either way, but if we do
that, we would possibly want to update treat_path to do the same thing
for consistency.

-Peff
