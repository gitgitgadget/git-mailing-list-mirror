From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] allow user aliases for the --author parameter
Date: Thu, 21 Aug 2008 16:02:55 -0400
Message-ID: <20080821200255.GB27705@coredump.intra.peff.net>
References: <g8jbvd$18k$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Thu Aug 21 22:04:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWGOD-0006B1-1l
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 22:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753687AbYHUUDE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 16:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753821AbYHUUDD
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 16:03:03 -0400
Received: from peff.net ([208.65.91.99]:1998 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752822AbYHUUDA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 16:03:00 -0400
Received: (qmail 9111 invoked by uid 111); 21 Aug 2008 20:02:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 21 Aug 2008 16:02:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Aug 2008 16:02:55 -0400
Content-Disposition: inline
In-Reply-To: <g8jbvd$18k$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93193>

On Thu, Aug 21, 2008 at 11:19:41AM +0200, Michael J Gruber wrote:

> This allows the use of author abbreviations when specifying commit
> authors via the --author option to git commit. "--author=$key" is
> resolved by looking up "user.$key.name" and "user.$key.email" in the
> config.

This seems like a reasonable feature to me, though two high-level
questions:

  - Is it worth supporting external alias sources, as Alex mentioned? I
    think that would make more sense for many people. Even if you are
    not personally interested in writing it, it would be nice to keep it
    in mind as a future expansion when doing this work. For example,
    maybe it makes more sense for the config to point to a (type, file)
    pair instead of placing directly into the config. Or maybe this
    should just live in conjunction with that feature, if somebody cares
    to implement it.

  - Is user.$key the right namespace? It precludes a few particular
    aliases, and it might clash with future user.* config. Perhaps
    user.alias.* would be a better place (or, as above, just referencing
    an external file).

  - git-send-email already looks at some alias files. Maybe this is an
    opportunity to refactor and centralize (although perhaps it is not
    worth the effort, because of the different implementation
    languages).

> ---
> In an ideal word, all my collaborators would exchange changes as git 
> patches (or even via pull/push). In the real world, they send new
> versions which I integrate (after dealing with their whitespace and encoding changes...).
> Therefore, being able to say 
> "git commit --author=mickey"
> and having git translate "mickey" into "Mickey Mouse <mickey@ducktown.us>"
> is a real time saver. The patch accomplishes this by reading config keys "user.mickey.name" and "user.mickey.email" when encountering an 
> --author argument without "<>".

This justification should probably go into the commit message, not the
cover letter. When you are writing it, think about the reader who will
bisect or blame to your commit a year from now. Will they want to see
just _what_ you did, or _why_ you did it?

> If there's interest in this patch I'll follow up with a documentation patch.

I think Miklos already yelled at you for this. The message he referenced
doesn't quite apply, because you did include some discussion of the
"why". The reason I think Junio (and other reviewers) find the "I'll
document this if it is accepted" so frustrating is that it puts them in
an awkward position.

When reviewing, you are trying to say "is this patch OK?". And clearly
it isn't, because it lacks documentation. Now Junio could queue your
patch and wait for the documentation, but sometimes the followup doc
patches aren't as easily forthcoming, and then he has to deal with it
later.

Furthermore, it is sort of a good faith effort. It shows that you put
the work into cleaning up the patch for presenting to the community,
which encourages the community to take a look. Saying "this is half of
the work, and I will do the other half if you like this" makes reviewers
wonder how cleaned up and ready the patch is.

All of that being said, I think in this instance it is less about the
patch and more in the words you picked. If you said "I am thinking about
this feature, and here is how I think the interface should work, and
here is the patch I have so far. I don't want to document the interface
until it is settled, so please comment on that and I will work up a
final patch" then that would have gone over very well. But as it
happens, you chose the magic pet peeve words. ;)

> The "--committer" argument to git commit is not treated because I don't
> consider it worthwhile.

If you are introducing a new source of alias mappings, it would make
sense to me to support it everywhere for the sake of consistency. That
means --committer should look at it, too (and should only be a few
lines, I would think), and probably git-send-email.

> P.S.: That's my first patch here. Yes, I've read Doc/SubmittingPatches.
> So, if something's wrong, please be gentle but not overly so ;)

I hope this is the right amount of gentleness. ;)

> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -53,6 +53,12 @@ static char *author_name, *author_email, *author_date;
>  static int all, edit_flag, also, interactive, only, amend, signoff;
>  static int quiet, verbose, no_verify, allow_empty;
>  static char *untracked_files_arg;
> +struct user {
> +	char *name, *full_name, *email;
> +};

Others may disagree, but style-wise I think we usually put each struct
member on its own line.

>  	if (force_author) {
>  		const char *lb = strstr(force_author, " <");
>  		const char *rb = strchr(force_author, '>');
>  
> +		if (!lb && !rb) {
> +			for (i=0; i < users_nr; i++) {

Style: "i = 0"

> +				if (!strcmp(force_author, users[i]->name)) {
> +					author_name = users[i]->full_name;
> +					author_email = users[i]->email;
> +					return;
> +				}


I haven't traced all of the uses of author_name and author_email, but
all of the other codepaths seem to allocate a new string, whereas this
uses the existing strings. Is this going to accidentally free() from the
users list, or are we just leaking those other strings now?

> +	ALLOC_GROW(users, users_nr + 1, users_alloc);

Yay, a first-time submitter bothered to use ALLOC_GROW! :)

> +	ret = xcalloc(1, sizeof(struct user));
> +	users[users_nr++] = ret;
> +	if (len)
> +		ret->name = xstrndup(name, len);
> +	else
> +		ret->name = xstrdup(name);
> +
> +	return ret;
> +}

This is the not the most git-ish way of using the config[1]. Usually we
avoid reading big lists into memory, but rather just call git_config
with the appropriate callback when we find we need to look up the user
alias.

[1] However, I don't necessarily agree with this. We can end up parsing
the config (which may be split across 3 files) several times per
command, so it is probably better to just parse and store it in one go.
So I will let Junio comment on the preferred method.

-Peff
