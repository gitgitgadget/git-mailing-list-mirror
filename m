From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/8] revert: Introduce a struct to parse command-line options into
Date: Fri, 13 May 2011 15:02:56 +0530
Message-ID: <20110513093253.GD14272@ramkum.desktop.amazon.com>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com> <1305100822-20470-4-git-send-email-artagnon@gmail.com> <20110511112438.GD2676@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 11:33:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKokJ-0008SI-70
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 11:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758667Ab1EMJdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 05:33:08 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:50447 "EHLO
	smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757903Ab1EMJdF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 05:33:05 -0400
X-IronPort-AV: E=Sophos;i="4.64,363,1301875200"; 
   d="scan'208";a="699810938"
Received: from smtp-in-1104.vdc.amazon.com ([10.140.10.25])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 May 2011 09:33:04 +0000
Received: from ramkum.desktop.amazon.com (ramkum.desktop.amazon.com [172.25.205.64])
	by smtp-in-1104.vdc.amazon.com (8.13.8/8.13.8) with ESMTP id p4D9X2SE024923;
	Fri, 13 May 2011 09:33:02 GMT
Received: by ramkum.desktop.amazon.com (Postfix, from userid 272482)
	id 7C54175483F; Fri, 13 May 2011 15:02:56 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <20110511112438.GD2676@elie>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173515>

Hi again,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
> 
> >  I get the following warning from GCC: warning: useless storage class
> >  specifier in empty declaration (at the line where I've declared the
> >  replay_opts struct).  What is the correct way to fix this?
> 
> Remove the useless storage class specifier ("static"). :)

Ah, thanks :)

> > --- a/builtin/revert.c
> > +++ b/builtin/revert.c
> > @@ -35,29 +35,42 @@ static const char * const cherry_pick_usage[] = {
> [...]
> > +static struct replay_opts {
> > +	enum { REVERT, CHERRY_PICK } action;
> > +
> > +	/* Boolean options */
> > +	int edit;
> > +	int no_replay;
> 
> replay but no replay?
> 
> I think originally git-revert.sh had a "replay" variable meaning "This
> is not a revert (which undoes a commit) but a cherry-pick (which
> re-does it)."  Later the purpose changed to "We are not cherry-picking
> and referring to the original with cherry-pick -x but replaying a
> commit and treating it as new".
> 
> Now with struct replay_opts you are proposing to make the term mean
> "we are using git revert machinery, or in other words replaying the
> change an old commit made (forwards or backwards)", which makes sense.
> In this case there should probably be a patch right before which
> renames no_replay to i_really_want_to_expose_my_private_commit_object_name
> (um, I mean to record_origin or something similar).

Great suggestion: one more patch changing "no_replay" to
"record_origin" it is.

> > +	int no_commit;
> > +	int signoff;
> > +	int allow_ff;
> > +	int allow_rerere_auto;
> > +
> > +	int mainline;
> > +	int commit_argc;
> > +	const char **commit_argv;
> > +
> > +	/* Merge strategy */
> > +	const char *strategy;
> > +	const char **xopts;
> > +	size_t xopts_nr, xopts_alloc;
> > +};
> [...]
> >  
> > -static const char * const *revert_or_cherry_pick_usage(void)
> > +static const char *const *revert_or_cherry_pick_usage(struct replay_opts *opts)
> 
> Line is getting long.  Whitespace change snuck in?

In my defense, I thought whitespace (indentation, style) changes were
permitted as long as I'm making a functional change.  If this isn't
the case, when can I correct the style/ indentation?

> I suppose if I ran the world the argument would be of type "enum
> replay_action", so it would be used as
> 
> 	usage(revert_or_cherry_pick_usage(o->action));
> 
> > +/* For option_parse_x */
> > +static const char **xopts;
> > +static size_t xopts_nr, xopts_alloc;
> > +
> 
> Hm.  In C89, struct initializers are not allowed to include addresses
> that are not known until run-time, and we used to follow that and now
> violate it all over the place.  I'm not sure if it's worth it or not.
> (I'm tempted to say, let it deteriorate further and people with the
> ability to test on such platforms can fix it, but commits like
> v1.7.2-rc0~32^2~18, Rewrite dynamic structure initializations to
> runtime assignment, 2010-05-14, suggest that some people have cared in
> the recent future.)
> 
> So.
> 
> If you want to use parse_options and support such compilers, it is
> indeed simplest to use static variables.  You can give them scope
> local to a particular function to at least avoid namespace polution.
> 
> To avoid such static variables at the expense of support for old
> compilers, one can pass a pointer to a struct to option_parse_x
> instead of the dummy &xopts.  Within option_parse_x, what you pass
> will be accessible as opt->value.  It's all explained in
> Documentation/technical/api-parse-options.txt, or one can grep around
> for OPT_CALLBACK for examples.  A simple variant on this will work
> with the old compilers, too.

Got it.

> [...]
> >  static int option_parse_x(const struct option *opt,
> > -			  const char *arg, int unset)
> > +			const char *arg, int unset)
> 
> Whitespace change snuck in.

Intended.  It changes indentation style to linux-tabs-only, which is
the style my editor currently works with.

> [...]
> > @@ -67,19 +80,18 @@ static int option_parse_x(const struct option *opt,
> >  	return 0;
> >  }
> >  
> > -static void parse_args(int argc, const char **argv)
> > +static void parse_args(int argc, const char **argv, struct replay_opts *opts)
> >  {
> > -	const char * const * usage_str = revert_or_cherry_pick_usage();
> > +	const char *const *usage_str = revert_or_cherry_pick_usage(opts);
> >  	int noop;
> >  	struct option options[] = {
> > -		OPT_BOOLEAN('n', "no-commit", &no_commit, "don't automatically commit"),
> > +		OPT_BOOLEAN('n', "no-commit", &(opts->no_commit), "don't automatically commit"),
> 
> The parentheses are not needed (and not idiomatic fwiw).  The line is
> getting long so I'd suggest splitting it, though that's more a matter
> of taste.

Ok, I'll lose the paranthesis.

> > @@ -87,23 +99,29 @@ static void parse_args(int argc, const char **argv)
> [...]
> > -	if (commit_argc < 2)
> > +
> > +	/* Fill in the opts struct from values set by option_parse_x */
> > +	opts->xopts = xopts;
> > +	opts->xopts_nr = xopts_nr;
> > +	opts->xopts_alloc = xopts_alloc;
> 
> Yep, something like this is needed (for all the options) if we want to
> follow C89's option-struct-initialization rules.

Ouch! That's much too painful :|
I think I'll break the rule for the moment.

> >  static int do_recursive_merge(struct commit *base, struct commit *next,
> > -			      const char *base_label, const char *next_label,
> > -			      unsigned char *head, struct strbuf *msgbuf)
> > +			const char *base_label, const char *next_label,
> > +			unsigned char *head, struct strbuf *msgbuf,
> > +			struct replay_opts *opts)
> 
> I'm not going to point out whitespace changes that snuck in any more.
> 
> I think I prefer the options struct to go in front (as in the
> merge-recursive and diff APIs), but this is only a matter of taste.

Intended again, since I'm adding an argument to the list.

> > @@ -311,15 +329,15 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from)
> >  }
> >  
> >  {
> >  	struct merge_options o;
> >  	struct tree *result, *next_tree, *base_tree, *head_tree;
> >  	int clean, index_fd;
> >  	const char **xopt;
> >  	static struct lock_file index_lock;
> > -	const char *me = (action == REVERT ? "revert" : "cherry-pick");
> 
> I think this belongs in a different patch (and likewise for its
> counterpart below).
> 
> > The current code uses a set of file-scope static variables to tell the
> > cherry-pick/ revert machinery how to replay the changes, and
> > initializes them by parsing the command-line arguments.  In later
> > steps in this series, we would like to introduce an API function that
> > calls into this machinery directly and have a way to tell it what to
> > do.  Hence, introduce a structure to group these variables, so that
> > the API can take them as a single "replay_options" parameter.
> 
> Stepping back, I think this is a good idea, to make the state being
> passed around a little clearer and to make it easier for callers to
> specify what they want to happen without making up fictitious argc and
> argv.  Most of what remains for this to be cooked are minor things
> (the biggest part is getting it to build with -std=c89 -pedantic if
> wanted and teaching option_parse_x to use a callback parameter).

Right, thanks.

-- Ram
