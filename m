Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2569D5C8FF
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 07:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9716 invoked by uid 109); 12 Jan 2024 07:24:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 12 Jan 2024 07:24:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15090 invoked by uid 111); 12 Jan 2024 07:24:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 12 Jan 2024 02:24:07 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 12 Jan 2024 02:24:04 -0500
From: Jeff King <peff@peff.net>
To: Michael Lohmann <mi.al.lohmann@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org, phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk, wanja.hentze@bevuta.com
Subject: Re: [PATCH v3] builtin/revert.c: refactor using an enum for
 cmd-action
Message-ID: <20240112072404.GF618729@coredump.intra.peff.net>
References: <xmqqsf33fy3t.fsf@gitster.g>
 <20240111200627.64199-1-mi.al.lohmann@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240111200627.64199-1-mi.al.lohmann@gmail.com>

On Thu, Jan 11, 2024 at 09:06:27PM +0100, Michael Lohmann wrote:

> > I agree with you why NONE is called as such.  If "revert" does not
> > take "--start" (I do not remember offhand), I would think it would
> > be better to follow suit.
> My point was that yes, it might be in sync with what the user passes in
> as arguments, but when I followed the code and saw lots of references to
> ACTION_NONE I was puzzled, since my intuition of that name was that
> _no action_ should be taken (which did not make sense to me).

Just my two cents as an observer who is very familiar with the idioms of
Git's codebase: it's common for us to use NONE here to mean "an action
has not been selected", which the code then translates to a default
action. So that's what I would have chosen.

But your way of seeing it also makes sense to me. I think I just find
the "START" name jarring because we do not use that word elsewhere to
describe the action. What if you called it ACTION_DEFAULT? Then it is
both the "default" value we give it, and also the default action (which
is not otherwise named in the code).


As far as the enum vs char thing, I do not have a strong opinion (though
I do tend to like enums myself). Here are a few minor style comments
(again that are idiomatic for our code base):

> +enum action {
> +	ACTION_START = 0,
> +	ACTION_CONTINUE,
> +	ACTION_SKIP,
> +	ACTION_ABORT,
> +	ACTION_QUIT,
> +};

Explicitly setting ACTION_START to 0 is good (even though it is not
strictly necessary) because it makes it clear that we expect to use its
truthiness later. But later...

> @@ -183,9 +189,7 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
>  				"--edit", opts->edit > 0,
>  				NULL);
>  
> -	if (cmd) {
> -		opts->revs = NULL;
> -	} else {
> +	if (cmd == ACTION_START) {
>  		struct setup_revision_opt s_r_opt;
>  		opts->revs = xmalloc(sizeof(*opts->revs));
>  		repo_init_revisions(the_repository, opts->revs, NULL);
> @@ -198,6 +202,8 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
>  		memset(&s_r_opt, 0, sizeof(s_r_opt));
>  		s_r_opt.assume_dashdash = 1;
>  		argc = setup_revisions(argc, argv, opts->revs, &s_r_opt);
> +	} else {
> +		opts->revs = NULL;

We do not take advantage of that. It is still OK to do "if (cmd)" with
the enum, and that's what I'd usually expect in our code base. There is
no need for this hunk at all (which also switches the order of the
conditional, which just seems like churn to me).

> @@ -33,6 +41,17 @@ static const char * const cherry_pick_usage[] = {
>  	NULL
>  };
>  
> +static char* get_cmd_optionname(enum action cmd)

From CodingGuidelines:

  When declaring pointers, the star sides with the variable name, i.e.
  "char *string", not "char* string" or "char * string".  This makes it
  easier to understand code like "char *string, c;".

(Yes, I know there are arguments for the other way, too; but consistency
is the most important thing, I think).

> +{
> +	switch (cmd) {
> +	case ACTION_CONTINUE: return "--continue";
> +	case ACTION_SKIP: return "--skip";
> +	case ACTION_ABORT: return "--abort";
> +	case ACTION_QUIT: return "--quit";
> +	case ACTION_START: BUG("no commandline flag for ACTION_START");
> +	}
> +}

I find this perfectly readable, and is likely the way I'd write it in a
personal project. But in this project I find we tend to stick to more
conventional formatting, like:

  switch (cmd) {
  case ACTION_CONTINUE:
	return "--continue";
  case ACTION_SKIP:
	return "--skip";
  ...and so on...

> @@ -144,20 +163,8 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
>  	}
>  
>  	/* Check for incompatible command line arguments */
> -	if (cmd) {
> -		char *this_operation;
> -		if (cmd == 'q')
> -			this_operation = "--quit";
> -		else if (cmd == 'c')
> -			this_operation = "--continue";
> -		else if (cmd == 's')
> -			this_operation = "--skip";
> -		else {
> -			assert(cmd == 'a');
> -			this_operation = "--abort";
> -		}
> -
> -		verify_opt_compatible(me, this_operation,
> +	if (cmd != ACTION_START)

Likewise here I'd probably leave this as "if (cmd)".

> [...]

Everything else looked pretty good to me.

-Peff
