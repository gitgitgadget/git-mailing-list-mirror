From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH v4 2/4] git-cherry-pick: Add keep-redundant-commits option
Date: Wed, 11 Apr 2012 19:55:09 -0400
Message-ID: <20120411235509.GB16937@hmsreliant.think-freely.org>
References: <1334175716-11391-1-git-send-email-nhorman@tuxdriver.com>
 <1334175716-11391-3-git-send-email-nhorman@tuxdriver.com>
 <7v1unuj8az.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 01:55:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI7O0-00011e-Us
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 01:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912Ab2DKXzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 19:55:19 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:41017 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964887Ab2DKXzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 19:55:16 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SI7NW-0005ui-Ig; Wed, 11 Apr 2012 19:55:13 -0400
Content-Disposition: inline
In-Reply-To: <7v1unuj8az.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195286>

On Wed, Apr 11, 2012 at 01:57:24PM -0700, Junio C Hamano wrote:
> Neil Horman <nhorman@tuxdriver.com> writes:
> 
> > The git-cherry-pick --allow-empty command by default only preserves empty
> > commits that were originally empty, i.e only those commits for which
> > <commit>^{tree} and <commit>^^{tree} are equal.  By default commits which are
> > non-empty, but were made empty by the inclusion of a prior commit on the current
> > history are filtered out.  This option allows us to override that behavior and
> > include redundant commits as empty commits in the change history.
> >
> > Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> > ---
> >  Documentation/git-cherry-pick.txt |   12 +++++-
> >  builtin/revert.c                  |    8 +++-
> >  sequencer.c                       |   91 +++++++++++++++++++++++++++++++-----
> >  sequencer.h                       |    1 +
> >  4 files changed, 97 insertions(+), 15 deletions(-)
> >
> > diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
> > index 730237a..f96b8c5 100644
> > --- a/Documentation/git-cherry-pick.txt
> > +++ b/Documentation/git-cherry-pick.txt
> > @@ -110,7 +110,17 @@ effect to your index in a row.
> >  	behavior, allowing empty commits to be preserved automatically
> >  	in a cherry-pick. Note that when "--ff" is in effect, empty
> >  	commits that meet the "fast-forward" requirement will be kept
> > -	even without this option.
> > +	even without this option.  Note also, that use of this option only
> > +	keeps commits that were initially empty (i.e. where for commit C
> > +	C^{tree} and C^^{tree} are equal).  Commits which are made empty due to
> 
> It is OK to be technical in the log message, but I think
> 
> 	commits that were initially empty (i.e. the commit recorded the
> 	same tree as its parent)
> 
> would be far easier to read in the documentation meant for the end users.
> 
> > +	a previous commit are ignored.  To force the inclusion of those commits
> > +	use `--keep-redundant-commits`
> 
> And end the sentence with a full-stop.
> 
Copy that.

> > +--keep-redundant-commits::
> > +	If a commit being cherry picked duplicates a commit already in the
> > +	current history, it will result in an empty changeset.  By default these
> > +	redundant commits are ignored.  This option overrides that behavior and
> > +	creates an empty commit object.  Implies `--allow-empty`
> 
> Likewise.
> 
ACK

> > diff --git a/builtin/revert.c b/builtin/revert.c
> > index 06b00e6..4f0d979 100644
> > --- a/builtin/revert.c
> > +++ b/builtin/revert.c
> > @@ -115,13 +115,15 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
> >  		OPT_END(),
> >  		OPT_END(),
> >  		OPT_END(),
> > +		OPT_END(),
> >  	};
> >  
> >  	if (opts->action == REPLAY_PICK) {
> >  		struct option cp_extra[] = {
> >  			OPT_BOOLEAN('x', NULL, &opts->record_origin, "append commit name"),
> >  			OPT_BOOLEAN(0, "ff", &opts->allow_ff, "allow fast-forward"),
> > -			OPT_BOOLEAN(0, "allow-empty", &opts->allow_empty, "preserve empty commits"),
> > +			OPT_BOOLEAN(0, "allow-empty", &opts->allow_empty, "preserve initially empty commits"),
> > +			OPT_BOOLEAN(0, "keep-redundant-commits", &opts->keep_if_made_empty, "keep redundant, empty commits"),
> >  			OPT_END(),
> >  		};
> >  		if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
> > @@ -139,6 +141,10 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
> >  				"--abort", rollback,
> >  				NULL);
> >  
> > +	/* keep_if_made_empty implies allow_empty */
> > +	if (opts->keep_if_made_empty)
> > +		opts->allow_empty = 1;
> > +
> >  	/* Set the subcommand */
> >  	if (remove_state)
> >  		opts->subcommand = REPLAY_REMOVE_STATE;
> > diff --git a/sequencer.c b/sequencer.c
> > index 71929ba..442f364 100644
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
> > @@ -258,26 +259,85 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
> >   * If we are revert, or if our cherry-pick results in a hand merge,
> >   * we had better say that the current user is responsible for that.
> >   */
> > -static int run_git_commit(const char *defmsg, struct replay_opts *opts)
> > +int run_git_commit(const char *defmsg, struct replay_opts *opts, int empty)
> >  {
> > -	/* 7 is max possible length of our args array including NULL */
> > -	const char *args[7];
> > -	int i = 0;
> > +	struct argv_array array;
> > +	int rc;
> > +
> > +	if (!empty && !opts->keep_if_made_empty) {
> > +		unsigned char head_sha1[20];
> > +		struct commit *head_commit;
> > +		int need_free = 0;
> > +
> > +		resolve_ref_unsafe("HEAD", head_sha1, 1, NULL);
> > +		head_commit = lookup_commit(head_sha1);
> 
> No error checking whatsoever?  HEAD might be pointing at a branch that
> hasn't been born, for example.
> 
Sorry, I had presumed that HEAD could be guaranteed to be good here, given that
we validate it in rollback_single_pick via read_ref_full.  But I can add
additional checking here.

> > +		if (parse_commit(head_commit) < 0)
> > +			return error(_("could not parse commit %s\n"),
> > +				     sha1_to_hex(head_commit->object.sha1));
> > +
> > +		if (!active_cache_tree) {
> > +			active_cache_tree = cache_tree();
> > +			need_free = 1;
> > +		}
> 
> I think this is wrong.  If for whatever reason the process does not have
> the index it is about to tell "git commit" to use to make a commit in-core,
> it should first be doing read_cache().
I would have thought so too, and perhaps it should, but it doesn't seem to be
the case.  Initially I hadn't added this code, but during testing I received a
segfault indicating that the_index.cache_tree was NULL.  I thought it should
have been filled in via the calls to read_cache in do_recursive_merge or
fast_forward_to, but it didn't seem to be the case.  I added a read_cache call
right before my call to cache_tree_update, but still the_index.cache_tree
remained NULL.  Looking at the read_cache code, it appears that cache_tree is
only allocated if a CACHE_EXT_TREE is found when parsing the index.  Not sure
why I wouldn't have one, but certainly it didn't seem I did.  The above code
fixed it, which I lifted directly from write_tree_from_memory()


> > +
> > +		if (!cache_tree_fully_valid(active_cache_tree))
> > +			cache_tree_update(active_cache_tree, active_cache,
> > +					  active_nr, 0);
> 
> I do not recall offhand if cache_tree_update() can give you an error, but
> if it does, it should be checked here.
> 
It can, and I'll add checking there, but I hit the segfault above prior to
getting any error checknig done.

> > +		rc = !hashcmp(active_cache_tree->sha1, head_commit->tree->object.sha1);
> > +
> > +		if (need_free)
> > +			cache_tree_free(&active_cache_tree);
> 
> and I don't see a need for nuking the cache tree here, unless you are
> discarding the_index as well.
> 
Just balancing the allocation above with a free.  I didn't see a need for it
any longer, given that we were shortly going to call git commit and then exit
this process.  Is it safe to leave hanging around?

> > +		if (rc)
> > +			/*
> > + 			 * The head tree and the parent tree match
> > + 			 * meaning the commit is empty.  Since it wasn't created
> > + 			 * empty (based on the previous test), we can conclude
> > + 			 * the commit has been made redundant.  Since we don't
> > + 			 * want to keep redundant commits, just skip this one
> > + 			 */
> > +			return 0;
> > +	}
> > +
> > +	argv_array_init(&array);
> > +	argv_array_push(&array, "commit");
> > +	argv_array_push(&array, "-n");
> >  
> > -	args[i++] = "commit";
> > -	args[i++] = "-n";
> >  	if (opts->signoff)
> > -		args[i++] = "-s";
> > +		argv_array_push(&array, "-s");
> >  	if (!opts->edit) {
> > -		args[i++] = "-F";
> > -		args[i++] = defmsg;
> > +		argv_array_push(&array, "-F");
> > +		argv_array_push(&array, defmsg);
> >  	}
> > +	
> >  	if (opts->allow_empty)
> > -		args[i++] = "--allow-empty";
> > +		argv_array_push(&array, "--allow-empty");
> 
> If --keep-if-made-empty is not given but --allow-empty was, it is fine to
> give --allow-empty here, but otherwise, it logically is iffy and is likely
> to become a cause of future bugs to pass --allow-empty to "git commit",
> even though the earlier check _ought_ to catch problematic cases, no?
> 
Not sure I follow your reasoning here.  We need to pass allow-empty to git
commit here if git cherry-pick set either allow-empty or keep-redundant-commits
(the latter setting opts->empty), Can you give an example of what might be
problematic in the future?

Neil
