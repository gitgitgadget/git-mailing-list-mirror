From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH v3 2/4] git-cherry-pick: Add keep-redundant-commits option
Date: Tue, 10 Apr 2012 14:25:24 -0400
Message-ID: <20120410182523.GB17776@hmsreliant.think-freely.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334072868-9435-1-git-send-email-nhorman@tuxdriver.com>
 <1334072868-9435-3-git-send-email-nhorman@tuxdriver.com>
 <7vy5q3pl9i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 20:25:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHfl0-0000Ls-Mr
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 20:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567Ab2DJSZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 14:25:30 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:51389 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146Ab2DJSZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 14:25:29 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SHfkr-0006Og-09; Tue, 10 Apr 2012 14:25:27 -0400
Content-Disposition: inline
In-Reply-To: <7vy5q3pl9i.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195117>

On Tue, Apr 10, 2012 at 10:04:32AM -0700, Junio C Hamano wrote:
> Neil Horman <nhorman@tuxdriver.com> writes:
> 
> > +	/* keep_if_made_empty implies allow_empty */
> > +	if (opts->keep_if_made_empty)
> > +		opts->allow_empty = 1;
> > +
>  
> OK.
> 
> > diff --git a/sequencer.c b/sequencer.c
> > index 71929ba..5d033db 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -13,6 +13,7 @@
> >  #include "rerere.h"
> >  #include "merge-recursive.h"
> >  #include "refs.h"
> > +#include "argv-array.h"
> >  
> >  #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
> >  
> > @@ -258,26 +259,102 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
> >   * If we are revert, or if our cherry-pick results in a hand merge,
> >   * we had better say that the current user is responsible for that.
> >   */
> > -static int run_git_commit(const char *defmsg, struct replay_opts *opts)
> > +static int run_git_commit(const char *defmsg, struct replay_opts *opts, int empty)
> >  {
> > -	/* 7 is max possible length of our args array including NULL */
> > -	const char *args[7];
> > -	int i = 0;
> > +	struct argv_array array;
> > +	int rc;
> > +
> > +	if (!empty && !opts->keep_if_made_empty) {
> > +		const char *argv[] = { "diff-index", "--quiet", "--exit-code",
> > +					"--cached", "HEAD", NULL };
> > +
> > +		/*
> > + 		 * If we run git diff-index with the above option and it returns
> > + 		 * zero, then there have been no changes made to the index by
> > + 		 * this patch, i.e. its empty.  Since our previous empty test
> > + 		 * indicated that this patch was not created empty, its been made
> > + 		 * redundant.  Since keep_if_made_empty is not set, we just skip
> > + 		 * it
> > + 		 */
> > +		if (run_command_v_opt(argv, RUN_GIT_CMD) == 0)
> > +			return 0;
> 
> Wouldn't it be far simpler to do this without forking diff-index?  I
> haven't followed the codepath leading to this, but it should be very easy
> to find a commit object that corresponds to the current HEAD and peek the
> tree object in it to find out the current tree, and because the original
> function is going to run an as-is "git commit", the tree you are going to
> commit should be available by calling cache_tree_update() like write-tree
> does.  If they match, you are trying to create an empty commit.  E.g. (error
> checking elided):
> 
> 	unsigned char head_sha1[20];
> 	struct commit *head_commit;
> 
> 	resolve_ref_unsafe("HEAD", head_sha1, 1, NULL);
>         head_commit = lookup_commit(head_sha1);
>         parse_commit(head_commit);
> 
>         if (!cache_tree_fully_valid(active_cache_tree))
> 		cache_tree_update(active_cache_tree, active_cache,
> 				active_nr, 0);
> 	return hashcmp(active_cache_tree->sha1, head_commit->tree->object.sha1);
> 
> > +static int is_original_commit_empty(struct commit *commit)
> > +{
> > +	struct argv_array argv_array;
> > +	struct child_process cp;
> > +	char ptree[40], pptree[40];
> > +	int ret = 0;
> > +
> > +	argv_array_init(&argv_array);
> > +	memset(&cp, 0, sizeof(struct child_process));
> > +
> > +	argv_array_push(&argv_array, "rev-parse");
> > +	argv_array_pushf(&argv_array, "%s^{tree}", sha1_to_hex(commit->object.sha1));
> 
> Likewise.  You have the commit object, so just make sure it was parsed,
> and peek its tree object.  Also do the same for its parent commit.  Now
> you have two trees, so you can compare their object names.  E.g. (error
> checking elided):
> 
Honestly, I wasn't aware there was a faster way.  In my last version you
suggested using git diff-index and git rev-parse (allbeit the latter was for use
in the git-rebase script, and I just reused it).  Regardless, I was going with
your previous suggestions.  I can re-do these to use these new suggestions.

Neil
