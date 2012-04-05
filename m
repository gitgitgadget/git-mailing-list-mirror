From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH 3/5] git-cherry-pick: Add ignore-if-made-empty option [v2]
Date: Thu, 5 Apr 2012 19:45:27 -0400
Message-ID: <20120405234527.GB8654@hmsreliant.think-freely.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-4-git-send-email-nhorman@tuxdriver.com>
 <7vobr551vs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 01:45:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFwN8-0006LI-9Y
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 01:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428Ab2DEXpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 19:45:35 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:59678 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890Ab2DEXpe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 19:45:34 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SFwMq-0006cZ-Vd; Thu, 05 Apr 2012 19:45:32 -0400
Content-Disposition: inline
In-Reply-To: <7vobr551vs.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194822>

On Thu, Apr 05, 2012 at 02:01:43PM -0700, Junio C Hamano wrote:
> Neil Horman <nhorman@tuxdriver.com> writes:
> 
> > Subject: Re: [PATCH 3/5] git-cherry-pick: Add ignore-if-made-empty option [v2]
> 
> Please don't do this.  The tools do not strip the garbage at the end.
> 
> Instead, do it like either one of these:
> 
> 	Subject: [PATCH 3/5 (v2)] mumble mumble...
> 	Subject: [PATCH v2 3/5] mumble mumble...
> 
> The latter is more appropriate when resending everything, including the
> ones that did not change from the earlier round.
> 
Thats fine, I typically use tools that strip everything inside all braces, I'll
update this on my next re-roll.

> > Since we'll be using git-cherry-pick to enhance git-rebase's ability to preserve
> > empty commits, we open ourselves to the possibility of preserving commits that
> > are made empty by a previous merge as well, which is almost certainly not what
> > we want (most of the time).  To handle this, we can add the ignore-if-made-empty
> > option.  If enabled, it will look at cherry-picked commits, and if the origional
> > sha1 has the same tree as its parent, then the cherry-pick is comitted as an
> > empty commit, otherwise the commit is skipped (because it previously made
> > changes to the tree, but no longer does).
> >
> > Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> 
> > diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
> > index c283d8c..bb7eb4a 100644
> > --- a/Documentation/git-cherry-pick.txt
> > +++ b/Documentation/git-cherry-pick.txt
> > @@ -103,7 +103,7 @@ effect to your index in a row.
> >  	cherry-pick'ed commit, then a fast forward to this commit will
> >  	be performed.
> >  
> > ---allow-empty:
> > +--allow-empty:::
> 
> A single colon is already buggy, but three colons is equally bad.  Please
> fix that in the original point this bug was introduced.  I guess it was
> 2/5 of this series?
> 
Crap, thanks, I missed that.  I'll square that away


> > @@ -112,6 +112,14 @@ effect to your index in a row.
> >  	commits that meet the "fast-forward" requirement will be kept
> >  	even without this option.
> >  
> > +--ignore-if-made-empty::
> > +	If the --allow-empty option is used, all empty commits are kept,
> 
> Literal strings the user may type are typically set in tt font
> (i.e. `--allow-empty`).
> 
Ack, ok.

> > +	including those which were made empty due to a previous change.
> > +	While this may be desireable, likely it is not.
> 
> Mental note.  Up to this point, the reader is told that "--allow-empty"
> alone is likely to do a wrong thing.
> 
> > +	This option
> > +	restricts the scope of --allow-empty to only those commits which
> > +	were created as empty commits ...
> 
> And the user is asked to give "--ignore-if-made-empty" in addition to
> "--allow-empty" to get a saner and more likely to be useful behaviour.
> Isn't that backwards?  This "the other option is insane, and please make
> it saner" option needs a lot more typing than the more insane option.
> 
> I would expect that "--allow-empty" would by default filter ones that are
> originally non-empty but are made unnecessary (we are allowing empty
> commits in the original history to be cherry-picked, but the general
> principle that unnecessary commits must not be picked still is in effect).
> If you want to give a user the other more insane mode of operation, it is
> OK to let the user give a different option *instead* *of* the saner
> "--allow-empty".
> 
> Perhaps name that "--keep-unnecessary-commit" (it is no longer about
> allowing empty commits in the original history to be picked; it is about
> keeping unnecessary and irrelevant commits in the resulting history).
> 
> And error out if both options are given.
> 
Yeah, ok.  I wasn't really thinking about the direct use case, as I had expected
the typical use to be in the rebase scripts, where this is already wired up, but
I see your point.  I'll reverse the logic.

> > +static int run_git_commit(const char *defmsg, struct replay_opts *opts, int empty)
> > +{
> > +	struct argv_array array;
> > +	int rc;
> > +
> > +	argv_array_init(&array);
> > +	argv_array_push(&array, "commit");
> > +	argv_array_push(&array, "-n");
> > +
> > +	if ((!empty) && (opts->ignore_if_made_empty)) {
> 
> Style: lose the extra and unnecessary parentheses, especially when the
> expression inside them are so trivial, i.e.
> 
Ok

> 	if (!empty && opts->ignore_if_made_empty) {
> 
> although I suspect that redesign of the command line interface might make
> it a moot point to polish this part of the code without major rethinking.
> 
> > +		/* Note: This implies --dry-run */
> > +		argv_array_push(&array, "--porcelain");
> > +		if (run_command_v_opt(array.argv, RUN_GIT_CMD) == 1) {
> 
> The only thing you want to check at this point is if the contents of the
> index being committed is the same as the tree of HEAD.  Why do we even
> want to incur this much overhead?
> 
> Isn't running "diff-index --cached HEAD" sufficient?
Well, I was looking at the git commit code to see what exactly --dry-run did,
and I thought that it was roughly equivalent to diff-index.  But if its lower
overhead to do a diff-index instead, I'll happily change it.

> 
> > +			/* The dry run exit code of 1 tells us this is
> > + 			 * an empty commit, just skip it.
> > + 			 */
> 
> 	/*
>          * Our multi-line comments are
>          * formatted this way.
>          */
> 
Ok.

> > +			argv_array_clear(&array);
> > +			return 0;
> > +		}
> > +		argv_array_pop(&array, 1);
> > +	}
> > +
> >  
> >  	if (opts->signoff)
> > +		argv_array_push(&array, "-s");
> >  	if (!opts->edit) {
> > +		argv_array_push(&array, "-F");
> > +		argv_array_push(&array, defmsg);
> >  	}
> > +	
> >  	if (opts->allow_empty)
> > +		argv_array_push(&array, "--allow-empty");
> > +
> > +
> > +	rc = run_command_v_opt(array.argv, RUN_GIT_CMD);
> > +	argv_array_clear(&array);
> > +	return rc;
> > +}
> > +
> > +static int is_origional_commit_empty(struct commit *commit)
> 
> What is origional?
> 
A spelling error :).   Thanks.

> Is there a reason why this series is not marked as WIP or RFC?
> 
Because its not.  It works perfectly well, and its fairly close to done.  So far
your review has turned up one significant operational change, which is easily
re-worked and a few stylistic nits.  Thats how review works, I don't see whats
wrong with that. 

> I am starting to wonder if it is worth spending time on careful reviewing,
> or it would be sufficient to give a cursory review quickly to give you
> more time to polish your re-roll.
> 
I'm not sure what you think is so egregious about this changeset, but if
you have a specific problem, please let me know.  We all make errors, thats why
we review work like this.  All your comment above does is toss a purposeless
insult into the conversation. 
 
> > +{
> > +	struct argv_array argv_array;
> > +	struct child_process cp;
> > +	char ptree[41], pptree[41];
> > +	int pipefd[2];
> > +	FILE *output;
> > +	int ret = 0;
> > +
> > +	if (pipe2(pipefd, 0) < 0)
> > +		return 0;
> > +
> > +	output = xfdopen(pipefd[0], "r");
> > +
> > +	argv_array_init(&argv_array);
> > +	memset(&cp, 0, sizeof(struct child_process));
> >  
> > -	args[i] = NULL;
> > +	argv_array_push(&argv_array, "rev-parse");
> > +	argv_array_pushf(&argv_array, "%s^{tree}", sha1_to_hex(commit->object.sha1));
> >  
> > -	return run_command_v_opt(args, RUN_GIT_CMD);
> > +	cp.git_cmd = 1;
> > +	cp.no_stdin = 1;
> > +	cp.no_stderr = 1;
> > +	cp.out = pipefd[1];
> > +	cp.argv = argv_array.argv;
> > +
> > +	if (start_command(&cp) < 0)
> > +		goto out;
> > +
> > +	if (fscanf(output, "%s\n", ptree) < 1)
> > +		goto out;
> > +
> > +	finish_command(&cp);
> > +
> > +	fclose(output);
> > +	close(pipefd[0]);
> > +	argv_array_clear(&argv_array);
> > +
> > +	if (pipe2(pipefd, 0) < 0)
> 
> Huh?  "man pipe2" and see if it is portable.
> 
Crud, I completely forgot that pipe2 was _GNU_SOURCE only.  I'll rework that,
thanks.

Regards
Neil
