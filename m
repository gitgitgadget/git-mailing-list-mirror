From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] checkout to notice forks (Re: Minor annoyance with git
 push)
Date: Sat, 16 Feb 2008 22:31:26 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802162202310.5496@iabervon.org>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com> <20080209030046.GA10470@coredump.intra.peff.net> <7vtzkihkx5.fsf@gitster.siamese.dyndns.org> <46a038f90802090350rc4780d1ted60c03b9abf1fc0@mail.gmail.com> <7vwspd5z1d.fsf@gitster.siamese.dyndns.org>
 <7vfxvs75kp.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Jeff King <peff@peff.net>, Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 04:32:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQaG0-0001hO-80
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 04:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755461AbYBQDb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 22:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbYBQDb2
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 22:31:28 -0500
Received: from iabervon.org ([66.92.72.58]:41939 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755459AbYBQDb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 22:31:27 -0500
Received: (qmail 9371 invoked by uid 1000); 17 Feb 2008 03:31:26 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Feb 2008 03:31:26 -0000
In-Reply-To: <7vfxvs75kp.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74090>

On Sat, 16 Feb 2008, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Perhaps making "git-checkout" to notice this and offer (or
> > suggest) fast-forwarding at that point may be safer and make
> > more sense.  You cannot grow your local branch unless you check
> > them out, and your remote tracking will keep growing without the
> > auto-ff you are suggesting, so it is not like people will lose
> > anchoring point to compare between branches if we do not
> > auto-ff.
> 
> So I did this.
> 
> When you are switching to a branch that is marked to merge from
> somewhere else, e.g. when you have:
> 
>     [branch "next"]
>             remote = upstream
>             merge = refs/heads/next
>     [remote "upstream"]
>             url = ...
>             fetch = refs/heads/*:refs/remotes/linus/*
> 
> and you say "git checkout next", then after we switch the branch
> we check the upstream (in this case, refs/remotes/linus/next)
> and our branch, and:
> 
>     (1) if they match, nothing happens;
> 
>     (2) if you are ahead (i.e. the upstream is a strict ancestor
>         of you), one line message tells you so;
> 
>     (3) otherwise, you are either behind or you and the upstream
>         have forked.  One line message will tell you which and
>         then you will see a "log --pretty=oneline --left-right".

I like this idea a lot. I'd actually also like it for commit, although (1) 
and (3a) obviously don't happen there. It would help to combat my tendency 
to forget to push when I mean to.

Note that, in addition to "should I merge before starting to work now", 
this also answers "if I turn off this computer, what can't I get at".

> We could enhance this with an option that tells the command to
> check if there is no local change, and automatically fast
> forward when you are truly behind.  But I ripped out that change
> because I was unsure what the right way should be to allow users
> to control it (issues include that checkout should not become
> automatically interactive).

I suppose you could use a config option to enable it per-branch.

It would be really clever to make it happen if you do:

$ git checkout next
(fast-forward info)
$ git checkout

But that's probably a bit too clever.

> diff --git a/builtin-checkout.c b/builtin-checkout.c
> index 59a0ef4..9370ba0 100644
> --- a/builtin-checkout.c
> +++ b/builtin-checkout.c
> @@ -12,6 +12,7 @@
>  #include "branch.h"
>  #include "diff.h"
>  #include "revision.h"
> +#include "remote.h"
>  
>  static const char * const checkout_usage[] = {
>  	"git checkout [options] <branch>",
> @@ -290,6 +291,139 @@ static int merge_working_tree(struct checkout_opts *opts,
>  	return 0;
>  }
>  
> +/*
> + * We really should allow cb_data... Yuck
> + */
> +static const char *branch_name;
> +static int branch_name_len;
> +static char *found_remote;
> +static char *found_merge;
> +static int read_branch_config(const char *var, const char *value)
> +{

...

I think you want branch_get(), which handles all the config file stuff up 
to approximately here:

> +	remote = remote_get(found_remote);
> +	memset(&spec, 0, sizeof(spec));
> +	spec.src = found_merge;
> +	if (remote_find_tracking(remote, &spec))
> +		goto cleanup;
> +	*base = spec.dst;
> +	return 1;
> +}
> +
> +static void adjust_to_tracking(struct branch_info *new, struct checkout_opts *opts)
> +{
> +	/*
> +	 * We have switched to a new branch; is it building on
> +	 * top of another branch, and if so does that other branch
> +	 * have changes we do not have yet?
> +	 */
> +	char *base;
> +	unsigned char sha1[20];
> +	struct commit *ours, *theirs;
> +	const char *msgfmt;
> +	char symmetric[84];
> +	int show_log;
> +
> +	if (!resolve_ref(new->path, sha1, 1, NULL))
> +		return;
> +	ours = lookup_commit(sha1);
> +
> +	if (!find_build_base(new->path, &base))
> +		return;
> +
> +	sprintf(symmetric, "%s", sha1_to_hex(sha1));
> +
> +	/*
> +	 * Ok, it is tracking base; is it ahead of us?
> +	 */
> +	if (!resolve_ref(base, sha1, 1, NULL))
> +		return;
> +	theirs = lookup_commit(sha1);
> +
> +	sprintf(symmetric + 40, "...%s", sha1_to_hex(sha1));
> +
> +	if (!hashcmp(sha1, ours->object.sha1))
> +		return; /* we are the same */
> +
> +	show_log = 1;
> +	if (in_merge_bases(theirs, &ours, 1)) {
> +		msgfmt = "You are ahead of the tracked branch '%s'\n";
> +		show_log = 0;
> +	}
> +	else if (in_merge_bases(ours, &theirs, 1))
> +		msgfmt = "Your branch can be fast-forwarded to the tracked branch '%s'\n";
> +	else
> +		msgfmt = "Both your branch and the tracked branch '%s' have own changes, you would eventually need to merge\n";
> +
> +	if (!prefixcmp(base, "refs/remotes/"))
> +		base += strlen("refs/remotes/");
> +	fprintf(stderr, msgfmt, base);
> +
> +	if (show_log) {
> +		const char *args[32];
> +		int ac;
> +
> +		ac = 0;
> +		args[ac++] = "log";
> +		args[ac++] = "--pretty=oneline";
> +		args[ac++] = "--abbrev-commit";
> +		args[ac++] = "--left-right";
> +		args[ac++] = "--boundary";
> +		args[ac++] = symmetric;
> +		args[ac++] = "--";
> +		args[ac] = NULL;
> +
> +		run_command_v_opt(args, RUN_GIT_CMD);

We really should be able to do this in-process, although I'm not sure if 
we really can. I don't think I've marked up the history in 
builtin-checkout for anything else yet, anyway.

	-Daniel
*This .sig left intentionally blank*
