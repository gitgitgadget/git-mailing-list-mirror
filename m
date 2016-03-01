From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v7 01/33] setup: call setup_git_directory_gently before
 accessing refs
Date: Tue, 1 Mar 2016 03:35:35 -0500
Message-ID: <20160301083535.GA4952@sigill.intra.peff.net>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
 <1456793586-22082-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 09:35:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aafmR-0004tT-3R
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 09:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549AbcCAIfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 03:35:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:52261 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752540AbcCAIfi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 03:35:38 -0500
Received: (qmail 11050 invoked by uid 102); 1 Mar 2016 08:35:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 03:35:38 -0500
Received: (qmail 6099 invoked by uid 107); 1 Mar 2016 08:35:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 03:35:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Mar 2016 03:35:35 -0500
Content-Disposition: inline
In-Reply-To: <1456793586-22082-2-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288001>

On Mon, Feb 29, 2016 at 07:52:34PM -0500, David Turner wrote:

> Usually, git calls some form of setup_git_directory at startup.  But
> sometimes, it doesn't.  Usually, that's OK because it's not really
> using the repository.  But in some cases, it is using the repo.  In
> those cases, either setup_git_directory_gently must be called, or the
> repository (e.g. the refs) must not be accessed.

It's actually not just setup_git_directory(). We can also use
check_repository_format(), which is used by enter_repo() (and hence by
things like upload-pack). I think the rule really ought to be: if we
didn't have check_repository_format_gently() tell us we have a valid
repo, we should not access any repo elements (refs, objects, etc).

I started earlier today on a patch series to identify and fix these
cases independent of your series. The basic strategy was to adapt the
existing "struct startup_info" to be available everywhere, and have
relevant bits of code assert() on it, or even behave differently (e.g.,
if some library code should do different things in a repo versus not).

But I think we can probably just scrap the assert() part of that. The
assertions I put in were unsurprisingly at the entry points to the ref
code. And your series supersedes that; we can't do anything with the
refs until the ref backend is setup, and if we only do so in
check_repository_format_gently(), then it amounts to the same thing.

For the "behave differently" part, I needed it for the .mailmap case,
but you fixed it below without having to add that.

I think it's worth going through the changes here and comparing notes
with what my series would have done.

> diff --git a/builtin/grep.c b/builtin/grep.c
> index 9e3f1cf..1e36b52 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -531,6 +531,7 @@ static int grep_directory(struct grep_opt *opt, const struct pathspec *pathspec,
>  	if (exc_std)
>  		setup_standard_excludes(&dir);
>  
> +	dir.flags |= DIR_NO_GITLINKS;
>  	fill_directory(&dir, pathspec);
>  	for (i = 0; i < dir.nr; i++) {
>  		if (!dir_path_match(dir.entries[i], pathspec, 0, NULL))

This one is interesting, because the ref access in fill_directory() is
only for hitting submodule refs. In theory, I guess a command operating
in a non-repo could want to know about and do something with embedded
git repos.

And indeed, it does produce a behavior change here. With a repo like:

  mkdir non-repo && cd non-repo &&
  git init sub &&
  (cd sub && echo foo >file && git add . && git commit -m foo)

running:

  git grep --no-index foo

does not currently find sub/file (because it does not descend into what
it think is a sub-repository), but it _does_ with your patch. I'm
inclined to say that's actually a behavior improvement. "grep
--no-index" on a directory is about behaving as a recursive grep, and
should probably descend into sub-repos (it probably should also avoid
looking inside .git directories, though, and I think it still does, even
with your patch).

The fill_directory() also touches the_index, which it should not in a
non-repository. But I think that's probably OK, because we simply don't
read the index in the first place (so it behaves naturally as if the
index is empty).

> diff --git a/builtin/log.c b/builtin/log.c
> index 0d738d6..1d0e43e 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -975,7 +975,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
>  
>  	strbuf_release(&sb);
>  
> -	shortlog_init(&log);
> +	shortlog_init(&log, 0);
>  	log.wrap_lines = 1;
>  	log.wrap = 72;
>  	log.in1 = 2;

This looks right. If we are making a cover letter for format-patch, we
know we have a repo, and thus nongit is always 0.  Though I admit the
double-negating confused me for a minute. I don't know if there's a way
around it, though, because "nongit" is what comes out of
setup_git_directory().

> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> index bfc082e..ab4305b 100644
> --- a/builtin/shortlog.c
> +++ b/builtin/shortlog.c
> @@ -219,11 +219,12 @@ static int parse_wrap_args(const struct option *opt, const char *arg, int unset)
>  	return 0;
>  }
>  
> -void shortlog_init(struct shortlog *log)
> +void shortlog_init(struct shortlog *log, int nongit)
>  {
>  	memset(log, 0, sizeof(*log));
>  
> -	read_mailmap(&log->mailmap, &log->common_repo_prefix);
> +	if (!nongit)
> +		read_mailmap(&log->mailmap, &log->common_repo_prefix);

My fix for this was to teach read_mailmap to avoid looking for
HEAD:.mailmap if we are not in a repository, but to continue with the
others (.mailmap in the cwd, and the mailmap.file config variable).

Yours disables the .mailmap entirely. That makes some sense for looking
at ".mailmap" in the working tree; if we do not have a repository, we
should not look at a mailmap (though I guess you could argue the
opposite, that a .mailmap in the current directory of a non-repo is
worth looking at).  But I'd think the mailmap.file config would apply
even to shortlog invoked outside a repository.

To be perfectly honest, I cannot imagine that shortlog is invoked with
data on stdin much at all these days, let alone outside of a repository.
But I do think your patch is a potential regression there, if anybody
does do that.

> diff --git a/git.c b/git.c
> index 6cc0c07..51e0508 100644
> --- a/git.c
> +++ b/git.c
> @@ -376,7 +376,7 @@ static struct cmd_struct commands[] = {
>  	{ "am", cmd_am, RUN_SETUP | NEED_WORK_TREE },
>  	{ "annotate", cmd_annotate, RUN_SETUP },
>  	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
> -	{ "archive", cmd_archive },
> +	{ "archive", cmd_archive, RUN_SETUP_GENTLY },
>  	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
>  	{ "blame", cmd_blame, RUN_SETUP },
>  	{ "branch", cmd_branch, RUN_SETUP },

I didn't have to touch this case in my experimenting. I wonder if it's
because I resolved the "grep" case a little differently.

I taught get_ref_cache() to only assert() that we have a repository when
we are looking at the main ref-cache, not a submodule. In theory, we can
look at a submodule from inside an outer non-repo (it's not really a
submodule then, but just a plain git dir). I don't think there's
anything in git right now that says you can't do so, though I think your
refs-backend work does introduce that restriction (because it actually
requires the submodules to use the same backend).

So with that requirement, I think we do need to require a repo even to
access submodule refs. Is that what triggered this change?

I'd think you would need a matching line inside cmd_archive, too. It
should allow "--remote" without a repo, but generating a local archive
does need one.  And indeed, I see in write_archive() that we run
setup_git_repository ourselves, and die if we're not in a git repo. So
I'm puzzled about which code path accesses the refs.

> diff --git a/test-match-trees.c b/test-match-trees.c
> index 109f03e..4dad709 100644
> --- a/test-match-trees.c
> +++ b/test-match-trees.c
> @@ -6,6 +6,8 @@ int main(int ac, char **av)
>  	unsigned char hash1[20], hash2[20], shifted[20];
>  	struct tree *one, *two;
>  
> +	setup_git_directory();
> +
>  	if (get_sha1(av[1], hash1))
>  		die("cannot parse %s as an object name", av[1]);
>  	if (get_sha1(av[2], hash2))

This one is weird. The test-match-trees program is only used one time in
our test suite, and then it is only as a hack because it is an external
that does not have startup_info setup. I think that test is somewhat
bogus (and is obsoleted by my approach), and we could probably get rid
of this program entirely.

But your patch here is certainly the right thing to do if we are keeping
it.

> diff --git a/test-revision-walking.c b/test-revision-walking.c
> index 285f06b..3d03133 100644
> --- a/test-revision-walking.c
> +++ b/test-revision-walking.c
> @@ -50,6 +50,8 @@ int main(int argc, char **argv)
>  	if (argc < 2)
>  		return 1;
>  
> +	setup_git_directory();
> +
>  	if (!strcmp(argv[1], "run-twice")) {
>  		printf("1st\n");
>  		if (!run_revision_walk())

This one I solved in the same way. Yay, we agreed on one! :)

-Peff
