From: Jeff King <peff@peff.net>
Subject: Re: [RFC] checkout to notice forks (Re: Minor annoyance with git
	push)
Date: Sun, 17 Feb 2008 07:28:15 -0500
Message-ID: <20080217122815.GA26031@sigill.intra.peff.net>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com> <20080209030046.GA10470@coredump.intra.peff.net> <7vtzkihkx5.fsf@gitster.siamese.dyndns.org> <46a038f90802090350rc4780d1ted60c03b9abf1fc0@mail.gmail.com> <7vwspd5z1d.fsf@gitster.siamese.dyndns.org> <7vfxvs75kp.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 13:29:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQidn-0001qc-K9
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 13:29:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756994AbYBQM2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 07:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757812AbYBQM2Y
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 07:28:24 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4146 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757702AbYBQM2T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 07:28:19 -0500
Received: (qmail 23660 invoked by uid 111); 17 Feb 2008 12:28:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 17 Feb 2008 07:28:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Feb 2008 07:28:15 -0500
Content-Disposition: inline
In-Reply-To: <7vfxvs75kp.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74122>

On Sat, Feb 16, 2008 at 05:08:22PM -0800, Junio C Hamano wrote:

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

Overall I think this is a sensible idea. For (3), it probably makes
sense to limit the output in some cases. If I checkout a topic branch
that I haven't looked at in a few days or even weeks, I am going to get
spammed with hundreds of commits.

Most of the time what I really want to know is "I am not up to date and
should merge or rebase." Automatically showing _which_ commits diverge
is a convenience that makes sense if there are a handful of them. For
larger cases, the user can easily run "git log upstream...branch".

Of course this is speculation and gut feeling; I'll try running with
this for a few weeks and see if my opinion changes.

-Peff


> 
> We could enhance this with an option that tells the command to
> check if there is no local change, and automatically fast
> forward when you are truly behind.  But I ripped out that change
> because I was unsure what the right way should be to allow users
> to control it (issues include that checkout should not become
> automatically interactive).
> 
> This is hot off the press and I know it tends to be a bit too
> loud.  It is based on Daniel's "git checkout in C" with Dscho's
> lock_file fix.
> 
> ---
> 
>  builtin-checkout.c |  136 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 136 insertions(+), 0 deletions(-)
> 
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
> +	const char *name;
> +	if (prefixcmp(var, "branch."))
> +		return 0; /* not ours */
> +	name = var + strlen("branch.");
> +	if (strncmp(name, branch_name, branch_name_len) ||
> +	    name[branch_name_len] != '.')
> +		return 0; /* not ours either */
> +	if (!strcmp(name + branch_name_len, ".remote")) {
> +		/*
> +		 * Yeah, I know Christian's clean-up should
> +		 * be used here, but the topic is based on an
> +		 * older fork point.
> +		 */
> +		if (!value)
> +			return error("'%s' not string", var);
> +		found_remote = xstrdup(value);
> +		return 0;
> +	}
> +	if (!strcmp(name + branch_name_len, ".merge")) {
> +		if (!value)
> +			return error("'%s' not string", var);
> +		found_merge = xstrdup(value);
> +		return 0;
> +	}
> +	return 0; /* not ours */
> +}
> +
> +static int find_build_base(const char *ours, char **base)
> +{
> +	struct remote *remote;
> +	struct refspec spec;
> +
> +	*base = NULL;
> +
> +	branch_name = ours + strlen("refs/heads/");
> +	branch_name_len = strlen(branch_name);
> +	found_remote = NULL;
> +	found_merge = NULL;
> +	git_config(read_branch_config);
> +
> +	if (!found_remote || !found_merge) {
> +	cleanup:
> +		free(found_remote);
> +		free(found_merge);
> +		return 0;
> +	}
> +
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
> +	}
> +}
> +
> +
>  static void update_refs_for_switch(struct checkout_opts *opts,
>  				   struct branch_info *old,
>  				   struct branch_info *new)
> @@ -332,6 +466,8 @@ static void update_refs_for_switch(struct checkout_opts *opts,
>  	}
>  	remove_branch_state();
>  	strbuf_release(&msg);
> +	if (new->path)
> +		adjust_to_tracking(new, opts);
>  }
>  
>  static int switch_branches(struct checkout_opts *opts,
