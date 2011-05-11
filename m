From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/8] revert: Introduce a struct to parse command-line
 options into
Date: Wed, 11 May 2011 06:24:38 -0500
Message-ID: <20110511112438.GD2676@elie>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
 <1305100822-20470-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 11 18:38:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKCQl-0006gd-Ti
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 18:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182Ab1EKQic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 12:38:32 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47779 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954Ab1EKQhW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 12:37:22 -0400
Received: by iwn34 with SMTP id 34so659439iwn.19
        for <git@vger.kernel.org>; Wed, 11 May 2011 09:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=i2jEcYcTJ5KOZDGEzo7Ti5oJz7QdAjK2b7uX83+6lsk=;
        b=suWRTb0mQ1UZ8aIx9eJdMsp6Ulmb1zVE982m2HzB+1fP5KInx/NahWGI02B5oVzs/J
         9Rnw+0HI+sa8Vp/HVzduCsJxj1xfNBQz75IDNvGEL08GPCvIL84h3fXURgNCdnzv8mCG
         88M33LcHHfjR67k0xIc4eF807NHHgKZRDzros=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ixZ1PsB0jxtAhf22+/80jmTqpmAHaguYdqQmmFfeq/tLqbQo6H6f3uHCS39tPmgMxB
         WKfJwxtpfWaytt/huty8d5720obSHFi8F7jme1V42ZyyDX2T+RbcFxyO3NHS4UccHafG
         zAxlElaLZcGiqTDoWz2u4yap4MhHuVW9FyRo4=
Received: by 10.42.171.197 with SMTP id k5mr790629icz.320.1305113083292;
        Wed, 11 May 2011 04:24:43 -0700 (PDT)
Received: from elie (adsl-69-209-56-134.dsl.chcgil.sbcglobal.net [69.209.56.134])
        by mx.google.com with ESMTPS id y10sm20164iba.29.2011.05.11.04.24.40
        (version=SSLv3 cipher=OTHER);
        Wed, 11 May 2011 04:24:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1305100822-20470-4-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173411>

Ramkumar Ramachandra wrote:

>  I get the following warning from GCC: warning: useless storage class
>  specifier in empty declaration (at the line where I've declared the
>  replay_opts struct).  What is the correct way to fix this?

Remove the useless storage class specifier ("static"). :)

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -35,29 +35,42 @@ static const char * const cherry_pick_usage[] = {
[...]
> +static struct replay_opts {
> +	enum { REVERT, CHERRY_PICK } action;
> +
> +	/* Boolean options */
> +	int edit;
> +	int no_replay;

replay but no replay?

I think originally git-revert.sh had a "replay" variable meaning "This
is not a revert (which undoes a commit) but a cherry-pick (which
re-does it)."  Later the purpose changed to "We are not cherry-picking
and referring to the original with cherry-pick -x but replaying a
commit and treating it as new".

Now with struct replay_opts you are proposing to make the term mean
"we are using git revert machinery, or in other words replaying the
change an old commit made (forwards or backwards)", which makes sense.
In this case there should probably be a patch right before which
renames no_replay to i_really_want_to_expose_my_private_commit_object_name
(um, I mean to record_origin or something similar).

> +	int no_commit;
> +	int signoff;
> +	int allow_ff;
> +	int allow_rerere_auto;
> +
> +	int mainline;
> +	int commit_argc;
> +	const char **commit_argv;
> +
> +	/* Merge strategy */
> +	const char *strategy;
> +	const char **xopts;
> +	size_t xopts_nr, xopts_alloc;
> +};
[...]
>  
> -static const char * const *revert_or_cherry_pick_usage(void)
> +static const char *const *revert_or_cherry_pick_usage(struct replay_opts *opts)

Line is getting long.  Whitespace change snuck in?

I suppose if I ran the world the argument would be of type "enum
replay_action", so it would be used as

	usage(revert_or_cherry_pick_usage(o->action));

> +/* For option_parse_x */
> +static const char **xopts;
> +static size_t xopts_nr, xopts_alloc;
> +

Hm.  In C89, struct initializers are not allowed to include addresses
that are not known until run-time, and we used to follow that and now
violate it all over the place.  I'm not sure if it's worth it or not.
(I'm tempted to say, let it deteriorate further and people with the
ability to test on such platforms can fix it, but commits like
v1.7.2-rc0~32^2~18, Rewrite dynamic structure initializations to
runtime assignment, 2010-05-14, suggest that some people have cared in
the recent future.)

So.

If you want to use parse_options and support such compilers, it is
indeed simplest to use static variables.  You can give them scope
local to a particular function to at least avoid namespace polution.

To avoid such static variables at the expense of support for old
compilers, one can pass a pointer to a struct to option_parse_x
instead of the dummy &xopts.  Within option_parse_x, what you pass
will be accessible as opt->value.  It's all explained in
Documentation/technical/api-parse-options.txt, or one can grep around
for OPT_CALLBACK for examples.  A simple variant on this will work
with the old compilers, too.

[...]
>  static int option_parse_x(const struct option *opt,
> -			  const char *arg, int unset)
> +			const char *arg, int unset)

Whitespace change snuck in.

[...]
> @@ -67,19 +80,18 @@ static int option_parse_x(const struct option *opt,
>  	return 0;
>  }
>  
> -static void parse_args(int argc, const char **argv)
> +static void parse_args(int argc, const char **argv, struct replay_opts *opts)
>  {
> -	const char * const * usage_str = revert_or_cherry_pick_usage();
> +	const char *const *usage_str = revert_or_cherry_pick_usage(opts);
>  	int noop;
>  	struct option options[] = {
> -		OPT_BOOLEAN('n', "no-commit", &no_commit, "don't automatically commit"),
> +		OPT_BOOLEAN('n', "no-commit", &(opts->no_commit), "don't automatically commit"),

The parentheses are not needed (and not idiomatic fwiw).  The line is
getting long so I'd suggest splitting it, though that's more a matter
of taste.

> @@ -87,23 +99,29 @@ static void parse_args(int argc, const char **argv)
[...]
> -	if (commit_argc < 2)
> +
> +	/* Fill in the opts struct from values set by option_parse_x */
> +	opts->xopts = xopts;
> +	opts->xopts_nr = xopts_nr;
> +	opts->xopts_alloc = xopts_alloc;

Yep, something like this is needed (for all the options) if we want to
follow C89's option-struct-initialization rules.

>  static int do_recursive_merge(struct commit *base, struct commit *next,
> -			      const char *base_label, const char *next_label,
> -			      unsigned char *head, struct strbuf *msgbuf)
> +			const char *base_label, const char *next_label,
> +			unsigned char *head, struct strbuf *msgbuf,
> +			struct replay_opts *opts)

I'm not going to point out whitespace changes that snuck in any more.

I think I prefer the options struct to go in front (as in the
merge-recursive and diff APIs), but this is only a matter of taste.

> @@ -311,15 +329,15 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from)
>  }
>  
>  {
>  	struct merge_options o;
>  	struct tree *result, *next_tree, *base_tree, *head_tree;
>  	int clean, index_fd;
>  	const char **xopt;
>  	static struct lock_file index_lock;
> -	const char *me = (action == REVERT ? "revert" : "cherry-pick");

I think this belongs in a different patch (and likewise for its
counterpart below).

> The current code uses a set of file-scope static variables to tell the
> cherry-pick/ revert machinery how to replay the changes, and
> initializes them by parsing the command-line arguments.  In later
> steps in this series, we would like to introduce an API function that
> calls into this machinery directly and have a way to tell it what to
> do.  Hence, introduce a structure to group these variables, so that
> the API can take them as a single "replay_options" parameter.

Stepping back, I think this is a good idea, to make the state being
passed around a little clearer and to make it easier for callers to
specify what they want to happen without making up fictitious argc and
argv.  Most of what remains for this to be cooked are minor things
(the biggest part is getting it to build with -std=c89 -pedantic if
wanted and teaching option_parse_x to use a callback parameter).

Thanks.
