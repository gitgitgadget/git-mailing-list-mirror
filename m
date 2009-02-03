From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] Introduce config variable "diff.primer"
Date: Tue, 3 Feb 2009 02:15:16 -0500
Message-ID: <20090203071516.GC21367@sigill.intra.peff.net>
References: <1233598855-1088-1-git-send-email-keith@cs.ucla.edu> <1233598855-1088-2-git-send-email-keith@cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Keith Cascio <keith@cs.ucla.edu>
X-From: git-owner@vger.kernel.org Tue Feb 03 08:17:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUFWl-0003n1-4b
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 08:16:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbZBCHPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 02:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbZBCHPX
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 02:15:23 -0500
Received: from peff.net ([208.65.91.99]:35261 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750998AbZBCHPW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 02:15:22 -0500
Received: (qmail 17403 invoked by uid 107); 3 Feb 2009 07:15:32 -0000
Received: from c-75-75-4-229.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (75.75.4.229)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 03 Feb 2009 02:15:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Feb 2009 02:15:16 -0500
Content-Disposition: inline
In-Reply-To: <1233598855-1088-2-git-send-email-keith@cs.ucla.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108158>

On Mon, Feb 02, 2009 at 10:20:54AM -0800, Keith Cascio wrote:

> Introduce config variable "diff.primer".

You don't need to repeat the subject in the body.

> Improve porcelain diff's accommodation of user preference by allowing
> some settings to (a) persist over all invocations and (b) stay consistent
> over multiple tools (e.g. command-line and gui).  The approach taken here
> is good because it delivers the consistency a user expects without breaking
> any plumbing.  It works by allowing the user, via git-config, to specify
> arbitrary options to pass to porcelain diff on every invocation, including
> internal invocations from other programs, e.g. git-gui.  Introduce diff
> command-line options --primer and --no-primer.  Affect only porcelain diff:
> we suppress primer options for plumbing diff-{files,index,tree},
> format-patch, and all other commands unless explicitly requested using
> --primer (opt-in).  Teach gitk to use --primer, but protect it from
> inapplicable options like --color.

Paragraph breaks might have made this a bit easier to read.

> +diff.primer::
> +	Whitespace-separated list of options to pass to 'git-diff'
> +	on every invocation, including internal invocations from
> +	linkgit:git-gui[1] and linkgit:gitk[1],
> +	e.g. `"--patience --color --ignore-space-at-eol --exit-code"`.
> +	See linkgit:git-diff[1]. You can suppress these at run time with
> +	option `--no-primer`.  Supports a subset of
> +	'git-diff'\'s many options, at least:
> +	`-b --binary --color --color-words --cumulative --dirstat-by-file
> +--exit-code --ext-diff --find-copies-harder --follow --full-index
> +--ignore-all-space --ignore-space-at-eol --ignore-space-change
> +--ignore-submodules --no-color --no-ext-diff --no-textconv --patience -q
> +--quiet -R -r --relative -t --text --textconv -w`

Funny indentation?

This seems really clunky to list all of the options here. I thought the
point was to respect _all_ of them, but do it from porcelain so that it
is up to the user what they want to put in.

How was this list chosen?

> +--no-primer::
> +	Ignore default options specified in '.git/config', i.e.
> +	those that were set using a command like
> +	`git config diff.primer "--patience --color --ignore-space-at-eol --exit-code"`
> +
> +--primer::
> +	Opt-in for default options specified in '.git/config'.  This option is
> +	most often used with the three plumbing commands diff-{files,index,tree}.
> +	These commands normally suppress default options.
> +

Some of the manpages use a more terse form for negatable options, like:

  --[no-]primer::

which often helps focus the text a bit. Something like:

  --[no-]primer::
    Respect (or ignore) options specifed in the diff.primer
    configuration variable. By default, porcelain commands (such as `git
    diff` and `git log`) respect this variable, but plumbing commands
    (such as `git diff-{files,index,tree}`) do not.

Also, don't mention ".git/config" by name: configuration can come from
~/.gitconfig, a system-wide gitconfig, or .git/config.

> @@ -284,6 +284,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
> [...]
> +	DIFF_OPT_SET(&rev.diffopt, PRIMER);

Probably ALLOW_PRIMER is a more sensible name, to match ALLOW_EXTERNAL
and ALLOW_TEXTCONV.

> +static const char blank[] = " \t\r\n";
> +
> +void parse_diff_primer(struct diff_options *options)
> +{
> +	char *str1, *token, *saveptr;
> +	int len;
> +
> +	if ((! diff_primer) || ((len = (strlen(diff_primer)+1)) < 3))
> +		return;
> +
> +	token = str1 = strncpy((char*) malloc(len), diff_primer, len);
> +	if ((saveptr = strpbrk(token += strspn(token, blank), blank)))
> +		*(saveptr++) = '\0';
> +	while (token) {
> +		if (*token == '-')
> +			diff_opt_parse(options, (const char **) &token, -1);
> +		if ((token = saveptr))
> +			if ((saveptr = strpbrk(token += strspn(token, blank), blank)))
> +				*(saveptr++) = '\0';
> +	}
> +
> +	free( str1 );
> +}

This doesn't appear to have any quoting mechanism. Is it impossible to
have an option with spaces (e.g., --relative='foo bar')? I guess that is
probably uncommon, but I would expect normal shell quoting rules to
apply.

> +struct diff_options* flatten_diff_options(struct diff_options *master, struct diff_options *slave)
> +{
> +	unsigned x0 = master->flags, x1 = master->mask, x2 = slave->flags, x3 = slave->mask;
> +	long w = master->xdl_opts, x = master->xdl_mask, y = slave->xdl_opts, z = slave->xdl_mask;
> +

Style: long lines.

> +	//minimized by Quine-McCluskey

Style: no C99/C++ comments.

> +	master->flags = (~x1&x2&x3)|(x0&~x3)|(x0&x1);

Style: whitespace between operands and operators.

I have to admit that this particular line is pretty dense to read. You
have eliminated any meaning from the variable names (like the fact that
you have a master/slave pair of flag/mask pairs). Yes, you point to the
Quine-McCluskey algorithm in the comment above, but I think something
like this would be easier to see what is going on:

  /*
   * Our desired flags are:
   *
   *   1. Anything the master hasn't explicitly set, we can take from
   *      the slave.
   *   2. Anything the slave didn't explicitly, we can take whether or
   *      not the master set it explicitly.
   *   3. Anything the master explicitly set, we take.
   */
  master->flags =
     /* (1) */ (~master->flags & slave->flags & slave->mask) |
     /* (2) */ (master->flags & ~slave->mask) |
     /* (3) */ (master->flags & master->mask);

> @@ -2326,14 +2369,15 @@ void diff_setup(struct diff_options *options)
>  	options->break_opt = -1;
>  	options->rename_limit = -1;
>  	options->dirstat_percent = 3;
> -	DIFF_OPT_CLR(options, DIRSTAT_CUMULATIVE);
> +	if (DIFF_OPT_TST(options, DIRSTAT_CUMULATIVE))
> +		DIFF_OPT_CLR(options, DIRSTAT_CUMULATIVE);

Hmm. I haven't gotten to any changes to DIFF_OPT_{SET,CLR} yet. But it
is a little worrisome that this patch is so invasive as to require a
change like this. I wouldn't be surprised to find other spots outside of
diff.c where the options are munged by various programs. Did you audit
for all such spots?

> +	if (DIFF_OPT_TST(options, PRIMER)) {
> +		if (! primer) {
> +			diff_setup(primer = (struct diff_options *) malloc(sizeof(struct diff_options)));

First, don't use malloc. Use the xmalloc wrapper that will try to free
pack memory and/or die if it fails.

Secondly, don't cast the result of malloc. At best it is pointless and
verbose, and at worst it can hide errors caused by a missing function
declaration.

>  	/* xdiff options */
>  	else if (!strcmp(arg, "-w") || !strcmp(arg, "--ignore-all-space"))
> -		options->xdl_opts |= XDF_IGNORE_WHITESPACE;
> +		DIFF_XDL_SET(options, IGNORE_WHITESPACE);

It often makes the patch easier to review if you split changes like this
out into a separate patch. Then your series is

  1/2: use DIFF_XDL_SET instead of raw bit-masking

       This is a cleanup in preparation for option-setting doing
       something more complex than just setting a bit-mask. The code
       should behave exactly the same.

  2/2: primer patch

       ... DIFF_XDL_SET tracks not only the set options, but which ones
       were set explicitly via a mask ...

Then we can all see pretty easily that patch 1/2 doesn't change the
behavior, and each patch is a much smaller, succint chunk to review.

> -	else if (!strcmp(arg, "--color-words"))
> -		options->flags |= DIFF_OPT_COLOR_DIFF | DIFF_OPT_COLOR_DIFF_WORDS;
> +	else if (!strcmp(arg, "--color-words")) {
> +		DIFF_OPT_SET(options, COLOR_DIFF);
> +		DIFF_OPT_SET(options, COLOR_DIFF_WORDS);
> +	}

Ditto here with DIFF_OPT_SET.

> +#define DIFF_OPT_TST(opts, flag)    ((opts)->flags &   DIFF_OPT_##flag)
> +#define DIFF_OPT_SET(opts, flag)    ((opts)->flags |=  DIFF_OPT_##flag), ((opts)->mask |= DIFF_OPT_##flag)
> +#define DIFF_OPT_CLR(opts, flag)    ((opts)->flags &= ~DIFF_OPT_##flag), ((opts)->mask |= DIFF_OPT_##flag)
> +#define DIFF_OPT_DRT(opts, flag)    ((opts)->mask  &   DIFF_OPT_##flag)

OK, I see what it is supposed to do, but what does DRT stand for? Also,
what practical use does it have? I don't see anybody _calling_ it.

> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -4259,7 +4259,7 @@ proc do_file_hl {serial} {
>  	# must be "containing:", i.e. we're searching commit info
>  	return
>      }
> -    set cmd [concat | git diff-tree -r -s --stdin $gdtargs]
> +    set cmd [concat | git diff-tree --primer --no-color -r -s --stdin $gdtargs]

Does gitk really want to respect --primer? Might it not make more sense
for it, as a porcelain, to respect the diff.primer variable itself, and
prepend it to the list of diff args? Then it has the power to veto any
options which it doesn't handle.

Also, any gitk changes should almost certainly be split into a different
patch.



All in all, this was a lot more complicated than I was expecting. Why
isn't the behavior of "diff.primer" simply "pretend as if the options in
diff.primer were prepended to the command line"? That is easy to
explain, and easy to implement (the only trick is that you have to do an
extra pass to find --[no-]primer). Is there some drawback to such a
simple scheme that I am missing?

-Peff
